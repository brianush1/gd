module gd.gui.window;
import gd.gui.element;
import gd.gui.event;
import gd.internal.gpu;
import gd.internal.window : SysWindow = Window, WindowInitOptions;
public import gd.internal.window : WindowState;
import gd.internal.application;
import gd.signal;
import gd.graphics;
import gd.math;
import std.exception : enforce;
import std.traits;
import core.thread;

private bool[Window] visibleWindows;
private bool[Window] allWindows;

class Window : Element {

	private SysWindow impl;

	Signal!Event onCloseRequest;

	override inout(Color) background() inout @property { return super.background(); }
	override Color background(Color value) @property {
		value.a = 1;
		return super.background(value);
	}

	mixin Property!(string, "title", "Untitled Window");
	mixin(setter!"title");
	inout(string) title() inout @property { return m_title; }

	Signal!Event onStateChange;
	WindowState state() const @property { return impl.state; }
	void state(WindowState value) @property { impl.state = value; }

	this() {
		enforce(Thread.getThis is guiThread, "window cannot be created in thread other than main thread");

		visible = false;
		background = Color.fromHex("#fff");
		Window.setSize(IVec2(640, 480));

		WindowInitOptions options = {
			title: title,
			size: IVec2(absoluteSize),
			initialState: WindowState.None,
			backgroundColor: background,
		};
		impl = application.display.createWindow(options);
		impl.onCloseRequest.connect(&closeRequestHandler);
		impl.onSizeChange.connect(&resizeHandler);
		allWindows[this] = true;

		onVisibleChange.connect((value) {
			if (impl !is null) {
				if (value) {
					impl.state = impl.state | WindowState.Visible;
				}
				else {
					impl.state = impl.state & ~WindowState.Visible;
				}
			}
		});

		onTitleChange.connect((value) {
			if (impl !is null) {
				impl.title = value;
			}
		});

		onBackgroundChange.connect((value) {
			if (impl !is null) {
				impl.backgroundColor = value;
			}
		});

		impl.onStateChange.connect((value) {
			onStateChange.emit(new Event);

			if (value & WindowState.Visible) {
				visibleWindows[this] = true;
			}
			else {
				visibleWindows.remove(this);
			}
		});

		impl.setPaintHandler((IRect region, IVec2 bufferSize, GPUSurface surface) {
			import gd.bindings.gl : GL;
			import std.algorithm : max;

			application.display.gpuContext.clearColorBuffer(surface, FVec4(1, 0.5, 0, 1));

			// GL.enable(GL.SCISSOR_TEST);
			// GL.scissor(20, bufferSize.y - 20 - (impl.size.y - 40), max(0, impl.size.x - 40), max(0, impl.size.y - 40));
			// GL.clearColor(Color.fromHex("#00c000").tupleof);
			// GL.clear(GL.COLOR_BUFFER_BIT);
			// GL.disable(GL.SCISSOR_TEST);

			return IRect(IVec2(0, 0), bufferSize);
		});
	}

	~this() {
		if (impl) {
			impl.dispose();
			impl = null;
		}
	}

	private void resizeHandler(IVec2 newSize) {
		absoluteSize = Vec2(newSize);
	}

	private void closeRequestHandler() {
		Event ev = new Event;
		onCloseRequest.emit(ev);
		if (!ev.defaultPrevented) {
			visible = false;
		}
	}

	void setSize(IVec2 newSize) {
		if (newSize.x < 1) newSize.x = 1;
		if (newSize.y < 1) newSize.y = 1;
		if (impl !is null) {
			// we have an event handler on the window implementation that sets absoluteSize when the window
			// is resized, so no need to do it in here
			impl.size = newSize;
		}
		else {
			absoluteSize = Vec2(newSize);
		}
	}

}
