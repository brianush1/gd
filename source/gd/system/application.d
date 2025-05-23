module gd.system.application;
import gd.system.display;
import gd.system.timer;
import gd.system.socket;
import gd.system.ssl;
import gd.resource;
import gd.threading;
import core.thread;

abstract class Application : Resource {

	package(gd) int exitCode = 0;

	abstract inout(Display) display() inout @property;
	abstract inout(Timer) timer() inout @property;
	abstract inout(SocketManager) socketManager() inout @property;
	abstract inout(SSLManager) sslManager() inout @property;

	/++

	This function indicates if code might theoretically keep running.

	If the application enters a state where no more events can possibly be generated,
	this function will return false.

	Note that this function has nothing to do with whether or not the event loop is actually running.

	+/
	abstract bool isActive();
	abstract void deactivate();

	abstract void processEvents(bool wait = true);

	void startEventLoop() {
		while (isActive) {
			processEvents();
		}
	}

}

private __gshared {
	Thread m_guiThread;
	Application m_application;
}

Thread guiThread() @property {
	return m_guiThread;
}

Application application() @property {
	version (gd_Android) {} else {
		assert(Thread.getThis is guiThread, "application can only be accessed in GUI thread");
	}
	return m_application;
}

shared static this() {
	m_guiThread = Thread.getThis;

	version (gd_Linux) {
		import gd.system.linux.application : LinuxApplication;

		m_application = new LinuxApplication();
	}
	else version (gd_Win32) {
		import gd.system.win32.application : Win32Application;

		m_application = new Win32Application();
	}
	else version (gd_Android) {
		import gd.system.android.application : AndroidApplication;

		m_application = new AndroidApplication();
	}
	else {
		static assert(0, "unsupported platform");
	}
}

version (unittest) {} else {
	private {
		extern (C) int _Dmain(char[][]);

		extern (C) int gdEventLoopWrapper(char[][] args) {
			int exitCode = 0;
			spawnTask({
				exitCode = _Dmain(args);
			});

			if (exitCode == 0) {
				application.startEventLoop();
				return application.exitCode;
			}

			return exitCode;
		}
	}

	version (gd_Win32) {
		// ensure that WinMain is compiled
		import gd.system.win32.winmain;
	}

	version (gd_WinMain) {}
	else version (gd_Android) {}
	else {
		shared static this() @trusted {
			// HACK: scan the stack to find where _Dmain is passed to _d_run_main2, and override that value
			void* p;
			void** s = &p;
			while (*s != &_Dmain)
				s += 1;
			*s = &gdEventLoopWrapper;
		}
	}
}

shared static ~this() {
	m_application.dispose();
}
