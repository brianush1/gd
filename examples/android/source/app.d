import gd.system.android.jni;
import gd.system.android.bindings;
import gd.system.application;
import gd.system.window;

version (Android) {
	import gd.bindings.gles2;
	alias GL = GLES2;
}
else {
	import gd.bindings.gl;
}

import core.time : msecs;
import core.stdc.stdio;

version (gd_Android) {} else {
	void logf(Args...)(string fmt, Args args) {
		import std.string : toStringz;

		printf(toStringz(fmt ~ "\n"), args);
	}
}

void main() {
	WindowInitOptions options;
	options.title = "Crossplatform demo";
	options.initialState = WindowState.Maximized;
	Window win = application.display.createWindow(options);
	scope (success)
		win.state = win.state | WindowState.Visible;

	win.setPaintHandler({
		GL.clearColor(1, 1, 0, 1);
		GL.clear(GL.COLOR_BUFFER_BIT);

		GL.scissor(100, 100, 200, 300);
		GL.enable(GL.SCISSOR_TEST);

		GL.clearColor(1, 0, 1, 1);
		GL.clear(GL.COLOR_BUFFER_BIT);

		GL.disable(GL.SCISSOR_TEST);
	});

	win.onCloseRequest.connect({
		win.state = win.state & ~WindowState.Visible;
	});
}
