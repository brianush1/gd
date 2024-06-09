module gd.logging;
import std.stdio;

private void defaultMissingBindingHandler(string library, string member) {
	throw new Exception("error when loading member '" ~ member ~ "' from " ~ library);
}

abstract class GDLogger {

	void logError(Throwable err) {
		stderr.writeln("An uncaught exception occurred:");
		stderr.writeln(err.file, "(", err.line, "): ", err.message);
		stderr.writeln(err.info.toString());
	}

	void handleMissingBinding(string library, string member) nothrow @nogc {
		(cast(void function(string, string) nothrow @nogc) &defaultMissingBindingHandler)(library, member);
	}

}

package(gd) GDLogger logger;

shared static this() {
	logger = new class GDLogger {};
}

void setGDLogger(GDLogger value) {
	logger = value;
}
