module gd.system.x11.display;
import gd.system.x11.device;
import gd.system.x11.window;
import gd.system.x11.exception;
import gd.system.window;
import gd.system.display;
import gd.system.application;
import gd.resource;
import gd.graphics;
import std.typecons;
import std.exception;

version (gd_X11Impl):

import gd.bindings.x11;
import gd.bindings.xi2;
import gd.bindings.xsync;
import gd.bindings.glx;
import gd.bindings.gl;

class X11Display : Display {
private:

	X11.Display* m_native;
	public inout(X11.Display*) native() inout @property { return m_native; }

	package {
		X11Window[X11.Window] windowMap;
		IRect[X11Window] invalidationQueue;
		X11DeviceManager deviceManager;
	}

	package(gd.system) this(Application application) {
		scope (failure) dispose();

		addDependency(application);

		// X11.setErrorHandler(cast(X11.XErrorHandler) function int(X11.Display* _disp, X11.XErrorEvent* errorEvent) {
		// 	// throw new Exception("oops");

		// 	return 0;
		// });

		m_native = X11.openDisplay(null);
		enforce!X11Exception(m_native != null, "could not open X11 display");

		X11.Bool success = 1;
		X11.kbSetDetectableAutoRepeat(native, X11.True, &success);
		enforce!X11Exception(success, "error in setting detectable autorepeat");

		deviceManager = new X11DeviceManager(this);
	}

	protected override void disposeImpl() {
		if (native) X11.closeDisplay(native);
	}

public:

	template atom(string name, Flag!"create" create = Yes.create) {
		X11.Atom atomResult;

		X11.Atom atom() {
			if (atomResult == X11.Atom.init) {
				atomResult = X11.internAtom(native, name, !create);
			}

			enforce(atomResult != X11.None, "could not get atom '" ~ name ~ "' (create = " ~ (create ? "yes" : "no") ~ ")");

			return atomResult;
		}
	}

	override X11Window createWindow(WindowInitOptions options) {
		X11Window window = new X11Window(this, options);
		windowMap[window.native] = window;

		window.onStateChange.connect((WindowState state) {
			if (state & WindowState.visible) {
				activeWindows[window] = true;
			}
			else {
				activeWindows.remove(window);
			}
		});

		if (window.state & WindowState.visible) {
			activeWindows[window] = true;
		}

		return window;
	}

	private bool[X11Window] activeWindows;
	override bool isActive() {
		return activeWindows.length > 0;
	}

	override void deactivate() {
		import std.array : array;

		foreach (win; activeWindows.byKey.array) {
			win.state = win.state & ~WindowState.visible;
		}
	}

	private void updateInvalidatedRegions() {
		IRect[X11Window] oldQueue = invalidationQueue;
		invalidationQueue = null;

		foreach (win, region; oldQueue) {
			win.updateRegion(region);
		}
	}

	override void processEvents() {
		while (X11.pending(native)) {
			X11.XEvent ev;
			X11.nextEvent(native, &ev);

			if (deviceManager.processEvent(ev)) {}
			else if (X11Window* window = ev.xany.window in windowMap) {
				window.processEvent(&ev);

				if (ev.type == X11.DestroyNotify) {
					windowMap.remove(window.native);
				}
			}
		}

		updateInvalidatedRegions();

		X11.flush(native);
	}

}
