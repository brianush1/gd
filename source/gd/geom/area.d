module gd.geom.area;
import gd.geom.path;

enum FillRule {

	/** Regions with a nonzero winding number are filled */
	NonZero,

	/** Regions with an odd winding number are filled */
	EvenOdd,

	/** Regions with a negative winding number are filled */
	CW,

	/** Regions with a positive winding number are filled */
	CCW,

}

alias Area = TArea!double;
alias IArea = TArea!int;
alias FArea = TArea!float;
alias RArea = TArea!real;

struct TArea(T) {

	FillRule fillRule;
	TPath!T outline;

	this(FillRule fillRule, TPath!T outline) {
		this.fillRule = fillRule;
		this.outline = outline;
	}

	/+T area() {
		
	}

	TArea!T normalize() {

	}

	// TArea!T[] split();

	TArea!T opBinary(string op)(const(TArea!T) rhs) const if (op == "+") => areaUnion(this, rhs);
	TArea!T opBinary(string op)(const(TArea!T) rhs) const if (op == "*") => areaIntersect(this, rhs);
	+/

}

/+
TArea!T areaUnion(T)(TArea!T[] areas...) {

}

TArea!T areaIntersect(T)(TArea!T[] areas...) {

}
+/
