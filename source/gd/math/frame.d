module gd.math.frame;
import gd.math.vec;
import std.traits;
import std.math;

alias Frame3 = TFrame3!double;
alias IFrame3 = TFrame3!int;
alias FFrame3 = TFrame3!float;
alias RFrame3 = TFrame3!real;

struct TFrame3(T) {
// fields:

	TVec3!T position = TVec3!T(0, 0, 0);
	TVec3!T right = TVec3!T(1, 0, 0);
	TVec3!T up = TVec3!T(0, 1, 0);
	TVec3!T forward = TVec3!T(0, 0, 1);

// frame constructors:

	this(V)(TVec3!V position) { this.position = TVec3!T(position); }
	this(T x, T y, T z) { position = TVec3!T(x, y, z); }

	this(V)(TVec3!V position, TVec3!T right, TVec3!T up, TVec3!T forward) {
		this.position = TVec3!T(position);
		this.right = TVec3!T(right);
		this.up = TVec3!T(up);
		this.forward = TVec3!T(forward);
	}

	this(V)(TFrame3!V base) {
		position = TVec3!T(base.position);
		right = TVec3!T(base.right);
		up = TVec3!T(base.up);
		forward = TVec3!T(base.forward);
	}

	static if (isFloatingPoint!T) {
		static TFrame3!T angles(T x, T y, T z) {
			TFrame3!T result;
			if (y == 0 && z == 0) { // rotate X
				result.up = TVec3!T(0, cos(x), sin(x));
				result.forward = TVec3!T(0, -sin(x), cos(x));
			}
			else if (x == 0 && z == 0) { // rotate Y
				result.right = TVec3!T(cos(y), 0, -sin(y));
				result.forward = TVec3!T(sin(y), 0, cos(y));
			}
			else if (x == 0 && y == 0) { // rotate Z
				result.right = TVec3!T(cos(z), sin(z), 0);
				result.up = TVec3!T(-sin(z), cos(z), 0);
			}
			else { // rotate combination
				return TFrame3!T.angles(x, 0, 0)
					* TFrame3!T.angles(0, y, 0)
					* TFrame3!T.angles(0, 0, z);
			}
			return result;
		}
	}

// transformations:

	static if (isFloatingPoint!T) {
		TFrame3!T lookAt(TVec3!T value, TVec3!T up = TVec3!T(0, 1, 0)) const {
			TVec3!T direction = (value - position).unit;
			if (direction.magnitude < 1e-9)
				return TFrame3!T(position);

			TVec3!T vx = direction.cross(up.unit);
			vx = vx.magnitude < 1e-9 ? TVec3!T(1, 0, 0) : vx.unit;

			TVec3!T vy = vx.cross(direction).unit;
			TVec3!T vz = vx.cross(vy).unit;

			return TFrame3!T(position, vx, vy, vz);
		}

		TFrame3!T lookAt(T x, T y, T z) const { return lookAt(TVec3!T(x, y, z)); }
	}

// basic operations:

	auto opBinary(string op, R)(TFrame3!R other) const if (op == "*") {
		alias ResT = typeof(mixin("cast(T) 0 * cast(R) 0"));
		auto mat = TVec3!(TVec3!T)(right, up, forward);
		return TFrame3!ResT(
			mat.dot(other.position) + position,
			mat.dot(other.right),
			mat.dot(other.up),
			mat.dot(other.forward),
		);
	}

	TFrame3!T inverse() const {
		T determinantRecip = right.magnitudeSq;
		return TFrame3!T(
			TVec3!T(position.dot(right), position.dot(up), position.dot(forward)) / -determinantRecip,
			TVec3!T(right.x, up.x, forward.x) / determinantRecip,
			TVec3!T(right.y, up.y, forward.y) / determinantRecip,
			TVec3!T(right.z, up.z, forward.z) / determinantRecip,
		);
	}

	TFrame3!T translate(T x, T y, T z) const { return translate(TVec3!T(x, y, z)); }
	auto translate(R)(TVec3!R vec) const {
		alias ResT = typeof(mixin("cast(T) 0 + cast(R) 0"));
		TFrame3!ResT result = this;
		result.position = position + vec;
		return result;
	}

// conversions:

	static if (isFloatingPoint!T) {
		// TODO: this is untested
		TVec4!T toQuaternion() const {
			import std.algorithm : max;

			double sign(double x) {
				return x < 0 ? -1
					: x > 0 ? 1
					: x; // 0 or NaN
			}

			TVec4!T result = TVec4!T(
				sqrt(max(0, 1 + right.x - up.y - forward.z)) / 2,
				sqrt(max(0, 1 - right.x + up.y - forward.z)) / 2,
				sqrt(max(0, 1 - right.x - up.y + forward.z)) / 2,
				sqrt(max(0, 1 + right.x + up.y + forward.z)) / 2,
			);

			result.x *= sign(result.x * (up.z - forward.y));
			result.x *= sign(result.y * (forward.x - right.z));
			result.x *= sign(result.z * (right.y - up.x));

			return result;
		}
	}

	string toString() const {
		import std.conv : text;

		return text(position, ", ", right, ", ", up, ", ", forward);
	}

}
