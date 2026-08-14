module gd.system.osx.socket;
import gd.system.osx.application;
import gd.system.osx.corefoundation;
import gd.system.socket;
import gd.net.address;
import gd.resource;

version (gd_OSX):

import core.stdc.errno;
import core.sys.posix.fcntl;
import core.sys.posix.netdb;
import core.sys.posix.netinet.in_;
import core.sys.posix.sys.socket;
import core.sys.posix.unistd;
import core.thread.fiber;
import std.sumtype;

class OSXSocketManager : SocketManager {
	private OSXApplication application;
	private OSXSocket[int] socketsByFd;

	package(gd.system) this(OSXApplication application) {
		scope (failure) dispose();
		addDependency(application);
		this.application = application;
	}

	protected override void disposeImpl() {
		deactivate();
	}

	override OSXSocket createSocket(AddressFamily family, SocketProtocol protocol) {
		int nativeFamily;
		int nativeType;

		final switch (family) {
		case AddressFamily.IPv4:
			nativeFamily = AF_INET;
			break;
		case AddressFamily.IPv6:
			nativeFamily = AF_INET6;
			break;
		}

		final switch (protocol) {
		case SocketProtocol.TCP:
			nativeType = SOCK_STREAM;
			break;
		case SocketProtocol.UDP:
			nativeType = SOCK_DGRAM;
			break;
		}

		int fd = socket(nativeFamily, nativeType, 0);
		if (fd == -1)
			throw socketException("create", errno);

		int attributes = fcntl(fd, F_GETFL, 0);
		if (attributes == -1 || fcntl(fd, F_SETFL, attributes | O_NONBLOCK) == -1) {
			int error = errno;
			close(fd);
			throw socketException("set nonblocking", error);
		}

		return new OSXSocket(this, fd, family, protocol);
	}

	override AddressInfo[] resolve(string address) {
		import std.string : fromStringz, toStringz;

		AddressInfo[] result;
		addrinfo* head;
		scope (exit) if (head) freeaddrinfo(head);

		addrinfo hints;
		hints.ai_family = AF_UNSPEC;
		hints.ai_socktype = SOCK_STREAM;
		hints.ai_flags = AI_CANONNAME;

		int error = getaddrinfo(address.toStringz, null, &hints, &head);
		if (error != 0)
			throw new Exception("name resolution failed: " ~ gai_strerror(error).fromStringz.idup);

		string canonicalName = head.ai_canonname ? head.ai_canonname.fromStringz.idup : address;
		for (addrinfo* info = head; info; info = info.ai_next) {
			Address resolved;
			switch (info.ai_family) {
			case AF_INET:
				resolved.m_family = AddressFamily.IPv4;
				(cast(uint[]) resolved.m_address)[0] = (cast(sockaddr_in*) info.ai_addr).sin_addr.s_addr;
				break;
			case AF_INET6:
				resolved.m_family = AddressFamily.IPv6;
				resolved.m_address[] = (cast(sockaddr_in6*) info.ai_addr).sin6_addr.s6_addr[];
				resolved.m_scopeId = (cast(sockaddr_in6*) info.ai_addr).sin6_scope_id;
				break;
			default:
				continue;
			}
			result ~= AddressInfo(resolved, canonicalName);
		}

		return result;
	}

	override bool isActive() {
		return socketsByFd.length != 0;
	}

	override void deactivate() {
		import std.array : array;

		foreach (socket; socketsByFd.byValue.array)
			socket.dispose();
	}

	override void processEvents() {}
}

class OSXSocket : Socket {
	package int fd;

	private OSXSocketManager manager;
	private AddressFamily family;
	private SocketProtocol protocol;
	private CFSocketRef cfSocket;
	private CFRunLoopSourceRef runLoopSource;
	private Fiber connectFiber;
	private int connectError;
	private bool isListening;

	private this(OSXSocketManager manager, int fd, AddressFamily family, SocketProtocol protocol) {
		scope (failure) dispose();

		addDependency(manager);
		this.manager = manager;
		this.fd = fd;
		this.family = family;
		this.protocol = protocol;

		int zero;
		setsockopt(fd, IPPROTO_IPV6, IPV6_V6ONLY, &zero, zero.sizeof);

		CFSocketContext context;
		context.info = cast(void*) this;
		cfSocket = CFSocketCreateWithNative(
			null,
			fd,
			CFSocketCallBackType.Read | CFSocketCallBackType.Connect | CFSocketCallBackType.Write,
			&socketCallback,
			&context,
		);
		if (!cfSocket)
			throw new Exception("failed to create CFSocket");

		CFOptionFlags flags = CFSocketGetSocketFlags(cfSocket);
		flags |= CFSocketFlags.AutomaticallyReenableRead | CFSocketFlags.CloseOnInvalidate;
		CFSocketSetSocketFlags(cfSocket, flags);
		CFSocketDisableCallBacks(cfSocket, CFSocketCallBackType.Write);

		runLoopSource = CFSocketCreateRunLoopSource(null, cfSocket, 0);
		if (!runLoopSource)
			throw new Exception("failed to create CFSocket run loop source");
		CFRunLoopAddSource(CFRunLoopGetMain(), runLoopSource, kCFRunLoopDefaultMode);

		manager.socketsByFd[fd] = this;
	}

