module gd.net.udp;
import gd.net.address;
import gd.system.application;
import gd.system.socket;
import gd.signal;
import std.exception;

class UdpSocket {

	private Socket socket;

	Signal!(Address, ubyte[]) onReceive;

	bool closed() const @property => socket.disposed;

	this(string hostname, ushort port) {
		this(resolveAddress(hostname, port)[0].address);
	}

	this(Address address) {
		this(application.socketManager.createSocket(address.family, SocketProtocol.UDP));
		socket.bind(address);
	}

	private this(Socket socket) {
		this.socket = socket;
		socket.onReceive.connect(&onReceive.emit);
	}

	void close() {
		socket.dispose();
	}

	size_t sendTo(Address address, const(void)[] data) {
		enforce(!closed, "connection is closed");
		return socket.sendTo(address, data);
	}

}
