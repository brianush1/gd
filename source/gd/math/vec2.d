module gd.math.vec2;
import std.traits;
import std.math;

alias Vec2 = TVec2!double;
alias IVec2 = TVec2!int;
alias FVec2 = TVec2!float;
alias RVec2 = TVec2!real;

struct TVec2(T) {
	T[2] components = [0, 0];

	ref inout(T) x() inout @property { return components[0]; }
	ref inout(T) y() inout @property { return components[1]; }

	ref inout(T) r() inout @property { return components[0]; }
	ref inout(T) g() inout @property { return components[1]; }

	ref inout(T) opIndex(size_t index) inout {
		return components[index];
	}

	this(V)(TVec2!V base) {
		x = cast(T) base.x;
		y = cast(T) base.y;
	}

	this(T v) {
		this.x = v;
		this.y = v;
	}

	this(T x, T y) {
		this.x = x;
		this.y = y;
	}

	TVec2!T abs() const {
		import std.math : abs;

		return TVec2!T(x.abs, y.abs);
	}

	static if (is(typeof(x < y))) {
		T min() const {
			import std.algorithm : min;

			return min(x, y);
		}

		T max() const {
			import std.algorithm : max;

			return max(x, y);
		}
	}

	static if (__traits(compiles, x * x)) {
		T magnitudeSq() @property const {
			return x * x + y * y;
		}

		T volume() @property const {
			return x * y;
		}
	}

	static if (isFloatingPoint!T) {
		T magnitude() @property const {
			import std.math : sqrt;

			return sqrt(x * x + y * y);
		}

		alias unit = normalize;
		TVec2!T normalize() const {
			if (magnitude == 0) {
				return this;
			}

			return this / magnitude;
		}

		TVec2!T round() const {
			import std.math : round;

			return TVec2!T(round(x), round(y));
		}
	}

	auto dot(R)(const(TVec2!R) rhs) const {
		return x * rhs.x + y * rhs.y;
	}

	auto cross(R)(const(TVec2!R) rhs) const {
		return x * rhs.y - y * rhs.x;
	}

	auto opBinary(string op, R)(const(TVec2!R) rhs) const {
		alias ResT = typeof(mixin("cast(T) 0" ~ op ~ "cast(R) 0"));
		TVec2!ResT result;
		result.x = mixin("x" ~ op ~ "rhs.x");
		result.y = mixin("y" ~ op ~ "rhs.y");
		return result;
	}

	auto opBinary(string op, R)(const(R) rhs) const
	if (!is(R : const(TVec2!K), K) && is(typeof(mixin("cast(T) 0" ~ op ~ "cast(R) 0")))) {
		alias ResT = typeof(mixin("cast(T) 0" ~ op ~ "cast(R) 0"));
		TVec2!ResT result;
		result.x = mixin("x" ~ op ~ "rhs");
		result.y = mixin("y" ~ op ~ "rhs");
		return result;
	}

	auto opBinaryRight(string op, L)(const(L) lhs) const
	if (!is(L : const(TVec2!K), K) && is(typeof(mixin("cast(L) 0" ~ op ~ "cast(T) 0")))) {
		alias ResT = typeof(mixin("cast(L) 0" ~ op ~ "cast(T) 0"));
		TVec2!ResT result;
		result.x = mixin("lhs" ~ op ~ "x");
		result.y = mixin("lhs" ~ op ~ "y");
		return result;
	}

	auto opOpAssign(string op, T)(T value) {
		auto res = mixin("this" ~ op ~ "value");
		x = res.x;
		y = res.y;
		return this;
	}

	auto opUnary(string op)() const if (op == "+") {
		return this;
	}

	auto opUnary(string op)() const if (op == "-") {
		return TVec2!T(-x, -y);
	}

	// TODO: allow swizzle assignment, i.e. foo.xzy = bar.yyz;
	TVec2!T opDispatch(string member)() @property const
	if (member.length == 2) {
		import std.algorithm : all;

		static assert(member.all!(c => c >= 'x' && c <= 'y'));

		TVec2!T result;
		static foreach (i, char c; member) {
			result.components[i] = mixin("this." ~ c);
		}
		return result;
	}

	TVec3!T opDispatch(string member)() @property const
	if (member.length == 3) {
		import std.algorithm : all;

		static assert(member.all!(c => c >= 'x' && c <= 'y'));

		TVec3!T result;
		static foreach (i, char c; member) {
			result.components[i] = mixin("this." ~ c);
		}
		return result;
	}

	TVec4!T opDispatch(string member)() @property const
	if (member.length == 4) {
		import std.algorithm : all;

		static assert(member.all!(c => c >= 'x' && c <= 'y'));

		TVec4!T result;
		static foreach (i, char c; member) {
			result.components[i] = mixin("this." ~ c);
		}
		return result;
	}

	static if (is(typeof(T.init <= T.init))) {
		bool eq(TVec2!T other, T eps) const {
			return (this - other).magnitudeSq <= eps * eps;
		}
	}

	string toString() const @safe {
		import std.conv : text;
	
		return text("(", x, ", ", y, ")");
	}
}
