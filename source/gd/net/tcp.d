module gd.net.tcp;
import gd.net.address;
import gd.system.application;
import gd.system.socket;
import gd.system.ssl;
import gd.signal;
import gd.timer;
import std.exception;

struct ConnectionOptions {
	bool secure = false;
	bool verifyPeer = true;
	string hostname;

	ConnectionOptions addHostname(string value) {
		ConnectionOptions res = this;
		if (res.hostname == "")
			res.hostname = value;
		return res;
	}
}

class TcpClient {

	private Socket socket;

	Signal!() onClose;
	Signal!(ubyte[]) onReceive;

	bool closed() const @property => socket.disposed;

	this(string hostname, ushort port, ConnectionOptions options = ConnectionOptions()) {
		this(resolveAddress(hostname, port)[0].address, options.addHostname(hostname));
	}

	this(Address address, ConnectionOptions options = ConnectionOptions()) {
		this(application.socketManager.createSocket(address.family, SocketProtocol.TCP));
		sslInit(options);
		socket.connect(address);
		sslConnect(options);
	}

	this(Duration timeout, string hostname, ushort port, ConnectionOptions options = ConnectionOptions()) {
		// TODO: timeout the address resolution, too
		this(timeout, resolveAddress(hostname, port)[0].address, options.addHostname(hostname));
	}

	this(Duration timeout, Address address, ConnectionOptions options = ConnectionOptions()) {
		this(application.socketManager.createSocket(address.family, SocketProtocol.TCP));
		sslInit(options);

		// HACK: create an throw the exception out here to generate the proper stack trace
		Exception timeoutException = new Exception("connection timed out");
		try { throw timeoutException; } catch (Exception ex) {}

		Timer timer = Timer.setTimer(timeout, {
			socket.dispose();
			throw timeoutException;
		});
		socket.connect(address);
		sslConnect(options);
		timer.cancel();
	}

	private this(Socket socket) {
		this.socket = socket;
		socket.onReceive.connect((Address from, ubyte[] buffer) {
			onReceive.emit(buffer.dup);
		});
		socket.onHangup.connect(&onClose.emit);
	}

	void close() {
		onClose.emit();
		socket.dispose();
	}

	size_t send(const(void)[] data) {
		enforce(!closed, "connection is closed");
		return ssl ? ssl.send(data) : socket.send(data);
	}

	void sendFull(const(void)[] data) {
		while (true) {
			enforce(!closed, "connection is closed");
			data = data[send(data) .. $];
			if (data.length == 0)
				break;

			socket.onWriteAvailable.wait();
		}
	}

	private {
		SSLInfo ssl;

		void sslInit(ConnectionOptions options) {
			if (!options.secure)
				return;

			ssl = application.sslManager.initSSL(socket, options.verifyPeer, options.hostname);
		}

		void sslConnect(ConnectionOptions options) {
			if (!options.secure)
				return;

			ssl.connect();
			socket.onReadAvailable.connect({
				ubyte[] buffer = ssl.read();
				if (buffer.length > 0)
					onReceive.emit(buffer);
			});
		}
	}

}

class TcpServer {

	private Socket socket;

	Signal!() onClose;
	Signal!TcpClient onNewClient;

	bool closed() const @property => socket.disposed;

	this(string hostname, ushort port) {
		this(resolveAddress(hostname, port)[0].address);
	}

	this(Address address) {
		this(address, 128);
	}

	this(Address address, int backlog) {
		socket = application.socketManager.createSocket(address.family, SocketProtocol.TCP);
		socket.onAccept.connect((Socket clientSocket) {
			onNewClient.emit(new TcpClient(clientSocket));
		});
		socket.onHangup.connect(&onClose.emit);
		socket.bind(address);
		socket.listen(backlog);
	}

	void close() {
		onClose.emit();
		socket.dispose();
	}

}
