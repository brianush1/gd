module gd.bindings.x11;
import gd.bindings.loader;
import gd.resource;
import core.stdc.config;
import core.stdc.stddef;

version (gd_X11Impl):

private static X11Library m_X11;
X11Library X11() @property { // @suppress(dscanner.confusing.function_attributes)
	if (m_X11 is null) {
		m_X11 = loadX11;
		registerLibraryResource(m_X11);
	}

	return m_X11;
}

X11Library loadX11() {
	string[] libraries;

	version (Posix) {
		libraries = ["libX11.so.6", "libX11.so"];
	}
	else {
		assert(0, "unsupported platform");
	}

	return loadSharedLibrary!(X11Library, delegate(string name) {
		return "X" ~ cast(char)(name[0] + 'A' - 'a') ~ name[1 .. $];
	})(libraries);
}

abstract class X11Library : Resource {
extern (System) @nogc nothrow:
	// file '/usr/include/X11/keysymdef.h'

	enum XK_VoidSymbol = 0xffffff;

	enum XK_BackSpace = 0xff08;
	enum XK_Tab = 0xff09;
	enum XK_Linefeed = 0xff0a;
	enum XK_Clear = 0xff0b;
	enum XK_Return = 0xff0d;
	enum XK_Pause = 0xff13;
	enum XK_Scroll_Lock = 0xff14;
	enum XK_Sys_Req = 0xff15;
	enum XK_Escape = 0xff1b;
	enum XK_Delete = 0xffff;

	enum XK_Multi_key = 0xff20;
	enum XK_Codeinput = 0xff37;
	enum XK_SingleCandidate = 0xff3c;
	enum XK_MultipleCandidate = 0xff3d;
	enum XK_PreviousCandidate = 0xff3e;

	enum XK_Kanji = 0xff21;
	enum XK_Muhenkan = 0xff22;
	enum XK_Henkan_Mode = 0xff23;
	enum XK_Henkan = 0xff23;
	enum XK_Romaji = 0xff24;
	enum XK_Hiragana = 0xff25;
	enum XK_Katakana = 0xff26;
	enum XK_Hiragana_Katakana = 0xff27;
	enum XK_Zenkaku = 0xff28;
	enum XK_Hankaku = 0xff29;
	enum XK_Zenkaku_Hankaku = 0xff2a;
	enum XK_Touroku = 0xff2b;
	enum XK_Massyo = 0xff2c;
	enum XK_Kana_Lock = 0xff2d;
	enum XK_Kana_Shift = 0xff2e;
	enum XK_Eisu_Shift = 0xff2f;
	enum XK_Eisu_toggle = 0xff30;
	enum XK_Kanji_Bangou = 0xff37;
	enum XK_Zen_Koho = 0xff3d;
	enum XK_Mae_Koho = 0xff3e;

	enum XK_Home = 0xff50;
	enum XK_Left = 0xff51;
	enum XK_Up = 0xff52;
	enum XK_Right = 0xff53;
	enum XK_Down = 0xff54;
	enum XK_Prior = 0xff55;
	enum XK_Page_Up = 0xff55;
	enum XK_Next = 0xff56;
	enum XK_Page_Down = 0xff56;
	enum XK_End = 0xff57;
	enum XK_Begin = 0xff58;

	enum XK_Select = 0xff60;
	enum XK_Print = 0xff61;
	enum XK_Execute = 0xff62;
	enum XK_Insert = 0xff63;
	enum XK_Undo = 0xff65;
	enum XK_Redo = 0xff66;
	enum XK_Menu = 0xff67;
	enum XK_Find = 0xff68;
	enum XK_Cancel = 0xff69;
	enum XK_Help = 0xff6a;
	enum XK_Break = 0xff6b;
	enum XK_Mode_switch = 0xff7e;
	enum XK_script_switch = 0xff7e;
	enum XK_Num_Lock = 0xff7f;

	enum XK_KP_Space = 0xff80;
	enum XK_KP_Tab = 0xff89;
	enum XK_KP_Enter = 0xff8d;
	enum XK_KP_F1 = 0xff91;
	enum XK_KP_F2 = 0xff92;
	enum XK_KP_F3 = 0xff93;
	enum XK_KP_F4 = 0xff94;
	enum XK_KP_Home = 0xff95;
	enum XK_KP_Left = 0xff96;
	enum XK_KP_Up = 0xff97;
	enum XK_KP_Right = 0xff98;
	enum XK_KP_Down = 0xff99;
	enum XK_KP_Prior = 0xff9a;
	enum XK_KP_Page_Up = 0xff9a;
	enum XK_KP_Next = 0xff9b;
	enum XK_KP_Page_Down = 0xff9b;
	enum XK_KP_End = 0xff9c;
	enum XK_KP_Begin = 0xff9d;
	enum XK_KP_Insert = 0xff9e;
	enum XK_KP_Delete = 0xff9f;
	enum XK_KP_Equal = 0xffbd;
	enum XK_KP_Multiply = 0xffaa;
	enum XK_KP_Add = 0xffab;
	enum XK_KP_Separator = 0xffac;
	enum XK_KP_Subtract = 0xffad;
	enum XK_KP_Decimal = 0xffae;
	enum XK_KP_Divide = 0xffaf;

	enum XK_KP_0 = 0xffb0;
	enum XK_KP_1 = 0xffb1;
	enum XK_KP_2 = 0xffb2;
	enum XK_KP_3 = 0xffb3;
	enum XK_KP_4 = 0xffb4;
	enum XK_KP_5 = 0xffb5;
	enum XK_KP_6 = 0xffb6;
	enum XK_KP_7 = 0xffb7;
	enum XK_KP_8 = 0xffb8;
	enum XK_KP_9 = 0xffb9;

	enum XK_F1 = 0xffbe;
	enum XK_F2 = 0xffbf;
	enum XK_F3 = 0xffc0;
	enum XK_F4 = 0xffc1;
	enum XK_F5 = 0xffc2;
	enum XK_F6 = 0xffc3;
	enum XK_F7 = 0xffc4;
	enum XK_F8 = 0xffc5;
	enum XK_F9 = 0xffc6;
	enum XK_F10 = 0xffc7;
	enum XK_F11 = 0xffc8;
	enum XK_L1 = 0xffc8;
	enum XK_F12 = 0xffc9;
	enum XK_L2 = 0xffc9;
	enum XK_F13 = 0xffca;
	enum XK_L3 = 0xffca;
	enum XK_F14 = 0xffcb;
	enum XK_L4 = 0xffcb;
	enum XK_F15 = 0xffcc;
	enum XK_L5 = 0xffcc;
	enum XK_F16 = 0xffcd;
	enum XK_L6 = 0xffcd;
	enum XK_F17 = 0xffce;
	enum XK_L7 = 0xffce;
	enum XK_F18 = 0xffcf;
	enum XK_L8 = 0xffcf;
	enum XK_F19 = 0xffd0;
	enum XK_L9 = 0xffd0;
	enum XK_F20 = 0xffd1;
	enum XK_L10 = 0xffd1;
	enum XK_F21 = 0xffd2;
	enum XK_R1 = 0xffd2;
	enum XK_F22 = 0xffd3;
	enum XK_R2 = 0xffd3;
	enum XK_F23 = 0xffd4;
	enum XK_R3 = 0xffd4;
	enum XK_F24 = 0xffd5;
	enum XK_R4 = 0xffd5;
	enum XK_F25 = 0xffd6;
	enum XK_R5 = 0xffd6;
	enum XK_F26 = 0xffd7;
	enum XK_R6 = 0xffd7;
	enum XK_F27 = 0xffd8;
	enum XK_R7 = 0xffd8;
	enum XK_F28 = 0xffd9;
	enum XK_R8 = 0xffd9;
	enum XK_F29 = 0xffda;
	enum XK_R9 = 0xffda;
	enum XK_F30 = 0xffdb;
	enum XK_R10 = 0xffdb;
	enum XK_F31 = 0xffdc;
	enum XK_R11 = 0xffdc;
	enum XK_F32 = 0xffdd;
	enum XK_R12 = 0xffdd;
	enum XK_F33 = 0xffde;
	enum XK_R13 = 0xffde;
	enum XK_F34 = 0xffdf;
	enum XK_R14 = 0xffdf;
	enum XK_F35 = 0xffe0;
	enum XK_R15 = 0xffe0;

	enum XK_Shift_L = 0xffe1;
	enum XK_Shift_R = 0xffe2;
	enum XK_Control_L = 0xffe3;
	enum XK_Control_R = 0xffe4;
	enum XK_Caps_Lock = 0xffe5;
	enum XK_Shift_Lock = 0xffe6;

	enum XK_Meta_L = 0xffe7;
	enum XK_Meta_R = 0xffe8;
	enum XK_Alt_L = 0xffe9;
	enum XK_Alt_R = 0xffea;
	enum XK_Super_L = 0xffeb;
	enum XK_Super_R = 0xffec;
	enum XK_Hyper_L = 0xffed;
	enum XK_Hyper_R = 0xffee;

	enum XK_ISO_Lock = 0xfe01;
	enum XK_ISO_Level2_Latch = 0xfe02;
	enum XK_ISO_Level3_Shift = 0xfe03;
	enum XK_ISO_Level3_Latch = 0xfe04;
	enum XK_ISO_Level3_Lock = 0xfe05;
	enum XK_ISO_Level5_Shift = 0xfe11;
	enum XK_ISO_Level5_Latch = 0xfe12;
	enum XK_ISO_Level5_Lock = 0xfe13;
	enum XK_ISO_Group_Shift = 0xff7e;
	enum XK_ISO_Group_Latch = 0xfe06;
	enum XK_ISO_Group_Lock = 0xfe07;
	enum XK_ISO_Next_Group = 0xfe08;
	enum XK_ISO_Next_Group_Lock = 0xfe09;
	enum XK_ISO_Prev_Group = 0xfe0a;
	enum XK_ISO_Prev_Group_Lock = 0xfe0b;
	enum XK_ISO_First_Group = 0xfe0c;
	enum XK_ISO_First_Group_Lock = 0xfe0d;
	enum XK_ISO_Last_Group = 0xfe0e;
	enum XK_ISO_Last_Group_Lock = 0xfe0f;

	enum XK_ISO_Left_Tab = 0xfe20;
	enum XK_ISO_Move_Line_Up = 0xfe21;
	enum XK_ISO_Move_Line_Down = 0xfe22;
	enum XK_ISO_Partial_Line_Up = 0xfe23;
	enum XK_ISO_Partial_Line_Down = 0xfe24;
	enum XK_ISO_Partial_Space_Left = 0xfe25;
	enum XK_ISO_Partial_Space_Right = 0xfe26;
	enum XK_ISO_Set_Margin_Left = 0xfe27;
	enum XK_ISO_Set_Margin_Right = 0xfe28;
	enum XK_ISO_Release_Margin_Left = 0xfe29;
	enum XK_ISO_Release_Margin_Right = 0xfe2a;
	enum XK_ISO_Release_Both_Margins = 0xfe2b;
	enum XK_ISO_Fast_Cursor_Left = 0xfe2c;
	enum XK_ISO_Fast_Cursor_Right = 0xfe2d;
	enum XK_ISO_Fast_Cursor_Up = 0xfe2e;
	enum XK_ISO_Fast_Cursor_Down = 0xfe2f;
	enum XK_ISO_Continuous_Underline = 0xfe30;
	enum XK_ISO_Discontinuous_Underline = 0xfe31;
	enum XK_ISO_Emphasize = 0xfe32;
	enum XK_ISO_Center_Object = 0xfe33;
	enum XK_ISO_Enter = 0xfe34;

	enum XK_dead_grave = 0xfe50;
	enum XK_dead_acute = 0xfe51;
	enum XK_dead_circumflex = 0xfe52;
	enum XK_dead_tilde = 0xfe53;
	enum XK_dead_perispomeni = 0xfe53;
	enum XK_dead_macron = 0xfe54;
	enum XK_dead_breve = 0xfe55;
	enum XK_dead_abovedot = 0xfe56;
	enum XK_dead_diaeresis = 0xfe57;
	enum XK_dead_abovering = 0xfe58;
	enum XK_dead_doubleacute = 0xfe59;
	enum XK_dead_caron = 0xfe5a;
	enum XK_dead_cedilla = 0xfe5b;
	enum XK_dead_ogonek = 0xfe5c;
	enum XK_dead_iota = 0xfe5d;
	enum XK_dead_voiced_sound = 0xfe5e;
	enum XK_dead_semivoiced_sound = 0xfe5f;
	enum XK_dead_belowdot = 0xfe60;
	enum XK_dead_hook = 0xfe61;
	enum XK_dead_horn = 0xfe62;
	enum XK_dead_stroke = 0xfe63;
	enum XK_dead_abovecomma = 0xfe64;
	enum XK_dead_psili = 0xfe64;
	enum XK_dead_abovereversedcomma = 0xfe65;
	enum XK_dead_dasia = 0xfe65;
	enum XK_dead_doublegrave = 0xfe66;
	enum XK_dead_belowring = 0xfe67;
	enum XK_dead_belowmacron = 0xfe68;
	enum XK_dead_belowcircumflex = 0xfe69;
	enum XK_dead_belowtilde = 0xfe6a;
	enum XK_dead_belowbreve = 0xfe6b;
	enum XK_dead_belowdiaeresis = 0xfe6c;
	enum XK_dead_invertedbreve = 0xfe6d;
	enum XK_dead_belowcomma = 0xfe6e;
	enum XK_dead_currency = 0xfe6f;

	enum XK_dead_lowline = 0xfe90;
	enum XK_dead_aboveverticalline = 0xfe91;
	enum XK_dead_belowverticalline = 0xfe92;
	enum XK_dead_longsolidusoverlay = 0xfe93;

	enum XK_dead_a = 0xfe80;
	enum XK_dead_A = 0xfe81;
	enum XK_dead_e = 0xfe82;
	enum XK_dead_E = 0xfe83;
	enum XK_dead_i = 0xfe84;
	enum XK_dead_I = 0xfe85;
	enum XK_dead_o = 0xfe86;
	enum XK_dead_O = 0xfe87;
	enum XK_dead_u = 0xfe88;
	enum XK_dead_U = 0xfe89;
	enum XK_dead_small_schwa = 0xfe8a;
	enum XK_dead_capital_schwa = 0xfe8b;

	enum XK_dead_greek = 0xfe8c;

	enum XK_First_Virtual_Screen = 0xfed0;
	enum XK_Prev_Virtual_Screen = 0xfed1;
	enum XK_Next_Virtual_Screen = 0xfed2;
	enum XK_Last_Virtual_Screen = 0xfed4;
	enum XK_Terminate_Server = 0xfed5;

	enum XK_AccessX_Enable = 0xfe70;
	enum XK_AccessX_Feedback_Enable = 0xfe71;
	enum XK_RepeatKeys_Enable = 0xfe72;
	enum XK_SlowKeys_Enable = 0xfe73;
	enum XK_BounceKeys_Enable = 0xfe74;
	enum XK_StickyKeys_Enable = 0xfe75;
	enum XK_MouseKeys_Enable = 0xfe76;
	enum XK_MouseKeys_Accel_Enable = 0xfe77;
	enum XK_Overlay1_Enable = 0xfe78;
	enum XK_Overlay2_Enable = 0xfe79;
	enum XK_AudibleBell_Enable = 0xfe7a;

	enum XK_Pointer_Left = 0xfee0;
	enum XK_Pointer_Right = 0xfee1;
	enum XK_Pointer_Up = 0xfee2;
	enum XK_Pointer_Down = 0xfee3;
	enum XK_Pointer_UpLeft = 0xfee4;
	enum XK_Pointer_UpRight = 0xfee5;
	enum XK_Pointer_DownLeft = 0xfee6;
	enum XK_Pointer_DownRight = 0xfee7;
	enum XK_Pointer_Button_Dflt = 0xfee8;
	enum XK_Pointer_Button1 = 0xfee9;
	enum XK_Pointer_Button2 = 0xfeea;
	enum XK_Pointer_Button3 = 0xfeeb;
	enum XK_Pointer_Button4 = 0xfeec;
	enum XK_Pointer_Button5 = 0xfeed;
	enum XK_Pointer_DblClick_Dflt = 0xfeee;
	enum XK_Pointer_DblClick1 = 0xfeef;
	enum XK_Pointer_DblClick2 = 0xfef0;
	enum XK_Pointer_DblClick3 = 0xfef1;
	enum XK_Pointer_DblClick4 = 0xfef2;
	enum XK_Pointer_DblClick5 = 0xfef3;
	enum XK_Pointer_Drag_Dflt = 0xfef4;
	enum XK_Pointer_Drag1 = 0xfef5;
	enum XK_Pointer_Drag2 = 0xfef6;
	enum XK_Pointer_Drag3 = 0xfef7;
	enum XK_Pointer_Drag4 = 0xfef8;
	enum XK_Pointer_Drag5 = 0xfefd;

	enum XK_Pointer_EnableKeys = 0xfef9;
	enum XK_Pointer_Accelerate = 0xfefa;
	enum XK_Pointer_DfltBtnNext = 0xfefb;
	enum XK_Pointer_DfltBtnPrev = 0xfefc;

	enum XK_ch = 0xfea0;
	enum XK_Ch = 0xfea1;
	enum XK_CH = 0xfea2;
	enum XK_c_h = 0xfea3;
	enum XK_C_h = 0xfea4;
	enum XK_C_H = 0xfea5;

	enum XK_space = 0x0020;
	enum XK_exclam = 0x0021;
	enum XK_quotedbl = 0x0022;
	enum XK_numbersign = 0x0023;
	enum XK_dollar = 0x0024;
	enum XK_percent = 0x0025;
	enum XK_ampersand = 0x0026;
	enum XK_apostrophe = 0x0027;
	enum XK_quoteright = 0x0027;
	enum XK_parenleft = 0x0028;
	enum XK_parenright = 0x0029;
	enum XK_asterisk = 0x002a;
	enum XK_plus = 0x002b;
	enum XK_comma = 0x002c;
	enum XK_minus = 0x002d;
	enum XK_period = 0x002e;
	enum XK_slash = 0x002f;
	enum XK_0 = 0x0030;
	enum XK_1 = 0x0031;
	enum XK_2 = 0x0032;
	enum XK_3 = 0x0033;
	enum XK_4 = 0x0034;
	enum XK_5 = 0x0035;
	enum XK_6 = 0x0036;
	enum XK_7 = 0x0037;
	enum XK_8 = 0x0038;
	enum XK_9 = 0x0039;
	enum XK_colon = 0x003a;
	enum XK_semicolon = 0x003b;
	enum XK_less = 0x003c;
	enum XK_equal = 0x003d;
	enum XK_greater = 0x003e;
	enum XK_question = 0x003f;
	enum XK_at = 0x0040;
	enum XK_A = 0x0041;
	enum XK_B = 0x0042;
	enum XK_C = 0x0043;
	enum XK_D = 0x0044;
	enum XK_E = 0x0045;
	enum XK_F = 0x0046;
	enum XK_G = 0x0047;
	enum XK_H = 0x0048;
	enum XK_I = 0x0049;
	enum XK_J = 0x004a;
	enum XK_K = 0x004b;
	enum XK_L = 0x004c;
	enum XK_M = 0x004d;
	enum XK_N = 0x004e;
	enum XK_O = 0x004f;
	enum XK_P = 0x0050;
	enum XK_Q = 0x0051;
	enum XK_R = 0x0052;
	enum XK_S = 0x0053;
	enum XK_T = 0x0054;
	enum XK_U = 0x0055;
	enum XK_V = 0x0056;
	enum XK_W = 0x0057;
	enum XK_X = 0x0058;
	enum XK_Y = 0x0059;
	enum XK_Z = 0x005a;
	enum XK_bracketleft = 0x005b;
	enum XK_backslash = 0x005c;
	enum XK_bracketright = 0x005d;
	enum XK_asciicircum = 0x005e;
	enum XK_underscore = 0x005f;
	enum XK_grave = 0x0060;
	enum XK_quoteleft = 0x0060;
	enum XK_a = 0x0061;
	enum XK_b = 0x0062;
	enum XK_c = 0x0063;
	enum XK_d = 0x0064;
	enum XK_e = 0x0065;
	enum XK_f = 0x0066;
	enum XK_g = 0x0067;
	enum XK_h = 0x0068;
	enum XK_i = 0x0069;
	enum XK_j = 0x006a;
	enum XK_k = 0x006b;
	enum XK_l = 0x006c;
	enum XK_m = 0x006d;
	enum XK_n = 0x006e;
	enum XK_o = 0x006f;
	enum XK_p = 0x0070;
	enum XK_q = 0x0071;
	enum XK_r = 0x0072;
	enum XK_s = 0x0073;
	enum XK_t = 0x0074;
	enum XK_u = 0x0075;
	enum XK_v = 0x0076;
	enum XK_w = 0x0077;
	enum XK_x = 0x0078;
	enum XK_y = 0x0079;
	enum XK_z = 0x007a;
	enum XK_braceleft = 0x007b;
	enum XK_bar = 0x007c;
	enum XK_braceright = 0x007d;
	enum XK_asciitilde = 0x007e;

	enum XK_nobreakspace = 0x00a0;
	enum XK_exclamdown = 0x00a1;
	enum XK_cent = 0x00a2;
	enum XK_sterling = 0x00a3;
	enum XK_currency = 0x00a4;
	enum XK_yen = 0x00a5;
	enum XK_brokenbar = 0x00a6;
	enum XK_section = 0x00a7;
	enum XK_diaeresis = 0x00a8;
	enum XK_copyright = 0x00a9;
	enum XK_ordfeminine = 0x00aa;
	enum XK_guillemotleft = 0x00ab;
	enum XK_notsign = 0x00ac;
	enum XK_hyphen = 0x00ad;
	enum XK_registered = 0x00ae;
	enum XK_macron = 0x00af;
	enum XK_degree = 0x00b0;
	enum XK_plusminus = 0x00b1;
	enum XK_twosuperior = 0x00b2;
	enum XK_threesuperior = 0x00b3;
	enum XK_acute = 0x00b4;
	enum XK_mu = 0x00b5;
	enum XK_paragraph = 0x00b6;
	enum XK_periodcentered = 0x00b7;
	enum XK_cedilla = 0x00b8;
	enum XK_onesuperior = 0x00b9;
	enum XK_masculine = 0x00ba;
	enum XK_guillemotright = 0x00bb;
	enum XK_onequarter = 0x00bc;
	enum XK_onehalf = 0x00bd;
	enum XK_threequarters = 0x00be;
	enum XK_questiondown = 0x00bf;
	enum XK_Agrave = 0x00c0;
	enum XK_Aacute = 0x00c1;
	enum XK_Acircumflex = 0x00c2;
	enum XK_Atilde = 0x00c3;
	enum XK_Adiaeresis = 0x00c4;
	enum XK_Aring = 0x00c5;
	enum XK_AE = 0x00c6;
	enum XK_Ccedilla = 0x00c7;
	enum XK_Egrave = 0x00c8;
	enum XK_Eacute = 0x00c9;
	enum XK_Ecircumflex = 0x00ca;
	enum XK_Ediaeresis = 0x00cb;
	enum XK_Igrave = 0x00cc;
	enum XK_Iacute = 0x00cd;
	enum XK_Icircumflex = 0x00ce;
	enum XK_Idiaeresis = 0x00cf;
	enum XK_ETH = 0x00d0;
	enum XK_Eth = 0x00d0;
	enum XK_Ntilde = 0x00d1;
	enum XK_Ograve = 0x00d2;
	enum XK_Oacute = 0x00d3;
	enum XK_Ocircumflex = 0x00d4;
	enum XK_Otilde = 0x00d5;
	enum XK_Odiaeresis = 0x00d6;
	enum XK_multiply = 0x00d7;
	enum XK_Oslash = 0x00d8;
	enum XK_Ooblique = 0x00d8;
	enum XK_Ugrave = 0x00d9;
	enum XK_Uacute = 0x00da;
	enum XK_Ucircumflex = 0x00db;
	enum XK_Udiaeresis = 0x00dc;
	enum XK_Yacute = 0x00dd;
	enum XK_THORN = 0x00de;
	enum XK_Thorn = 0x00de;
	enum XK_ssharp = 0x00df;
	enum XK_agrave = 0x00e0;
	enum XK_aacute = 0x00e1;
	enum XK_acircumflex = 0x00e2;
	enum XK_atilde = 0x00e3;
	enum XK_adiaeresis = 0x00e4;
	enum XK_aring = 0x00e5;
	enum XK_ae = 0x00e6;
	enum XK_ccedilla = 0x00e7;
	enum XK_egrave = 0x00e8;
	enum XK_eacute = 0x00e9;
	enum XK_ecircumflex = 0x00ea;
	enum XK_ediaeresis = 0x00eb;
	enum XK_igrave = 0x00ec;
	enum XK_iacute = 0x00ed;
	enum XK_icircumflex = 0x00ee;
	enum XK_idiaeresis = 0x00ef;
	enum XK_eth = 0x00f0;
	enum XK_ntilde = 0x00f1;
	enum XK_ograve = 0x00f2;
	enum XK_oacute = 0x00f3;
	enum XK_ocircumflex = 0x00f4;
	enum XK_otilde = 0x00f5;
	enum XK_odiaeresis = 0x00f6;
	enum XK_division = 0x00f7;
	enum XK_oslash = 0x00f8;
	enum XK_ooblique = 0x00f8;
	enum XK_ugrave = 0x00f9;
	enum XK_uacute = 0x00fa;
	enum XK_ucircumflex = 0x00fb;
	enum XK_udiaeresis = 0x00fc;
	enum XK_yacute = 0x00fd;
	enum XK_thorn = 0x00fe;
	enum XK_ydiaeresis = 0x00ff;

	enum XK_Aogonek = 0x01a1;
	enum XK_breve = 0x01a2;
	enum XK_Lstroke = 0x01a3;
	enum XK_Lcaron = 0x01a5;
	enum XK_Sacute = 0x01a6;
	enum XK_Scaron = 0x01a9;
	enum XK_Scedilla = 0x01aa;
	enum XK_Tcaron = 0x01ab;
	enum XK_Zacute = 0x01ac;
	enum XK_Zcaron = 0x01ae;
	enum XK_Zabovedot = 0x01af;
	enum XK_aogonek = 0x01b1;
	enum XK_ogonek = 0x01b2;
	enum XK_lstroke = 0x01b3;
	enum XK_lcaron = 0x01b5;
	enum XK_sacute = 0x01b6;
	enum XK_caron = 0x01b7;
	enum XK_scaron = 0x01b9;
	enum XK_scedilla = 0x01ba;
	enum XK_tcaron = 0x01bb;
	enum XK_zacute = 0x01bc;
	enum XK_doubleacute = 0x01bd;
	enum XK_zcaron = 0x01be;
	enum XK_zabovedot = 0x01bf;
	enum XK_Racute = 0x01c0;
	enum XK_Abreve = 0x01c3;
	enum XK_Lacute = 0x01c5;
	enum XK_Cacute = 0x01c6;
	enum XK_Ccaron = 0x01c8;
	enum XK_Eogonek = 0x01ca;
	enum XK_Ecaron = 0x01cc;
	enum XK_Dcaron = 0x01cf;
	enum XK_Dstroke = 0x01d0;
	enum XK_Nacute = 0x01d1;
	enum XK_Ncaron = 0x01d2;
	enum XK_Odoubleacute = 0x01d5;
	enum XK_Rcaron = 0x01d8;
	enum XK_Uring = 0x01d9;
	enum XK_Udoubleacute = 0x01db;
	enum XK_Tcedilla = 0x01de;
	enum XK_racute = 0x01e0;
	enum XK_abreve = 0x01e3;
	enum XK_lacute = 0x01e5;
	enum XK_cacute = 0x01e6;
	enum XK_ccaron = 0x01e8;
	enum XK_eogonek = 0x01ea;
	enum XK_ecaron = 0x01ec;
	enum XK_dcaron = 0x01ef;
	enum XK_dstroke = 0x01f0;
	enum XK_nacute = 0x01f1;
	enum XK_ncaron = 0x01f2;
	enum XK_odoubleacute = 0x01f5;
	enum XK_rcaron = 0x01f8;
	enum XK_uring = 0x01f9;
	enum XK_udoubleacute = 0x01fb;
	enum XK_tcedilla = 0x01fe;
	enum XK_abovedot = 0x01ff;

	enum XK_Hstroke = 0x02a1;
	enum XK_Hcircumflex = 0x02a6;
	enum XK_Iabovedot = 0x02a9;
	enum XK_Gbreve = 0x02ab;
	enum XK_Jcircumflex = 0x02ac;
	enum XK_hstroke = 0x02b1;
	enum XK_hcircumflex = 0x02b6;
	enum XK_idotless = 0x02b9;
	enum XK_gbreve = 0x02bb;
	enum XK_jcircumflex = 0x02bc;
	enum XK_Cabovedot = 0x02c5;
	enum XK_Ccircumflex = 0x02c6;
	enum XK_Gabovedot = 0x02d5;
	enum XK_Gcircumflex = 0x02d8;
	enum XK_Ubreve = 0x02dd;
	enum XK_Scircumflex = 0x02de;
	enum XK_cabovedot = 0x02e5;
	enum XK_ccircumflex = 0x02e6;
	enum XK_gabovedot = 0x02f5;
	enum XK_gcircumflex = 0x02f8;
	enum XK_ubreve = 0x02fd;
	enum XK_scircumflex = 0x02fe;

	enum XK_kra = 0x03a2;
	enum XK_kappa = 0x03a2;
	enum XK_Rcedilla = 0x03a3;
	enum XK_Itilde = 0x03a5;
	enum XK_Lcedilla = 0x03a6;
	enum XK_Emacron = 0x03aa;
	enum XK_Gcedilla = 0x03ab;
	enum XK_Tslash = 0x03ac;
	enum XK_rcedilla = 0x03b3;
	enum XK_itilde = 0x03b5;
	enum XK_lcedilla = 0x03b6;
	enum XK_emacron = 0x03ba;
	enum XK_gcedilla = 0x03bb;
	enum XK_tslash = 0x03bc;
	enum XK_ENG = 0x03bd;
	enum XK_eng = 0x03bf;
	enum XK_Amacron = 0x03c0;
	enum XK_Iogonek = 0x03c7;
	enum XK_Eabovedot = 0x03cc;
	enum XK_Imacron = 0x03cf;
	enum XK_Ncedilla = 0x03d1;
	enum XK_Omacron = 0x03d2;
	enum XK_Kcedilla = 0x03d3;
	enum XK_Uogonek = 0x03d9;
	enum XK_Utilde = 0x03dd;
	enum XK_Umacron = 0x03de;
	enum XK_amacron = 0x03e0;
	enum XK_iogonek = 0x03e7;
	enum XK_eabovedot = 0x03ec;
	enum XK_imacron = 0x03ef;
	enum XK_ncedilla = 0x03f1;
	enum XK_omacron = 0x03f2;
	enum XK_kcedilla = 0x03f3;
	enum XK_uogonek = 0x03f9;
	enum XK_utilde = 0x03fd;
	enum XK_umacron = 0x03fe;

	enum XK_Wcircumflex = 0x1000174;
	enum XK_wcircumflex = 0x1000175;
	enum XK_Ycircumflex = 0x1000176;
	enum XK_ycircumflex = 0x1000177;
	enum XK_Babovedot = 0x1001e02;
	enum XK_babovedot = 0x1001e03;
	enum XK_Dabovedot = 0x1001e0a;
	enum XK_dabovedot = 0x1001e0b;
	enum XK_Fabovedot = 0x1001e1e;
	enum XK_fabovedot = 0x1001e1f;
	enum XK_Mabovedot = 0x1001e40;
	enum XK_mabovedot = 0x1001e41;
	enum XK_Pabovedot = 0x1001e56;
	enum XK_pabovedot = 0x1001e57;
	enum XK_Sabovedot = 0x1001e60;
	enum XK_sabovedot = 0x1001e61;
	enum XK_Tabovedot = 0x1001e6a;
	enum XK_tabovedot = 0x1001e6b;
	enum XK_Wgrave = 0x1001e80;
	enum XK_wgrave = 0x1001e81;
	enum XK_Wacute = 0x1001e82;
	enum XK_wacute = 0x1001e83;
	enum XK_Wdiaeresis = 0x1001e84;
	enum XK_wdiaeresis = 0x1001e85;
	enum XK_Ygrave = 0x1001ef2;
	enum XK_ygrave = 0x1001ef3;

	enum XK_OE = 0x13bc;
	enum XK_oe = 0x13bd;
	enum XK_Ydiaeresis = 0x13be;

