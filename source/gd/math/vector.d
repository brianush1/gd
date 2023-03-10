module gd.math.vector;
import gd.math.dimension;
import std.traits;
import std.math;

alias Vec2 = GVec2!double;
alias IVec2 = GVec2!int;
alias FVec2 = GVec2!float;
alias RVec2 = GVec2!real;

alias Vec3 = GVec3!double;
alias IVec3 = GVec3!int;
alias FVec3 = GVec3!float;
alias RVec3 = GVec3!real;

alias Vec4 = GVec4!double;
alias IVec4 = GVec4!int;
alias FVec4 = GVec4!float;
alias RVec4 = GVec4!real;

struct GVec2(T) {
	T[2] components = [0, 0];

	ref inout(T) x() inout @property { return components[0]; }
	ref inout(T) y() inout @property { return components[1]; }

	ref inout(T) opIndex(size_t index) inout {
		return components[index];
	}

	this(V)(GVec2!V base) {
		x = cast(T) base.x;
		y = cast(T) base.y;
	}

	this(T x, T y = 0) {
		this.x = x;
		this.y = y;
	}

	GVec2!T abs() const {
		import std.math : abs;

		return GVec2!T(x.abs, y.abs);
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
		GVec2!T normalize() const {
			if (magnitude == 0) {
				return this;
			}

			return this / magnitude;
		}

		GVec2!T round() const {
			import std.math : round;

			return GVec2!T(round(x), round(y));
		}
	}

	auto dot(R)(const(GVec2!R) rhs) const {
		return x * rhs.x + y * rhs.y;
	}

	auto opBinary(string op, R)(const(GVec2!R) rhs) const {
		alias ResT = typeof(mixin("cast(T) 0" ~ op ~ "cast(R) 0"));
		GVec2!ResT result;
		result.x = mixin("x" ~ op ~ "rhs.x");
		result.y = mixin("y" ~ op ~ "rhs.y");
		return result;
	}

	auto opBinary(string op, R)(const(R) rhs) const
	if (!is(R : const(GVec2!K), K) && is(typeof(mixin("cast(T) 0" ~ op ~ "cast(R) 0")))) {
		alias ResT = typeof(mixin("cast(T) 0" ~ op ~ "cast(R) 0"));
		GVec2!ResT result;
		result.x = mixin("x" ~ op ~ "rhs");
		result.y = mixin("y" ~ op ~ "rhs");
		return result;
	}

	auto opBinaryRight(string op, L)(const(L) lhs) const
	if (!is(L : const(GVec2!K), K) && is(typeof(mixin("cast(L) 0" ~ op ~ "cast(T) 0")))) {
		alias ResT = typeof(mixin("cast(L) 0" ~ op ~ "cast(T) 0"));
		GVec2!ResT result;
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
		return GVec2!T(-x, -y);
	}

	GVec2!T opDispatch(string member)() @property const
	if (member.length == 2) {
		import std.algorithm : all;

		static assert(member.all!(c => c >= 'x' && c <= 'y'));

		GVec2!T result;
		static foreach (i, char c; member) {
			result.components[i] = mixin("this." ~ c);
		}
		return result;
	}

	GVec3!T opDispatch(string member)() @property const
	if (member.length == 3) {
		import std.algorithm : all;

		static assert(member.all!(c => c >= 'x' && c <= 'y'));

		GVec3!T result;
		static foreach (i, char c; member) {
			result.components[i] = mixin("this." ~ c);
		}
		return result;
	}

	GVec4!T opDispatch(string member)() @property const
	if (member.length == 4) {
		import std.algorithm : all;

		static assert(member.all!(c => c >= 'x' && c <= 'y'));

		GVec4!T result;
		static foreach (i, char c; member) {
			result.components[i] = mixin("this." ~ c);
		}
		return result;
	}

	static if (is(typeof(T.init <= T.init))) {
		bool eq(GVec2!T other, T eps) const {
			return (this - other).magnitudeSq <= eps * eps;
		}
	}

	string toString() const @safe {
		import std.conv : text;
	
		return text("(", x, ", ", y, ")");
	}
}

struct GVec3(T) {
	T[3] components = [0, 0, 0];

	ref inout(T) x() inout @property { return components[0]; }
	ref inout(T) y() inout @property { return components[1]; }
	ref inout(T) z() inout @property { return components[2]; }

	ref inout(T) opIndex(size_t index) inout {
		return components[index];
	}

	this(T x, T y = 0, T z = 0) {
		this.x = x;
		this.y = y;
		this.z = z;
	}

	this(V)(GVec3!V base) {
		x = cast(T) base.x;
		y = cast(T) base.y;
		z = cast(T) base.z;
	}

	this(V)(GVec2!V v, T z = 0) {
		x = cast(T) v.x;
		y = cast(T) v.y;
		this.z = z;
	}

	this(V)(T x, GVec2!V v) {
		this.x = x;
		y = cast(T) v.x;
		z = cast(T) v.y;
	}

