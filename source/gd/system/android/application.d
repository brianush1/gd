module gd.system.android.application;
import gd.system.android.display;
import gd.system.android.timer;
import gd.system.application;
import gd.system.display;
import gd.system.timer;
import gd.system.socket;
import gd.system.ssl;
import gd.resource;

version (gd_Android):

import core.sys.linux.sys.signalfd;
import core.sys.linux.unistd;
import core.sys.linux.epoll;
import core.sys.posix.signal;

package enum MAX_EPOLL_EVENTS = 16;

class AndroidApplication : Application {

	private int m_epollFd;
	int epollFd() const @property { return m_epollFd; }

	package(gd.system) this() {
		scope (failure) dispose();

		m_epollFd = epoll_create1(0);
	}

	protected override void disposeImpl() {
		close(epollFd);
	}

	package {
		void addToPoll(int fd, int events = EPOLLIN) {
			epoll_event ev;
			ev.data.fd = fd;
			ev.events = events;
			epoll_ctl(epollFd, EPOLL_CTL_ADD, fd, &ev);
		}

		void modifyPoll(int fd, int events) {
			epoll_event ev;
			ev.data.fd = fd;
			ev.events = events;
			epoll_ctl(epollFd, EPOLL_CTL_MOD, fd, &ev);
		}

		void removeFromPoll(int fd) {
			epoll_event ev;
			epoll_ctl(epollFd, EPOLL_CTL_DEL, fd, &ev);
		}
	}

	private {
		AndroidDisplay m_display;

		void initDisplay() {
			m_display = new AndroidDisplay(this);
		}
	}

	override inout(AndroidDisplay) display() inout @property {
		if (!m_display) (cast() this).initDisplay();
		return m_display;
	}

	private {
		AndroidTimer m_timer;

		void initTimer() {
			m_timer = new AndroidTimer(this);
			addToPoll(m_timer.timerFd);
		}
	}

	override inout(AndroidTimer) timer() inout @property {
		if (!m_timer) (cast() this).initTimer();
		return m_timer;
	}

	private SocketManager m_socketManager;
	override inout(SocketManager) socketManager() inout @property {
		return null;
	}

	private SSLManager m_sslManager;
	override inout(SSLManager) sslManager() inout @property {
		return null;
	}

	private bool deactivated = false;

	override bool isActive() {
		if (deactivated) return false;
		if (m_display && m_display.isActive) return true;
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

	package epoll_event[] epollEvents;

	override void processEvents(bool wait = true) {
		if (m_display) {
			// X11.flush(m_display.native);
			// if (m_display.invalidationQueue.length != 0)
			// 	wait = false; // don't wait around if we have an invalidated window
		}

		epoll_event[MAX_EPOLL_EVENTS] eventBuf;
		int numEvents = epoll_wait(epollFd, eventBuf.ptr, MAX_EPOLL_EVENTS, wait ? -1 : 0);
		if (numEvents == -1)
			epollEvents = null;
		else
			epollEvents = eventBuf[0 .. numEvents];

		if (m_display) m_display.processEvents();
		if (m_timer) m_timer.processEvents();
		if (m_socketManager) m_socketManager.processEvents();
	}

}
