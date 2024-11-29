module gd.system.android.display;
import gd.system.android.window;
import gd.system.android.exception;
import gd.system.application;
import gd.system.display;
import gd.system.window;
import gd.resource;
import gd.keycode;
import gd.math;

version (gd_Android):

class AndroidDisplay : Display {

	package(gd.system) this(Application application) {
		scope (failure) dispose();

		addDependency(application);

		m_mainWindow = new AndroidWindow(this);
	}

	protected override void disposeImpl() {}

	private AndroidWindow m_mainWindow;
	inout(AndroidWindow) mainWindow() inout @property => m_mainWindow;

	private bool createdWindow = false;
	override AndroidWindow createWindow(WindowInitOptions options) {
		if (createdWindow) {
			throw new AndroidException("cannot create multiple windows on Android");
		}

		createdWindow = true;
		return mainWindow;
	}

	override Cursor createCursor(IVec2 size, const(uint)[] data, IVec2 hotspot) => null;
	override Cursor createXorCursor(IVec2 size, const(uint)[] data, IVec2 hotspot) => null;
	override Modifiers getCurrentModifiers() => Modifiers.None;

	override bool isActive() {
		return true;
	}

	override void deactivate() {}

	override void processEvents() {}

}
