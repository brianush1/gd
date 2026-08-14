module gd.system.osx.display;
import gd.system.osx.window;
import gd.system.osx.bindings;
import gd.system.application;
import gd.system.display;
import gd.system.window;
import gd.cursor : Cursors;
import gd.keycode;
import gd.math;
import gd.resource;

version (gd_OSX):

class OSXCursor : Cursor {
	private OSXDisplay m_display;
	inout(OSXDisplay) display() inout @property => m_display;

	private NSCursor m_native;
	inout(NSCursor) native() inout @property => m_native;

	private bool ownsNative;

	this(OSXDisplay display, NSCursor native, bool ownsNative = false) {
		scope (failure) dispose();
		addDependency(display);
		m_display = display;
		m_native = native;
		this.ownsNative = ownsNative;
	}

	protected override void disposeImpl() {
		if (ownsNative && native)
			native.release();
		m_native = null;
	}
}

class OSXDisplay : Display {
	package {
		OSXCursor[Cursors] systemCursorMap;
		bool[OSXWindow] activeWindows;
		IRect[OSXWindow] invalidationQueue;
	}

	package(gd.system) this(Application application) {
		scope (failure) dispose();
		addDependency(application);
		loadSystemCursors();
	}

	protected override void disposeImpl() {
		deactivate();
	}

	private void loadSystemCursors() {
		void add(Cursors cursor, NSCursor native) {
			systemCursorMap[cursor] = new OSXCursor(this, native);
		}

		add(Cursors.Arrow, NSCursor.arrowCursor());
		add(Cursors.ArrowLeft, NSCursor.arrowCursor());
		add(Cursors.ArrowCenter, NSCursor.arrowCursor());
		add(Cursors.ArrowRight, NSCursor.arrowCursor());
		add(Cursors.Cell, NSCursor.crosshairCursor());
		add(Cursors.ColorPicker, NSCursor.crosshairCursor());
		add(Cursors.Handwriting, NSCursor.crosshairCursor());
		add(Cursors.ContextMenu, NSCursor.contextualMenuCursor());
		add(Cursors.Copy, NSCursor.dragCopyCursor());
		add(Cursors.Crosshair, NSCursor.crosshairCursor());
		add(Cursors.Grab, NSCursor.openHandCursor());
		add(Cursors.Grabbing, NSCursor.closedHandCursor());
		add(Cursors.Hand, NSCursor.pointingHandCursor());
		add(Cursors.Help, NSCursor.arrowCursor());
		add(Cursors.Link, NSCursor.dragLinkCursor());
		add(Cursors.Move, NSCursor.openHandCursor());
		add(Cursors.NoDrop, NSCursor.operationNotAllowedCursor());
		add(Cursors.None, null);
		add(Cursors.NotAllowed, NSCursor.operationNotAllowedCursor());
		add(Cursors.Pan, NSCursor.openHandCursor());
		add(Cursors.Progress, NSCursor.arrowCursor());
		add(Cursors.SplitVertical, NSCursor.resizeUpDownCursor());
		add(Cursors.SplitHorizontal, NSCursor.resizeLeftRightCursor());
		add(Cursors.ResizeRow, NSCursor.resizeUpDownCursor());
		add(Cursors.ResizeColumn, NSCursor.resizeLeftRightCursor());
		add(Cursors.ResizeN, NSCursor.resizeUpDownCursor());
		add(Cursors.ResizeW, NSCursor.resizeLeftRightCursor());
		add(Cursors.ResizeS, NSCursor.resizeUpDownCursor());
		add(Cursors.ResizeE, NSCursor.resizeLeftRightCursor());
		add(Cursors.ResizeNE, NSCursor.crosshairCursor());
		add(Cursors.ResizeNW, NSCursor.crosshairCursor());
		add(Cursors.ResizeSW, NSCursor.crosshairCursor());
		add(Cursors.ResizeSE, NSCursor.crosshairCursor());
		add(Cursors.ResizeNS, NSCursor.resizeUpDownCursor());
		add(Cursors.ResizeEW, NSCursor.resizeLeftRightCursor());
		add(Cursors.ResizeNESW, NSCursor.crosshairCursor());
		add(Cursors.ResizeNWSE, NSCursor.crosshairCursor());
		add(Cursors.Text, NSCursor.IBeamCursor());
		add(Cursors.VerticalText, NSCursor.IBeamCursorForVerticalLayout());
		add(Cursors.Wait, NSCursor.arrowCursor());
		add(Cursors.ZoomIn, NSCursor.crosshairCursor());
		add(Cursors.ZoomOut, NSCursor.crosshairCursor());
	}

	override OSXWindow createWindow(WindowInitOptions options) {
		OSXWindow window = new OSXWindow(this, options);
		window.onStateChange.connect((WindowState state) {
			if (state & WindowState.Visible)
				activeWindows[window] = true;
			else
				activeWindows.remove(window);
		});
		if (window.state & WindowState.Visible)
			activeWindows[window] = true;
		return window;
	}

	override OSXCursor createCursor(IVec2 size, const(uint)[] data, IVec2 hotspot) {
		assert(data.length == size.x * cast(size_t) size.y);
		assert(hotspot.x >= 0 && hotspot.x < size.x && hotspot.y >= 0 && hotspot.y < size.y);

		NSImage image = createImage(NSSize(size.x, size.y), data);
		NSCursor cursor = NSCursor.alloc.initWithImage(image, NSPoint(hotspot.x, hotspot.y));
		image.release();
		return new OSXCursor(this, cursor, true);
	}

	override OSXCursor createXorCursor(IVec2 size, const(uint)[] data, IVec2 hotspot) {
		uint[] converted = new uint[data.length];
		foreach (i, color; data)
			converted[i] = color >> 24 ? 0xFFFF_FFFF : 0;
		return createCursor(size, converted, hotspot);
	}

	override Modifiers getCurrentModifiers() {
		return convertModifiers(NSEvent.currentModifierFlags());
	}

	override bool isActive() {
		return activeWindows.length != 0;
	}

	override void deactivate() {
		import std.array : array;

		foreach (window; activeWindows.byKey.array)
			window.state = window.state & ~WindowState.Visible;
		invalidationQueue = null;
	}

	override void processEvents() {
		IRect[OSXWindow] queue = invalidationQueue;
		invalidationQueue = null;
		foreach (window, region; queue)
			window.updateRegion(region);
	}
}

package Modifiers convertModifiers(NSEventModifierFlags flags) {
	Modifiers result;
	if (flags & NSEventModifierFlags.Control) result |= Modifiers.Ctrl;
	if (flags & NSEventModifierFlags.Shift) result |= Modifiers.Shift;
	if (flags & NSEventModifierFlags.Option) result |= Modifiers.Alt;
	if (flags & NSEventModifierFlags.Command) result |= Modifiers.Super;
	if (flags & NSEventModifierFlags.CapsLock) result |= Modifiers.CapsLock;
	return result;
}
