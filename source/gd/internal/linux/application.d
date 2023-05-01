module gd.internal.linux.application;
import gd.internal.linux.timer;
import gd.internal.x11.display;
import gd.internal.application;
import gd.internal.display;
import gd.resource;

version (gd_Linux):

import gd.bindings.x11;
import core.sys.linux.sys.signalfd;
import core.sys.linux.unistd;
import core.sys.linux.epoll;
import core.sys.posix.signal;

class LinuxApplication : Application {

	private int m_epollFd;
	int epollFd() const @property { return m_epollFd; }

	package(gd.internal) this() {
		scope (failure) dispose();

		m_epollFd = epoll_create1(0);
	}

	private void addToPoll(int fd, int events = EPOLLIN) {
		epoll_event ev;
		ev.data.fd = fd;
		ev.events = events;
		epoll_ctl(epollFd, EPOLL_CTL_ADD, ev.data.fd, &ev);
	}

	private {
		X11Display m_display;

		void initDisplay() {
			m_display = new X11Display(this);
			addToPoll(X11.connectionNumber(m_display.native));
		}
	}

	override inout(X11Display) display() inout @property {
		if (!m_display) (cast() this).initDisplay();
		return m_display;
	}

	private {
		LinuxTimer m_timer;

		void initTimer() {
			m_timer = new LinuxTimer(this);
			addToPoll(m_timer.signalFd);
		}
	}

	override inout(LinuxTimer) timer() inout @property {
		if (!m_timer) (cast() this).initTimer();
		return m_timer;
	}

	protected override void disposeImpl() {
		close(epollFd);
	}

	override bool isActive() {
		if (m_display && m_display.isActive) return true;
		if (m_timer && m_timer.isActive) return true;
		return false;
	}

	override void deactivate() {
		if (m_display) m_display.deactivate();
		if (m_timer) m_timer.deactivate();
	}

	override void waitForEvents() {
		if (m_display) X11.flush(m_display.native);

		epoll_event[] events = new epoll_event[1];
		epoll_wait(epollFd, events.ptr, cast(int) events.length, -1);
	}

	override void processEvents() {
		if (m_display) m_display.processEvents();
		if (m_timer) m_timer.processEvents();
	}

}
