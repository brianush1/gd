module gd.system.win32.application;
import gd.system.win32.display;
import gd.system.win32.socket;
import gd.system.win32.timer;
import gd.system.win32.sslmanager;
import gd.system.application;
import gd.system.display;
import gd.system.socket;
import gd.system.timer;
import gd.resource;

version (gd_Win32):

import core.sys.windows.windows;

class Win32Application : Application {

	package(gd.system) this() {
		scope (failure) dispose();
	}

	protected override void disposeImpl() {}

	private {
		Win32Display m_display;

		void initDisplay() {
			m_display = new Win32Display(this);
		}
	}

	override inout(Win32Display) display() inout @property {
		if (!m_display) (cast() this).initDisplay();
		return m_display;
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

	private {
		Win32SocketManager m_socketManager;

		void initSocketManager() {
			m_socketManager = new Win32SocketManager(this);
		}
	}

	override inout(Win32SocketManager) socketManager() inout @property {
		if (!m_socketManager) (cast() this).initSocketManager();
		return m_socketManager;
	}

	private {
		Win32SSLManager m_sslManager;

		void initSSLManager() {
			m_sslManager = new Win32SSLManager(this);
		}
	}

	override inout(Win32SSLManager) sslManager() inout @property {
		if (!m_sslManager) (cast() this).initSSLManager();
		return m_sslManager;
	}

	private bool deactivated = false;

	override bool isActive() {
		if (deactivated) return false;
		if (m_display && m_display.isActive) return true;
		if (m_timer && m_timer.isActive) return true;
		if (m_timer && m_timer.isActive) return true;
		if (m_socketManager && m_socketManager.isActive) return true;
		return false;
	}

	override void deactivate() {
		if (m_display) m_display.deactivate();
		if (m_timer) m_timer.deactivate();
		if (m_socketManager) m_socketManager.deactivate();
		deactivated = true;
	}

	override void processEvents(bool wait = true) {
		if (wait)
			WaitMessage();

		while (true) {
			MSG msg;
			auto read = PeekMessage(&msg, null, 0, 0, PM_REMOVE);
			if (!read)
				break;
			// TODO: do we check for resizing here to avoid resize blocks?
			TranslateMessage(&msg);
			DispatchMessage(&msg);
		}

		if (m_display) m_display.processEvents();
		if (m_timer) m_timer.processEvents();
		if (m_socketManager) m_socketManager.processEvents();
	}

}
