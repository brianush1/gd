module gd.system.x11.keycode;
import gd.bindings.x11;
import gd.keycode;

KeyCode keySymToKeyCode(X11.KeySym key) {
	switch (key) {

		// function keys:

		case X11.XK_F1: .. case X11.XK_F20:
			return cast(KeyCode)(KeyCode.f1 + (key - X11.XK_F1));

		// digits and alphabet:

		case X11.XK_0: .. case X11.XK_9:
			return cast(KeyCode)(KeyCode.d0 + (key - X11.XK_0));
		case X11.XK_a: .. case X11.XK_z:
			return cast(KeyCode)(KeyCode.a + (key - X11.XK_a));
		case X11.XK_A: .. case X11.XK_Z:
			return cast(KeyCode)(KeyCode.a + (key - X11.XK_A));

		case X11.XK_exclam: return KeyCode.exclamation;
		case X11.XK_at: return KeyCode.at;
		case X11.XK_numbersign: return KeyCode.hash;
		case X11.XK_dollar: return KeyCode.dollar;
		case X11.XK_percent: return KeyCode.percent;
		case X11.XK_asciicircum: return KeyCode.caret;
		case X11.XK_ampersand: return KeyCode.ampersand;
		case X11.XK_asterisk: return KeyCode.asterisk;
		case X11.XK_parenleft: return KeyCode.leftParenthesis;
		case X11.XK_parenright: return KeyCode.rightParenthesis;

		// locks:

		case X11.XK_Num_Lock: return KeyCode.numLock;
		case X11.XK_Caps_Lock: return KeyCode.capsLock;
		case X11.XK_Scroll_Lock: return KeyCode.scrollLock;

		// non-printable keys:

		case X11.XK_Escape: return KeyCode.escape;
		case X11.XK_Print: return KeyCode.printScreen;
		case X11.XK_Insert: return KeyCode.insert;
		case X11.XK_Delete: return KeyCode.delete_;
		case X11.XK_Home: return KeyCode.home;
		case X11.XK_End: return KeyCode.end;
		case X11.XK_Page_Up: return KeyCode.pageUp;
		case X11.XK_Page_Down: return KeyCode.pageDown;
		case X11.XK_BackSpace: return KeyCode.backspace;
		case X11.XK_Return: return KeyCode.enter;
		case X11.XK_Tab: return KeyCode.tab;
		case X11.XK_Left: return KeyCode.left;
		case X11.XK_Right: return KeyCode.right;
		case X11.XK_Up: return KeyCode.up;
		case X11.XK_Down: return KeyCode.down;

		// modifier keys:

		case X11.XK_Shift_L: return KeyCode.leftShift;
		case X11.XK_Shift_R: return KeyCode.rightShift;
		case X11.XK_Control_L: return KeyCode.leftCtrl;
		case X11.XK_Control_R: return KeyCode.rightCtrl;
		case X11.XK_Alt_L: return KeyCode.leftAlt;
		case X11.XK_Alt_R: return KeyCode.rightAlt;
		case X11.XK_Super_L: return KeyCode.leftSuper;
		case X11.XK_Super_R: return KeyCode.rightSuper;
		case X11.XK_Hyper_L: return KeyCode.leftHyper;
		case X11.XK_Hyper_R: return KeyCode.rightHyper;
		case X11.XK_Meta_L: return KeyCode.leftMeta;
		case X11.XK_Meta_R: return KeyCode.rightMeta;

		// miscellaneous printable keys:

		case X11.XK_grave: return KeyCode.backtick;
		case X11.XK_minus: return KeyCode.minus;
		case X11.XK_equal: return KeyCode.equals;
		case X11.XK_bracketleft: return KeyCode.leftSquareBracket;
		case X11.XK_bracketright: return KeyCode.rightSquareBracket;
		case X11.XK_backslash: return KeyCode.backslash;
		case X11.XK_semicolon: return KeyCode.semicolon;
		case X11.XK_apostrophe: return KeyCode.apostrophe;
		case X11.XK_comma: return KeyCode.comma;
		case X11.XK_period: return KeyCode.period;
		case X11.XK_slash: return KeyCode.slash;
		case X11.XK_space: return KeyCode.space;

		case X11.XK_asciitilde: return KeyCode.tilde;
		case X11.XK_underscore: return KeyCode.underscore;
		case X11.XK_plus: return KeyCode.plus;
		case X11.XK_braceleft: return KeyCode.leftBrace;
		case X11.XK_braceright: return KeyCode.rightBrace;
		case X11.XK_bar: return KeyCode.bar;
		case X11.XK_colon: return KeyCode.colon;
		case X11.XK_quotedbl: return KeyCode.quote;
		case X11.XK_less: return KeyCode.lesserSign;
		case X11.XK_greater: return KeyCode.greaterSign;
		case X11.XK_question: return KeyCode.questionMark;

		// miscellaneous non-printable keys:

		case X11.XK_Menu: return KeyCode.contextMenu;
		case X11.XK_Multi_key: return KeyCode.compose;
		case X11.XK_Pause: return KeyCode.pause;
		case X11.XK_dead_greek: return KeyCode.deadGreek;

		// numpad:

		case X11.XK_KP_0: .. case X11.XK_KP_9:
			return cast(KeyCode)(KeyCode.np0 + (key - X11.XK_KP_0));

		case X11.XK_KP_Divide: return KeyCode.npDivide;
		case X11.XK_KP_Multiply: return KeyCode.npMultiply;
		case X11.XK_KP_Subtract: return KeyCode.npMinus;
		case X11.XK_KP_Add: return KeyCode.npPlus;
		case X11.XK_KP_Decimal: return KeyCode.npPeriod;
		case X11.XK_KP_Enter: return KeyCode.npEnter;

		case X11.XK_KP_Insert: return KeyCode.npInsert;
		case X11.XK_KP_End: return KeyCode.npEnd;
		case X11.XK_KP_Down: return KeyCode.npDown;
		case X11.XK_KP_Page_Down: return KeyCode.npPageDown;
		case X11.XK_KP_Left: return KeyCode.npLeft;
		case X11.XK_KP_Begin: return KeyCode.npBegin;
		case X11.XK_KP_Right: return KeyCode.npRight;
		case X11.XK_KP_Home: return KeyCode.npHome;
		case X11.XK_KP_Up: return KeyCode.npUp;
		case X11.XK_KP_Page_Up: return KeyCode.npPageUp;
		case X11.XK_KP_Delete: return KeyCode.npDelete;

		//

		default: return KeyCode.unknown;

	}
}
