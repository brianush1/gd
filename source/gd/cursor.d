module gd.cursor;

/++ A list of semantic cursor shapes. Note that the exact appearance may vary from system to system. +/
enum Cursors {

	/++ The default arrow cursor.

	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](/user-data/projects/gd-cursor-docs/Windows/aero_arrow.png)|![Image](/user-data/projects/gd-cursor-docs/Yaru/left_ptr.png)|![Image](/user-data/projects/gd-cursor-docs/Breeze/default.png)|
	)
	+/
	Arrow,

	/++
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](/user-data/projects/gd-cursor-docs/Windows/aero_arrow.png)|![Image](/user-data/projects/gd-cursor-docs/Yaru/left_ptr.png)|![Image](/user-data/projects/gd-cursor-docs/Breeze/default.png)|
	)
	+/
	ArrowLeft,

	/++
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|N/A|N/A|![Image](/user-data/projects/gd-cursor-docs/Breeze/center_ptr.png)|
	)
	+/
	ArrowCenter,

	/++

	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](/user-data/projects/gd-cursor-docs/Windows/aero_right_arrow.png)|![Image](/user-data/projects/gd-cursor-docs/Yaru/right_ptr.png)|![Image](/user-data/projects/gd-cursor-docs/Breeze/right_ptr.png)|
	)
	+/
	ArrowRight,

	/++
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](/user-data/projects/gd-cursor-docs/Windows/cell.png)|![Image](/user-data/projects/gd-cursor-docs/Yaru/plus.png)|![Image](/user-data/projects/gd-cursor-docs/Breeze/cell.png)|
	)
	+/
	Cell,

	/++
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|N/A|![Image](/user-data/projects/gd-cursor-docs/Yaru/color-picker.png)|![Image](/user-data/projects/gd-cursor-docs/Breeze/color-picker.png)|
	)
	+/
	ColorPicker,

	/++
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](/user-data/projects/gd-cursor-docs/Windows/aero_pen.png)|N/A|N/A||
	)
	+/
	Pen,

	/++
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|N/A|![Image](/user-data/projects/gd-cursor-docs/Yaru/pencil.png)|![Image](/user-data/projects/gd-cursor-docs/Breeze/pencil.png)|
	)
	+/
	Pencil,

	/++
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|N/A|![Image](/user-data/projects/gd-cursor-docs/Yaru/context-menu.png)|![Image](/user-data/projects/gd-cursor-docs/Breeze/context-menu.png)|
	)
	+/
	ContextMenu,

	/++
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](/user-data/projects/gd-cursor-docs/Windows/aero_copy.png)|![Image](/user-data/projects/gd-cursor-docs/Yaru/copy.png)|![Image](/user-data/projects/gd-cursor-docs/Breeze/copy.png)|
	)
	+/
	Copy,

	/++
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](/user-data/projects/gd-cursor-docs/Windows/cross_i.png)|![Image](/user-data/projects/gd-cursor-docs/Yaru/crosshair.png)|![Image](/user-data/projects/gd-cursor-docs/Breeze/crosshair.png)|
	)
	+/
	Crosshair,

	/++
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](/user-data/projects/gd-cursor-docs/Windows/aero_grab2.png)|![Image](/user-data/projects/gd-cursor-docs/Yaru/hand1.png)|![Image](/user-data/projects/gd-cursor-docs/Breeze/openhand.png)|
	)
	+/
	Grab,

	/++
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](/user-data/projects/gd-cursor-docs/Windows/aero_grabbing.png)|![Image](/user-data/projects/gd-cursor-docs/Yaru/grabbing.png)|![Image](/user-data/projects/gd-cursor-docs/Breeze/dnd-move.png)|
	)
	+/
	Grabbing,

	/++
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](/user-data/projects/gd-cursor-docs/Windows/aero_link.png)|![Image](/user-data/projects/gd-cursor-docs/Yaru/hand2.png)|![Image](/user-data/projects/gd-cursor-docs/Breeze/pointer.png)|
	)
	+/
	Hand,

	/++
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](/user-data/projects/gd-cursor-docs/Windows/aero_helpsel.png)|![Image](/user-data/projects/gd-cursor-docs/Yaru/question_arrow.png)|![Image](/user-data/projects/gd-cursor-docs/Breeze/help.png)|
	)
	+/
	Help,

	/++
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](/user-data/projects/gd-cursor-docs/Windows/aero_alias.png)|![Image](/user-data/projects/gd-cursor-docs/Yaru/dnd-link.png)|![Image](/user-data/projects/gd-cursor-docs/Breeze/alias.png)|
	)
	+/
	Link,

	/++
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](/user-data/projects/gd-cursor-docs/Windows/aero_move.png)|![Image](/user-data/projects/gd-cursor-docs/Yaru/move.png)|![Image](/user-data/projects/gd-cursor-docs/Breeze/fleur.png)|
	)
	+/
	Move,

	/++
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](/user-data/projects/gd-cursor-docs/Windows/aero_unavail.png)|![Image](/user-data/projects/gd-cursor-docs/Yaru/dnd-no-drop.png)|![Image](/user-data/projects/gd-cursor-docs/Breeze/no-drop.png)|
	)
	+/
	NoDrop,

	/++ The cursor is invisible +/
	None,

	/++
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](/user-data/projects/gd-cursor-docs/Windows/aero_unavail.png)|![Image](/user-data/projects/gd-cursor-docs/Yaru/crossed_circle.png)|![Image](/user-data/projects/gd-cursor-docs/Breeze/not-allowed.png)|
	)
	+/
	NotAllowed,

	/++
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](/user-data/projects/gd-cursor-docs/Windows/aero_move.png)|![Image](/user-data/projects/gd-cursor-docs/Yaru/all-scroll.png)|![Image](/user-data/projects/gd-cursor-docs/Breeze/all-scroll.png)|
	)
	+/
	Pan,

	/++ The program is busy in the background, but the user can still interact with the interface.
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](/user-data/projects/gd-cursor-docs/Windows/aero_working.png)|![Image](/user-data/projects/gd-cursor-docs/Yaru/left_ptr_watch.png)|![Image](/user-data/projects/gd-cursor-docs/Breeze/progress.png)|
	)
	+/
	Progress,

	/++
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](/user-data/projects/gd-cursor-docs/Windows/splitv.png)|![Image](/user-data/projects/gd-cursor-docs/Yaru/sb_v_double_arrow.png)|![Image](/user-data/projects/gd-cursor-docs/Breeze/row-resize.png)|
	)
	+/
	SplitVertical,

	/++
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](/user-data/projects/gd-cursor-docs/Windows/splith.png)|![Image](/user-data/projects/gd-cursor-docs/Yaru/sb_h_double_arrow.png)|![Image](/user-data/projects/gd-cursor-docs/Breeze/col-resize.png)|
	)
	+/
	SplitHorizontal,

	/++
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](/user-data/projects/gd-cursor-docs/Windows/sizev.png)|![Image](/user-data/projects/gd-cursor-docs/Yaru/sb_v_double_arrow.png)|![Image](/user-data/projects/gd-cursor-docs/Breeze/row-resize.png)|
	)
	+/
	ResizeRow,

	/++
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](/user-data/projects/gd-cursor-docs/Windows/sizeh.png)|![Image](/user-data/projects/gd-cursor-docs/Yaru/sb_h_double_arrow.png)|![Image](/user-data/projects/gd-cursor-docs/Breeze/col-resize.png)|
	)
	+/
	ResizeColumn,

	/++
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](/user-data/projects/gd-cursor-docs/Windows/aero_ns.png)|![Image](/user-data/projects/gd-cursor-docs/Yaru/top_side.png)|![Image](/user-data/projects/gd-cursor-docs/Breeze/top_side.png)|
	)
	+/
	ResizeN,

	/++
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](/user-data/projects/gd-cursor-docs/Windows/aero_ew.png)|![Image](/user-data/projects/gd-cursor-docs/Yaru/left_side.png)|![Image](/user-data/projects/gd-cursor-docs/Breeze/left_side.png)|
	)
	+/
	ResizeW,

	/++
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](/user-data/projects/gd-cursor-docs/Windows/aero_ns.png)|![Image](/user-data/projects/gd-cursor-docs/Yaru/bottom_side.png)|![Image](/user-data/projects/gd-cursor-docs/Breeze/bottom_side.png)|
	)
	+/
	ResizeS,

	/++
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](/user-data/projects/gd-cursor-docs/Windows/aero_ew.png)|![Image](/user-data/projects/gd-cursor-docs/Yaru/right_side.png)|![Image](/user-data/projects/gd-cursor-docs/Breeze/right_side.png)|
	)
	+/
	ResizeE,

	/++
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](/user-data/projects/gd-cursor-docs/Windows/aero_nesw.png)|![Image](/user-data/projects/gd-cursor-docs/Yaru/top_right_corner.png)|![Image](/user-data/projects/gd-cursor-docs/Breeze/top_right_corner.png)|
	)
	+/
	ResizeNE,

	/++
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](/user-data/projects/gd-cursor-docs/Windows/aero_nwse.png)|![Image](/user-data/projects/gd-cursor-docs/Yaru/top_left_corner.png)|![Image](/user-data/projects/gd-cursor-docs/Breeze/top_left_corner.png)|
	)
	+/
	ResizeNW,

	/++
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](/user-data/projects/gd-cursor-docs/Windows/aero_nesw.png)|![Image](/user-data/projects/gd-cursor-docs/Yaru/bottom_left_corner.png)|![Image](/user-data/projects/gd-cursor-docs/Breeze/bottom_left_corner.png)|
	)
	+/
	ResizeSW,

	/++
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](/user-data/projects/gd-cursor-docs/Windows/aero_nwse.png)|![Image](/user-data/projects/gd-cursor-docs/Yaru/bottom_right_corner.png)|![Image](/user-data/projects/gd-cursor-docs/Breeze/bottom_right_corner.png)|
	)
	+/
	ResizeSE,

	/++
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](/user-data/projects/gd-cursor-docs/Windows/aero_ns.png)|![Image](/user-data/projects/gd-cursor-docs/Yaru/sb_v_double_arrow.png)|![Image](/user-data/projects/gd-cursor-docs/Breeze/size_ver.png)|
	)
	+/
	ResizeNS,

	/++
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](/user-data/projects/gd-cursor-docs/Windows/aero_ew.png)|![Image](/user-data/projects/gd-cursor-docs/Yaru/sb_h_double_arrow.png)|![Image](/user-data/projects/gd-cursor-docs/Breeze/size_hor.png)|
	)
	+/
	ResizeEW,

	/++
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](/user-data/projects/gd-cursor-docs/Windows/aero_nesw.png)|![Image](/user-data/projects/gd-cursor-docs/Yaru/fd_double_arrow.png)|![Image](/user-data/projects/gd-cursor-docs/Breeze/size_bdiag.png)|
	)
	+/
	ResizeNESW,

	/++
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](/user-data/projects/gd-cursor-docs/Windows/aero_nwse.png)|![Image](/user-data/projects/gd-cursor-docs/Yaru/bd_double_arrow.png)|![Image](/user-data/projects/gd-cursor-docs/Breeze/size_fdiag.png)|
	)
	+/
	ResizeNWSE,

	/++ Indicates the ability to select text.
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](/user-data/projects/gd-cursor-docs/Windows/beam_i.png)|![Image](/user-data/projects/gd-cursor-docs/Yaru/xterm.png)|![Image](/user-data/projects/gd-cursor-docs/Breeze/text.png)|
	)
	+/
	Text,

	/++ Indicates the ability to select vertical text.
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](/user-data/projects/gd-cursor-docs/Windows/beam_i_vertical.png)|![Image](/user-data/projects/gd-cursor-docs/Yaru/vertical-text.png)|![Image](/user-data/projects/gd-cursor-docs/Breeze/vertical-text.png)|
	)
	+/
	VerticalText,

	/++ The program is busy and the user cannot interact with the interface.
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](/user-data/projects/gd-cursor-docs/Windows/aero_busy.png)|![Image](/user-data/projects/gd-cursor-docs/Yaru/watch.png)|![Image](/user-data/projects/gd-cursor-docs/Breeze/wait.png)|
	)
	+/
	Wait,

	/++ Something can be zoomed in (magnified).
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](/user-data/projects/gd-cursor-docs/Windows/aero_zoom-in.png)|![Image](/user-data/projects/gd-cursor-docs/Yaru/zoom-in.png)|![Image](/user-data/projects/gd-cursor-docs/Breeze/zoom-in.png)|
	)
	+/
	ZoomIn,

	/++ Something can be zoomed out (demagnified).
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](/user-data/projects/gd-cursor-docs/Windows/aero_zoom-out.png)|![Image](/user-data/projects/gd-cursor-docs/Yaru/zoom-out.png)|![Image](/user-data/projects/gd-cursor-docs/Breeze/zoom-out.png)|
	)
	+/
	ZoomOut,

}

/++ Macros: SMALL_TABLE=$0 +/
