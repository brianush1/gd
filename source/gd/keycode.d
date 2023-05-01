module gd.keycode;

struct KeyBinding {
	Modifiers mods;
	string key;

	this(KeyBindings standardBinding) {
	}

	string toString() const @safe pure nothrow {
		return key;
	}
}

enum KeyBindings {

	// Tab: ====================================================

	/++ Open a new tab.
	- Common key binding: Ctrl+T
	- Qt equivalent: QKeySequence::AddTab
	+/
	NewTab,

	/++ Close the current tab.
	- Common key binding: Ctrl+W
	- Qt equivalent: QKeySequence::Close
	+/
	CloseTab,

	/++ Switch to the previous tab.
	- Common key binding: Ctrl+Shift+Tab
	- Qt equivalent: QKeySequence::PreviousChild
	+/
	PreviousTab,

	/++ Switch to the next tab.
	- Common key binding: Ctrl+Tab
	- Qt equivalent: QKeySequence::NextChild
	+/
	NextTab,

	// Navigation: =============================================

	/++ Go back (e.g. back button in a web browser).
	- Common key binding: Alt+Left
	- Qt equivalent: QKeySequence::Back
	+/
	Back,

	/++ Go forward (e.g. forward button in a web browser).
	- Common key binding: Alt+Right
	- Qt equivalent: QKeySequence::Forward
	+/
	Forward,

	/++ Refresh the state of the application.
	- Common key binding: F5, Ctrl+R
	- Qt equivalent: QKeySequence::Refresh
	+/
	Refresh,

	// File: ===================================================

	/++ Create a new document.
	- Common key binding: Ctrl+N
	- Qt equivalent: QKeySequence::New
	+/
	New,

	/++ Open an existing document.
	- Common key binding: Ctrl+O
	- Qt equivalent: QKeySequence::Open
	+/
	Open,

	/++ Save the current document.
	- Common key binding: Ctrl+O
	- Qt equivalent: QKeySequence::Save
	+/
	Save,

	/++ Prompt the user for a file location and save the current document.
	- Common key binding: Ctrl+Shift+S
	- Qt equivalent: QKeySequence::SaveAs
	+/
	SaveAs,

	// Style: ==================================================

	/++ Toggle bold text style.
	- Common key binding: Ctrl+B
	- Qt equivalent: QKeySequence::Bold
	+/
	Bold,

	/++ Toggle italic text style.
	- Common key binding: Ctrl+I
	- Qt equivalent: QKeySequence::Italic
	+/
	Italic,

	/++ Toggle underlined text style.
	- Common key binding: Ctrl+U
	- Qt equivalent: QKeySequence::Underline
	+/
	Underline,

	// History: ================================================

	/++ Undo the last operation.
	- Common key binding: Ctrl+Z
	- Qt equivalent: QKeySequence::Undo
	+/
	Undo,

	/++ Redo the last undone operation.
	- Common key binding: Ctrl+Y (Windows), Ctrl+Shift+Z
	- Qt equivalent: QKeySequence::Redo
	+/
	Redo,

	// Clipboard: ==============================================

	/++ Copy the selection to the clipboard.
	- Common key binding: Ctrl+C
	- Qt equivalent: QKeySequence::Copy
	+/
	Copy,

	/++ Copy to the clipboard and delete the selection.
	- Common key binding: Ctrl+X
	- Qt equivalent: QKeySequence::Cut
	+/
	Cut,

	/++ Paste from the clipboard.
	- Common key binding: Ctrl+V
	- Qt equivalent: QKeySequence::Paste
	+/
	Paste,

	// Text Navigation and Manipulation: =======================

	/++ Go to a specific location in the document.
	- Common key binding: Ctrl+G
	- Qt equivalent: none
	+/
	GoTo,

	/++ Go to a specific location in the document.
	- Common key binding: Ctrl+F
	- Qt equivalent: QtKeySequence::Find
	+/
	Find,

	/++ Go to the next occurrence of the content in the find dialog.
	- Common key binding: F3
	- Qt equivalent: QtKeySequence::FindNext
	+/
	FindNext,

	/++ Go to the next occurrence of the content in the find dialog.
	- Common key binding: Shift+F3
	- Qt equivalent: QtKeySequence::FindPrevious
	+/
	FindPrevious,

