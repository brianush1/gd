module gd.math.mat3;
import gd.math.mat4;
import gd.math.frame3;
import gd.math.vec3;
import std.traits;
import std.math;

alias Mat3 = TMat3!double;
alias IMat3 = TMat3!int;
alias FMat3 = TMat3!float;
alias RMat3 = TMat3!real;

struct TMat3(T) {
// fields:

	T[9] components = [
		1, 0, 0,
		0, 1, 0,
		0, 0, 1,
	];

// matrix constructors:

	this(T[9] components) {
		this.components = components;
	}

	this(V)(TMat3!V base) {
		foreach (i; 0 .. 9) {
			components[i] = cast(T) base.components[i];
		}
	}

	this(V)(TMat4!V base) {
		foreach (i; 0 .. 3) {
			foreach (j; 0 .. 3) {
				this[i, j] = cast(T) base[i, j];
			}
		}
	}

	this(V)(TFrame3!V base) {
		components = [
			base.right.x, base.up.x, base.forward.x,
			base.right.y, base.up.y, base.forward.y,
			base.right.z, base.up.z, base.forward.z,
		];
	}

	static if (isFloatingPoint!T) {
		static TMat3!T angles(T x, T y, T z) {
			if (y == 0 && z == 0) { // rotate X
				return TMat3!T([
					1, 0, 0,
					0, cos(x), -sin(x),
					0, sin(x), cos(x),
				]);
			}
			else if (x == 0 && z == 0) { // rotate Y
				return TMat3!T([
					cos(y), 0, sin(y),
					0, 1, 0,
					-sin(y), 0, cos(y),
				]);
			}
			else if (x == 0 && y == 0) { // rotate Z
				return TMat3!T([
					cos(z), -sin(z), 0,
					sin(z), cos(z), 0,
					0, 0, 1,
				]);
			}
			else { // rotate combination
				return TMat3!T.angles(x, 0, 0)
					* TMat3!T.angles(0, y, 0)
					* TMat3!T.angles(0, 0, z);
			}
		}
	}

	static TMat3!T scale(T x, T y, T z) { return scale(TVec3!T(x, y, z)); }
	static TMat3!T scale(T all) { return scale(TVec3!T(all, all, all)); }
	static TMat3!T scale(TVec3!T scale) {
		return TMat3!T([
			scale.x, 0, 0,
			0, scale.y, 0,
			0, 0, scale.z,
		]);
	}

// indexing:

	ref inout(T) opIndex(size_t r, size_t c) return inout {
		return components[r * 3 + c];
	}

	TVec3!T row(size_t r) const {
		return TVec3!T(this[r, 0], this[r, 1], this[r, 2]);
	}

	TVec3!T column(size_t c) const {
		return TVec3!T(this[0, c], this[1, c], this[2, c]);
	}

	TVec3!T right() const => column(0);

	TVec3!T up() const => column(1);

	TVec3!T forward() const => column(2);

// transformations:

	static if (isFloatingPoint!T) {
		static TMat3!T lookAt(TVec3!T value, TVec3!T up = TVec3!T(0, 1, 0)) {
			TVec3!T forward = value.unit;
			if (forward.magnitude < 1e-9)
				return TMat3!T();

			TVec3!T vx = forward.cross(up.unit);

			vx = vx.magnitude < 1e-9 ? TVec3!T(1, 0, 0) : vx.unit;

			TVec3!T vy = vx.cross(forward).unit;
			TVec3!T vz = vx.cross(vy).unit;

			return TMat3!T([
				vx.x, vy.x, vz.x,
				vx.y, vy.y, vz.y,
				vx.z, vy.z, vz.z,
			]);
		}

		static TMat3!T lookAt(T x, T y, T z) {
			return lookAt(TVec3!T(x, y, z));
		}
	}

// basic operations:

	auto opBinary(string op, R)(R other) const
	if (isNumeric!R && (op == "*" || op == "/" || op == "+" || op == "-")) {
		alias ResT = typeof(mixin("cast(T) 0 ", op, " cast(R) 0"));
		TMat3!ResT result;

		foreach (i; 0 .. 3) {
			foreach (j; 0 .. 3) {
				result[i, j] = mixin("this[i, j]", op, "other");
			}
		}

		return result;
	}

