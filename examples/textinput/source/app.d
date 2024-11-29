import std.stdio;
import gd.system.application;
import gd.system.window;
import gd.bindings.gl;
import gd.math;
import gd.keycode;

void main() {
	WindowInitOptions options;
	options.title = "Text input demo";
	options.initialState = WindowState.Maximized;

	Window win = application.display.createWindow(options);
	scope (exit)
		win.state = win.state | WindowState.Visible;

	win.setIMECursorPosition(IVec2(300, 20));
	win.setIMEFocus(true);

	win.onCompositionStart.connect({
		writeln("start composition");
	});

	win.onCompositionEnd.connect({
		writeln("end composition");
	});

	win.onCompositionUpdate.connect((string s) {
		writeln("composing: ", s);
	});

	win.onTextInput.connect((string s) {
		writeln("input: ", s);
	});

	win.onKeyPress.connect((KeyInfo info) {
		if ((info.mods & Modifiers.Ctrl) && info.logical == KeyCode.V) {
			writeln("paste");
			writeln(cast(string) win.getClipboardData(Clipboard.Clipboard, "text/plain"));
		}
		else if ((info.mods & Modifiers.Ctrl) && info.logical == KeyCode.C) {
			writeln("copy");
			win.setClipboardData(Clipboard.Clipboard, "text/plain", "Hello!");
		}
	});

	win.primaryPointer.onButtonPress.connect((MouseButton button) {
		if (button == MouseButton.Middle) {
			writeln("middle click paste");
			writeln(cast(string) win.getClipboardData(Clipboard.Selection, "text/plain"));
		}
	});

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
