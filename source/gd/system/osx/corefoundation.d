module gd.system.osx.corefoundation;

version (gd_OSX):

alias CFIndex = long;
alias CFOptionFlags = ulong;
alias CFTypeRef = const(void)*;
alias CFAllocatorRef = const(void)*;
alias CFStringRef = const(void)*;
alias CFDataRef = const(void)*;
alias CFRunLoopRef = void*;
alias CFRunLoopSourceRef = void*;
alias CFSocketRef = void*;
alias CFSocketNativeHandle = int;

enum CFSocketCallBackType : CFOptionFlags {
	No = 0,
	Read = 1,
	Accept = 2,
	Data = 3,
	Connect = 4,
	Write = 8,
}

enum CFSocketFlags : CFOptionFlags {
	AutomaticallyReenableRead = 1,
	AutomaticallyReenableAccept = 2,
	AutomaticallyReenableData = 3,
	AutomaticallyReenableWrite = 8,
	LeaveErrors = 64,
	CloseOnInvalidate = 128,
}

alias CFSocketCallBack = extern(C) void function(
	CFSocketRef socket,
	CFSocketCallBackType callbackType,
	CFDataRef address,
	const(void)* data,
	void* info,
);

struct CFSocketContext {
	CFIndex version_;
	void* info;
	const(void)* function(const(void)*) retain;
	void function(const(void)*) release;
	CFStringRef function(const(void)*) copyDescription;
}

extern (C) {
	extern __gshared CFStringRef kCFRunLoopDefaultMode;

	void CFRelease(CFTypeRef value);
	CFSocketRef CFSocketCreateWithNative(
		CFAllocatorRef allocator,
		CFSocketNativeHandle socket,
		CFOptionFlags callbackTypes,
		CFSocketCallBack callback,
		const(CFSocketContext)* context,
	);
	void CFSocketInvalidate(CFSocketRef socket);
	CFRunLoopSourceRef CFSocketCreateRunLoopSource(
		CFAllocatorRef allocator,
		CFSocketRef socket,
		CFIndex order,
	);
	CFOptionFlags CFSocketGetSocketFlags(CFSocketRef socket);
	void CFSocketSetSocketFlags(CFSocketRef socket, CFOptionFlags flags);
	void CFSocketDisableCallBacks(CFSocketRef socket, CFOptionFlags callbackTypes);
	void CFSocketEnableCallBacks(CFSocketRef socket, CFOptionFlags callbackTypes);

	CFRunLoopRef CFRunLoopGetMain();
	void CFRunLoopAddSource(CFRunLoopRef runLoop, CFRunLoopSourceRef source, CFStringRef mode);
	void CFRunLoopRemoveSource(CFRunLoopRef runLoop, CFRunLoopSourceRef source, CFStringRef mode);
}