	protected override void disposeImpl() {
		manager.socketsByFd.remove(fd);
		if (runLoopSource) {
			CFRunLoopRemoveSource(CFRunLoopGetMain(), runLoopSource, kCFRunLoopDefaultMode);
			CFRelease(runLoopSource);
			runLoopSource = null;
		}
		if (cfSocket) {
			CFSocketInvalidate(cfSocket);
			CFRelease(cfSocket);
			cfSocket = null;
		}
		else if (fd != -1) {
			close(fd);
		}
		fd = -1;
	}

	private SumType!(sockaddr_in, sockaddr_in6) convertAddress(Address address) {
		final switch (address.family) {
		case AddressFamily.IPv4:
			sockaddr_in result;
			result.sin_len = result.sizeof;
			result.sin_family = AF_INET;
			result.sin_port = htons(address.port);
			result.sin_addr.s_addr = (cast(uint[]) address.m_address)[0];
			return typeof(return)(result);
		case AddressFamily.IPv6:
			sockaddr_in6 result;
			result.sin6_len = result.sizeof;
			result.sin6_family = AF_INET6;
			result.sin6_port = htons(address.port);
			result.sin6_flowinfo = address.m_flowInfo;
			result.sin6_scope_id = address.m_scopeId;
			result.sin6_addr.s6_addr[] = address.m_address[];
			return typeof(return)(result);
		}
	}

	private Address convertAddress(sockaddr_in address) {
		Address result;
		result.m_family = AddressFamily.IPv4;
		(cast(uint[]) result.m_address)[0] = address.sin_addr.s_addr;
		result.m_port = ntohs(address.sin_port);
		return result;
	}

	private Address convertAddress(sockaddr_in6 address) {
		Address result;
		result.m_family = AddressFamily.IPv6;
		result.m_address[] = address.sin6_addr.s6_addr[];
		result.m_port = ntohs(address.sin6_port);
		result.m_flowInfo = address.sin6_flowinfo;
		result.m_scopeId = address.sin6_scope_id;
		return result;
	}

	override void bind(Address address) {
		auto native = convertAddress(address);
		int result = native.match!(value => .bind(fd, cast(sockaddr*) &value, value.sizeof));
		if (result != 0)
			throw socketException("bind", errno);
	}

	override void listen(int backlog) {
		if (.listen(fd, backlog) != 0)
			throw socketException("listen", errno);
		isListening = true;
	}

	override void connect(Address address) {
		auto native = convertAddress(address);
		int result = native.match!(value => .connect(fd, cast(sockaddr*) &value, value.sizeof));
		if (result == 0)
			return;

		int error = errno;
		if (error != EINPROGRESS)
			throw socketException("connect", error);

		connectFiber = Fiber.getThis;
		Fiber.yield();
		connectFiber = null;
		if (connectError)
			throw socketException("connect", connectError);
	}

	private bool m_readAutomatically = true;
	override bool readAutomatically() const @property => m_readAutomatically;
	override void readAutomatically(bool value) @property { m_readAutomatically = value; }

	package void waitForWrite() {
		CFSocketEnableCallBacks(cfSocket, CFSocketCallBackType.Write);
	}

	private void handleRead() {
		if (isListening) {
			while (true) {
				int client = accept(fd, null, null);
				if (client == -1) {
					if (errno == EAGAIN || errno == EWOULDBLOCK)
						break;
					throw socketException("accept", errno);
				}

				int attributes = fcntl(client, F_GETFL, 0);
				fcntl(client, F_SETFL, attributes | O_NONBLOCK);
				OSXSocket accepted = new OSXSocket(manager, client, family, protocol);
				accepted.addDependency(this);
				onAccept.emit(accepted);
			}
			return;
		}

		onReadAvailable.emit();
		while (m_readAutomatically && !disposed) {
			ubyte[4096] buffer;
			Address source;
			ssize_t received;
			final switch (family) {
			case AddressFamily.IPv4:
				sockaddr_in native;
				socklen_t length = native.sizeof;
				received = recvfrom(fd, buffer.ptr, buffer.length, 0, cast(sockaddr*) &native, &length);
				source = convertAddress(native);
				break;
			case AddressFamily.IPv6:
				sockaddr_in6 native;
				socklen_t length = native.sizeof;
				received = recvfrom(fd, buffer.ptr, buffer.length, 0, cast(sockaddr*) &native, &length);
				source = convertAddress(native);
				break;
			}

			if (received > 0)
				onReceive.emit(source, buffer[0 .. received]);
			else if (received == 0) {
				onHangup.emit();
				dispose();
				break;
			}
			else if (errno == EAGAIN || errno == EWOULDBLOCK)
				break;
			else
				throw socketException("receive", errno);
		}
	}

