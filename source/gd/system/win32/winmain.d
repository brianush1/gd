module gd.system.win32.winmain;

version (gd_Win32):

import core.runtime;
import core.sys.windows.windows;

private:

extern (C) int gdEventLoopWrapper(char[][] args);

package(gd.system) extern (Windows) int WinMain(HINSTANCE, HINSTANCE, LPSTR, int) {
	int result;

	try {
		Runtime.initialize();

		HANDLE stdinHandle = GetStdHandle(STD_INPUT_HANDLE);
		HANDLE stdoutHandle = GetStdHandle(STD_OUTPUT_HANDLE);
		HANDLE stderrHandle = GetStdHandle(STD_ERROR_HANDLE);

		bool hasStdin = stdinHandle != null;
		bool hasStdout = stdoutHandle != null;
		bool hasStderr = stderrHandle != null;

		// TODO: this doesn't quite work when standard streams are redirected to a file
		// also, if the program is run in a terminal, powershell isn't going
		// to wait on the program to exit, because its subsystem is windows
		if (AttachConsole(ATTACH_PARENT_PROCESS)) {
			import std.stdio : stdin, stdout, stderr;

			if (!hasStdin) stdin.reopen("CONIN$", "r");
			if (!hasStdout) stdout.reopen("CONOUT$", "w");
			if (!hasStderr) stderr.reopen("CONOUT$", "w");
		}
		else {
			import std.stdio : stdin, stdout, stderr;

			if (!hasStdin) stdin.reopen(r"\\.\NUL", "r");
			if (!hasStdout) stdout.reopen(r"\\.\NUL", "w");
			if (!hasStderr) stderr.reopen(r"\\.\NUL", "w");
		}

		LPWSTR* szArglist;
		int nArgs;
		szArglist = CommandLineToArgvW(GetCommandLineW(), &nArgs);

		if (szArglist == null)
			throw new Exception("CommandLineToArgvW failed");

		char[][] args;

		foreach (i; 0 .. nArgs) {
			import std.conv : to;

			wchar* ptr = szArglist[i];
			size_t len = 0;
			while (ptr[len] != 0)
				len += 1;

			args ~= ptr[0 .. len].to!(char[]);
		}

		LocalFree(szArglist);

		result = gdEventLoopWrapper(args);

		Runtime.terminate();
	}
	catch (Throwable ex) { // @suppress(dscanner.suspicious.catch_em_all)
		import std.string : toStringz;

		MessageBoxA(null, ex.toString.toStringz, "Uncaught runtime error", MB_ICONEXCLAMATION);
		result = 0;
	}

	return result;
}
