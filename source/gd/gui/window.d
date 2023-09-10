module gd.gui.window;
import gd.gui.widgets;
import gd.gui.event;
import gd.gui.style;
import gd.gui.themes;
import gd.internal.gpu;
import gd.internal.window : SysWindow = Window, WindowInitOptions, Pointer;
public import gd.internal.window : WindowState;
import gd.internal.application;
import gd.signal;
import gd.keycode;
import gd.graphics;
import gd.math;
import std.traits;
import std.typecons;
import core.thread;

class Window : Container {

	private SysWindow impl;

	Signal!Event onCloseRequest;

	override const(Color) background() const @property { return super.background(); }
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

	private Image m_icon;
	inout(Image) icon() inout @property { return m_icon; }
	void icon(Image value) @property {
		m_icon = value;

		BitmapImage bmp = cast(BitmapImage) value;
		if (bmp) {}
		else if (VectorImage vec = cast(VectorImage) value) {
			bmp = vec.toBitmap(IVec2(256));
		}
		else {
			assert(0, "unsupported image type");
		}

		impl.setIcon(bmp.isize, bmp.readPixels(IRect(0, 0, bmp.isize)));
	}

	mixin Property!(IVec2, "windowSize", IVec2(640, 480));
	mixin(setter!("windowSize", "private"));
	inout(IVec2) windowSize() inout @property { return m_windowSize; }

	StyleSheet[] styleSheets;

	this(Flag!"startVisible" startVisible = Yes.startVisible) {
		assert(Thread.getThis is guiThread, "window cannot be created in thread other than main thread");

		styleSheets ~= defaultTheme;

		visible = startVisible;
		background = Colors.White;
		Window.setSize(IVec2(640, 480));

		WindowInitOptions options = {
			title: title,
			size: windowSize,
			initialState: visible ? WindowState.Visible : WindowState.None,
			backgroundColor: background,
		};
		impl = application.display.createWindow(options);
		impl.onCloseRequest.connect(&closeRequestHandler);
		impl.onSizeChange.connect(&sizeChangeHandler);
		impl.onStateChange.connect(&stateChangeHandler);
		impl.setPaintHandler(&paintHandler);
		impl.handlePointer(&pointerHandler);

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
	}

	private void closeRequestHandler() {
		Event ev = new Event;
		onCloseRequest.emit(ev);
		if (!ev.defaultPrevented) {
			visible = false;
		}
	}

	private void sizeChangeHandler(IVec2 newSize) {
		windowSize = newSize;
	}

	private void stateChangeHandler(WindowState newState) {
		visible = (newState & WindowState.Visible) != 0;
		onStateChange.emit(new Event);
	}

	private BitmapImage surfaceImage;
	private IRect paintHandler(IRect region, IVec2 bufferSize, GPUSurface surface) {
		if (!surfaceImage || surfaceImage.isize != bufferSize)
			surfaceImage = new BitmapImage(bufferSize);

		Graphics g = Graphics.fromImage(surfaceImage);

		g.clipRegion = region;
		paint(g, Rect(0, 0, windowSize));
		application.display.gpuContext.blit(
			surface, IRect(0, 0, impl.size),
			surfaceImage.gpuImage, IRect(0, 0, impl.size),
		);

		return region;
	}

	private void pointerHandler(Pointer pointer) {
		pointer.onButtonPress.connect((MouseButton button) {
			foreach (child; getChildren) {
				child.onMouseDown.emit(new Event);
			}
		});
		pointer.onButtonRelease.connect((MouseButton button) {
			foreach (child; getChildren) {
				child.onMouseUp.emit(new Event);
			}
		});
	}

	override void invalidate() {
		impl.invalidate(IRect(0, 0, impl.size));
	}

	// TODO: get rid of this
	void setSize(IVec2 newSize) {
		if (newSize.x < 1) newSize.x = 1;
		if (newSize.y < 1) newSize.y = 1;
		if (impl !is null) {
			// we have an event handler on impl that sets windowSize when the window
			// is resized, so no need to do it in here
			impl.size = newSize;
		}
		else {
			windowSize = newSize;
		}
	}

}
