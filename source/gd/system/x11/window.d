module gd.system.x11.window;
import gd.system.x11.display;
import gd.system.x11.device;
import gd.system.x11.exception;
import gd.system.window;
import gd.resource;
import gd.graphics;
import gd.keycode;
import gd.math;
import std.typecons;
import std.exception;

version (gd_X11Impl):

import gd.bindings.x11;
import gd.bindings.xfixes;
import gd.bindings.xi2;
import gd.bindings.xsync;
import gd.bindings.glx;
import gd.bindings.gl;

immutable(string) WINDOW_CLASS = "gd_window";

class X11MousePointer : Pointer {

	private X11Device device;

	int deviceId() const @property { return device.id; }

	private X11Window window;

	private this(X11Window window, X11Device device) {
		scope (failure) dispose();

		this.device = device;
		addDependency(device);

		this.window = window;
		addDependency(window);
	}

	protected override void disposeImpl() {}

	override PointerType type() const @property {
		return PointerType.mouse;
	}

	override PointerFlags flags() const @property {
		PointerFlags flags = PointerFlags.canSetPosition
			| PointerFlags.hasScreenPosition;
		if (device.getValuatorByRole(ValuatorRole.pressure)) {
			flags |= PointerFlags.hasPressure;
		}
		return flags;
	}

	override Vec2 position() const @property {
		if (lockedInPlace) {
			return lockedPosition;
		}
		else {
			return currentPosition;
		}
	}

	override void position(Vec2 newPosition) @property {
		if (lockedInPlace) {
			return;
		}

		warp(false, newPosition);
	}

	private double m_pressure = 0;
	override double pressure() const @property {
		return m_pressure;
	}

	private {
		XFixes.PointerBarrier[] barriers;
		bool lockedInPlace;
		Vec2 lockedPosition;
		Vec2 currentPosition;

		struct Position {
			Vec2 window, screen;
		}

		Position queryPosition() const @property {
			Position result;
			X11.Window root, child;
			XI2.XIButtonState buttons;
			XI2.XIModifierState mods;
			XI2.XIGroupState group;
			XI2.queryPointer(
				(cast() window).display.native,
				deviceId,
				window.native,
				&root, &child,
				&result.screen.x(), &result.screen.y(),
				&result.window.x(), &result.window.y(),
				&buttons, &mods, &group,
			);
			return result;
		}

		void warp(bool screenWarp, Vec2 newScreenPosition) {
			X11.XWindowAttributes attrs;
			X11.getWindowAttributes(window.display.native, window.native, &attrs);
			int screen = X11.screenNumberOfScreen(attrs.screen);
			X11.Window root = X11.rootWindow(window.display.native, screen);

			XI2.warpPointer(
				window.display.native, // display
				deviceId, // device ID
				root, // src win
				screenWarp ? root : window.native, // dst win
				0, 0, 0, 0, // src rectangle
				newScreenPosition.x, newScreenPosition.y, // dst x, y
			);
		}
	}

	override void lockInPlace() {
		removeConstraint();

		// we would like to have the latest cursor position we can so the
		// cursor doesn't teleport backwards
		X11.sync(window.display.native, X11.False);

		Position queriedPosition = queryPosition();
		int x = cast(int) queriedPosition.screen.x;
		int y = cast(int) queriedPosition.screen.y;

		// UGLY HACK: maintain subpixel precision, but also update the pointer position if we need to
		if (IVec2(queriedPosition.window) != IVec2(currentPosition)) {
			lockedPosition = queriedPosition.window;
		}
		else {
			lockedPosition = currentPosition;
		}

		lockedInPlace = true;

		int m_deviceId = deviceId;
		barriers = [

			// left barrier
			XFixes.createPointerBarrier(window.display.native, window.native,
				x, y - 1,
				x, y + 2,
				0, 1, &m_deviceId),

			// right barrier
			XFixes.createPointerBarrier(window.display.native, window.native,
				x + 1, y - 1,
				x + 1, y + 2,
				0, 1, &m_deviceId),

			// top barrier
			XFixes.createPointerBarrier(window.display.native, window.native,
				x - 1, y,
				x + 2, y,
				0, 1, &m_deviceId),

			// bottom barrier
			XFixes.createPointerBarrier(window.display.native, window.native,
				x - 1, y + 1,
				x + 2, y + 1,
				0, 1, &m_deviceId),

		];

		// after we create the barriers, warp the pointer back to
		// where we think it is in case it's managed to escape the constraints
		// between when we queried the position and when we made the barriers
		warp(true, queriedPosition.screen);
	}

