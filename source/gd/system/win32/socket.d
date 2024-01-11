module gd.system.win32.socket;
import gd.system.win32.application;
import gd.system.socket;
import gd.net.address;
import gd.resource;
import gd.signal;

version (gd_Win32):

import gd.system.win32.exception;
import core.sys.windows.windows;
import core.thread.fiber;
import std.sumtype;

private enum WM_SOCKET = WM_USER + 1;

private {
	enum WORD FD_READ_BIT =      0;
	enum WORD FD_READ =          (1 << FD_READ_BIT);

	enum WORD FD_WRITE_BIT =     1;
	enum WORD FD_WRITE =         (1 << FD_WRITE_BIT);

	enum WORD FD_OOB_BIT =       2;
	enum WORD FD_OOB =           (1 << FD_OOB_BIT);

	enum WORD FD_ACCEPT_BIT =    3;
	enum WORD FD_ACCEPT =        (1 << FD_ACCEPT_BIT);

	enum WORD FD_CONNECT_BIT =   4;
	enum WORD FD_CONNECT =       (1 << FD_CONNECT_BIT);

	enum WORD FD_CLOSE_BIT =     5;
	enum WORD FD_CLOSE =         (1 << FD_CLOSE_BIT);

	enum WORD FD_QOS_BIT =       6;
	enum WORD FD_QOS =           (1 << FD_QOS_BIT);

	enum WORD FD_GROUP_QOS_BIT = 7;
	enum WORD FD_GROUP_QOS =     (1 << FD_GROUP_QOS_BIT);

	enum WORD FD_ROUTING_INTERFACE_CHANGE_BIT = 8;
	enum WORD FD_ROUTING_INTERFACE_CHANGE =     (1 << FD_ROUTING_INTERFACE_CHANGE_BIT);

	enum WORD FD_ADDRESS_LIST_CHANGE_BIT = 9;
	enum WORD FD_ADDRESS_LIST_CHANGE =     (1 << FD_ADDRESS_LIST_CHANGE_BIT);

	enum WORD FD_MAX_EVENTS =    10;
	enum WORD FD_ALL_EVENTS =    ((1 << FD_MAX_EVENTS) - 1);

	alias WSAGETSELECTEVENT = LOWORD;
	alias WSAGETSELECTERROR = HIWORD;

	alias GROUP = UINT;

	enum WSA_FLAG_OVERLAPPED =           0x01;
	enum WSA_FLAG_MULTIPOINT_C_ROOT =    0x02;
	enum WSA_FLAG_MULTIPOINT_C_LEAF =    0x04;
	enum WSA_FLAG_MULTIPOINT_D_ROOT =    0x08;
	enum WSA_FLAG_MULTIPOINT_D_LEAF =    0x10;
	enum WSA_FLAG_ACCESS_SYSTEM_SECURITY = 0x40;
	enum WSA_FLAG_NO_HANDLE_INHERIT =    0x80;
	enum WSA_FLAG_REGISTERED_IO =       0x100;

	extern (Windows) {
		int WSAAsyncSelect(SOCKET s, HWND hWnd, UINT wMsg, LONG lEvent);

		SOCKET WSASocketW(
			int af,
			int type,
			int protocol,
			void* lpProtocolInfo,
			GROUP g,
			DWORD dwFlags,
		);
	}
}

class Win32SocketManager : SocketManager {

	private Win32Application application;

	private HANDLE hwnd;

	package(gd.system) this(Win32Application application) {
		scope (failure) dispose();

		addDependency(application);
		this.application = application;

		WSADATA wsaData;
		int result = WSAStartup(MAKEWORD(2, 2), &wsaData);
		if (result != 0)
			throw new Win32Exception("WSAStartup", GetLastError());

		WNDCLASSEXW wc;
		wc.cbSize = WNDCLASSEXW.sizeof;
		wc.style = 0;
		wc.lpfnWndProc = &win32SocketWndProc;
		wc.cbClsExtra = 0;
		wc.cbWndExtra = 0;
		wc.hInstance = GetModuleHandleW(NULL);
		wc.hIcon = LoadIcon(NULL, IDI_APPLICATION);
		wc.hCursor = NULL;
		wc.hbrBackground = cast(HBRUSH) GetStockObject(BLACK_BRUSH);
		wc.lpszMenuName = NULL;
		wc.lpszClassName = "networkmessageonly"w.ptr;
		wc.hIconSm = LoadIcon(NULL, IDI_APPLICATION);

		if (!RegisterClassExW(&wc))
			throw new Win32Exception("RegisterClassExW", GetLastError());

		// create a message-only window to receive network events
		hwnd = CreateWindowW("networkmessageonly"w.ptr, null, 0, 0, 0, 1, 1, HWND_MESSAGE, null, GetModuleHandleW(NULL), null);

		SetWindowLongPtrW(hwnd, GWLP_USERDATA, cast(LONG_PTR) cast(void*) this);
	}

