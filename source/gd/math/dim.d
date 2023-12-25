module gd.math.dim;
import gd.math.vec;

struct Dim {
	double scale = 0;
	double offset = 0;

	this(double offset) {
		this.offset = offset;
	}

	this(double scale, double offset) {
		this.scale = scale;
		this.offset = offset;
	}

	double compute(double scaleFactor) const {
		return scale * scaleFactor + offset;
	}

	Dim opBinary(string op)(const(Dim) rhs) const if (op == "+" || op == "-") {
		Dim result;
		result.scale = mixin("scale" ~ op ~ "rhs.scale");
		result.offset = mixin("offset" ~ op ~ "rhs.offset");
		return result;
	}

	auto opOpAssign(string op, T)(T value) {
		auto res = mixin("this" ~ op ~ "value");
		scale = res.scale;
		offset = res.offset;
		return this;
	}

	auto opUnary(string op)() const if (op == "-") {
		return Dim(-scale, -offset);
	}

	string toString() const @safe {
		import std.string : format;

		if (scale == 0) {
			return format!"%gpx"(offset);
		}
		else if (offset == 0) {
			return format!"%.2f%%"(scale * 100);
		}
		else {
			return format!"%.2f%% + %gpx"(scale * 100, offset);
		}
	}

}

struct Dim2 {
	Dim x, y;

	this(Dim x, Dim y) {
		this.x = x;
		this.y = y;
	}

	this(double xOffset, double yOffset) {
		x = Dim(xOffset);
		y = Dim(yOffset);
	}

	this(double allOffset) {
		x = Dim(allOffset);
		y = Dim(allOffset);
	}

	this(double xScale, double xOffset, double yScale, double yOffset) {
		x = Dim(xScale, xOffset);
		y = Dim(yScale, yOffset);
	}

	this(Dim x, double yScale, double yOffset) {
		this.x = x;
		y = Dim(yScale, yOffset);
	}

	this(double xScale, double xOffset, Dim y) {
		x = Dim(xScale, xOffset);
		this.y = y;
	}

	Vec2 compute(Vec2 scaleFactor) const {
		return Vec2(x.compute(scaleFactor.x), y.compute(scaleFactor.y));
	}

	Dim2 opBinary(string op)(const(Dim2) rhs) const if (op == "+" || op == "-") {
		Dim2 result;
		result.x = mixin("x" ~ op ~ "rhs.x");
		result.y = mixin("y" ~ op ~ "rhs.y");
		return result;
	}

	auto opOpAssign(string op, T)(T value) {
		auto res = mixin("this" ~ op ~ "value");
		x = res.x;
		y = res.y;
		return this;
	}

	auto opUnary(string op)() const if (op == "-") {
		return Dim2(-x, -y);
	}

	string toString() const @safe {
		import std.string : format;

		return format!"(%s, %s)"(x, y);
	}
}
