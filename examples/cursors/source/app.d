import std.stdio;
import gd.system.application;
import gd.system.display;
import gd.system.window;
import gd.math;
import gd.cursor;
import gd.bindings.gl;
import imageformats;

void main() {
	WindowInitOptions options;
	options.title = "Basic cursor demo";
	options.initialState = WindowState.Maximized;

	Window win = application.display.createWindow(options);
	scope (exit)
		win.state = win.state | WindowState.Visible;

	win.setPaintHandler({
		GL.clearColor(1, 0, 1, 1);
		GL.clear(GL.COLOR_BUFFER_BIT);
	});

	IFImage iconImg = read_png("icon.png", 4);
	win.setIcon(IVec2(128, 128), cast(uint[]) iconImg.pixels);

	IFImage img = read_png("cursor.png", 4);
	win.primaryPointer.cursor = application.display.createXorCursor(IVec2(64, 64), cast(uint[]) img.pixels, IVec2(27, 22));

	win.onCloseRequest.connect({
		// the application will automatically terminate once no more events can occur,
		// so we don't have to manually call quitApp()
		win.state = win.state & ~WindowState.Visible;
	});
}