	override void removeConstraint() {
		lockedInPlace = false;

		foreach (barrier; barriers) {
			XFixes.destroyPointerBarrier(window.display.native, barrier);
		}

		barriers = [];
	}

}

class X11Window : Window {
private:
	X11Display m_display;
	public inout(X11Display) display() inout @property { return m_display; }

	bool createdXWindow;
	X11.Window m_native;
	public inout(X11.Window) native() inout @property { return m_native; }

	GLX.GLXContext glContext;
	GLX.GLXFBConfig fbconfig;
	X11.GC gcontext;
	IVec2 bufferSize;
	X11.Pixmap backBuffer;
	GLX.GLXPixmap glxBackBuffer;
	bool oversizeBuffer;

	immutable(XSync.XSyncCounter) xsyncCounter = X11.None;

	X11MousePointer[] m_pointers;

	package this(X11Display display, WindowInitOptions options) {
		scope (failure) dispose();

		m_display = display;

		addDependency(display);

		oversizeBuffer = options.oversizeBuffer;

		display.deviceManager.handleDevice((X11Device device) {
			if (device.role == DeviceRole.pointer) {
				X11MousePointer pointer = new X11MousePointer(this, device);

				m_pointers ~= pointer;
				onPointerAdd.emit(pointer);
			}
		});

		display.deviceManager.onDeviceRemove.connect((X11Device device) {
			import std.algorithm : remove;

			foreach (i, pointer; m_pointers) {
				if (pointer.device is device) {
					pointer.onRemove.emit();
					m_pointers = m_pointers.remove(i);
					break;
				}
			}
		});

		int screen = X11.defaultScreen(display.native);
		X11.Window root = X11.rootWindow(display.native, screen);

		int[23] visualAttribs = [
			GLX.X_RENDERABLE, X11.True,
			GLX.DRAWABLE_TYPE, GLX.PIXMAP_BIT,
			GLX.RENDER_TYPE, GLX.RGBA_BIT,
			GLX.X_VISUAL_TYPE, GLX.TRUE_COLOR,
			GLX.RED_SIZE, 8,
			GLX.GREEN_SIZE, 8,
			GLX.BLUE_SIZE, 8,
			GLX.ALPHA_SIZE, 8,
			GLX.DEPTH_SIZE, options.gl.depthSize,
			GLX.STENCIL_SIZE, 8,
			GLX.DOUBLEBUFFER, X11.False,
			X11.None,
		];

		int fbcount;
		GLX.GLXFBConfig* fbconfigs = GLX.chooseFBConfig(display.native, screen, visualAttribs.ptr, &fbcount);
		enforce!X11Exception(fbcount > 0, "could not get framebuffer config");

		int chosenSamples = -1;
		foreach (i, candidate; fbconfigs[0 .. fbcount]) {
			int sampleBuffers, samples;
			GLX.getFBConfigAttrib(display.native, candidate, GLX.SAMPLE_BUFFERS, &sampleBuffers);
			GLX.getFBConfigAttrib(display.native, candidate, GLX.SAMPLES, &samples);
			if (i == 0 || (sampleBuffers > 0 && samples == 1)) {
				fbconfig = candidate;
				chosenSamples = samples;
			}
		}
		// this free call is safe, since no statements between the creation of fbconfigs and this free can throw
		X11.free(fbconfigs);

		enforce!X11Exception(chosenSamples != -1, "could not get framebuffer configuration");

		// X11.XVisualInfo* visualInfo = GLX.getVisualFromFBConfig(display.native, fbconfig);
		// enforce!X11Exception(visualInfo != null, "could not get OpenGL visual");
		X11.Visual* visual = X11.defaultVisual(display.native, screen);

		try {
			X11.XSetWindowAttributes winAttribs;
			winAttribs.colormap = X11.createColormap(display.native, root, visual, X11.AllocNone);
			// winAttribs.override_redirect = isPopup; // TODO: support for popup windows

			createdXWindow = true; // used to make sure we don't destroy a window in disposeImpl before it's created
			m_native = X11.createWindow(
				display.native,
				root, // parent
				0, 0, options.size.x, options.size.y, // x, y, width, height
				0, // border width
				24, // color depth
				X11.InputOutput,
				visual,
				// TODO: support for popup windows (override redirect)
				X11.CWColormap, // | X11.CWOverrideRedirect
				&winAttribs,
			);

			X11.freeColormap(display.native, winAttribs.colormap);
		}
		finally {
			// X11.free(visualInfo);
		}

		// X11.XColor color;
		// ubyte[1] data = [0];

		// X11.Pixmap pixmap = X11.createBitmapFromData(display.native, native, cast(char*) data.ptr, 1, 1);
		// X11.Cursor cursor = X11.createPixmapCursor(display.native, pixmap, pixmap, &color, &color, 0, 0);
		// X11.freePixmap(display.native, pixmap);

		// XI2.defineCursor(display.native, m_pointer.m_deviceId, native, cursor);

		int[9] contextAttribs = [
			GLX.CONTEXT_MAJOR_VERSION_ARB, options.gl.versionMajor,
			GLX.CONTEXT_MINOR_VERSION_ARB, options.gl.versionMinor,
			GLX.CONTEXT_PROFILE_MASK_ARB, GLX.CONTEXT_CORE_PROFILE_BIT_ARB,
			GLX.CONTEXT_FLAGS_ARB, GLX.CONTEXT_FORWARD_COMPATIBLE_BIT_ARB,
			X11.None,
		];

		glContext = GLX.createContextAttribsARB(
			display.native,
			fbconfig,
			null,
			X11.True, // request direct rendering
			contextAttribs.ptr,
		);

		enforce!X11Exception(glContext != null, "could not create OpenGL context");

		gcontext = X11.createGC(display.native, m_native, 0, null);
		X11.setGraphicsExposures(display.native, gcontext, X11.False);

		bufferSize = IVec2(640, 480);
		backBuffer = X11.createPixmap(display.native, m_native, bufferSize.x, bufferSize.y, 24);
		glxBackBuffer = GLX.createPixmap(display.native, fbconfig, backBuffer, null);

		// sync to ensure any errors generated are processed
		X11.sync(display.native, X11.False);

		// TODO: vsync
		makeGLContextCurrent(); // turn vsync off (I don't know if it's on tbh!)
		GLX.swapIntervalEXT(display.native, native, 0);
		auto glXSwapIntervalMESA = cast(int function(int)) GLX.getProcAddress(cast(const(ubyte)*) "glXSwapIntervalMESA".ptr);
		if (glXSwapIntervalMESA !is null) {
			glXSwapIntervalMESA(0);
		}

		title = options.title;
		m_size = options.size;
		backgroundColor = options.backgroundColor;

		X11.XClassHint classHint;
		X11.XWMHints wmHints;
		X11.XSizeHints sizeHints;
		classHint.res_class = classHint.res_name = cast(char*) WINDOW_CLASS.ptr;
		X11.setWMProperties(display.native, native, null, null, null, 0, &sizeHints, &wmHints, &classHint);

		X11.Atom[] protocols = [
			// get notified when the user wants to close the window:
			display.atom!"WM_DELETE_WINDOW",
		];

		xsyncCounter = XSync.createCounter(display.native, XSync.XSyncValue(0, 0));
		if (xsyncCounter != X11.None) {
			// enable the XSync extension so we can let the window manager know when our resize events are
			// done processing and avoid getting overwhelmed
			protocols ~= display.atom!"_NET_WM_SYNC_REQUEST";
			changeProperty(
				display.atom!("_NET_WM_SYNC_REQUEST_COUNTER", No.create),
				display.atom!("CARDINAL", No.create),
				[cast(uint) xsyncCounter],
			);
		}

		X11.setWMProtocols(display.native, native, protocols.ptr, cast(int) protocols.length);

		state = options.initialState; // set initial state
		X11.sync(display.native, X11.False);

		enum maskLen = typeof(XI2).maskLen(typeof(XI2).XI_LASTEVENT);
		XI2.XIEventMask mask = {
			deviceid: XI2.XIAllMasterDevices, // XIAllDevices
			mask_len: maskLen,
			mask: new ubyte[maskLen].ptr,
		};
		XI2.setMask(mask.mask, XI2.XI_TouchBegin);
		XI2.setMask(mask.mask, XI2.XI_TouchUpdate);
		XI2.setMask(mask.mask, XI2.XI_TouchEnd);
		XI2.setMask(mask.mask, XI2.XI_ButtonPress);
		XI2.setMask(mask.mask, XI2.XI_ButtonRelease);
		XI2.setMask(mask.mask, XI2.XI_BarrierHit);
		XI2.setMask(mask.mask, XI2.XI_Motion);
		XI2.setMask(mask.mask, XI2.XI_Enter);
		XI2.setMask(mask.mask, XI2.XI_Leave);
		// XI2.setMask(mask.mask, XI2.XI_RawMotion);
		XI2.selectEvents(display.native, native, &mask, 1);
		X11.sync(display.native, X11.False);

		updateEventMask();
	}

