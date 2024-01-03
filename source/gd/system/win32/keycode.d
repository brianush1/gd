module gd.system.win32.keycode;

version (gd_Win32):

import core.sys.windows.windows;
import gd.keycode;

KeyCode vkeyToKeyCode(WPARAM vk) {
	switch (vk) {
		case VK_SPACE: return KeyCode.Space;
		case VK_OEM_7: return KeyCode.Quote;
		case VK_OEM_COMMA: return KeyCode.Comma;
		case VK_OEM_MINUS: return KeyCode.Minus;
		case VK_OEM_PERIOD: return KeyCode.Period;
		case VK_OEM_2: return KeyCode.Slash;
		case '0': .. case '9': return cast(KeyCode)(KeyCode.D0 + cast(int)(vk - '0'));
		case VK_OEM_1: return KeyCode.Semicolon;
		case VK_OEM_PLUS: return KeyCode.Equals;
		case 'A': .. case 'Z': return cast(KeyCode)(KeyCode.A + cast(int)(vk - 'A'));
		case VK_OEM_4: return KeyCode.LeftSquareBracket;
		case VK_OEM_5: return KeyCode.Backslash;
		case VK_OEM_6: return KeyCode.RightSquareBracket;
		case VK_OEM_3: return KeyCode.Backtick;
		case VK_ESCAPE: return KeyCode.Escape;
		case VK_RETURN: return KeyCode.Enter;
		case VK_TAB: return KeyCode.Tab;
		case VK_BACK: return KeyCode.Backspace;
		case VK_INSERT: return KeyCode.Insert;
		case VK_DELETE: return KeyCode.Delete;
		case VK_RIGHT: return KeyCode.Right;
		case VK_LEFT: return KeyCode.Left;
		case VK_DOWN: return KeyCode.Down;
		case VK_UP: return KeyCode.Up;
		case VK_PRIOR: return KeyCode.PageUp;
		case VK_NEXT: return KeyCode.PageDown;
		case VK_HOME: return KeyCode.Home;
		case VK_END: return KeyCode.End;
		case VK_CAPITAL: return KeyCode.CapsLock;
		case VK_SCROLL: return KeyCode.ScrollLock;
		case VK_NUMLOCK: return KeyCode.NumLock;
		case VK_SNAPSHOT: return KeyCode.PrintScreen;
		case VK_PAUSE: return KeyCode.Pause;
		case VK_F1: .. case VK_F24: return cast(KeyCode)(KeyCode.F1 + cast(int)(vk - VK_F1));
		case VK_NUMPAD0: .. case VK_NUMPAD9: return cast(KeyCode)(KeyCode.Kp0 + cast(int)(vk - VK_NUMPAD0));
		case VK_DECIMAL: return KeyCode.KpPeriod;
		case VK_DIVIDE: return KeyCode.KpDivide;
		case VK_MULTIPLY: return KeyCode.KpMultiply;
		case VK_SUBTRACT: return KeyCode.KpMinus;
		case VK_ADD: return KeyCode.KpPlus;
		case VK_LSHIFT: return KeyCode.LeftShift;
		case VK_LCONTROL: return KeyCode.LeftCtrl;
		case VK_LMENU: return KeyCode.LeftAlt;
		case VK_LWIN: return KeyCode.LeftSuper;
		case VK_RSHIFT: return KeyCode.RightShift;
		case VK_RCONTROL: return KeyCode.RightCtrl;
		case VK_RMENU: return KeyCode.RightAlt;
		case VK_RWIN: return KeyCode.RightSuper;
		case VK_APPS: return KeyCode.ContextMenu;
		default: return KeyCode.Unknown;
	}
}
