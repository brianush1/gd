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
	arrow,

	/++
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](/user-data/projects/gd-cursor-docs/Windows/aero_arrow.png)|![Image](/user-data/projects/gd-cursor-docs/Yaru/left_ptr.png)|![Image](/user-data/projects/gd-cursor-docs/Breeze/default.png)|
	)
	+/
	arrowLeft,

	/++
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|N/A|N/A|![Image](/user-data/projects/gd-cursor-docs/Breeze/center_ptr.png)|
	)
	+/
	arrowCenter,

	/++

	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](/user-data/projects/gd-cursor-docs/Windows/aero_right_arrow.png)|![Image](/user-data/projects/gd-cursor-docs/Yaru/right_ptr.png)|![Image](/user-data/projects/gd-cursor-docs/Breeze/right_ptr.png)|
	)
	+/
	arrowRight,

	/++
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](/user-data/projects/gd-cursor-docs/Windows/cell.png)|![Image](/user-data/projects/gd-cursor-docs/Yaru/plus.png)|![Image](/user-data/projects/gd-cursor-docs/Breeze/cell.png)|
	)
	+/
	cell,

	/++
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|N/A|![Image](/user-data/projects/gd-cursor-docs/Yaru/color-picker.png)|![Image](/user-data/projects/gd-cursor-docs/Breeze/color-picker.png)|
	)
	+/
	colorPicker,

	/++
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](/user-data/projects/gd-cursor-docs/Windows/aero_pen.png)|N/A|N/A||
	)
	+/
	pen,

	/++
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|N/A|![Image](/user-data/projects/gd-cursor-docs/Yaru/pencil.png)|![Image](/user-data/projects/gd-cursor-docs/Breeze/pencil.png)|
	)
	+/
	pencil,

	/++
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|N/A|![Image](/user-data/projects/gd-cursor-docs/Yaru/context-menu.png)|![Image](/user-data/projects/gd-cursor-docs/Breeze/context-menu.png)|
	)
	+/
	contextMenu,

	/++
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](/user-data/projects/gd-cursor-docs/Windows/aero_copy.png)|![Image](/user-data/projects/gd-cursor-docs/Yaru/copy.png)|![Image](/user-data/projects/gd-cursor-docs/Breeze/copy.png)|
	)
	+/
	copy,

	/++
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](/user-data/projects/gd-cursor-docs/Windows/cross_i.png)|![Image](/user-data/projects/gd-cursor-docs/Yaru/crosshair.png)|![Image](/user-data/projects/gd-cursor-docs/Breeze/crosshair.png)|
	)
	+/
	crosshair,

	/++
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](/user-data/projects/gd-cursor-docs/Windows/aero_grab2.png)|![Image](/user-data/projects/gd-cursor-docs/Yaru/hand1.png)|![Image](/user-data/projects/gd-cursor-docs/Breeze/openhand.png)|
	)
	+/
	grab,

	/++
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](/user-data/projects/gd-cursor-docs/Windows/aero_grabbing.png)|![Image](/user-data/projects/gd-cursor-docs/Yaru/grabbing.png)|![Image](/user-data/projects/gd-cursor-docs/Breeze/dnd-move.png)|
	)
	+/
	grabbing,

	/++
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](/user-data/projects/gd-cursor-docs/Windows/aero_link.png)|![Image](/user-data/projects/gd-cursor-docs/Yaru/hand2.png)|![Image](/user-data/projects/gd-cursor-docs/Breeze/pointer.png)|
	)
	+/
	hand,

	/++
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](/user-data/projects/gd-cursor-docs/Windows/aero_helpsel.png)|![Image](/user-data/projects/gd-cursor-docs/Yaru/question_arrow.png)|![Image](/user-data/projects/gd-cursor-docs/Breeze/help.png)|
	)
	+/
	help,

	/++
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](/user-data/projects/gd-cursor-docs/Windows/aero_alias.png)|![Image](/user-data/projects/gd-cursor-docs/Yaru/dnd-link.png)|![Image](/user-data/projects/gd-cursor-docs/Breeze/alias.png)|
	)
	+/
	link,

	/++
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](/user-data/projects/gd-cursor-docs/Windows/aero_move.png)|![Image](/user-data/projects/gd-cursor-docs/Yaru/move.png)|![Image](/user-data/projects/gd-cursor-docs/Breeze/fleur.png)|
	)
	+/
	move,

	/++
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](/user-data/projects/gd-cursor-docs/Windows/aero_unavail.png)|![Image](/user-data/projects/gd-cursor-docs/Yaru/dnd-no-drop.png)|![Image](/user-data/projects/gd-cursor-docs/Breeze/no-drop.png)|
	)
	+/
	noDrop,

	/++ The cursor is invisible +/
	none,

	/++
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](/user-data/projects/gd-cursor-docs/Windows/aero_unavail.png)|![Image](/user-data/projects/gd-cursor-docs/Yaru/crossed_circle.png)|![Image](/user-data/projects/gd-cursor-docs/Breeze/not-allowed.png)|
	)
	+/
	notAllowed,

	/++
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](/user-data/projects/gd-cursor-docs/Windows/aero_move.png)|![Image](/user-data/projects/gd-cursor-docs/Yaru/all-scroll.png)|![Image](/user-data/projects/gd-cursor-docs/Breeze/all-scroll.png)|
	)
	+/
	pan,

	/++ The program is busy in the background, but the user can still interact with the interface.
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](/user-data/projects/gd-cursor-docs/Windows/aero_working.png)|![Image](/user-data/projects/gd-cursor-docs/Yaru/left_ptr_watch.png)|![Image](/user-data/projects/gd-cursor-docs/Breeze/progress.png)|
	)
	+/
	progress,

	/++
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](/user-data/projects/gd-cursor-docs/Windows/splitv.png)|![Image](/user-data/projects/gd-cursor-docs/Yaru/sb_v_double_arrow.png)|![Image](/user-data/projects/gd-cursor-docs/Breeze/row-resize.png)|
	)
	+/
	splitVertical,

	/++
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](/user-data/projects/gd-cursor-docs/Windows/splith.png)|![Image](/user-data/projects/gd-cursor-docs/Yaru/sb_h_double_arrow.png)|![Image](/user-data/projects/gd-cursor-docs/Breeze/col-resize.png)|
	)
	+/
	splitHorizontal,

	/++
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](/user-data/projects/gd-cursor-docs/Windows/sizev.png)|![Image](/user-data/projects/gd-cursor-docs/Yaru/sb_v_double_arrow.png)|![Image](/user-data/projects/gd-cursor-docs/Breeze/row-resize.png)|
	)
	+/
	resizeRow,

	/++
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](/user-data/projects/gd-cursor-docs/Windows/sizeh.png)|![Image](/user-data/projects/gd-cursor-docs/Yaru/sb_h_double_arrow.png)|![Image](/user-data/projects/gd-cursor-docs/Breeze/col-resize.png)|
	)
	+/
	resizeColumn,

	/++
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](/user-data/projects/gd-cursor-docs/Windows/aero_ns.png)|![Image](/user-data/projects/gd-cursor-docs/Yaru/top_side.png)|![Image](/user-data/projects/gd-cursor-docs/Breeze/top_side.png)|
	)
	+/
	resizeN,

	/++
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](/user-data/projects/gd-cursor-docs/Windows/aero_ew.png)|![Image](/user-data/projects/gd-cursor-docs/Yaru/left_side.png)|![Image](/user-data/projects/gd-cursor-docs/Breeze/left_side.png)|
	)
	+/
	resizeW,

	/++
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](/user-data/projects/gd-cursor-docs/Windows/aero_ns.png)|![Image](/user-data/projects/gd-cursor-docs/Yaru/bottom_side.png)|![Image](/user-data/projects/gd-cursor-docs/Breeze/bottom_side.png)|
	)
	+/
	resizeS,

	/++
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](/user-data/projects/gd-cursor-docs/Windows/aero_ew.png)|![Image](/user-data/projects/gd-cursor-docs/Yaru/right_side.png)|![Image](/user-data/projects/gd-cursor-docs/Breeze/right_side.png)|
	)
	+/
	resizeE,

	/++
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](/user-data/projects/gd-cursor-docs/Windows/aero_nesw.png)|![Image](/user-data/projects/gd-cursor-docs/Yaru/top_right_corner.png)|![Image](/user-data/projects/gd-cursor-docs/Breeze/top_right_corner.png)|
	)
	+/
	resizeNE,

	/++
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](/user-data/projects/gd-cursor-docs/Windows/aero_nwse.png)|![Image](/user-data/projects/gd-cursor-docs/Yaru/top_left_corner.png)|![Image](/user-data/projects/gd-cursor-docs/Breeze/top_left_corner.png)|
	)
	+/
	resizeNW,

	/++
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](/user-data/projects/gd-cursor-docs/Windows/aero_nesw.png)|![Image](/user-data/projects/gd-cursor-docs/Yaru/bottom_left_corner.png)|![Image](/user-data/projects/gd-cursor-docs/Breeze/bottom_left_corner.png)|
	)
	+/
	resizeSW,

	/++
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](/user-data/projects/gd-cursor-docs/Windows/aero_nwse.png)|![Image](/user-data/projects/gd-cursor-docs/Yaru/bottom_right_corner.png)|![Image](/user-data/projects/gd-cursor-docs/Breeze/bottom_right_corner.png)|
	)
	+/
	resizeSE,

	/++
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](/user-data/projects/gd-cursor-docs/Windows/aero_ns.png)|![Image](/user-data/projects/gd-cursor-docs/Yaru/sb_v_double_arrow.png)|![Image](/user-data/projects/gd-cursor-docs/Breeze/size_ver.png)|
	)
	+/
	resizeNS,

	/++
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](/user-data/projects/gd-cursor-docs/Windows/aero_ew.png)|![Image](/user-data/projects/gd-cursor-docs/Yaru/sb_h_double_arrow.png)|![Image](/user-data/projects/gd-cursor-docs/Breeze/size_hor.png)|
	)
	+/
	resizeEW,

	/++
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](/user-data/projects/gd-cursor-docs/Windows/aero_nesw.png)|![Image](/user-data/projects/gd-cursor-docs/Yaru/fd_double_arrow.png)|![Image](/user-data/projects/gd-cursor-docs/Breeze/size_bdiag.png)|
	)
	+/
	resizeNESW,

	/++
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](/user-data/projects/gd-cursor-docs/Windows/aero_nwse.png)|![Image](/user-data/projects/gd-cursor-docs/Yaru/bd_double_arrow.png)|![Image](/user-data/projects/gd-cursor-docs/Breeze/size_fdiag.png)|
	)
	+/
	resizeNWSE,

	/++ Indicates the ability to select text.
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](/user-data/projects/gd-cursor-docs/Windows/beam_i.png)|![Image](/user-data/projects/gd-cursor-docs/Yaru/xterm.png)|![Image](/user-data/projects/gd-cursor-docs/Breeze/text.png)|
	)
	+/
	text,

	/++ Indicates the ability to select vertical text.
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](/user-data/projects/gd-cursor-docs/Windows/beam_i_vertical.png)|![Image](/user-data/projects/gd-cursor-docs/Yaru/vertical-text.png)|![Image](/user-data/projects/gd-cursor-docs/Breeze/vertical-text.png)|
	)
	+/
	verticalText,

	/++ The program is busy and the user cannot interact with the interface.
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](/user-data/projects/gd-cursor-docs/Windows/aero_busy.png)|![Image](/user-data/projects/gd-cursor-docs/Yaru/watch.png)|![Image](/user-data/projects/gd-cursor-docs/Breeze/wait.png)|
	)
	+/
	wait,

	/++ Something can be zoomed in (magnified).
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](/user-data/projects/gd-cursor-docs/Windows/aero_zoom-in.png)|![Image](/user-data/projects/gd-cursor-docs/Yaru/zoom-in.png)|![Image](/user-data/projects/gd-cursor-docs/Breeze/zoom-in.png)|
	)
	+/
	zoomIn,

	/++ Something can be zoomed out (demagnified).
	$(SMALL_TABLE
	|Windows|Ubuntu|KDE|
	|---|---|---|
	|![Image](/user-data/projects/gd-cursor-docs/Windows/aero_zoom-out.png)|![Image](/user-data/projects/gd-cursor-docs/Yaru/zoom-out.png)|![Image](/user-data/projects/gd-cursor-docs/Breeze/zoom-out.png)|
	)
	+/
	zoomOut,

}

/++ Macros: SMALL_TABLE=$0 +/
