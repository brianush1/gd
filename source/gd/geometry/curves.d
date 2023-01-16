module gd.geometry.curves;
import gd.math;

abstract class Curve(T) {
	GVec2!T start, end;

	this(GVec2!T start, GVec2!T end) {
		this.start = start;
		this.end = end;
	}

	abstract GVec2!T getPoint(T t) const @property;
}

class Line(T) : Curve!T {
	GVec2!T direction() const @property {
		return end - start;
	}

	override GVec2!T getPoint(T t) const @property {
		return start * (1 - t) + end * t;
	}
}

class BezierQuad(T) : Curve!T {
	GVec2!T control;

	this(GVec2!T start, GVec2!T control, GVec2!T end) {
		super(start, end);
		this.control = control;
	}

	override GVec2!T getPoint(T t) const @property {
		return start * (1 - t) + end * t;
	}
}

class Arc(T) : Curve!T {
	this(GVec2!T center, T radius, T startAngle, T endAngle) {
		super(start, end);
		this.control = control;
	}

	override GVec2!T getPoint(T t) const @property {
		return start * (1 - t) + end * t;
	}
}
