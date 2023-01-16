module gd.system.x11.exception;

version (gd_X11Impl):

class X11Exception : Exception {
	this(string msg, string file = __FILE__, size_t line = __LINE__, Throwable nextInChain = null)
	pure nothrow @nogc @safe {
		super(msg, file, line, nextInChain);
	}
}
