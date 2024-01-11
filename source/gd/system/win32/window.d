module gd.system.win32.window;
import gd.system.win32.display;
import gd.system.win32.exception;
import gd.system.display;
import gd.system.window;
import gd.resource;
import gd.graphics.color;
import gd.keycode;
import gd.cursor;
import gd.math;
import std.typecons;
import std.exception;
import std.conv;

version (gd_Win32):

import core.sys.windows.windows;
import gd.bindings.gl;
import gd.bindings.loader;

private {
	const(wchar)* toWStr(string str) {
		wchar[] slice = str.to!(wchar[]) ~ cast(wchar) 0;
		return slice.ptr;
	}

	enum WGL_CONTEXT_MAJOR_VERSION_ARB = 0x2091;
	enum WGL_CONTEXT_MINOR_VERSION_ARB = 0x2092;
	enum WGL_CONTEXT_LAYER_PLANE_ARB = 0x2093;
	enum WGL_CONTEXT_FLAGS_ARB = 0x2094;
	enum WGL_CONTEXT_PROFILE_MASK_ARB = 0x9126;

	enum WGL_CONTEXT_DEBUG_BIT_ARB = 0x0001;
	enum WGL_CONTEXT_FORWARD_COMPATIBLE_BIT_ARB = 0x0002;

	enum WGL_CONTEXT_CORE_PROFILE_BIT_ARB = 0x00000001;
	enum WGL_CONTEXT_COMPATIBILITY_PROFILE_BIT_ARB = 0x00000002;

	alias wglCreateContextAttribsARB_t = extern (Windows) HGLRC function(HDC hDC, HGLRC hShareContext, const(int)* attribList);
	__gshared wglCreateContextAttribsARB_t wglCreateContextAttribsARB;
}

class Win32Pointer : Pointer {

	private Win32Window window;

	private this(Win32Window window) {
		scope (failure) dispose();

		this.window = window;
		addDependency(window);

		RAWINPUTDEVICE rid;
		rid.usUsagePage = 0x01;
		rid.usUsage = 0x02;
		rid.dwFlags = 0;
		rid.hwndTarget = window.hwnd;
		RegisterRawInputDevices(&rid, 1, RAWINPUTDEVICE.sizeof);

		updateFlags();
	}

	protected override void disposeImpl() {}

	private void updateFlags() {
		PointerFlags flags = cast(PointerFlags) 0
			| PointerFlags.CanSetPosition
			| PointerFlags.HasScreenPosition
			| PointerFlags.RelativeMotion
			| PointerFlags.CanConstrain;

		m_flags = flags;
		onFlagsChange.emit(m_flags);
	}

	private PointerFlags m_flags;
	override PointerFlags flags() const @property { return m_flags; }

	override Vec2 position() const @property {
		POINT pos;
		GetCursorPos(&pos);
		ScreenToClient((cast() this).window.hwnd, &pos);

		return Vec2(pos.x, pos.y);
	}

	override void position(Vec2 newPosition) @property {
		POINT pos = POINT(cast(int) newPosition.x, cast(int) newPosition.y);
		ClientToScreen((cast() this).window.hwnd, &pos);
		SetCursorPos(pos.x, pos.y);
	}

	override double pressure() const @property { return 1; } // TODO: implement

	override Vec2 tilt() const @property { return Vec2(0, 0); } // TODO: implement

	private Win32Cursor m_cursor;
	override void cursor(Cursor value_) @property {
		Win32Cursor value = cast(Win32Cursor) value_;
		enforce!Win32Exception(value, "can't pass non-X11 cursor to X11 pointer");

		m_cursor = value;
		SetCursor(value.hCursor);
	}

	override void cursor(Cursors value) @property {
		if (value !in window.display.systemCursorMap)
			value = Cursors.Arrow;

		cursor = window.display.systemCursorMap[value];
	}

	private {
		bool lockedInPlace;
		bool inWindow;
		bool captured;
	}

	override void lockInPlace() {
		if (lockedInPlace)
			return;

		lockedInPlace = true;

		POINT pos;
		GetCursorPos(&pos);

		RECT rect;
		rect.left = pos.x;
		rect.top = pos.y;
		rect.right = pos.x + 1;
		rect.bottom = pos.y + 1;
		ClipCursor(&rect);
	}