	/++ Replace occurrences of a particular string in the document.
	- Common key binding: Ctrl+H
	- Qt equivalent: QtKeySequence::Replace
	+/
	Replace,

	/++ Select the whole text.
	- Common key binding: Ctrl+A
	- Qt equivalent: QtKeySequence::SelectAll
	+/
	SelectAll,

	// Miscellaneous: ==========================================

	/++ Print the document.
	- Common key binding: Ctrl+P
	- Qt equivalent: QtKeySequence::Print
	+/
	Print,

	/++ Quit the application.
	- Common key binding: Ctrl+Q
	- Qt equivalent: QtKeySequence::Quit
	+/
	Quit,

	/++ Show help for using the application.
	- Common key binding: F1
	- Qt equivalent: QtKeySequence::HelpContents
	+/
	Help,

	/++ Quit the application.
	- Common key binding: Ctrl+Plus
	- Qt equivalent: QtKeySequence::Quit
	+/
	ZoomIn,

	/++ Show help for using the application.
	- Common key binding: Ctrl+Minus
	- Qt equivalent: QtKeySequence::HelpContents
	+/
	ZoomOut,

}

enum GamepadButton : uint {
	A, B, X, Y,
	LB, RB,
	Start,
	DpadLeft,
	DpadRight,
	DpadUp,
	DpadDown,
}

enum MouseButton : uint {
	Unknown = 0,

	Left = 0x1000,
	Right,
	Middle,
	X1,
	X2,
}

enum Modifiers : uint {
	None       = 0b0000_0000,
	Ctrl       = 0b0000_0001,
	Shift      = 0b0000_0010,
	Alt        = 0b0000_0100,
	Super      = 0b0000_1000,
	AltGr      = 0b0001_0000,
	NumLock    = 0b0010_0000,
	ScrollLock = 0b0100_0000,
	CapsLock   = 0b1000_0000,
}

enum KeyCode : uint {
	Unknown = 0,

	// function keys:
	F1 = 0x1000, F2, F3, F4, F5, F6, F7, F8, F9, F10, F11, F12,
	F13, F14, F15, F16, F17, F18, F19, F20,

	// digits and alphabet:
	D0 = 0x2000, D1, D2, D3, D4, D5, D6, D7, D8, D9,
	A, B, C, D, E, F, G, H, I, J, K, L, M,
	N, O, P, Q, R, S, T, U, V, W, X, Y, Z,

	RightParenthesis = 0x2800,
	Exclamation,
	At,
	Hash,
	Dollar,
	Percent,
	Caret,
	Ampersand,
	Asterisk,
	LeftParenthesis,

	// locks:
	NumLock = 0x3000,
	CapsLock,
	ScrollLock,

	// non-printable keys:
	Escape = 0x4000,
	PrintScreen,
	Insert,
	Delete,
	Home,
	End,
	PageUp,
	PageDown,
	Backspace,
	Enter,
	Tab,
	Left,
	Right,
	Up,
	Down,

	// modifier keys:
	LeftShift = 0x5000, RightShift,
	LeftCtrl, RightCtrl,
	LeftAlt, RightAlt,
	LeftSuper, RightSuper,
	LeftHyper, RightHyper,
	LeftMeta, RightMeta,

	// miscellaneous printable keys:
	Backtick = 0x6000,
	Minus,
	Equals,
	LeftSquareBracket,
	RightSquareBracket,
	Backslash,
	Semicolon,
	Apostrophe,
	Comma,
	Period,
	Slash,
	Space,

	Tilde = 0x6800,
	Underscore,
	Plus,
	LeftBrace,
	RightBrace,
	Bar,
	Colon,
	Quote,
	LesserSign,
	GreaterSign,
	QuestionMark,

	// miscellaneous non-printable keys:
	ContextMenu = 0x7000,
	Macro,
	Compose,
	Pause,
	DeadGreek,

	// keypad:
	Kp0 = 0x8000,
	Kp1, Kp2, Kp3,
	Kp4, Kp5, Kp6,
	Kp7, Kp8, Kp9,
	KpDivide,
	KpMultiply,
	KpMinus,
	KpPlus,
	KpPeriod,
	KpEnter,

	KpInsert = 0x8800,
	KpEnd,
	KpDown,
	KpPageDown,
	KpLeft,
	KpBegin, // ???
	KpRight,
	KpHome,
	KpUp,
	KpPageUp,
	KpDelete,
}