	auto opBinaryRight(string op, R)(R other) const
	if (isNumeric!R && (op == "*" || op == "/" || op == "+" || op == "-")) {
		alias ResT = typeof(mixin("cast(R) 0 ", op, " cast(T) 0"));
		TMat3!ResT result;

		foreach (i; 0 .. 3) {
			foreach (j; 0 .. 3) {
				result[i, j] = mixin("other", op, "this[i, j]");
			}
		}

		return result;
	}

	auto opBinary(string op, R)(TMat3!R other) const if (op == "+" || op == "-") {
		alias ResT = typeof(mixin("cast(T) 0 + cast(R) 0"));
		TMat3!ResT result;

		foreach (i; 0 .. 3) {
			foreach (j; 0 .. 3) {
				result[i, j] = this[i, j] + other[i, j];
			}
		}

		return result;
	}

	auto opBinary(string op, R)(TMat3!R other) const if (op == "*") {
		alias ResT = typeof(mixin("cast(T) 0 * cast(R) 0"));
		TMat3!ResT result;

		foreach (i; 0 .. 3) {
			foreach (j; 0 .. 3) {
				ResT dot = 0;
				foreach (k; 0 .. 3) {
					dot += this[i, k] * other[k, j];
				}
				result[i, j] = dot;
			}
		}

		return result;
	}

	auto opBinary(string op, R)(TVec3!R other) const if (op == "*") {
		alias ResT = typeof(mixin("cast(T) 0 * cast(R) 0"));
		TVec3!ResT result;

		foreach (i; 0 .. 3) {
			ResT dot = 0;
			foreach (k; 0 .. 3) {
				dot += this[i, k] * other[k];
			}
			result[i] = dot;
		}

		return result;
	}

	auto opOpAssign(string op, T)(T value) {
		*this = mixin("*this ", op, " value");
		return this;
	}

	// TODO: inverse

	TMat3!T transpose() const {
		return TMat3!T([
			this[0, 0], this[1, 0], this[2, 0],
			this[0, 1], this[1, 1], this[2, 1],
			this[0, 2], this[1, 2], this[2, 2],
		]);
	}

	T trace() const {
		return this[0, 0] + this[1, 1] + this[2, 2];
	}

	static if (isFloatingPoint!T) {
		Vec3 getEulerZYX() {
			Vec3 result;
			if (abs(this[2, 0]) >= 1) {
				result.z = 0;

				double delta = atan2(this[0, 0], this[0, 2]);
				if (this[2, 0] > 0) {
					result.y = PI_2;
					result.x = result.y + delta;
				}
				else {
					result.y = -PI_2;
					result.x = -result.y + delta;
				}
			}
			else {
				result.y = -asin(this[2, 0]);
				result.x = atan2(this[2, 1] / cos(result.y), this[2, 2] / cos(result.y));
				result.z = atan2(this[1, 0] / cos(result.y), this[0, 0] / cos(result.y));
			}
			return result;
		}
	}

// conversions:

	string toString() const {
		import std.conv : text;

		string[] lines;

		foreach (row; 0 .. 3) {
			lines ~= "";
		}
		foreach_reverse (col; 0 .. 3) {
			foreach (row; 0 .. 3) {
				import std.math : abs;

				if (abs(this[row, col]) < 1e-9) {
					lines[row] = "0" ~ lines[row];
				}
				else {
					lines[row] = text(this[row, col]) ~ lines[row];
				}
			}
			size_t maxLen = 0;
			foreach (row; 0 .. 3) {
				if (lines[row].length > maxLen) {
					maxLen = lines[row].length;
				}
			}
			foreach (row; 0 .. 3) {
				size_t len = lines[row].length;
				foreach (i; 0 .. (maxLen - len + 1)) {
					lines[row] = " " ~ lines[row];
				}
			}
		}

		string res;
		foreach (line; lines) {
			res ~= line[1 .. $] ~ "\n";
		}
		return "\n" ~ res[0 .. $ - 1];
	}

}
