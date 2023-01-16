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
	newTab,

	/++ Close the current tab.
	- Common key binding: Ctrl+W
	- Qt equivalent: QKeySequence::Close
	+/
	closeTab,

	/++ Switch to the previous tab.
	- Common key binding: Ctrl+Shift+Tab
	- Qt equivalent: QKeySequence::PreviousChild
	+/
	previousTab,

	/++ Switch to the next tab.
	- Common key binding: Ctrl+Tab
	- Qt equivalent: QKeySequence::NextChild
	+/
	nextTab,

	// Navigation: =============================================

	/++ Go back (e.g. back button in a web browser).
	- Common key binding: Alt+Left
	- Qt equivalent: QKeySequence::Back
	+/
	back,

	/++ Go forward (e.g. forward button in a web browser).
	- Common key binding: Alt+Right
	- Qt equivalent: QKeySequence::Forward
	+/
	forward,

	/++ Refresh the state of the application.
	- Common key binding: F5, Ctrl+R
	- Qt equivalent: QKeySequence::Refresh
	+/
	refresh,

	// File: ===================================================

	/++ Create a new document.
	- Common key binding: Ctrl+N
	- Qt equivalent: QKeySequence::New
	+/
	new_,

	/++ Open an existing document.
	- Common key binding: Ctrl+O
	- Qt equivalent: QKeySequence::Open
	+/
	open,

	/++ Save the current document.
	- Common key binding: Ctrl+O
	- Qt equivalent: QKeySequence::Save
	+/
	save,

	/++ Prompt the user for a file location and save the current document.
	- Common key binding: Ctrl+Shift+S
	- Qt equivalent: QKeySequence::SaveAs
	+/
	saveAs,

	// Style: ==================================================

	/++ Toggle bold text style.
	- Common key binding: Ctrl+B
	- Qt equivalent: QKeySequence::Bold
	+/
	bold,

	/++ Toggle italic text style.
	- Common key binding: Ctrl+I
	- Qt equivalent: QKeySequence::Italic
	+/
	italic,

	/++ Toggle underlined text style.
	- Common key binding: Ctrl+U
	- Qt equivalent: QKeySequence::Underline
	+/
	underline,

	// History: ================================================

	/++ Undo the last operation.
	- Common key binding: Ctrl+Z
	- Qt equivalent: QKeySequence::Undo
	+/
	undo,

	/++ Redo the last undone operation.
	- Common key binding: Ctrl+Y (Windows), Ctrl+Shift+Z
	- Qt equivalent: QKeySequence::Redo
	+/
	redo,

	// Clipboard: ==============================================

	/++ Copy the selection to the clipboard.
	- Common key binding: Ctrl+C
	- Qt equivalent: QKeySequence::Copy
	+/
	copy,

	/++ Copy to the clipboard and delete the selection.
	- Common key binding: Ctrl+X
	- Qt equivalent: QKeySequence::Cut
	+/
	cut,

	/++ Paste from the clipboard.
	- Common key binding: Ctrl+V
	- Qt equivalent: QKeySequence::Paste
	+/
	paste,

	// Text Navigation and Manipulation: =======================

	/++ Go to a specific location in the document.
	- Common key binding: Ctrl+G
	- Qt equivalent: none
	+/
	goTo,

	/++ Go to a specific location in the document.
	- Common key binding: Ctrl+F
	- Qt equivalent: QtKeySequence::Find
	+/
	find,

	/++ Go to the next occurrence of the content in the find dialog.
	- Common key binding: F3
	- Qt equivalent: QtKeySequence::FindNext
	+/
	findNext,

	/++ Go to the next occurrence of the content in the find dialog.
	- Common key binding: Shift+F3
	- Qt equivalent: QtKeySequence::FindPrevious
	+/
	findPrevious,

	/++ Replace occurrences of a particular string in the document.
	- Common key binding: Ctrl+H
	- Qt equivalent: QtKeySequence::Replace
	+/
	replace,

	/++ Select the whole text.
	- Common key binding: Ctrl+A
	- Qt equivalent: QtKeySequence::SelectAll
	+/
	selectAll,

	// Miscellaneous: ==========================================

	/++ Print the document.
	- Common key binding: Ctrl+P
	- Qt equivalent: QtKeySequence::Print
	+/
	print,

	/++ Quit the application.
	- Common key binding: Ctrl+Q
	- Qt equivalent: QtKeySequence::Quit
	+/
	quit,

	/++ Show help for using the application.
	- Common key binding: F1
	- Qt equivalent: QtKeySequence::HelpContents
	+/
	help,

	/++ Quit the application.
	- Common key binding: Ctrl+Plus
	- Qt equivalent: QtKeySequence::Quit
	+/
	zoomIn,

	/++ Show help for using the application.
	- Common key binding: Ctrl+Minus
	- Qt equivalent: QtKeySequence::HelpContents
	+/
	zoomOut,

}

