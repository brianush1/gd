import std.stdio;
import gd.system.application;
import gd.system.window;
import gd.bindings.gl;

void main() {
	WindowInitOptions options;
	options.title = "Basic OpenGL demo";
	options.initialState = WindowState.Maximized;

	Window win = application.display.createWindow(options);
	scope (exit)
		win.state = win.state | WindowState.Visible;

	win.setPaintHandler({
		GL.clearColor(1, 0, 1, 1);
		GL.clear(GL.COLOR_BUFFER_BIT);
	});

	win.onCloseRequest.connect({
		// the application will automatically terminate once no more events can occur,
		// so we don't have to manually call quitApp()
		win.state = win.state & ~WindowState.Visible;
	});
}
