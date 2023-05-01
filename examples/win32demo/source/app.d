import std.stdio;
import std.datetime;
import gd.internal.application;
import gd.timer;

void main() {
	writeln("Hi!");

	int counter = 0;
	Timer.setInterval(500.msecs, {
		writeln("interval run ", counter += 1);
	});

	application.startEventLoop();
}