	private void handleCallback(CFSocketCallBackType callbackType, const(void)* data) {
		switch (callbackType) {
		case CFSocketCallBackType.Read:
			handleRead();
			break;
		case CFSocketCallBackType.Connect:
			connectError = data ? *cast(const(int)*) data : 0;
			if (connectFiber)
				connectFiber.call();
			break;
		case CFSocketCallBackType.Write:
			onWriteAvailable.emit();
			break;
		default:
			break;
		}
	}

	override size_t send(const(void)[] buffer) {
		ssize_t sent = .send(fd, buffer.ptr, buffer.length, 0);
		if (sent >= 0)
			return cast(size_t) sent;
		if (errno == EAGAIN || errno == EWOULDBLOCK) {
			waitForWrite();
			return 0;
		}
		throw socketException("send", errno);
	}

	override size_t sendTo(Address address, const(void)[] buffer) {
		auto native = convertAddress(address);
		ssize_t sent = native.match!(value => .sendto(
			fd,
			buffer.ptr,
			buffer.length,
			0,
			cast(sockaddr*) &value,
			value.sizeof,
		));
		if (sent >= 0)
			return cast(size_t) sent;
		if (errno == EAGAIN || errno == EWOULDBLOCK) {
			waitForWrite();
			return 0;
		}
		throw socketException("sendto", errno);
	}
}

private Exception socketException(string operation, int error) {
	import std.conv : to;
	return new Exception("socket " ~ operation ~ " failed (errno " ~ error.to!string ~ ")");
}

private extern(C) void socketCallback(
	CFSocketRef socket,
	CFSocketCallBackType callbackType,
	CFDataRef address,
	const(void)* data,
	void* info,
) {
	(cast(OSXSocket) info).handleCallback(callbackType, data);
}

@("macOS UDP sockets dispatch through the application run loop") unittest {
	import gd.system.application : application;

	OSXSocketManager manager = cast(OSXSocketManager) application.socketManager;
	OSXSocket receiver = manager.createSocket(AddressFamily.IPv4, SocketProtocol.UDP);
	scope (exit) receiver.dispose();
	receiver.bind(Address.createIPv4([127, 0, 0, 1], 0));

	sockaddr_in receiverAddress;
	socklen_t receiverAddressLength = receiverAddress.sizeof;
	assert(getsockname(
		receiver.fd,
		cast(sockaddr*) &receiverAddress,
		&receiverAddressLength,
	) == 0);

	OSXSocket sender = manager.createSocket(AddressFamily.IPv4, SocketProtocol.UDP);
	scope (exit) sender.dispose();

	ubyte[] received;
	receiver.onReceive.connect((Address, ubyte[] data) { received = data.dup; });
	enum payload = cast(const(ubyte)[]) "gd macOS socket test";
	Address destination = Address.createIPv4(
		[127, 0, 0, 1],
		ntohs(receiverAddress.sin_port),
	);
	assert(sender.sendTo(destination, payload) == payload.length);

	foreach (_; 0 .. 100) {
		if (received.length)
			break;
		application.processEvents();
	}
	assert(received == payload);
}

@("macOS TCP connect and accept dispatch through the application run loop") unittest {
	import gd.system.application : application;
	import gd.threading : spawnUnprotectedTask;

	OSXSocketManager manager = cast(OSXSocketManager) application.socketManager;
	OSXSocket listener = manager.createSocket(AddressFamily.IPv4, SocketProtocol.TCP);
	scope (exit) listener.dispose();
	listener.bind(Address.createIPv4([127, 0, 0, 1], 0));
	listener.listen(1);

	sockaddr_in listenerAddress;
	socklen_t listenerAddressLength = listenerAddress.sizeof;
	assert(getsockname(
		listener.fd,
		cast(sockaddr*) &listenerAddress,
		&listenerAddressLength,
	) == 0);

	OSXSocket accepted;
	listener.onAccept.connect((Socket socket) { accepted = cast(OSXSocket) socket; });

	OSXSocket client = manager.createSocket(AddressFamily.IPv4, SocketProtocol.TCP);
	scope (exit) client.dispose();
	bool connectFinished;
	Exception connectError;
	Address destination = Address.createIPv4(
		[127, 0, 0, 1],
		ntohs(listenerAddress.sin_port),
	);
	spawnUnprotectedTask({
		try {
			client.connect(destination);
		}
		catch (Exception error) {
			connectError = error;
		}
		connectFinished = true;
	});

	foreach (_; 0 .. 100) {
		if (connectFinished && accepted)
			break;
		application.processEvents();
	}
	assert(connectError is null);
	assert(connectFinished);
	assert(accepted);
}
