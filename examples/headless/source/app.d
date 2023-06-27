import std.stdio;
import imageformats;
import gd.graphics;
import gd.math;
import gd.internal.application;
import gd.internal.display;
import gd.internal.window;
import gd.internal.gpu;
import std.random;

void main() {
	WindowInitOptions options;
	options.oversizeBuffer = true;
	options.title = "Test";
	options.initialState = WindowState.Visible;
	options.depthSize = 24;
	options.size = IVec2(640, 480);

	Window win = application.display.createWindow(options);

	win.onCloseRequest.connect({
		win.state = win.state & ~WindowState.Visible;
	});

	win.setPaintHandler((IRect region, IVec2 bufferSize, GPUSurface surface) {
		Graphics g = Graphics.fromGPUSurface(surface);

		g.clear(Color(0.9, 0.9, 0.9));

		return IRect(IVec2(0, 0), bufferSize);
	});

	Image img = new Image(uniform!"[]"(300, 600), uniform!"[]"(300, 600));
	Graphics g = Graphics.fromImage(img);

	// application.display.gpuContext.clearColorBuffer(img.gpuImage, FVec4(1, 0, 1, 1));
	g.clear(Color(1, 0.5, 0, 1));

	img.save("test.png", ImageFileFormat.PNG);

}