	override void removeConstraint() {
		if (!lockedInPlace)
			return;

		lockedInPlace = false;

		ClipCursor(null);
	}

}

class Win32Window : Window {
private:
	Win32Display m_display;
	public inout(Win32Display) display() inout @property { return m_display; }

	bool createdHWND;
	HWND m_hwnd;
	public inout(HWND) hwnd() inout @property { return m_hwnd; }

	int style;

	HDC hdc;
	HGLRC wglContext;

	package this(Win32Display display, WindowInitOptions options) {
		scope (failure) dispose();

		m_display = display;

		addDependency(display);

		style = WS_OVERLAPPEDWINDOW;

		// TODO: implement resizability
		// if (!options.resizable)
		// 	style ^= WS_THICKFRAME | WS_MAXIMIZEBOX;

		RECT rect = RECT(0, 0, options.size.x, options.size.y);
		AdjustWindowRect(&rect, style, FALSE);

		m_title = options.title;
		m_hwnd = CreateWindowExW(
			0,
			"gd_WindowClass".toWStr, // TODO: custom window class support
			options.title.toWStr,
			style,
			options.position.isNull ? CW_USEDEFAULT : options.position.get.x,
			options.position.isNull ? CW_USEDEFAULT : options.position.get.y,
			rect.right - rect.left,
			rect.bottom - rect.top,
			GetDesktopWindow(),
			null, display.hInstance, null,
		);
		createdHWND = true;

		SetWindowLongPtrW(hwnd, GWLP_USERDATA, cast(LONG_PTR) cast(void*) this);

		hdc = GetDC(hwnd);

		PIXELFORMATDESCRIPTOR pfd;
		pfd.nSize = PIXELFORMATDESCRIPTOR.sizeof;
		pfd.nVersion = 1;
		pfd.dwFlags = PFD_DRAW_TO_WINDOW | PFD_SUPPORT_OPENGL | PFD_DOUBLEBUFFER;
		pfd.dwLayerMask = PFD_MAIN_PLANE;
		pfd.iPixelType = PFD_TYPE_RGBA;
		pfd.cColorBits = 24;
		pfd.cDepthBits = 24; // cast(ubyte) options.depthSize;
		pfd.cAccumBits = 0;
		pfd.cStencilBits = 8;

		int pixelFormat = ChoosePixelFormat(hdc, &pfd);

		if (pixelFormat == 0)
			throw new Win32Exception("ChoosePixelFormat", GetLastError());

		if (SetPixelFormat(hdc, pixelFormat, &pfd) == 0)
			throw new Win32Exception("SetPixelFormat", GetLastError());

		if (wglCreateContextAttribsARB is null) {
			// we need a context in order to get the function address, so we make a dummy context

			HGLRC dummy = wglCreateContext(hdc);
			if (dummy !is null) {
				wglMakeCurrent(hdc, dummy);
				wglCreateContextAttribsARB = cast(wglCreateContextAttribsARB_t) wglGetProcAddress("wglCreateContextAttribsARB");
				wglMakeCurrent(hdc, null);
				wglDeleteContext(dummy);
			}
		}

		if (!wglCreateContextAttribsARB)
			throw new Win32Exception("could not get address of wglCreateContextAttribsARB");

		int[9] contextAttribs = [
			WGL_CONTEXT_MAJOR_VERSION_ARB, options.glVersionMajor,
			WGL_CONTEXT_MINOR_VERSION_ARB, options.glVersionMinor,
			WGL_CONTEXT_PROFILE_MASK_ARB, WGL_CONTEXT_CORE_PROFILE_BIT_ARB,
			WGL_CONTEXT_FLAGS_ARB, WGL_CONTEXT_FORWARD_COMPATIBLE_BIT_ARB,
			0,
		];

		wglContext = wglCreateContextAttribsARB(hdc, null, contextAttribs.ptr);

		if (wglContext is null)
			throw new Win32Exception("wglCreateContextAttribsARB", GetLastError());

		assert(!(options.initialState & WindowState.Visible),
			"window cannot be visible on creation, since a paint handler ought to be set when the window is first shown");
		state = options.initialState; // set initial state

		m_primaryPointer = new Win32Pointer(this);
		m_primaryPointer.cursor = Cursors.Arrow;
	}

