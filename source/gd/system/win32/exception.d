module gd.system.win32.exception;

version (gd_Win32):

import core.sys.windows.windows;

class Win32Exception : Exception {
	this(string msg, string file = __FILE__, size_t line = __LINE__, Throwable nextInChain = null) {
		super(msg, file, line, nextInChain);
	}

	this(string source, DWORD errorCode, string file = __FILE__, size_t line = __LINE__, Throwable nextInChain = null) {
		import std.format : format;

		wchar[256] buffer;
		DWORD length = FormatMessageW(FORMAT_MESSAGE_FROM_SYSTEM | FORMAT_MESSAGE_IGNORE_INSERTS,
			null, errorCode, MAKELANGID(LANG_NEUTRAL, SUBLANG_DEFAULT), buffer.ptr, buffer.length, null);

		super(format!"error in call to %s (0x%08X): %s"(source, errorCode, buffer[0 .. length]), file, line, nextInChain);
	}
}

package T safeCall(T, Args...)(scope T function(Args) dg, Args args) nothrow {
	return safeCall((Args a) { return dg(a); }, args);
}

package T safeCall(T, Args...)(scope T delegate(Args) dg, Args args) nothrow {
	try {
		return dg(args);
	}
	catch (Throwable ex) { // @suppress(dscanner.suspicious.catch_em_all)
		import core.stdc.stdlib : exit;
		import core.stdc.stdio : printf;
		import std.string : toStringz;

		try {
			const(char)* s = ex.toString.toStringz;
			printf("Uncaught runtime error: %s\n", s);
			// MessageBoxA(null, s, "Uncaught runtime error", MB_ICONEXCLAMATION);
		}
		catch (Throwable ex) { // @suppress(dscanner.suspicious.catch_em_all)
			MessageBoxA(null, "An error occurred while trying to generate an error report",
				"Uncaught runtime error", MB_ICONEXCLAMATION);
		}
		exit(1);
	}
}