	protected override void disposeImpl() {
		if (glContext != null) {
			// TODO: figure out how to free gl context
		}
		if (createdXWindow) X11.destroyWindow(display.native, native);
		if (xsyncCounter != X11.None) XSync.destroyCounter(display.native, xsyncCounter);
	}

	void changeProperty(T)(X11.Atom name, X11.Atom type, const(T)[] data, int mode = X11.PropModeReplace)
	if (is(T == ubyte) || is(T == ushort) || is(T == uint) || is(T == ulong)) {
		import core.stdc.config : c_ulong;

		static if (is(T == ubyte)) int format = 8;
		else static if (is(T == ushort)) int format = 16;
		else int format = 32;

		static if (is(T == uint) && uint.sizeof != c_ulong.sizeof) {
			c_ulong[] dataCopy;

			foreach (v; data) {
				dataCopy.assumeSafeAppend ~= cast(c_ulong) v;
			}
		}
		else static if (is(T == ulong) && ulong.sizeof != c_ulong.sizeof) {
			c_ulong[] dataCopy;

			foreach (v; data) {
				dataCopy.assumeSafeAppend ~= cast(c_ulong) v;
			}
		}
		else {
			alias dataCopy = data;
		}

		X11.changeProperty(
			display.native, native,
			name, type, format, mode,
			cast(const(ubyte)*) dataCopy.ptr,
			cast(int) data.length,
		);

		// sync so the GC doesn't have the opportunity to free the data buffer
		X11.sync(display.native, X11.False);
	}

