module gd.internal.x11.display;
import gd.internal.x11.device;
import gd.internal.x11.window;
import gd.internal.x11.exception;
import gd.internal.gl.opengl;
import gd.internal.window;
import gd.internal.display;
import gd.internal.application;
import gd.internal.gpu;
import gd.graphics;
import gd.math.rectangle;
import gd.resource;
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

	package(gd.internal) this(Application application) {
		scope (failure) dispose();

		addDependency(application);

		m_native = X11.openDisplay(null);
		enforce!X11Exception(m_native != null, "could not open X11 display");

		X11.Bool success = 1;
		X11.kbSetDetectableAutoRepeat(native, X11.True, &success);
		enforce!X11Exception(success, "error in setting detectable autorepeat");

		deviceManager = new X11DeviceManager(this);

		createHeadlessContext();
	}

	protected override void disposeImpl() {
		if (native) X11.closeDisplay(native);
	}

	package GLX.GLXContext headlessGlxContext;
	GLX.GLXWindow headlessGlxWindow;
	X11.Window headlessWindow;

	void createHeadlessContext() {
		int screen = X11.defaultScreen(native);
		X11.Window root = X11.rootWindow(native, screen);

		int[23] visualAttribs = [
			GLX.X_RENDERABLE, X11.True,
			GLX.DRAWABLE_TYPE, GLX.PIXMAP_BIT,
			GLX.RENDER_TYPE, GLX.RGBA_BIT,
			GLX.X_VISUAL_TYPE, GLX.TRUE_COLOR,
			GLX.RED_SIZE, 8,
			GLX.GREEN_SIZE, 8,
			GLX.BLUE_SIZE, 8,
			GLX.ALPHA_SIZE, 8,
			GLX.DEPTH_SIZE, 8,
			GLX.STENCIL_SIZE, 8,
			GLX.DOUBLEBUFFER, X11.False,
			X11.None,
		];

		int fbcount;
		GLX.GLXFBConfig fbconfig;
		GLX.GLXFBConfig* fbconfigs = GLX.chooseFBConfig(native, screen, visualAttribs.ptr, &fbcount);
		enforce!X11Exception(fbcount > 0, "could not get framebuffer config");

		int chosenSamples = -1;
		foreach (i, candidate; fbconfigs[0 .. fbcount]) {
			int sampleBuffers, samples;
			GLX.getFBConfigAttrib(native, candidate, GLX.SAMPLE_BUFFERS, &sampleBuffers);
			GLX.getFBConfigAttrib(native, candidate, GLX.SAMPLES, &samples);
			if (i == 0 || (sampleBuffers > 0 && samples == 1)) {
				fbconfig = candidate;
				chosenSamples = samples;
			}
		}
		// this free call is safe, since no statements between the creation of fbconfigs and this free can throw
		X11.free(fbconfigs);

		enforce!X11Exception(chosenSamples != -1, "could not get framebuffer configuration");

		int[9] contextAttribs = [
			GLX.CONTEXT_MAJOR_VERSION_ARB, GL_VERSION_MAJOR,
			GLX.CONTEXT_MINOR_VERSION_ARB, GL_VERSION_MINOR,
			GLX.CONTEXT_PROFILE_MASK_ARB, GLX.CONTEXT_CORE_PROFILE_BIT_ARB,
			GLX.CONTEXT_FLAGS_ARB, GLX.CONTEXT_FORWARD_COMPATIBLE_BIT_ARB,
			X11.None,
		];

		headlessGlxContext = GLX.createContextAttribsARB(
			native,
			fbconfig,
			null,
			X11.True,
			contextAttribs.ptr,
		);

		enforce!X11Exception(headlessGlxContext != null, "could not create OpenGL context");

		X11.sync(native, X11.False);

		headlessWindow = X11.createSimpleWindow(native, root,
			0, 0, 1, 1, // x, y, width, height
			0, // border width
			0, // border
			0, // background
		);

		headlessGlxWindow = GLX.createWindow(native, fbconfig, headlessWindow, null);

		m_gpuContext = new GLContext();
		m_gpuContext.addDependency(this);
		m_gpuContext.registerWindow(null, {
			// TODO: don't call this if it's already the current context
			GLX.makeCurrent(native, headlessGlxWindow, headlessGlxContext);
		});
	}

public:

	private GLContext m_gpuContext;
	override inout(GPUContext) gpuContext() inout @property {
		return m_gpuContext;
	}

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
			if (state & WindowState.Visible) {
				activeWindows[window] = true;
			}
			else {
				activeWindows.remove(window);
			}
		});

		if (window.state & WindowState.Visible) {
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
			win.state = win.state & ~WindowState.Visible;
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