	GVec3!T abs() const {
		import std.math : abs;

		return GVec3!T(x.abs, y.abs, z.abs);
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
		GVec3!T normalize() const {
			if (magnitude == 0) {
				return this;
			}

			return this / magnitude;
		}
	}

	auto dot(R)(const(GVec3!R) rhs) const {
		return x * rhs.x + y * rhs.y + z * rhs.z;
	}

	auto cross(R)(const(GVec3!R) rhs) const {
		alias ResT = typeof(mixin("cast(T) 0 * cast(R) 0"));
		GVec3!ResT result;
		result.x = y * rhs.z - z * rhs.y;
		result.y = z * rhs.x - x * rhs.z;
		result.z = x * rhs.y - y * rhs.x;
		return result;
	}

	auto opBinary(string op, R)(const(GVec3!R) rhs) const {
		alias ResT = typeof(mixin("cast(T) 0" ~ op ~ "cast(R) 0"));
		GVec3!ResT result;
		result.x = mixin("x" ~ op ~ "rhs.x");
		result.y = mixin("y" ~ op ~ "rhs.y");
		result.z = mixin("z" ~ op ~ "rhs.z");
		return result;
	}

	auto opBinary(string op, R)(const(R) rhs) const
	if (!is(R : const(GVec3!K), K) && is(typeof(mixin("cast(T) 0" ~ op ~ "cast(R) 0")))) {
		alias ResT = typeof(mixin("cast(T) 0" ~ op ~ "cast(R) 0"));
		GVec3!ResT result;
		result.x = mixin("x" ~ op ~ "rhs");
		result.y = mixin("y" ~ op ~ "rhs");
		result.z = mixin("z" ~ op ~ "rhs");
		return result;
	}

	auto opBinaryRight(string op, L)(const(L) lhs) const
	if (!is(L : const(GVec3!K), K) && is(typeof(mixin("cast(L) 0" ~ op ~ "cast(T) 0")))) {
		alias ResT = typeof(mixin("cast(L) 0" ~ op ~ "cast(T) 0"));
		GVec3!ResT result;
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
		return GVec3!T(-x, -y, -z);
	}

	GVec2!T opDispatch(string member)() @property const
	if (member.length == 2) {
		import std.algorithm : all;

		static assert(member.all!(c => c >= 'x' && c <= 'z'));

		GVec2!T result;
		static foreach (i, char c; member) {
			result.components[i] = mixin("this." ~ c);
		}
		return result;
	}

	GVec3!T opDispatch(string member)() @property const
	if (member.length == 3) {
		import std.algorithm : all;

		static assert(member.all!(c => c >= 'x' && c <= 'z'));

		GVec3!T result;
		static foreach (i, char c; member) {
			result.components[i] = mixin("this." ~ c);
		}
		return result;
	}

	GVec4!T opDispatch(string member)() @property const
	if (member.length == 4) {
		import std.algorithm : all;

		static assert(member.all!(c => c >= 'x' && c <= 'z'));

		GVec4!T result;
		static foreach (i, char c; member) {
			result.components[i] = mixin("this." ~ c);
		}
		return result;
	}

	static if (is(typeof(T.init <= T.init))) {
		bool eq(GVec3!T other, T eps) const {
			return (this - other).magnitudeSq <= eps * eps;
		}
	}

	string toString() const @safe {
		import std.conv : text;
	
		return text("(", x, ", ", y, ", ", z, ")");
	}
}

struct GVec4(T) {
	T[4] components = [0, 0, 0, 0];

	ref inout(T) x() inout @property { return components[0]; }
	ref inout(T) y() inout @property { return components[1]; }
	ref inout(T) z() inout @property { return components[2]; }
	ref inout(T) w() inout @property { return components[3]; }

	ref inout(T) r() inout @property { return components[0]; }
	ref inout(T) g() inout @property { return components[1]; }
	ref inout(T) b() inout @property { return components[2]; }
	ref inout(T) a() inout @property { return components[3]; }

	ref inout(T) opIndex(size_t index) inout {
		return components[index];
	}

	this(T x, T y = 0, T z = 0, T w = 0) {
		this.x = x;
		this.y = y;
		this.z = z;
		this.w = w;
	}

	this(V)(GVec4!V base) {
		x = cast(T) base.x;
		y = cast(T) base.y;
		z = cast(T) base.z;
		w = cast(T) base.w;
	}

	this(V)(GVec3!V v, T w = 0) {
		x = cast(T) v.x;
		y = cast(T) v.y;
		z = cast(T) v.z;
		this.w = w;
	}

	this(V)(T x, GVec3!V v) {
		this.x = x;
		y = cast(T) v.x;
		z = cast(T) v.y;
		w = cast(T) v.z;
	}

	this(V1, V2)(GVec2!V1 v1, GVec2!V2 v2) {
		x = cast(T) v1.x;
		y = cast(T) v1.y;
		z = cast(T) v2.x;
		w = cast(T) v2.y;
	}

