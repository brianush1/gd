module gd.system.osx.ssl;
import gd.system.osx.application;
import gd.system.osx.corefoundation;
import gd.system.osx.socket;
import gd.system.socket;
import gd.system.ssl;
import gd.resource;

version (gd_OSX):

import core.stdc.errno;
import core.sys.posix.sys.socket;
import core.thread.fiber;

private {
	alias OSStatus = int;
	alias SSLContextRef = void*;
	alias SSLConnectionRef = void*;

	enum SSLProtocolSide : int {
		Server,
		Client,
	}

	enum SSLConnectionType : int {
		Stream,
		Datagram,
	}

	enum OSStatus ERR_SSL_WOULD_BLOCK = -9803;
	enum OSStatus ERR_SSL_CLOSED_GRACEFUL = -9805;
	enum OSStatus ERR_SSL_CLOSED_ABORT = -9806;

	alias SSLReadFunc = extern(C) OSStatus function(SSLConnectionRef, void*, size_t*);
	alias SSLWriteFunc = extern(C) OSStatus function(SSLConnectionRef, const(void)*, size_t*);

	extern (C) {
		SSLContextRef SSLCreateContext(CFAllocatorRef, SSLProtocolSide, SSLConnectionType);
		OSStatus SSLSetIOFuncs(SSLContextRef, SSLReadFunc, SSLWriteFunc);
		OSStatus SSLSetConnection(SSLContextRef, SSLConnectionRef);
		OSStatus SSLSetPeerDomainName(SSLContextRef, const(char)*, size_t);
		OSStatus SSLSetEnableCertVerify(SSLContextRef, bool);
		OSStatus SSLHandshake(SSLContextRef);
		OSStatus SSLWrite(SSLContextRef, const(void)*, size_t, size_t*);
		OSStatus SSLRead(SSLContextRef, void*, size_t, size_t*);
	}
}

class OSXSSLInfo : SSLInfo {
	private OSXSocket socket;
	private SSLContextRef context;

	package(gd.system) this(OSXSocket socket, bool verifyPeer, string hostname) {
		scope (failure) dispose();

		addDependency(socket);
		this.socket = socket;
		context = SSLCreateContext(null, SSLProtocolSide.Client, SSLConnectionType.Stream);
		if (!context)
			throw new Exception("failed to create Secure Transport context");

		checkStatus("set I/O callbacks", SSLSetIOFuncs(context, &sslRead, &sslWrite));
		checkStatus("set connection", SSLSetConnection(context, cast(void*) this));
		if (hostname.length)
			checkStatus("set peer domain", SSLSetPeerDomainName(context, hostname.ptr, hostname.length));
		if (!verifyPeer)
			checkStatus("disable certificate verification", SSLSetEnableCertVerify(context, false));

		socket.readAutomatically = false;
	}

	protected override void disposeImpl() {
		if (context) {
			CFRelease(context);
			context = null;
		}
	}

	private void waitForIO() {
		import gd.signal : Slot;

		Fiber fiber = Fiber.getThis;
		bool resumed;
		Slot readSlot;
		Slot writeSlot;
		void resume() {
			if (resumed)
				return;
			resumed = true;
			socket.onReadAvailable.disconnect(readSlot);
			socket.onWriteAvailable.disconnect(writeSlot);
			fiber.call();
		}

		readSlot = socket.onReadAvailable.connect(&resume);
		writeSlot = socket.onWriteAvailable.connect(&resume);
		socket.waitForWrite();
		Fiber.yield();
	}

	override void connect() {
		while (true) {
			OSStatus status = SSLHandshake(context);
			if (status == 0)
				return;
			if (status == ERR_SSL_WOULD_BLOCK) {
				waitForIO();
				continue;
			}
			throw sslException("handshake", status);
		}
	}

	override size_t send(const(void)[] data) {
		size_t processed;
		OSStatus status = SSLWrite(context, data.ptr, data.length, &processed);
		if (status == 0)
			return processed;
		if (status == ERR_SSL_WOULD_BLOCK) {
			if (processed == 0)
				socket.waitForWrite();
			return processed;
		}
		throw sslException("write", status);
	}

	override ubyte[] read() {
		ubyte[4096] buffer;
		size_t processed;
		OSStatus status = SSLRead(context, buffer.ptr, buffer.length, &processed);
		if (status == 0 || status == ERR_SSL_WOULD_BLOCK)
			return buffer[0 .. processed].dup;
		if (status == ERR_SSL_CLOSED_GRACEFUL || status == ERR_SSL_CLOSED_ABORT)
			return null;
		throw sslException("read", status);
	}

	private extern(C) static OSStatus sslRead(SSLConnectionRef connection, void* data, size_t* length) {
		OSXSSLInfo info = cast(OSXSSLInfo) connection;
		ssize_t received = recv(info.socket.fd, data, *length, 0);
		if (received > 0) {
			*length = cast(size_t) received;
			return 0;
		}
		if (received == 0) {
			*length = 0;
			return ERR_SSL_CLOSED_GRACEFUL;
		}
		if (errno == EAGAIN || errno == EWOULDBLOCK) {
			*length = 0;
			return ERR_SSL_WOULD_BLOCK;
		}
		*length = 0;
		return -1;
	}

	private extern(C) static OSStatus sslWrite(SSLConnectionRef connection, const(void)* data, size_t* length) {
		OSXSSLInfo info = cast(OSXSSLInfo) connection;
		ssize_t sent = .send(info.socket.fd, data, *length, 0);
		if (sent >= 0) {
			*length = cast(size_t) sent;
			return 0;
		}
		if (errno == EAGAIN || errno == EWOULDBLOCK) {
			*length = 0;
			info.socket.waitForWrite();
			return ERR_SSL_WOULD_BLOCK;
		}
		*length = 0;
		return -1;
	}
}

class OSXSSLManager : SSLManager {
	package(gd.system) this(OSXApplication application) {
		scope (failure) dispose();
		addDependency(application);
	}

	protected override void disposeImpl() {}

	override OSXSSLInfo initSSL(Socket socket, bool verifyPeer, string hostname) {
		OSXSocket osxSocket = cast(OSXSocket) socket;
		if (!osxSocket)
			throw new Exception("expected a macOS socket");
		return new OSXSSLInfo(osxSocket, verifyPeer, hostname);
	}
}

private void checkStatus(string operation, OSStatus status) {
	if (status != 0)
		throw sslException(operation, status);
}

private Exception sslException(string operation, OSStatus status) {
	import std.conv : to;
	return new Exception("TLS " ~ operation ~ " failed (OSStatus " ~ status.to!string ~ ")");
}