	protected override void disposeImpl() {
		if (currentHIcon !is null)
			DestroyIcon(currentHIcon);

		if (wglContext) {
			wglMakeCurrent(hdc, null);
			wglDeleteContext(wglContext);
		}

		if (hdc) ReleaseDC(hwnd, hdc);

		if (createdHWND) DestroyWindow(hwnd);
	}

	void checkWindowSize() {
		RECT r;
		if (GetClientRect(hwnd, &r)) {
			import std.algorithm : max;

			IVec2 newSize;
			newSize.x = max(1, cast(int)(r.right - r.left));
			newSize.y = max(1, cast(int)(r.bottom - r.top));
			if (newSize != m_size) {
				m_size = newSize;
				onSizeChange.emit(m_size);
			}
		}
	}

public:

	private Win32Pointer m_primaryPointer;
	override inout(Pointer)[] pointers() inout @property { return [m_primaryPointer]; }

	private HICON currentHIcon;
	override void setIcon(IVec2 size, const(uint)[] data) {
		if (currentHIcon !is null)
			DestroyIcon(currentHIcon);

		currentHIcon = display.loadHIcon(size, data);
		SendMessageA(hwnd, WM_SETICON, ICON_SMALL, cast(LPARAM) currentHIcon);
	}

	private PaintHandler m_paintHandler;
	override void setPaintHandler(PaintHandler handler) {
		m_paintHandler = handler;
	}

	override void invalidate(IRect region) {
		RECT rect;
		rect.left = region.left;
		rect.top = region.top;
		rect.right = region.right;
		rect.bottom = region.bottom;
		InvalidateRect(hwnd, &rect, false);
	}

	override void makeContextCurrent() {
		wglMakeCurrent(hdc, wglContext);
	}

	void repaintImmediately() {
		if (m_paintHandler is null) {
			return;
		}

		makeContextCurrent();
		m_paintHandler();

		SwapBuffers(hdc);
	}

	private string m_title;
	override string title() const @property { return m_title; }
	override void title(string value) @property {
		m_title = value;
		SetWindowTextW(hwnd, value.toWStr);
	}

	private IVec2 m_size;
	override IVec2 size() const @property { return m_size; }
	override void size(IVec2 value) @property {
		RECT rect;
		GetWindowRect(hwnd, &rect);
		IVec2 pos = IVec2(rect.left, rect.top);

		rect = RECT(0, 0, value.x, value.y);
		AdjustWindowRect(&rect, style, FALSE);
		MoveWindow(hwnd,
			/* position */ pos.x, pos.y,
			/* size */ rect.right - rect.left, rect.bottom - rect.top,
			/* repaint */ TRUE,
		);
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

		if ((add | remove) & WindowState.Attention) {
			// TODO: what happens if we hide the window while it has attention,
			// and then show it again? I'm guessing the flash is probably lost.
			// do we wanna recreate the flash when the window is re-shown?
			FLASHWINFO info;
			info.cbSize = FLASHWINFO.sizeof;
			info.hwnd = hwnd;
			info.dwFlags = (remove & WindowState.Attention) ? FLASHW_STOP : (FLASHW_TRAY | FLASHW_TIMER);
			info.uCount = 0;
			info.dwTimeout = 0;
			FlashWindowEx(&info);
		}

		if ((add | remove) & WindowState.Topmost) {
			SetWindowPos(hwnd, (remove & WindowState.Topmost) ? HWND_NOTOPMOST : HWND_TOPMOST,
				0, 0, 0, 0, SWP_NOMOVE | SWP_NOSIZE);
		}

		if ((add | remove) & WindowState.Fullscreen) {
			if (remove & WindowState.Fullscreen) {
				style = WS_OVERLAPPEDWINDOW;
			}
			else {
				style = WS_POPUP | WS_SYSMENU;
			}

			SetWindowLongPtrA(hwnd, GWL_STYLE, style);
		}

		if (add & WindowState.Visible) {
			if (value & WindowState.Minimized) {
				ShowWindow(hwnd, SW_SHOWMINIMIZED);
			}
			else if (value & (WindowState.Maximized | WindowState.Fullscreen)) {
				ShowWindow(hwnd, SW_SHOWMAXIMIZED);
			}
			else {
				ShowWindow(hwnd, SW_SHOWNORMAL);
			}
		}
		else if (remove & WindowState.Visible) {
			ShowWindow(hwnd, SW_HIDE);
		}
		else if (value & WindowState.Visible) {
			// we need a bit of custom logic, because we wanna let users of the library
			// set a window to be both maximized and minimized at the same time, meaning
			// that the window is minimized but will be maximized when the user restores
			// it from the taskbar
			if (add & WindowState.Minimized) {
				ShowWindow(hwnd, SW_MINIMIZE);
			}
			else if (add & (WindowState.Maximized | WindowState.Fullscreen)) {
				ShowWindow(hwnd, SW_MAXIMIZE);
			}
			else if (remove & WindowState.Minimized) {
				if (value & (WindowState.Maximized | WindowState.Fullscreen))
					ShowWindow(hwnd, SW_MAXIMIZE);
				else
					ShowWindow(hwnd, SW_NORMAL);
			}
			else if (remove & (WindowState.Maximized | WindowState.Fullscreen)) {
				if (!(value & WindowState.Minimized))
					ShowWindow(hwnd, SW_RESTORE);
			}
		}
	}

}

