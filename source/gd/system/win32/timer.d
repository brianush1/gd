module gd.system.win32.timer;
import gd.system.application;
import gd.system.timer;
import std.datetime;

version (gd_Win32):

import core.sys.windows.winbase;
import core.sys.windows.winuser;

class Win32Timer : Timer {

	package(gd.system) this(Application application) {
		scope (failure) dispose();

		addDependency(application);
	}

	protected override void disposeImpl() {}

	private long createTimer(long nsDelay, long nsInterval, void delegate() callback) {
		return 0;
	}

	override long setTimer(Duration duration, void delegate() callback) {
		return createTimer(duration.total!"nsecs", 0, callback);
	}

	override long setInterval(Duration duration, void delegate() callback) {
		return createTimer(duration.total!"nsecs", duration.total!"nsecs", callback);
	}

	override void cancel(long timer) {
	}

	override bool isActive() {
		return false;
	}

	override void deactivate() {
	}

	override void processEvents() {
	}

}
