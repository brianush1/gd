module gd.system.android.timer;
import gd.system.application;
import gd.system.timer;
import std.datetime;

version (gd_Android):

import core.sys.linux.timerfd;
import core.sys.posix.signal;
import core.sys.posix.unistd;
import core.sys.posix.time;
import core.sys.linux.epoll;

class AndroidTimer : Timer {

	private int m_timerFd;
	int timerFd() const @property { return m_timerFd; }

	package(gd.system) this(Application application) {
		scope (failure) dispose();

		addDependency(application);

		m_timerFd = epoll_create1(0);
	}

	protected override void disposeImpl() {
		close(m_timerFd);
	}

	private {
		struct TimerInfo {
			int fd;
			void delegate() callback;
			bool isInterval;
		}

		TimerInfo[long] currentTimers;
	}

	private long createTimer(long nsDelay, long nsInterval, void delegate() callback) {
		import core.stdc.config : c_long;
		import std.random : uniform;

		TimerInfo info;
		info.callback = callback;
		info.isInterval = nsInterval != 0;
		info.fd = timerfd_create(CLOCK_REALTIME, TFD_NONBLOCK);

		itimerspec its;
		its.it_value.tv_sec = cast(time_t)(nsDelay / 1_000_000_000);
		its.it_value.tv_nsec = cast(c_long)(nsDelay % 1_000_000_000);
		its.it_interval.tv_sec = cast(time_t)(nsInterval / 1_000_000_000);
		its.it_interval.tv_nsec = cast(c_long)(nsInterval % 1_000_000_000);
		timerfd_settime(info.fd, 0, &its, null);

		epoll_event ev;
		ev.data.fd = info.fd;
		ev.events = EPOLLIN;
		epoll_ctl(m_timerFd, EPOLL_CTL_ADD, info.fd, &ev);

		currentTimers[cast(long) info.fd] = info;

		return cast(long) info.fd;
	}

	override long setTimer(Duration duration, void delegate() callback) {
		return createTimer(duration.total!"nsecs", 0, callback);
	}

	override long setInterval(Duration duration, void delegate() callback) {
		return createTimer(duration.total!"nsecs", duration.total!"nsecs", callback);
	}

	override void cancel(long timer) {
		if (TimerInfo* info = timer in currentTimers) {
			epoll_event ev;
			epoll_ctl(m_timerFd, EPOLL_CTL_DEL, info.fd, &ev);

			itimerspec its;
			timerfd_settime(info.fd, 0, &its, null);
			close(info.fd);
			currentTimers.remove(timer);
		}
	}

	override bool isActive() {
		return currentTimers.length > 0;
	}

	override void deactivate() {
		import std.array : array;

		foreach (id; currentTimers.byKey.array) {
			cancel(id);
		}
	}

	override void processEvents() {
		enum MAX_EPOLL_EVENTS = 16;
		epoll_event[MAX_EPOLL_EVENTS] eventBuf;
		while (true) {
			int numEvents = epoll_wait(m_timerFd, eventBuf.ptr, MAX_EPOLL_EVENTS, 0);
			if (numEvents == -1)
				break;

			epoll_event[] events = eventBuf[0 .. numEvents];

			foreach (ev; events) {
				long timerId = cast(long) ev.data.fd;
				if (TimerInfo* tinfo = timerId in currentTimers) {
					ulong times;
					ssize_t bytesRead = read(tinfo.fd, &times, times.sizeof);

					if (bytesRead != times.sizeof)
						continue;

					foreach (i; 0 .. times) {
						auto callback = tinfo.callback;

						if (!tinfo.isInterval) {
							cancel(timerId);
						}

						callback();
					}
				}
			}
		}
	}

}