	enum XK_overline = 0x047e;
	enum XK_kana_fullstop = 0x04a1;
	enum XK_kana_openingbracket = 0x04a2;
	enum XK_kana_closingbracket = 0x04a3;
	enum XK_kana_comma = 0x04a4;
	enum XK_kana_conjunctive = 0x04a5;
	enum XK_kana_middledot = 0x04a5;
	enum XK_kana_WO = 0x04a6;
	enum XK_kana_a = 0x04a7;
	enum XK_kana_i = 0x04a8;
	enum XK_kana_u = 0x04a9;
	enum XK_kana_e = 0x04aa;
	enum XK_kana_o = 0x04ab;
	enum XK_kana_ya = 0x04ac;
	enum XK_kana_yu = 0x04ad;
	enum XK_kana_yo = 0x04ae;
	enum XK_kana_tsu = 0x04af;
	enum XK_kana_tu = 0x04af;
	enum XK_prolongedsound = 0x04b0;
	enum XK_kana_A = 0x04b1;
	enum XK_kana_I = 0x04b2;
	enum XK_kana_U = 0x04b3;
	enum XK_kana_E = 0x04b4;
	enum XK_kana_O = 0x04b5;
	enum XK_kana_KA = 0x04b6;
	enum XK_kana_KI = 0x04b7;
	enum XK_kana_KU = 0x04b8;
	enum XK_kana_KE = 0x04b9;
	enum XK_kana_KO = 0x04ba;
	enum XK_kana_SA = 0x04bb;
	enum XK_kana_SHI = 0x04bc;
	enum XK_kana_SU = 0x04bd;
	enum XK_kana_SE = 0x04be;
	enum XK_kana_SO = 0x04bf;
	enum XK_kana_TA = 0x04c0;
	enum XK_kana_CHI = 0x04c1;
	enum XK_kana_TI = 0x04c1;
	enum XK_kana_TSU = 0x04c2;
	enum XK_kana_TU = 0x04c2;
	enum XK_kana_TE = 0x04c3;
	enum XK_kana_TO = 0x04c4;
	enum XK_kana_NA = 0x04c5;
	enum XK_kana_NI = 0x04c6;
	enum XK_kana_NU = 0x04c7;
	enum XK_kana_NE = 0x04c8;
	enum XK_kana_NO = 0x04c9;
	enum XK_kana_HA = 0x04ca;
	enum XK_kana_HI = 0x04cb;
	enum XK_kana_FU = 0x04cc;
	enum XK_kana_HU = 0x04cc;
	enum XK_kana_HE = 0x04cd;
	enum XK_kana_HO = 0x04ce;
	enum XK_kana_MA = 0x04cf;
	enum XK_kana_MI = 0x04d0;
	enum XK_kana_MU = 0x04d1;
	enum XK_kana_ME = 0x04d2;
	enum XK_kana_MO = 0x04d3;
	enum XK_kana_YA = 0x04d4;
	enum XK_kana_YU = 0x04d5;
	enum XK_kana_YO = 0x04d6;
	enum XK_kana_RA = 0x04d7;
	enum XK_kana_RI = 0x04d8;
	enum XK_kana_RU = 0x04d9;
	enum XK_kana_RE = 0x04da;
	enum XK_kana_RO = 0x04db;
	enum XK_kana_WA = 0x04dc;
	enum XK_kana_N = 0x04dd;
	enum XK_voicedsound = 0x04de;
	enum XK_semivoicedsound = 0x04df;
	enum XK_kana_switch = 0xff7e;

	enum XK_Farsi_0 = 0x10006f0;
	enum XK_Farsi_1 = 0x10006f1;
	enum XK_Farsi_2 = 0x10006f2;
	enum XK_Farsi_3 = 0x10006f3;
	enum XK_Farsi_4 = 0x10006f4;
	enum XK_Farsi_5 = 0x10006f5;
	enum XK_Farsi_6 = 0x10006f6;
	enum XK_Farsi_7 = 0x10006f7;
	enum XK_Farsi_8 = 0x10006f8;
	enum XK_Farsi_9 = 0x10006f9;
	enum XK_Arabic_percent = 0x100066a;
	enum XK_Arabic_superscript_alef = 0x1000670;
	enum XK_Arabic_tteh = 0x1000679;
	enum XK_Arabic_peh = 0x100067e;
	enum XK_Arabic_tcheh = 0x1000686;
	enum XK_Arabic_ddal = 0x1000688;
	enum XK_Arabic_rreh = 0x1000691;
	enum XK_Arabic_comma = 0x05ac;
	enum XK_Arabic_fullstop = 0x10006d4;
	enum XK_Arabic_0 = 0x1000660;
	enum XK_Arabic_1 = 0x1000661;
	enum XK_Arabic_2 = 0x1000662;
	enum XK_Arabic_3 = 0x1000663;
	enum XK_Arabic_4 = 0x1000664;
	enum XK_Arabic_5 = 0x1000665;
	enum XK_Arabic_6 = 0x1000666;
	enum XK_Arabic_7 = 0x1000667;
	enum XK_Arabic_8 = 0x1000668;
	enum XK_Arabic_9 = 0x1000669;
	enum XK_Arabic_semicolon = 0x05bb;
	enum XK_Arabic_question_mark = 0x05bf;
	enum XK_Arabic_hamza = 0x05c1;
	enum XK_Arabic_maddaonalef = 0x05c2;
	enum XK_Arabic_hamzaonalef = 0x05c3;
	enum XK_Arabic_hamzaonwaw = 0x05c4;
	enum XK_Arabic_hamzaunderalef = 0x05c5;
	enum XK_Arabic_hamzaonyeh = 0x05c6;
	enum XK_Arabic_alef = 0x05c7;
	enum XK_Arabic_beh = 0x05c8;
	enum XK_Arabic_tehmarbuta = 0x05c9;
	enum XK_Arabic_teh = 0x05ca;
	enum XK_Arabic_theh = 0x05cb;
	enum XK_Arabic_jeem = 0x05cc;
	enum XK_Arabic_hah = 0x05cd;
	enum XK_Arabic_khah = 0x05ce;
	enum XK_Arabic_dal = 0x05cf;
	enum XK_Arabic_thal = 0x05d0;
	enum XK_Arabic_ra = 0x05d1;
	enum XK_Arabic_zain = 0x05d2;
	enum XK_Arabic_seen = 0x05d3;
	enum XK_Arabic_sheen = 0x05d4;
	enum XK_Arabic_sad = 0x05d5;
	enum XK_Arabic_dad = 0x05d6;
	enum XK_Arabic_tah = 0x05d7;
	enum XK_Arabic_zah = 0x05d8;
	enum XK_Arabic_ain = 0x05d9;
	enum XK_Arabic_ghain = 0x05da;
	enum XK_Arabic_tatweel = 0x05e0;
	enum XK_Arabic_feh = 0x05e1;
	enum XK_Arabic_qaf = 0x05e2;
	enum XK_Arabic_kaf = 0x05e3;
	enum XK_Arabic_lam = 0x05e4;
	enum XK_Arabic_meem = 0x05e5;
	enum XK_Arabic_noon = 0x05e6;
	enum XK_Arabic_ha = 0x05e7;
	enum XK_Arabic_heh = 0x05e7;
	enum XK_Arabic_waw = 0x05e8;
	enum XK_Arabic_alefmaksura = 0x05e9;
	enum XK_Arabic_yeh = 0x05ea;
	enum XK_Arabic_fathatan = 0x05eb;
	enum XK_Arabic_dammatan = 0x05ec;
	enum XK_Arabic_kasratan = 0x05ed;
	enum XK_Arabic_fatha = 0x05ee;
	enum XK_Arabic_damma = 0x05ef;
	enum XK_Arabic_kasra = 0x05f0;
	enum XK_Arabic_shadda = 0x05f1;
	enum XK_Arabic_sukun = 0x05f2;
	enum XK_Arabic_madda_above = 0x1000653;
	enum XK_Arabic_hamza_above = 0x1000654;
	enum XK_Arabic_hamza_below = 0x1000655;
	enum XK_Arabic_jeh = 0x1000698;
	enum XK_Arabic_veh = 0x10006a4;
	enum XK_Arabic_keheh = 0x10006a9;
	enum XK_Arabic_gaf = 0x10006af;
	enum XK_Arabic_noon_ghunna = 0x10006ba;
	enum XK_Arabic_heh_doachashmee = 0x10006be;
	enum XK_Farsi_yeh = 0x10006cc;
	enum XK_Arabic_farsi_yeh = 0x10006cc;
	enum XK_Arabic_yeh_baree = 0x10006d2;
	enum XK_Arabic_heh_goal = 0x10006c1;
	enum XK_Arabic_switch = 0xff7e;

	enum XK_Cyrillic_GHE_bar = 0x1000492;
	enum XK_Cyrillic_ghe_bar = 0x1000493;
	enum XK_Cyrillic_ZHE_descender = 0x1000496;
	enum XK_Cyrillic_zhe_descender = 0x1000497;
	enum XK_Cyrillic_KA_descender = 0x100049a;
	enum XK_Cyrillic_ka_descender = 0x100049b;
	enum XK_Cyrillic_KA_vertstroke = 0x100049c;
	enum XK_Cyrillic_ka_vertstroke = 0x100049d;
	enum XK_Cyrillic_EN_descender = 0x10004a2;
	enum XK_Cyrillic_en_descender = 0x10004a3;
	enum XK_Cyrillic_U_straight = 0x10004ae;
	enum XK_Cyrillic_u_straight = 0x10004af;
	enum XK_Cyrillic_U_straight_bar = 0x10004b0;
	enum XK_Cyrillic_u_straight_bar = 0x10004b1;
	enum XK_Cyrillic_HA_descender = 0x10004b2;
	enum XK_Cyrillic_ha_descender = 0x10004b3;
	enum XK_Cyrillic_CHE_descender = 0x10004b6;
	enum XK_Cyrillic_che_descender = 0x10004b7;
	enum XK_Cyrillic_CHE_vertstroke = 0x10004b8;
	enum XK_Cyrillic_che_vertstroke = 0x10004b9;
	enum XK_Cyrillic_SHHA = 0x10004ba;
	enum XK_Cyrillic_shha = 0x10004bb;

	enum XK_Cyrillic_SCHWA = 0x10004d8;
	enum XK_Cyrillic_schwa = 0x10004d9;
	enum XK_Cyrillic_I_macron = 0x10004e2;
	enum XK_Cyrillic_i_macron = 0x10004e3;
	enum XK_Cyrillic_O_bar = 0x10004e8;
	enum XK_Cyrillic_o_bar = 0x10004e9;
	enum XK_Cyrillic_U_macron = 0x10004ee;
	enum XK_Cyrillic_u_macron = 0x10004ef;

	enum XK_Serbian_dje = 0x06a1;
	enum XK_Macedonia_gje = 0x06a2;
	enum XK_Cyrillic_io = 0x06a3;
	enum XK_Ukrainian_ie = 0x06a4;
	enum XK_Ukranian_je = 0x06a4;
	enum XK_Macedonia_dse = 0x06a5;
	enum XK_Ukrainian_i = 0x06a6;
	enum XK_Ukranian_i = 0x06a6;
	enum XK_Ukrainian_yi = 0x06a7;
	enum XK_Ukranian_yi = 0x06a7;
	enum XK_Cyrillic_je = 0x06a8;
	enum XK_Serbian_je = 0x06a8;
	enum XK_Cyrillic_lje = 0x06a9;
	enum XK_Serbian_lje = 0x06a9;
	enum XK_Cyrillic_nje = 0x06aa;
	enum XK_Serbian_nje = 0x06aa;
	enum XK_Serbian_tshe = 0x06ab;
	enum XK_Macedonia_kje = 0x06ac;
	enum XK_Ukrainian_ghe_with_upturn = 0x06ad;
	enum XK_Byelorussian_shortu = 0x06ae;
	enum XK_Cyrillic_dzhe = 0x06af;
	enum XK_Serbian_dze = 0x06af;
	enum XK_numerosign = 0x06b0;
	enum XK_Serbian_DJE = 0x06b1;
	enum XK_Macedonia_GJE = 0x06b2;
	enum XK_Cyrillic_IO = 0x06b3;
	enum XK_Ukrainian_IE = 0x06b4;
	enum XK_Ukranian_JE = 0x06b4;
	enum XK_Macedonia_DSE = 0x06b5;
	enum XK_Ukrainian_I = 0x06b6;
	enum XK_Ukranian_I = 0x06b6;
	enum XK_Ukrainian_YI = 0x06b7;
	enum XK_Ukranian_YI = 0x06b7;
	enum XK_Cyrillic_JE = 0x06b8;
	enum XK_Serbian_JE = 0x06b8;
	enum XK_Cyrillic_LJE = 0x06b9;
	enum XK_Serbian_LJE = 0x06b9;
	enum XK_Cyrillic_NJE = 0x06ba;
	enum XK_Serbian_NJE = 0x06ba;
	enum XK_Serbian_TSHE = 0x06bb;
	enum XK_Macedonia_KJE = 0x06bc;
	enum XK_Ukrainian_GHE_WITH_UPTURN = 0x06bd;
	enum XK_Byelorussian_SHORTU = 0x06be;
	enum XK_Cyrillic_DZHE = 0x06bf;
	enum XK_Serbian_DZE = 0x06bf;
	enum XK_Cyrillic_yu = 0x06c0;
	enum XK_Cyrillic_a = 0x06c1;
	enum XK_Cyrillic_be = 0x06c2;
	enum XK_Cyrillic_tse = 0x06c3;
	enum XK_Cyrillic_de = 0x06c4;
	enum XK_Cyrillic_ie = 0x06c5;
	enum XK_Cyrillic_ef = 0x06c6;
	enum XK_Cyrillic_ghe = 0x06c7;
	enum XK_Cyrillic_ha = 0x06c8;
	enum XK_Cyrillic_i = 0x06c9;
	enum XK_Cyrillic_shorti = 0x06ca;
	enum XK_Cyrillic_ka = 0x06cb;
	enum XK_Cyrillic_el = 0x06cc;
	enum XK_Cyrillic_em = 0x06cd;
	enum XK_Cyrillic_en = 0x06ce;
	enum XK_Cyrillic_o = 0x06cf;
	enum XK_Cyrillic_pe = 0x06d0;
	enum XK_Cyrillic_ya = 0x06d1;
	enum XK_Cyrillic_er = 0x06d2;
	enum XK_Cyrillic_es = 0x06d3;
	enum XK_Cyrillic_te = 0x06d4;
	enum XK_Cyrillic_u = 0x06d5;
	enum XK_Cyrillic_zhe = 0x06d6;
	enum XK_Cyrillic_ve = 0x06d7;
	enum XK_Cyrillic_softsign = 0x06d8;
	enum XK_Cyrillic_yeru = 0x06d9;
	enum XK_Cyrillic_ze = 0x06da;
	enum XK_Cyrillic_sha = 0x06db;
	enum XK_Cyrillic_e = 0x06dc;
	enum XK_Cyrillic_shcha = 0x06dd;
	enum XK_Cyrillic_che = 0x06de;
	enum XK_Cyrillic_hardsign = 0x06df;
	enum XK_Cyrillic_YU = 0x06e0;
	enum XK_Cyrillic_A = 0x06e1;
	enum XK_Cyrillic_BE = 0x06e2;
	enum XK_Cyrillic_TSE = 0x06e3;
	enum XK_Cyrillic_DE = 0x06e4;
	enum XK_Cyrillic_IE = 0x06e5;
	enum XK_Cyrillic_EF = 0x06e6;
	enum XK_Cyrillic_GHE = 0x06e7;
	enum XK_Cyrillic_HA = 0x06e8;
	enum XK_Cyrillic_I = 0x06e9;
	enum XK_Cyrillic_SHORTI = 0x06ea;
	enum XK_Cyrillic_KA = 0x06eb;
	enum XK_Cyrillic_EL = 0x06ec;
	enum XK_Cyrillic_EM = 0x06ed;
	enum XK_Cyrillic_EN = 0x06ee;
	enum XK_Cyrillic_O = 0x06ef;
	enum XK_Cyrillic_PE = 0x06f0;
	enum XK_Cyrillic_YA = 0x06f1;
	enum XK_Cyrillic_ER = 0x06f2;
	enum XK_Cyrillic_ES = 0x06f3;
	enum XK_Cyrillic_TE = 0x06f4;
	enum XK_Cyrillic_U = 0x06f5;
	enum XK_Cyrillic_ZHE = 0x06f6;
	enum XK_Cyrillic_VE = 0x06f7;
	enum XK_Cyrillic_SOFTSIGN = 0x06f8;
	enum XK_Cyrillic_YERU = 0x06f9;
	enum XK_Cyrillic_ZE = 0x06fa;
	enum XK_Cyrillic_SHA = 0x06fb;
	enum XK_Cyrillic_E = 0x06fc;
	enum XK_Cyrillic_SHCHA = 0x06fd;
	enum XK_Cyrillic_CHE = 0x06fe;
	enum XK_Cyrillic_HARDSIGN = 0x06ff;

	enum XK_Greek_ALPHAaccent = 0x07a1;
	enum XK_Greek_EPSILONaccent = 0x07a2;
	enum XK_Greek_ETAaccent = 0x07a3;
	enum XK_Greek_IOTAaccent = 0x07a4;
	enum XK_Greek_IOTAdieresis = 0x07a5;
	enum XK_Greek_IOTAdiaeresis = 0x07a5;
	enum XK_Greek_OMICRONaccent = 0x07a7;
	enum XK_Greek_UPSILONaccent = 0x07a8;
	enum XK_Greek_UPSILONdieresis = 0x07a9;
	enum XK_Greek_OMEGAaccent = 0x07ab;
	enum XK_Greek_accentdieresis = 0x07ae;
	enum XK_Greek_horizbar = 0x07af;
	enum XK_Greek_alphaaccent = 0x07b1;
	enum XK_Greek_epsilonaccent = 0x07b2;
	enum XK_Greek_etaaccent = 0x07b3;
	enum XK_Greek_iotaaccent = 0x07b4;
	enum XK_Greek_iotadieresis = 0x07b5;
	enum XK_Greek_iotaaccentdieresis = 0x07b6;
	enum XK_Greek_omicronaccent = 0x07b7;
	enum XK_Greek_upsilonaccent = 0x07b8;
	enum XK_Greek_upsilondieresis = 0x07b9;
	enum XK_Greek_upsilonaccentdieresis = 0x07ba;
	enum XK_Greek_omegaaccent = 0x07bb;
	enum XK_Greek_ALPHA = 0x07c1;
	enum XK_Greek_BETA = 0x07c2;
	enum XK_Greek_GAMMA = 0x07c3;
	enum XK_Greek_DELTA = 0x07c4;
	enum XK_Greek_EPSILON = 0x07c5;
	enum XK_Greek_ZETA = 0x07c6;
	enum XK_Greek_ETA = 0x07c7;
	enum XK_Greek_THETA = 0x07c8;
	enum XK_Greek_IOTA = 0x07c9;
	enum XK_Greek_KAPPA = 0x07ca;
	enum XK_Greek_LAMDA = 0x07cb;
	enum XK_Greek_LAMBDA = 0x07cb;
	enum XK_Greek_MU = 0x07cc;
	enum XK_Greek_NU = 0x07cd;
	enum XK_Greek_XI = 0x07ce;
	enum XK_Greek_OMICRON = 0x07cf;
	enum XK_Greek_PI = 0x07d0;
	enum XK_Greek_RHO = 0x07d1;
	enum XK_Greek_SIGMA = 0x07d2;
	enum XK_Greek_TAU = 0x07d4;
	enum XK_Greek_UPSILON = 0x07d5;
	enum XK_Greek_PHI = 0x07d6;
	enum XK_Greek_CHI = 0x07d7;
	enum XK_Greek_PSI = 0x07d8;
	enum XK_Greek_OMEGA = 0x07d9;
	enum XK_Greek_alpha = 0x07e1;
	enum XK_Greek_beta = 0x07e2;
	enum XK_Greek_gamma = 0x07e3;
	enum XK_Greek_delta = 0x07e4;
	enum XK_Greek_epsilon = 0x07e5;
	enum XK_Greek_zeta = 0x07e6;
	enum XK_Greek_eta = 0x07e7;
	enum XK_Greek_theta = 0x07e8;
	enum XK_Greek_iota = 0x07e9;
	enum XK_Greek_kappa = 0x07ea;
	enum XK_Greek_lamda = 0x07eb;
	enum XK_Greek_lambda = 0x07eb;
	enum XK_Greek_mu = 0x07ec;
	enum XK_Greek_nu = 0x07ed;
	enum XK_Greek_xi = 0x07ee;
	enum XK_Greek_omicron = 0x07ef;
	enum XK_Greek_pi = 0x07f0;
	enum XK_Greek_rho = 0x07f1;
	enum XK_Greek_sigma = 0x07f2;
	enum XK_Greek_finalsmallsigma = 0x07f3;
	enum XK_Greek_tau = 0x07f4;
	enum XK_Greek_upsilon = 0x07f5;
	enum XK_Greek_phi = 0x07f6;
	enum XK_Greek_chi = 0x07f7;
	enum XK_Greek_psi = 0x07f8;
	enum XK_Greek_omega = 0x07f9;
	enum XK_Greek_switch = 0xff7e;

	enum XK_hebrew_doublelowline = 0x0cdf;
	enum XK_hebrew_aleph = 0x0ce0;
	enum XK_hebrew_bet = 0x0ce1;
	enum XK_hebrew_beth = 0x0ce1;
	enum XK_hebrew_gimel = 0x0ce2;
	enum XK_hebrew_gimmel = 0x0ce2;
	enum XK_hebrew_dalet = 0x0ce3;
	enum XK_hebrew_daleth = 0x0ce3;
	enum XK_hebrew_he = 0x0ce4;
	enum XK_hebrew_waw = 0x0ce5;
	enum XK_hebrew_zain = 0x0ce6;
	enum XK_hebrew_zayin = 0x0ce6;
	enum XK_hebrew_chet = 0x0ce7;
	enum XK_hebrew_het = 0x0ce7;
	enum XK_hebrew_tet = 0x0ce8;
	enum XK_hebrew_teth = 0x0ce8;
	enum XK_hebrew_yod = 0x0ce9;
	enum XK_hebrew_finalkaph = 0x0cea;
	enum XK_hebrew_kaph = 0x0ceb;
	enum XK_hebrew_lamed = 0x0cec;
	enum XK_hebrew_finalmem = 0x0ced;
	enum XK_hebrew_mem = 0x0cee;
	enum XK_hebrew_finalnun = 0x0cef;
	enum XK_hebrew_nun = 0x0cf0;
	enum XK_hebrew_samech = 0x0cf1;
	enum XK_hebrew_samekh = 0x0cf1;
	enum XK_hebrew_ayin = 0x0cf2;
	enum XK_hebrew_finalpe = 0x0cf3;
	enum XK_hebrew_pe = 0x0cf4;
	enum XK_hebrew_finalzade = 0x0cf5;
	enum XK_hebrew_finalzadi = 0x0cf5;
	enum XK_hebrew_zade = 0x0cf6;
	enum XK_hebrew_zadi = 0x0cf6;
	enum XK_hebrew_qoph = 0x0cf7;
	enum XK_hebrew_kuf = 0x0cf7;
	enum XK_hebrew_resh = 0x0cf8;
	enum XK_hebrew_shin = 0x0cf9;
	enum XK_hebrew_taw = 0x0cfa;
	enum XK_hebrew_taf = 0x0cfa;
	enum XK_Hebrew_switch = 0xff7e;

	enum XK_Thai_kokai = 0x0da1;
	enum XK_Thai_khokhai = 0x0da2;
	enum XK_Thai_khokhuat = 0x0da3;
	enum XK_Thai_khokhwai = 0x0da4;
	enum XK_Thai_khokhon = 0x0da5;
	enum XK_Thai_khorakhang = 0x0da6;
	enum XK_Thai_ngongu = 0x0da7;
	enum XK_Thai_chochan = 0x0da8;
	enum XK_Thai_choching = 0x0da9;
	enum XK_Thai_chochang = 0x0daa;
	enum XK_Thai_soso = 0x0dab;
	enum XK_Thai_chochoe = 0x0dac;
	enum XK_Thai_yoying = 0x0dad;
	enum XK_Thai_dochada = 0x0dae;
	enum XK_Thai_topatak = 0x0daf;
	enum XK_Thai_thothan = 0x0db0;
	enum XK_Thai_thonangmontho = 0x0db1;
	enum XK_Thai_thophuthao = 0x0db2;
	enum XK_Thai_nonen = 0x0db3;
	enum XK_Thai_dodek = 0x0db4;
	enum XK_Thai_totao = 0x0db5;
	enum XK_Thai_thothung = 0x0db6;
	enum XK_Thai_thothahan = 0x0db7;
	enum XK_Thai_thothong = 0x0db8;
	enum XK_Thai_nonu = 0x0db9;
	enum XK_Thai_bobaimai = 0x0dba;
	enum XK_Thai_popla = 0x0dbb;
	enum XK_Thai_phophung = 0x0dbc;
	enum XK_Thai_fofa = 0x0dbd;
	enum XK_Thai_phophan = 0x0dbe;
	enum XK_Thai_fofan = 0x0dbf;
	enum XK_Thai_phosamphao = 0x0dc0;
	enum XK_Thai_moma = 0x0dc1;
	enum XK_Thai_yoyak = 0x0dc2;
	enum XK_Thai_rorua = 0x0dc3;
	enum XK_Thai_ru = 0x0dc4;
	enum XK_Thai_loling = 0x0dc5;
	enum XK_Thai_lu = 0x0dc6;
	enum XK_Thai_wowaen = 0x0dc7;
	enum XK_Thai_sosala = 0x0dc8;
	enum XK_Thai_sorusi = 0x0dc9;
	enum XK_Thai_sosua = 0x0dca;
	enum XK_Thai_hohip = 0x0dcb;
	enum XK_Thai_lochula = 0x0dcc;
	enum XK_Thai_oang = 0x0dcd;
	enum XK_Thai_honokhuk = 0x0dce;
	enum XK_Thai_paiyannoi = 0x0dcf;
	enum XK_Thai_saraa = 0x0dd0;
	enum XK_Thai_maihanakat = 0x0dd1;
	enum XK_Thai_saraaa = 0x0dd2;
	enum XK_Thai_saraam = 0x0dd3;
	enum XK_Thai_sarai = 0x0dd4;
	enum XK_Thai_saraii = 0x0dd5;
	enum XK_Thai_saraue = 0x0dd6;
	enum XK_Thai_sarauee = 0x0dd7;
	enum XK_Thai_sarau = 0x0dd8;
	enum XK_Thai_sarauu = 0x0dd9;
	enum XK_Thai_phinthu = 0x0dda;
	enum XK_Thai_maihanakat_maitho = 0x0dde;
	enum XK_Thai_baht = 0x0ddf;
	enum XK_Thai_sarae = 0x0de0;
	enum XK_Thai_saraae = 0x0de1;
	enum XK_Thai_sarao = 0x0de2;
	enum XK_Thai_saraaimaimuan = 0x0de3;
	enum XK_Thai_saraaimaimalai = 0x0de4;
	enum XK_Thai_lakkhangyao = 0x0de5;
	enum XK_Thai_maiyamok = 0x0de6;
	enum XK_Thai_maitaikhu = 0x0de7;
	enum XK_Thai_maiek = 0x0de8;
	enum XK_Thai_maitho = 0x0de9;
	enum XK_Thai_maitri = 0x0dea;
	enum XK_Thai_maichattawa = 0x0deb;
	enum XK_Thai_thanthakhat = 0x0dec;
	enum XK_Thai_nikhahit = 0x0ded;
	enum XK_Thai_leksun = 0x0df0;
	enum XK_Thai_leknung = 0x0df1;
	enum XK_Thai_leksong = 0x0df2;
	enum XK_Thai_leksam = 0x0df3;
	enum XK_Thai_leksi = 0x0df4;
	enum XK_Thai_lekha = 0x0df5;
	enum XK_Thai_lekhok = 0x0df6;
	enum XK_Thai_lekchet = 0x0df7;
	enum XK_Thai_lekpaet = 0x0df8;
	enum XK_Thai_lekkao = 0x0df9;

	enum XK_Hangul = 0xff31;
	enum XK_Hangul_Start = 0xff32;
	enum XK_Hangul_End = 0xff33;
	enum XK_Hangul_Hanja = 0xff34;
	enum XK_Hangul_Jamo = 0xff35;
	enum XK_Hangul_Romaja = 0xff36;
	enum XK_Hangul_Codeinput = 0xff37;
	enum XK_Hangul_Jeonja = 0xff38;
	enum XK_Hangul_Banja = 0xff39;
	enum XK_Hangul_PreHanja = 0xff3a;
	enum XK_Hangul_PostHanja = 0xff3b;
	enum XK_Hangul_SingleCandidate = 0xff3c;
	enum XK_Hangul_MultipleCandidate = 0xff3d;
	enum XK_Hangul_PreviousCandidate = 0xff3e;
	enum XK_Hangul_Special = 0xff3f;
	enum XK_Hangul_switch = 0xff7e;

	enum XK_Hangul_Kiyeog = 0x0ea1;
	enum XK_Hangul_SsangKiyeog = 0x0ea2;
	enum XK_Hangul_KiyeogSios = 0x0ea3;
	enum XK_Hangul_Nieun = 0x0ea4;
	enum XK_Hangul_NieunJieuj = 0x0ea5;
	enum XK_Hangul_NieunHieuh = 0x0ea6;
	enum XK_Hangul_Dikeud = 0x0ea7;
	enum XK_Hangul_SsangDikeud = 0x0ea8;
	enum XK_Hangul_Rieul = 0x0ea9;
	enum XK_Hangul_RieulKiyeog = 0x0eaa;
	enum XK_Hangul_RieulMieum = 0x0eab;
	enum XK_Hangul_RieulPieub = 0x0eac;
	enum XK_Hangul_RieulSios = 0x0ead;
	enum XK_Hangul_RieulTieut = 0x0eae;
	enum XK_Hangul_RieulPhieuf = 0x0eaf;
	enum XK_Hangul_RieulHieuh = 0x0eb0;
	enum XK_Hangul_Mieum = 0x0eb1;
	enum XK_Hangul_Pieub = 0x0eb2;
	enum XK_Hangul_SsangPieub = 0x0eb3;
	enum XK_Hangul_PieubSios = 0x0eb4;
	enum XK_Hangul_Sios = 0x0eb5;
	enum XK_Hangul_SsangSios = 0x0eb6;
	enum XK_Hangul_Ieung = 0x0eb7;
	enum XK_Hangul_Jieuj = 0x0eb8;
	enum XK_Hangul_SsangJieuj = 0x0eb9;
	enum XK_Hangul_Cieuc = 0x0eba;
	enum XK_Hangul_Khieuq = 0x0ebb;
	enum XK_Hangul_Tieut = 0x0ebc;
	enum XK_Hangul_Phieuf = 0x0ebd;
	enum XK_Hangul_Hieuh = 0x0ebe;

	enum XK_Hangul_A = 0x0ebf;
	enum XK_Hangul_AE = 0x0ec0;
	enum XK_Hangul_YA = 0x0ec1;
	enum XK_Hangul_YAE = 0x0ec2;
	enum XK_Hangul_EO = 0x0ec3;
	enum XK_Hangul_E = 0x0ec4;
	enum XK_Hangul_YEO = 0x0ec5;
	enum XK_Hangul_YE = 0x0ec6;
	enum XK_Hangul_O = 0x0ec7;
	enum XK_Hangul_WA = 0x0ec8;
	enum XK_Hangul_WAE = 0x0ec9;
	enum XK_Hangul_OE = 0x0eca;
	enum XK_Hangul_YO = 0x0ecb;
	enum XK_Hangul_U = 0x0ecc;
	enum XK_Hangul_WEO = 0x0ecd;
	enum XK_Hangul_WE = 0x0ece;
	enum XK_Hangul_WI = 0x0ecf;
	enum XK_Hangul_YU = 0x0ed0;
	enum XK_Hangul_EU = 0x0ed1;
	enum XK_Hangul_YI = 0x0ed2;
	enum XK_Hangul_I = 0x0ed3;

	enum XK_Hangul_J_Kiyeog = 0x0ed4;
	enum XK_Hangul_J_SsangKiyeog = 0x0ed5;
	enum XK_Hangul_J_KiyeogSios = 0x0ed6;
	enum XK_Hangul_J_Nieun = 0x0ed7;
	enum XK_Hangul_J_NieunJieuj = 0x0ed8;
	enum XK_Hangul_J_NieunHieuh = 0x0ed9;
	enum XK_Hangul_J_Dikeud = 0x0eda;
	enum XK_Hangul_J_Rieul = 0x0edb;
	enum XK_Hangul_J_RieulKiyeog = 0x0edc;
	enum XK_Hangul_J_RieulMieum = 0x0edd;
	enum XK_Hangul_J_RieulPieub = 0x0ede;
	enum XK_Hangul_J_RieulSios = 0x0edf;
	enum XK_Hangul_J_RieulTieut = 0x0ee0;
	enum XK_Hangul_J_RieulPhieuf = 0x0ee1;
	enum XK_Hangul_J_RieulHieuh = 0x0ee2;
	enum XK_Hangul_J_Mieum = 0x0ee3;
	enum XK_Hangul_J_Pieub = 0x0ee4;
	enum XK_Hangul_J_PieubSios = 0x0ee5;
	enum XK_Hangul_J_Sios = 0x0ee6;
	enum XK_Hangul_J_SsangSios = 0x0ee7;
	enum XK_Hangul_J_Ieung = 0x0ee8;
	enum XK_Hangul_J_Jieuj = 0x0ee9;
	enum XK_Hangul_J_Cieuc = 0x0eea;
	enum XK_Hangul_J_Khieuq = 0x0eeb;
	enum XK_Hangul_J_Tieut = 0x0eec;
	enum XK_Hangul_J_Phieuf = 0x0eed;
	enum XK_Hangul_J_Hieuh = 0x0eee;

