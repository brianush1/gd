module gd.net.tcp;
import gd.net.address;
import gd.system.application;
import gd.system.socket;
import gd.signal;
import gd.timer;
import std.exception;

class TcpClient {

	private Socket socket;

	Signal!() onClose;
	Signal!(ubyte[]) onReceive;

	bool closed() const @property => socket.disposed;

	this(string hostname, ushort port) {
		this(resolveAddress(hostname, port)[0].address);
	}

	this(Address address) {
		this(application.socketManager.createSocket(address.family, SocketProtocol.TCP));
		socket.connect(address);
	}

	this(Duration timeout, string hostname, ushort port) {
		// TODO: timeout the address resolution, too
		this(timeout, resolveAddress(hostname, port)[0].address);
	}

	this(Duration timeout, Address address) {
		this(application.socketManager.createSocket(address.family, SocketProtocol.TCP));

		// HACK: create an throw the exception out here to generate the proper stack trace
		Exception timeoutException = new Exception("connection timed out");
		try { throw timeoutException; } catch (Exception ex) {}

		Timer timer = Timer.setTimer(timeout, {
			socket.dispose();
			throw timeoutException;
		});
		socket.connect(address);
		timer.cancel();
	}

	private this(Socket socket) {
		this.socket = socket;
		socket.onReceive.connect((Address from, ubyte[] buffer) {
			onReceive.emit(buffer);
		});
		socket.onHangup.connect(&onClose.emit);
	}

	void close() {
		onClose.emit();
		socket.dispose();
	}

	size_t send(const(void)[] data) {
		enforce(!closed, "connection is closed");
		return socket.send(data);
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
