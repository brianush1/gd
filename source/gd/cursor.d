module gd.cursor;

/++ A list of semantic cursor shapes. Note that the exact appearance may vary from system to system. +/
enum Cursors {

	/++ The default arrow cursor.

	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Windows/aero_arrow.png)|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Yaru/left_ptr.png)|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Breeze/default.png)|
	)
	+/
	Arrow,

	/++
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Windows/aero_arrow.png)|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Yaru/left_ptr.png)|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Breeze/default.png)|
	)
	+/
	ArrowLeft,

	/++
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|N/A|N/A|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Breeze/center_ptr.png)|
	)
	+/
	ArrowCenter,

	/++

	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Windows/aero_right_arrow.png)|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Yaru/right_ptr.png)|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Breeze/right_ptr.png)|
	)
	+/
	ArrowRight,

	/++
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Windows/cell.png)|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Yaru/plus.png)|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Breeze/cell.png)|
	)
	+/
	Cell,

	/++
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Windows/cross_i.png)|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Yaru/color-picker.png)|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Breeze/color-picker.png)|
	)
	+/
	ColorPicker,

	/++
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Windows/aero_pen.png)|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Yaru/pencil.png)|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Breeze/pencil.png)|
	)
	+/
	Handwriting,

	/++
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|N/A|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Yaru/context-menu.png)|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Breeze/context-menu.png)|
	)
	+/
	ContextMenu,

	/++
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Windows/aero_copy.png)|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Yaru/copy.png)|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Breeze/copy.png)|
	)
	+/
	Copy,

	/++
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Windows/cross_i.png)|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Yaru/crosshair.png)|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Breeze/crosshair.png)|
	)
	+/
	Crosshair,

	/++
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Windows/aero_grab2.png)|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Yaru/hand1.png)|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Breeze/openhand.png)|
	)
	+/
	Grab,

	/++
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Windows/aero_grabbing.png)|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Yaru/grabbing.png)|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Breeze/dnd-move.png)|
	)
	+/
	Grabbing,

	/++
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Windows/aero_link.png)|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Yaru/hand2.png)|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Breeze/pointer.png)|
	)
	+/
	Hand,

	/++
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Windows/aero_helpsel.png)|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Yaru/question_arrow.png)|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Breeze/help.png)|
	)
	+/
	Help,

	/++
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Windows/aero_alias.png)|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Yaru/dnd-link.png)|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Breeze/alias.png)|
	)
	+/
	Link,

	/++
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Windows/aero_move.png)|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Yaru/move.png)|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Breeze/fleur.png)|
	)
	+/
	Move,

	/++
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Windows/aero_unavail.png)|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Yaru/dnd-no-drop.png)|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Breeze/no-drop.png)|
	)
	+/
	NoDrop,

	/++ The cursor is invisible +/
	None,

	/++
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Windows/aero_unavail.png)|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Yaru/crossed_circle.png)|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Breeze/not-allowed.png)|
	)
	+/
	NotAllowed,

	/++
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Windows/aero_move.png)|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Yaru/all-scroll.png)|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Breeze/all-scroll.png)|
	)
	+/
	Pan,

	/++ The program is busy in the background, but the user can still interact with the interface.
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Windows/aero_working.png)|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Yaru/left_ptr_watch.png)|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Breeze/progress.png)|
	)
	+/
	Progress,

	/++
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Windows/splitv.png)|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Yaru/sb_v_double_arrow.png)|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Breeze/row-resize.png)|
	)
	+/
	SplitVertical,

	/++
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Windows/splith.png)|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Yaru/sb_h_double_arrow.png)|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Breeze/col-resize.png)|
	)
	+/
	SplitHorizontal,

	/++
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Windows/sizev.png)|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Yaru/sb_v_double_arrow.png)|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Breeze/row-resize.png)|
	)
	+/
	ResizeRow,

	/++
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Windows/sizeh.png)|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Yaru/sb_h_double_arrow.png)|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Breeze/col-resize.png)|
	)
	+/
	ResizeColumn,

	/++
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Windows/aero_ns.png)|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Yaru/top_side.png)|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Breeze/top_side.png)|
	)
	+/
	ResizeN,

	/++
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Windows/aero_ew.png)|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Yaru/left_side.png)|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Breeze/left_side.png)|
	)
	+/
	ResizeW,

	/++
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Windows/aero_ns.png)|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Yaru/bottom_side.png)|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Breeze/bottom_side.png)|
	)
	+/
	ResizeS,

	/++
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Windows/aero_ew.png)|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Yaru/right_side.png)|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Breeze/right_side.png)|
	)
	+/
	ResizeE,

	/++
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Windows/aero_nesw.png)|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Yaru/top_right_corner.png)|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Breeze/top_right_corner.png)|
	)
	+/
	ResizeNE,

	/++
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Windows/aero_nwse.png)|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Yaru/top_left_corner.png)|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Breeze/top_left_corner.png)|
	)
	+/
	ResizeNW,

	/++
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Windows/aero_nesw.png)|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Yaru/bottom_left_corner.png)|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Breeze/bottom_left_corner.png)|
	)
	+/
	ResizeSW,

	/++
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Windows/aero_nwse.png)|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Yaru/bottom_right_corner.png)|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Breeze/bottom_right_corner.png)|
	)
	+/
	ResizeSE,

	/++
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Windows/aero_ns.png)|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Yaru/sb_v_double_arrow.png)|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Breeze/size_ver.png)|
	)
	+/
	ResizeNS,

	/++
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Windows/aero_ew.png)|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Yaru/sb_h_double_arrow.png)|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Breeze/size_hor.png)|
	)
	+/
	ResizeEW,

	/++
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Windows/aero_nesw.png)|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Yaru/fd_double_arrow.png)|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Breeze/size_bdiag.png)|
	)
	+/
	ResizeNESW,

	/++
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Windows/aero_nwse.png)|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Yaru/bd_double_arrow.png)|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Breeze/size_fdiag.png)|
	)
	+/
	ResizeNWSE,

	/++ Indicates the ability to select text.
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Windows/beam_i.png)|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Yaru/xterm.png)|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Breeze/text.png)|
	)
	+/
	Text,

	/++ Indicates the ability to select vertical text.
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Windows/beam_i_vertical.png)|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Yaru/vertical-text.png)|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Breeze/vertical-text.png)|
	)
	+/
	VerticalText,

	/++ The program is busy and the user cannot interact with the interface.
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Windows/aero_busy.png)|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Yaru/watch.png)|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Breeze/wait.png)|
	)
	+/
	Wait,

	/++ Something can be zoomed in (magnified).
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Windows/aero_zoom-in.png)|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Yaru/zoom-in.png)|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Breeze/zoom-in.png)|
	)
	+/
	ZoomIn,

	/++ Something can be zoomed out (demagnified).
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Windows/aero_zoom-out.png)|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Yaru/zoom-out.png)|![Image](https://raw.githubusercontent.com/brianush1/gd/master/doc-images/cursors/Breeze/zoom-out.png)|
	)
	+/
	ZoomOut,

}

/++ Macros: SMALL_TABLE=$0 +/
