module gd.system.android.bindings;
import gd.system.android.jni;
import gd.system.android.display;
import gd.system.android.window;
import gd.system.application;
import gd.math;
import core.stdc.stdarg;
import core.stdc.stdio;
import core.sys.posix.pthread;

version (gd_Android):

import core.runtime;
import core.thread;

extern (C) void __android_log_write(int prio, const(char)* tag, const(char)* text);
enum ANDROID_LOG_DEBUG = 3;

void logf(const(char)* fmt, ...) {
	char[10_000] buffer;

	va_list args;
	va_start(args, fmt);
	vsprintf(buffer.ptr, fmt, args);
	va_end(args);

	__android_log_write(ANDROID_LOG_DEBUG, "cringe", buffer.ptr);
}

private:

extern (C) int gdEventLoopWrapper(char[][] args);

extern (C) void* __tls_get_addr(size_t* p) {
	return null;
}

import std.conv : to;
import core.runtime : rt_init;
import core.stdc.stdlib;
import core.stdc.stdio;
import core.stdc.stdarg;
import std.string;

import core.sys.linux.execinfo;
import core.sys.linux.sys.signalfd;
import core.sys.posix.signal;
import core.sys.posix.pthread;

extern (C) {

	void abortHandler( int signum, siginfo_t* si, void* unused )
	{

		if (alreadyErrored)
			return;

		alreadyErrored = true;

		const(char)* name = null;
		switch( signum )
		{
		case SIGABRT: name = "SIGABRT";  break;
		case SIGSEGV: name = "SIGSEGV";  break;
		case SIGBUS:  name = "SIGBUS";   break;
		case SIGILL:  name = "SIGILL";   break;
		case SIGFPE:  name = "SIGFPE";   break;
		case SIGPIPE: name = "SIGPIPE";  break;
		default: name = null; break;
		}

		if ( name )
			fprintf( stderr, "Caught signal %d (%s)\n", signum, name );
		else 
			fprintf( stderr, "Caught signal %d\n", signum );

		printStackTrace();

		exit( 7 );
	}

	void handleCrashes()
	{
		sigaction_t sa;
		sa.sa_flags = SA_SIGINFO;
		sa.sa_sigaction = &abortHandler;
		sigemptyset( &sa.sa_mask );

		sigaction( SIGABRT, &sa, null );
		sigaction( SIGSEGV, &sa, null );
		sigaction( SIGBUS,  &sa, null );
		sigaction( SIGILL,  &sa, null );
		sigaction( SIGFPE,  &sa, null );
		sigaction( SIGPIPE, &sa, null );
	}


	void printStackTrace()
	{
		(*genv).FindClass(genv, null);
	}

	__gshared JNIEnv* genv;
	__gshared bool alreadyErrored = false;

}

__gshared bool runtimeInitialized = false;

extern (C) void Java_com_gd_Main_initializeEarly(JNIEnv* env, jclass) {
	genv = env;
	handleCrashes();
}

extern (C) void Java_com_gd_Main_initialize(JNIEnv* env, jclass) {
	extern (C) void* entrypoint(void*) {
		Runtime.initialize();

		runtimeInitialized = true;

		int result = gdEventLoopWrapper([]);

		// Runtime.terminate();

		pthread_exit(null);
		return null;
	}

	pthread_t thr;
	pthread_create(&thr, null, &entrypoint, null);

	while (!runtimeInitialized) {}
}

extern (C) void Java_com_gd_Main_onSurfaceCreated(JNIEnv* env, jclass) {
	if (!runtimeInitialized)
		return;

	AndroidWindow win = (cast(AndroidDisplay) application.display).mainWindow;

	logf("surface created");
}

extern (C) void Java_com_gd_Main_onDrawFrame(JNIEnv* env, jclass) {
	if (!runtimeInitialized)
		return;

	AndroidWindow win = (cast(AndroidDisplay) application.display).mainWindow;

	if (win.m_paintHandler !is null) {
		win.m_paintHandler();
	}
}

extern (C) void Java_com_gd_Main_onSurfaceChanged(JNIEnv* env, jclass, jint width, jint height) {
	if (!runtimeInitialized)
		return;

	IVec2 newSize = IVec2(width, height);
	AndroidWindow win = (cast(AndroidDisplay) application.display).mainWindow;

	if (win.m_size != newSize) {
		win.m_size = newSize;
		win.onSizeChange.emit(newSize);
	}
}

extern (C) void Java_com_gd_Main_onTouchStart(JNIEnv* env, jclass, jint pointerId, jdouble x, jdouble y) {
	if (!runtimeInitialized)
		return;

	AndroidWindow win = (cast(AndroidDisplay) application.display).mainWindow;
	win.onTouchStart.emit(cast(uint) pointerId, Vec2(x, y));
}

extern (C) void Java_com_gd_Main_onTouchEnd(JNIEnv* env, jclass, jint pointerId, jdouble x, jdouble y) {
	if (!runtimeInitialized)
		return;

	AndroidWindow win = (cast(AndroidDisplay) application.display).mainWindow;
	win.onTouchMove.emit(cast(uint) pointerId, Vec2(x, y));
	win.onTouchEnd.emit(cast(uint) pointerId);
}

extern (C) void Java_com_gd_Main_onTouchMove(JNIEnv* env, jclass, jint pointerId, jdouble x, jdouble y) {
	if (!runtimeInitialized)
		return;

	AndroidWindow win = (cast(AndroidDisplay) application.display).mainWindow;
	win.onTouchMove.emit(cast(uint) pointerId, Vec2(x, y));
}

extern (C) void Java_com_gd_Main_onScroll(JNIEnv* env, jclass, jdouble dx, jdouble dy) {
}
