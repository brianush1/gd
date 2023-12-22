import std.stdio;
import std.datetime;
import gd.timer;

void main() {
	foreach (i, msg; ["Ready...", "Set...", "Go!"]) {
		if (i) Timer.wait(2.seconds);
		writeln(msg);
	}

	int counter = 0;
	Timer.setInterval(1000.msecs, {
		counter += 1;
		writeln(counter, " second", counter == 1 ? " has" : "s have", " passed");
	});
}