	protected override void disposeImpl() {
		if (hwnd) DestroyWindow(hwnd);
		WSACleanup();
	}

	private Win32Socket[SOCKET] socketsByFd;

	override Win32Socket createSocket(AddressFamily family, SocketProtocol protocol) {
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

		// create the socket
		// SOCKET fd = socket(lfamily, lprotocol, 0);
		SOCKET fd = WSASocketW(lfamily, lprotocol, 0, null, 0, WSA_FLAG_OVERLAPPED);
		if (fd == INVALID_SOCKET)
			throw new Win32Exception("socket", WSAGetLastError());

		return new Win32Socket(this, fd, family, protocol);
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

		import std.stdio;
		int res = getaddrinfo(address.toStringz, null, &hints, &info);
		if (res != 0) {
			throw new Exception("name resolution failed");
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

		Win32Socket[] sockets = socketsByFd.byValue.array;
		foreach (socket; sockets)
			socket.dispose();
	}

	override void processEvents() {}

}

class Win32Socket : Socket {

	SOCKET fd;
	Signal!(WORD, WORD) onWin32Events;

	private {
		AddressFamily family;
		SocketProtocol protocol;
	}

	private Win32SocketManager socketManager;
	private this(Win32SocketManager socketManager, SOCKET fd, AddressFamily family, SocketProtocol protocol) {
		scope (failure) dispose();

		addDependency(socketManager);
		this.socketManager = socketManager;

		this.fd = fd;
		this.family = family;
		this.protocol = protocol;

		socketManager.socketsByFd[fd] = this;

		listenToEvents();
	}

	protected override void disposeImpl() {
		closesocket(fd);
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
			throw new Win32Exception("bind", WSAGetLastError());
		}
	}

	private bool isListening = false;
	override void listen(int backlog) {
		int res = .listen(fd, backlog);
		if (res != 0) {
			throw new Win32Exception("listen", WSAGetLastError());
		}

		isListening = true;
	}

	override void connect(Address address) {
		auto addr = convertAddress(address);

		// sometimes messages can arrive immediately after we connect, despite
		// the connect function returning EWOULDBLOCK, because winders is dumb
		WORD[2][] preEvents;
		Slot preSlot = onWin32Events.connect((WORD ev, WORD err_) {
			preEvents ~= [ev, err_];
		});

		int res = addr.match!((x) => .connect(fd, cast(sockaddr*)&x, typeof(x).sizeof));
		if (res == 0) {
			// we're connected
			onWin32Events.disconnect(preSlot);
			return;
		}

		bool hasError = false;
		int err = WSAGetLastError();
		if (err == EWOULDBLOCK || err == EINPROGRESS) {
			Fiber fiber = Fiber.getThis;

			suspendListening = true;

			bool yielded = false, needYielding = true;

			Slot slot;
			onWin32Events.disconnect(preSlot);
			slot = onWin32Events.connect((WORD ev, WORD err_) {
				if (err_ != 0) {
					err = err_;
					hasError = true;
				}
				else if (ev & FD_CONNECT) {
					// we're connected
					suspendListening = false;
					onWin32Events.disconnect(slot);

					if (!yielded)
						needYielding = false;
					else
						fiber.call();
				}
				else {
					// some random event, ignore
				}
			});

			foreach (ev; preEvents) {
				onWin32Events.emit(ev[0], ev[1]);
			}

			if (needYielding) {
				yielded = true;
				Fiber.yield();
			}
		}
		else {
			onWin32Events.disconnect(preSlot);
			hasError = true;
		}

		if (hasError) {
			throw new Win32Exception("connect", err);
		}
	}

