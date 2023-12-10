import std.stdio;
import std.datetime;
import gd.timer;

void main() {
	int counter = 0;
	Timer.setInterval(1000.msecs, {
		counter += 1;
		writeln(counter, " second", counter == 1 ? " has" : "s have", " passed");
	});
}
