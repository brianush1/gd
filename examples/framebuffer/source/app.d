import gd.graphics.color;
import gd.system.application;
import gd.system.window;

void main() {
	WindowInitOptions options;
	options.graphicsBackend = GraphicsBackend.PixelFramebuffer;
	options.title = "Pixel framebuffer demo";

	Window window = application.display.createWindow(options);
	scope (exit)
		window.state = window.state | WindowState.Visible;

	window.setPaintHandler({
		uint[] pixels = window.framebuffer;
		foreach (y; 0 .. window.size.y) {
			foreach (x; 0 .. window.size.x) {
				pixels[y * window.size.x + x] = ((x / 32 + y / 32) & 1)
					? Colors.DeepPink.asUint
					: Colors.MidnightBlue.asUint;
			}
		}
	});

	window.onCloseRequest.connect({
		window.state = window.state & ~WindowState.Visible;
	});
}
