module gd.system.win32.display;
import gd.system.win32.window;
import gd.system.win32.exception;
import gd.system.application;
import gd.system.display;
import gd.system.window;
import gd.cursor : Cursors;
import gd.keycode;
import gd.math;
import std.datetime;
import std.typecons;

version (gd_Win32):

import core.sys.windows.windows;

class Win32Cursor : Cursor {
private:

	Win32Display m_display;
	public inout(Win32Display) display() inout @property { return m_display; }

	HCURSOR m_hCursor;
	public inout(HCURSOR) hCursor() inout @property { return m_hCursor; }

	bool needsDestroying;

	this(Win32Display display, HCURSOR hCursor, bool needsDestroying) {
		scope (failure) dispose();

		addDependency(display);
		m_display = display;

		m_hCursor = hCursor;

		this.needsDestroying = needsDestroying;
	}

	protected override void disposeImpl() {
		if (needsDestroying)
			DestroyIcon(hCursor);
	}

}

class Win32Display : Display {

	package {
		// TODO: weak map?
		Win32Window[HWND] windowMap;

		Win32Cursor[Cursors] systemCursorMap;

		HKL qwerty;
	}

	private HMODULE m_hInstance;
	inout(HMODULE) hInstance() inout @property { return m_hInstance; }

	package(gd.system) this(Application application) {
		scope (failure) dispose();

		addDependency(application);

		m_hInstance = GetModuleHandleW(NULL);

		WNDCLASSEXW wc;
		wc.cbSize = WNDCLASSEXW.sizeof;
		wc.style = CS_HREDRAW | CS_VREDRAW;
		wc.lpfnWndProc = &win32WindowWndProc;
		wc.cbClsExtra = 0;
		wc.cbWndExtra = 0;
		wc.hInstance = hInstance;
		wc.hIcon = LoadIcon(NULL, IDI_APPLICATION);
		wc.hCursor = NULL;
		wc.hbrBackground = cast(HBRUSH) GetStockObject(BLACK_BRUSH);
		wc.lpszMenuName = NULL;
		wc.lpszClassName = "gd_WindowClass"w.ptr;
		wc.hIconSm = LoadIcon(NULL, IDI_APPLICATION);

		if (!RegisterClassExW(&wc))
			throw new Win32Exception("RegisterClassExW", GetLastError());

		systemCursorMap[Cursors.Arrow] = new Win32Cursor(this, LoadCursor(null, IDC_ARROW), false);
		systemCursorMap[Cursors.ArrowLeft] = new Win32Cursor(this, LoadCursor(null, IDC_ARROW), false);
		// systemCursorMap[Cursors.ArrowCenter] = new Win32Cursor(this, LoadCursor(null, IDC_ARROW), false);
		systemCursorMap[Cursors.ColorPicker] = new Win32Cursor(this, LoadCursor(null, IDC_CROSS), false);
		systemCursorMap[Cursors.Handwriting] = new Win32Cursor(this, LoadCursor(null, MAKEINTRESOURCE_T!32_631), false);
		// systemCursorMap[Cursors.ContextMenu] = new Win32Cursor(this, LoadCursor(null, IDC_ARROW), false);
		systemCursorMap[Cursors.Crosshair] = new Win32Cursor(this, LoadCursor(null, IDC_CROSS), false);
		systemCursorMap[Cursors.Hand] = new Win32Cursor(this, LoadCursor(null, IDC_HAND), false);
		systemCursorMap[Cursors.Help] = new Win32Cursor(this, LoadCursor(null, IDC_HELP), false);
		systemCursorMap[Cursors.Move] = new Win32Cursor(this, LoadCursor(null, IDC_SIZEALL), false);
		systemCursorMap[Cursors.NoDrop] = new Win32Cursor(this, LoadCursor(null, IDC_NO), false);
		systemCursorMap[Cursors.None] = new Win32Cursor(this, null, false);
		systemCursorMap[Cursors.NotAllowed] = new Win32Cursor(this, LoadCursor(null, IDC_NO), false);
		systemCursorMap[Cursors.Pan] = new Win32Cursor(this, LoadCursor(null, IDC_SIZEALL), false);
		systemCursorMap[Cursors.Progress] = new Win32Cursor(this, LoadCursor(null, IDC_APPSTARTING), false);
		systemCursorMap[Cursors.ResizeN] = new Win32Cursor(this, LoadCursor(null, IDC_SIZENS), false);
		systemCursorMap[Cursors.ResizeW] = new Win32Cursor(this, LoadCursor(null, IDC_SIZEWE), false);
		systemCursorMap[Cursors.ResizeS] = new Win32Cursor(this, LoadCursor(null, IDC_SIZENS), false);
		systemCursorMap[Cursors.ResizeE] = new Win32Cursor(this, LoadCursor(null, IDC_SIZEWE), false);
		systemCursorMap[Cursors.ResizeNE] = new Win32Cursor(this, LoadCursor(null, IDC_SIZENESW), false);
		systemCursorMap[Cursors.ResizeNW] = new Win32Cursor(this, LoadCursor(null, IDC_SIZENWSE), false);
		systemCursorMap[Cursors.ResizeSW] = new Win32Cursor(this, LoadCursor(null, IDC_SIZENESW), false);
		systemCursorMap[Cursors.ResizeSE] = new Win32Cursor(this, LoadCursor(null, IDC_SIZENWSE), false);
		systemCursorMap[Cursors.ResizeNS] = new Win32Cursor(this, LoadCursor(null, IDC_SIZENS), false);
		systemCursorMap[Cursors.ResizeEW] = new Win32Cursor(this, LoadCursor(null, IDC_SIZEWE), false);
		systemCursorMap[Cursors.ResizeNESW] = new Win32Cursor(this, LoadCursor(null, IDC_SIZENESW), false);
		systemCursorMap[Cursors.ResizeNWSE] = new Win32Cursor(this, LoadCursor(null, IDC_SIZENWSE), false);
		systemCursorMap[Cursors.Text] = new Win32Cursor(this, LoadCursor(null, IDC_IBEAM), false);
		systemCursorMap[Cursors.Wait] = new Win32Cursor(this, LoadCursor(null, IDC_WAIT), false);

		void initSystemCursor(string file)(Cursors name, IVec2 hotspot, bool xor = false) {
			import imageformats : read_png_from_mem, IFImage;

			IFImage img = read_png_from_mem(cast(ubyte[]) import("gd-cursors/" ~ file), 4);
			if (xor)
				systemCursorMap[name] = Win32Display.createXorCursor(IVec2(img.w, img.h), cast(uint[]) img.pixels, hotspot);
			else
				systemCursorMap[name] = Win32Display.createCursor(IVec2(img.w, img.h), cast(uint[]) img.pixels, hotspot);
		}

		initSystemCursor!"cell.png"(Cursors.Cell, IVec2(16, 16));
		initSystemCursor!"aero_copy.png"(Cursors.Copy, IVec2(10, 7));
		initSystemCursor!"aero_grab2.png"(Cursors.Grab, IVec2(17, 21));
		initSystemCursor!"aero_grabbing.png"(Cursors.Grabbing, IVec2(16, 16));
		initSystemCursor!"aero_alias.png"(Cursors.Link, IVec2(6, 1));
		initSystemCursor!"splitv.png"(Cursors.SplitVertical, IVec2(16, 16), true);
		initSystemCursor!"splith.png"(Cursors.SplitHorizontal, IVec2(16, 16), true);
		initSystemCursor!"sizev.png"(Cursors.ResizeRow, IVec2(16, 16), true);
		initSystemCursor!"sizeh.png"(Cursors.ResizeColumn, IVec2(16, 16), true);
		initSystemCursor!"aero_zoom-in.png"(Cursors.ZoomIn, IVec2(14, 14));
		initSystemCursor!"aero_zoom-out.png"(Cursors.ZoomOut, IVec2(14, 14));

		// TODO: generate ArrowRight and VerticalText at runtime
		initSystemCursor!"aero_right_arrow.png"(Cursors.ArrowRight, IVec2(21, 7));
		initSystemCursor!"beam_i_vertical.png"(Cursors.VerticalText, IVec2(16, 16), true);

		qwerty = LoadKeyboardLayoutA("00000409", 0);
	}

