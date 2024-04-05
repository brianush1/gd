module gd.net.http;
import gd.timer;
static import std.net.curl;
import core.thread;
import core.atomic;

// TODO: switch to using curl_multi_perform instead of spawning new threads

T[] httpGet(T)(string url) if (is(T == ubyte) || is(T == char)) {
	bool finished = false;
	T[] result;
	Exception ex;

	Thread thr = new Thread({
		try {
			T[] data = std.net.curl.get!(std.net.curl.AutoProtocol, T)(url);
			result = data;
		}
		catch (Exception caughtEx) {
			ex = caughtEx;
		}

		atomicStore(finished, true);
	});
	thr.isDaemon = true;
	thr.start();

	while (!finished) // HACK
		Timer.wait(0.05);

	if (ex !is null)
		throw ex;

	return result;
}

T[] httpPost(T)(string url, const(void)[] data, string contentType = "application/x-www-form-urlencoded") if (is(T == ubyte) || is(T == char)) {
	bool finished = false;
	T[] result;
	Exception ex;

	Thread thr = new Thread({
		try {
			auto http = std.net.curl.HTTP();
			http.addRequestHeader("Content-Type", contentType);

			T[] data = std.net.curl.post!T(url, data, http);
			result = data;
		}
		catch (Exception caughtEx) {
			ex = caughtEx;
		}

		atomicStore(finished, true);
	});
	thr.isDaemon = true;
	thr.start();

	while (!finished) // HACK
		Timer.wait(0.05);

	if (ex !is null)
		throw ex;

	return result;
}
