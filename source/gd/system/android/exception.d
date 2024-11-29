module gd.system.android.exception;

version (gd_Android):

class AndroidException : Exception {
	this(string msg, string file = __FILE__, size_t line = __LINE__, Throwable nextInChain = null)
	pure nothrow @nogc @safe {
		super(msg, file, line, nextInChain);
	}
}