	private bool suspendListening = false;
	private void listenToEvents() {
		// make the socket send non-blocking events
		int aRes = WSAAsyncSelect(fd, socketManager.hwnd, WM_SOCKET, FD_READ | FD_WRITE | FD_ACCEPT | FD_CONNECT | FD_CLOSE);
		if (aRes != 0)
			throw new Win32Exception("WSAAsyncSelect", WSAGetLastError());

		onWin32Events.connect((WORD ev, WORD err) {
			if (suspendListening)
				return;

			if (err != 0) {
				// TODO: how to handle errors
			}

			if (ev & FD_ACCEPT) {
				while (true) {
					SOCKET clientSock = accept(fd, null, null);
					if (clientSock == INVALID_SOCKET) {
						int errno = WSAGetLastError();
						if (errno == EWOULDBLOCK) {
							break;
						}
						else {
							// TODO: how would we properly handle an error here?
							import std.stdio : writeln;
							writeln("error: ", errno);
							break;
						}
					}

					Win32Socket newSocket = new Win32Socket(socketManager, clientSock, family, protocol);
					newSocket.addDependency(this);
					onAccept.emit(newSocket);
				}
			}

			if (ev & FD_READ) {
				while (true) {
					ubyte[1024] buffer;
					Address addr;
					int received;
					final switch (family) {
					case AddressFamily.IPv4:
						sockaddr_in addrin;
						socklen_t len = addrin.sizeof;
						received = recvfrom(fd, buffer.ptr, buffer.length, 0,
							cast(sockaddr*) &addrin, &len);
						addr = convertAddress(addrin);
						break;
					case AddressFamily.IPv6:
						sockaddr_in6 addrin;
						socklen_t len = addrin.sizeof;
						received = recvfrom(fd, buffer.ptr, buffer.length, 0,
							cast(sockaddr*) &addrin, &len);
						addr = convertAddress(addrin);
						break;
					}

					if (received == SOCKET_ERROR) {
						int errno = WSAGetLastError();
						if (errno == EWOULDBLOCK) {
							break;
						}
						else {
							// TODO: how do we handle an error here
							import std.stdio : writeln;
							writeln("error: ", errno);
							continue;
						}
					}
					else if (received > 0) {
						onReceive.emit(addr, buffer[0 .. received]);
					}
					else {
						break;
					}
				}
			}

			if (ev & FD_CLOSE) {
				onHangup.emit();
				dispose();
			}
		});
	}

	override size_t send(const(void)[] buffer) {
		int res = .send(fd, buffer.ptr, cast(int) buffer.length, 0);
		if (res >= 0)
			return cast(size_t) res;

		int err = WSAGetLastError();
		if (err == EWOULDBLOCK) {
			return 0;
		}
		else {
			throw new Win32Exception("send", err);
		}
	}

	override size_t sendTo(Address address, const(void)[] buffer) {
		auto addr = convertAddress(address);
		int res = addr.match!((x) => .sendto(fd, buffer.ptr, cast(int) buffer.length, 0,
			cast(sockaddr*)&x, typeof(x).sizeof));
		if (res >= 0)
			return cast(size_t) res;

		int err = WSAGetLastError();
		if (err == EWOULDBLOCK) {
			return 0;
		}
		else {
			throw new Win32Exception("send", err);
		}
	}

}

private extern (Windows) LRESULT win32SocketWndProc(HWND hwnd, UINT Msg, WPARAM wParam, LPARAM lParam) nothrow {
	return safeCall(&wndProcD, hwnd, Msg, wParam, lParam);
}

private LRESULT wndProcD(HWND hwnd, UINT Msg, WPARAM wParam, LPARAM lParam) {
	Win32SocketManager self = cast(Win32SocketManager) cast(void*) GetWindowLongPtrW(hwnd, GWLP_USERDATA);

	if (self is null)
		return DefWindowProc(hwnd, Msg, wParam, lParam);

	if (Msg != WM_SOCKET)
		return TRUE;

	// sometimes, we receive FD_READ messages after FD_CLOSE.
	// why, microsoft....
	if (cast(SOCKET) wParam !in self.socketsByFd)
		return TRUE;

	Win32Socket socket = self.socketsByFd[cast(SOCKET) wParam];

	socket.onWin32Events.emit(WSAGETSELECTEVENT(lParam), WSAGETSELECTERROR(lParam));

	return TRUE;
}