private {
	enum WM_MOUSEHWHEEL = 526;
	enum WM_TOUCH = 0x0240;

	enum TOUCHEVENTF_MOVE = 0x0001;
	enum TOUCHEVENTF_DOWN = 0x0002;
	enum TOUCHEVENTF_UP = 0x0004;
	enum TOUCHEVENTF_INRANGE = 0x0008;
	enum TOUCHEVENTF_PRIMARY = 0x0010;
	enum TOUCHEVENTF_NOCOALESCE = 0x0020;
	enum TOUCHEVENTF_PEN = 0x0040;
	enum TOUCHEVENTF_PALM = 0x0080;

	struct TOUCHINPUT {
	align(1): // is this correct?
		LONG x;
		LONG y;
		HANDLE hSource;
		DWORD dwID;
		DWORD dwFlags;
		DWORD dwMask;
		DWORD dwTime;
		ULONG_PTR dwExtraInfo;
		DWORD cxContact;
		DWORD cyContact;
	}

	extern (Windows) {
		BOOL GetTouchInputInfo(HANDLE hTouchInput, UINT cInputs, TOUCHINPUT* pInputs, int cbSize);
		BOOL CloseTouchInputHandle(HANDLE hTouchInput);
	}

}

extern (Windows) LRESULT win32WindowWndProc(HWND hwnd, UINT Msg, WPARAM wParam, LPARAM lParam) nothrow {
	return safeCall(&wndProcD, hwnd, Msg, wParam, lParam);
}