	X11MousePointer getPointerByDeviceId(int deviceId) {
		foreach (pointer; m_pointers) {
			if (pointer.deviceId == deviceId) {
				return pointer;
			}
		}

		return null;
	}

	void updateEventMask() {
		typeof(X11.NoEventMask) eventMask = 0
			| X11.ExposureMask
			| X11.PropertyChangeMask
			| X11.FocusChangeMask
			| X11.StructureNotifyMask
			| X11.VisibilityChangeMask
			| X11.KeyPressMask
			| X11.KeyReleaseMask
		;

		if (XI2 is null) {
			eventMask |= 0
				| X11.ButtonPressMask
				| X11.ButtonReleaseMask
				| X11.PointerMotionMask
			;
		}

		X11.selectInput(display.native, native, eventMask);
		X11.sync(display.native, X11.False);
	}

	long currentConfigureTimer = -1;

	package void processEvent(X11.XEvent* ev) {
		import std.stdio : writefln;

		string name;
		switch (ev.type) {
			case X11.KeyPress: name = "KeyPress"; break;
			case X11.KeyRelease: name = "KeyRelease"; break;
			case X11.ButtonPress: name = "ButtonPress"; break;
			case X11.ButtonRelease: name = "ButtonRelease"; break;
			case X11.MotionNotify: name = "MotionNotify"; break;
			case X11.EnterNotify: name = "EnterNotify"; break;
			case X11.LeaveNotify: name = "LeaveNotify"; break;
			case X11.FocusIn: name = "FocusIn"; break;
			case X11.FocusOut: name = "FocusOut"; break;
			case X11.KeymapNotify: name = "KeymapNotify"; break;
			case X11.Expose: name = "Expose"; break;
			case X11.GraphicsExpose: name = "GraphicsExpose"; break;
			case X11.NoExpose: name = "NoExpose"; break;
			case X11.VisibilityNotify: name = "VisibilityNotify"; break;
			case X11.CreateNotify: name = "CreateNotify"; break;
			case X11.DestroyNotify: name = "DestroyNotify"; break;
			case X11.UnmapNotify: name = "UnmapNotify"; break;
			case X11.MapNotify: name = "MapNotify"; break;
			case X11.MapRequest: name = "MapRequest"; break;
			case X11.ReparentNotify: name = "ReparentNotify"; break;
			case X11.ConfigureNotify: name = "ConfigureNotify"; break;
			case X11.ConfigureRequest: name = "ConfigureRequest"; break;
			case X11.GravityNotify: name = "GravityNotify"; break;
			case X11.ResizeRequest: name = "ResizeRequest"; break;
			case X11.CirculateNotify: name = "CirculateNotify"; break;
			case X11.CirculateRequest: name = "CirculateRequest"; break;
			case X11.PropertyNotify: name = "PropertyNotify"; break;
			case X11.SelectionClear: name = "SelectionClear"; break;
			case X11.SelectionRequest: name = "SelectionRequest"; break;
			case X11.SelectionNotify: name = "SelectionNotify"; break;
			case X11.ColormapNotify: name = "ColormapNotify"; break;
			case X11.ClientMessage: name = "ClientMessage"; break;
			case X11.MappingNotify: name = "MappingNotify"; break;
			case X11.GenericEvent: name = "GenericEvent"; break;
			default: name = "?"; break;
		}
		// writefln!"event %s"(name);

		static bool syncRequest = false;
		static XSync.XSyncValue syncValue;

		switch (ev.type) {
		case X11.ClientMessage:
			if (ev.xclient.message_type == display.atom!"WM_PROTOCOLS") {
				if (ev.xclient.data.l[0] == display.atom!"WM_DELETE_WINDOW") {
					onCloseRequest.emit();
				}
				else if (ev.xclient.data.l[0] == display.atom!"_NET_WM_SYNC_REQUEST") {
					syncRequest = true;
					syncValue.lo = cast(uint) ev.xclient.data.l[2];
					syncValue.hi = cast(int) ev.xclient.data.l[3];
				}
			}

			break;
		case X11.ConfigureNotify:
			import gd.system.application : application;
			import std.algorithm : min, max;
			import std.datetime : Duration, msecs;

			void resizeBackBuffer(IVec2 newSize) {
				if (bufferSize == newSize) {
					return;
				}

				bufferSize = newSize;

				GLX.destroyPixmap(display.native, glxBackBuffer);
				X11.freePixmap(display.native, backBuffer);

				backBuffer = X11.createPixmap(display.native, native, bufferSize.x, bufferSize.y, 24);
				glxBackBuffer = GLX.createPixmap(display.native, fbconfig, backBuffer, null);
			}

			// query the current width/height, because xconfigure.width/height can be up to 1 frame behind
			X11.XWindowAttributes attrs;
			X11.getWindowAttributes(display.native, native, &attrs);
			m_size = IVec2(max(attrs.width, 1), max(attrs.height, 1));

			if (oversizeBuffer) {
				application.timer.cancel(currentConfigureTimer);
				currentConfigureTimer = application.timer.setTimer(500.msecs, {
					resizeBackBuffer(size);
					doPaint(IRect(IVec2(), size));
				});

				IVec2 newSize = bufferSize;

				while (newSize.x < attrs.width) { newSize.x = (newSize.x * 3 + 1) / 2; }
				while (newSize.y < attrs.height) { newSize.y = (newSize.y * 3 + 1) / 2; }

				newSize.x = min(newSize.x, max(attrs.width, X11.widthOfScreen(attrs.screen)));
				newSize.y = min(newSize.y, max(attrs.height, X11.heightOfScreen(attrs.screen)));

				resizeBackBuffer(newSize);
			}
			else {
				resizeBackBuffer(size);
			}

			doPaint(IRect(IVec2(), size));

			if (syncRequest) {
				syncRequest = false;
				XSync.setCounter(display.native, xsyncCounter, syncValue);
				X11.sync(display.native, X11.False);
			}

			break;
		case X11.Expose:
			IRect region = IRect(
				ev.xexpose.x, ev.xexpose.y,
				ev.xexpose.width, ev.xexpose.height,
			);

			X11.copyArea(display.native,
				backBuffer, // source
				native, // destination
				gcontext,
				region.x, region.y, // source pos
				region.width, region.height, // size
				region.x, region.y, // destination pos
			);

			break;
		case X11.PropertyDelete:
		case X11.PropertyNewValue:
		case X11.PropertyNotify:
			if (ev.xproperty.atom == display.atom!"_NET_WM_STATE"
					&& (m_state & WindowState.visible) != 0) {
				import core.stdc.config : c_ulong;

				X11.Atom type;
				int format;

				X11.Atom* states;
				c_ulong bytesAfter = 0, numStates = 0;
				int success = X11.getWindowProperty(display.native, native,
					display.atom!"_NET_WM_STATE",
					0, 1024,
					X11.False,
					display.atom!"ATOM",
					&type, &format,
					&numStates,
					&bytesAfter,
					cast(ubyte**) &states,
				);

				bool[X11.Atom] stateMap;

				if (success == X11.Success) {
					foreach (i; 0 .. numStates) {
						stateMap[states[i]] = true;
					}
				}

				WindowState windowState = WindowState.visible;

				if (display.atom!"_NET_WM_STATE_MAXIMIZED_HORZ" in stateMap
						&& display.atom!"_NET_WM_STATE_MAXIMIZED_VERT" in stateMap) {
					windowState |= WindowState.maximized;
				}

				if (display.atom!"_NET_WM_HIDDEN" in stateMap) {
					windowState |= WindowState.minimized;
				}

				if (display.atom!"_NET_WM_STATE_FULLSCREEN" in stateMap) {
					windowState |= WindowState.fullscreen;
				}

				if (display.atom!"_NET_WM_STATE_DEMANDS_ATTENTION" in stateMap) {
					windowState |= WindowState.attention;
				}

				if (display.atom!"_NET_WM_STATE_ABOVE" in stateMap) {
					windowState |= WindowState.topmost;
				}

				if (windowState != m_state) {
					m_state = windowState;
					onStateChange.emit(windowState);
				}
			}

			break;
		case X11.KeyPress:
		case X11.KeyRelease:
			import gd.system.x11.keycode : keySymToKeyCode;
			import std.algorithm : countUntil;

			X11.KeySym[] keys;

			X11.KeySym currentKey;
			int keyIndex = 0;
			while ((currentKey = X11.lookupKeysym(&ev.xkey, keyIndex++)) != X11.NoSymbol) {
				keys.assumeSafeAppend ~= currentKey;
			}

			Modifiers mods;
			if (ev.xkey.state & X11.ShiftMask) mods |= Modifiers.shift;
			if (ev.xkey.state & X11.LockMask) mods |= Modifiers.capsLock;
			if (ev.xkey.state & X11.ControlMask) mods |= Modifiers.ctrl;
			if (ev.xkey.state & X11.Mod1Mask) mods |= Modifiers.alt;
			if (ev.xkey.state & X11.Mod2Mask) mods |= Modifiers.numLock;
			if (ev.xkey.state & X11.Mod3Mask) mods |= Modifiers.scrollLock;
			if (ev.xkey.state & X11.Mod4Mask) mods |= Modifiers.super_;
			if (ev.xkey.state & X11.Mod5Mask) mods |= Modifiers.altGr;

			X11.KeySym key;
			X11.lookupString(&ev.xkey, null, 0, &key, null);

			// we search the keysyms for a key that's known to us
			// and we filter out purely logical KeyCodes when looking
			// for the physical key

			// this way, we can still support keybinds like Ctrl+C that use Latin characters
			// on non-Latin keyboard layouts, while also making sure shortcuts like Ctrl+A
			// use the key labelled A on Latin layouts like AZERTY (which seems to be standard behavior on Linux)

			KeyCode getKeyCode(size_t startIndex, bool logical) {
				size_t index = startIndex;

				do {
					KeyCode result = keySymToKeyCode(keys[index]);

					if (result != KeyCode.unknown
							&& (logical || result % 0x1000 < 0x800)) {
						return result;
					}

					index = (index + 1) % keys.length;
				}
				while (index != startIndex);

				return KeyCode.unknown;
			}

			KeyInfo info;
			info.mods = mods;
			info.physical = getKeyCode(0, false);
			info.logical = getKeyCode(keys.countUntil(key), true);

			if (ev.type == X11.KeyPress) {
				onKeyPress.emit(info);
			}
			else {
				onKeyRelease.emit(info);
			}

			break;
		default:
			break;
		}
	}