	enum XK_Hangul_RieulYeorinHieuh = 0x0eef;
	enum XK_Hangul_SunkyeongeumMieum = 0x0ef0;
	enum XK_Hangul_SunkyeongeumPieub = 0x0ef1;
	enum XK_Hangul_PanSios = 0x0ef2;
	enum XK_Hangul_KkogjiDalrinIeung = 0x0ef3;
	enum XK_Hangul_SunkyeongeumPhieuf = 0x0ef4;
	enum XK_Hangul_YeorinHieuh = 0x0ef5;

	enum XK_Hangul_AraeA = 0x0ef6;
	enum XK_Hangul_AraeAE = 0x0ef7;

	enum XK_Hangul_J_PanSios = 0x0ef8;
	enum XK_Hangul_J_KkogjiDalrinIeung = 0x0ef9;
	enum XK_Hangul_J_YeorinHieuh = 0x0efa;

	enum XK_Korean_Won = 0x0eff;

	enum XK_Armenian_ligature_ew = 0x1000587;
	enum XK_Armenian_full_stop = 0x1000589;
	enum XK_Armenian_verjaket = 0x1000589;
	enum XK_Armenian_separation_mark = 0x100055d;
	enum XK_Armenian_but = 0x100055d;
	enum XK_Armenian_hyphen = 0x100058a;
	enum XK_Armenian_yentamna = 0x100058a;
	enum XK_Armenian_exclam = 0x100055c;
	enum XK_Armenian_amanak = 0x100055c;
	enum XK_Armenian_accent = 0x100055b;
	enum XK_Armenian_shesht = 0x100055b;
	enum XK_Armenian_question = 0x100055e;
	enum XK_Armenian_paruyk = 0x100055e;
	enum XK_Armenian_AYB = 0x1000531;
	enum XK_Armenian_ayb = 0x1000561;
	enum XK_Armenian_BEN = 0x1000532;
	enum XK_Armenian_ben = 0x1000562;
	enum XK_Armenian_GIM = 0x1000533;
	enum XK_Armenian_gim = 0x1000563;
	enum XK_Armenian_DA = 0x1000534;
	enum XK_Armenian_da = 0x1000564;
	enum XK_Armenian_YECH = 0x1000535;
	enum XK_Armenian_yech = 0x1000565;
	enum XK_Armenian_ZA = 0x1000536;
	enum XK_Armenian_za = 0x1000566;
	enum XK_Armenian_E = 0x1000537;
	enum XK_Armenian_e = 0x1000567;
	enum XK_Armenian_AT = 0x1000538;
	enum XK_Armenian_at = 0x1000568;
	enum XK_Armenian_TO = 0x1000539;
	enum XK_Armenian_to = 0x1000569;
	enum XK_Armenian_ZHE = 0x100053a;
	enum XK_Armenian_zhe = 0x100056a;
	enum XK_Armenian_INI = 0x100053b;
	enum XK_Armenian_ini = 0x100056b;
	enum XK_Armenian_LYUN = 0x100053c;
	enum XK_Armenian_lyun = 0x100056c;
	enum XK_Armenian_KHE = 0x100053d;
	enum XK_Armenian_khe = 0x100056d;
	enum XK_Armenian_TSA = 0x100053e;
	enum XK_Armenian_tsa = 0x100056e;
	enum XK_Armenian_KEN = 0x100053f;
	enum XK_Armenian_ken = 0x100056f;
	enum XK_Armenian_HO = 0x1000540;
	enum XK_Armenian_ho = 0x1000570;
	enum XK_Armenian_DZA = 0x1000541;
	enum XK_Armenian_dza = 0x1000571;
	enum XK_Armenian_GHAT = 0x1000542;
	enum XK_Armenian_ghat = 0x1000572;
	enum XK_Armenian_TCHE = 0x1000543;
	enum XK_Armenian_tche = 0x1000573;
	enum XK_Armenian_MEN = 0x1000544;
	enum XK_Armenian_men = 0x1000574;
	enum XK_Armenian_HI = 0x1000545;
	enum XK_Armenian_hi = 0x1000575;
	enum XK_Armenian_NU = 0x1000546;
	enum XK_Armenian_nu = 0x1000576;
	enum XK_Armenian_SHA = 0x1000547;
	enum XK_Armenian_sha = 0x1000577;
	enum XK_Armenian_VO = 0x1000548;
	enum XK_Armenian_vo = 0x1000578;
	enum XK_Armenian_CHA = 0x1000549;
	enum XK_Armenian_cha = 0x1000579;
	enum XK_Armenian_PE = 0x100054a;
	enum XK_Armenian_pe = 0x100057a;
	enum XK_Armenian_JE = 0x100054b;
	enum XK_Armenian_je = 0x100057b;
	enum XK_Armenian_RA = 0x100054c;
	enum XK_Armenian_ra = 0x100057c;
	enum XK_Armenian_SE = 0x100054d;
	enum XK_Armenian_se = 0x100057d;
	enum XK_Armenian_VEV = 0x100054e;
	enum XK_Armenian_vev = 0x100057e;
	enum XK_Armenian_TYUN = 0x100054f;
	enum XK_Armenian_tyun = 0x100057f;
	enum XK_Armenian_RE = 0x1000550;
	enum XK_Armenian_re = 0x1000580;
	enum XK_Armenian_TSO = 0x1000551;
	enum XK_Armenian_tso = 0x1000581;
	enum XK_Armenian_VYUN = 0x1000552;
	enum XK_Armenian_vyun = 0x1000582;
	enum XK_Armenian_PYUR = 0x1000553;
	enum XK_Armenian_pyur = 0x1000583;
	enum XK_Armenian_KE = 0x1000554;
	enum XK_Armenian_ke = 0x1000584;
	enum XK_Armenian_O = 0x1000555;
	enum XK_Armenian_o = 0x1000585;
	enum XK_Armenian_FE = 0x1000556;
	enum XK_Armenian_fe = 0x1000586;
	enum XK_Armenian_apostrophe = 0x100055a;

	enum XK_Georgian_an = 0x10010d0;
	enum XK_Georgian_ban = 0x10010d1;
	enum XK_Georgian_gan = 0x10010d2;
	enum XK_Georgian_don = 0x10010d3;
	enum XK_Georgian_en = 0x10010d4;
	enum XK_Georgian_vin = 0x10010d5;
	enum XK_Georgian_zen = 0x10010d6;
	enum XK_Georgian_tan = 0x10010d7;
	enum XK_Georgian_in = 0x10010d8;
	enum XK_Georgian_kan = 0x10010d9;
	enum XK_Georgian_las = 0x10010da;
	enum XK_Georgian_man = 0x10010db;
	enum XK_Georgian_nar = 0x10010dc;
	enum XK_Georgian_on = 0x10010dd;
	enum XK_Georgian_par = 0x10010de;
	enum XK_Georgian_zhar = 0x10010df;
	enum XK_Georgian_rae = 0x10010e0;
	enum XK_Georgian_san = 0x10010e1;
	enum XK_Georgian_tar = 0x10010e2;
	enum XK_Georgian_un = 0x10010e3;
	enum XK_Georgian_phar = 0x10010e4;
	enum XK_Georgian_khar = 0x10010e5;
	enum XK_Georgian_ghan = 0x10010e6;
	enum XK_Georgian_qar = 0x10010e7;
	enum XK_Georgian_shin = 0x10010e8;
	enum XK_Georgian_chin = 0x10010e9;
	enum XK_Georgian_can = 0x10010ea;
	enum XK_Georgian_jil = 0x10010eb;
	enum XK_Georgian_cil = 0x10010ec;
	enum XK_Georgian_char = 0x10010ed;
	enum XK_Georgian_xan = 0x10010ee;
	enum XK_Georgian_jhan = 0x10010ef;
	enum XK_Georgian_hae = 0x10010f0;
	enum XK_Georgian_he = 0x10010f1;
	enum XK_Georgian_hie = 0x10010f2;
	enum XK_Georgian_we = 0x10010f3;
	enum XK_Georgian_har = 0x10010f4;
	enum XK_Georgian_hoe = 0x10010f5;
	enum XK_Georgian_fi = 0x10010f6;

	enum XK_Xabovedot = 0x1001e8a;
	enum XK_Ibreve = 0x100012c;
	enum XK_Zstroke = 0x10001b5;
	enum XK_Gcaron = 0x10001e6;
	enum XK_Ocaron = 0x10001d1;
	enum XK_Obarred = 0x100019f;
	enum XK_xabovedot = 0x1001e8b;
	enum XK_ibreve = 0x100012d;
	enum XK_zstroke = 0x10001b6;
	enum XK_gcaron = 0x10001e7;
	enum XK_ocaron = 0x10001d2;
	enum XK_obarred = 0x1000275;
	enum XK_SCHWA = 0x100018f;
	enum XK_schwa = 0x1000259;
	enum XK_EZH = 0x10001b7;
	enum XK_ezh = 0x1000292;

	enum XK_Lbelowdot = 0x1001e36;
	enum XK_lbelowdot = 0x1001e37;

	enum XK_Abelowdot = 0x1001ea0;
	enum XK_abelowdot = 0x1001ea1;
	enum XK_Ahook = 0x1001ea2;
	enum XK_ahook = 0x1001ea3;
	enum XK_Acircumflexacute = 0x1001ea4;
	enum XK_acircumflexacute = 0x1001ea5;
	enum XK_Acircumflexgrave = 0x1001ea6;
	enum XK_acircumflexgrave = 0x1001ea7;
	enum XK_Acircumflexhook = 0x1001ea8;
	enum XK_acircumflexhook = 0x1001ea9;
	enum XK_Acircumflextilde = 0x1001eaa;
	enum XK_acircumflextilde = 0x1001eab;
	enum XK_Acircumflexbelowdot = 0x1001eac;
	enum XK_acircumflexbelowdot = 0x1001ead;
	enum XK_Abreveacute = 0x1001eae;
	enum XK_abreveacute = 0x1001eaf;
	enum XK_Abrevegrave = 0x1001eb0;
	enum XK_abrevegrave = 0x1001eb1;
	enum XK_Abrevehook = 0x1001eb2;
	enum XK_abrevehook = 0x1001eb3;
	enum XK_Abrevetilde = 0x1001eb4;
	enum XK_abrevetilde = 0x1001eb5;
	enum XK_Abrevebelowdot = 0x1001eb6;
	enum XK_abrevebelowdot = 0x1001eb7;
	enum XK_Ebelowdot = 0x1001eb8;
	enum XK_ebelowdot = 0x1001eb9;
	enum XK_Ehook = 0x1001eba;
	enum XK_ehook = 0x1001ebb;
	enum XK_Etilde = 0x1001ebc;
	enum XK_etilde = 0x1001ebd;
	enum XK_Ecircumflexacute = 0x1001ebe;
	enum XK_ecircumflexacute = 0x1001ebf;
	enum XK_Ecircumflexgrave = 0x1001ec0;
	enum XK_ecircumflexgrave = 0x1001ec1;
	enum XK_Ecircumflexhook = 0x1001ec2;
	enum XK_ecircumflexhook = 0x1001ec3;
	enum XK_Ecircumflextilde = 0x1001ec4;
	enum XK_ecircumflextilde = 0x1001ec5;
	enum XK_Ecircumflexbelowdot = 0x1001ec6;
	enum XK_ecircumflexbelowdot = 0x1001ec7;
	enum XK_Ihook = 0x1001ec8;
	enum XK_ihook = 0x1001ec9;
	enum XK_Ibelowdot = 0x1001eca;
	enum XK_ibelowdot = 0x1001ecb;
	enum XK_Obelowdot = 0x1001ecc;
	enum XK_obelowdot = 0x1001ecd;
	enum XK_Ohook = 0x1001ece;
	enum XK_ohook = 0x1001ecf;
	enum XK_Ocircumflexacute = 0x1001ed0;
	enum XK_ocircumflexacute = 0x1001ed1;
	enum XK_Ocircumflexgrave = 0x1001ed2;
	enum XK_ocircumflexgrave = 0x1001ed3;
	enum XK_Ocircumflexhook = 0x1001ed4;
	enum XK_ocircumflexhook = 0x1001ed5;
	enum XK_Ocircumflextilde = 0x1001ed6;
	enum XK_ocircumflextilde = 0x1001ed7;
	enum XK_Ocircumflexbelowdot = 0x1001ed8;
	enum XK_ocircumflexbelowdot = 0x1001ed9;
	enum XK_Ohornacute = 0x1001eda;
	enum XK_ohornacute = 0x1001edb;
	enum XK_Ohorngrave = 0x1001edc;
	enum XK_ohorngrave = 0x1001edd;
	enum XK_Ohornhook = 0x1001ede;
	enum XK_ohornhook = 0x1001edf;
	enum XK_Ohorntilde = 0x1001ee0;
	enum XK_ohorntilde = 0x1001ee1;
	enum XK_Ohornbelowdot = 0x1001ee2;
	enum XK_ohornbelowdot = 0x1001ee3;
	enum XK_Ubelowdot = 0x1001ee4;
	enum XK_ubelowdot = 0x1001ee5;
	enum XK_Uhook = 0x1001ee6;
	enum XK_uhook = 0x1001ee7;
	enum XK_Uhornacute = 0x1001ee8;
	enum XK_uhornacute = 0x1001ee9;
	enum XK_Uhorngrave = 0x1001eea;
	enum XK_uhorngrave = 0x1001eeb;
	enum XK_Uhornhook = 0x1001eec;
	enum XK_uhornhook = 0x1001eed;
	enum XK_Uhorntilde = 0x1001eee;
	enum XK_uhorntilde = 0x1001eef;
	enum XK_Uhornbelowdot = 0x1001ef0;
	enum XK_uhornbelowdot = 0x1001ef1;
	enum XK_Ybelowdot = 0x1001ef4;
	enum XK_ybelowdot = 0x1001ef5;
	enum XK_Yhook = 0x1001ef6;
	enum XK_yhook = 0x1001ef7;
	enum XK_Ytilde = 0x1001ef8;
	enum XK_ytilde = 0x1001ef9;
	enum XK_Ohorn = 0x10001a0;
	enum XK_ohorn = 0x10001a1;
	enum XK_Uhorn = 0x10001af;
	enum XK_uhorn = 0x10001b0;
	enum XK_combining_tilde = 0x1000303;
	enum XK_combining_grave = 0x1000300;
	enum XK_combining_acute = 0x1000301;
	enum XK_combining_hook = 0x1000309;
	enum XK_combining_belowdot = 0x1000323;

	enum XK_EcuSign = 0x10020a0;
	enum XK_ColonSign = 0x10020a1;
	enum XK_CruzeiroSign = 0x10020a2;
	enum XK_FFrancSign = 0x10020a3;
	enum XK_LiraSign = 0x10020a4;
	enum XK_MillSign = 0x10020a5;
	enum XK_NairaSign = 0x10020a6;
	enum XK_PesetaSign = 0x10020a7;
	enum XK_RupeeSign = 0x10020a8;
	enum XK_WonSign = 0x10020a9;
	enum XK_NewSheqelSign = 0x10020aa;
	enum XK_DongSign = 0x10020ab;
	enum XK_EuroSign = 0x20ac;

	enum XK_zerosuperior = 0x1002070;
	enum XK_foursuperior = 0x1002074;
	enum XK_fivesuperior = 0x1002075;
	enum XK_sixsuperior = 0x1002076;
	enum XK_sevensuperior = 0x1002077;
	enum XK_eightsuperior = 0x1002078;
	enum XK_ninesuperior = 0x1002079;
	enum XK_zerosubscript = 0x1002080;
	enum XK_onesubscript = 0x1002081;
	enum XK_twosubscript = 0x1002082;
	enum XK_threesubscript = 0x1002083;
	enum XK_foursubscript = 0x1002084;
	enum XK_fivesubscript = 0x1002085;
	enum XK_sixsubscript = 0x1002086;
	enum XK_sevensubscript = 0x1002087;
	enum XK_eightsubscript = 0x1002088;
	enum XK_ninesubscript = 0x1002089;
	enum XK_partdifferential = 0x1002202;
	enum XK_emptyset = 0x1002205;
	enum XK_elementof = 0x1002208;
	enum XK_notelementof = 0x1002209;
	enum XK_containsas = 0x100220B;
	enum XK_squareroot = 0x100221A;
	enum XK_cuberoot = 0x100221B;
	enum XK_fourthroot = 0x100221C;
	enum XK_dintegral = 0x100222C;
	enum XK_tintegral = 0x100222D;
	enum XK_because = 0x1002235;
	enum XK_approxeq = 0x1002248;
	enum XK_notapproxeq = 0x1002247;
	enum XK_notidentical = 0x1002262;
	enum XK_stricteq = 0x1002263;

	enum XK_braille_dot_1 = 0xfff1;
	enum XK_braille_dot_2 = 0xfff2;
	enum XK_braille_dot_3 = 0xfff3;
	enum XK_braille_dot_4 = 0xfff4;
	enum XK_braille_dot_5 = 0xfff5;
	enum XK_braille_dot_6 = 0xfff6;
	enum XK_braille_dot_7 = 0xfff7;
	enum XK_braille_dot_8 = 0xfff8;
	enum XK_braille_dot_9 = 0xfff9;
	enum XK_braille_dot_10 = 0xfffa;
	enum XK_braille_blank = 0x1002800;
	enum XK_braille_dots_1 = 0x1002801;
	enum XK_braille_dots_2 = 0x1002802;
	enum XK_braille_dots_12 = 0x1002803;
	enum XK_braille_dots_3 = 0x1002804;
	enum XK_braille_dots_13 = 0x1002805;
	enum XK_braille_dots_23 = 0x1002806;
	enum XK_braille_dots_123 = 0x1002807;
	enum XK_braille_dots_4 = 0x1002808;
	enum XK_braille_dots_14 = 0x1002809;
	enum XK_braille_dots_24 = 0x100280a;
	enum XK_braille_dots_124 = 0x100280b;
	enum XK_braille_dots_34 = 0x100280c;
	enum XK_braille_dots_134 = 0x100280d;
	enum XK_braille_dots_234 = 0x100280e;
	enum XK_braille_dots_1234 = 0x100280f;
	enum XK_braille_dots_5 = 0x1002810;
	enum XK_braille_dots_15 = 0x1002811;
	enum XK_braille_dots_25 = 0x1002812;
	enum XK_braille_dots_125 = 0x1002813;
	enum XK_braille_dots_35 = 0x1002814;
	enum XK_braille_dots_135 = 0x1002815;
	enum XK_braille_dots_235 = 0x1002816;
	enum XK_braille_dots_1235 = 0x1002817;
	enum XK_braille_dots_45 = 0x1002818;
	enum XK_braille_dots_145 = 0x1002819;
	enum XK_braille_dots_245 = 0x100281a;
	enum XK_braille_dots_1245 = 0x100281b;
	enum XK_braille_dots_345 = 0x100281c;
	enum XK_braille_dots_1345 = 0x100281d;
	enum XK_braille_dots_2345 = 0x100281e;
	enum XK_braille_dots_12345 = 0x100281f;
	enum XK_braille_dots_6 = 0x1002820;
	enum XK_braille_dots_16 = 0x1002821;
	enum XK_braille_dots_26 = 0x1002822;
	enum XK_braille_dots_126 = 0x1002823;
	enum XK_braille_dots_36 = 0x1002824;
	enum XK_braille_dots_136 = 0x1002825;
	enum XK_braille_dots_236 = 0x1002826;
	enum XK_braille_dots_1236 = 0x1002827;
	enum XK_braille_dots_46 = 0x1002828;
	enum XK_braille_dots_146 = 0x1002829;
	enum XK_braille_dots_246 = 0x100282a;
	enum XK_braille_dots_1246 = 0x100282b;
	enum XK_braille_dots_346 = 0x100282c;
	enum XK_braille_dots_1346 = 0x100282d;
	enum XK_braille_dots_2346 = 0x100282e;
	enum XK_braille_dots_12346 = 0x100282f;
	enum XK_braille_dots_56 = 0x1002830;
	enum XK_braille_dots_156 = 0x1002831;
	enum XK_braille_dots_256 = 0x1002832;
	enum XK_braille_dots_1256 = 0x1002833;
	enum XK_braille_dots_356 = 0x1002834;
	enum XK_braille_dots_1356 = 0x1002835;
	enum XK_braille_dots_2356 = 0x1002836;
	enum XK_braille_dots_12356 = 0x1002837;
	enum XK_braille_dots_456 = 0x1002838;
	enum XK_braille_dots_1456 = 0x1002839;
	enum XK_braille_dots_2456 = 0x100283a;
	enum XK_braille_dots_12456 = 0x100283b;
	enum XK_braille_dots_3456 = 0x100283c;
	enum XK_braille_dots_13456 = 0x100283d;
	enum XK_braille_dots_23456 = 0x100283e;
	enum XK_braille_dots_123456 = 0x100283f;
	enum XK_braille_dots_7 = 0x1002840;
	enum XK_braille_dots_17 = 0x1002841;
	enum XK_braille_dots_27 = 0x1002842;
	enum XK_braille_dots_127 = 0x1002843;
	enum XK_braille_dots_37 = 0x1002844;
	enum XK_braille_dots_137 = 0x1002845;
	enum XK_braille_dots_237 = 0x1002846;
	enum XK_braille_dots_1237 = 0x1002847;
	enum XK_braille_dots_47 = 0x1002848;
	enum XK_braille_dots_147 = 0x1002849;
	enum XK_braille_dots_247 = 0x100284a;
	enum XK_braille_dots_1247 = 0x100284b;
	enum XK_braille_dots_347 = 0x100284c;
	enum XK_braille_dots_1347 = 0x100284d;
	enum XK_braille_dots_2347 = 0x100284e;
	enum XK_braille_dots_12347 = 0x100284f;
	enum XK_braille_dots_57 = 0x1002850;
	enum XK_braille_dots_157 = 0x1002851;
	enum XK_braille_dots_257 = 0x1002852;
	enum XK_braille_dots_1257 = 0x1002853;
	enum XK_braille_dots_357 = 0x1002854;
	enum XK_braille_dots_1357 = 0x1002855;
	enum XK_braille_dots_2357 = 0x1002856;
	enum XK_braille_dots_12357 = 0x1002857;
	enum XK_braille_dots_457 = 0x1002858;
	enum XK_braille_dots_1457 = 0x1002859;
	enum XK_braille_dots_2457 = 0x100285a;
	enum XK_braille_dots_12457 = 0x100285b;
	enum XK_braille_dots_3457 = 0x100285c;
	enum XK_braille_dots_13457 = 0x100285d;
	enum XK_braille_dots_23457 = 0x100285e;
	enum XK_braille_dots_123457 = 0x100285f;
	enum XK_braille_dots_67 = 0x1002860;
	enum XK_braille_dots_167 = 0x1002861;
	enum XK_braille_dots_267 = 0x1002862;
	enum XK_braille_dots_1267 = 0x1002863;
	enum XK_braille_dots_367 = 0x1002864;
	enum XK_braille_dots_1367 = 0x1002865;
	enum XK_braille_dots_2367 = 0x1002866;
	enum XK_braille_dots_12367 = 0x1002867;
	enum XK_braille_dots_467 = 0x1002868;
	enum XK_braille_dots_1467 = 0x1002869;
	enum XK_braille_dots_2467 = 0x100286a;
	enum XK_braille_dots_12467 = 0x100286b;
	enum XK_braille_dots_3467 = 0x100286c;
	enum XK_braille_dots_13467 = 0x100286d;
	enum XK_braille_dots_23467 = 0x100286e;
	enum XK_braille_dots_123467 = 0x100286f;
	enum XK_braille_dots_567 = 0x1002870;
	enum XK_braille_dots_1567 = 0x1002871;
	enum XK_braille_dots_2567 = 0x1002872;
	enum XK_braille_dots_12567 = 0x1002873;
	enum XK_braille_dots_3567 = 0x1002874;
	enum XK_braille_dots_13567 = 0x1002875;
	enum XK_braille_dots_23567 = 0x1002876;
	enum XK_braille_dots_123567 = 0x1002877;
	enum XK_braille_dots_4567 = 0x1002878;
	enum XK_braille_dots_14567 = 0x1002879;
	enum XK_braille_dots_24567 = 0x100287a;
	enum XK_braille_dots_124567 = 0x100287b;
	enum XK_braille_dots_34567 = 0x100287c;
	enum XK_braille_dots_134567 = 0x100287d;
	enum XK_braille_dots_234567 = 0x100287e;
	enum XK_braille_dots_1234567 = 0x100287f;
	enum XK_braille_dots_8 = 0x1002880;
	enum XK_braille_dots_18 = 0x1002881;
	enum XK_braille_dots_28 = 0x1002882;
	enum XK_braille_dots_128 = 0x1002883;
	enum XK_braille_dots_38 = 0x1002884;
	enum XK_braille_dots_138 = 0x1002885;
	enum XK_braille_dots_238 = 0x1002886;
	enum XK_braille_dots_1238 = 0x1002887;
	enum XK_braille_dots_48 = 0x1002888;
	enum XK_braille_dots_148 = 0x1002889;
	enum XK_braille_dots_248 = 0x100288a;
	enum XK_braille_dots_1248 = 0x100288b;
	enum XK_braille_dots_348 = 0x100288c;
	enum XK_braille_dots_1348 = 0x100288d;
	enum XK_braille_dots_2348 = 0x100288e;
	enum XK_braille_dots_12348 = 0x100288f;
	enum XK_braille_dots_58 = 0x1002890;
	enum XK_braille_dots_158 = 0x1002891;
	enum XK_braille_dots_258 = 0x1002892;
	enum XK_braille_dots_1258 = 0x1002893;
	enum XK_braille_dots_358 = 0x1002894;
	enum XK_braille_dots_1358 = 0x1002895;
	enum XK_braille_dots_2358 = 0x1002896;
	enum XK_braille_dots_12358 = 0x1002897;
	enum XK_braille_dots_458 = 0x1002898;
	enum XK_braille_dots_1458 = 0x1002899;
	enum XK_braille_dots_2458 = 0x100289a;
	enum XK_braille_dots_12458 = 0x100289b;
	enum XK_braille_dots_3458 = 0x100289c;
	enum XK_braille_dots_13458 = 0x100289d;
	enum XK_braille_dots_23458 = 0x100289e;
	enum XK_braille_dots_123458 = 0x100289f;
	enum XK_braille_dots_68 = 0x10028a0;
	enum XK_braille_dots_168 = 0x10028a1;
	enum XK_braille_dots_268 = 0x10028a2;
	enum XK_braille_dots_1268 = 0x10028a3;
	enum XK_braille_dots_368 = 0x10028a4;
	enum XK_braille_dots_1368 = 0x10028a5;
	enum XK_braille_dots_2368 = 0x10028a6;
	enum XK_braille_dots_12368 = 0x10028a7;
	enum XK_braille_dots_468 = 0x10028a8;
	enum XK_braille_dots_1468 = 0x10028a9;
	enum XK_braille_dots_2468 = 0x10028aa;
	enum XK_braille_dots_12468 = 0x10028ab;
	enum XK_braille_dots_3468 = 0x10028ac;
	enum XK_braille_dots_13468 = 0x10028ad;
	enum XK_braille_dots_23468 = 0x10028ae;
	enum XK_braille_dots_123468 = 0x10028af;
	enum XK_braille_dots_568 = 0x10028b0;
	enum XK_braille_dots_1568 = 0x10028b1;
	enum XK_braille_dots_2568 = 0x10028b2;
	enum XK_braille_dots_12568 = 0x10028b3;
	enum XK_braille_dots_3568 = 0x10028b4;
	enum XK_braille_dots_13568 = 0x10028b5;
	enum XK_braille_dots_23568 = 0x10028b6;
	enum XK_braille_dots_123568 = 0x10028b7;
	enum XK_braille_dots_4568 = 0x10028b8;
	enum XK_braille_dots_14568 = 0x10028b9;
	enum XK_braille_dots_24568 = 0x10028ba;
	enum XK_braille_dots_124568 = 0x10028bb;
	enum XK_braille_dots_34568 = 0x10028bc;
	enum XK_braille_dots_134568 = 0x10028bd;
	enum XK_braille_dots_234568 = 0x10028be;
	enum XK_braille_dots_1234568 = 0x10028bf;
	enum XK_braille_dots_78 = 0x10028c0;
	enum XK_braille_dots_178 = 0x10028c1;
	enum XK_braille_dots_278 = 0x10028c2;
	enum XK_braille_dots_1278 = 0x10028c3;
	enum XK_braille_dots_378 = 0x10028c4;
	enum XK_braille_dots_1378 = 0x10028c5;
	enum XK_braille_dots_2378 = 0x10028c6;
	enum XK_braille_dots_12378 = 0x10028c7;
	enum XK_braille_dots_478 = 0x10028c8;
	enum XK_braille_dots_1478 = 0x10028c9;
	enum XK_braille_dots_2478 = 0x10028ca;
	enum XK_braille_dots_12478 = 0x10028cb;
	enum XK_braille_dots_3478 = 0x10028cc;
	enum XK_braille_dots_13478 = 0x10028cd;
	enum XK_braille_dots_23478 = 0x10028ce;
	enum XK_braille_dots_123478 = 0x10028cf;
	enum XK_braille_dots_578 = 0x10028d0;
	enum XK_braille_dots_1578 = 0x10028d1;
	enum XK_braille_dots_2578 = 0x10028d2;
	enum XK_braille_dots_12578 = 0x10028d3;
	enum XK_braille_dots_3578 = 0x10028d4;
	enum XK_braille_dots_13578 = 0x10028d5;
	enum XK_braille_dots_23578 = 0x10028d6;
	enum XK_braille_dots_123578 = 0x10028d7;
	enum XK_braille_dots_4578 = 0x10028d8;
	enum XK_braille_dots_14578 = 0x10028d9;
	enum XK_braille_dots_24578 = 0x10028da;
	enum XK_braille_dots_124578 = 0x10028db;
	enum XK_braille_dots_34578 = 0x10028dc;
	enum XK_braille_dots_134578 = 0x10028dd;
	enum XK_braille_dots_234578 = 0x10028de;
	enum XK_braille_dots_1234578 = 0x10028df;
	enum XK_braille_dots_678 = 0x10028e0;
	enum XK_braille_dots_1678 = 0x10028e1;
	enum XK_braille_dots_2678 = 0x10028e2;
	enum XK_braille_dots_12678 = 0x10028e3;
	enum XK_braille_dots_3678 = 0x10028e4;
	enum XK_braille_dots_13678 = 0x10028e5;
	enum XK_braille_dots_23678 = 0x10028e6;
	enum XK_braille_dots_123678 = 0x10028e7;
	enum XK_braille_dots_4678 = 0x10028e8;
	enum XK_braille_dots_14678 = 0x10028e9;
	enum XK_braille_dots_24678 = 0x10028ea;
	enum XK_braille_dots_124678 = 0x10028eb;
	enum XK_braille_dots_34678 = 0x10028ec;
	enum XK_braille_dots_134678 = 0x10028ed;
	enum XK_braille_dots_234678 = 0x10028ee;
	enum XK_braille_dots_1234678 = 0x10028ef;
	enum XK_braille_dots_5678 = 0x10028f0;
	enum XK_braille_dots_15678 = 0x10028f1;
	enum XK_braille_dots_25678 = 0x10028f2;
	enum XK_braille_dots_125678 = 0x10028f3;
	enum XK_braille_dots_35678 = 0x10028f4;
	enum XK_braille_dots_135678 = 0x10028f5;
	enum XK_braille_dots_235678 = 0x10028f6;
	enum XK_braille_dots_1235678 = 0x10028f7;
	enum XK_braille_dots_45678 = 0x10028f8;
	enum XK_braille_dots_145678 = 0x10028f9;
	enum XK_braille_dots_245678 = 0x10028fa;
	enum XK_braille_dots_1245678 = 0x10028fb;
	enum XK_braille_dots_345678 = 0x10028fc;
	enum XK_braille_dots_1345678 = 0x10028fd;
	enum XK_braille_dots_2345678 = 0x10028fe;
	enum XK_braille_dots_12345678 = 0x10028ff;

