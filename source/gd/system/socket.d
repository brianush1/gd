module gd.system.socket;
import gd.net.address;
import gd.resource;
import gd.signal;

abstract class SocketManager : Resource {

	abstract bool isActive();
	abstract void deactivate();
	abstract void processEvents();

	abstract Socket createSocket(AddressFamily family, SocketProtocol protocol);
	abstract AddressInfo[] resolve(string address);

}

enum SocketProtocol {
	TCP,
	UDP,
}

abstract class Socket : Resource {

	Signal!() onHangup;

	/++

	Called whenever data is received on the socket. Note that the buffer is not guaranteed
	to be alive after the signal has finished being emitted!!

	+/
	Signal!(Address, ubyte[]) onReceive;

	Signal!Socket onAccept;

	abstract void bind(Address address);
	abstract void listen(int backlog);
	abstract void connect(Address address);
	abstract size_t send(const(void)[] buffer);
	abstract size_t sendTo(Address address, const(void)[] buffer);

}
