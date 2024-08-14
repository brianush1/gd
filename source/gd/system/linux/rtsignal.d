module gd.system.linux.rtsignal;

version (gd_Linux):
package(gd.system.linux):

import core.sys.linux.sys.signalfd;
import core.sys.posix.signal;
import core.sys.posix.unistd;

int m_signalFd;
int m_timerSignal;

shared static this() {
	m_timerSignal = SIGRTMIN + 2; // TODO: make this configurable

	// we have to block this signal first thing, or else we might make other
	// threads that won't inherit our sigmask
	sigset_t mask;
	sigemptyset(&mask);
	sigaddset(&mask, m_timerSignal);
	pthread_sigmask(SIG_BLOCK, &mask, null);

	m_signalFd = signalfd(-1, &mask, SFD_NONBLOCK);
}

shared static ~this() {
	close(m_signalFd); // TODO: is this the right way to close the signal fd?
}