	enum XK_Sinh_ng = 0x1000d82;
	enum XK_Sinh_h2 = 0x1000d83;
	enum XK_Sinh_a = 0x1000d85;
	enum XK_Sinh_aa = 0x1000d86;
	enum XK_Sinh_ae = 0x1000d87;
	enum XK_Sinh_aee = 0x1000d88;
	enum XK_Sinh_i = 0x1000d89;
	enum XK_Sinh_ii = 0x1000d8a;
	enum XK_Sinh_u = 0x1000d8b;
	enum XK_Sinh_uu = 0x1000d8c;
	enum XK_Sinh_ri = 0x1000d8d;
	enum XK_Sinh_rii = 0x1000d8e;
	enum XK_Sinh_lu = 0x1000d8f;
	enum XK_Sinh_luu = 0x1000d90;
	enum XK_Sinh_e = 0x1000d91;
	enum XK_Sinh_ee = 0x1000d92;
	enum XK_Sinh_ai = 0x1000d93;
	enum XK_Sinh_o = 0x1000d94;
	enum XK_Sinh_oo = 0x1000d95;
	enum XK_Sinh_au = 0x1000d96;
	enum XK_Sinh_ka = 0x1000d9a;
	enum XK_Sinh_kha = 0x1000d9b;
	enum XK_Sinh_ga = 0x1000d9c;
	enum XK_Sinh_gha = 0x1000d9d;
	enum XK_Sinh_ng2 = 0x1000d9e;
	enum XK_Sinh_nga = 0x1000d9f;
	enum XK_Sinh_ca = 0x1000da0;
	enum XK_Sinh_cha = 0x1000da1;
	enum XK_Sinh_ja = 0x1000da2;
	enum XK_Sinh_jha = 0x1000da3;
	enum XK_Sinh_nya = 0x1000da4;
	enum XK_Sinh_jnya = 0x1000da5;
	enum XK_Sinh_nja = 0x1000da6;
	enum XK_Sinh_tta = 0x1000da7;
	enum XK_Sinh_ttha = 0x1000da8;
	enum XK_Sinh_dda = 0x1000da9;
	enum XK_Sinh_ddha = 0x1000daa;
	enum XK_Sinh_nna = 0x1000dab;
	enum XK_Sinh_ndda = 0x1000dac;
	enum XK_Sinh_tha = 0x1000dad;
	enum XK_Sinh_thha = 0x1000dae;
	enum XK_Sinh_dha = 0x1000daf;
	enum XK_Sinh_dhha = 0x1000db0;
	enum XK_Sinh_na = 0x1000db1;
	enum XK_Sinh_ndha = 0x1000db3;
	enum XK_Sinh_pa = 0x1000db4;
	enum XK_Sinh_pha = 0x1000db5;
	enum XK_Sinh_ba = 0x1000db6;
	enum XK_Sinh_bha = 0x1000db7;
	enum XK_Sinh_ma = 0x1000db8;
	enum XK_Sinh_mba = 0x1000db9;
	enum XK_Sinh_ya = 0x1000dba;
	enum XK_Sinh_ra = 0x1000dbb;
	enum XK_Sinh_la = 0x1000dbd;
	enum XK_Sinh_va = 0x1000dc0;
	enum XK_Sinh_sha = 0x1000dc1;
	enum XK_Sinh_ssha = 0x1000dc2;
	enum XK_Sinh_sa = 0x1000dc3;
	enum XK_Sinh_ha = 0x1000dc4;
	enum XK_Sinh_lla = 0x1000dc5;
	enum XK_Sinh_fa = 0x1000dc6;
	enum XK_Sinh_al = 0x1000dca;
	enum XK_Sinh_aa2 = 0x1000dcf;
	enum XK_Sinh_ae2 = 0x1000dd0;
	enum XK_Sinh_aee2 = 0x1000dd1;
	enum XK_Sinh_i2 = 0x1000dd2;
	enum XK_Sinh_ii2 = 0x1000dd3;
	enum XK_Sinh_u2 = 0x1000dd4;
	enum XK_Sinh_uu2 = 0x1000dd6;
	enum XK_Sinh_ru2 = 0x1000dd8;
	enum XK_Sinh_e2 = 0x1000dd9;
	enum XK_Sinh_ee2 = 0x1000dda;
	enum XK_Sinh_ai2 = 0x1000ddb;
	enum XK_Sinh_o2 = 0x1000ddc;
	enum XK_Sinh_oo2 = 0x1000ddd;
	enum XK_Sinh_au2 = 0x1000dde;
	enum XK_Sinh_lu2 = 0x1000ddf;
	enum XK_Sinh_ruu2 = 0x1000df2;
	enum XK_Sinh_luu2 = 0x1000df3;
	enum XK_Sinh_kunddaliya = 0x1000df4;
	// file '/usr/include/X11/X.h'

	import core.stdc.config;

	enum X_PROTOCOL = 11;
	enum X_PROTOCOL_REVISION = 0;

	alias XID = c_ulong;

	alias Mask = c_ulong;

	alias Atom = c_ulong;

	alias VisualID = c_ulong;
	alias Time = c_ulong;

	alias Window = c_ulong;
	alias Drawable = c_ulong;

	alias Font = c_ulong;

	alias Pixmap = c_ulong;
	alias Cursor = c_ulong;
	alias Colormap = c_ulong;
	alias GContext = c_ulong;
	alias KeySym = c_ulong;

	alias KeyCode = ubyte;

	enum None = 0L;

	enum ParentRelative = 1L;

	enum CopyFromParent = 0L;

	enum PointerWindow = 0L;
	enum InputFocus = 1L;

	enum PointerRoot = 1L;

	enum AnyPropertyType = 0L;

	enum AnyKey = 0L;

	enum AnyButton = 0L;

	enum AllTemporary = 0L;

	enum CurrentTime = 0L;

	enum NoSymbol = 0L;

	enum NoEventMask = 0L;
	enum KeyPressMask = 1L << 0;
	enum KeyReleaseMask = 1L << 1;
	enum ButtonPressMask = 1L << 2;
	enum ButtonReleaseMask = 1L << 3;
	enum EnterWindowMask = 1L << 4;
	enum LeaveWindowMask = 1L << 5;
	enum PointerMotionMask = 1L << 6;
	enum PointerMotionHintMask = 1L << 7;
	enum Button1MotionMask = 1L << 8;
	enum Button2MotionMask = 1L << 9;
	enum Button3MotionMask = 1L << 10;
	enum Button4MotionMask = 1L << 11;
	enum Button5MotionMask = 1L << 12;
	enum ButtonMotionMask = 1L << 13;
	enum KeymapStateMask = 1L << 14;
	enum ExposureMask = 1L << 15;
	enum VisibilityChangeMask = 1L << 16;
	enum StructureNotifyMask = 1L << 17;
	enum ResizeRedirectMask = 1L << 18;
	enum SubstructureNotifyMask = 1L << 19;
	enum SubstructureRedirectMask = 1L << 20;
	enum FocusChangeMask = 1L << 21;
	enum PropertyChangeMask = 1L << 22;
	enum ColormapChangeMask = 1L << 23;
	enum OwnerGrabButtonMask = 1L << 24;

	enum KeyPress = 2;
	enum KeyRelease = 3;
	enum ButtonPress = 4;
	enum ButtonRelease = 5;
	enum MotionNotify = 6;
	enum EnterNotify = 7;
	enum LeaveNotify = 8;
	enum FocusIn = 9;
	enum FocusOut = 10;
	enum KeymapNotify = 11;
	enum Expose = 12;
	enum GraphicsExpose = 13;
	enum NoExpose = 14;
	enum VisibilityNotify = 15;
	enum CreateNotify = 16;
	enum DestroyNotify = 17;
	enum UnmapNotify = 18;
	enum MapNotify = 19;
	enum MapRequest = 20;
	enum ReparentNotify = 21;
	enum ConfigureNotify = 22;
	enum ConfigureRequest = 23;
	enum GravityNotify = 24;
	enum ResizeRequest = 25;
	enum CirculateNotify = 26;
	enum CirculateRequest = 27;
	enum PropertyNotify = 28;
	enum SelectionClear = 29;
	enum SelectionRequest = 30;
	enum SelectionNotify = 31;
	enum ColormapNotify = 32;
	enum ClientMessage = 33;
	enum MappingNotify = 34;
	enum GenericEvent = 35;
	enum LASTEvent = 36;

	enum ShiftMask = 1 << 0;
	enum LockMask = 1 << 1;
	enum ControlMask = 1 << 2;
	enum Mod1Mask = 1 << 3;
	enum Mod2Mask = 1 << 4;
	enum Mod3Mask = 1 << 5;
	enum Mod4Mask = 1 << 6;
	enum Mod5Mask = 1 << 7;

	enum ShiftMapIndex = 0;
	enum LockMapIndex = 1;
	enum ControlMapIndex = 2;
	enum Mod1MapIndex = 3;
	enum Mod2MapIndex = 4;
	enum Mod3MapIndex = 5;
	enum Mod4MapIndex = 6;
	enum Mod5MapIndex = 7;

	enum Button1Mask = 1 << 8;
	enum Button2Mask = 1 << 9;
	enum Button3Mask = 1 << 10;
	enum Button4Mask = 1 << 11;
	enum Button5Mask = 1 << 12;

	enum AnyModifier = 1 << 15;

	enum Button1 = 1;
	enum Button2 = 2;
	enum Button3 = 3;
	enum Button4 = 4;
	enum Button5 = 5;

	enum NotifyNormal = 0;
	enum NotifyGrab = 1;
	enum NotifyUngrab = 2;
	enum NotifyWhileGrabbed = 3;

	enum NotifyHint = 1;

	enum NotifyAncestor = 0;
	enum NotifyVirtual = 1;
	enum NotifyInferior = 2;
	enum NotifyNonlinear = 3;
	enum NotifyNonlinearVirtual = 4;
	enum NotifyPointer = 5;
	enum NotifyPointerRoot = 6;
	enum NotifyDetailNone = 7;

	enum VisibilityUnobscured = 0;
	enum VisibilityPartiallyObscured = 1;
	enum VisibilityFullyObscured = 2;

	enum PlaceOnTop = 0;
	enum PlaceOnBottom = 1;

	enum FamilyInternet = 0;
	enum FamilyDECnet = 1;
	enum FamilyChaos = 2;
	enum FamilyInternet6 = 6;

	enum FamilyServerInterpreted = 5;

	enum PropertyNewValue = 0;
	enum PropertyDelete = 1;

	enum ColormapUninstalled = 0;
	enum ColormapInstalled = 1;

	enum GrabModeSync = 0;
	enum GrabModeAsync = 1;

	enum GrabSuccess = 0;
	enum AlreadyGrabbed = 1;
	enum GrabInvalidTime = 2;
	enum GrabNotViewable = 3;
	enum GrabFrozen = 4;

	enum AsyncPointer = 0;
	enum SyncPointer = 1;
	enum ReplayPointer = 2;
	enum AsyncKeyboard = 3;
	enum SyncKeyboard = 4;
	enum ReplayKeyboard = 5;
	enum AsyncBoth = 6;
	enum SyncBoth = 7;

	enum RevertToNone = cast(int) None;
	enum RevertToPointerRoot = cast(int) PointerRoot;
	enum RevertToParent = 2;

	enum Success = 0;
	enum BadRequest = 1;
	enum BadValue = 2;
	enum BadWindow = 3;
	enum BadPixmap = 4;
	enum BadAtom = 5;
	enum BadCursor = 6;
	enum BadFont = 7;
	enum BadMatch = 8;
	enum BadDrawable = 9;
	enum BadAccess = 10;

	enum BadAlloc = 11;
	enum BadColor = 12;
	enum BadGC = 13;
	enum BadIDChoice = 14;
	enum BadName = 15;
	enum BadLength = 16;
	enum BadImplementation = 17;

	enum FirstExtensionError = 128;
	enum LastExtensionError = 255;

	enum InputOutput = 1;
	enum InputOnly = 2;

	enum CWBackPixmap = 1L << 0;
	enum CWBackPixel = 1L << 1;
	enum CWBorderPixmap = 1L << 2;
	enum CWBorderPixel = 1L << 3;
	enum CWBitGravity = 1L << 4;
	enum CWWinGravity = 1L << 5;
	enum CWBackingStore = 1L << 6;
	enum CWBackingPlanes = 1L << 7;
	enum CWBackingPixel = 1L << 8;
	enum CWOverrideRedirect = 1L << 9;
	enum CWSaveUnder = 1L << 10;
	enum CWEventMask = 1L << 11;
	enum CWDontPropagate = 1L << 12;
	enum CWColormap = 1L << 13;
	enum CWCursor = 1L << 14;

	enum CWX = 1 << 0;
	enum CWY = 1 << 1;
	enum CWWidth = 1 << 2;
	enum CWHeight = 1 << 3;
	enum CWBorderWidth = 1 << 4;
	enum CWSibling = 1 << 5;
	enum CWStackMode = 1 << 6;

	enum ForgetGravity = 0;
	enum NorthWestGravity = 1;
	enum NorthGravity = 2;
	enum NorthEastGravity = 3;
	enum WestGravity = 4;
	enum CenterGravity = 5;
	enum EastGravity = 6;
	enum SouthWestGravity = 7;
	enum SouthGravity = 8;
	enum SouthEastGravity = 9;
	enum StaticGravity = 10;

	enum UnmapGravity = 0;

	enum NotUseful = 0;
	enum WhenMapped = 1;
	enum Always = 2;

	enum IsUnmapped = 0;
	enum IsUnviewable = 1;
	enum IsViewable = 2;

	enum SetModeInsert = 0;
	enum SetModeDelete = 1;

	enum DestroyAll = 0;
	enum RetainPermanent = 1;
	enum RetainTemporary = 2;

	enum Above = 0;
	enum Below = 1;
	enum TopIf = 2;
	enum BottomIf = 3;
	enum Opposite = 4;

	enum RaiseLowest = 0;
	enum LowerHighest = 1;

	enum PropModeReplace = 0;
	enum PropModePrepend = 1;
	enum PropModeAppend = 2;

	enum GXclear = 0x0;
	enum GXand = 0x1;
	enum GXandReverse = 0x2;
	enum GXcopy = 0x3;
	enum GXandInverted = 0x4;
	enum GXnoop = 0x5;
	enum GXxor = 0x6;
	enum GXor = 0x7;
	enum GXnor = 0x8;
	enum GXequiv = 0x9;
	enum GXinvert = 0xa;
	enum GXorReverse = 0xb;
	enum GXcopyInverted = 0xc;
	enum GXorInverted = 0xd;
	enum GXnand = 0xe;
	enum GXset = 0xf;

	enum LineSolid = 0;
	enum LineOnOffDash = 1;
	enum LineDoubleDash = 2;

	enum CapNotLast = 0;
	enum CapButt = 1;
	enum CapRound = 2;
	enum CapProjecting = 3;

	enum JoinMiter = 0;
	enum JoinRound = 1;
	enum JoinBevel = 2;

	enum FillSolid = 0;
	enum FillTiled = 1;
	enum FillStippled = 2;
	enum FillOpaqueStippled = 3;

	enum EvenOddRule = 0;
	enum WindingRule = 1;

	enum ClipByChildren = 0;
	enum IncludeInferiors = 1;

	enum Unsorted = 0;
	enum YSorted = 1;
	enum YXSorted = 2;
	enum YXBanded = 3;

	enum CoordModeOrigin = 0;
	enum CoordModePrevious = 1;

	enum Complex = 0;
	enum Nonconvex = 1;
	enum Convex = 2;

	enum ArcChord = 0;
	enum ArcPieSlice = 1;

	enum GCFunction = 1L << 0;
	enum GCPlaneMask = 1L << 1;
	enum GCForeground = 1L << 2;
	enum GCBackground = 1L << 3;
	enum GCLineWidth = 1L << 4;
	enum GCLineStyle = 1L << 5;
	enum GCCapStyle = 1L << 6;
	enum GCJoinStyle = 1L << 7;
	enum GCFillStyle = 1L << 8;
	enum GCFillRule = 1L << 9;
	enum GCTile = 1L << 10;
	enum GCStipple = 1L << 11;
	enum GCTileStipXOrigin = 1L << 12;
	enum GCTileStipYOrigin = 1L << 13;
	enum GCFont = 1L << 14;
	enum GCSubwindowMode = 1L << 15;
	enum GCGraphicsExposures = 1L << 16;
	enum GCClipXOrigin = 1L << 17;
	enum GCClipYOrigin = 1L << 18;
	enum GCClipMask = 1L << 19;
	enum GCDashOffset = 1L << 20;
	enum GCDashList = 1L << 21;
	enum GCArcMode = 1L << 22;

	enum GCLastBit = 22;

	enum FontLeftToRight = 0;
	enum FontRightToLeft = 1;

	enum FontChange = 255;

	enum XYBitmap = 0;
	enum XYPixmap = 1;
	enum ZPixmap = 2;

	enum AllocNone = 0;
	enum AllocAll = 1;

	enum DoRed = 1 << 0;
	enum DoGreen = 1 << 1;
	enum DoBlue = 1 << 2;

	enum CursorShape = 0;
	enum TileShape = 1;
	enum StippleShape = 2;

	enum AutoRepeatModeOff = 0;
	enum AutoRepeatModeOn = 1;
	enum AutoRepeatModeDefault = 2;

	enum LedModeOff = 0;
	enum LedModeOn = 1;

	enum KBKeyClickPercent = 1L << 0;
	enum KBBellPercent = 1L << 1;
	enum KBBellPitch = 1L << 2;
	enum KBBellDuration = 1L << 3;
	enum KBLed = 1L << 4;
	enum KBLedMode = 1L << 5;
	enum KBKey = 1L << 6;
	enum KBAutoRepeatMode = 1L << 7;

	enum MappingSuccess = 0;
	enum MappingBusy = 1;
	enum MappingFailed = 2;

	enum MappingModifier = 0;
	enum MappingKeyboard = 1;
	enum MappingPointer = 2;

	enum DontPreferBlanking = 0;
	enum PreferBlanking = 1;
	enum DefaultBlanking = 2;

	enum DisableScreenSaver = 0;
	enum DisableScreenInterval = 0;

	enum DontAllowExposures = 0;
	enum AllowExposures = 1;
	enum DefaultExposures = 2;

	enum ScreenSaverReset = 0;
	enum ScreenSaverActive = 1;

	enum HostInsert = 0;
	enum HostDelete = 1;

	enum EnableAccess = 1;
	enum DisableAccess = 0;

	enum StaticGray = 0;
	enum GrayScale = 1;
	enum StaticColor = 2;
	enum PseudoColor = 3;
	enum TrueColor = 4;
	enum DirectColor = 5;

	enum LSBFirst = 0;
	enum MSBFirst = 1;
	// file '/usr/include/X11/Xutil.h'

	import core.stdc.config;
	import core.stdc.stddef;

	enum NoValue = 0x0000;
	enum XValue = 0x0001;
	enum YValue = 0x0002;
	enum WidthValue = 0x0004;
	enum HeightValue = 0x0008;
	enum AllValues = 0x000F;
	enum XNegative = 0x0010;
	enum YNegative = 0x0020;

	struct XSizeHints {
		c_long flags;
		int x;
		int y;
		int width;
		int height;
		int min_width;
		int min_height;
		int max_width;
		int max_height;
		int width_inc;
		int height_inc;

		struct PrivateAnonymous_0 {
			int x;
			int y;
		}

		PrivateAnonymous_0 min_aspect;
		PrivateAnonymous_0 max_aspect;
		int base_width;
		int base_height;
		int win_gravity;
	}

	enum USPosition = 1L << 0;
	enum USSize = 1L << 1;

	enum PPosition = 1L << 2;
	enum PSize = 1L << 3;
	enum PMinSize = 1L << 4;
	enum PMaxSize = 1L << 5;
	enum PResizeInc = 1L << 6;
	enum PAspect = 1L << 7;
	enum PBaseSize = 1L << 8;
	enum PWinGravity = 1L << 9;

	enum PAllHints = PPosition | PSize | PMinSize | PMaxSize | PResizeInc | PAspect;

	struct XWMHints {
		c_long flags;
		int input;

		int initial_state;
		Pixmap icon_pixmap;
		Window icon_window;
		int icon_x;
		int icon_y;
		Pixmap icon_mask;
		XID window_group;
	}

	enum InputHint = 1L << 0;
	enum StateHint = 1L << 1;
	enum IconPixmapHint = 1L << 2;
	enum IconWindowHint = 1L << 3;
	enum IconPositionHint = 1L << 4;
	enum IconMaskHint = 1L << 5;
	enum WindowGroupHint = 1L << 6;
	enum AllHints = InputHint | StateHint | IconPixmapHint | IconWindowHint
		| IconPositionHint | IconMaskHint | WindowGroupHint;
	enum XUrgencyHint = 1L << 8;

	enum WithdrawnState = 0;
	enum NormalState = 1;
	enum IconicState = 3;

	enum DontCareState = 0;
	enum ZoomState = 2;
	enum InactiveState = 4;

	struct XTextProperty {
		ubyte* value;
		Atom encoding;
		int format;
		c_ulong nitems;
	}

	enum XNoMemory = -1;
	enum XLocaleNotSupported = -2;
	enum XConverterNotFound = -3;

	enum XICCEncodingStyle {
		XStringStyle = 0,
		XCompoundTextStyle = 1,
		XTextStyle = 2,
		XStdICCTextStyle = 3,

		XUTF8StringStyle = 4
	}

	struct XIconSize {
		int min_width;
		int min_height;
		int max_width;
		int max_height;
		int width_inc;
		int height_inc;
	}

	struct XClassHint {
		char* res_name;
		char* res_class;
	}

	static extern (D) auto destroyImage(T)(auto ref T ximage) {
		return (*ximage.f.destroy_image)(ximage);
	}

	static extern (D) auto getPixel(T0, T1, T2)(auto ref T0 ximage, auto ref T1 x, auto ref T2 y) {
		return (*ximage.f.get_pixel)(ximage, x, y);
	}

	static extern (D) auto putPixel(T0, T1, T2, T3)(auto ref T0 ximage,
			auto ref T1 x, auto ref T2 y, auto ref T3 pixel) {
		return (*ximage.f.put_pixel)(ximage, x, y, pixel);
	}

	static extern (D) auto subImage(T0, T1, T2, T3, T4)(auto ref T0 ximage,
			auto ref T1 x, auto ref T2 y, auto ref T3 width, auto ref T4 height) {
		return (*ximage.f.sub_image)(ximage, x, y, width, height);
	}

	static extern (D) auto addPixel(T0, T1)(auto ref T0 ximage, auto ref T1 value) {
		return (*ximage.f.add_pixel)(ximage, value);
	}

	struct XComposeStatus {
		XPointer compose_ptr;
		int chars_matched;
	}

	static extern (D) auto isKeypadKey(T)(auto ref T keysym) {
		return (cast(KeySym) keysym >= XK_KP_Space) && (cast(KeySym) keysym <= XK_KP_Equal);
	}

	static extern (D) auto isPrivateKeypadKey(T)(auto ref T keysym) {
		return (cast(KeySym) keysym >= 0x11000000) && (cast(KeySym) keysym <= 0x1100FFFF);
	}

	static extern (D) auto isCursorKey(T)(auto ref T keysym) {
		return (cast(KeySym) keysym >= XK_Home) && (cast(KeySym) keysym < XK_Select);
	}

	static extern (D) auto isPFKey(T)(auto ref T keysym) {
		return (cast(KeySym) keysym >= XK_KP_F1) && (cast(KeySym) keysym <= XK_KP_F4);
	}

	static extern (D) auto isFunctionKey(T)(auto ref T keysym) {
		return (cast(KeySym) keysym >= XK_F1) && (cast(KeySym) keysym <= XK_F35);
	}

	static extern (D) auto isMiscFunctionKey(T)(auto ref T keysym) {
		return (cast(KeySym) keysym >= XK_Select) && (cast(KeySym) keysym <= XK_Break);
	}

	static extern (D) auto isModifierKey(T)(auto ref T keysym) {
		return ((cast(KeySym) keysym >= XK_Shift_L) && (cast(KeySym) keysym <= XK_Hyper_R))
			|| ((cast(KeySym) keysym >= XK_ISO_Lock)
					&& (cast(KeySym) keysym <= XK_ISO_Level5_Lock))
			|| (cast(KeySym) keysym == XK_Mode_switch) || (cast(KeySym) keysym == XK_Num_Lock);
	}

	struct PrivateXRegion;
	alias Region = PrivateXRegion*;

	enum RectangleOut = 0;
	enum RectangleIn = 1;
	enum RectanglePart = 2;

	struct XVisualInfo {
		Visual* visual;
		VisualID visualid;
		int screen;
		int depth;

		int class_;

		c_ulong red_mask;
		c_ulong green_mask;
		c_ulong blue_mask;
		int colormap_size;
		int bits_per_rgb;
	}

	enum VisualNoMask = 0x0;
	enum VisualIDMask = 0x1;
	enum VisualScreenMask = 0x2;
	enum VisualDepthMask = 0x4;
	enum VisualClassMask = 0x8;
	enum VisualRedMaskMask = 0x10;
	enum VisualGreenMaskMask = 0x20;
	enum VisualBlueMaskMask = 0x40;
	enum VisualColormapSizeMask = 0x80;
	enum VisualBitsPerRGBMask = 0x100;
	enum VisualAllMask = 0x1FF;

	struct XStandardColormap {
		Colormap colormap;
		c_ulong red_max;
		c_ulong red_mult;
		c_ulong green_max;
		c_ulong green_mult;
		c_ulong blue_max;
		c_ulong blue_mult;
		c_ulong base_pixel;
		VisualID visualid;
		XID killid;
	}

	enum ReleaseByFreeingColormap = cast(XID) 1L;

	enum BitmapSuccess = 0;
	enum BitmapOpenFailed = 1;
	enum BitmapFileInvalid = 2;
	enum BitmapNoMemory = 3;

	enum XCSUCCESS = 0;
	enum XCNOMEM = 1;
	enum XCNOENT = 2;

	alias XContext = int;

	static extern (D) auto uniqueContext()() {
		return cast(XContext) rmUniqueQuark();
	}

	static extern (D) auto stringToContext(T)(auto ref T string) {
		return cast(XContext) rmStringToQuark(string);
	}

	XClassHint* allocClassHint();

	XIconSize* allocIconSize();

	XSizeHints* allocSizeHints();

	XStandardColormap* allocStandardColormap();

	XWMHints* allocWMHints();

	int clipBox(Region, XRectangle*);

	Region createRegion();

	const(char)* defaultString();

	int deleteContext(Display*, XID, XContext);

	int destroyRegion(Region);

	int emptyRegion(Region);

	int equalRegion(Region, Region);

	int findContext(Display*, XID, XContext, XPointer*);

	int getClassHint(Display*, Window, XClassHint*);

	int getIconSizes(Display*, Window, XIconSize**, int*);

	int getNormalHints(Display*, Window, XSizeHints*);

	int getRGBColormaps(Display*, Window, XStandardColormap**, int*, Atom);

	int getSizeHints(Display*, Window, XSizeHints*, Atom);

	int getStandardColormap(Display*, Window, XStandardColormap*, Atom);

	int getTextProperty(Display*, Window, XTextProperty*, Atom);

	XVisualInfo* getVisualInfo(Display*, c_long, XVisualInfo*, int*);

	int getWMClientMachine(Display*, Window, XTextProperty*);

	XWMHints* getWMHints(Display*, Window);

	int getWMIconName(Display*, Window, XTextProperty*);

	int getWMName(Display*, Window, XTextProperty*);

	int getWMNormalHints(Display*, Window, XSizeHints*, c_long*);

	int getWMSizeHints(Display*, Window, XSizeHints*, c_long*, Atom);

	int getZoomHints(Display*, Window, XSizeHints*);

	int intersectRegion(Region, Region, Region);

	void convertCase(KeySym, KeySym*, KeySym*);

	int lookupString(XKeyEvent*, char*, int, KeySym*, XComposeStatus*);

	int matchVisualInfo(Display*, int, int, int, XVisualInfo*);

	int offsetRegion(Region, int, int);

	int pointInRegion(Region, int, int);

	Region polygonRegion(XPoint*, int, int);

	int rectInRegion(Region, int, int, uint, uint);

	int saveContext(Display*, XID, XContext, const(char)*);

	int setClassHint(Display*, Window, XClassHint*);

	int setIconSizes(Display*, Window, XIconSize*, int);

	int setNormalHints(Display*, Window, XSizeHints*);

	void setRGBColormaps(Display*, Window, XStandardColormap*, int, Atom);

	int setSizeHints(Display*, Window, XSizeHints*, Atom);

	int setStandardProperties(Display*, Window, const(char)*, const(char)*,
			Pixmap, char**, int, XSizeHints*);

	void setTextProperty(Display*, Window, XTextProperty*, Atom);

	void setWMClientMachine(Display*, Window, XTextProperty*);

	int setWMHints(Display*, Window, XWMHints*);

	void setWMIconName(Display*, Window, XTextProperty*);

	void setWMName(Display*, Window, XTextProperty*);

	void setWMNormalHints(Display*, Window, XSizeHints*);

	void setWMProperties(Display*, Window, XTextProperty*, XTextProperty*,
			char**, int, XSizeHints*, XWMHints*, XClassHint*);

	@BindingName("XmbSetWMProperties")
	void mbSetWMProperties(Display*, Window, const(char)*, const(char)*,
			char**, int, XSizeHints*, XWMHints*, XClassHint*);

	@BindingName("Xutf8SetWMProperties")
	void utf8SetWMProperties(Display*, Window, const(char)*, const(char)*,
			char**, int, XSizeHints*, XWMHints*, XClassHint*);

	void setWMSizeHints(Display*, Window, XSizeHints*, Atom);

	int setRegion(Display*, GC, Region);

	void setStandardColormap(Display*, Window, XStandardColormap*, Atom);

	int setZoomHints(Display*, Window, XSizeHints*);

	int shrinkRegion(Region, int, int);

	int stringListToTextProperty(char**, int, XTextProperty*);

	int subtractRegion(Region, Region, Region);

	@BindingName("XmbTextListToTextProperty")
	int mbTextListToTextProperty(Display* display, char** list, int count,
			XICCEncodingStyle style, XTextProperty* text_prop_return);

	@BindingName("XwcTextListToTextProperty")
	int wcTextListToTextProperty(Display* display, wchar_t** list, int count,
			XICCEncodingStyle style, XTextProperty* text_prop_return);

	@BindingName("Xutf8TextListToTextProperty")
	int utf8TextListToTextProperty(Display* display, char** list, int count,
			XICCEncodingStyle style, XTextProperty* text_prop_return);

	@BindingName("XwcFreeStringList")
	void wcFreeStringList(wchar_t** list);

	int textPropertyToStringList(XTextProperty*, char***, int*);

	@BindingName("XmbTextPropertyToTextList")
	int mbTextPropertyToTextList(Display* display,
			const(XTextProperty)* text_prop, char*** list_return, int* count_return);

	@BindingName("XwcTextPropertyToTextList")
	int wcTextPropertyToTextList(Display* display, const(XTextProperty)* text_prop,
			wchar_t*** list_return, int* count_return);

	@BindingName("Xutf8TextPropertyToTextList")
	int utf8TextPropertyToTextList(Display* display,
			const(XTextProperty)* text_prop, char*** list_return, int* count_return);

	int unionRectWithRegion(XRectangle*, Region, Region);

	int unionRegion(Region, Region, Region);

	@BindingName("XWMGeometry")
	int wmGeometry(Display*, int, const(char)*, const(char)*, uint,
			XSizeHints*, int*, int*, int*, int*, int*);

	int xorRegion(Region, Region, Region);

	// file '/usr/include/X11/extensions/XKBstr.h'

	import core.stdc.config;
	import core.stdc.stddef;

	static extern (D) auto kbCharToInt(T)(auto ref T v) {
		return v & 0x80 ? cast(int) v | (~0xff) : cast(int) v & 0x7f;
	}

	static extern (D) auto kb2CharsToInt(T0, T1)(auto ref T0 h, auto ref T1 l) {
		return cast(short)(h << 8) | l;
	}

	struct XkbStateRec {
		ubyte group;
		ubyte locked_group;
		ushort base_group;
		ushort latched_group;
		ubyte mods;
		ubyte base_mods;
		ubyte latched_mods;
		ubyte locked_mods;
		ubyte compat_state;
		ubyte grab_mods;
		ubyte compat_grab_mods;
		ubyte lookup_mods;
		ubyte compat_lookup_mods;
		ushort ptr_buttons;
	}

	alias XkbStatePtr = XkbStateRec*;

	static extern (D) auto kbModLocks(T)(auto ref T s) {
		return s.locked_mods;
	}

	static extern (D) auto kbStateMods(T)(auto ref T s) {
		return s.base_mods | s.latched_mods | kbModLocks(s);
	}

	static extern (D) auto kbGroupLock(T)(auto ref T s) {
		return s.locked_group;
	}

	static extern (D) auto kbStateGroup(T)(auto ref T s) {
		return s.base_group + s.latched_group + kbGroupLock(s);
	}

	static extern (D) auto kbStateFieldFromRec(T)(auto ref T s) {
		return kbBuildCoreState(s.lookup_mods, s.group);
	}

	static extern (D) auto kbGrabStateFromRec(T)(auto ref T s) {
		return kbBuildCoreState(s.grab_mods, s.group);
	}

	struct PrivateXkbMods {
		ubyte mask;
		ubyte real_mods;
		ushort vmods;
	}

	alias XkbModsRec = PrivateXkbMods;
	alias XkbModsPtr = PrivateXkbMods*;

	struct PrivateXkbKTMapEntry {
		int active;
		ubyte level;
		XkbModsRec mods;
	}

	alias XkbKTMapEntryRec = PrivateXkbKTMapEntry;
	alias XkbKTMapEntryPtr = PrivateXkbKTMapEntry*;

	struct PrivateXkbKeyType {
		XkbModsRec mods;
		ubyte num_levels;
		ubyte map_count;

		XkbKTMapEntryPtr map;

		XkbModsPtr preserve;
		Atom name;

		Atom* level_names;
	}

	alias XkbKeyTypeRec = PrivateXkbKeyType;
	alias XkbKeyTypePtr = PrivateXkbKeyType*;

