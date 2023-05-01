module gd.internal.timer;
import gd.resource;
import std.datetime;

abstract class Timer : Resource {

	abstract long setTimer(Duration duration, void delegate() callback);
	abstract long setInterval(Duration duration, void delegate() callback);
	abstract void cancel(long timer);

	abstract bool isActive();
	abstract void deactivate();
	abstract void processEvents();

}
