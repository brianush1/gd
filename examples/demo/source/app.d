import gd.system.application;
import gd.system.window;
import gd.bindings.gl;
import gd.graphics;
import gd.keycode;
import gd.math;
import std.datetime;
import std.stdio;

void main() {
	WindowInitOptions options;
	options.initialState = WindowState.visible;

	Window win = application.display.createWindow(options);

	bool locked;

	writeln("window has ", win.pointers.length, " pointers");

	Vec2[Pointer] cursors;
	Color[Pointer] colors;
	double[Pointer] pressure;
	bool[Pointer] isDown;

	win.handlePointer((Pointer pointer) {
		import std.random : uniform;

		colors[pointer] = Color(
			uniform!"[]"(0.0, 1.0),
			uniform!"[]"(0.0, 1.0),
			uniform!"[]"(0.0, 1.0),
		);
		cursors[pointer] = pointer.position;
		isDown[pointer] = false;
		pressure[pointer] = (pointer.flags & PointerFlags.hasPressure) ? pointer.pressure : 1;
		// cursors[pointer] = Vec2(0, 0);
		win.invalidate(IRect(0, 0, win.size.x, win.size.y));

		pointer.onScroll.connect((Vec2 delta) {
			// writeln("scroll ", delta);
			// cursors[pointer] += delta * 64;
			// win.invalidate(IRect(0, 0, win.size.x, win.size.y));
		});

		pointer.onButtonPress.connect((MouseButton button) {
			if (button == MouseButton.left) {
				isDown[pointer] = true;
			}
			if (button == MouseButton.right && !locked) {
				locked = true;
				pointer.lockInPlace();
			}
		});

		pointer.onEnter.connect({
			writeln("enter ", pointer);
		});

		pointer.onLeave.connect({
			writeln("leave ", pointer);
		});

		pointer.onButtonRelease.connect((MouseButton button) {
			writeln("release ", button);
			if (button == MouseButton.left) {
				isDown[pointer] = false;
			}
			if (button == MouseButton.right) {
				locked = false;
				pointer.removeConstraint();
			}
		});

		pointer.onPressureChange.connect((double pr) {
			pressure[pointer] = pr;
		});

		pointer.onPositionChange.connect((Vec2 position) {
			// writeln(position);
			cursors[pointer] = position;
			win.invalidate(IRect(0, 0, win.size.x, win.size.y));
		});

		pointer.onRemove.connect({
			cursors.remove(pointer);
			win.invalidate(IRect(0, 0, win.size.x, win.size.y));
		});
	});

	IVec2 prevSize;
	win.setPaintHandler((IRect region, IVec2 bufferSize) {
		import gd.bindings.gl : GL;
		import std.algorithm : max;

		if (prevSize != bufferSize) {
			prevSize = bufferSize;
			GL.clearColor(Color.fromHex("#ff7f00").tupleof);
			GL.clear(GL.COLOR_BUFFER_BIT);
		}

		GL.enable(GL.SCISSOR_TEST);
		foreach (pointer; cursors.byKey) {
			if (!isDown[pointer]) continue;
			int size = cast(int)(pressure[pointer] * 40 + 0.5);
			GL.scissor(
				cast(int)(cursors[pointer].x - size / 2),
				cast(int)(bufferSize.y - cursors[pointer].y - size + size / 2),
				size, size,
			);
			GL.clearColor(colors[pointer].tupleof);
			GL.clear(GL.COLOR_BUFFER_BIT);
		}
		GL.disable(GL.SCISSOR_TEST);

		return IRect(IVec2(0, 0), bufferSize);
	});

	win.onCloseRequest.connect({
		writeln("closing");
		application.deactivate();
	});

	application.startEventLoop();
}
