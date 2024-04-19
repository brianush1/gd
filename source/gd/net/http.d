module gd.net.http;
import gd.net.tcp;
import gd.net.url;
import gd.net.address;
import gd.net.exception;
import gd.timer;
import gd.signal;
import core.thread;
import core.atomic;
import std.exception;
import std.string;
import std.conv;
import std.zlib;

enum HttpMethod : string {
	OPTIONS = "OPTIONS",
	GET = "GET",
	HEAD = "HEAD",
	POST = "POST",
	PUT = "PUT",
	DELETE = "DELETE",
	TRACE = "TRACE",
	CONNECT = "CONNECT",
}

struct Header {
	string name, value;

	static Header parse(string line) {
		ptrdiff_t delim = line.indexOf(": ");
		enforce(delim != -1);

		Header result;
		result.name = line[0 .. delim];
		result.value = line[delim + 2 .. $];
		return result;
	}
}

struct StatusLine {
	int statusCode;
	string statusText;
	string httpVersion;

	static StatusLine parse(string line) {
		import std.algorithm : countUntil;

		ptrdiff_t delim1 = line.countUntil(" ");
		enforce(delim1 != -1);

		ptrdiff_t delim2 = delim1 + 1 + line[delim1 + 1 .. $].countUntil(" ");
		enforce(delim2 != -1);

		StatusLine result;
		result.httpVersion = line[0 .. delim1];
		result.statusCode = line[delim1 + 1 .. delim2].to!int;
		result.statusText = line[delim2 + 1 .. $];
		return result;
	}
}

class HttpRequest {
	Signal!StatusLine onStatusReceived;
	Signal!Header onHeaderReceived;
	Signal!(ubyte[]) onChunkReceived;
	Signal!() onClose;

	private {
		TcpClient client;

		this(TcpClient client) {
			this.client = client;
		}
	}

	void write(const(void)[] data) {
		client.sendFull(data);
	}
}

enum HttpCompression {
	None = 0,
	GZip = 0b01,
	Deflate = 0b10,
	All = 0b11,
}

struct HttpRequestOptions {
	HttpCompression acceptedEncodings = HttpCompression.All;
	bool keepAlive = false;
	Header[] headers;
}

class HttpClient {

