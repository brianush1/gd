module gd.system.win32.application;
import gd.system.win32.timer;
import gd.system.application;
import gd.system.display;
import gd.system.timer;
import gd.resource;

version (gd_Win32):

class Win32Application : Application {

	package(gd.system) this() {
		scope (failure) dispose();
	}

	protected override void disposeImpl() {}

	// private {
	// 	Win32Display m_display;

	// 	void initDisplay() {
	// 		m_display = new Win32Display(this);
	// 	}
	// }

	// override inout(Win32Display) display() inout @property {
	// 	if (!m_display) (cast() this).initDisplay();
	// 	return m_display;
	// }

	override inout(Display) display() inout @property {
		return null;
	}

	private {
		Win32Timer m_timer;

		void initTimer() {
			m_timer = new Win32Timer(this);
		}
	}

	override inout(Win32Timer) timer() inout @property {
		if (!m_timer) (cast() this).initTimer();
		return m_timer;
	}

	override bool isActive() {
		// if (m_display && m_display.isActive) return true;
		if (m_timer && m_timer.isActive) return true;
		return false;
	}

	override void deactivate() {
		// if (m_display) m_display.deactivate();
		if (m_timer) m_timer.deactivate();
	}

	override void waitForEvents() {
	}

	override void processEvents() {
	}

}
