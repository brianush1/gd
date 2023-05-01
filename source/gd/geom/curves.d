module gd.geom.curves;
import gd.math;

/+
alias Line = Curves!double.Line;
alias BezierQuad = Curves!double.BezierQuad;
alias BezierCubic = Curves!double.BezierCubic;
alias Arc = Curves!double.Arc;

template Curves(T) {
	interface Curve {
		TRect!T boundingBox();
	}

	struct Line { TVec2!T start, end; }
	struct BezierQuad { TVec2!T start, c1, end; }
	struct BezierCubic { TVec2!T start, c1, c2, end; }
	struct Arc { TVec2!T center; T radius, startAngle, endAngle; }

	struct Intersection {
		T t1, t2;
	}

	TIntersection!T getIntersections(TLine!T a, TLine!T b) {

	}
}
+/
