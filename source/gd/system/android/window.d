module gd.system.android.window;
import gd.system.android.display;
import gd.system.application;
import gd.system.display;
import gd.system.window;
import gd.resource;
import gd.keycode;
import gd.math;

version (gd_Android):

class AndroidWindow : Window {

	package(gd.system) this(AndroidDisplay display) {
		scope (failure) dispose();

		addDependency(display);
	}

	protected override void disposeImpl() {}

	override inout(Pointer)[] pointers() inout @property { return []; }

	override void setIcon(IVec2 size, const(uint)[] data) {}

	package(gd.system.android) PaintHandler m_paintHandler, m_postPaintHandler;
	override void setPaintHandler(PaintHandler handler) { m_paintHandler = handler; }
	override void setPostPaintHandler(PaintHandler handler) { m_postPaintHandler = handler; }

	override void invalidate(IRect region) {}

	override void setIMEFocus(bool focus) {}
	override void setIMECursorPosition(IVec2 position) {}
	override void setSwapInterval(bool vsync) {}
	override void makeContextCurrent() {}
	override string title() const @property { return "AndroidWindow"; }
	override void title(string value) @property {}

	package(gd.system.android) IVec2 m_size = IVec2(100, 100);
	override IVec2 size() const @property { return m_size; }
	override void size(IVec2 value) @property {}

	override WindowState state() const @property { return WindowState.Fullscreen; }
	override void state(WindowState value) @property {}
	override bool isClipboardAvailable(Clipboard clipboard) { return false; }
	override void[] getClipboardData(Clipboard clipboard, string mimeType) { return []; }
	override void setClipboardData(Clipboard clipboard, string mimeType, const(void)[] data) {}

}
