module gd.system.application;
import gd.system.display;
import gd.system.timer;
import gd.resource;
import core.thread;

abstract class Application : Resource {

	abstract inout(Display) display() inout @property;
	abstract inout(Timer) timer() inout @property;

	/++

	This function indicates if code might theoretically keep running.

	If the application enters a state where no more events can possibly be generated,
	this function will return false.

	Note that this function has nothing to do with whether or not the event loop is actually running.

	+/
	abstract bool isActive();
	abstract void deactivate();

	abstract void waitForEvents();
	abstract void processEvents();

	void startEventLoop() {
		while (isActive) {
			waitForEvents();
			processEvents();
		}
	}

}

private __gshared {
	Thread m_guiThread;
	Application m_application;
}

Thread guiThread() @property { // @suppress(dscanner.confusing.function_attributes)
	return m_guiThread;
}

Application application() @property { // @suppress(dscanner.confusing.function_attributes)
	import std.exception : enforce;

	enforce(Thread.getThis is guiThread, "application can only be accessed in GUI thread");
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
	else {
		static assert(0, "unsupported platform");
	}
}

shared static ~this() {
	m_application.dispose();
}
