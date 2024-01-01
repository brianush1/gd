module gd.math.vec3;
import gd.math.vec2;
import std.traits;
import std.math;

alias Vec3 = TVec3!double;
alias IVec3 = TVec3!int;
alias FVec3 = TVec3!float;
alias RVec3 = TVec3!real;

struct TVec3(T) {
	T[3] components = [0, 0, 0];

	ref inout(T) x() inout @property { return components[0]; }
	ref inout(T) y() inout @property { return components[1]; }
	ref inout(T) z() inout @property { return components[2]; }

	ref inout(T) r() inout @property { return components[0]; }
	ref inout(T) g() inout @property { return components[1]; }
	ref inout(T) b() inout @property { return components[2]; }

	ref inout(T) opIndex(size_t index) inout {
		return components[index];
	}

	this(V)(TVec3!V base) {
		x = cast(T) base.x;
		y = cast(T) base.y;
		z = cast(T) base.z;
	}

	this(T v) {
		this.x = v;
		this.y = v;
		this.z = v;
	}

	this(T x, T y, T z) {
		this.x = x;
		this.y = y;
		this.z = z;
	}

	this(V)(TVec2!V v, T z) {
		x = cast(T) v.x;
		y = cast(T) v.y;
		this.z = z;
	}

	this(V)(T x, TVec2!V v) {
		this.x = x;
		y = cast(T) v.x;
		z = cast(T) v.y;
	}

	TVec3!T abs() const {
		import std.math : abs;

		return TVec3!T(x.abs, y.abs, z.abs);
	}

	static if (is(typeof(x < y))) {
		T min() const {
			import std.algorithm : min;

			return min(x, y, z);
		}

		T max() const {
			import std.algorithm : max;

			return max(x, y, z);
		}
	}

	static if (__traits(compiles, x * x)) {
		T magnitudeSq() @property const {
			return x * x + y * y + z * z;
		}

		T volume() @property const {
			return x * y * z;
		}
	}

	static if (isFloatingPoint!T) {
		T magnitude() @property const {
			import std.math : sqrt;

			return (x * x + y * y + z * z).sqrt;
		}

		alias unit = normalize;
		TVec3!T normalize() const {
			if (magnitude == 0) {
				return this;
			}

			return this / magnitude;
		}
	}

	auto dot(R)(const(TVec3!R) rhs) const {
		return x * rhs.x + y * rhs.y + z * rhs.z;
	}

	auto cross(R)(const(TVec3!R) rhs) const {
		alias ResT = typeof(mixin("cast(T) 0 * cast(R) 0"));
		TVec3!ResT result;
		result.x = y * rhs.z - z * rhs.y;
		result.y = z * rhs.x - x * rhs.z;
		result.z = x * rhs.y - y * rhs.x;
		return result;
	}

	auto opBinary(string op, R)(const(TVec3!R) rhs) const {
		alias ResT = typeof(mixin("cast(T) 0" ~ op ~ "cast(R) 0"));
		TVec3!ResT result;
		result.x = mixin("x" ~ op ~ "rhs.x");
		result.y = mixin("y" ~ op ~ "rhs.y");
		result.z = mixin("z" ~ op ~ "rhs.z");
		return result;
	}

	auto opBinary(string op, R)(const(R) rhs) const
	if (!is(R : const(TVec3!K), K) && is(typeof(mixin("cast(T) 0" ~ op ~ "cast(R) 0")))) {
		alias ResT = typeof(mixin("cast(T) 0" ~ op ~ "cast(R) 0"));
		TVec3!ResT result;
		result.x = mixin("x" ~ op ~ "rhs");
		result.y = mixin("y" ~ op ~ "rhs");
		result.z = mixin("z" ~ op ~ "rhs");
		return result;
	}

	auto opBinaryRight(string op, L)(const(L) lhs) const
	if (!is(L : const(TVec3!K), K) && is(typeof(mixin("cast(L) 0" ~ op ~ "cast(T) 0")))) {
		alias ResT = typeof(mixin("cast(L) 0" ~ op ~ "cast(T) 0"));
		TVec3!ResT result;
		result.x = mixin("lhs" ~ op ~ "x");
		result.y = mixin("lhs" ~ op ~ "y");
		result.z = mixin("lhs" ~ op ~ "z");
		return result;
	}

	auto opOpAssign(string op, T)(T value) {
		auto res = mixin("this" ~ op ~ "value");
		x = res.x;
		y = res.y;
		z = res.z;
		return this;
	}

	auto opUnary(string op)() const if (op == "+") {
		return this;
	}

	auto opUnary(string op)() const if (op == "-") {
		return TVec3!T(-x, -y, -z);
	}

	TVec2!T opDispatch(string member)() @property const
	if (member.length == 2) {
		import std.algorithm : all;

		static assert(member.all!(c => c >= 'x' && c <= 'z'));

		TVec2!T result;
		static foreach (i, char c; member) {
			result.components[i] = mixin("this." ~ c);
		}
		return result;
	}

	TVec3!T opDispatch(string member)() @property const
	if (member.length == 3) {
		import std.algorithm : all;

		static assert(member.all!(c => c >= 'x' && c <= 'z'));

		TVec3!T result;
		static foreach (i, char c; member) {
			result.components[i] = mixin("this." ~ c);
		}
		return result;
	}

	TVec4!T opDispatch(string member)() @property const
	if (member.length == 4) {
		import std.algorithm : all;

		static assert(member.all!(c => c >= 'x' && c <= 'z'));

		TVec4!T result;
		static foreach (i, char c; member) {
			result.components[i] = mixin("this." ~ c);
		}
		return result;
	}

	static if (is(typeof(T.init <= T.init))) {
		bool eq(TVec3!T other, T eps) const {
			return (this - other).magnitudeSq <= eps * eps;
		}
	}

	string toString() const @safe {
		import std.conv : text;
	
		return text("(", x, ", ", y, ", ", z, ")");
	}
}