	static extern (D) auto kbNumGroups(T)(auto ref T g) {
		return g & 0x0f;
	}

	static extern (D) auto kbOutOfRangeGroupInfo(T)(auto ref T g) {
		return g & 0xf0;
	}

	static extern (D) auto kbOutOfRangeGroupAction(T)(auto ref T g) {
		return g & 0xc0;
	}

	static extern (D) auto kbOutOfRangeGroupNumber(T)(auto ref T g) {
		return (g & 0x30) >> 4;
	}

	static extern (D) auto kbSetGroupInfo(T0, T1, T2)(auto ref T0 g, auto ref T1 w, auto ref T2 n) {
		return (w & 0xc0) | ((n & 3) << 4) | (g & 0x0f);
	}

	static extern (D) auto kbSetNumGroups(T0, T1)(auto ref T0 g, auto ref T1 n) {
		return (g & 0xf0) | (n & 0x0f);
	}

	struct XkbBehavior {
		ubyte type;
		ubyte data;
	}

	enum XkbAnyActionDataSize = 7;

	struct XkbAnyAction {
		ubyte type;
		ubyte[XkbAnyActionDataSize] data;
	}

	struct XkbModAction {
		ubyte type;
		ubyte flags;
		ubyte mask;
		ubyte real_mods;
		ubyte vmods1;
		ubyte vmods2;
	}

	static extern (D) auto kbModActionVMods(T)(auto ref T a) {
		return cast(short)(a.vmods1 << 8) | (a.vmods2);
	}

	struct XkbGroupAction {
		ubyte type;
		ubyte flags;
		char group_XXX;
	}

	static extern (D) auto kbSAGroup(T)(auto ref T a) {
		return kbCharToInt(a.group_XXX);
	}

	struct XkbISOAction {
		ubyte type;
		ubyte flags;
		ubyte mask;
		ubyte real_mods;
		char group_XXX;
		ubyte affect;
		ubyte vmods1;
		ubyte vmods2;
	}

	struct XkbPtrAction {
		ubyte type;
		ubyte flags;
		ubyte high_XXX;
		ubyte low_XXX;
		ubyte high_YYY;
		ubyte low_YYY;
	}

	static extern (D) auto kbPtrActionX(T)(auto ref T a) {
		return kb2CharsToInt(a.high_XXX, a.low_XXX);
	}

	static extern (D) auto kbPtrActionY(T)(auto ref T a) {
		return kb2CharsToInt(a.high_YYY, a.low_YYY);
	}

	static extern (D) auto kbSetPtrActionX(T0, T1)(auto ref T0 a, auto ref T1 x) {
		return kbIntTo2Chars(x, a.high_XXX, a.low_XXX);
	}

	static extern (D) auto kbSetPtrActionY(T0, T1)(auto ref T0 a, auto ref T1 y) {
		return kbIntTo2Chars(y, a.high_YYY, a.low_YYY);
	}

	struct XkbPtrBtnAction {
		ubyte type;
		ubyte flags;
		ubyte count;
		ubyte button;
	}

	struct XkbPtrDfltAction {
		ubyte type;
		ubyte flags;
		ubyte affect;
		char valueXXX;
	}

	static extern (D) auto kbSAPtrDfltValue(T)(auto ref T a) {
		return kbCharToInt(a.valueXXX);
	}

	struct XkbSwitchScreenAction {
		ubyte type;
		ubyte flags;
		char screenXXX;
	}

	static extern (D) auto kbSAScreen(T)(auto ref T a) {
		return kbCharToInt(a.screenXXX);
	}

	struct XkbCtrlsAction {
		ubyte type;
		ubyte flags;
		ubyte ctrls3;
		ubyte ctrls2;
		ubyte ctrls1;
		ubyte ctrls0;
	}

	static extern (D) auto kbActionCtrls(T)(auto ref T a) {
		return ((cast(uint) a.ctrls3) << 24) | ((cast(uint) a.ctrls2) << 16) | (
				(cast(uint) a.ctrls1) << 8) | (cast(uint) a.ctrls0);
	}

	struct XkbMessageAction {
		ubyte type;
		ubyte flags;
		ubyte[6] message;
	}

	struct XkbRedirectKeyAction {
		ubyte type;
		ubyte new_key;
		ubyte mods_mask;
		ubyte mods;
		ubyte vmods_mask0;
		ubyte vmods_mask1;
		ubyte vmods0;
		ubyte vmods1;
	}

	static extern (D) auto kbSARedirectVMods(T)(auto ref T a) {
		return ((cast(uint) a.vmods1) << 8) | (cast(uint) a.vmods0);
	}

	static extern (D) auto kbSARedirectVModsMask(T)(auto ref T a) {
		return ((cast(uint) a.vmods_mask1) << 8) | (cast(uint) a.vmods_mask0);
	}

	struct XkbDeviceBtnAction {
		ubyte type;
		ubyte flags;
		ubyte count;
		ubyte button;
		ubyte device;
	}

	struct XkbDeviceValuatorAction {
		ubyte type;
		ubyte device;
		ubyte v1_what;
		ubyte v1_ndx;
		ubyte v1_value;
		ubyte v2_what;
		ubyte v2_ndx;
		ubyte v2_value;
	}

	union XkbAction {
		XkbAnyAction any;
		XkbModAction mods;
		XkbGroupAction group;
		XkbISOAction iso;
		XkbPtrAction ptr;
		XkbPtrBtnAction btn;
		XkbPtrDfltAction dflt;
		XkbSwitchScreenAction screen;
		XkbCtrlsAction ctrls;
		XkbMessageAction msg;
		XkbRedirectKeyAction redirect;
		XkbDeviceBtnAction devbtn;
		XkbDeviceValuatorAction devval;
		ubyte type;
	}

	struct PrivateXkbControls {
		ubyte mk_dflt_btn;
		ubyte num_groups;
		ubyte groups_wrap;
		XkbModsRec internal;
		XkbModsRec ignore_lock;
		uint enabled_ctrls;
		ushort repeat_delay;
		ushort repeat_interval;
		ushort slow_keys_delay;
		ushort debounce_delay;
		ushort mk_delay;
		ushort mk_interval;
		ushort mk_time_to_max;
		ushort mk_max_speed;
		short mk_curve;
		ushort ax_options;
		ushort ax_timeout;
		ushort axt_opts_mask;
		ushort axt_opts_values;
		uint axt_ctrls_mask;
		uint axt_ctrls_values;
		ubyte[32] per_key_repeat;
	}

	alias XkbControlsRec = PrivateXkbControls;
	alias XkbControlsPtr = PrivateXkbControls*;

	static extern (D) auto kbAX_AnyFeedback(T)(auto ref T c) {
		return c.enabled_ctrls & XkbAccessXFeedbackMask;
	}

	static extern (D) auto kbAX_NeedOption(T0, T1)(auto ref T0 c, auto ref T1 w) {
		return c.ax_options & w;
	}

	static extern (D) auto kbAX_NeedFeedback(T0, T1)(auto ref T0 c, auto ref T1 w) {
		return kbAX_AnyFeedback(c) && kbAX_NeedOption(c, w);
	}

	struct XkbServerMapRec {
		ushort num_acts;
		ushort size_acts;
		XkbAction* acts;

		XkbBehavior* behaviors;
		ushort* key_acts;

		ubyte* explicit;

		ubyte[XkbNumVirtualMods] vmods;
		ushort* vmodmap;
	}

	alias XkbServerMapPtr = XkbServerMapRec*;

	static extern (D) auto kbSMKeyActionsPtr(T0, T1)(auto ref T0 m, auto ref T1 k) {
		return &m.acts[m.key_acts[k]];
	}

	struct XkbSymMapRec {
		ubyte[XkbNumKbdGroups] kt_index;
		ubyte group_info;
		ubyte width;
		ushort offset;
	}

	alias XkbSymMapPtr = XkbSymMapRec*;

	struct XkbClientMapRec {
		ubyte size_types;
		ubyte num_types;
		XkbKeyTypePtr types;

		ushort size_syms;
		ushort num_syms;
		KeySym* syms;

		XkbSymMapPtr key_sym_map;

		ubyte* modmap;
	}

	alias XkbClientMapPtr = XkbClientMapRec*;

	static extern (D) auto kbCMKeyGroupInfo(T0, T1)(auto ref T0 m, auto ref T1 k) {
		return m.key_sym_map[k].group_info;
	}

	static extern (D) auto kbCMKeyNumGroups(T0, T1)(auto ref T0 m, auto ref T1 k) {
		return kbNumGroups(m.key_sym_map[k].group_info);
	}

	static extern (D) auto kbCMKeyGroupWidth(T0, T1, T2)(auto ref T0 m, auto ref T1 k, auto ref T2 g) {
		return kbCMKeyType(m, k, g).num_levels;
	}

	static extern (D) auto kbCMKeyGroupsWidth(T0, T1)(auto ref T0 m, auto ref T1 k) {
		return m.key_sym_map[k].width;
	}

	static extern (D) auto kbCMKeyTypeIndex(T0, T1, T2)(auto ref T0 m, auto ref T1 k, auto ref T2 g) {
		return m.key_sym_map[k].kt_index[g & 0x3];
	}

	static extern (D) auto kbCMKeyType(T0, T1, T2)(auto ref T0 m, auto ref T1 k, auto ref T2 g) {
		return &m.types[kbCMKeyTypeIndex(m, k, g)];
	}

	static extern (D) auto kbCMKeyNumSyms(T0, T1)(auto ref T0 m, auto ref T1 k) {
		return kbCMKeyGroupsWidth(m, k) * kbCMKeyNumGroups(m, k);
	}

	static extern (D) auto kbCMKeySymsOffset(T0, T1)(auto ref T0 m, auto ref T1 k) {
		return m.key_sym_map[k].offset;
	}

	static extern (D) auto kbCMKeySymsPtr(T0, T1)(auto ref T0 m, auto ref T1 k) {
		return &m.syms[kbCMKeySymsOffset(m, k)];
	}

	struct XkbSymInterpretRec {
		KeySym sym;
		ubyte flags;
		ubyte match;
		ubyte mods;
		ubyte virtual_mod;
		XkbAnyAction act;
	}

	alias XkbSymInterpretPtr = XkbSymInterpretRec*;

	struct XkbCompatMapRec {
		XkbSymInterpretPtr sym_interpret;
		XkbModsRec[XkbNumKbdGroups] groups;
		ushort num_si;
		ushort size_si;
	}

	alias XkbCompatMapPtr = XkbCompatMapRec*;

	struct XkbIndicatorMapRec {
		ubyte flags;
		ubyte which_groups;
		ubyte groups;
		ubyte which_mods;
		XkbModsRec mods;
		uint ctrls;
	}

	alias XkbIndicatorMapPtr = XkbIndicatorMapRec*;

	static extern (D) auto kbIM_IsAuto(T)(auto ref T i) {
		return ((i.flags & XkbIM_NoAutomatic) == 0) && ((i.which_groups
				&& i.groups) || (i.which_mods && i.mods.mask) || (i.ctrls));
	}

	static extern (D) auto kbIM_InUse(T)(auto ref T i) {
		return (i.flags) || (i.which_groups) || (i.which_mods) || (i.ctrls);
	}

	struct XkbIndicatorRec {
		c_ulong phys_indicators;
		XkbIndicatorMapRec[XkbNumIndicators] maps;
	}

	alias XkbIndicatorPtr = XkbIndicatorRec*;

	struct XkbKeyNameRec {
		char[XkbKeyNameLength] name;
	}

	alias XkbKeyNamePtr = XkbKeyNameRec*;

	struct XkbKeyAliasRec {
		char[XkbKeyNameLength] real_;
		char[XkbKeyNameLength] alias_;
	}

	alias XkbKeyAliasPtr = XkbKeyAliasRec*;

	struct XkbNamesRec {
		Atom keycodes;
		Atom geometry;
		Atom symbols;
		Atom types;
		Atom compat;
		Atom[XkbNumVirtualMods] vmods;
		Atom[XkbNumIndicators] indicators;
		Atom[XkbNumKbdGroups] groups;

		XkbKeyNamePtr keys;

		XkbKeyAliasPtr key_aliases;

		Atom* radio_groups;
		Atom phys_symbols;

		ubyte num_keys;
		ubyte num_key_aliases;
		ushort num_rg;
	}

	alias XkbNamesPtr = XkbNamesRec*;

	struct PrivateXkbGeometry;
	alias XkbGeometryPtr = PrivateXkbGeometry*;

	struct PrivateXkbDesc {
		PrivateXDisplay* dpy;
		ushort flags;
		ushort device_spec;
		KeyCode min_key_code;
		KeyCode max_key_code;

		XkbControlsPtr ctrls;
		XkbServerMapPtr server;
		XkbClientMapPtr map;
		XkbIndicatorPtr indicators;
		XkbNamesPtr names;
		XkbCompatMapPtr compat;
		XkbGeometryPtr geom;
	}

	alias XkbDescRec = PrivateXkbDesc;
	alias XkbDescPtr = PrivateXkbDesc*;

	static extern (D) auto kbKeyKeyTypeIndex(T0, T1, T2)(auto ref T0 d, auto ref T1 k, auto ref T2 g) {
		return kbCMKeyTypeIndex(d.map, k, g);
	}

	static extern (D) auto kbKeyKeyType(T0, T1, T2)(auto ref T0 d, auto ref T1 k, auto ref T2 g) {
		return kbCMKeyType(d.map, k, g);
	}

	static extern (D) auto kbKeyGroupWidth(T0, T1, T2)(auto ref T0 d, auto ref T1 k, auto ref T2 g) {
		return kbCMKeyGroupWidth(d.map, k, g);
	}

	static extern (D) auto kbKeyGroupsWidth(T0, T1)(auto ref T0 d, auto ref T1 k) {
		return kbCMKeyGroupsWidth(d.map, k);
	}

	static extern (D) auto kbKeyGroupInfo(T0, T1)(auto ref T0 d, auto ref T1 k) {
		return kbCMKeyGroupInfo(d.map, k);
	}

	static extern (D) auto kbKeyNumGroups(T0, T1)(auto ref T0 d, auto ref T1 k) {
		return kbCMKeyNumGroups(d.map, k);
	}

	static extern (D) auto kbKeyNumSyms(T0, T1)(auto ref T0 d, auto ref T1 k) {
		return kbCMKeyNumSyms(d.map, k);
	}

	static extern (D) auto kbKeySymsPtr(T0, T1)(auto ref T0 d, auto ref T1 k) {
		return kbCMKeySymsPtr(d.map, k);
	}

	static extern (D) auto kbKeySym(T0, T1, T2)(auto ref T0 d, auto ref T1 k, auto ref T2 n) {
		return kbKeySymsPtr(d, k)[n];
	}

	static extern (D) auto kbKeySymEntry(T0, T1, T2, T3)(auto ref T0 d,
			auto ref T1 k, auto ref T2 sl, auto ref T3 g) {
		return kbKeySym(d, k, (kbKeyGroupsWidth(d, k) * g) + sl);
	}

	static extern (D) auto kbKeyAction(T0, T1, T2)(auto ref T0 d, auto ref T1 k, auto ref T2 n) {
		return kbKeyHasActions(d, k) ? &kbKeyActionsPtr(d, k)[n] : NULL;
	}

	static extern (D) auto kbKeyActionEntry(T0, T1, T2, T3)(auto ref T0 d,
			auto ref T1 k, auto ref T2 sl, auto ref T3 g) {
		return kbKeyHasActions(d, k) ? kbKeyAction(d, k, (kbKeyGroupsWidth(d, k) * g) + sl) : NULL;
	}

	static extern (D) auto kbKeyHasActions(T0, T1)(auto ref T0 d, auto ref T1 k) {
		return d.server.key_acts[k] != 0;
	}

	static extern (D) auto kbKeyNumActions(T0, T1)(auto ref T0 d, auto ref T1 k) {
		return kbKeyHasActions(d, k) ? kbKeyNumSyms(d, k) : 1;
	}

	static extern (D) auto kbKeyActionsPtr(T0, T1)(auto ref T0 d, auto ref T1 k) {
		return kbSMKeyActionsPtr(d.server, k);
	}

	static extern (D) auto kbKeycodeInRange(T0, T1)(auto ref T0 d, auto ref T1 k) {
		return (k >= d.min_key_code) && (k <= d.max_key_code);
	}

	static extern (D) auto kbNumKeys(T)(auto ref T d) {
		return d.max_key_code - d.min_key_code + 1;
	}

	struct PrivateXkbMapChanges {
		ushort changed;
		KeyCode min_key_code;
		KeyCode max_key_code;
		ubyte first_type;
		ubyte num_types;
		KeyCode first_key_sym;
		ubyte num_key_syms;
		KeyCode first_key_act;
		ubyte num_key_acts;
		KeyCode first_key_behavior;
		ubyte num_key_behaviors;
		KeyCode first_key_explicit;
		ubyte num_key_explicit;
		KeyCode first_modmap_key;
		ubyte num_modmap_keys;
		KeyCode first_vmodmap_key;
		ubyte num_vmodmap_keys;
		ubyte pad;
		ushort vmods;
	}

	alias XkbMapChangesRec = PrivateXkbMapChanges;
	alias XkbMapChangesPtr = PrivateXkbMapChanges*;

	struct PrivateXkbControlsChanges {
		uint changed_ctrls;
		uint enabled_ctrls_changes;
		int num_groups_changed;
	}

	alias XkbControlsChangesRec = PrivateXkbControlsChanges;
	alias XkbControlsChangesPtr = PrivateXkbControlsChanges*;

	struct PrivateXkbIndicatorChanges {
		uint state_changes;
		uint map_changes;
	}

	alias XkbIndicatorChangesRec = PrivateXkbIndicatorChanges;
	alias XkbIndicatorChangesPtr = PrivateXkbIndicatorChanges*;

	struct PrivateXkbNameChanges {
		uint changed;
		ubyte first_type;
		ubyte num_types;
		ubyte first_lvl;
		ubyte num_lvls;
		ubyte num_aliases;
		ubyte num_rg;
		ubyte first_key;
		ubyte num_keys;
		ushort changed_vmods;
		c_ulong changed_indicators;
		ubyte changed_groups;
	}

	alias XkbNameChangesRec = PrivateXkbNameChanges;
	alias XkbNameChangesPtr = PrivateXkbNameChanges*;

	struct PrivateXkbCompatChanges {
		ubyte changed_groups;
		ushort first_si;
		ushort num_si;
	}

	alias XkbCompatChangesRec = PrivateXkbCompatChanges;
	alias XkbCompatChangesPtr = PrivateXkbCompatChanges*;

	struct PrivateXkbChanges {
		ushort device_spec;
		ushort state_changes;
		XkbMapChangesRec map;
		XkbControlsChangesRec ctrls;
		XkbIndicatorChangesRec indicators;
		XkbNameChangesRec names;
		XkbCompatChangesRec compat;
	}

	alias XkbChangesRec = PrivateXkbChanges;
	alias XkbChangesPtr = PrivateXkbChanges*;

	struct PrivateXkbComponentNames {
		char* keymap;
		char* keycodes;
		char* types;
		char* compat;
		char* symbols;
		char* geometry;
	}

	alias XkbComponentNamesRec = PrivateXkbComponentNames;
	alias XkbComponentNamesPtr = PrivateXkbComponentNames*;

	struct PrivateXkbComponentName {
		ushort flags;
		char* name;
	}

	alias XkbComponentNameRec = PrivateXkbComponentName;
	alias XkbComponentNamePtr = PrivateXkbComponentName*;

	struct PrivateXkbComponentList {
		int num_keymaps;
		int num_keycodes;
		int num_types;
		int num_compat;
		int num_symbols;
		int num_geometry;
		XkbComponentNamePtr keymaps;
		XkbComponentNamePtr keycodes;
		XkbComponentNamePtr types;
		XkbComponentNamePtr compat;
		XkbComponentNamePtr symbols;
		XkbComponentNamePtr geometry;
	}

	alias XkbComponentListRec = PrivateXkbComponentList;
	alias XkbComponentListPtr = PrivateXkbComponentList*;

	struct PrivateXkbDeviceLedInfo {
		ushort led_class;
		ushort led_id;
		uint phys_indicators;
		uint maps_present;
		uint names_present;
		uint state;
		Atom[XkbNumIndicators] names;
		XkbIndicatorMapRec[XkbNumIndicators] maps;
	}

	alias XkbDeviceLedInfoRec = PrivateXkbDeviceLedInfo;
	alias XkbDeviceLedInfoPtr = PrivateXkbDeviceLedInfo*;

	struct PrivateXkbDeviceInfo {
		char* name;
		Atom type;
		ushort device_spec;
		int has_own_state;
		ushort supported;
		ushort unsupported;

		ushort num_btns;
		XkbAction* btn_acts;

		ushort sz_leds;
		ushort num_leds;
		ushort dflt_kbd_fb;
		ushort dflt_led_fb;

		XkbDeviceLedInfoPtr leds;
	}

	alias XkbDeviceInfoRec = PrivateXkbDeviceInfo;
	alias XkbDeviceInfoPtr = PrivateXkbDeviceInfo*;

	static extern (D) auto kbXI_DevHasBtnActs(T)(auto ref T d) {
		return (d.num_btns > 0) && (d.btn_acts != NULL);
	}

	static extern (D) auto kbXI_LegalDevBtn(T0, T1)(auto ref T0 d, auto ref T1 b) {
		return kbXI_DevHasBtnActs(d) && (b < d.num_btns);
	}

	static extern (D) auto kbXI_DevHasLeds(T)(auto ref T d) {
		return (d.num_leds > 0) && (d.leds != NULL);
	}

	struct PrivateXkbDeviceLedChanges {
		ushort led_class;
		ushort led_id;
		uint defined;
		PrivateXkbDeviceLedChanges* next;
	}

	alias XkbDeviceLedChangesRec = PrivateXkbDeviceLedChanges;
	alias XkbDeviceLedChangesPtr = PrivateXkbDeviceLedChanges*;

	struct PrivateXkbDeviceChanges {
		uint changed;
		ushort first_btn;
		ushort num_btns;
		XkbDeviceLedChangesRec leds;
	}

	alias XkbDeviceChangesRec = PrivateXkbDeviceChanges;
	alias XkbDeviceChangesPtr = PrivateXkbDeviceChanges*;

	// file '/usr/include/X11/extensions/XKB.h'

	enum X_kbUseExtension = 0;
	enum X_kbSelectEvents = 1;
	enum X_kbBell = 3;
	enum X_kbGetState = 4;
	enum X_kbLatchLockState = 5;
	enum X_kbGetControls = 6;
	enum X_kbSetControls = 7;
	enum X_kbGetMap = 8;
	enum X_kbSetMap = 9;
	enum X_kbGetCompatMap = 10;
	enum X_kbSetCompatMap = 11;
	enum X_kbGetIndicatorState = 12;
	enum X_kbGetIndicatorMap = 13;
	enum X_kbSetIndicatorMap = 14;
	enum X_kbGetNamedIndicator = 15;
	enum X_kbSetNamedIndicator = 16;
	enum X_kbGetNames = 17;
	enum X_kbSetNames = 18;
	enum X_kbGetGeometry = 19;
	enum X_kbSetGeometry = 20;
	enum X_kbPerClientFlags = 21;
	enum X_kbListComponents = 22;
	enum X_kbGetKbdByName = 23;
	enum X_kbGetDeviceInfo = 24;
	enum X_kbSetDeviceInfo = 25;
	enum X_kbSetDebuggingFlags = 101;

	enum XkbEventCode = 0;
	enum XkbNumberEvents = XkbEventCode + 1;

	enum XkbNewKeyboardNotify = 0;
	enum XkbMapNotify = 1;
	enum XkbStateNotify = 2;
	enum XkbControlsNotify = 3;
	enum XkbIndicatorStateNotify = 4;
	enum XkbIndicatorMapNotify = 5;
	enum XkbNamesNotify = 6;
	enum XkbCompatMapNotify = 7;
	enum XkbBellNotify = 8;
	enum XkbActionMessage = 9;
	enum XkbAccessXNotify = 10;
	enum XkbExtensionDeviceNotify = 11;

	enum XkbNewKeyboardNotifyMask = 1L << 0;
	enum XkbMapNotifyMask = 1L << 1;
	enum XkbStateNotifyMask = 1L << 2;
	enum XkbControlsNotifyMask = 1L << 3;
	enum XkbIndicatorStateNotifyMask = 1L << 4;
	enum XkbIndicatorMapNotifyMask = 1L << 5;
	enum XkbNamesNotifyMask = 1L << 6;
	enum XkbCompatMapNotifyMask = 1L << 7;
	enum XkbBellNotifyMask = 1L << 8;
	enum XkbActionMessageMask = 1L << 9;
	enum XkbAccessXNotifyMask = 1L << 10;
	enum XkbExtensionDeviceNotifyMask = 1L << 11;
	enum XkbAllEventsMask = 0xFFF;

	enum XkbNKN_KeycodesMask = 1L << 0;
	enum XkbNKN_GeometryMask = 1L << 1;
	enum XkbNKN_DeviceIDMask = 1L << 2;
	enum XkbAllNewKeyboardEventsMask = 0x7;

	enum XkbAXN_SKPress = 0;
	enum XkbAXN_SKAccept = 1;
	enum XkbAXN_SKReject = 2;
	enum XkbAXN_SKRelease = 3;
	enum XkbAXN_BKAccept = 4;
	enum XkbAXN_BKReject = 5;
	enum XkbAXN_AXKWarning = 6;

	enum XkbAXN_SKPressMask = 1L << 0;
	enum XkbAXN_SKAcceptMask = 1L << 1;
	enum XkbAXN_SKRejectMask = 1L << 2;
	enum XkbAXN_SKReleaseMask = 1L << 3;
	enum XkbAXN_BKAcceptMask = 1L << 4;
	enum XkbAXN_BKRejectMask = 1L << 5;
	enum XkbAXN_AXKWarningMask = 1L << 6;
	enum XkbAllAccessXEventsMask = 0x7f;

	enum XkbAllStateEventsMask = XkbAllStateComponentsMask;
	enum XkbAllMapEventsMask = XkbAllMapComponentsMask;
	enum XkbAllControlEventsMask = XkbAllControlsMask;
	enum XkbAllIndicatorEventsMask = XkbAllIndicatorsMask;
	enum XkbAllNameEventsMask = XkbAllNamesMask;
	enum XkbAllCompatMapEventsMask = XkbAllCompatMask;
	enum XkbAllBellEventsMask = 1L << 0;
	enum XkbAllActionMessagesMask = 1L << 0;

	enum XkbKeyboard = 0;
	enum XkbNumberErrors = 1;

	enum XkbErr_BadDevice = 0xff;
	enum XkbErr_BadClass = 0xfe;
	enum XkbErr_BadId = 0xfd;

	enum XkbClientMapMask = 1L << 0;
	enum XkbServerMapMask = 1L << 1;
	enum XkbCompatMapMask = 1L << 2;
	enum XkbIndicatorMapMask = 1L << 3;
	enum XkbNamesMask = 1L << 4;
	enum XkbGeometryMask = 1L << 5;
	enum XkbControlsMask = 1L << 6;
	enum XkbAllComponentsMask = 0x7f;

	enum XkbModifierStateMask = 1L << 0;
	enum XkbModifierBaseMask = 1L << 1;
	enum XkbModifierLatchMask = 1L << 2;
	enum XkbModifierLockMask = 1L << 3;
	enum XkbGroupStateMask = 1L << 4;
	enum XkbGroupBaseMask = 1L << 5;
	enum XkbGroupLatchMask = 1L << 6;
	enum XkbGroupLockMask = 1L << 7;
	enum XkbCompatStateMask = 1L << 8;
	enum XkbGrabModsMask = 1L << 9;
	enum XkbCompatGrabModsMask = 1L << 10;
	enum XkbLookupModsMask = 1L << 11;
	enum XkbCompatLookupModsMask = 1L << 12;
	enum XkbPointerButtonMask = 1L << 13;
	enum XkbAllStateComponentsMask = 0x3fff;

	enum XkbRepeatKeysMask = 1L << 0;
	enum XkbSlowKeysMask = 1L << 1;
	enum XkbBounceKeysMask = 1L << 2;
	enum XkbStickyKeysMask = 1L << 3;
	enum XkbMouseKeysMask = 1L << 4;
	enum XkbMouseKeysAccelMask = 1L << 5;
	enum XkbAccessXKeysMask = 1L << 6;
	enum XkbAccessXTimeoutMask = 1L << 7;
	enum XkbAccessXFeedbackMask = 1L << 8;
	enum XkbAudibleBellMask = 1L << 9;
	enum XkbOverlay1Mask = 1L << 10;
	enum XkbOverlay2Mask = 1L << 11;
	enum XkbIgnoreGroupLockMask = 1L << 12;
	enum XkbGroupsWrapMask = 1L << 27;
	enum XkbInternalModsMask = 1L << 28;
	enum XkbIgnoreLockModsMask = 1L << 29;
	enum XkbPerKeyRepeatMask = 1L << 30;
	enum XkbControlsEnabledMask = 1L << 31;

	enum XkbAccessXOptionsMask = XkbStickyKeysMask | XkbAccessXFeedbackMask;

	enum XkbAllBooleanCtrlsMask = 0x00001FFF;
	enum XkbAllControlsMask = 0xF8001FFF;
	// enum XkbAllControlEventsMask = XkbAllControlsMask;

	enum XkbAX_SKPressFBMask = 1L << 0;
	enum XkbAX_SKAcceptFBMask = 1L << 1;
	enum XkbAX_FeatureFBMask = 1L << 2;
	enum XkbAX_SlowWarnFBMask = 1L << 3;
	enum XkbAX_IndicatorFBMask = 1L << 4;
	enum XkbAX_StickyKeysFBMask = 1L << 5;
	enum XkbAX_TwoKeysMask = 1L << 6;
	enum XkbAX_LatchToLockMask = 1L << 7;
	enum XkbAX_SKReleaseFBMask = 1L << 8;
	enum XkbAX_SKRejectFBMask = 1L << 9;
	enum XkbAX_BKRejectFBMask = 1L << 10;
	enum XkbAX_DumbBellFBMask = 1L << 11;
	enum XkbAX_FBOptionsMask = 0xF3F;
	enum XkbAX_SKOptionsMask = 0x0C0;
	enum XkbAX_AllOptionsMask = 0xFFF;

	enum XkbUseCoreKbd = 0x0100;
	enum XkbUseCorePtr = 0x0200;
	enum XkbDfltXIClass = 0x0300;
	enum XkbDfltXIId = 0x0400;
	enum XkbAllXIClasses = 0x0500;
	enum XkbAllXIIds = 0x0600;
	enum XkbXINone = 0xff00;

	static extern (D) auto kbLegalXILedClass(T)(auto ref T c) {
		return (c == KbdFeedbackClass) || (c == LedFeedbackClass)
			|| (c == XkbDfltXIClass) || (c == XkbAllXIClasses);
	}

	static extern (D) auto kbLegalXIBellClass(T)(auto ref T c) {
		return (c == KbdFeedbackClass) || (c == BellFeedbackClass)
			|| (c == XkbDfltXIClass) || (c == XkbAllXIClasses);
	}

	static extern (D) auto kbExplicitXIDevice(T)(auto ref T c) {
		return (c & (~0xff)) == 0;
	}

	static extern (D) auto kbExplicitXIClass(T)(auto ref T c) {
		return (c & (~0xff)) == 0;
	}

	static extern (D) auto kbExplicitXIId(T)(auto ref T c) {
		return (c & (~0xff)) == 0;
	}

	static extern (D) auto kbSingleXIClass(T)(auto ref T c) {
		return ((c & (~0xff)) == 0) || (c == XkbDfltXIClass);
	}

	static extern (D) auto kbSingleXIId(T)(auto ref T c) {
		return ((c & (~0xff)) == 0) || (c == XkbDfltXIId);
	}

	enum XkbNoModifier = 0xff;
	enum XkbNoShiftLevel = 0xff;
	enum XkbNoShape = 0xff;
	enum XkbNoIndicator = 0xff;

	enum XkbNoModifierMask = 0;
	enum XkbAllModifiersMask = 0xff;
	enum XkbAllVirtualModsMask = 0xffff;

	enum XkbNumKbdGroups = 4;
	enum XkbMaxKbdGroup = XkbNumKbdGroups - 1;

	enum XkbMaxMouseKeysBtn = 4;

	enum XkbGroup1Index = 0;
	enum XkbGroup2Index = 1;
	enum XkbGroup3Index = 2;
	enum XkbGroup4Index = 3;
	enum XkbAnyGroup = 254;
	enum XkbAllGroups = 255;

	enum XkbGroup1Mask = 1 << 0;
	enum XkbGroup2Mask = 1 << 1;
	enum XkbGroup3Mask = 1 << 2;
	enum XkbGroup4Mask = 1 << 3;
	enum XkbAnyGroupMask = 1 << 7;
	enum XkbAllGroupsMask = 0xf;

	static extern (D) auto kbBuildCoreState(T0, T1)(auto ref T0 m, auto ref T1 g) {
		return ((g & 0x3) << 13) | (m & 0xff);
	}

	static extern (D) auto kbGroupForCoreState(T)(auto ref T s) {
		return (s >> 13) & 0x3;
	}