	this(V)(GVec2!V v, T z = 0, T w = 0) {
		x = cast(T) v.x;
		y = cast(T) v.y;
		this.z = z;
		this.w = w;
	}

	this(V)(T x, GVec2!V v, T w = 0) {
		this.x = x;
		y = cast(T) v.x;
		z = cast(T) v.y;
		this.w = w;
	}

	this(V)(T x, T y, GVec2!V v) {
		this.x = x;
		this.y = y;
		z = cast(T) v.x;
		w = cast(T) v.y;
	}

	GVec4!T abs() const {
		import std.math : abs;

		return GVec4!T(x.abs, y.abs, z.abs, w.abs);
	}

	static if (is(typeof(x < y))) {
		T min() const {
			import std.algorithm : min;

			return min(x, y, z, w);
		}

		T max() const {
			import std.algorithm : max;

			return max(x, y, z, w);
		}
	}

	static if (__traits(compiles, x * x)) {
		T magnitudeSq() @property const {
			return x * x + y * y + z * z + w * w;
		}

		T volume() @property const {
			return x * y * z * w;
		}
	}

	static if (isFloatingPoint!T) {
		T magnitude() @property const {
			import std.math : sqrt;

			return sqrt(x * x + y * y + z * z + w * w);
		}

		alias unit = normalize;
		GVec4!T normalize() const {
			if (magnitude == 0) {
				return this;
			}

			return this / magnitude;
		}
	}

	auto dot(R)(const(GVec4!R) rhs) const {
		return x * rhs.x + y * rhs.y + z * rhs.z + w * rhs.w;
	}

	auto opBinary(string op, R)(const(GVec4!R) rhs) const {
		alias ResT = typeof(mixin("cast(T) 0" ~ op ~ "cast(R) 0"));
		GVec4!ResT result;
		result.x = mixin("x" ~ op ~ "rhs.x");
		result.y = mixin("y" ~ op ~ "rhs.y");
		result.z = mixin("z" ~ op ~ "rhs.z");
		result.w = mixin("w" ~ op ~ "rhs.w");
		return result;
	}

	auto opBinary(string op, R)(const(R) rhs) const
	if (!is(R : const(GVec4!K), K) && is(typeof(mixin("cast(T) 0" ~ op ~ "cast(R) 0")))) {
		alias ResT = typeof(mixin("cast(T) 0" ~ op ~ "cast(R) 0"));
		GVec4!ResT result;
		result.x = mixin("x" ~ op ~ "rhs");
		result.y = mixin("y" ~ op ~ "rhs");
		result.z = mixin("z" ~ op ~ "rhs");
		result.w = mixin("w" ~ op ~ "rhs");
		return result;
	}

	auto opBinaryRight(string op, L)(const(L) lhs) const
	if (!is(L : const(GVec4!K), K) && is(typeof(mixin("cast(L) 0" ~ op ~ "cast(T) 0")))) {
		alias ResT = typeof(mixin("cast(L) 0" ~ op ~ "cast(T) 0"));
		GVec4!ResT result;
		result.x = mixin("lhs" ~ op ~ "x");
		result.y = mixin("lhs" ~ op ~ "y");
		result.z = mixin("lhs" ~ op ~ "z");
		result.w = mixin("lhs" ~ op ~ "w");
		return result;
	}

	auto opOpAssign(string op, T)(T value) {
		auto res = mixin("this" ~ op ~ "value");
		x = res.x;
		y = res.y;
		z = res.z;
		w = res.w;
		return this;
	}

	auto opUnary(string op)() const if (op == "+") {
		return this;
	}

	auto opUnary(string op)() const if (op == "-") {
		return GVec4!T(-x, -y, -z, -w);
	}

	GVec2!T opDispatch(string member)() @property const
	if (member.length == 2) {
		import std.algorithm : all;

		static assert(member.all!(c => c >= 'w' && c <= 'z'));

		GVec2!T result;
		static foreach (i, char c; member) {
			result.components[i] = mixin("this." ~ c);
		}
		return result;
	}

	GVec3!T opDispatch(string member)() @property const
	if (member.length == 3) {
		import std.algorithm : all;

		static assert(member.all!(c => c >= 'w' && c <= 'z'));

		GVec3!T result;
		static foreach (i, char c; member) {
			result.components[i] = mixin("this." ~ c);
		}
		return result;
	}

	GVec4!T opDispatch(string member)() @property const
	if (member.length == 4) {
		import std.algorithm : all;

		static assert(member.all!(c => c >= 'w' && c <= 'z'));

		GVec4!T result;
		static foreach (i, char c; member) {
			result.components[i] = mixin("this." ~ c);
		}
		return result;
	}

	static if (is(typeof(T.init <= T.init))) {
		bool eq(GVec4!T other, T eps) const {
			return (this - other).magnitudeSq <= eps * eps;
		}
	}

	string toString() const @safe {
		import std.conv : text;

		return text("(", x, ", ", y, ", ", z, ", ", w, ")");
	}
}
