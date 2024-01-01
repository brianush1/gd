module gd.math.frame2;
import gd.math.vec2;
import std.traits;
import std.math;

alias Frame2 = TFrame2!double;
alias IFrame2 = TFrame2!int;
alias FFrame2 = TFrame2!float;
alias RFrame2 = TFrame2!real;

/++

Represents a coordinate frame/transformation in 2D space. The orientation is encoded in terms
of an orthonormal basis, and the translation is encoded as a position vector.

+/
struct TFrame2(T) {
// fields:

	TVec2!T position = TVec2!T(0, 0);
	TVec2!T right = TVec2!T(1, 0);
	TVec2!T up = TVec2!T(0, 1);

// matrix constructors:

	/++ Constructs a $(D TFrame2) from a given translation vector. +/
	this(V)(TVec2!V position) { this.position = TVec2!T(position); }

	/// ditto
	this(T x, T y) { position = TVec2!T(x, y); }

	/++ Constructs a $(D TFrame3) from the given parameters. +/
	this(V)(TVec2!V position, TVec2!V right, TVec2!V up) {
		this.position = TVec2!T(position);
		this.right = TVec2!T(right);
		this.up = TVec2!T(up);
	}

	/// ditto
	this(V)(TFrame2!V base) {
		position = TVec2!T(base.position);
		right = TVec2!T(base.right);
		up = TVec2!T(base.up);
	}

	static if (isFloatingPoint!T) {
		/++

		Constructs a $(D TFrame2) from a given rotation angle.

		The name is `angles` in order to be consistent with $(D TFrame3), which actually takes
		in multiple angles.

		+/
		static TFrame2!T angles(T theta) {
			TFrame2!T result;
			result.right = TVec2!T(cos(theta), sin(theta));
			result.up = TVec2!T(-sin(theta), cos(theta));
			return result;
		}
	}

// indexing:

	ref inout(T) opIndex(size_t r, size_t c) return inout {
		assert(r < 2 && c < 3);
		switch (c) {
			case 0: return right.components[r];
			case 1: return up.components[r];
			case 2: return position.components[r];
			default: assert(0);
		}
	}

// basic operations:

	auto opBinary(string op, R)(TFrame2!R other) const if (op == "*") {
		alias ResT = typeof(mixin("cast(T) 0 * cast(R) 0"));
		auto mat = TVec2!(TVec2!T)(right, up);
		return TFrame2!ResT(
			mat.dot(other.position) + position,
			mat.dot(other.right),
			mat.dot(other.up),
		);
	}

	TFrame2!T inverse() const {
		T determinantRecip = right.magnitudeSq;
		return TFrame2!T(
			TVec2!T(position.dot(right), position.dot(up)) / -determinantRecip,
			TVec2!T(right.x, up.x) / determinantRecip,
			TVec2!T(right.y, up.y) / determinantRecip,
		);
	}

	TFrame2!T rotation() const => translate(-position);

	TFrame2!T translate(T x, T y) const => translate(TVec2!T(x, y));
	auto translate(R)(TVec2!R vec) const {
		alias ResT = typeof(mixin("cast(T) 0 + cast(R) 0"));
		TFrame2!ResT result = this;
		result.position = position + vec;
		return result;
	}

// conversions:

	string toString() const {
		import std.conv : text;

		return text(position, ", ", right, ", ", up);
	}

}