	static extern (D) auto kbIsLegalGroup(T)(auto ref T g) {
		return (g >= 0) && (g < XkbNumKbdGroups);
	}

	enum XkbWrapIntoRange = 0x00;
	enum XkbClampIntoRange = 0x40;
	enum XkbRedirectIntoRange = 0x80;

	enum XkbSA_ClearLocks = 1L << 0;
	enum XkbSA_LatchToLock = 1L << 1;

	enum XkbSA_LockNoLock = 1L << 0;
	enum XkbSA_LockNoUnlock = 1L << 1;

	enum XkbSA_UseModMapMods = 1L << 2;

	enum XkbSA_GroupAbsolute = 1L << 2;
	enum XkbSA_UseDfltButton = 0;

	enum XkbSA_NoAcceleration = 1L << 0;
	enum XkbSA_MoveAbsoluteX = 1L << 1;
	enum XkbSA_MoveAbsoluteY = 1L << 2;

	enum XkbSA_ISODfltIsGroup = 1L << 7;
	enum XkbSA_ISONoAffectMods = 1L << 6;
	enum XkbSA_ISONoAffectGroup = 1L << 5;
	enum XkbSA_ISONoAffectPtr = 1L << 4;
	enum XkbSA_ISONoAffectCtrls = 1L << 3;
	enum XkbSA_ISOAffectMask = 0x78;

	enum XkbSA_MessageOnPress = 1L << 0;
	enum XkbSA_MessageOnRelease = 1L << 1;
	enum XkbSA_MessageGenKeyEvent = 1L << 2;

	enum XkbSA_AffectDfltBtn = 1;
	enum XkbSA_DfltBtnAbsolute = 1L << 2;

	enum XkbSA_SwitchApplication = 1L << 0;
	enum XkbSA_SwitchAbsolute = 1L << 2;

	enum XkbSA_IgnoreVal = 0x00;
	enum XkbSA_SetValMin = 0x10;
	enum XkbSA_SetValCenter = 0x20;
	enum XkbSA_SetValMax = 0x30;
	enum XkbSA_SetValRelative = 0x40;
	enum XkbSA_SetValAbsolute = 0x50;
	enum XkbSA_ValOpMask = 0x70;
	enum XkbSA_ValScaleMask = 0x07;

	static extern (D) auto kbSA_ValOp(T)(auto ref T a) {
		return a & XkbSA_ValOpMask;
	}

	static extern (D) auto kbSA_ValScale(T)(auto ref T a) {
		return a & XkbSA_ValScaleMask;
	}

	enum XkbSA_NoAction = 0x00;
	enum XkbSA_SetMods = 0x01;
	enum XkbSA_LatchMods = 0x02;
	enum XkbSA_LockMods = 0x03;
	enum XkbSA_SetGroup = 0x04;
	enum XkbSA_LatchGroup = 0x05;
	enum XkbSA_LockGroup = 0x06;
	enum XkbSA_MovePtr = 0x07;
	enum XkbSA_PtrBtn = 0x08;
	enum XkbSA_LockPtrBtn = 0x09;
	enum XkbSA_SetPtrDflt = 0x0a;
	enum XkbSA_ISOLock = 0x0b;
	enum XkbSA_Terminate = 0x0c;
	enum XkbSA_SwitchScreen = 0x0d;
	enum XkbSA_SetControls = 0x0e;
	enum XkbSA_LockControls = 0x0f;
	enum XkbSA_ActionMessage = 0x10;
	enum XkbSA_RedirectKey = 0x11;
	enum XkbSA_DeviceBtn = 0x12;
	enum XkbSA_LockDeviceBtn = 0x13;
	enum XkbSA_DeviceValuator = 0x14;
	enum XkbSA_LastAction = XkbSA_DeviceValuator;
	enum XkbSA_NumActions = XkbSA_LastAction + 1;

	enum XkbSA_XFree86Private = 0x86;

	enum XkbSA_BreakLatch = (1 << XkbSA_NoAction) | (1 << XkbSA_PtrBtn) | (1 << XkbSA_LockPtrBtn) | (
				1 << XkbSA_Terminate) | (1 << XkbSA_SwitchScreen) | (1 << XkbSA_SetControls) | (
				1 << XkbSA_LockControls) | (1 << XkbSA_ActionMessage) | (
				1 << XkbSA_RedirectKey) | (1 << XkbSA_DeviceBtn) | (1 << XkbSA_LockDeviceBtn);

	static extern (D) auto kbIsModAction(T)(auto ref T a) {
		return (a.type >= Xkb_SASetMods) && (a.type <= XkbSA_LockMods);
	}

	static extern (D) auto kbIsGroupAction(T)(auto ref T a) {
		return (a.type >= XkbSA_SetGroup) && (a.type <= XkbSA_LockGroup);
	}

	static extern (D) auto kbIsPtrAction(T)(auto ref T a) {
		return (a.type >= XkbSA_MovePtr) && (a.type <= XkbSA_SetPtrDflt);
	}

	enum XkbKB_Permanent = 0x80;
	enum XkbKB_OpMask = 0x7f;

	enum XkbKB_Default = 0x00;
	enum XkbKB_Lock = 0x01;
	enum XkbKB_RadioGroup = 0x02;
	enum XkbKB_Overlay1 = 0x03;
	enum XkbKB_Overlay2 = 0x04;

	enum XkbKB_RGAllowNone = 0x80;

	enum XkbMinLegalKeyCode = 8;
	enum XkbMaxLegalKeyCode = 255;
	enum XkbMaxKeyCount = XkbMaxLegalKeyCode - XkbMinLegalKeyCode + 1;
	enum XkbPerKeyBitArraySize = (XkbMaxLegalKeyCode + 1) / 8;

	static extern (D) auto kbIsLegalKeycode(T)(auto ref T k) {
		return k >= XkbMinLegalKeyCode;
	}

	enum XkbNumModifiers = 8;
	enum XkbNumVirtualMods = 16;
	enum XkbNumIndicators = 32;
	enum XkbAllIndicatorsMask = 0xffffffff;
	enum XkbMaxRadioGroups = 32;
	enum XkbAllRadioGroupsMask = 0xffffffff;
	enum XkbMaxShiftLevel = 63;
	enum XkbMaxSymsPerKey = XkbMaxShiftLevel * XkbNumKbdGroups;
	enum XkbRGMaxMembers = 12;
	enum XkbActionMessageLength = 6;
	enum XkbKeyNameLength = 4;
	enum XkbMaxRedirectCount = 8;

	enum XkbGeomPtsPerMM = 10;
	enum XkbGeomMaxColors = 32;
	enum XkbGeomMaxLabelColors = 3;
	enum XkbGeomMaxPriority = 255;

	enum XkbOneLevelIndex = 0;
	enum XkbTwoLevelIndex = 1;
	enum XkbAlphabeticIndex = 2;
	enum XkbKeypadIndex = 3;
	enum XkbLastRequiredType = XkbKeypadIndex;
	enum XkbNumRequiredTypes = XkbLastRequiredType + 1;
	enum XkbMaxKeyTypes = 255;

	enum XkbOneLevelMask = 1 << 0;
	enum XkbTwoLevelMask = 1 << 1;
	enum XkbAlphabeticMask = 1 << 2;
	enum XkbKeypadMask = 1 << 3;
	enum XkbAllRequiredTypes = 0xf;

	static extern (D) auto kbShiftLevel(T)(auto ref T n) {
		return n - 1;
	}

	static extern (D) auto kbShiftLevelMask(T)(auto ref T n) {
		return 1 << (n - 1);
	}

	enum XkbName = "XKEYBOARD";
	enum XkbMajorVersion = 1;
	enum XkbMinorVersion = 0;

	enum XkbExplicitKeyTypesMask = 0x0f;
	enum XkbExplicitKeyType1Mask = 1 << 0;
	enum XkbExplicitKeyType2Mask = 1 << 1;
	enum XkbExplicitKeyType3Mask = 1 << 2;
	enum XkbExplicitKeyType4Mask = 1 << 3;
	enum XkbExplicitInterpretMask = 1 << 4;
	enum XkbExplicitAutoRepeatMask = 1 << 5;
	enum XkbExplicitBehaviorMask = 1 << 6;
	enum XkbExplicitVModMapMask = 1 << 7;
	enum XkbAllExplicitMask = 0xff;

	enum XkbKeyTypesMask = 1 << 0;
	enum XkbKeySymsMask = 1 << 1;
	enum XkbModifierMapMask = 1 << 2;
	enum XkbExplicitComponentsMask = 1 << 3;
	enum XkbKeyActionsMask = 1 << 4;
	enum XkbKeyBehaviorsMask = 1 << 5;
	enum XkbVirtualModsMask = 1 << 6;
	enum XkbVirtualModMapMask = 1 << 7;

	enum XkbAllClientInfoMask = XkbKeyTypesMask | XkbKeySymsMask | XkbModifierMapMask;
	enum XkbAllServerInfoMask = XkbExplicitComponentsMask | XkbKeyActionsMask
		| XkbKeyBehaviorsMask | XkbVirtualModsMask | XkbVirtualModMapMask;
	enum XkbAllMapComponentsMask = XkbAllClientInfoMask | XkbAllServerInfoMask;

	enum XkbSI_AutoRepeat = 1 << 0;
	enum XkbSI_LockingKey = 1 << 1;

	enum XkbSI_LevelOneOnly = 0x80;
	enum XkbSI_OpMask = 0x7f;
	enum XkbSI_NoneOf = 0;
	enum XkbSI_AnyOfOrNone = 1;
	enum XkbSI_AnyOf = 2;
	enum XkbSI_AllOf = 3;
	enum XkbSI_Exactly = 4;

	enum XkbIM_NoExplicit = 1L << 7;
	enum XkbIM_NoAutomatic = 1L << 6;
	enum XkbIM_LEDDrivesKB = 1L << 5;

	enum XkbIM_UseBase = 1L << 0;
	enum XkbIM_UseLatched = 1L << 1;
	enum XkbIM_UseLocked = 1L << 2;
	enum XkbIM_UseEffective = 1L << 3;
	enum XkbIM_UseCompat = 1L << 4;

	enum XkbIM_UseNone = 0;
	enum XkbIM_UseAnyGroup = XkbIM_UseBase | XkbIM_UseLatched | XkbIM_UseLocked | XkbIM_UseEffective;
	enum XkbIM_UseAnyMods = XkbIM_UseAnyGroup | XkbIM_UseCompat;

	enum XkbSymInterpMask = 1 << 0;
	enum XkbGroupCompatMask = 1 << 1;
	enum XkbAllCompatMask = 0x3;

	enum XkbKeycodesNameMask = 1 << 0;
	enum XkbGeometryNameMask = 1 << 1;
	enum XkbSymbolsNameMask = 1 << 2;
	enum XkbPhysSymbolsNameMask = 1 << 3;
	enum XkbTypesNameMask = 1 << 4;
	enum XkbCompatNameMask = 1 << 5;
	enum XkbKeyTypeNamesMask = 1 << 6;
	enum XkbKTLevelNamesMask = 1 << 7;
	enum XkbIndicatorNamesMask = 1 << 8;
	enum XkbKeyNamesMask = 1 << 9;
	enum XkbKeyAliasesMask = 1 << 10;
	enum XkbVirtualModNamesMask = 1 << 11;
	enum XkbGroupNamesMask = 1 << 12;
	enum XkbRGNamesMask = 1 << 13;
	enum XkbComponentNamesMask = 0x3f;
	enum XkbAllNamesMask = 0x3fff;

	enum XkbGBN_TypesMask = 1L << 0;
	enum XkbGBN_CompatMapMask = 1L << 1;
	enum XkbGBN_ClientSymbolsMask = 1L << 2;
	enum XkbGBN_ServerSymbolsMask = 1L << 3;
	enum XkbGBN_SymbolsMask = XkbGBN_ClientSymbolsMask | XkbGBN_ServerSymbolsMask;
	enum XkbGBN_IndicatorMapMask = 1L << 4;
	enum XkbGBN_KeyNamesMask = 1L << 5;
	enum XkbGBN_GeometryMask = 1L << 6;
	enum XkbGBN_OtherNamesMask = 1L << 7;
	enum XkbGBN_AllComponentsMask = 0xff;

	enum XkbLC_Hidden = 1L << 0;
	enum XkbLC_Default = 1L << 1;
	enum XkbLC_Partial = 1L << 2;

	enum XkbLC_AlphanumericKeys = 1L << 8;
	enum XkbLC_ModifierKeys = 1L << 9;
	enum XkbLC_KeypadKeys = 1L << 10;
	enum XkbLC_FunctionKeys = 1L << 11;
	enum XkbLC_AlternateGroup = 1L << 12;

	enum XkbXI_KeyboardsMask = 1L << 0;
	enum XkbXI_ButtonActionsMask = 1L << 1;
	enum XkbXI_IndicatorNamesMask = 1L << 2;
	enum XkbXI_IndicatorMapsMask = 1L << 3;
	enum XkbXI_IndicatorStateMask = 1L << 4;
	enum XkbXI_UnsupportedFeatureMask = 1L << 15;
	enum XkbXI_AllFeaturesMask = 0x001f;
	enum XkbXI_AllDeviceFeaturesMask = 0x001e;

	enum XkbXI_IndicatorsMask = 0x001c;
	enum XkbAllExtensionDeviceEventsMask = 0x801f;

	enum XkbPCF_DetectableAutoRepeatMask = 1L << 0;
	enum XkbPCF_GrabsUseXKBStateMask = 1L << 1;
	enum XkbPCF_AutoResetControlsMask = 1L << 2;
	enum XkbPCF_LookupStateWhenGrabbed = 1L << 3;
	enum XkbPCF_SendEventUsesXKBState = 1L << 4;
	enum XkbPCF_AllFlagsMask = 0x1F;

	enum XkbDF_DisableLocks = 1 << 0;
	// file '/usr/include/X11/XKBlib.h'

	import core.stdc.config;

	struct XkbAnyEvent {
		int type;
		c_ulong serial;
		int send_event;
		Display* display;
		Time time;
		int xkb_type;
		uint device;
	}

	struct PrivateXkbNewKeyboardNotify {
		int type;
		c_ulong serial;
		int send_event;
		Display* display;
		Time time;
		int xkb_type;
		int device;
		int old_device;
		int min_key_code;
		int max_key_code;
		int old_min_key_code;
		int old_max_key_code;
		uint changed;
		char req_major;
		char req_minor;
	}

	alias XkbNewKeyboardNotifyEvent = PrivateXkbNewKeyboardNotify;

	struct XkbMapNotifyEvent {
		int type;
		c_ulong serial;
		int send_event;
		Display* display;
		Time time;
		int xkb_type;
		int device;
		uint changed;
		uint flags;
		int first_type;
		int num_types;
		KeyCode min_key_code;
		KeyCode max_key_code;
		KeyCode first_key_sym;
		KeyCode first_key_act;
		KeyCode first_key_behavior;
		KeyCode first_key_explicit;
		KeyCode first_modmap_key;
		KeyCode first_vmodmap_key;
		int num_key_syms;
		int num_key_acts;
		int num_key_behaviors;
		int num_key_explicit;
		int num_modmap_keys;
		int num_vmodmap_keys;
		uint vmods;
	}

	struct XkbStateNotifyEvent {
		int type;
		c_ulong serial;
		int send_event;
		Display* display;
		Time time;
		int xkb_type;
		int device;
		uint changed;
		int group;
		int base_group;
		int latched_group;
		int locked_group;
		uint mods;
		uint base_mods;
		uint latched_mods;
		uint locked_mods;
		int compat_state;
		ubyte grab_mods;
		ubyte compat_grab_mods;
		ubyte lookup_mods;
		ubyte compat_lookup_mods;
		int ptr_buttons;
		KeyCode keycode;
		char event_type;
		char req_major;
		char req_minor;
	}

	struct PrivateXkbControlsNotify {
		int type;
		c_ulong serial;
		int send_event;
		Display* display;
		Time time;
		int xkb_type;
		int device;
		uint changed_ctrls;
		uint enabled_ctrls;
		uint enabled_ctrl_changes;
		int num_groups;
		KeyCode keycode;
		char event_type;
		char req_major;
		char req_minor;
	}

	alias XkbControlsNotifyEvent = PrivateXkbControlsNotify;

	struct PrivateXkbIndicatorNotify {
		int type;
		c_ulong serial;
		int send_event;
		Display* display;
		Time time;
		int xkb_type;
		int device;
		uint changed;
		uint state;
	}

	alias XkbIndicatorNotifyEvent = PrivateXkbIndicatorNotify;

	struct PrivateXkbNamesNotify {
		int type;
		c_ulong serial;
		int send_event;
		Display* display;
		Time time;
		int xkb_type;
		int device;
		uint changed;
		int first_type;
		int num_types;
		int first_lvl;
		int num_lvls;
		int num_aliases;
		int num_radio_groups;
		uint changed_vmods;
		uint changed_groups;
		uint changed_indicators;
		int first_key;
		int num_keys;
	}

	alias XkbNamesNotifyEvent = PrivateXkbNamesNotify;

	struct PrivateXkbCompatMapNotify {
		int type;
		c_ulong serial;
		int send_event;
		Display* display;
		Time time;
		int xkb_type;
		int device;
		uint changed_groups;
		int first_si;
		int num_si;
		int num_total_si;
	}

	alias XkbCompatMapNotifyEvent = PrivateXkbCompatMapNotify;

	struct PrivateXkbBellNotify {
		int type;
		c_ulong serial;
		int send_event;
		Display* display;
		Time time;
		int xkb_type;
		int device;
		int percent;
		int pitch;
		int duration;
		int bell_class;
		int bell_id;
		Atom name;
		Window window;
		int event_only;
	}

	alias XkbBellNotifyEvent = PrivateXkbBellNotify;

	struct PrivateXkbActionMessage {
		int type;
		c_ulong serial;
		int send_event;
		Display* display;
		Time time;
		int xkb_type;
		int device;
		KeyCode keycode;
		int press;
		int key_event_follows;
		int group;
		uint mods;
		char[7] message;
	}

	alias XkbActionMessageEvent = PrivateXkbActionMessage;

	struct PrivateXkbAccessXNotify {
		int type;
		c_ulong serial;
		int send_event;
		Display* display;
		Time time;
		int xkb_type;
		int device;
		int detail;
		int keycode;
		int sk_delay;
		int debounce_delay;
	}

	alias XkbAccessXNotifyEvent = PrivateXkbAccessXNotify;

	struct PrivateXkbExtensionDeviceNotify {
		int type;
		c_ulong serial;
		int send_event;
		Display* display;
		Time time;
		int xkb_type;
		int device;
		uint reason;
		uint supported;
		uint unsupported;

		int first_btn;
		int num_btns;
		uint leds_defined;
		uint led_state;
		int led_class;
		int led_id;
	}

	alias XkbExtensionDeviceNotifyEvent = PrivateXkbExtensionDeviceNotify;

	union XkbEvent {
		int type;
		XkbAnyEvent any;
		XkbNewKeyboardNotifyEvent new_kbd;
		XkbMapNotifyEvent map;
		XkbStateNotifyEvent state;
		XkbControlsNotifyEvent ctrls;
		XkbIndicatorNotifyEvent indicators;
		XkbNamesNotifyEvent names;
		XkbCompatMapNotifyEvent compat;
		XkbBellNotifyEvent bell;
		XkbActionMessageEvent message;
		XkbAccessXNotifyEvent accessx;
		XkbExtensionDeviceNotifyEvent device;
		XEvent core;
	}

	struct PrivateXkbKbdDpyState;
	alias XkbKbdDpyStateRec = PrivateXkbKbdDpyState;
	alias XkbKbdDpyStatePtr = PrivateXkbKbdDpyState*;

	enum XkbOD_Success = 0;
	enum XkbOD_BadLibraryVersion = 1;
	enum XkbOD_ConnectionRefused = 2;
	enum XkbOD_NonXkbServer = 3;
	enum XkbOD_BadServerVersion = 4;

	enum XkbLC_ForceLatin1Lookup = 1 << 0;
	enum XkbLC_ConsumeLookupMods = 1 << 1;
	enum XkbLC_AlwaysConsumeShiftAndLock = 1 << 2;
	enum XkbLC_IgnoreNewKeyboards = 1 << 3;
	enum XkbLC_ControlFallback = 1 << 4;
	enum XkbLC_ConsumeKeysOnComposeFail = 1 << 29;
	enum XkbLC_ComposeLED = 1 << 30;
	enum XkbLC_BeepOnComposeFail = 1 << 31;

	enum XkbLC_AllComposeControls = 0xc0000000;
	enum XkbLC_AllControls = 0xc000001f;

	@BindingName("XkbIgnoreExtension")
	int kbIgnoreExtension(int);

	@BindingName("XkbOpenDisplay")
	Display* kbOpenDisplay(char*, int*, int*, int*, int*, int*);

	@BindingName("XkbQueryExtension")
	int kbQueryExtension(Display*, int*, int*, int*, int*, int*);

	@BindingName("XkbUseExtension")
	int kbUseExtension(Display*, int*, int*);

	@BindingName("XkbLibraryVersion")
	int kbLibraryVersion(int*, int*);

	@BindingName("XkbSetXlibControls")
	uint kbSetXlibControls(Display*, uint, uint);

	@BindingName("XkbGetXlibControls")
	uint kbGetXlibControls(Display*);

	@BindingName("XkbXlibControlsImplemented")
	uint kbXlibControlsImplemented();

	alias XkbInternAtomFunc = c_ulong function(Display*, const(char)*, int);

	alias XkbGetAtomNameFunc = char* function(Display*, Atom);

	@BindingName("XkbSetAtomFuncs")
	void kbSetAtomFuncs(XkbInternAtomFunc, XkbGetAtomNameFunc);

	@BindingName("XkbKeycodeToKeysym")
	KeySym kbKeycodeToKeysym(Display*, KeyCode, int, int);

	@BindingName("XkbKeysymToModifiers")
	uint kbKeysymToModifiers(Display*, KeySym);

	@BindingName("XkbLookupKeySym")
	int kbLookupKeySym(Display*, KeyCode, uint, uint*, KeySym*);

	@BindingName("XkbLookupKeyBinding")
	int kbLookupKeyBinding(Display*, KeySym, uint, char*, int, int*);

	@BindingName("XkbTranslateKeyCode")
	int kbTranslateKeyCode(XkbDescPtr, KeyCode, uint, uint*, KeySym*);

	@BindingName("XkbTranslateKeySym")
	int kbTranslateKeySym(Display*, KeySym*, uint, char*, int, int*);

	@BindingName("XkbSetAutoRepeatRate")
	int kbSetAutoRepeatRate(Display*, uint, uint, uint);

	@BindingName("XkbGetAutoRepeatRate")
	int kbGetAutoRepeatRate(Display*, uint, uint*, uint*);

	@BindingName("XkbChangeEnabledControls")
	int kbChangeEnabledControls(Display*, uint, uint, uint);

	@BindingName("XkbDeviceBell")
	int kbDeviceBell(Display*, Window, int, int, int, int, Atom);

	@BindingName("XkbForceDeviceBell")
	int kbForceDeviceBell(Display*, int, int, int, int);

	@BindingName("XkbDeviceBellEvent")
	int kbDeviceBellEvent(Display*, Window, int, int, int, int, Atom);

	@BindingName("XkbBell")
	int kbBell(Display*, Window, int, Atom);

	@BindingName("XkbForceBell")
	int kbForceBell(Display*, int);

	@BindingName("XkbBellEvent")
	int kbBellEvent(Display*, Window, int, Atom);

	@BindingName("XkbSelectEvents")
	int kbSelectEvents(Display*, uint, uint, uint);

	@BindingName("XkbSelectEventDetails")
	int kbSelectEventDetails(Display*, uint, uint, c_ulong, c_ulong);

	@BindingName("XkbNoteMapChanges")
	void kbNoteMapChanges(XkbMapChangesPtr, XkbMapNotifyEvent*, uint);

	@BindingName("XkbNoteNameChanges")
	void kbNoteNameChanges(XkbNameChangesPtr, XkbNamesNotifyEvent*, uint);

	@BindingName("XkbGetIndicatorState")
	int kbGetIndicatorState(Display*, uint, uint*);

	@BindingName("XkbGetDeviceIndicatorState")
	int kbGetDeviceIndicatorState(Display*, uint, uint, uint, uint*);

	@BindingName("XkbGetIndicatorMap")
	int kbGetIndicatorMap(Display*, c_ulong, XkbDescPtr);

	@BindingName("XkbSetIndicatorMap")
	int kbSetIndicatorMap(Display*, c_ulong, XkbDescPtr);

	static extern (D) auto kbGetIndicatorMapChanges(T0, T1, T2)(auto ref T0 d,
			auto ref T1 x, auto ref T2 c) {
		return kbGetIndicatorMap(d, c.map_changes, x);
	}

	static extern (D) auto kbChangeIndicatorMaps(T0, T1, T2)(auto ref T0 d, auto ref T1 x,
			auto ref T2 c) {
		return kbSetIndicatorMap(d, c.map_changes, x);
	}

	@BindingName("XkbGetNamedIndicator")
	int kbGetNamedIndicator(Display*, Atom, int*, int*, XkbIndicatorMapPtr, int*);

	@BindingName("XkbGetNamedDeviceIndicator")
	int kbGetNamedDeviceIndicator(Display*, uint, uint, uint, Atom, int*,
			int*, XkbIndicatorMapPtr, int*);

	@BindingName("XkbSetNamedIndicator")
	int kbSetNamedIndicator(Display*, Atom, int, int, int, XkbIndicatorMapPtr);

	@BindingName("XkbSetNamedDeviceIndicator")
	int kbSetNamedDeviceIndicator(Display*, uint, uint, uint, Atom, int, int,
			int, XkbIndicatorMapPtr);

	@BindingName("XkbLockModifiers")
	int kbLockModifiers(Display*, uint, uint, uint);

	@BindingName("XkbLatchModifiers")
	int kbLatchModifiers(Display*, uint, uint, uint);

	@BindingName("XkbLockGroup")
	int kbLockGroup(Display*, uint, uint);

	@BindingName("XkbLatchGroup")
	int kbLatchGroup(Display*, uint, uint);

	@BindingName("XkbSetServerInternalMods")
	int kbSetServerInternalMods(Display*, uint, uint, uint, uint, uint);

	@BindingName("XkbSetIgnoreLockMods")
	int kbSetIgnoreLockMods(Display*, uint, uint, uint, uint, uint);

	@BindingName("XkbVirtualModsToReal")
	int kbVirtualModsToReal(XkbDescPtr, uint, uint*);

	@BindingName("XkbComputeEffectiveMap")
	int kbComputeEffectiveMap(XkbDescPtr, XkbKeyTypePtr, ubyte*);

	@BindingName("XkbInitCanonicalKeyTypes")
	int kbInitCanonicalKeyTypes(XkbDescPtr, uint, int);

	@BindingName("XkbAllocKeyboard")
	XkbDescPtr kbAllocKeyboard();

	@BindingName("XkbFreeKeyboard")
	void kbFreeKeyboard(XkbDescPtr, uint, int);

	@BindingName("XkbAllocClientMap")
	int kbAllocClientMap(XkbDescPtr, uint, uint);

	@BindingName("XkbAllocServerMap")
	int kbAllocServerMap(XkbDescPtr, uint, uint);

	@BindingName("XkbFreeClientMap")
	void kbFreeClientMap(XkbDescPtr, uint, int);

	@BindingName("XkbFreeServerMap")
	void kbFreeServerMap(XkbDescPtr, uint, int);

	@BindingName("XkbAddKeyType")
	XkbKeyTypePtr kbAddKeyType(XkbDescPtr, Atom, int, int, int);

	@BindingName("XkbAllocIndicatorMaps")
	int kbAllocIndicatorMaps(XkbDescPtr);

	@BindingName("XkbFreeIndicatorMaps")
	void kbFreeIndicatorMaps(XkbDescPtr);

	@BindingName("XkbGetMap")
	XkbDescPtr kbGetMap(Display*, uint, uint);

	@BindingName("XkbGetUpdatedMap")
	int kbGetUpdatedMap(Display*, uint, XkbDescPtr);

	@BindingName("XkbGetMapChanges")
	int kbGetMapChanges(Display*, XkbDescPtr, XkbMapChangesPtr);

	@BindingName("XkbRefreshKeyboardMapping")
	int kbRefreshKeyboardMapping(XkbMapNotifyEvent*);

	@BindingName("XkbGetKeyTypes")
	int kbGetKeyTypes(Display*, uint, uint, XkbDescPtr);

	@BindingName("XkbGetKeySyms")
	int kbGetKeySyms(Display*, uint, uint, XkbDescPtr);

	@BindingName("XkbGetKeyActions")
	int kbGetKeyActions(Display*, uint, uint, XkbDescPtr);

	@BindingName("XkbGetKeyBehaviors")
	int kbGetKeyBehaviors(Display*, uint, uint, XkbDescPtr);

	@BindingName("XkbGetVirtualMods")
	int kbGetVirtualMods(Display*, uint, XkbDescPtr);

	@BindingName("XkbGetKeyExplicitComponents")
	int kbGetKeyExplicitComponents(Display*, uint, uint, XkbDescPtr);

	@BindingName("XkbGetKeyModifierMap")
	int kbGetKeyModifierMap(Display*, uint, uint, XkbDescPtr);

	@BindingName("XkbGetKeyVirtualModMap")
	int kbGetKeyVirtualModMap(Display*, uint, uint, XkbDescPtr);

	@BindingName("XkbAllocControls")
	int kbAllocControls(XkbDescPtr, uint);

	@BindingName("XkbFreeControls")
	void kbFreeControls(XkbDescPtr, uint, int);

	@BindingName("XkbGetControls")
	int kbGetControls(Display*, c_ulong, XkbDescPtr);

	@BindingName("XkbSetControls")
	int kbSetControls(Display*, c_ulong, XkbDescPtr);

	@BindingName("XkbNoteControlsChanges")
	void kbNoteControlsChanges(XkbControlsChangesPtr, XkbControlsNotifyEvent*, uint);

	static extern (D) auto kbGetControlsChanges(T0, T1, T2)(auto ref T0 d, auto ref T1 x,
			auto ref T2 c) {
		return kbGetControls(d, c.changed_ctrls, x);
	}

	static extern (D) auto kbChangeControls(T0, T1, T2)(auto ref T0 d, auto ref T1 x, auto ref T2 c) {
		return kbSetControls(d, c.changed_ctrls, x);
	}

	@BindingName("XkbAllocCompatMap")
	int kbAllocCompatMap(XkbDescPtr, uint, uint);

	@BindingName("XkbFreeCompatMap")
	void kbFreeCompatMap(XkbDescPtr, uint, int);

	@BindingName("XkbGetCompatMap")
	int kbGetCompatMap(Display*, uint, XkbDescPtr);

	@BindingName("XkbSetCompatMap")
	int kbSetCompatMap(Display*, uint, XkbDescPtr, int);

	@BindingName("XkbAddSymInterpret")
	XkbSymInterpretPtr kbAddSymInterpret(XkbDescPtr, XkbSymInterpretPtr, int, XkbChangesPtr);

	@BindingName("XkbAllocNames")
	int kbAllocNames(XkbDescPtr, uint, int, int);

	@BindingName("XkbGetNames")
	int kbGetNames(Display*, uint, XkbDescPtr);

	@BindingName("XkbSetNames")
	int kbSetNames(Display*, uint, uint, uint, XkbDescPtr);

	@BindingName("XkbChangeNames")
	int kbChangeNames(Display*, XkbDescPtr, XkbNameChangesPtr);

	@BindingName("XkbFreeNames")
	void kbFreeNames(XkbDescPtr, uint, int);

	@BindingName("XkbGetState")
	int kbGetState(Display*, uint, XkbStatePtr);

	@BindingName("XkbSetMap")
	int kbSetMap(Display*, uint, XkbDescPtr);

	@BindingName("XkbChangeMap")
	int kbChangeMap(Display*, XkbDescPtr, XkbMapChangesPtr);

	@BindingName("XkbSetDetectableAutoRepeat")
	int kbSetDetectableAutoRepeat(Display*, int, int*);

	@BindingName("XkbGetDetectableAutoRepeat")
	int kbGetDetectableAutoRepeat(Display*, int*);

	@BindingName("XkbSetAutoResetControls")
	int kbSetAutoResetControls(Display*, uint, uint*, uint*);

	@BindingName("XkbGetAutoResetControls")
	int kbGetAutoResetControls(Display*, uint*, uint*);

	@BindingName("XkbSetPerClientControls")
	int kbSetPerClientControls(Display*, uint, uint*);

	@BindingName("XkbGetPerClientControls")
	int kbGetPerClientControls(Display*, uint*);

	@BindingName("XkbCopyKeyType")
	int kbCopyKeyType(XkbKeyTypePtr, XkbKeyTypePtr);

	@BindingName("XkbCopyKeyTypes")
	int kbCopyKeyTypes(XkbKeyTypePtr, XkbKeyTypePtr, int);

	@BindingName("XkbResizeKeyType")
	int kbResizeKeyType(XkbDescPtr, int, int, int, int);

	@BindingName("XkbResizeKeySyms")
	KeySym* kbResizeKeySyms(XkbDescPtr, int, int);

