import std.stdio;
import gd.system.application;
import gd.system.window;
import gd.bindings.gl;
import gd.math;
import gd.timer;
import gd.cursor;
import std.conv;

// void main() {
// 	WindowInitOptions options;
// 	options.title = "ZeBricks";
// 	// options.className = "player";
// 	// options.applicationName = "ZeBricks";
// 	// options.depthSize = 24;
// 	// options.initialState = WindowState.Maximized;
// 	// options.size = IVec2(1000, 480);
// 	// options.glVersionMajor = 3;
// 	// options.glVersionMinor = 3;
// 	Window window = application.display.createWindow(options);
// 	scope (success)
// 		window.state = window.state | WindowState.Visible;

// 	window.setPaintHandler({
// 		import std.random : uniform;
// 		GL.clearColor(1, 0.5, 0, 1.0);
// 		GL.clear(GL.COLOR_BUFFER_BIT);
// 	});
// }

void main(string[] args) {
	WindowInitOptions options;
	options.title = "Basic Windows Demo";

	Window win = application.display.createWindow(options);
	scope (exit)
		win.state = win.state | WindowState.Visible;

	win.setPaintHandler({
		import std.random : uniform;
		GL.clearColor(1, 0.5, 0, 1.0);
		GL.clear(GL.COLOR_BUFFER_BIT);
	});

	win.onKeyPress.connect((info) {
		writeln("DOWN ", info.mods, " ", info.logical, " ", info.physical);
		import std.conv : text;
		win.title = text("pressed ", info.logical);
	});

	win.onKeyRelease.connect((info) {
		writeln("UP   ", info.mods, " ", info.logical, " ", info.physical);
	});

	win.primaryPointer.onScroll.connect((delta) {
		writeln("scroll ", delta);
	});

	win.onStateChange.connect((flags) {
		write("State:  ");
		if (flags & WindowState.Minimized) write("Minimized ");
		if (flags & WindowState.Maximized) write("Maximized ");
		if (flags & WindowState.Fullscreen) write("Fullscreen ");
		if (flags & WindowState.Visible) write("Visible ");
		if (flags & WindowState.Attention) write("Attention ");
		if (flags & WindowState.Topmost) write("Topmost ");
		writeln();
	});

	Cursors cursor = Cursors.Arrow;
	win.primaryPointer.onButtonPress.connect((button) {
		cursor = cast(Cursors)((cursor + 1) % (Cursors.ZoomOut + 1));
		win.primaryPointer.cursor = cursor;
		win.title = text(cursor);
		writeln("press ", button, " : ", win.primaryPointer.position);
		// win.primaryPointer.lockInPlace();
	});

	win.primaryPointer.onButtonRelease.connect((button) {
		writeln("release ", button);
		// win.primaryPointer.removeConstraint();
	});
	win.primaryPointer.onEnter.connect({ writeln("enter"); });
	win.primaryPointer.onLeave.connect({ writeln("leave"); });

	win.onCloseRequest.connect({
		// the application will automatically terminate once no more events can occur,
		// so we don't have to manually call quitApp()
		win.state = win.state & ~WindowState.Visible;
	});
}
