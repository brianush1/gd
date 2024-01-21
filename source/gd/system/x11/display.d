module gd.system.x11.display;
import gd.system.x11.device;
import gd.system.x11.window;
import gd.system.x11.exception;
import gd.system.window;
import gd.system.display;
import gd.system.application;
import gd.graphics.color;
import gd.math;
import gd.cursor : Cursors;
import gd.resource;
import gd.keycode;
import std.typecons;
import std.exception;

version (gd_X11Impl):

import gd.bindings.x11;
import gd.bindings.xi2;
import gd.bindings.xsync;
import gd.bindings.xcursor;
import gd.bindings.glx;
import gd.bindings.gl;

class X11Cursor : Cursor {
private:

	X11Display m_display;
	public inout(X11Display) display() inout @property { return m_display; }

	X11.Cursor m_native;
	public X11.Cursor native() const @property { return m_native; }

	this(X11Display display, X11.Cursor native) {
		scope (failure) dispose();

		addDependency(display);
		m_display = display;

		m_native = native;
	}

	protected override void disposeImpl() {
		X11.freeCursor(display.native, native);
	}

}

class X11Display : Display {
private:

	X11.Display* m_native;
	public inout(X11.Display*) native() inout @property { return m_native; }

	package {
		// TODO: weak map?
		X11Window[X11.Window] windowMap;
		X11DeviceManager deviceManager;

		X11Cursor[Cursors] systemCursorMap;

		X11.XIM xim;
	}

	package(gd.system) IRect[X11Window] invalidationQueue;

	package(gd.system) this(Application application) {
		scope (failure) dispose();

		addDependency(application);

		import core.stdc.locale : setlocale, LC_CTYPE;
		setlocale(LC_CTYPE, "");
		X11.setLocaleModifiers("");

		m_native = X11.openDisplay(null);
		enforce!X11Exception(m_native != null, "could not open X11 display");

		X11.Bool success = 1;
		X11.kbSetDetectableAutoRepeat(native, X11.True, &success);
		enforce!X11Exception(success, "error in setting detectable autorepeat");

		deviceManager = new X11DeviceManager(this);

		loadSystemCursors();
		openXIM();
	}

	protected override void disposeImpl() {
		// TODO: figure out how to free gl context
		if (native) X11.closeDisplay(native);
	}

	void openXIM() {
		xim = X11.openIM(native, null, null, null);
	}

	void loadSystemCursors() {
		loadSystemCursor(Cursors.Arrow, "default");
		loadSystemCursor(Cursors.ArrowLeft, "left_ptr");
		loadSystemCursor(Cursors.ArrowCenter, "center_ptr");
		loadSystemCursor(Cursors.ArrowRight, "right_ptr");
		loadSystemCursor(Cursors.Cell, "cell");
		loadSystemCursor(Cursors.ColorPicker, "color-picker");
		loadSystemCursor(Cursors.Handwriting, "pencil");
		loadSystemCursor(Cursors.ContextMenu, "context-menu");
		loadSystemCursor(Cursors.Copy, "copy");
		loadSystemCursor(Cursors.Crosshair, "crosshair");
		loadSystemCursor(Cursors.Grab, "grab");
		loadSystemCursor(Cursors.Grabbing, "grabbing");
		loadSystemCursor(Cursors.Hand, "pointer");
		loadSystemCursor(Cursors.Help, "help");
		loadSystemCursor(Cursors.Link, "alias");
		loadSystemCursor(Cursors.Move, "fleur");
		loadSystemCursor(Cursors.NoDrop, "no-drop");
		loadSystemCursor(Cursors.NotAllowed, "not-allowed");
		loadSystemCursor(Cursors.Pan, "all-scroll");
		loadSystemCursor(Cursors.Progress, "progress");
		loadSystemCursor(Cursors.SplitVertical, "split_v");
		loadSystemCursor(Cursors.SplitHorizontal, "split_h");
		loadSystemCursor(Cursors.ResizeRow, "row-resize");
		loadSystemCursor(Cursors.ResizeColumn, "col-resize");
		loadSystemCursor(Cursors.ResizeN, "top_side");
		loadSystemCursor(Cursors.ResizeW, "left_side");
		loadSystemCursor(Cursors.ResizeS, "bottom_side");
		loadSystemCursor(Cursors.ResizeE, "right_side");
		loadSystemCursor(Cursors.ResizeNE, "top_right_corner");
		loadSystemCursor(Cursors.ResizeNW, "top_left_corner");
		loadSystemCursor(Cursors.ResizeSW, "bottom_left_corner");
		loadSystemCursor(Cursors.ResizeSE, "bottom_right_corner");
		loadSystemCursor(Cursors.ResizeNS, "size_ver");
		loadSystemCursor(Cursors.ResizeEW, "size_hor");
		loadSystemCursor(Cursors.ResizeNESW, "size_bdiag");
		loadSystemCursor(Cursors.ResizeNWSE, "size_fdiag");
		loadSystemCursor(Cursors.Text, "text");
		loadSystemCursor(Cursors.VerticalText, "vertical-text");
		loadSystemCursor(Cursors.Wait, "wait");
		loadSystemCursor(Cursors.ZoomIn, "zoom-in");
		loadSystemCursor(Cursors.ZoomOut, "zoom-out");

		// create blank cursor
		X11.XColor color;
		ubyte[1] data = [0];
		X11.Pixmap pixmap = X11.createBitmapFromData(
			native,
			X11.rootWindow(native, X11.defaultScreen(native)),
			cast(char*) data.ptr, 1, 1);
		systemCursorMap[Cursors.None] = new X11Cursor(this,
			X11.createPixmapCursor(native, pixmap, pixmap, &color, &color, 0, 0));
		X11.freePixmap(native, pixmap);
	}

