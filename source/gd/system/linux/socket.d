module gd.system.linux.socket;
import gd.system.linux.application;
import gd.system.socket;
import gd.net.address;
import gd.resource;
import gd.signal;

version (gd_Linux):

import gd.system.linux.errno;
import core.sys.linux.epoll;
import core.sys.linux.unistd;
import core.sys.posix.sys.socket;
import core.sys.posix.netinet.in_;
import core.sys.posix.fcntl;
import core.sys.posix.netdb;
import core.stdc.errno;
import core.thread.fiber;
import std.sumtype;

class LinuxSocketManager : SocketManager {

	private LinuxApplication application;

	package(gd.system) this(LinuxApplication application) {
		scope (failure) dispose();

		addDependency(application);
		this.application = application;
	}

	protected override void disposeImpl() {}

	private LinuxSocket[int] socketsByFd;

	override LinuxSocket createSocket(AddressFamily family, SocketProtocol protocol) {
		int lfamily, lprotocol;

		final switch (family) {
		case AddressFamily.IPv4:
			lfamily = AF_INET;
			break;
		case AddressFamily.IPv6:
			lfamily = AF_INET6;
			break;
		}

		final switch (protocol) {
		case SocketProtocol.TCP:
			lprotocol = SOCK_STREAM;
			break;
		case SocketProtocol.UDP:
			lprotocol = SOCK_DGRAM;
			break;
		}

		// TODO: error checking

		// create the socket
		int fd = socket(lfamily, lprotocol, 0);

		// set the socket to non-blocking
		int attrs = fcntl(fd, F_GETFL, 0);
		attrs |= O_NONBLOCK;
		fcntl(fd, F_SETFL, attrs);

		return new LinuxSocket(this, fd, family, protocol);
	}

	override AddressInfo[] resolve(string address) {
		import std.string : fromStringz, toStringz;

		AddressInfo[] result;

		addrinfo* info;
		scope (exit) {
			if (info)
				freeaddrinfo(info);
		}

		addrinfo hints;
		hints.ai_family = AF_UNSPEC;
		hints.ai_socktype = SOCK_STREAM;
		hints.ai_flags |= AI_CANONNAME;

		int res = getaddrinfo(address.toStringz, null, &hints, &info);
		if (res != 0) {
			switch (res) {
				case EAI_AGAIN: throw new Exception("name resolution failed: EAI_AGAIN");
				case EAI_BADFLAGS: throw new Exception("name resolution failed: EAI_BADFLAGS");
				case EAI_FAIL: throw new Exception("name resolution failed: EAI_FAIL");
				case EAI_FAMILY: throw new Exception("name resolution failed: EAI_FAMILY");
				case EAI_MEMORY: throw new Exception("name resolution failed: EAI_MEMORY");
				case EAI_NONAME: throw new Exception("name resolution failed: EAI_NONAME");
				case EAI_SERVICE: throw new Exception("name resolution failed: EAI_SERVICE");
				case EAI_SOCKTYPE: throw new Exception("name resolution failed: EAI_SOCKTYPE");
				case EAI_SYSTEM: throw new Exception("name resolution failed: EAI_SYSTEM");
				default: throw new Exception("name resolution failed: unknown error");
			}
		}

		string canonName = info.ai_canonname.fromStringz.idup;

		addrLoop: for (; info; info = info.ai_next) {
			Address addr;

			switch (info.ai_family) {
			case AF_INET:
				addr.m_family = AddressFamily.IPv4;
				(cast(uint[]) addr.m_address)[0] = (cast(sockaddr_in*) info.ai_addr).sin_addr.s_addr;
				break;
			case AF_INET6:
				addr.m_family = AddressFamily.IPv6;
				addr.m_address[] = (cast(sockaddr_in6*) info.ai_addr).sin6_addr.s6_addr[];
				addr.m_scopeId = (cast(sockaddr_in6*) info.ai_addr).sin6_scope_id;
				break;
			default:
				continue addrLoop;
			}

			result ~= AddressInfo(addr, canonName);
		}

		return result;
	}

	override bool isActive() {
		return socketsByFd.length != 0;
	}

	override void deactivate() {
		import std.array : array;

		LinuxSocket[] sockets = socketsByFd.byValue.array;
		foreach (socket; sockets)
			socket.dispose();
	}

	override void processEvents() {
		foreach (ref ev; application.epollEvents) {
			if (LinuxSocket* sock = ev.data.fd in socketsByFd) {
				sock.onEpollEvents.emit(ev.events);
			}
		}
	}

}

private int epollFlags(SocketProtocol protocol) {
	final switch (protocol) {
	case SocketProtocol.TCP:
		return 0
			| EPOLLIN
			| EPOLLRDHUP
			| EPOLLPRI
			| EPOLLERR
			| EPOLLHUP
		;
	case SocketProtocol.UDP:
		return 0
			| EPOLLIN
			| EPOLLERR
			// | EPOLLET
		;
	}
}

class LinuxSocket : Socket {

	int fd;
	Signal!int onEpollEvents;

	private {
		AddressFamily family;
		SocketProtocol protocol;
	}

	private LinuxSocketManager socketManager;
	private this(LinuxSocketManager socketManager, int fd, AddressFamily family, SocketProtocol protocol) {
		scope (failure) dispose();

		addDependency(socketManager);
		this.socketManager = socketManager;

		this.fd = fd;
		this.family = family;
		this.protocol = protocol;

		socketManager.application.addToPoll(fd, epollFlags(protocol));

		socketManager.socketsByFd[fd] = this;

		listenToEvents();
	}

