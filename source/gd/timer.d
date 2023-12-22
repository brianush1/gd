module gd.timer;
import gd.system.application;
import std.datetime;
import core.thread.fiber;

public import std.datetime : Duration, dur,
	weeks, days, hours, minutes, seconds, msecs, usecs, hnsecs, nsecs;

class Timer {

	private long id;
	private this() {}

	static Timer setTimer(double delayInSeconds, void delegate() callback) {
		Duration dur = hnsecs(cast(long)(delayInSeconds * 1.convert!("seconds", "hnsecs")));
		return setTimer(dur, callback);
	}

	static Timer setInterval(double delayInSeconds, void delegate() callback) {
		Duration dur = hnsecs(cast(long)(delayInSeconds * 1.convert!("seconds", "hnsecs")));
		return setInterval(dur, callback);
	}

	static void wait(double delayInSeconds) {
		Duration dur = hnsecs(cast(long)(delayInSeconds * 1.convert!("seconds", "hnsecs")));
		wait(dur);
	}

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

	static void wait(Duration delay) {
		Fiber fiber = Fiber.getThis;

		setTimer(delay, {
			fiber.call();
		});

		Fiber.yield();
	}

	void cancel() {
		application.timer.cancel(id);
	}

}
