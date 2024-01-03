module gd.system.win32.timer;
import gd.system.win32.exception;
import gd.system.application;
import gd.system.timer;
import std.datetime;

version (gd_Win32):

import core.sys.windows.windows;
import std.conv;

private Win32Timer instance;

class Win32Timer : Timer {

	package(gd.system) this(Application application) {
		scope (failure) dispose();

		addDependency(application);

		assert(!instance);
		instance = this;
	}

	protected override void disposeImpl() {}

	private void delegate()[UINT_PTR] timerCallbacks;

	override long setTimer(Duration duration, void delegate() callback) {
		long timer;
		timer = setInterval(duration, {
			cancel(timer);
			callback();
		});
		return timer;
	}

	override long setInterval(Duration duration, void delegate() callback) {
		UINT_PTR timer = SetTimer(null, 0, duration.total!"msecs".to!uint, &timerProc);
		if (timer == 0)
			throw new Win32Exception("SetTimer", GetLastError());
		timerCallbacks[timer] = callback;
		return cast(long) timer;
	}

	override void cancel(long timer) {
		timerCallbacks.remove(cast(UINT_PTR) timer);
		KillTimer(null, timer);
	}

	override bool isActive() {
		return timerCallbacks.length > 0;
	}

	override void deactivate() {
		import std.array : array;

		foreach (timer; timerCallbacks.byKey.array) {
			cancel(timer);
		}
	}

	override void processEvents() {}

}

extern (Windows) void timerProc(HWND hwnd, UINT uMsg, UINT_PTR idEvent, DWORD dwTime) nothrow {
	safeCall(&timerProcD, hwnd, uMsg, idEvent, dwTime);
}

private void timerProcD(HWND hwnd, UINT uMsg, UINT_PTR idEvent, DWORD dwTime) {
	if (uMsg != WM_TIMER)
		return;

	if (auto callback = idEvent in instance.timerCallbacks)
		(*callback)();
}