	@BindingName("XkbResizeKeyActions")
	XkbAction* kbResizeKeyActions(XkbDescPtr, int, int);

	@BindingName("XkbChangeTypesOfKey")
	int kbChangeTypesOfKey(XkbDescPtr, int, int, uint, int*, XkbMapChangesPtr);

	@BindingName("XkbChangeKeycodeRange")
	int kbChangeKeycodeRange(XkbDescPtr, int, int, XkbChangesPtr);

	@BindingName("XkbListComponents")
	XkbComponentListPtr kbListComponents(Display*, uint, XkbComponentNamesPtr, int*);

	@BindingName("XkbFreeComponentList")
	void kbFreeComponentList(XkbComponentListPtr);

	@BindingName("XkbGetKeyboard")
	XkbDescPtr kbGetKeyboard(Display*, uint, uint);

	@BindingName("XkbGetKeyboardByName")
	XkbDescPtr kbGetKeyboardByName(Display*, uint, XkbComponentNamesPtr, uint, uint, int);

	@BindingName("XkbKeyTypesForCoreSymbols")
	int kbKeyTypesForCoreSymbols(XkbDescPtr, int, KeySym*, uint, int*, KeySym*);

	@BindingName("XkbApplyCompatMapToKey")
	int kbApplyCompatMapToKey(XkbDescPtr, KeyCode, XkbChangesPtr);

	@BindingName("XkbUpdateMapFromCore")
	int kbUpdateMapFromCore(XkbDescPtr, KeyCode, int, int, KeySym*, XkbChangesPtr);

	@BindingName("XkbAddDeviceLedInfo")
	XkbDeviceLedInfoPtr kbAddDeviceLedInfo(XkbDeviceInfoPtr, uint, uint);

	@BindingName("XkbResizeDeviceButtonActions")
	int kbResizeDeviceButtonActions(XkbDeviceInfoPtr, uint);

	@BindingName("XkbAllocDeviceInfo")
	XkbDeviceInfoPtr kbAllocDeviceInfo(uint, uint, uint);

	@BindingName("XkbFreeDeviceInfo")
	void kbFreeDeviceInfo(XkbDeviceInfoPtr, uint, int);

	@BindingName("XkbNoteDeviceChanges")
	void kbNoteDeviceChanges(XkbDeviceChangesPtr, XkbExtensionDeviceNotifyEvent*, uint);

	@BindingName("XkbGetDeviceInfo")
	XkbDeviceInfoPtr kbGetDeviceInfo(Display*, uint, uint, uint, uint);

	@BindingName("XkbGetDeviceInfoChanges")
	int kbGetDeviceInfoChanges(Display*, XkbDeviceInfoPtr, XkbDeviceChangesPtr);

	@BindingName("XkbGetDeviceButtonActions")
	int kbGetDeviceButtonActions(Display*, XkbDeviceInfoPtr, int, uint, uint);

	@BindingName("XkbGetDeviceLedInfo")
	int kbGetDeviceLedInfo(Display*, XkbDeviceInfoPtr, uint, uint, uint);

	@BindingName("XkbSetDeviceInfo")
	int kbSetDeviceInfo(Display*, uint, XkbDeviceInfoPtr);

	@BindingName("XkbChangeDeviceInfo")
	int kbChangeDeviceInfo(Display*, XkbDeviceInfoPtr, XkbDeviceChangesPtr);

	@BindingName("XkbSetDeviceLedInfo")
	int kbSetDeviceLedInfo(Display*, XkbDeviceInfoPtr, uint, uint, uint);

	@BindingName("XkbSetDeviceButtonActions")
	int kbSetDeviceButtonActions(Display*, XkbDeviceInfoPtr, uint, uint);

	@BindingName("XkbToControl")
	char kbToControl(char);

	@BindingName("XkbSetDebuggingFlags")
	int kbSetDebuggingFlags(Display*, uint, uint, char*, uint, uint, uint*, uint*);

	@BindingName("XkbApplyVirtualModChanges")
	int kbApplyVirtualModChanges(XkbDescPtr, uint, XkbChangesPtr);

	@BindingName("XkbUpdateActionVirtualMods")
	int kbUpdateActionVirtualMods(XkbDescPtr, XkbAction*, uint);

	@BindingName("XkbUpdateKeyTypeVirtualMods")
	void kbUpdateKeyTypeVirtualMods(XkbDescPtr, XkbKeyTypePtr, uint, XkbChangesPtr);

	// file '/usr/include/X11/cursorfont.h'

	enum XC_num_glyphs = 154;
	enum XC_X_cursor = 0;
	enum XC_arrow = 2;
	enum XC_based_arrow_down = 4;
	enum XC_based_arrow_up = 6;
	enum XC_boat = 8;
	enum XC_bogosity = 10;
	enum XC_bottom_left_corner = 12;
	enum XC_bottom_right_corner = 14;
	enum XC_bottom_side = 16;
	enum XC_bottom_tee = 18;
	enum XC_box_spiral = 20;
	enum XC_center_ptr = 22;
	enum XC_circle = 24;
	enum XC_clock = 26;
	enum XC_coffee_mug = 28;
	enum XC_cross = 30;
	enum XC_cross_reverse = 32;
	enum XC_crosshair = 34;
	enum XC_diamond_cross = 36;
	enum XC_dot = 38;
	enum XC_dotbox = 40;
	enum XC_double_arrow = 42;
	enum XC_draft_large = 44;
	enum XC_draft_small = 46;
	enum XC_draped_box = 48;
	enum XC_exchange = 50;
	enum XC_fleur = 52;
	enum XC_gobbler = 54;
	enum XC_gumby = 56;
	enum XC_hand1 = 58;
	enum XC_hand2 = 60;
	enum XC_heart = 62;
	enum XC_icon = 64;
	enum XC_iron_cross = 66;
	enum XC_left_ptr = 68;
	enum XC_left_side = 70;
	enum XC_left_tee = 72;
	enum XC_leftbutton = 74;
	enum XC_ll_angle = 76;
	enum XC_lr_angle = 78;
	enum XC_man = 80;
	enum XC_middlebutton = 82;
	enum XC_mouse = 84;
	enum XC_pencil = 86;
	enum XC_pirate = 88;
	enum XC_plus = 90;
	enum XC_question_arrow = 92;
	enum XC_right_ptr = 94;
	enum XC_right_side = 96;
	enum XC_right_tee = 98;
	enum XC_rightbutton = 100;
	enum XC_rtl_logo = 102;
	enum XC_sailboat = 104;
	enum XC_sb_down_arrow = 106;
	enum XC_sb_h_double_arrow = 108;
	enum XC_sb_left_arrow = 110;
	enum XC_sb_right_arrow = 112;
	enum XC_sb_up_arrow = 114;
	enum XC_sb_v_double_arrow = 116;
	enum XC_shuttle = 118;
	enum XC_sizing = 120;
	enum XC_spider = 122;
	enum XC_spraycan = 124;
	enum XC_star = 126;
	enum XC_target = 128;
	enum XC_tcross = 130;
	enum XC_top_left_arrow = 132;
	enum XC_top_left_corner = 134;
	enum XC_top_right_corner = 136;
	enum XC_top_side = 138;
	enum XC_top_tee = 140;
	enum XC_trek = 142;
	enum XC_ul_angle = 144;
	enum XC_umbrella = 146;
	enum XC_ur_angle = 148;
	enum XC_watch = 150;
	enum XC_xterm = 152;
	// file '/usr/include/X11/Xlib.h'

	import core.stdc.config;
	import core.stdc.stddef;

	enum XlibSpecificationRelease = 6;

	alias XPointer = char*;

	struct XExtData {
		int number;
		XExtData* next;
		int function(XExtData* extension) free_private;
		XPointer private_data;
	}

	struct XExtCodes {
		int extension;
		int major_opcode;
		int first_event;
		int first_error;
	}

	struct XPixmapFormatValues {
		int depth;
		int bits_per_pixel;
		int scanline_pad;
	}

	struct XGCValues {
		int function_;
		c_ulong plane_mask;
		c_ulong foreground;
		c_ulong background;
		int line_width;
		int line_style;
		int cap_style;

		int join_style;
		int fill_style;

		int fill_rule;
		int arc_mode;
		Pixmap tile;
		Pixmap stipple;
		int ts_x_origin;
		int ts_y_origin;
		Font font;
		int subwindow_mode;
		int graphics_exposures;
		int clip_x_origin;
		int clip_y_origin;
		Pixmap clip_mask;
		int dash_offset;
		char dashes;
	}

	struct PrivateXGC;
	alias GC = PrivateXGC*;

	struct Visual {
		XExtData* ext_data;
		VisualID visualid;

		int class_;

		c_ulong red_mask;
		c_ulong green_mask;
		c_ulong blue_mask;
		int bits_per_rgb;
		int map_entries;
	}

	struct Depth {
		int depth;
		int nvisuals;
		Visual* visuals;
	}

	struct PrivateXDisplay;

	struct Screen {
		XExtData* ext_data;
		PrivateXDisplay* display;
		Window root;
		int width;
		int height;
		int mwidth;
		int mheight;
		int ndepths;
		Depth* depths;
		int root_depth;
		Visual* root_visual;
		GC default_gc;
		Colormap cmap;
		c_ulong white_pixel;
		c_ulong black_pixel;
		int max_maps;
		int min_maps;
		int backing_store;
		int save_unders;
		c_long root_input_mask;
	}

	struct ScreenFormat {
		XExtData* ext_data;
		int depth;
		int bits_per_pixel;
		int scanline_pad;
	}

	struct XSetWindowAttributes {
		Pixmap background_pixmap;
		c_ulong background_pixel;
		Pixmap border_pixmap;
		c_ulong border_pixel;
		int bit_gravity;
		int win_gravity;
		int backing_store;
		c_ulong backing_planes;
		c_ulong backing_pixel;
		int save_under;
		c_long event_mask;
		c_long do_not_propagate_mask;
		int override_redirect;
		Colormap colormap;
		Cursor cursor;
	}

	struct XWindowAttributes {
		int x;
		int y;
		int width;
		int height;
		int border_width;
		int depth;
		Visual* visual;
		Window root;

		int class_;

		int bit_gravity;
		int win_gravity;
		int backing_store;
		c_ulong backing_planes;
		c_ulong backing_pixel;
		int save_under;
		Colormap colormap;
		int map_installed;
		int map_state;
		c_long all_event_masks;
		c_long your_event_mask;
		c_long do_not_propagate_mask;
		int override_redirect;
		Screen* screen;
	}

	struct XHostAddress {
		int family;
		int length;
		char* address;
	}

	struct XServerInterpretedAddress {
		int typelength;
		int valuelength;
		char* type;
		char* value;
	}

	struct XImage {
		int width;
		int height;
		int xoffset;
		int format;
		char* data;
		int byte_order;
		int bitmap_unit;
		int bitmap_bit_order;
		int bitmap_pad;
		int depth;
		int bytes_per_line;
		int bits_per_pixel;
		c_ulong red_mask;
		c_ulong green_mask;
		c_ulong blue_mask;
		XPointer obdata;

		struct Funcs {
			XImage* function(PrivateXDisplay*, Visual*, uint, int, int,
					char*, uint, uint, int, int) create_image;
			int function(XImage*) destroy_image;
			c_ulong function(XImage*, int, int) get_pixel;
			int function(XImage*, int, int, c_ulong) put_pixel;
			XImage* function(XImage*, int, int, uint, uint) sub_image;
			int function(XImage*, c_long) add_pixel;
		}

		Funcs f;
	}

	struct XWindowChanges {
		int x;
		int y;
		int width;
		int height;
		int border_width;
		Window sibling;
		int stack_mode;
	}

	struct XColor {
		c_ulong pixel;
		ushort red;
		ushort green;
		ushort blue;
		char flags;
		char pad;
	}

	struct XSegment {
		short x1;
		short y1;
		short x2;
		short y2;
	}

	struct XPoint {
		short x;
		short y;
	}

	struct XRectangle {
		short x;
		short y;
		ushort width;
		ushort height;
	}

	struct XArc {
		short x;
		short y;
		ushort width;
		ushort height;
		short angle1;
		short angle2;
	}

	struct XKeyboardControl {
		int key_click_percent;
		int bell_percent;
		int bell_pitch;
		int bell_duration;
		int led;
		int led_mode;
		int key;
		int auto_repeat_mode;
	}

	struct XKeyboardState {
		int key_click_percent;
		int bell_percent;
		uint bell_pitch;
		uint bell_duration;
		c_ulong led_mask;
		int global_auto_repeat;
		char[32] auto_repeats;
	}

	struct XTimeCoord {
		Time time;
		short x;
		short y;
	}

	struct XModifierKeymap {
		int max_keypermod;
		KeyCode* modifiermap;
	}

	alias Display = PrivateXDisplay;

	struct PrivateXPrivate;
	struct PrivateXrmHashBucketRec;

	struct PrivateXPrivDisplay {
		XExtData* ext_data;
		PrivateXPrivate* private1;
		int fd;
		int private2;
		int proto_major_version;
		int proto_minor_version;
		char* vendor;
		XID private3;
		XID private4;
		XID private5;
		int private6;
		XID function(PrivateXDisplay*) resource_alloc;
		int byte_order;
		int bitmap_unit;
		int bitmap_pad;
		int bitmap_bit_order;
		int nformats;
		ScreenFormat* pixmap_format;
		int private8;
		int release;
		PrivateXPrivate* private9;
		PrivateXPrivate* private10;
		int qlen;
		c_ulong last_request_read;
		c_ulong request;
		XPointer private11;
		XPointer private12;
		XPointer private13;
		XPointer private14;
		uint max_request_size;
		PrivateXrmHashBucketRec* db;
		int function(PrivateXDisplay*) private15;
		char* display_name;
		int default_screen;
		int nscreens;
		Screen* screens;
		c_ulong motion_buffer;
		c_ulong private16;
		int min_keycode;
		int max_keycode;
		XPointer private17;
		XPointer private18;
		int private19;
		char* xdefaults;
	}

	struct XKeyEvent {
		int type;
		c_ulong serial;
		int send_event;
		Display* display;
		Window window;
		Window root;
		Window subwindow;
		Time time;
		int x;
		int y;
		int x_root;
		int y_root;
		uint state;
		uint keycode;
		int same_screen;
	}

	alias XKeyPressedEvent = XKeyEvent;
	alias XKeyReleasedEvent = XKeyEvent;

	struct XButtonEvent {
		int type;
		c_ulong serial;
		int send_event;
		Display* display;
		Window window;
		Window root;
		Window subwindow;
		Time time;
		int x;
		int y;
		int x_root;
		int y_root;
		uint state;
		uint button;
		int same_screen;
	}

	alias XButtonPressedEvent = XButtonEvent;
	alias XButtonReleasedEvent = XButtonEvent;

	struct XMotionEvent {
		int type;
		c_ulong serial;
		int send_event;
		Display* display;
		Window window;
		Window root;
		Window subwindow;
		Time time;
		int x;
		int y;
		int x_root;
		int y_root;
		uint state;
		char is_hint;
		int same_screen;
	}

	alias XPointerMovedEvent = XMotionEvent;

	struct XCrossingEvent {
		int type;
		c_ulong serial;
		int send_event;
		Display* display;
		Window window;
		Window root;
		Window subwindow;
		Time time;
		int x;
		int y;
		int x_root;
		int y_root;
		int mode;
		int detail;

		int same_screen;
		int focus;
		uint state;
	}

	alias XEnterWindowEvent = XCrossingEvent;
	alias XLeaveWindowEvent = XCrossingEvent;

	struct XFocusChangeEvent {
		int type;
		c_ulong serial;
		int send_event;
		Display* display;
		Window window;
		int mode;

		int detail;
	}

	alias XFocusInEvent = XFocusChangeEvent;
	alias XFocusOutEvent = XFocusChangeEvent;

	struct XKeymapEvent {
		int type;
		c_ulong serial;
		int send_event;
		Display* display;
		Window window;
		char[32] key_vector;
	}

	struct XExposeEvent {
		int type;
		c_ulong serial;
		int send_event;
		Display* display;
		Window window;
		int x;
		int y;
		int width;
		int height;
		int count;
	}

	struct XGraphicsExposeEvent {
		int type;
		c_ulong serial;
		int send_event;
		Display* display;
		Drawable drawable;
		int x;
		int y;
		int width;
		int height;
		int count;
		int major_code;
		int minor_code;
	}

	struct XNoExposeEvent {
		int type;
		c_ulong serial;
		int send_event;
		Display* display;
		Drawable drawable;
		int major_code;
		int minor_code;
	}

	struct XVisibilityEvent {
		int type;
		c_ulong serial;
		int send_event;
		Display* display;
		Window window;
		int state;
	}

	struct XCreateWindowEvent {
		int type;
		c_ulong serial;
		int send_event;
		Display* display;
		Window parent;
		Window window;
		int x;
		int y;
		int width;
		int height;
		int border_width;
		int override_redirect;
	}

	struct XDestroyWindowEvent {
		int type;
		c_ulong serial;
		int send_event;
		Display* display;
		Window event;
		Window window;
	}

	struct XUnmapEvent {
		int type;
		c_ulong serial;
		int send_event;
		Display* display;
		Window event;
		Window window;
		int from_configure;
	}

	struct XMapEvent {
		int type;
		c_ulong serial;
		int send_event;
		Display* display;
		Window event;
		Window window;
		int override_redirect;
	}

	struct XMapRequestEvent {
		int type;
		c_ulong serial;
		int send_event;
		Display* display;
		Window parent;
		Window window;
	}

	struct XReparentEvent {
		int type;
		c_ulong serial;
		int send_event;
		Display* display;
		Window event;
		Window window;
		Window parent;
		int x;
		int y;
		int override_redirect;
	}

	struct XConfigureEvent {
		int type;
		c_ulong serial;
		int send_event;
		Display* display;
		Window event;
		Window window;
		int x;
		int y;
		int width;
		int height;
		int border_width;
		Window above;
		int override_redirect;
	}

	struct XGravityEvent {
		int type;
		c_ulong serial;
		int send_event;
		Display* display;
		Window event;
		Window window;
		int x;
		int y;
	}

	struct XResizeRequestEvent {
		int type;
		c_ulong serial;
		int send_event;
		Display* display;
		Window window;
		int width;
		int height;
	}

	struct XConfigureRequestEvent {
		int type;
		c_ulong serial;
		int send_event;
		Display* display;
		Window parent;
		Window window;
		int x;
		int y;
		int width;
		int height;
		int border_width;
		Window above;
		int detail;
		c_ulong value_mask;
	}

	struct XCirculateEvent {
		int type;
		c_ulong serial;
		int send_event;
		Display* display;
		Window event;
		Window window;
		int place;
	}

	struct XCirculateRequestEvent {
		int type;
		c_ulong serial;
		int send_event;
		Display* display;
		Window parent;
		Window window;
		int place;
	}

	struct XPropertyEvent {
		int type;
		c_ulong serial;
		int send_event;
		Display* display;
		Window window;
		Atom atom;
		Time time;
		int state;
	}

	struct XSelectionClearEvent {
		int type;
		c_ulong serial;
		int send_event;
		Display* display;
		Window window;
		Atom selection;
		Time time;
	}

	struct XSelectionRequestEvent {
		int type;
		c_ulong serial;
		int send_event;
		Display* display;
		Window owner;
		Window requestor;
		Atom selection;
		Atom target;
		Atom property;
		Time time;
	}

	struct XSelectionEvent {
		int type;
		c_ulong serial;
		int send_event;
		Display* display;
		Window requestor;
		Atom selection;
		Atom target;
		Atom property;
		Time time;
	}

	struct XColormapEvent {
		int type;
		c_ulong serial;
		int send_event;
		Display* display;
		Window window;
		Colormap colormap;

		int new_;

		int state;
	}

	struct XClientMessageEvent {
		int type;
		c_ulong serial;
		int send_event;
		Display* display;
		Window window;
		Atom message_type;
		int format;

		union PrivateAnonymous_0 {
			char[20] b;
			short[10] s;
			c_long[5] l;
		}

		PrivateAnonymous_0 data;
	}

	struct XMappingEvent {
		int type;
		c_ulong serial;
		int send_event;
		Display* display;
		Window window;
		int request;

		int first_keycode;
		int count;
	}

	struct XErrorEvent {
		int type;
		Display* display;
		XID resourceid;
		c_ulong serial;
		ubyte error_code;
		ubyte request_code;
		ubyte minor_code;
	}

	struct XAnyEvent {
		int type;
		c_ulong serial;
		int send_event;
		Display* display;
		Window window;
	}

	struct XGenericEvent {
		int type;
		c_ulong serial;
		int send_event;
		Display* display;
		int extension;
		int evtype;
	}

	struct XGenericEventCookie {
		int type;
		c_ulong serial;
		int send_event;
		Display* display;
		int extension;
		int evtype;
		uint cookie;
		void* data;
	}

	union XEvent {
		int type;
		XAnyEvent xany;
		XKeyEvent xkey;
		XButtonEvent xbutton;
		XMotionEvent xmotion;
		XCrossingEvent xcrossing;
		XFocusChangeEvent xfocus;
		XExposeEvent xexpose;
		XGraphicsExposeEvent xgraphicsexpose;
		XNoExposeEvent xnoexpose;
		XVisibilityEvent xvisibility;
		XCreateWindowEvent xcreatewindow;
		XDestroyWindowEvent xdestroywindow;
		XUnmapEvent xunmap;
		XMapEvent xmap;
		XMapRequestEvent xmaprequest;
		XReparentEvent xreparent;
		XConfigureEvent xconfigure;
		XGravityEvent xgravity;
		XResizeRequestEvent xresizerequest;
		XConfigureRequestEvent xconfigurerequest;
		XCirculateEvent xcirculate;
		XCirculateRequestEvent xcirculaterequest;
		XPropertyEvent xproperty;
		XSelectionClearEvent xselectionclear;
		XSelectionRequestEvent xselectionrequest;
		XSelectionEvent xselection;
		XColormapEvent xcolormap;
		XClientMessageEvent xclient;
		XMappingEvent xmapping;
		XErrorEvent xerror;
		XKeymapEvent xkeymap;
		XGenericEvent xgeneric;
		XGenericEventCookie xcookie;
		c_long[24] pad;
	}

	struct XCharStruct {
		short lbearing;
		short rbearing;
		short width;
		short ascent;
		short descent;
		ushort attributes;
	}

	struct XFontProp {
		Atom name;
		c_ulong card32;
	}

	struct XFontStruct {
		XExtData* ext_data;
		Font fid;
		uint direction;
		uint min_char_or_byte2;
		uint max_char_or_byte2;
		uint min_byte1;
		uint max_byte1;
		int all_chars_exist;
		uint default_char;
		int n_properties;
		XFontProp* properties;
		XCharStruct min_bounds;
		XCharStruct max_bounds;
		XCharStruct* per_char;
		int ascent;
		int descent;
	}

	struct XTextItem {
		char* chars;
		int nchars;
		int delta;
		Font font;
	}

	struct XChar2b {
		ubyte byte1;
		ubyte byte2;
	}

	struct XTextItem16 {
		XChar2b* chars;
		int nchars;
		int delta;
		Font font;
	}

	union XEDataObject {
		Display* display;
		GC gc;
		Visual* visual;
		Screen* screen;
		ScreenFormat* pixmap_format;
		XFontStruct* font;
	}

	struct XFontSetExtents {
		XRectangle max_ink_extent;
		XRectangle max_logical_extent;
	}

	struct PrivateXOM;
	alias XOM = PrivateXOM*;
	struct PrivateXOC;
	alias XOC = PrivateXOC*;
	alias XFontSet = PrivateXOC*;

	struct XmbTextItem {
		char* chars;
		int nchars;
		int delta;
		XFontSet font_set;
	}

	struct XwcTextItem {
		wchar_t* chars;
		int nchars;
		int delta;
		XFontSet font_set;
	}

	struct XOMCharSetList {
		int charset_count;
		char** charset_list;
	}

	enum XOrientation {
		XOMOrientation_LTR_TTB = 0,
		XOMOrientation_RTL_TTB = 1,
		XOMOrientation_TTB_LTR = 2,
		XOMOrientation_TTB_RTL = 3,
		XOMOrientation_Context = 4
	}

	struct XOMOrientation {
		int num_orientation;
		XOrientation* orientation;
	}

	struct XOMFontInfo {
		int num_font;
		XFontStruct** font_struct_list;
		char** font_name_list;
	}

	struct PrivateXIM;
	alias XIM = PrivateXIM*;
	struct PrivateXIC;
	alias XIC = PrivateXIC*;

	alias XIMProc = void function(XIM, XPointer, XPointer);

	alias XICProc = int function(XIC, XPointer, XPointer);

	alias XIDProc = void function(Display*, XPointer, XPointer);

	alias XIMStyle = c_ulong;

	struct XIMStyles {
		ushort count_styles;
		XIMStyle* supported_styles;
	}

	alias XVaNestedList = void*;

	struct XIMCallback {
		XPointer client_data;
		XIMProc callback;
	}

	struct XICCallback {
		XPointer client_data;
		XICProc callback;
	}

	alias XIMFeedback = c_ulong;

	struct XIMText {
		ushort length;
		XIMFeedback* feedback;
		int encoding_is_wchar;

		union _Anonymous_1 {
			char* multi_byte;
			wchar_t* wide_char;
		}

		_Anonymous_1 string;
	}

	alias XIMPreeditState = c_ulong;

	struct XIMPreeditStateNotifyCallbackStruct {
		XIMPreeditState state;
	}

	alias XIMResetState = c_ulong;

	alias XIMStringConversionFeedback = c_ulong;

	struct XIMStringConversionText {
		ushort length;
		XIMStringConversionFeedback* feedback;
		int encoding_is_wchar;

		union _Anonymous_2 {
			char* mbs;
			wchar_t* wcs;
		}

		_Anonymous_2 string;
	}

	alias XIMStringConversionPosition = ushort;

	alias XIMStringConversionType = ushort;

	alias XIMStringConversionOperation = ushort;

	enum XIMCaretDirection {
		XIMForwardChar = 0,
		XIMBackwardChar = 1,
		XIMForwardWord = 2,
		XIMBackwardWord = 3,
		XIMCaretUp = 4,
		XIMCaretDown = 5,
		XIMNextLine = 6,
		XIMPreviousLine = 7,
		XIMLineStart = 8,
		XIMLineEnd = 9,
		XIMAbsolutePosition = 10,
		XIMDontChange = 11
	}

	struct XIMStringConversionCallbackStruct {
		XIMStringConversionPosition position;
		XIMCaretDirection direction;
		XIMStringConversionOperation operation;
		ushort factor;
		XIMStringConversionText* text;
	}

	struct XIMPreeditDrawCallbackStruct {
		int caret;
		int chg_first;
		int chg_length;
		XIMText* text;
	}

	enum XIMCaretStyle {
		XIMIsInvisible = 0,
		XIMIsPrimary = 1,
		XIMIsSecondary = 2
	}

	struct XIMPreeditCaretCallbackStruct {
		int position;
		XIMCaretDirection direction;
		XIMCaretStyle style;
	}

	enum XIMStatusDataType {
		XIMTextType = 0,
		XIMBitmapType = 1
	}

	struct XIMStatusDrawCallbackStruct {
		XIMStatusDataType type;

		union _Anonymous_3 {
			XIMText* text;
			Pixmap bitmap;
		}

		_Anonymous_3 data;
	}

	struct XIMHotKeyTrigger {
		KeySym keysym;
		int modifier;
		int modifier_mask;
	}

	struct XIMHotKeyTriggers {
		int num_hot_key;
		XIMHotKeyTrigger* key;
	}

	alias XIMHotKeyState = c_ulong;

	struct XIMValuesList {
		ushort count_values;
		char** supported_values;
	}

	XFontStruct* loadQueryFont(Display*, const(char)*);

	XFontStruct* queryFont(Display*, XID);

	XTimeCoord* getMotionEvents(Display*, Window, Time, Time, int*);

	XModifierKeymap* deleteModifiermapEntry(XModifierKeymap*, KeyCode, int);

	XModifierKeymap* getModifierMapping(Display*);

	XModifierKeymap* insertModifiermapEntry(XModifierKeymap*, KeyCode, int);

	XModifierKeymap* newModifiermap(int);

	XImage* createImage(Display*, Visual*, uint, int, int, char*, uint, uint, int, int);
	int initImage(XImage*);
	XImage* getImage(Display*, Drawable, int, int, uint, uint, c_ulong, int);
	XImage* getSubImage(Display*, Drawable, int, int, uint, uint, c_ulong,
			int, XImage*, int, int);

	Display* openDisplay(const(char)*);

	@BindingName("XrmInitialize")
	void rmInitialize();

	char* fetchBytes(Display*, int*);
	char* fetchBuffer(Display*, int*, int);
	char* getAtomName(Display*, Atom);
	int getAtomNames(Display*, Atom*, int, char**);
	char* getDefault(Display*, const(char)*, const(char)*);
	char* displayName(const(char)*);
	char* keysymToString(KeySym);

	int function(Display*, Display*, int) synchronize(Display*, Display*, int);
	int function(Display*, Display*, int function(Display*)) setAfterFunction(Display*,
			Display*, int function(Display*));
	Atom internAtom(Display*, const(char)*, int);
	int internAtoms(Display*, char**, int, int, Atom*);
	Colormap copyColormapAndFree(Display*, Colormap);
	Colormap createColormap(Display*, Window, Visual*, int);
	Cursor createPixmapCursor(Display*, Pixmap, Pixmap, XColor*, XColor*, uint, uint);
	Cursor createGlyphCursor(Display*, Font, Font, uint, uint, const(XColor)*, const(XColor)*);
	Cursor createFontCursor(Display*, uint);
	Font loadFont(Display*, const(char)*);
	GC createGC(Display*, Drawable, c_ulong, XGCValues*);
	@BindingName("XGContextFromGC")
	GContext gContextFromGC(GC);
	void flushGC(Display*, GC);
	Pixmap createPixmap(Display*, Drawable, uint, uint, uint);
	Pixmap createBitmapFromData(Display*, Drawable, const(char)*, uint, uint);
	Pixmap createPixmapFromBitmapData(Display*, Drawable, char*, uint, uint,
			c_ulong, c_ulong, uint);
	Window createSimpleWindow(Display*, Window, int, int, uint, uint, uint, c_ulong, c_ulong);
	Window getSelectionOwner(Display*, Atom);
	Window createWindow(Display*, Window, int, int, uint, uint, uint, int,
			uint, Visual*, c_ulong, XSetWindowAttributes*);
	Colormap* listInstalledColormaps(Display*, Window, int*);
	char** listFonts(Display*, const(char)*, int, int*);
	char** listFontsWithInfo(Display*, const(char)*, int, int*, XFontStruct**);
	char** getFontPath(Display*, int*);
	char** listExtensions(Display*, int*);
	Atom* listProperties(Display*, Window, int*);
	XHostAddress* listHosts(Display*, int*, int*);
	KeySym keycodeToKeysym(Display*, KeyCode, int);
	KeySym lookupKeysym(XKeyEvent*, int);
	KeySym* getKeyboardMapping(Display*, KeyCode, int, int*);
	KeySym stringToKeysym(const(char)*);
	c_long maxRequestSize(Display*);
	c_long extendedMaxRequestSize(Display*);
	char* resourceManagerString(Display*);
	char* screenResourceString(Screen*);
	c_ulong displayMotionBufferSize(Display*);
	VisualID visualIDFromVisual(Visual*);

	int initThreads();

	void lockDisplay(Display*);

	void unlockDisplay(Display*);

	XExtCodes* initExtension(Display*, const(char)*);

	XExtCodes* addExtension(Display*);
	XExtData* findOnExtensionList(XExtData**, int);
	@BindingName("XEHeadOfExtensionList")
	XExtData** eHeadOfExtensionList(XEDataObject);

	Window rootWindow(Display*, int);
	Window defaultRootWindow(Display*);
	Window rootWindowOfScreen(Screen*);
	Visual* defaultVisual(Display*, int);
	Visual* defaultVisualOfScreen(Screen*);
	GC defaultGC(Display*, int);
	GC defaultGCOfScreen(Screen*);
	c_ulong blackPixel(Display*, int);
	c_ulong whitePixel(Display*, int);
	c_ulong allPlanes();
	c_ulong blackPixelOfScreen(Screen*);
	c_ulong whitePixelOfScreen(Screen*);
	c_ulong nextRequest(Display*);
	c_ulong lastKnownRequestProcessed(Display*);
	char* serverVendor(Display*);
	char* displayString(Display*);
	Colormap defaultColormap(Display*, int);
	Colormap defaultColormapOfScreen(Screen*);
	Display* displayOfScreen(Screen*);
	Screen* screenOfDisplay(Display*, int);
	Screen* defaultScreenOfDisplay(Display*);
	c_long eventMaskOfScreen(Screen*);

	int screenNumberOfScreen(Screen*);

	alias XErrorHandler = int function(Display*, XErrorEvent*);

	XErrorHandler setErrorHandler(XErrorHandler);

	alias XIOErrorHandler = int function(Display*);

	XIOErrorHandler setIOErrorHandler(XIOErrorHandler);

	alias XIOErrorExitHandler = void function(Display*, void*);

	void setIOErrorExitHandler(Display*, XIOErrorExitHandler, void*);

