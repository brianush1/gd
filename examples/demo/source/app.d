import gd.system.application;
import gd.system.window;
import gd.timer;
import gd.bindings.gl;
import gd.graphics;
import gd.keycode;
import gd.math;
import std.datetime;
import std.stdio;
import std.datetime;
import std.conv;
import gd.cursor;

void main() {
	WindowInitOptions options;
	options.initialState = WindowState.visible;
	options.title = "Demo Window";

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
		win.invalidate(IRect(0, 0, win.size.x, win.size.y));

		pointer.onScroll.connect((Vec2 delta) {
			// writeln("scroll ", delta);
			// cursors[pointer] += delta * 64;
			// win.invalidate(IRect(0, 0, win.size.x, win.size.y));
		});

		Cursors cursor = Cursors.min;
		Vec2 downPos;
		pointer.onButtonPress.connect((MouseButton button) {
			if (cursor == Cursors.max) {
				cursor = Cursors.min;
			}
			else {
				cursor += 1;
			}

			pointer.cursor = cursor;

			if (button == MouseButton.left) {
				isDown[pointer] = true;
			}
			if (button == MouseButton.right && !locked) {
				locked = true;
				downPos = pointer.position;
				// pointer.lockInPlace();
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
				// pointer.removeConstraint();
			}
		});

		pointer.onPressureChange.connect((double pr) {
			pressure[pointer] = pr == -1 ? 1 : pr;
		});

		pointer.onPositionChange.connect((Vec2 position) {
			if (locked) {
				pointer.position = downPos;
				return;
			}

			cursors[pointer] = position;
			win.invalidate(IRect(0, 0, win.size.x, win.size.y));

			// warp pointer if it goes out of bounds
			if (isDown[pointer] && (pointer.flags & PointerFlags.relativeMotion)) {
				if (position.x >= win.size.x) {
					position.x -= win.size.x;
					pointer.position = position;
				}
				else if (position.x < 0) {
					position.x += win.size.x;
					pointer.position = position;
				}

				if (position.y >= win.size.y) {
					position.y -= win.size.y;
					pointer.position = position;
				}
				else if (position.y < 0) {
					position.y += win.size.y;
					pointer.position = position;
				}
			}
		});

		pointer.onRemove.connect({
			cursors.remove(pointer);
			// win.invalidate(IRect(0, 0, win.size.x, win.size.y));
		});
	});

	IVec2 prevSize;
	win.onKeyPress.connect((KeyInfo info) {
		if (info.logical == KeyCode.escape) {
			application.deactivate();
		}

		if (info.logical == KeyCode.delete_) {
			prevSize = IVec2();
			win.invalidate(IRect(IVec2(), win.size));
		}
	});

	win.setPaintHandler((IRect region, IVec2 bufferSize) {
		import gd.bindings.gl : GL;
		import std.algorithm : max;

		if (prevSize != bufferSize) {
			prevSize = bufferSize;
			GL.clearColor(1, 1, 1, 1);
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
