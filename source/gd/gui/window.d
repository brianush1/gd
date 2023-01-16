module gd.gui.window;
import gd.gui.element;
import gd.system.window : SysWindow = Window, WindowInitOptions;
public import gd.system.window : WindowState;
import gd.system.application;
import gd.signal;
import gd.graphics;
import gd.math;
import std.exception : enforce;
import std.traits;
import core.thread;

private bool[Window] visibleWindows;
private bool[Window] allWindows;

double getTime() {
	import core.time : MonoTimeImpl, ClockType;

	auto time = MonoTimeImpl!(ClockType.normal).currTime();
	return time.ticks / cast(double) time.ticksPerSecond;
}

double getUnixTime() {
	import std.datetime.systime : SysTime, Clock;
	import std.datetime.interval : Interval;
	import std.datetime.date : DateTime;
	import std.datetime.timezone : UTC;

	return Interval!SysTime(SysTime(DateTime(1970, 1, 1), UTC()), Clock.currTime)
		.length.total!"hnsecs" / 10_000_000.0;
}

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
			initialState: WindowState.none,
			backgroundColor: background,
		};
		impl = application.display.createWindow(options);
		impl.onCloseRequest.connect(&closeRequestHandler);
		impl.onSizeChange.connect(&resizeHandler);
		allWindows[this] = true;

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

			if (value & WindowState.visible) {
				visibleWindows[this] = true;
			}
			else {
				visibleWindows.remove(this);
			}
		});

		impl.setPaintHandler((IRect region, IVec2 bufferSize) {
			import gd.bindings.gl : GL;
			import std.algorithm : max;

			GL.clearColor(Color.fromHex("#ff7f00").tupleof);
			GL.clear(GL.COLOR_BUFFER_BIT);

			GL.enable(GL.SCISSOR_TEST);
			GL.scissor(20, bufferSize.y - 20 - (impl.size.y - 40), max(0, impl.size.x - 40), max(0, impl.size.y - 40));
			GL.clearColor(Color.fromHex("#00c000").tupleof);
			GL.clear(GL.COLOR_BUFFER_BIT);
			GL.disable(GL.SCISSOR_TEST);

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

Window[] getVisibleWindows() {
	import std.array : array;

	return visibleWindows.byKey.array;
}

void hideAllWindows() {
	foreach (win; getVisibleWindows) {
		win.visible = false;
	}
}

bool isGuiActive() {
	return visibleWindows.length > 0;
}