	XPixmapFormatValues* listPixmapFormats(Display*, int*);
	int* listDepths(Display*, int, int*);

	int reconfigureWMWindow(Display*, Window, int, uint, XWindowChanges*);

	int getWMProtocols(Display*, Window, Atom**, int*);
	int setWMProtocols(Display*, Window, Atom*, int);
	int iconifyWindow(Display*, Window, int);
	int withdrawWindow(Display*, Window, int);
	int getCommand(Display*, Window, char***, int*);
	int getWMColormapWindows(Display*, Window, Window**, int*);
	int setWMColormapWindows(Display*, Window, Window*, int);
	void freeStringList(char**);
	int setTransientForHint(Display*, Window, Window);

	int activateScreenSaver(Display*);

	int addHost(Display*, XHostAddress*);

	int addHosts(Display*, XHostAddress*, int);

	int addToExtensionList(XExtData**, XExtData*);

	int addToSaveSet(Display*, Window);

	int allocColor(Display*, Colormap, XColor*);

	int allocColorCells(Display*, Colormap, int, c_ulong*, uint, c_ulong*, uint);

	int allocColorPlanes(Display*, Colormap, int, c_ulong*, int, int, int,
			int, c_ulong*, c_ulong*, c_ulong*);

	int allocNamedColor(Display*, Colormap, const(char)*, XColor*, XColor*);

	int allowEvents(Display*, int, Time);

	int autoRepeatOff(Display*);

	int autoRepeatOn(Display*);

	int bell(Display*, int);

	int bitmapBitOrder(Display*);

	int bitmapPad(Display*);

	int bitmapUnit(Display*);

	int cellsOfScreen(Screen*);

	int changeActivePointerGrab(Display*, uint, Cursor, Time);

	int changeGC(Display*, GC, c_ulong, XGCValues*);

	int changeKeyboardControl(Display*, c_ulong, XKeyboardControl*);

	int changeKeyboardMapping(Display*, int, int, KeySym*, int);

	int changePointerControl(Display*, int, int, int, int, int);

	int changeProperty(Display*, Window, Atom, Atom, int, int, const(ubyte)*, int);

	int changeSaveSet(Display*, Window, int);

	int changeWindowAttributes(Display*, Window, c_ulong, XSetWindowAttributes*);

	int checkIfEvent(Display*, XEvent*, int function(Display*, XEvent*, XPointer), XPointer);

	int checkMaskEvent(Display*, c_long, XEvent*);

	int checkTypedEvent(Display*, int, XEvent*);

	int checkTypedWindowEvent(Display*, Window, int, XEvent*);

	int checkWindowEvent(Display*, Window, c_long, XEvent*);

	int circulateSubwindows(Display*, Window, int);

	int circulateSubwindowsDown(Display*, Window);

	int circulateSubwindowsUp(Display*, Window);

	int clearArea(Display*, Window, int, int, uint, uint, int);

	int clearWindow(Display*, Window);

	int closeDisplay(Display*);

	int configureWindow(Display*, Window, uint, XWindowChanges*);

	int connectionNumber(Display*);

	int convertSelection(Display*, Atom, Atom, Atom, Window, Time);

	int copyArea(Display*, Drawable, Drawable, GC, int, int, uint, uint, int, int);

	int copyGC(Display*, GC, c_ulong, GC);

	int copyPlane(Display*, Drawable, Drawable, GC, int, int, uint, uint, int, int, c_ulong);

	int defaultDepth(Display*, int);

	int defaultDepthOfScreen(Screen*);

	int defaultScreen(Display*);

	int defineCursor(Display*, Window, Cursor);

	int deleteProperty(Display*, Window, Atom);

	int destroyWindow(Display*, Window);

	int destroySubwindows(Display*, Window);

	int doesBackingStore(Screen*);

	int doesSaveUnders(Screen*);

	int disableAccessControl(Display*);

	int displayCells(Display*, int);

	int displayHeight(Display*, int);

	int displayHeightMM(Display*, int);

	int displayKeycodes(Display*, int*, int*);

	int displayPlanes(Display*, int);

	int displayWidth(Display*, int);

	int displayWidthMM(Display*, int);

	int drawArc(Display*, Drawable, GC, int, int, uint, uint, int, int);

	int drawArcs(Display*, Drawable, GC, XArc*, int);

	int drawImageString(Display*, Drawable, GC, int, int, const(char)*, int);

	int drawImageString16(Display*, Drawable, GC, int, int, const(XChar2b)*, int);

	int drawLine(Display*, Drawable, GC, int, int, int, int);

	int drawLines(Display*, Drawable, GC, XPoint*, int, int);

	int drawPoint(Display*, Drawable, GC, int, int);

	int drawPoints(Display*, Drawable, GC, XPoint*, int, int);

	int drawRectangle(Display*, Drawable, GC, int, int, uint, uint);

	int drawRectangles(Display*, Drawable, GC, XRectangle*, int);

	int drawSegments(Display*, Drawable, GC, XSegment*, int);

	int drawString(Display*, Drawable, GC, int, int, const(char)*, int);

	int drawString16(Display*, Drawable, GC, int, int, const(XChar2b)*, int);

	int drawText(Display*, Drawable, GC, int, int, XTextItem*, int);

	int drawText16(Display*, Drawable, GC, int, int, XTextItem16*, int);

	int enableAccessControl(Display*);

	int eventsQueued(Display*, int);

	int fetchName(Display*, Window, char**);

	int fillArc(Display*, Drawable, GC, int, int, uint, uint, int, int);

	int fillArcs(Display*, Drawable, GC, XArc*, int);

	int fillPolygon(Display*, Drawable, GC, XPoint*, int, int, int);

	int fillRectangle(Display*, Drawable, GC, int, int, uint, uint);

	int fillRectangles(Display*, Drawable, GC, XRectangle*, int);

	int flush(Display*);

	int forceScreenSaver(Display*, int);

	int free(void*);

	int freeColormap(Display*, Colormap);

	int freeColors(Display*, Colormap, c_ulong*, int, c_ulong);

	int freeCursor(Display*, Cursor);

	int freeExtensionList(char**);

	int freeFont(Display*, XFontStruct*);

	int freeFontInfo(char**, XFontStruct*, int);

	int freeFontNames(char**);

	int freeFontPath(char**);

	int freeGC(Display*, GC);

	int freeModifiermap(XModifierKeymap*);

	int freePixmap(Display*, Pixmap);

	int geometry(Display*, int, const(char)*, const(char)*, uint, uint,
			uint, int, int, int*, int*, int*, int*);

	int getErrorDatabaseText(Display*, const(char)*, const(char)*, const(char)*, char*, int);

	int getErrorText(Display*, int, char*, int);

	int getFontProperty(XFontStruct*, Atom, c_ulong*);

	int getGCValues(Display*, GC, c_ulong, XGCValues*);

	int getGeometry(Display*, Drawable, Window*, int*, int*, uint*, uint*, uint*, uint*);

	int getIconName(Display*, Window, char**);

	int getInputFocus(Display*, Window*, int*);

	int getKeyboardControl(Display*, XKeyboardState*);

	int getPointerControl(Display*, int*, int*, int*);

	int getPointerMapping(Display*, ubyte*, int);

	int getScreenSaver(Display*, int*, int*, int*, int*);

	int getTransientForHint(Display*, Window, Window*);

	int getWindowProperty(Display*, Window, Atom, c_long, c_long, int, Atom,
			Atom*, int*, c_ulong*, c_ulong*, ubyte**);

	int getWindowAttributes(Display*, Window, XWindowAttributes*);

	int grabButton(Display*, uint, uint, Window, int, uint, int, int, Window, Cursor);

	int grabKey(Display*, int, uint, Window, int, int, int);

	int grabKeyboard(Display*, Window, int, int, int, Time);

	int grabPointer(Display*, Window, int, uint, int, int, Window, Cursor, Time);

	int grabServer(Display*);

	int heightMMOfScreen(Screen*);

	int heightOfScreen(Screen*);

	int ifEvent(Display*, XEvent*, int function(Display*, XEvent*, XPointer), XPointer);

	int imageByteOrder(Display*);

	int installColormap(Display*, Colormap);

	KeyCode keysymToKeycode(Display*, KeySym);

	int killClient(Display*, XID);

	int lookupColor(Display*, Colormap, const(char)*, XColor*, XColor*);

	int lowerWindow(Display*, Window);

	int mapRaised(Display*, Window);

	int mapSubwindows(Display*, Window);

	int mapWindow(Display*, Window);

	int maskEvent(Display*, c_long, XEvent*);

	int maxCmapsOfScreen(Screen*);

	int minCmapsOfScreen(Screen*);

	int moveResizeWindow(Display*, Window, int, int, uint, uint);

	int moveWindow(Display*, Window, int, int);

	int nextEvent(Display*, XEvent*);

	int noOp(Display*);

	int parseColor(Display*, Colormap, const(char)*, XColor*);

	int parseGeometry(const(char)*, int*, int*, uint*, uint*);

	int peekEvent(Display*, XEvent*);

	int peekIfEvent(Display*, XEvent*, int function(Display*, XEvent*, XPointer), XPointer);

	int pending(Display*);

	int planesOfScreen(Screen*);

	int protocolRevision(Display*);

	int protocolVersion(Display*);

	int putBackEvent(Display*, XEvent*);

	int putImage(Display*, Drawable, GC, XImage*, int, int, int, int, uint, uint);

	@BindingName("XQLength")
	int qLength(Display*);

	int queryBestCursor(Display*, Drawable, uint, uint, uint*, uint*);

	int queryBestSize(Display*, int, Drawable, uint, uint, uint*, uint*);

	int queryBestStipple(Display*, Drawable, uint, uint, uint*, uint*);

	int queryBestTile(Display*, Drawable, uint, uint, uint*, uint*);

	int queryColor(Display*, Colormap, XColor*);

	int queryColors(Display*, Colormap, XColor*, int);

	int queryExtension(Display*, const(char)*, int*, int*, int*);

	int queryKeymap(Display*, ref char[32]);

	int queryPointer(Display*, Window, Window*, Window*, int*, int*, int*, int*, uint*);

	int queryTextExtents(Display*, XID, const(char)*, int, int*, int*, int*, XCharStruct*);

	int queryTextExtents16(Display*, XID, const(XChar2b)*, int, int*, int*,
			int*, XCharStruct*);

	int queryTree(Display*, Window, Window*, Window*, Window**, uint*);

	int raiseWindow(Display*, Window);

	int readBitmapFile(Display*, Drawable, const(char)*, uint*, uint*, Pixmap*, int*, int*);

	int readBitmapFileData(const(char)*, uint*, uint*, ubyte**, int*, int*);

	int rebindKeysym(Display*, KeySym, KeySym*, int, const(ubyte)*, int);

	int recolorCursor(Display*, Cursor, XColor*, XColor*);

	int refreshKeyboardMapping(XMappingEvent*);

	int removeFromSaveSet(Display*, Window);

	int removeHost(Display*, XHostAddress*);

	int removeHosts(Display*, XHostAddress*, int);

	int reparentWindow(Display*, Window, Window, int, int);

	int resetScreenSaver(Display*);

	int resizeWindow(Display*, Window, uint, uint);

	int restackWindows(Display*, Window*, int);

	int rotateBuffers(Display*, int);

	int rotateWindowProperties(Display*, Window, Atom*, int, int);

	int screenCount(Display*);

	int selectInput(Display*, Window, c_long);

	int sendEvent(Display*, Window, int, c_long, XEvent*);

	int setAccessControl(Display*, int);

	int setArcMode(Display*, GC, int);

	int setBackground(Display*, GC, c_ulong);

	int setClipMask(Display*, GC, Pixmap);

	int setClipOrigin(Display*, GC, int, int);

	int setClipRectangles(Display*, GC, int, int, XRectangle*, int, int);

	int setCloseDownMode(Display*, int);

	int setCommand(Display*, Window, char**, int);

	int setDashes(Display*, GC, int, const(char)*, int);

	int setFillRule(Display*, GC, int);

	int setFillStyle(Display*, GC, int);

	int setFont(Display*, GC, Font);

	int setFontPath(Display*, char**, int);

	int setForeground(Display*, GC, c_ulong);

	int setFunction(Display*, GC, int);

	int setGraphicsExposures(Display*, GC, int);

	int setIconName(Display*, Window, const(char)*);

	int setInputFocus(Display*, Window, int, Time);

	int setLineAttributes(Display*, GC, uint, int, int, int);

	int setModifierMapping(Display*, XModifierKeymap*);

	int setPlaneMask(Display*, GC, c_ulong);

	int setPointerMapping(Display*, const(ubyte)*, int);

	int setScreenSaver(Display*, int, int, int, int);

	int setSelectionOwner(Display*, Atom, Window, Time);

	int setState(Display*, GC, c_ulong, c_ulong, int, c_ulong);

	int setStipple(Display*, GC, Pixmap);

	int setSubwindowMode(Display*, GC, int);

	int setTSOrigin(Display*, GC, int, int);

	int setTile(Display*, GC, Pixmap);

	int setWindowBackground(Display*, Window, c_ulong);

	int setWindowBackgroundPixmap(Display*, Window, Pixmap);

	int setWindowBorder(Display*, Window, c_ulong);

	int setWindowBorderPixmap(Display*, Window, Pixmap);

	int setWindowBorderWidth(Display*, Window, uint);

	int setWindowColormap(Display*, Window, Colormap);

	int storeBuffer(Display*, const(char)*, int, int);

	int storeBytes(Display*, const(char)*, int);

	int storeColor(Display*, Colormap, XColor*);

	int storeColors(Display*, Colormap, XColor*, int);

	int storeName(Display*, Window, const(char)*);

	int storeNamedColor(Display*, Colormap, const(char)*, c_ulong, int);

	int sync(Display*, int);

	int textExtents(XFontStruct*, const(char)*, int, int*, int*, int*, XCharStruct*);

	int textExtents16(XFontStruct*, const(XChar2b)*, int, int*, int*, int*, XCharStruct*);

	int textWidth(XFontStruct*, const(char)*, int);

	int textWidth16(XFontStruct*, const(XChar2b)*, int);

	int translateCoordinates(Display*, Window, Window, int, int, int*, int*, Window*);

	int undefineCursor(Display*, Window);

	int ungrabButton(Display*, uint, uint, Window);

	int ungrabKey(Display*, int, uint, Window);

	int ungrabKeyboard(Display*, Time);

	int ungrabPointer(Display*, Time);

	int ungrabServer(Display*);

	int uninstallColormap(Display*, Colormap);

	int unloadFont(Display*, Font);

	int unmapSubwindows(Display*, Window);

	int unmapWindow(Display*, Window);

	int vendorRelease(Display*);

	int warpPointer(Display*, Window, Window, int, int, uint, uint, int, int);

	int widthMMOfScreen(Screen*);

	int widthOfScreen(Screen*);

	int windowEvent(Display*, Window, c_long, XEvent*);

	int writeBitmapFile(Display*, const(char)*, Pixmap, uint, uint, int, int);

	int supportsLocale();

	char* setLocaleModifiers(const(char)*);

	XOM openOM(Display*, PrivateXrmHashBucketRec*, const(char)*, const(char)*);

	int closeOM(XOM);

	// char* setOMValues(XOM, ...);

	// char* getOMValues(XOM, ...);

	Display* displayOfOM(XOM);

	char* localeOfOM(XOM);

	// XOC createOC(XOM, ...);

	void destroyOC(XOC);

	@BindingName("XOMOfOC")
	XOM omOfOC(XOC);

	// char* setOCValues(XOC, ...);

	// char* getOCValues(XOC, ...);

	XFontSet createFontSet(Display*, const(char)*, char***, int*, char**);

	void freeFontSet(Display*, XFontSet);

	int fontsOfFontSet(XFontSet, XFontStruct***, char***);

	char* baseFontNameListOfFontSet(XFontSet);

	char* localeOfFontSet(XFontSet);

	int contextDependentDrawing(XFontSet);

	int directionalDependentDrawing(XFontSet);

	int contextualDrawing(XFontSet);

	XFontSetExtents* extentsOfFontSet(XFontSet);

	@BindingName("XmbTextEscapement")
	int mbTextEscapement(XFontSet, const(char)*, int);

	@BindingName("XwcTextEscapement")
	int wcTextEscapement(XFontSet, const(wchar_t)*, int);

	@BindingName("Xutf8TextEscapement")
	int utf8TextEscapement(XFontSet, const(char)*, int);

	@BindingName("XmbTextExtents")
	int mbTextExtents(XFontSet, const(char)*, int, XRectangle*, XRectangle*);

	@BindingName("XwcTextExtents")
	int wcTextExtents(XFontSet, const(wchar_t)*, int, XRectangle*, XRectangle*);

	@BindingName("Xutf8TextExtents")
	int utf8TextExtents(XFontSet, const(char)*, int, XRectangle*, XRectangle*);

	@BindingName("XmbTextPerCharExtents")
	int mbTextPerCharExtents(XFontSet, const(char)*, int, XRectangle*,
			XRectangle*, int, int*, XRectangle*, XRectangle*);

	@BindingName("XwcTextPerCharExtents")
	int wcTextPerCharExtents(XFontSet, const(wchar_t)*, int, XRectangle*,
			XRectangle*, int, int*, XRectangle*, XRectangle*);

	@BindingName("Xutf8TextPerCharExtents")
	int utf8TextPerCharExtents(XFontSet, const(char)*, int, XRectangle*,
			XRectangle*, int, int*, XRectangle*, XRectangle*);

	@BindingName("XmbDrawText")
	void mbDrawText(Display*, Drawable, GC, int, int, XmbTextItem*, int);

	@BindingName("XwcDrawText")
	void wcDrawText(Display*, Drawable, GC, int, int, XwcTextItem*, int);

	@BindingName("Xutf8DrawText")
	void utf8DrawText(Display*, Drawable, GC, int, int, XmbTextItem*, int);

	@BindingName("XmbDrawString")
	void mbDrawString(Display*, Drawable, XFontSet, GC, int, int, const(char)*, int);

	@BindingName("XwcDrawString")
	void wcDrawString(Display*, Drawable, XFontSet, GC, int, int, const(wchar_t)*, int);

	@BindingName("Xutf8DrawString")
	void utf8DrawString(Display*, Drawable, XFontSet, GC, int, int, const(char)*, int);

	@BindingName("XmbDrawImageString")
	void mbDrawImageString(Display*, Drawable, XFontSet, GC, int, int, const(char)*, int);

	@BindingName("XwcDrawImageString")
	void wcDrawImageString(Display*, Drawable, XFontSet, GC, int, int, const(wchar_t)*, int);

	@BindingName("Xutf8DrawImageString")
	void utf8DrawImageString(Display*, Drawable, XFontSet, GC, int, int, const(char)*, int);

	XIM openIM(Display*, PrivateXrmHashBucketRec*, char*, char*);

	int closeIM(XIM);

	char* function(XIM, ...) getIMValues();

	char* function(XIM, ...) setIMValues();

	Display* displayOfIM(XIM);

	char* localeOfIM(XIM);

	XIC function(XIM, ...) createIC();

	void destroyIC(XIC);

	void setICFocus(XIC);

	void unsetICFocus(XIC);

	wchar_t* wcResetIC(XIC);

	@BindingName("XmbResetIC")
	char* mbResetIC(XIC);

	@BindingName("Xutf8ResetIC")
	char* utf8ResetIC(XIC);

	char* function(XIC, ...) setICValues();

	char* function(XIC, ...) getICValues();

	@BindingName("XIMOfIC")
	XIM imOfIC(XIC);

	int filterEvent(XEvent*, Window);

	@BindingName("XmbLookupString")
	int mbLookupString(XIC, XKeyPressedEvent*, char*, int, KeySym*, int*);

	@BindingName("XwcLookupString")
	int wcLookupString(XIC, XKeyPressedEvent*, wchar_t*, int, KeySym*, int*);

	@BindingName("Xutf8LookupString")
	int utf8LookupString(XIC, XKeyPressedEvent*, char*, int, KeySym*, int*);

	XVaNestedList function(int, ...) vaCreateNestedList();

	int registerIMInstantiateCallback(Display*, PrivateXrmHashBucketRec*,
			char*, char*, XIDProc, XPointer);

	int unregisterIMInstantiateCallback(Display*, PrivateXrmHashBucketRec*,
			char*, char*, XIDProc, XPointer);

	alias XConnectionWatchProc = void function(Display*, XPointer, int, int, XPointer*);

	int internalConnectionNumbers(Display*, int**, int*);

	void processInternalConnection(Display*, int);

	int addConnectionWatch(Display*, XConnectionWatchProc, XPointer);

	void removeConnectionWatch(Display*, XConnectionWatchProc, XPointer);

	void setAuthorization(char*, int, char*, int);

	int getEventData(Display*, XGenericEventCookie*);

	void freeEventData(Display*, XGenericEventCookie*);
	enum X_HAVE_UTF8_STRING = 1;
	alias Bool = int;
	alias Status = int;
	enum True = 1;
	enum False = 0;
	enum QueuedAlready = 0;
	enum QueuedAfterReading = 1;
	enum QueuedAfterFlush = 2;

	static extern (D) auto connectionNumber(T)(auto ref T dpy) {
		return (cast(PrivateXPrivDisplay) dpy).fd;
	}

	static extern (D) auto rootWindow(T0, T1)(auto ref T0 dpy, auto ref T1 scr) {
		return screenOfDisplay(dpy, scr).root;
	}

	static extern (D) auto defaultScreen(T)(auto ref T dpy) {
		return (cast(PrivateXPrivDisplay) dpy).default_screen;
	}

	static extern (D) auto defaultRootWindow(T)(auto ref T dpy) {
		return screenOfDisplay(dpy, defaultScreen(dpy)).root;
	}

	static extern (D) auto defaultVisual(T0, T1)(auto ref T0 dpy, auto ref T1 scr) {
		return screenOfDisplay(dpy, scr).root_visual;
	}

	static extern (D) auto defaultGC(T0, T1)(auto ref T0 dpy, auto ref T1 scr) {
		return screenOfDisplay(dpy, scr).default_gc;
	}

	static extern (D) auto blackPixel(T0, T1)(auto ref T0 dpy, auto ref T1 scr) {
		return screenOfDisplay(dpy, scr).black_pixel;
	}

	static extern (D) auto whitePixel(T0, T1)(auto ref T0 dpy, auto ref T1 scr) {
		return screenOfDisplay(dpy, scr).white_pixel;
	}

	enum AllPlanes = cast(c_ulong)~0L;

	static extern (D) auto qLength(T)(auto ref T dpy) {
		return (cast(PrivateXPrivDisplay) dpy).qlen;
	}

	static extern (D) auto displayWidth(T0, T1)(auto ref T0 dpy, auto ref T1 scr) {
		return screenOfDisplay(dpy, scr).width;
	}

	static extern (D) auto displayHeight(T0, T1)(auto ref T0 dpy, auto ref T1 scr) {
		return screenOfDisplay(dpy, scr).height;
	}

	static extern (D) auto displayWidthMM(T0, T1)(auto ref T0 dpy, auto ref T1 scr) {
		return screenOfDisplay(dpy, scr).mwidth;
	}

	static extern (D) auto displayHeightMM(T0, T1)(auto ref T0 dpy, auto ref T1 scr) {
		return screenOfDisplay(dpy, scr).mheight;
	}

	static extern (D) auto displayPlanes(T0, T1)(auto ref T0 dpy, auto ref T1 scr) {
		return screenOfDisplay(dpy, scr).root_depth;
	}

	static extern (D) auto displayCells(T0, T1)(auto ref T0 dpy, auto ref T1 scr) {
		return defaultVisual(dpy, scr).map_entries;
	}

	static extern (D) auto screenCount(T)(auto ref T dpy) {
		return (cast(PrivateXPrivDisplay) dpy).nscreens;
	}

	static extern (D) auto serverVendor(T)(auto ref T dpy) {
		return (cast(PrivateXPrivDisplay) dpy).vendor;
	}

	static extern (D) auto protocolVersion(T)(auto ref T dpy) {
		return (cast(PrivateXPrivDisplay) dpy).proto_major_version;
	}

	static extern (D) auto protocolRevision(T)(auto ref T dpy) {
		return (cast(PrivateXPrivDisplay) dpy).proto_minor_version;
	}

	static extern (D) auto vendorRelease(T)(auto ref T dpy) {
		return (cast(PrivateXPrivDisplay) dpy).release;
	}

	static extern (D) auto displayString(T)(auto ref T dpy) {
		return (cast(PrivateXPrivDisplay) dpy).display_name;
	}

	static extern (D) auto defaultDepth(T0, T1)(auto ref T0 dpy, auto ref T1 scr) {
		return screenOfDisplay(dpy, scr).root_depth;
	}

	static extern (D) auto defaultColormap(T0, T1)(auto ref T0 dpy, auto ref T1 scr) {
		return screenOfDisplay(dpy, scr).cmap;
	}

	static extern (D) auto bitmapUnit(T)(auto ref T dpy) {
		return (cast(PrivateXPrivDisplay) dpy).bitmap_unit;
	}

	static extern (D) auto bitmapBitOrder(T)(auto ref T dpy) {
		return (cast(PrivateXPrivDisplay) dpy).bitmap_bit_order;
	}

	static extern (D) auto bitmapPad(T)(auto ref T dpy) {
		return (cast(PrivateXPrivDisplay) dpy).bitmap_pad;
	}

	static extern (D) auto imageByteOrder(T)(auto ref T dpy) {
		return (cast(PrivateXPrivDisplay) dpy).byte_order;
	}

	static extern (D) auto nextRequest(T)(auto ref T dpy) {
		return (cast(PrivateXPrivDisplay) dpy).request + 1;
	}

	static extern (D) auto lastKnownRequestProcessed(T)(auto ref T dpy) {
		return (cast(PrivateXPrivDisplay) dpy).last_request_read;
	}

	static extern (D) auto screenOfDisplay(T0, T1)(auto ref T0 dpy, auto ref T1 scr) {
		return &(cast(PrivateXPrivDisplay) dpy).screens[scr];
	}

	static extern (D) auto defaultScreenOfDisplay(T)(auto ref T dpy) {
		return screenOfDisplay(dpy, defaultScreen(dpy));
	}

	static extern (D) auto displayOfScreen(T)(auto ref T s) {
		return s.display;
	}

	static extern (D) auto rootWindowOfScreen(T)(auto ref T s) {
		return s.root;
	}

	static extern (D) auto blackPixelOfScreen(T)(auto ref T s) {
		return s.black_pixel;
	}

	static extern (D) auto whitePixelOfScreen(T)(auto ref T s) {
		return s.white_pixel;
	}

	static extern (D) auto defaultColormapOfScreen(T)(auto ref T s) {
		return s.cmap;
	}

	static extern (D) auto defaultDepthOfScreen(T)(auto ref T s) {
		return s.root_depth;
	}

	static extern (D) auto defaultGCOfScreen(T)(auto ref T s) {
		return s.default_gc;
	}

	static extern (D) auto defaultVisualOfScreen(T)(auto ref T s) {
		return s.root_visual;
	}

	static extern (D) auto widthOfScreen(T)(auto ref T s) {
		return s.width;
	}

	static extern (D) auto heightOfScreen(T)(auto ref T s) {
		return s.height;
	}

	static extern (D) auto widthMMOfScreen(T)(auto ref T s) {
		return s.mwidth;
	}

	static extern (D) auto heightMMOfScreen(T)(auto ref T s) {
		return s.mheight;
	}

	static extern (D) auto planesOfScreen(T)(auto ref T s) {
		return s.root_depth;
	}

	static extern (D) auto cellsOfScreen(T)(auto ref T s) {
		return defaultVisualOfScreen(s).map_entries;
	}

	static extern (D) auto minCmapsOfScreen(T)(auto ref T s) {
		return s.min_maps;
	}

	static extern (D) auto maxCmapsOfScreen(T)(auto ref T s) {
		return s.max_maps;
	}

	static extern (D) auto doesSaveUnders(T)(auto ref T s) {
		return s.save_unders;
	}

	static extern (D) auto doesBackingStore(T)(auto ref T s) {
		return s.backing_store;
	}

	static extern (D) auto eventMaskOfScreen(T)(auto ref T s) {
		return s.root_input_mask;
	}

	static extern (D) auto allocID(T)(auto ref T dpy) {
		return (*(cast(PrivateXPrivDisplay) dpy).resource_alloc)(dpy);
	}

	enum XNRequiredCharSet = "requiredCharSet";
	enum XNQueryOrientation = "queryOrientation";
	enum XNBaseFontName = "baseFontName";
	enum XNOMAutomatic = "omAutomatic";
	enum XNMissingCharSet = "missingCharSet";
	enum XNDefaultString = "defaultString";
	enum XNOrientation = "orientation";
	enum XNDirectionalDependentDrawing = "directionalDependentDrawing";
	enum XNContextualDrawing = "contextualDrawing";
	enum XNFontInfo = "fontInfo";
	enum XIMPreeditArea = 0x0001L;
	enum XIMPreeditCallbacks = 0x0002L;
	enum XIMPreeditPosition = 0x0004L;
	enum XIMPreeditNothing = 0x0008L;
	enum XIMPreeditNone = 0x0010L;
	enum XIMStatusArea = 0x0100L;
	enum XIMStatusCallbacks = 0x0200L;
	enum XIMStatusNothing = 0x0400L;
	enum XIMStatusNone = 0x0800L;
	enum XNVaNestedList = "XNVaNestedList";
	enum XNQueryInputStyle = "queryInputStyle";
	enum XNClientWindow = "clientWindow";
	enum XNInputStyle = "inputStyle";
	enum XNFocusWindow = "focusWindow";
	enum XNResourceName = "resourceName";
	enum XNResourceClass = "resourceClass";
	enum XNGeometryCallback = "geometryCallback";
	enum XNDestroyCallback = "destroyCallback";
	enum XNFilterEvents = "filterEvents";
	enum XNPreeditStartCallback = "preeditStartCallback";
	enum XNPreeditDoneCallback = "preeditDoneCallback";
	enum XNPreeditDrawCallback = "preeditDrawCallback";
	enum XNPreeditCaretCallback = "preeditCaretCallback";
	enum XNPreeditStateNotifyCallback = "preeditStateNotifyCallback";
	enum XNPreeditAttributes = "preeditAttributes";
	enum XNStatusStartCallback = "statusStartCallback";
	enum XNStatusDoneCallback = "statusDoneCallback";
	enum XNStatusDrawCallback = "statusDrawCallback";
	enum XNStatusAttributes = "statusAttributes";
	enum XNArea = "area";
	enum XNAreaNeeded = "areaNeeded";
	enum XNSpotLocation = "spotLocation";
	enum XNColormap = "colorMap";
	enum XNStdColormap = "stdColorMap";
	enum XNForeground = "foreground";
	enum XNBackground = "background";
	enum XNBackgroundPixmap = "backgroundPixmap";
	enum XNFontSet = "fontSet";
	enum XNLineSpace = "lineSpace";
	enum XNCursor = "cursor";
	enum XNQueryIMValuesList = "queryIMValuesList";
	enum XNQueryICValuesList = "queryICValuesList";
	enum XNVisiblePosition = "visiblePosition";
	enum XNR6PreeditCallback = "r6PreeditCallback";
	enum XNStringConversionCallback = "stringConversionCallback";
	enum XNStringConversion = "stringConversion";
	enum XNResetState = "resetState";
	enum XNHotKey = "hotKey";
	enum XNHotKeyState = "hotKeyState";
	enum XNPreeditState = "preeditState";
	enum XNSeparatorofNestedList = "separatorofNestedList";
	enum XBufferOverflow = -1;
	enum XLookupNone = 1;
	enum XLookupChars = 2;
	enum XLookupKeySym = 3;
	enum XLookupBoth = 4;
	enum XIMReverse = 1L;
	enum XIMUnderline = 1L << 1;
	enum XIMHighlight = 1L << 2;
	enum XIMPrimary = 1L << 5;
	enum XIMSecondary = 1L << 6;
	enum XIMTertiary = 1L << 7;
	enum XIMVisibleToForward = 1L << 8;
	enum XIMVisibleToBackword = 1L << 9;
	enum XIMVisibleToCenter = 1L << 10;
	enum XIMPreeditUnKnown = 0L;
	enum XIMPreeditEnable = 1L;
	enum XIMPreeditDisable = 1L << 1;
	enum XIMInitialState = 1L;
	enum XIMPreserveState = 1L << 1;
	enum XIMStringConversionLeftEdge = 0x00000001;
	enum XIMStringConversionRightEdge = 0x00000002;
	enum XIMStringConversionTopEdge = 0x00000004;
	enum XIMStringConversionBottomEdge = 0x00000008;
	enum XIMStringConversionConcealed = 0x00000010;
	enum XIMStringConversionWrapped = 0x00000020;
	enum XIMStringConversionBuffer = 0x0001;
	enum XIMStringConversionLine = 0x0002;
	enum XIMStringConversionWord = 0x0003;
	enum XIMStringConversionChar = 0x0004;
	enum XIMStringConversionSubstitution = 0x0001;
	enum XIMStringConversionRetrieval = 0x0002;
	enum XIMHotKeyStateON = 0x0001L;
	enum XIMHotKeyStateOFF = 0x0002L;
}