	package void processXI2Event(XI2.XIEnterEvent* ev) {
		X11MousePointer pointer = getPointerByDeviceId(ev.deviceid);
		if (pointer is null) return;

		switch (ev.evtype) {
		case XI2.XI_Enter:
			pointer.onEnter.emit();
			break;
		case XI2.XI_Leave:
			pointer.onLeave.emit();
			break;
		default:
			assert(0);
		}
	}

	package void processXI2Event(XI2.XIDeviceEvent* devev) {
		import std.stdio : writefln;

		double[int] valuators;

		int valuatorIndex = 0;
		foreach (i; 0 .. devev.valuators.mask_len) {
			ubyte mask = devev.valuators.mask[i];
			foreach (j; 0 .. 8) {
				if ((mask & cast(ubyte)(1 << j)) != 0) {
					valuators[8 * i + j] = devev.valuators.values[valuatorIndex];
					valuatorIndex += 1;
				}
			}
		}

		// debug { import std.stdio : writeln; try { writeln(valuators); } catch (Exception) {} }

		// if (devev.flags & XI2.XIPointerEmulated) {
		// 	return;
		// }

		switch (devev.evtype) {
		case XI2.XI_TouchBegin:
			writefln!"Touch Begin   %08X %f %f"(devev.detail, devev.event_x, devev.event_y);
			break;
		case XI2.XI_TouchUpdate:
			writefln!"Touch Update  %08X %f %f    dev = %d, src = %d"(devev.detail, devev.event_x, devev.event_y,
				devev.deviceid, devev.sourceid);
			break;
		case XI2.XI_TouchEnd:
			writefln!"Touch End     %08X %f %f"(devev.detail, devev.event_x, devev.event_y);
			break;
		case XI2.XI_ButtonPress:
		case XI2.XI_ButtonRelease:
			X11MousePointer pointer = getPointerByDeviceId(devev.deviceid);
			MouseButton button;

			// TODO: look at button labels
			switch (devev.detail) {
				case 1: button = MouseButton.left; break;
				case 2: button = MouseButton.middle; break;
				case 3: button = MouseButton.right; break;
				default: button = MouseButton.unknown; break;
			}

			if (pointer !is null && button != MouseButton.unknown) {
				if (devev.evtype == XI2.XI_ButtonPress) {
					pointer.onButtonPress.emit(button);
				}
				else {
					pointer.onButtonRelease.emit(button);
				}
			}
			// writefln!"Button Press  %d"(devev.detail);

			// enum maskLen = typeof(XI2).maskLen(typeof(XI2).XI_LASTEVENT);
			// XI2.XIEventMask mask = {
			// 	deviceid: XI2.XIAllMasterDevices, // XIAllDevices
			// 	mask_len: maskLen,
			// 	mask: new ubyte[maskLen].ptr,
			// };
			// XI2.grabDevice(display.native, 2, native, X11.CurrentTime,
			// 	X11.None, XI2.XIGrabModeAsync, XI2.XIGrabModeAsync, X11.False, &mask);

			break;
		case XI2.XI_Motion:
			X11MousePointer pointer = getPointerByDeviceId(devev.deviceid);

			if (pointer !is null) {
				pointer.currentPosition = Vec2(devev.event_x, devev.event_y);
				pointer.onPositionChange.emit(pointer.position);

				foreach (valuator; pointer.device.valuators) {
					if (valuator.number in valuators) {
						if (valuator.role == ValuatorRole.scrollVertical) {
							pointer.onScroll.emit(
								Vec2(0, valuators[valuator.number] - valuator.value)
								/ valuator.increment
							);
						}
						else if (valuator.role == ValuatorRole.scrollHorizontal) {
							pointer.onScroll.emit(
								Vec2(valuators[valuator.number] - valuator.value, 0)
								/ valuator.increment
							);
						}
						else if (valuator.role == ValuatorRole.pressure) {
							pointer.m_pressure = (valuators[valuator.number] - valuator.min)
								/ (valuator.max - valuator.min);
							pointer.onPressureChange.emit(pointer.pressure);
						}
					}
				}
			}
			// writefln!"Motion        %f %f | %f %f"(devev.event_x, devev.event_y,
			// 	2 in valuators ? valuators[2] : 0.0/0,
			// 	3 in valuators ? valuators[3] : 0.0/0,
			// );
			writefln!"Motion %s"(valuators);
			break;
		default:
			break;
		}
	}

public:

	override inout(Pointer)[] pointers() inout @property {
		inout(Pointer)[] result;

		result ~= m_pointers;

		return result;
	}

	private void makeGLContextCurrent() {
		// some events may keep firing after the window is closed
		if (disposed) return;

		GLX.makeCurrent(display.native, native, glContext);
	}

	private PaintHandler m_paintHandler;
	override void setPaintHandler(PaintHandler handler) {
		m_paintHandler = handler;
	}

	override void invalidate(IRect region) {
		if (IRect* invalidatedRegion = this in display.invalidationQueue) {
			*invalidatedRegion = invalidatedRegion.minimalUnion(region);
		}
		else {
			display.invalidationQueue[this] = region;
		}
	}

	package void updateRegion(IRect region) {
		if (disposed) return;

		doPaint(region);
	}

	void doPaint(IRect region) {
		if (m_paintHandler is null) {
			return;
		}

		GLX.makeCurrent(display.native, glxBackBuffer, glContext);
		GL.drawBuffer(GL.FRONT_LEFT);

		IRect paintedRegion = m_paintHandler(region, bufferSize);
		IRect updateRegion = paintedRegion.clipArea(IRect(IVec2(0, 0), size));

		GL.Sync fence = GL.fenceSync(GL.SYNC_GPU_COMMANDS_COMPLETE, 0);
		GL.clientWaitSync(fence, GL.SYNC_FLUSH_COMMANDS_BIT, 50_000_000); // 50 ms = 20 fps

		X11.copyArea(display.native,
			backBuffer, // source
			native, // destination
			gcontext,
			updateRegion.x, updateRegion.y, // source pos
			updateRegion.width, updateRegion.height, // size
			updateRegion.x, updateRegion.y, // destination pos
		);
	}

