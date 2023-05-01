module gd.timer;
import gd.internal.application;
import std.datetime;

class Timer {

	private long id;
	private this() {}

	static Timer setTimer(Duration delay, void delegate() callback) {
		Timer result = new Timer;
		result.id = application.timer.setTimer(delay, callback);
		return result;
	}

	static Timer setInterval(Duration delay, void delegate() callback) {
		Timer result = new Timer;
		result.id = application.timer.setInterval(delay, callback);
		return result;
	}

	void cancel() {
		application.timer.cancel(id);
	}

}