	HttpRequest request(string url, HttpMethod method, HttpRequestOptions options = HttpRequestOptions()) => request(URL(url), method, options);
	HttpRequest request(URL url, HttpMethod method, HttpRequestOptions options = HttpRequestOptions()) {
		enforce(url.protocol == "http:" || url.protocol == "https:", "URL must be http or https");
		Address address = resolveAddress(url.hostname, cast(ushort) url.effectivePort)[0].address;

		ConnectionOptions tcpOptions;
		tcpOptions.secure = url.protocol == "https:";
		tcpOptions.verifyPeer = true;
		tcpOptions.hostname = url.hostname;

		TcpClient client = new TcpClient(address, tcpOptions);

		HttpRequest request = new HttpRequest(client);

		enum ReceiveState {
			Status,
			Headers,
			Content,
		}

		ReceiveState state = ReceiveState.Status;
		ubyte[] headerLine;

		bool chunked = false;
		HttpCompression compression = HttpCompression.None;

		UnCompress decompressor;

		void handleHeader(Header header) {
			header.name = header.name.toLower;
			if (header.name == "transfer-encoding") {
				if (header.value == "chunked") {
					chunked = true;
				}
				else {
					throw new NetworkException("unrecognized value for Transfer-Encoding");
				}
			}
			else if (header.name == "content-encoding") {
				if (header.value == "gzip" && (options.acceptedEncodings & HttpCompression.GZip) != 0) {
					compression = HttpCompression.GZip;
					decompressor = new UnCompress(HeaderFormat.gzip);
				}
				else if (header.value == "deflate" && (options.acceptedEncodings & HttpCompression.Deflate) != 0) {
					compression = HttpCompression.Deflate;
					decompressor = new UnCompress(HeaderFormat.deflate);
				}
				else {
					throw new NetworkException("unrecognized value for Content-Encoding");
				}
			}
		}

		enum ChunkState {
			Length,
			LengthCR,
			Body,
			BodyCR,
		}

		ChunkState chunkState = ChunkState.Length;
		size_t chunkLength = 0;

		void handleTransferData(ubyte[] data) {
			if (decompressor is null) {
				request.onChunkReceived.emit(data);
			}
			else {
				const(void)[] data_ = decompressor.uncompress(data);
				if (data_ != [])
					request.onChunkReceived.emit((cast(const(ubyte)[]) data_).dup);
			}
		}

		void finishData() {
			if (decompressor) {
				const(void)[] data = decompressor.flush();
				if (data != [])
					request.onChunkReceived.emit((cast(const(ubyte)[]) data).dup);
			}
		}

		void handleData(ubyte[] data) {
			if (chunked) {
				ubyte[] chunkData;
				foreach (b; data) {
					final switch (chunkState) {
					case ChunkState.Length:
						if (b == 13) {
							chunkState = ChunkState.LengthCR;
							break;
						}

						enforce!NetworkException(0
								|| (b >= '0' && b <= '9')
								|| (b >= 'a' && b <= 'f')
								|| (b >= 'A' && b <= 'F'),
							"expected chunk length in hexadecimal",
						);

						chunkLength *= 16;
						if (b >= '0' && b <= '9')
							chunkLength += b - '0';
						else if (b >= 'a' && b <= 'f')
							chunkLength += 10 + (b - 'a');
						else if (b >= 'A' && b <= 'F')
							chunkLength += 10 + (b - 'A');

						break;
					case ChunkState.LengthCR:
						enforce!NetworkException(b == 10, "expected CRLF to end chunk length");
						chunkState = ChunkState.Body;
						break;
					case ChunkState.Body:
						if (chunkLength == 0) {
							enforce!NetworkException(b == 13, "expected CR after chunk data");
							chunkState = ChunkState.BodyCR;
						}
						else {
							chunkLength -= 1;
							chunkData.assumeSafeAppend ~= b;
						}

						break;
					case ChunkState.BodyCR:
						enforce!NetworkException(b == 10, "expected CRLF to end chunk data");
						chunkState = ChunkState.Length;
						break;
					}
				}

				if (chunkData != [])
					handleTransferData(chunkData);
			}
			else {
				handleTransferData(data);
			}
		}

		void processChunk(ubyte[] chunk) {
			final switch (state) {
			case ReceiveState.Status:
			case ReceiveState.Headers:
				foreach (index, b; chunk) {
					if (b == '\n' && headerLine[$ - 1] == '\r') {
						headerLine = headerLine[0 .. $ - 1];

						if (headerLine == []) {
							state = ReceiveState.Content;
							processChunk(chunk[index + 1 .. $]);
							break;
						}
						else if (state == ReceiveState.Status) {
							state = ReceiveState.Headers;
							request.onStatusReceived.emit(StatusLine.parse((cast(char[]) headerLine).idup));
						}
						else if (state == ReceiveState.Headers) {
							Header header = Header.parse((cast(char[]) headerLine).idup);
							handleHeader(header);
							request.onHeaderReceived.emit(header);
						}

						headerLine = [];
					}
					else {
						headerLine.assumeSafeAppend ~= b;
					}
				}
				break;
			case ReceiveState.Content:
				if (chunk != [])
					handleData(chunk);
				break;
			}
		}

		client.onReceive.connect(&processChunk);

		client.onClose.connect({
			finishData();
			request.onClose.emit();
		});

		Header[] headers;

		headers ~= Header("Host", url.host);
		headers ~= Header("Connection", options.keepAlive ? "keep-alive" : "close");

		string[] acceptEncoding;
		if (options.acceptedEncodings & HttpCompression.GZip) acceptEncoding ~= "gzip";
		if (options.acceptedEncodings & HttpCompression.Deflate) acceptEncoding ~= "deflate";
		if (acceptEncoding.length > 0)
			headers ~= Header("Accept-Encoding", acceptEncoding.join(", "));

		headers ~= options.headers;

		string data;
		data ~= text(method, " ", url.pathname, url.query, " HTTP/1.1\r\n");
		foreach (header; headers)
			data ~= text(header.name, ": ", header.value, "\r\n");
		data ~= "\r\n";

		client.sendFull(data);

		return request;
	}

}

private HttpClient m_defaultClient;

HttpClient defaultClient() {
	if (m_defaultClient is null)
		m_defaultClient = new HttpClient();
	return m_defaultClient;
}

T[] httpGet(T)(string url) if (is(T == ubyte) || is(T == char)) {
	HttpRequest req = defaultClient.request(url, HttpMethod.GET);
	T[] result;
	req.onChunkReceived.connect((ubyte[] chunk) { result ~= cast(T[]) chunk; });
	req.onClose.wait();
	return result;
}

T[] httpPost(T)(string url, const(void)[] data, string contentType = "application/x-www-form-urlencoded") if (is(T == ubyte) || is(T == char)) {
	HttpRequestOptions options;
	options.headers ~= Header("Content-Type", contentType);
	options.headers ~= Header("Content-Length", data.length.to!string);
	HttpRequest req = defaultClient.request(url, HttpMethod.POST, options);
	req.write(data);
	T[] result;
	req.onChunkReceived.connect((ubyte[] chunk) { result ~= cast(T[]) chunk; });
	req.onClose.wait();
	return result;
}