	private string m_title;
	override string title() const @property { return m_title; }
	override void title(string value) @property {
		if (m_title == value) return;

		m_title = value;

		X11.XTextProperty windowName;
		windowName.value = cast(ubyte*) m_title.ptr;
		windowName.encoding = display.atom!("UTF8_STRING", No.create);
		windowName.format = 8;
		windowName.nitems = cast(uint) m_title.length;
		X11.setWMName(display.native, native, &windowName);

		changeProperty(
			display.atom!("_NET_WM_NAME", No.create),
			display.atom!("UTF8_STRING", No.create),
			cast(const(ubyte)[]) m_title,
		);

		X11.flush(display.native);
	}

	private IVec2 m_size;
	override IVec2 size() const @property { return m_size; }
	override void size(IVec2 value) @property {
		import std.algorithm : max;

		value = IVec2(max(value.x, 1), max(value.y, 1));
		m_size = value;

		X11.XWindowAttributes attrs;
		X11.getWindowAttributes(display.native, native, &attrs);
		X11.moveResizeWindow(display.native, native, attrs.x, attrs.y, value.x, value.y);
	}

	private WindowState m_state;
	override WindowState state() const @property { return m_state; }
	override void state(WindowState value) @property {
		if (m_state == value) return;

		WindowState prev = m_state;
		m_state = value;

		onStateChange.emit(m_state);

		WindowState add = value & ~prev;
		WindowState remove = prev & ~value;

		struct AtomState {
			WindowState state;
			typeof(X11).Atom atom1, atom2;
		}

		AtomState[] atoms;

		atoms ~= AtomState(WindowState.maximized,
			display.atom!"_NET_WM_STATE_MAXIMIZED_HORZ",
			display.atom!"_NET_WM_STATE_MAXIMIZED_VERT");
		atoms ~= AtomState(WindowState.fullscreen, display.atom!"_NET_WM_STATE_FULLSCREEN");
		atoms ~= AtomState(WindowState.attention, display.atom!"_NET_WM_STATE_DEMANDS_ATTENTION");
		atoms ~= AtomState(WindowState.topmost, display.atom!"_NET_WM_STATE_ABOVE");

		if (add & WindowState.visible) {
			X11.Atom[] wmState;

			foreach (atomState; atoms) {
				if (value & atomState.state) {
					wmState ~= atomState.atom1;

					if (atomState.atom2 != X11.None) {
						wmState ~= atomState.atom2;
					}
				}
			}

			changeProperty(
				display.atom!("_NET_WM_STATE", No.create),
				display.atom!("ATOM", No.create),
				wmState,
			);

			X11.mapWindow(display.native, native);

			if (value & WindowState.minimized) {
				X11.iconifyWindow(display.native, native, X11.defaultScreen(display.native));
			}
		}
		else if (remove & WindowState.visible) {
			X11.XWindowAttributes attrs;
			X11.getWindowAttributes(display.native, native, &attrs);
			X11.withdrawWindow(display.native, native, X11.screenNumberOfScreen(attrs.screen));
		}
		else {
			X11.XWindowAttributes attrs;
			X11.getWindowAttributes(display.native, native, &attrs);
			int screen = X11.screenNumberOfScreen(attrs.screen);
			X11.Window root = X11.rootWindow(display.native, screen);

			foreach (atomState; atoms) {
				int action = -1;
				if (add & atomState.state) action = 1; // _NET_WM_STATE_ADD
				else if (remove & atomState.state) action = 0; // _NET_WM_STATE_REMOVE

				if (action != -1) {
					import core.stdc.config : c_long;

					X11.XClientMessageEvent ev;
					ev.type = X11.ClientMessage;
					ev.window = native;
					ev.message_type = display.atom!"_NET_WM_STATE";
					ev.format = 32;
					ev.data.l[0] = action;
					ev.data.l[1] = atomState.atom1;
					ev.data.l[2] = atomState.atom2;
					ev.data.l[3] = 1;
					X11.sendEvent(display.native,
						root,
						X11.False,
						X11.SubstructureRedirectMask | X11.SubstructureNotifyMask,
						cast(X11.XEvent*) &ev,
					);
				}
			}

			if (add & WindowState.minimized) {
				X11.iconifyWindow(display.native, native, screen);
			}
			else if (remove & WindowState.minimized) {
				X11.mapWindow(display.native, native);
			}
		}
	}

	private Color m_backgroundColor;
	override Color backgroundColor() const @property { return m_backgroundColor; }
	override void backgroundColor(Color value) @property {
		value.a = 1;
		value = value.clamp;

		if (m_backgroundColor.asUint != value.asUint) {
			X11.setWindowBackground(display.native, native, value.asUint);
		}

		m_backgroundColor = value;
	}

}
