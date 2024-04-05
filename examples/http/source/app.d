import std.stdio;
import gd.net.http;
import gd.timer;
import gd.threading;

void main() {
	writeln(httpGet!char("https://www.google.com/"));
	writeln(httpPost!char("https://httpbin.org/post", "[\"a\", 2, 3]", "application/json"));
}
