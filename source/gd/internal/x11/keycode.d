module gd.internal.x11.keycode;

version (gd_X11Impl):

import gd.bindings.x11;
import gd.keycode;

KeyCode keySymToKeyCode(X11.KeySym key) {
	switch (key) {

		// function keys:

		case X11.XK_F1: .. case X11.XK_F20:
			return cast(KeyCode)(KeyCode.F1 + (key - X11.XK_F1));

		// digits and alphabet:

		case X11.XK_0: .. case X11.XK_9:
			return cast(KeyCode)(KeyCode.D0 + (key - X11.XK_0));
		case X11.XK_a: .. case X11.XK_z:
			return cast(KeyCode)(KeyCode.A + (key - X11.XK_a));
		case X11.XK_A: .. case X11.XK_Z:
			return cast(KeyCode)(KeyCode.A + (key - X11.XK_A));

		case X11.XK_exclam: return KeyCode.Exclamation;
		case X11.XK_at: return KeyCode.At;
		case X11.XK_numbersign: return KeyCode.Hash;
		case X11.XK_dollar: return KeyCode.Dollar;
		case X11.XK_percent: return KeyCode.Percent;
		case X11.XK_asciicircum: return KeyCode.Caret;
		case X11.XK_ampersand: return KeyCode.Ampersand;
		case X11.XK_asterisk: return KeyCode.Asterisk;
		case X11.XK_parenleft: return KeyCode.LeftParenthesis;
		case X11.XK_parenright: return KeyCode.RightParenthesis;

		// locks:

		case X11.XK_Num_Lock: return KeyCode.NumLock;
		case X11.XK_Caps_Lock: return KeyCode.CapsLock;
		case X11.XK_Scroll_Lock: return KeyCode.ScrollLock;

		// non-printable keys:

		case X11.XK_Escape: return KeyCode.Escape;
		case X11.XK_Print: return KeyCode.PrintScreen;
		case X11.XK_Insert: return KeyCode.Insert;
		case X11.XK_Delete: return KeyCode.Delete;
		case X11.XK_Home: return KeyCode.Home;
		case X11.XK_End: return KeyCode.End;
		case X11.XK_Page_Up: return KeyCode.PageUp;
		case X11.XK_Page_Down: return KeyCode.PageDown;
		case X11.XK_BackSpace: return KeyCode.Backspace;
		case X11.XK_Return: return KeyCode.Enter;
		case X11.XK_Tab: return KeyCode.Tab;
		case X11.XK_Left: return KeyCode.Left;
		case X11.XK_Right: return KeyCode.Right;
		case X11.XK_Up: return KeyCode.Up;
		case X11.XK_Down: return KeyCode.Down;

		// modifier keys:

		case X11.XK_Shift_L: return KeyCode.LeftShift;
		case X11.XK_Shift_R: return KeyCode.RightShift;
		case X11.XK_Control_L: return KeyCode.LeftCtrl;
		case X11.XK_Control_R: return KeyCode.RightCtrl;
		case X11.XK_Alt_L: return KeyCode.LeftAlt;
		case X11.XK_Alt_R: return KeyCode.RightAlt;
		case X11.XK_Super_L: return KeyCode.LeftSuper;
		case X11.XK_Super_R: return KeyCode.RightSuper;
		case X11.XK_Hyper_L: return KeyCode.LeftHyper;
		case X11.XK_Hyper_R: return KeyCode.RightHyper;
		case X11.XK_Meta_L: return KeyCode.LeftMeta;
		case X11.XK_Meta_R: return KeyCode.RightMeta;

		// miscellaneous printable keys:

		case X11.XK_grave: return KeyCode.Backtick;
		case X11.XK_minus: return KeyCode.Minus;
		case X11.XK_equal: return KeyCode.Equals;
		case X11.XK_bracketleft: return KeyCode.LeftSquareBracket;
		case X11.XK_bracketright: return KeyCode.RightSquareBracket;
		case X11.XK_backslash: return KeyCode.Backslash;
		case X11.XK_semicolon: return KeyCode.Semicolon;
		case X11.XK_apostrophe: return KeyCode.Apostrophe;
		case X11.XK_comma: return KeyCode.Comma;
		case X11.XK_period: return KeyCode.Period;
		case X11.XK_slash: return KeyCode.Slash;
		case X11.XK_space: return KeyCode.Space;

		case X11.XK_asciitilde: return KeyCode.Tilde;
		case X11.XK_underscore: return KeyCode.Underscore;
		case X11.XK_plus: return KeyCode.Plus;
		case X11.XK_braceleft: return KeyCode.LeftBrace;
		case X11.XK_braceright: return KeyCode.RightBrace;
		case X11.XK_bar: return KeyCode.Bar;
		case X11.XK_colon: return KeyCode.Colon;
		case X11.XK_quotedbl: return KeyCode.Quote;
		case X11.XK_less: return KeyCode.LesserSign;
		case X11.XK_greater: return KeyCode.GreaterSign;
		case X11.XK_question: return KeyCode.QuestionMark;

		// miscellaneous non-printable keys:

		case X11.XK_Menu: return KeyCode.ContextMenu;
		case X11.XK_Multi_key: return KeyCode.Compose;
		case X11.XK_Pause: return KeyCode.Pause;
		case X11.XK_dead_greek: return KeyCode.DeadGreek;

		// numpad:

		case X11.XK_KP_0: .. case X11.XK_KP_9:
			return cast(KeyCode)(KeyCode.Kp0 + (key - X11.XK_KP_0));

		case X11.XK_KP_Divide: return KeyCode.KpDivide;
		case X11.XK_KP_Multiply: return KeyCode.KpMultiply;
		case X11.XK_KP_Subtract: return KeyCode.KpMinus;
		case X11.XK_KP_Add: return KeyCode.KpPlus;
		case X11.XK_KP_Decimal: return KeyCode.KpPeriod;
		case X11.XK_KP_Enter: return KeyCode.KpEnter;

		case X11.XK_KP_Insert: return KeyCode.KpInsert;
		case X11.XK_KP_End: return KeyCode.KpEnd;
		case X11.XK_KP_Down: return KeyCode.KpDown;
		case X11.XK_KP_Page_Down: return KeyCode.KpPageDown;
		case X11.XK_KP_Left: return KeyCode.KpLeft;
		case X11.XK_KP_Begin: return KeyCode.KpBegin;
		case X11.XK_KP_Right: return KeyCode.KpRight;
		case X11.XK_KP_Home: return KeyCode.KpHome;
		case X11.XK_KP_Up: return KeyCode.KpUp;
		case X11.XK_KP_Page_Up: return KeyCode.KpPageUp;
		case X11.XK_KP_Delete: return KeyCode.KpDelete;

		//

		default: return KeyCode.Unknown;

	}
}
