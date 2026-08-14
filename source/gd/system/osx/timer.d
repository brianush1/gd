module gd.system.osx.timer;
import gd.system.osx.bindings;
import gd.system.application;
import gd.system.timer;
import std.datetime;

version (gd_OSX):

import core.attribute : selector;

class OSXTimer : Timer {
	private struct TimerInfo {
		void* native;
		void* target;
		void delegate() callback;
		bool repeats;
	}

	private TimerInfo[long] timers;
	private long nextId;

	package(gd.system) this(Application application) {
		scope (failure) dispose();
		addDependency(application);
	}

	protected override void disposeImpl() {
		deactivate();
	}

	private long createTimer(Duration duration, bool repeats, void delegate() callback) {
		long id = ++nextId;
		OSXTimerTarget target = OSXTimerTarget.alloc.init;
		target.manager = this;
		target.id = id;

		double seconds = duration.total!"hnsecs" / 10_000_000.0;
		NSTimer native = NSTimer.scheduledTimer(
			seconds,
			cast(NSid) target,
			sel_registerName("timerFired:"),
			null,
			repeats,
		);
		timers[id] = TimerInfo(cast(void*) native, cast(void*) target, callback, repeats);
		return id;
	}

	override long setTimer(Duration duration, void delegate() callback) {
		return createTimer(duration, false, callback);
	}

	override long setInterval(Duration duration, void delegate() callback) {
		return createTimer(duration, true, callback);
	}

	override void cancel(long timer) {
		if (TimerInfo* info = timer in timers) {
			NSTimer native = cast(NSTimer) info.native;
			OSXTimerTarget target = cast(OSXTimerTarget) info.target;
			native.invalidate();
			target.manager = null;
			target.release();
			timers.remove(timer);
		}
	}

	package void fire(long id) {
		TimerInfo* info = id in timers;
		if (!info)
			return;

		void delegate() callback = info.callback;
		if (!info.repeats)
			cancel(id);
		callback();
	}

	override bool isActive() {
		return timers.length != 0;
	}

	override void deactivate() {
		import std.array : array;

		foreach (id; timers.byKey.array)
			cancel(id);
	}

	override void processEvents() {}
}

extern (Objective-C) class OSXTimerTarget : NSObject {
	override static OSXTimerTarget alloc() @selector("alloc");
	override OSXTimerTarget init() @selector("init");

	OSXTimer manager;
	long id;

	void timerFired(NSid timer) @selector("timerFired:") {
		if (manager)
			manager.fire(id);
	}
}
