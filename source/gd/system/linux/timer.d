module gd.system.linux.timer;
import gd.system.linux.rtsignal;
import gd.system.application;
import gd.system.timer;
import std.datetime;

version (gd_Linux):

import core.sys.linux.sys.signalfd;
import core.sys.posix.signal;
import core.sys.posix.unistd;
import core.sys.posix.time;

// TODO: switch to using timerfd
// TODO: check for errors on all the system calls

class LinuxTimer : Timer {

	int signalFd() const @property { return m_signalFd; }

	int timerSignal() const @property { return m_timerSignal; }

	package(gd.system) this(Application application) {
		scope (failure) dispose();

		addDependency(application);
	}

	protected override void disposeImpl() {}

	private {
		struct TimerInfo {
			timer_t id;
			void delegate() callback;
			bool isInterval;
		}

		TimerInfo[long] currentTimers;
	}

	private long createTimer(long nsDelay, long nsInterval, void delegate() callback) {
		import core.stdc.config : c_long;
		import std.random : uniform;

		long result;

		do {
			// would be nice to use the whole long range
			// but we're limited by the size of sigevent.sigev_value.sival_int
			result = uniform!"[]"(0, int.max);

			// so instead, we can only have 2^31 timers active at once
			// which is still pretty good
		}
		while (result in currentTimers);

		TimerInfo info;
		info.callback = callback;
		info.isInterval = nsInterval != 0;

		sigevent sev;
		sev.sigev_notify = SIGEV_SIGNAL;
		sev.sigev_signo = timerSignal;
		sev.sigev_value.sival_int = cast(int) result;
		timer_create(CLOCK_REALTIME, &sev, &info.id);

		itimerspec its;
		its.it_value.tv_sec = cast(time_t)(nsDelay / 1_000_000_000);
		its.it_value.tv_nsec = cast(c_long)(nsDelay % 1_000_000_000);
		its.it_interval.tv_sec = cast(time_t)(nsInterval / 1_000_000_000);
		its.it_interval.tv_nsec = cast(c_long)(nsInterval % 1_000_000_000);
		timer_settime(info.id, 0, &its, null);

		currentTimers[result] = info;

		return result;
	}

	override long setTimer(Duration duration, void delegate() callback) {
		return createTimer(duration.total!"nsecs", 0, callback);
	}

	override long setInterval(Duration duration, void delegate() callback) {
		return createTimer(duration.total!"nsecs", duration.total!"nsecs", callback);
	}

	override void cancel(long timer) {
		if (TimerInfo* info = timer in currentTimers) {
			itimerspec its;
			timer_settime(info.id, 0, &its, null);
			timer_delete(info.id);
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
		while (true) {
			signalfd_siginfo info;
			ssize_t bytesRead = read(signalFd, &info, info.sizeof);

			if (bytesRead == signalfd_siginfo.sizeof) {
				long id = cast(long) info.ssi_int;
				if (TimerInfo* tinfo = id in currentTimers) {
					auto callback = tinfo.callback;

					if (!tinfo.isInterval) {
						cancel(id);
					}

					callback();
				}
			}
			else {
				break;
			}
		}
	}

}