enum GamepadButton : uint {
	a, b, x, y,
	lb, rb,
	start,
	dpadLeft,
	dpadRight,
	dpadUp,
	dpadDown,
}

enum MouseButton : uint {
	unknown = 0,

	left = 0x1000,
	right,
	middle,
	x1,
	x2,
}

enum Modifiers : uint {
	ctrl       = 0b0000_0001,
	shift      = 0b0000_0010,
	alt        = 0b0000_0100,
	super_     = 0b0000_1000,
	altGr      = 0b0001_0000,
	numLock    = 0b0010_0000,
	scrollLock = 0b0100_0000,
	capsLock   = 0b1000_0000,
}

enum KeyCode : uint {
	unknown = 0,

	// function keys:
	f1 = 0x1000, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12,
	f13, f14, f15, f16, f17, f18, f19, f20,

	// digits and alphabet:
	d0 = 0x2000, d1, d2, d3, d4, d5, d6, d7, d8, d9,
	a, b, c, d, e, f, g, h, i, j, k, l, m,
	n, o, p, q, r, s, t, u, v, w, x, y, z,

	rightParenthesis = 0x2800,
	exclamation,
	at,
	hash,
	dollar,
	percent,
	caret,
	ampersand,
	asterisk,
	leftParenthesis,

	// locks:
	numLock = 0x3000,
	capsLock,
	scrollLock,

	// non-printable keys:
	escape = 0x4000,
	printScreen,
	insert,
	delete_,
	home,
	end,
	pageUp,
	pageDown,
	backspace,
	enter,
	tab,
	left,
	right,
	up,
	down,

	// modifier keys:
	leftShift = 0x5000, rightShift,
	leftCtrl, rightCtrl,
	leftAlt, rightAlt,
	leftSuper, rightSuper,
	leftHyper, rightHyper,
	leftMeta, rightMeta,

	// miscellaneous printable keys:
	backtick = 0x6000,
	minus,
	equals,
	leftSquareBracket,
	rightSquareBracket,
	backslash,
	semicolon,
	apostrophe,
	comma,
	period,
	slash,
	space,

	tilde = 0x6800,
	underscore,
	plus,
	leftBrace,
	rightBrace,
	bar,
	colon,
	quote,
	lesserSign,
	greaterSign,
	questionMark,

	// miscellaneous non-printable keys:
	contextMenu = 0x7000,
	macro_,
	compose,
	pause,
	deadGreek,

	// numpad:
	np0 = 0x8000,
	np1, np2, np3,
	np4, np5, np6,
	np7, np8, np9,
	npDivide,
	npMultiply,
	npMinus,
	npPlus,
	npPeriod,
	npEnter,

	npInsert = 0x8800,
	npEnd,
	npDown,
	npPageDown,
	npLeft,
	npBegin, // ???
	npRight,
	npHome,
	npUp,
	npPageUp,
	npDelete,
}
