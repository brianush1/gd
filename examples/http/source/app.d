import std.stdio;
import gd.net.http;
import gd.timer;
import gd.threading;

void main() {
	HttpClient client = new HttpClient();
	HttpRequestOptions options;
	options.acceptedEncodings = HttpCompression.None;
	HttpRequest req = client.request("https://google.com/", HttpMethod.GET, options);
	ubyte[] total;
	req.onStatusReceived.connect((StatusLine status) {
		writeln(status);
	});
	req.onHeaderReceived.connect((Header header) {
		writeln(header);
	});
	req.onChunkReceived.connect((ubyte[] data) {
		total ~= data;
		// write(cast(string) data);
	});
	req.onClose.connect({
		writeln("finished:");
		writeln(cast(string) total);
	});

	writeln(httpGet!char("https://www.google.com/"));
	writeln(httpPost!char("https://httpbin.org/post", "[\"a\", 2, 3]", "application/json"));
}