	void loadSystemCursor(Cursors cursor, const(char)* name) {
		X11.Cursor xcursor = XCursor.libraryLoadCursor(native, name);
		if (xcursor != X11.None)
			systemCursorMap[cursor] = new X11Cursor(this, xcursor);
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
		windowMap[window.imeWindow] = window;

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

	override X11Cursor createCursor(IVec2 size, const(uint)[] data, IVec2 hotspot) {
		assert(data.length == size.x * cast(size_t) size.y);
		assert(size.x > 0 && size.y > 0);
		assert(hotspot.x >= 0 && hotspot.y >= 0 && hotspot.x < size.x && hotspot.y < size.y);
		uint[] transformed = new uint[data.length];
		foreach (i; 0 .. data.length) {
			uint color = data[i]; // stored as RGBA
			transformed[i] = // swap to BGRA
				color & 0xFF_00_FF_00u
				| color >> 16 & 0xFF
				| (color & 0xFF) << 16
				;
		}

		XCursor.XcursorImage* img = XCursor.imageCreate(size.x, size.y);
		img.xhot = hotspot.x;
		img.yhot = hotspot.y;
		img.pixels = transformed.ptr;
		X11.Cursor cursor = XCursor.imageLoadCursor(native, img);
		XCursor.imageDestroy(img);

		return new X11Cursor(this, cursor);
	}

	override X11Cursor createXorCursor(IVec2 size, const(uint)[] data, IVec2 hotspot) {
		assert(data.length == size.x * cast(size_t) size.y);
		assert(size.x > 0 && size.y > 0);
		assert(hotspot.x >= 0 && hotspot.y >= 0 && hotspot.x < size.x && hotspot.y < size.y);

		size_t stride = (size.x + 7) / 8;

		ubyte[] transformed = new ubyte[](stride * size.y);
		foreach (y; 0 .. size.y) {
			foreach (x; 0 .. size.x) {
				uint color = data[y * size.x + x]; // stored as RGBA
				if (color >> 24) { // if alpha is nonzero
					transformed[stride * y + x / 8] |= 1 << x % 8; // then invert this pixel
				}
			}
		}

		X11.XColor color;
		X11.Pixmap pixmap = X11.createBitmapFromData(
			native,
			X11.rootWindow(native, X11.defaultScreen(native)),
			cast(char*) transformed.ptr,
			cast(uint) size.x,
			cast(uint) size.y,
		);
		X11Cursor result = new X11Cursor(this, X11.createPixmapCursor(
			native,
			pixmap, pixmap,
			&color, &color,
			hotspot.x, hotspot.y,
		));
		X11.freePixmap(native, pixmap);

		return result;
	}

	override Modifiers getCurrentModifiers() {
		X11.XkbStateRec kbState;
		X11.kbGetState(native, X11.XkbUseCoreKbd, &kbState);

		Modifiers mods;
		if (kbState.mods & X11.ShiftMask) mods |= Modifiers.Shift;
		if (kbState.mods & X11.LockMask) mods |= Modifiers.CapsLock;
		if (kbState.mods & X11.ControlMask) mods |= Modifiers.Ctrl;
		if (kbState.mods & X11.Mod1Mask) mods |= Modifiers.Alt;
		if (kbState.mods & X11.Mod2Mask) mods |= Modifiers.NumLock;
		if (kbState.mods & X11.Mod3Mask) mods |= Modifiers.ScrollLock;
		if (kbState.mods & X11.Mod4Mask) mods |= Modifiers.Super;
		if (kbState.mods & X11.Mod5Mask) mods |= Modifiers.AltGr;

		return mods;
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

		invalidationQueue = null;
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
			if (X11.filterEvent(&ev, X11.None))
				continue;

			if (deviceManager.processEvent(ev)) {}
			else if (X11Window* window = ev.xany.window in windowMap) {
				window.processEvent(&ev);

				if (ev.type == X11.DestroyNotify) {
					windowMap.remove(ev.xany.window);
				}
			}
		}

		updateInvalidatedRegions();

		X11.flush(native);
	}

}