	protected override void disposeImpl() {
		if (qwerty) UnloadKeyboardLayout(qwerty);
	}

	// TODO: SetThreadCursorCreationScaling for multi-monitor DPI awareness
	package HICON loadHIcon(IVec2 size, const(uint)[] data, Nullable!IVec2 hotspot = Nullable!IVec2()) {
		import std.range : iota, retro;

		assert(data.length == size.x * cast(size_t) size.y);
		assert(size.x > 0 && size.y > 0 && size.x <= 256 && size.y <= 256);

		struct LOCALHEADER {
		align(1):
			WORD xHotSpot;
			WORD yHotSpot;
		}

		ubyte[] memory = new ubyte[]((hotspot.isNull ? 0 : LOCALHEADER.sizeof)
			+ BITMAPINFOHEADER.sizeof + data.length * 2 * uint.sizeof);

		uint[] transformed = cast(uint[])(memory[(hotspot.isNull ? 0 : LOCALHEADER.sizeof)
			+ BITMAPINFOHEADER.sizeof .. $]);
		size_t index = 0;
		foreach (y; iota(0, size.y).retro) {
			foreach (x; 0 .. size.x) {
				uint color = data[index]; // stored as RGBA
				transformed[y * size.x + x] = // swap to BGRA
					color & 0xFF_00_FF_00u
					| color >> 16 & 0xFF
					| (color & 0xFF) << 16
					;
				index += 1;
			}
		}

		foreach (i; 0 .. data.length) {
			transformed[i + data.length] = 0xFF_FF_FF_FF;
		}

		if (!hotspot.isNull) {
			LOCALHEADER* localHeader = cast(LOCALHEADER*) memory.ptr;
			localHeader.xHotSpot = cast(WORD) hotspot.get.x;
			localHeader.yHotSpot = cast(WORD) hotspot.get.y;
		}

		BITMAPINFOHEADER* header = cast(BITMAPINFOHEADER*)(memory.ptr + (hotspot.isNull ? 0 : LOCALHEADER.sizeof));
		header.biSize = BITMAPINFOHEADER.sizeof;
		header.biWidth = size.x;
		header.biHeight = size.y * 2;
		header.biPlanes = 1;
		header.biBitCount = 32;
		header.biCompression = BI_RGB;

		HICON hIcon = CreateIconFromResourceEx(
			memory.ptr, cast(uint) memory.length,
			hotspot.isNull,
			0x00030000,
			size.x, size.y,
			LR_DEFAULTCOLOR,
		);

		if (hIcon is null)
			throw new Win32Exception("CreateIconFromResourceEx", GetLastError());

		return hIcon;
	}

