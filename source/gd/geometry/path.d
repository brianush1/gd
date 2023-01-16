module gd.geometry.path;
import gd.math;
import std.sumtype;

enum FillRule {
	nonZero,
	evenOdd,
}

alias Path = GPath!double;
alias IPath = GPath!int;
alias FPath = GPath!float;
alias RPath = GPath!real;

struct GPath(T) {
	
}