	protected override void disposeImpl() {
		socketManager.application.removeFromPoll(fd);
		close(fd);
		socketManager.socketsByFd.remove(fd);
	}

	private SumType!(sockaddr_in, sockaddr_in6) convertAddress(Address address) {
		final switch (address.family) {
		case AddressFamily.IPv4:
			sockaddr_in addr;
			addr.sin_family = AF_INET;
			addr.sin_port = htons(address.port);
			addr.sin_addr.s_addr = (cast(uint[]) address.m_address)[0];
			return typeof(return)(addr);
		case AddressFamily.IPv6: // TODO: test IPv6
			sockaddr_in6 addr;
			addr.sin6_family = AF_INET6;
			addr.sin6_port = htons(address.port);
			addr.sin6_flowinfo = address.m_flowInfo;
			addr.sin6_scope_id = address.m_scopeId;
			addr.sin6_addr.s6_addr[] = address.m_address[];
			return typeof(return)(addr);
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
		auto addr = convertAddress(address);
		int res = addr.match!((x) => .bind(fd, cast(sockaddr*)&x, typeof(x).sizeof));
		if (res != 0) {
			throw new Exception("socket bind failed: " ~ errnoToMacroName(errno()));
		}
	}

	private bool isListening = false;
	override void listen(int backlog) {
		int res = .listen(fd, backlog);
		if (res != 0) {
			throw new Exception("socket listen failed: " ~ errnoToMacroName(errno()));
		}

		isListening = true;
	}

	override void connect(Address address) {
		// listen to EPOLLOUT so we know when we've connected
		socketManager.application.modifyPoll(fd, epollFlags(protocol) | EPOLLOUT);

		scope (success) {
			// once we're connected, we don't need EPOLLOUT anymore

			socketManager.application.modifyPoll(fd, epollFlags(protocol));
		}

		auto addr = convertAddress(address);
		int res = addr.match!((x) => .connect(fd, cast(sockaddr*)&x, typeof(x).sizeof));
		if (res == 0) {
			// we're connected
			return;
		}

		bool hasError = false;
		int err = errno();
		if (err == EINPROGRESS) {
			Fiber fiber = Fiber.getThis;

			suspendListening = true;

			Slot slot;
			slot = onEpollEvents.connect((int ev) {
				if (ev & (EPOLLRDHUP | EPOLLPRI | EPOLLERR | EPOLLHUP)) {
					// handle errors
					socklen_t len = err.sizeof;
					getsockopt(fd, SOL_SOCKET, SO_ERROR, &err, &len);
					hasError = true;
				}
				else if (ev & EPOLLOUT) {
					// we're connected
				}
				else {
					// some random event, ignore
					return;
				}

				suspendListening = false;
				onEpollEvents.disconnect(slot);
				fiber.call();
			});

			Fiber.yield();
		}
		else {
			hasError = true;
		}

		if (hasError) {
			throw new Exception("socket connect failed: " ~ errnoToMacroName(err));
		}
	}

	private bool suspendListening = false;
	private void listenToEvents() {
		onEpollEvents.connect((int ev) {
			if (suspendListening)
				return;

			if (ev & (EPOLLPRI | EPOLLERR)) {
				// TODO: how to handle errors
			}

			if (ev & EPOLLIN) {
				if (isListening) {
					int clientSock = accept(fd, null, null);
					if (clientSock == -1) {
						// TODO: how would we properly handle an error here?
						return;
					}

					LinuxSocket newSocket = new LinuxSocket(socketManager, clientSock, family, protocol);
					newSocket.addDependency(this);
					onAccept.emit(newSocket);
				}
				else {
					ubyte[1024] buffer;
					final switch (family) {
					case AddressFamily.IPv4:
						sockaddr_in addrin;
						socklen_t len = addrin.sizeof;
						ssize_t received = recvfrom(fd, buffer.ptr, buffer.length, 0,
							cast(sockaddr*) &addrin, &len);
						if (received > 0) {
							onReceive.emit(convertAddress(addrin), buffer[0 .. received]);
						}
						break;
					case AddressFamily.IPv6:
						sockaddr_in6 addrin;
						socklen_t len = addrin.sizeof;
						ssize_t received = recvfrom(fd, buffer.ptr, buffer.length, 0,
							cast(sockaddr*) &addrin, &len);
						if (received > 0) {
							onReceive.emit(convertAddress(addrin), buffer[0 .. received]);
						}
						break;
					}
				}
			}

			if (ev & (EPOLLRDHUP | EPOLLHUP)) {
				onHangup.emit();
				dispose();
			}
		});
	}

	override size_t send(const(void)[] buffer) {
		ssize_t res = .send(fd, buffer.ptr, buffer.length, 0);
		if (res >= 0)
			return cast(size_t) res;

		int err = errno();
		if (err == EAGAIN || err == EWOULDBLOCK) {
			return 0;
		}
		else {
			throw new Exception("socket send failed: " ~ errnoToMacroName(err));
		}
	}

	override size_t sendTo(Address address, const(void)[] buffer) {
		auto addr = convertAddress(address);
		ssize_t res = addr.match!((x) => .sendto(fd, buffer.ptr, buffer.length, 0,
			cast(sockaddr*)&x, typeof(x).sizeof));
		if (res >= 0)
			return cast(size_t) res;

		int err = errno();
		if (err == EAGAIN || err == EWOULDBLOCK) {
			return 0;
		}
		else {
			throw new Exception("socket send failed: " ~ errnoToMacroName(err));
		}
	}

}