	override Win32Window createWindow(WindowInitOptions options) {
		Win32Window window = new Win32Window(this, options);
		windowMap[window.hwnd] = window;

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

	override Win32Cursor createCursor(IVec2 size, const(uint)[] data, IVec2 hotspot) {
		assert(hotspot.x >= 0 && hotspot.y >= 0 && hotspot.x < size.x && hotspot.y < size.y);

		return new Win32Cursor(this, loadHIcon(size, data, hotspot.nullable), true);
	}

	override Win32Cursor createXorCursor(IVec2 size, const(uint)[] data, IVec2 hotspot) {
		assert(data.length == size.x * cast(size_t) size.y);
		assert(size.x > 0 && size.y > 0 && size.x <= 256 && size.y <= 256);
		assert(hotspot.x >= 0 && hotspot.y >= 0 && hotspot.x < size.x && hotspot.y < size.y);

		size_t xorStride = (size.x + 31 & ~31) >> 3;
		size_t andStride = (size.x + 31 & ~31) >> 3;

		ubyte[] memory = new ubyte[]((xorStride + andStride) * size.y);

		ubyte[] xorMask = memory[0 .. xorStride * size.y];
		ubyte[] andMask = memory[xorStride * size.y .. $];
		foreach (y; 0 .. size.y) {
			foreach (x; 0 .. size.x) {
				// I don't know why, but we *don't* need to flip the image vertically here
				uint color = data[size.x * y + x]; // stored as RGBA

				andMask[andStride * y + x / 8] |= 1 << (7 - x % 8); // the whole image should be transparent

				if (color >> 24) { // if alpha is nonzero
					xorMask[xorStride * y + x / 8] |= 1 << (7 - x % 8); // then invert this pixel
				}
			}
		}

		HCURSOR hCursor = CreateCursor(
			null,
			hotspot.x, hotspot.y,
			size.x, size.y,
			andMask.ptr, xorMask.ptr,
		);

		if (hCursor is null)
			throw new Win32Exception("CreateCursor", GetLastError());

		return new Win32Cursor(this, hCursor, true);
	}

	override Modifiers getCurrentModifiers() {
		Modifiers mods;

		if (GetKeyState(VK_CONTROL) & 0x8000) mods |= Modifiers.Ctrl;
		if (GetKeyState(VK_SHIFT) & 0x8000) mods |= Modifiers.Shift;
		if (GetKeyState(VK_MENU) & 0x8000) mods |= Modifiers.Alt;
		if ((GetKeyState(VK_LWIN) & 0x8000) || (GetKeyState(VK_RWIN) & 0x8000)) mods |= Modifiers.Super;
		// TODO: AltGr
		if (GetKeyState(VK_NUMLOCK) & 1) mods |= Modifiers.NumLock;
		if (GetKeyState(VK_SCROLL) & 1) mods |= Modifiers.ScrollLock;
		if (GetKeyState(VK_CAPITAL) & 1) mods |= Modifiers.CapsLock;

		return mods;
	}

	private bool[Win32Window] activeWindows;
	override bool isActive() {
		return activeWindows.length > 0;
	}

	package(gd.system) IRect[Win32Window] invalidationQueue;

	override void deactivate() {
		import std.array : array;

		foreach (win; activeWindows.byKey.array) {
			win.state = win.state & ~WindowState.Visible;
		}

		invalidationQueue = null;
	}

	private void updateInvalidatedRegions() {
		IRect[Win32Window] oldQueue = invalidationQueue;
		invalidationQueue = null;

		foreach (win, region; oldQueue) {
			win.updateRegion(region);
		}
	}

	override void processEvents() {
		updateInvalidatedRegions();
	}

}
