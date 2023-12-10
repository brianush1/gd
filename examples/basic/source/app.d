import std.stdio;
import gd.system.application;
import gd.system.window;
import gd.bindings.gl;

void main() {
	WindowInitOptions options;
	options.title = "Basic demo";
	options.initialState = WindowState.Visible;
	Window win = application.display.createWindow(options);
	win.setPaintHandler({
		GL.clearColor(1, 0, 1, 1);
		GL.clear(GL.COLOR_BUFFER_BIT);
	});
	win.onCloseRequest.connect({
		win.state = win.state & ~WindowState.Visible;
	});
}