private LRESULT wndProcD(HWND hwnd, UINT Msg, WPARAM wParam, LPARAM lParam) {
	Win32Window self = cast(Win32Window) cast(void*) GetWindowLongPtrW(hwnd, GWLP_USERDATA);

	if (self is null)
		return DefWindowProc(hwnd, Msg, wParam, lParam);

	switch (Msg) {
	case WM_SETFOCUS:
		self.state = self.state & ~WindowState.Attention;
		self.onFocusEnter.emit();
		break;
	case WM_KILLFOCUS:
		self.onFocusLeave.emit();
		break;
	case WM_SYSCOMMAND:
		switch (wParam) {
			case SC_MINIMIZE:
				self.state = self.state | WindowState.Minimized;
				return 0;
			case SC_MAXIMIZE:
				self.state = self.state & ~WindowState.Minimized | WindowState.Maximized;
				return 0;
			case SC_RESTORE:
				if (self.state & WindowState.Minimized) {
					self.state = self.state & ~WindowState.Minimized;
				}
				else if (self.state & WindowState.Maximized) {
					self.state = self.state & ~WindowState.Maximized;
				}

				return 0;
			default:
				break;
		}

		break;
	case WM_CLOSE:
		self.onCloseRequest.emit();
		return 0;
	case WM_SIZE:
		if (wParam == SIZE_MAXIMIZED) {
			self.state = self.state | WindowState.Maximized;
		}
		else if (wParam == SIZE_RESTORED) {
			self.state = self.state & ~WindowState.Maximized;
		}

		goto case;
	case WM_SIZING:
	case WM_ENTERSIZEMOVE:
	case WM_EXITSIZEMOVE:
		self.checkWindowSize();
		break;
	case WM_ERASEBKGND:
		return TRUE;
	case WM_PAINT:
		ValidateRect(hwnd, null);
		self.repaintImmediately();
		return 0;
	case WM_KEYDOWN:
	case WM_SYSKEYDOWN:
	case WM_KEYUP:
	case WM_SYSKEYUP:
		import gd.system.win32.keycode : vkeyToKeyCode;

		KeyInfo keyInfo;

		WPARAM vk = wParam;
		UINT scancode = (lParam >> 16) & 0xFF;
		int extended = (lParam >> 24) & 1;

		switch (wParam) {
		case VK_SHIFT:
			// for some reason, Microsoft decided shift doesn't deserve to use the extended bit
			vk = MapVirtualKey(scancode, MAPVK_VSC_TO_VK_EX);
			break;
		case VK_CONTROL:
			vk = extended ? VK_RCONTROL : VK_LCONTROL;
			break;
		case VK_MENU:
			vk = extended ? VK_RMENU : VK_LMENU;
			break;
		default:
			break;
		}

		keyInfo.logical = vkeyToKeyCode(vk);
		keyInfo.physical = vkeyToKeyCode(MapVirtualKeyEx(scancode, MAPVK_VSC_TO_VK_EX, self.display.qwerty));

		if (GetKeyState(VK_CONTROL) & 0x8000) keyInfo.mods |= Modifiers.Ctrl;
		if (GetKeyState(VK_SHIFT) & 0x8000) keyInfo.mods |= Modifiers.Shift;
		if (GetKeyState(VK_MENU) & 0x8000) keyInfo.mods |= Modifiers.Alt;
		if ((GetKeyState(VK_LWIN) & 0x8000) || (GetKeyState(VK_RWIN) & 0x8000)) keyInfo.mods |= Modifiers.Super;
		// TODO: AltGr
		if (GetKeyState(VK_NUMLOCK) & 1) keyInfo.mods |= Modifiers.NumLock;
		if (GetKeyState(VK_SCROLL) & 1) keyInfo.mods |= Modifiers.ScrollLock;
		if (GetKeyState(VK_CAPITAL) & 1) keyInfo.mods |= Modifiers.CapsLock;

		if (Msg == WM_KEYDOWN || Msg == WM_SYSKEYDOWN)
			self.onKeyPress.emit(keyInfo);
		else
			self.onKeyRelease.emit(keyInfo);
		break;
	case WM_LBUTTONDOWN:
	case WM_MBUTTONDOWN:
	case WM_RBUTTONDOWN:
	case WM_LBUTTONUP:
	case WM_MBUTTONUP:
	case WM_RBUTTONUP: // TODO: X1 and X2
		MouseButton button;

		if (Msg == WM_LBUTTONDOWN || Msg == WM_LBUTTONUP) button = MouseButton.Left;
		else if (Msg == WM_MBUTTONDOWN || Msg == WM_MBUTTONUP) button = MouseButton.Middle;
		else if (Msg == WM_RBUTTONDOWN || Msg == WM_RBUTTONUP) button = MouseButton.Right;

		if (Msg == WM_LBUTTONDOWN || Msg == WM_MBUTTONDOWN || Msg == WM_RBUTTONDOWN) {
			if (!self.m_primaryPointer.captured) {
				self.m_primaryPointer.captured = true;
				SetCapture(self.hwnd);
			}
			self.m_primaryPointer.onButtonPress.emit(button);
		}
		else {
			self.m_primaryPointer.onButtonRelease.emit(button);
			if (self.m_primaryPointer.captured) {
				self.m_primaryPointer.captured = false;
				ReleaseCapture();
			}
		}

		break;
	case WM_MOUSEMOVE:
		if (!self.m_primaryPointer.inWindow) {
			self.m_primaryPointer.inWindow = true;

			Win32Cursor cursor = self.m_primaryPointer.m_cursor;
			if (cursor)
				SetCursor(cursor.hCursor);

			self.m_primaryPointer.onEnter.emit();

			TRACKMOUSEEVENT track;
			track.cbSize = TRACKMOUSEEVENT.sizeof;
			track.dwFlags = TME_LEAVE;
			track.hwndTrack = self.hwnd;
			track.dwHoverTime = 0;

			TrackMouseEvent(&track);
		}

		self.m_primaryPointer.onPositionChange.emit(self.m_primaryPointer.position);
		break;
	case WM_MOUSELEAVE:
		self.m_primaryPointer.onLeave.emit();
		self.m_primaryPointer.inWindow = false;
		break;
	case WM_MOUSEWHEEL:
		// TODO: test that this works with smooth scrolling devices
		double delta = cast(short)(wParam >> 16 & 0xFFFF);
		self.m_primaryPointer.onScroll.emit(Vec2(0, -delta / 120.0));
		break;
	case WM_MOUSEHWHEEL:
		double delta = cast(short)(wParam >> 16 & 0xFFFF);
		self.m_primaryPointer.onScroll.emit(Vec2(delta / 120.0, 0));
		break;
	case WM_INPUT:
		import core.stdc.stdlib : alloca;

		UINT size;

		if (GetRawInputData(cast(HRAWINPUT) lParam, RID_INPUT, NULL, &size, RAWINPUTHEADER.sizeof) == -1)
			throw new Win32Exception("GetRawInputData", GetLastError());

		RAWINPUT* inputData = cast(RAWINPUT*) alloca(size);
		GetRawInputData(cast(HRAWINPUT) lParam, RID_INPUT, inputData, &size, RAWINPUTHEADER.sizeof);

		if ((inputData.data.mouse.usFlags & MOUSE_MOVE_ABSOLUTE) != MOUSE_MOVE_ABSOLUTE) {
			double dx = cast(double) inputData.data.mouse.lLastX;
			double dy = cast(double) inputData.data.mouse.lLastY;
			self.m_primaryPointer.onMotion.emit(Vec2(dx, dy));
		}

		break;
	case WM_TOUCH: // TODO: this is entirely untested!
		import core.stdc.stdlib : alloca;

		UINT cInputs = LOWORD(wParam);
		TOUCHINPUT* inputs = cast(TOUCHINPUT*) alloca(TOUCHINPUT.sizeof * cInputs);

		if (!GetTouchInputInfo(cast(HANDLE) lParam, cInputs, inputs, TOUCHINPUT.sizeof))
			throw new Win32Exception("GetTouchInputInfo", GetLastError());

		POINT clientOffset;
		clientOffset.x = 0;
		clientOffset.y = 0;
		ClientToScreen(self.hwnd, &clientOffset);

		foreach (ref input; inputs[0 .. cInputs]) {
			uint id = cast(uint) input.dwID;
			Vec2 pos = Vec2(
				cast(double) input.x / 100.0 - clientOffset.x,
				cast(double) input.y / 100.0 - clientOffset.y,
			);

			if ((input.dwFlags & TOUCHEVENTF_DOWN) == TOUCHEVENTF_DOWN)
				self.onTouchStart.emit(id, pos);

			if ((input.dwFlags & TOUCHEVENTF_MOVE) == TOUCHEVENTF_MOVE)
				self.onTouchMove.emit(id, pos);

			if ((input.dwFlags & TOUCHEVENTF_UP) == TOUCHEVENTF_UP)
				self.onTouchEnd.emit(id);
		}

		if (!CloseTouchInputHandle(cast(HANDLE) lParam))
			throw new Win32Exception("CloseTouchInputHandle", GetLastError());

		return 0;
	default:
		break;
	}

	return DefWindowProc(hwnd, Msg, wParam, lParam);
}
