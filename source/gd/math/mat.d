module gd.math.mat;
import gd.math.frame;
import gd.math.vec;
import std.traits;
import std.math;

alias Mat4 = TMat4!double;
alias IMat4 = TMat4!int;
alias FMat4 = TMat4!float;
alias RMat4 = TMat4!real;

// TODO: opOpAssign

struct TMat4(T) {
// fields:

	T[16] components = [
		1, 0, 0, 0,
		0, 1, 0, 0,
		0, 0, 1, 0,
		0, 0, 0, 1,
	];

// matrix constructors:

	this(T[16] components) {
		this.components = components;
	}

	this(V)(TMat4!V base) {
		foreach (i; 0 .. 16) {
			components[i] = cast(T) base.components[i];
		}
	}

	this(V)(TFrame3!V base) {
		components = [
			base.right.x, base.up.x, base.forward.x, base.position.x,
			base.right.y, base.up.y, base.forward.y, base.position.y,
			base.right.z, base.up.z, base.forward.z, base.position.z,
			0, 0, 0, 1,
		];
	}

	this(T x, T y, T z) { this(TVec3!T(x, y, z)); }
	this(TVec3!T position) {
		components = [
			1, 0, 0, position.x,
			0, 1, 0, position.y,
			0, 0, 1, position.z,
			0, 0, 0, 1,
		];
	}

	static if (isFloatingPoint!T) {
		/**
		* Creates a perspective projection matrix
		*
		* Params:
		*   fov = Field of view, in radians; 0 < fov < PI
		*   aspectRatio = Viewport aspect ratio (width / height); aspectRatio > 0
		*   near = The Z-coordinate of the near clipping plane; near > 0
		*   far = The Z-coordinate of the far clipping plane; far > near
		* Returns: A perspective matrix with the given parameters, or the identity matrix if any parameters are out of range
		*/
		static TMat4!T perspective(T fov, T aspectRatio, T near, T far) {
			if (0 >= fov || fov >= PI || aspectRatio <= 0 || near <= 0 || far <= near) {
				return TMat4!T.init;
			}

			T y = 1 / tan(fov / 2);
			return TMat4!T([
				y / aspectRatio, 0, 0, 0,
				0, y, 0, 0,
				0, 0, -far / (far - near), -2 * near * far / (far - near),
				0, 0, -1, 0,
			]);
		}

		static TMat4!T orthographic(T left, T right, T bottom, T top, T near, T far) {
			return TMat4!T([
				2.0 / (right - left), 0, 0, -(right + left) / (right - left),
				0, 2.0 / (top - bottom), 0, -(top + bottom) / (top - bottom),
				0, 0, -2.0 / (far - near), -(far + near) / (far - near),
				0, 0, 0, 1.0,
			]);
		}

		static TMat4!T orthographic(Vec2 viewPlaneSize, T near, T far) {
			return orthographic(
				-viewPlaneSize.x / 2, viewPlaneSize.x / 2,
				-viewPlaneSize.y / 2, viewPlaneSize.y / 2,
				near, far,
			);
		}

		static TMat4!T angles(T x, T y, T z) {
			if (y == 0 && z == 0) { // rotate X
				return TMat4!T([
					1, 0, 0, 0,
					0, cos(x), -sin(x), 0,
					0, sin(x), cos(x), 0,
					0, 0, 0, 1,
				]);
			}
			else if (x == 0 && z == 0) { // rotate Y
				return TMat4!T([
					cos(y), 0, sin(y), 0,
					0, 1, 0, 0,
					-sin(y), 0, cos(y), 0,
					0, 0, 0, 1,
				]);
			}
			else if (x == 0 && y == 0) { // rotate Z
				return TMat4!T([
					cos(z), -sin(z), 0, 0,
					sin(z), cos(z), 0, 0,
					0, 0, 1, 0,
					0, 0, 0, 1,
				]);
			}
			else { // rotate combination
				return TMat4!T.angles(x, 0, 0)
					* TMat4!T.angles(0, y, 0)
					* TMat4!T.angles(0, 0, z);
			}
		}
	}

	static TMat4!T scale(T x, T y, T z) { return scale(TVec3!T(x, y, z)); }
	static TMat4!T scale(T all) { return scale(TVec3!T(all, all, all)); }
	static TMat4!T scale(TVec3!T scale) {
		return TMat4!T([
			scale.x, 0, 0, 0,
			0, scale.y, 0, 0,
			0, 0, scale.z, 0,
			0, 0, 0, 1,
		]);
	}

// indexing:

	ref inout(T) opIndex(size_t r, size_t c) return inout {
		return components[r * 4 + c];
	}

	TVec4!T row(size_t r) const {
		return TVec4!T(this[r, 0], this[r, 1], this[r, 2], this[r, 3]);
	}

	TVec4!T column(size_t c) const {
		return TVec4!T(this[0, c], this[1, c], this[2, c], this[3, c]);
	}

	TVec3!T position() const {
		return column(3).xyz;
	}

	TVec3!T right() const {
		return column(0).xyz;
	}

	TVec3!T up() const {
		return column(1).xyz;
	}

	TVec3!T forward() const {
		return column(2).xyz;
	}

// transformations:

	static if (isFloatingPoint!T) {
		TMat4!T lookAt(TVec3!T value, TVec3!T up = TVec3!T(0, 1, 0)) const {
			TVec3!T forward = (value - position).unit;
			if (forward.magnitude < 1e-9)
				return TMat4!T(position);

			TVec3!T vx = forward.cross(up.unit);

			vx = vx.magnitude < 1e-9 ? TVec3!T(1, 0, 0) : vx.unit;

			TVec3!T vy = vx.cross(forward).unit;
			TVec3!T vz = vx.cross(vy).unit;

			return TMat4!T([
				vx.x, vy.x, vz.x, position.x,
				vx.y, vy.y, vz.y, position.y,
				vx.z, vy.z, vz.z, position.z,
				0, 0, 0, 1,
			]);
		}

		TMat4!T lookAt(T x, T y, T z) const {
			return lookAt(TVec3!T(x, y, z));
		}
	}

// basic operations:

	auto opBinary(string op, R)(TMat4!R other) const if (op == "*") {
		alias ResT = typeof(mixin("cast(T) 0 * cast(R) 0"));
		TMat4!ResT result;

		foreach (i; 0 .. 4) {
			foreach (j; 0 .. 4) {
				ResT dot = 0;
				foreach (k; 0 .. 4) {
					dot += this[i, k] * other[k, j];
				}
				result[i, j] = dot;
			}
		}

		return result;
	}

	auto opBinary(string op, R)(TVec4!R other) const if (op == "*") {
		alias ResT = typeof(mixin("cast(T) 0 * cast(R) 0"));
		TVec4!ResT result;

		foreach (i; 0 .. 4) {
			ResT dot = 0;
			foreach (k; 0 .. 4) {
				dot += this[i, k] * other[k];
			}
			result[i] = dot;
		}

		return result;
	}

	TMat4!T inverse() const {
		T M_00 = this[1, 1] * this[2, 2] * this[3, 3] - this[1, 1] * this[3, 2] * this[2, 3]
			- this[1, 2] * this[2, 1] * this[3, 3] + this[1, 2] * this[3, 1] * this[2, 3]
			+ this[1, 3] * this[2, 1] * this[3, 2] - this[1, 3] * this[3, 1] * this[2, 2];

		T M_01 = -this[0, 1] * this[2, 2] * this[3, 3] + this[0, 1] * this[3, 2] * this[2, 3]
			+ this[0, 2] * this[2, 1] * this[3, 3] - this[0, 2] * this[3, 1] * this[2, 3]
			- this[0, 3] * this[2, 1] * this[3, 2] + this[0, 3] * this[3, 1] * this[2, 2];

		T M_02 = this[0, 1] * this[1, 2] * this[3, 3] - this[0, 1] * this[3, 2] * this[1, 3]
			- this[0, 2] * this[1, 1] * this[3, 3] + this[0, 2] * this[3, 1] * this[1, 3]
			+ this[0, 3] * this[1, 1] * this[3, 2] - this[0, 3] * this[3, 1] * this[1, 2];

		T M_03 = -this[0, 1] * this[1, 2] * this[2, 3] + this[0, 1] * this[2, 2] * this[1, 3]
			+ this[0, 2] * this[1, 1] * this[2, 3] - this[0, 2] * this[2, 1] * this[1, 3]
			- this[0, 3] * this[1, 1] * this[2, 2] + this[0, 3] * this[2, 1] * this[1, 2];

		T M_10 = -this[1, 0] * this[2, 2] * this[3, 3] + this[1, 0] * this[3, 2] * this[2, 3]
			+ this[1, 2] * this[2, 0] * this[3, 3] - this[1, 2] * this[3, 0] * this[2, 3]
			- this[1, 3] * this[2, 0] * this[3, 2] + this[1, 3] * this[3, 0] * this[2, 2];

		T M_11 = this[0, 0] * this[2, 2] * this[3, 3] - this[0, 0] * this[3, 2] * this[2, 3]
			- this[0, 2] * this[2, 0] * this[3, 3] + this[0, 2] * this[3, 0] * this[2, 3]
			+ this[0, 3] * this[2, 0] * this[3, 2] - this[0, 3] * this[3, 0] * this[2, 2];

		T M_12 = -this[0, 0] * this[1, 2] * this[3, 3] + this[0, 0] * this[3, 2] * this[1, 3]
			+ this[0, 2] * this[1, 0] * this[3, 3] - this[0, 2] * this[3, 0] * this[1, 3]
			- this[0, 3] * this[1, 0] * this[3, 2] + this[0, 3] * this[3, 0] * this[1, 2];

		T M_13 = this[0, 0] * this[1, 2] * this[2, 3] - this[0, 0] * this[2, 2] * this[1, 3]
			- this[0, 2] * this[1, 0] * this[2, 3] + this[0, 2] * this[2, 0] * this[1, 3]
			+ this[0, 3] * this[1, 0] * this[2, 2] - this[0, 3] * this[2, 0] * this[1, 2];

		T M_20 = this[1, 0] * this[2, 1] * this[3, 3] - this[1, 0] * this[3, 1] * this[2, 3]
			- this[1, 1] * this[2, 0] * this[3, 3] + this[1, 1] * this[3, 0] * this[2, 3]
			+ this[1, 3] * this[2, 0] * this[3, 1] - this[1, 3] * this[3, 0] * this[2, 1];

		T M_21 = -this[0, 0] * this[2, 1] * this[3, 3] + this[0, 0] * this[3, 1] * this[2, 3]
			+ this[0, 1] * this[2, 0] * this[3, 3] - this[0, 1] * this[3, 0] * this[2, 3]
			- this[0, 3] * this[2, 0] * this[3, 1] + this[0, 3] * this[3, 0] * this[2, 1];

		T M_22 = this[0, 0] * this[1, 1] * this[3, 3] - this[0, 0] * this[3, 1] * this[1, 3]
			- this[0, 1] * this[1, 0] * this[3, 3] + this[0, 1] * this[3, 0] * this[1, 3]
			+ this[0, 3] * this[1, 0] * this[3, 1] - this[0, 3] * this[3, 0] * this[1, 1];

		T M_23 = -this[0, 0] * this[1, 1] * this[2, 3] + this[0, 0] * this[2, 1] * this[1, 3]
			+ this[0, 1] * this[1, 0] * this[2, 3] - this[0, 1] * this[2, 0] * this[1, 3]
			- this[0, 3] * this[1, 0] * this[2, 1] + this[0, 3] * this[2, 0] * this[1, 1];

		T M_30 = -this[1, 0] * this[2, 1] * this[3, 2] + this[1, 0] * this[3, 1] * this[2, 2]
			+ this[1, 1] * this[2, 0] * this[3, 2] - this[1, 1] * this[3, 0] * this[2, 2]
			- this[1, 2] * this[2, 0] * this[3, 1] + this[1, 2] * this[3, 0] * this[2, 1];

		T M_31 = this[0, 0] * this[2, 1] * this[3, 2] - this[0, 0] * this[3, 1] * this[2, 2]
			- this[0, 1] * this[2, 0] * this[3, 2] + this[0, 1] * this[3, 0] * this[2, 2]
			+ this[0, 2] * this[2, 0] * this[3, 1] - this[0, 2] * this[3, 0] * this[2, 1];

		T M_32 = -this[0, 0] * this[1, 1] * this[3, 2] + this[0, 0] * this[3, 1] * this[1, 2]
			+ this[0, 1] * this[1, 0] * this[3, 2] - this[0, 1] * this[3, 0] * this[1, 2]
			- this[0, 2] * this[1, 0] * this[3, 1] + this[0, 2] * this[3, 0] * this[1, 1];

		T M_33 = this[0, 0] * this[1, 1] * this[2, 2] - this[0, 0] * this[2, 1] * this[1, 2]
			- this[0, 1] * this[1, 0] * this[2, 2] + this[0, 1] * this[2, 0] * this[1, 2]
			+ this[0, 2] * this[1, 0] * this[2, 1] - this[0, 2] * this[2, 0] * this[1, 1];

		T determinantRecip = this[0, 0] * M_00 + this[1, 0] * M_01 + this[2, 0] * M_02 + this[3, 0] * M_03;
		if (determinantRecip == 0)
			return TMat4!T.init;

		return TMat4!T([
			M_00 / determinantRecip, M_01 / determinantRecip, M_02 / determinantRecip, M_03 / determinantRecip,
			M_10 / determinantRecip, M_11 / determinantRecip, M_12 / determinantRecip, M_13 / determinantRecip,
			M_20 / determinantRecip, M_21 / determinantRecip, M_22 / determinantRecip, M_23 / determinantRecip,
			M_30 / determinantRecip, M_31 / determinantRecip, M_32 / determinantRecip, M_33 / determinantRecip,
		]);
	}

	TMat4!T transpose() const {
		return TMat4!T([
			this[0, 0], this[1, 0], this[2, 0], this[3, 0],
			this[0, 1], this[1, 1], this[2, 1], this[3, 1],
			this[0, 2], this[1, 2], this[2, 2], this[3, 2],
			this[0, 3], this[1, 3], this[2, 3], this[3, 3],
		]);
	}

	auto translate(R)(TVec3!R vec) const {
		alias ResT = typeof(mixin("cast(T) 0 + cast(R) 0"));
		TMat4!ResT result = this;
		result[0, 3] = this[0, 3] + vec.x;
		result[1, 3] = this[1, 3] + vec.y;
		result[2, 3] = this[2, 3] + vec.z;
		return result;
	}

	TMat4!T translate(T x, T y, T z) const {
		return translate(TVec3!T(x, y, z));
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
				sqrt(max(0, 1 + this[0, 0] - this[1, 1] - this[2, 2])) / 2,
				sqrt(max(0, 1 - this[0, 0] + this[1, 1] - this[2, 2])) / 2,
				sqrt(max(0, 1 - this[0, 0] - this[1, 1] + this[2, 2])) / 2,
				sqrt(max(0, 1 + this[0, 0] + this[1, 1] + this[2, 2])) / 2,
			);

			result.x *= sign(result.x * (this[2, 1] - this[1, 2]));
			result.x *= sign(result.y * (this[0, 2] - this[2, 0]));
			result.x *= sign(result.z * (this[1, 0] - this[0, 1]));

			return result;
		}
	}

	string toString() const {
		import std.conv : text;

		string[] lines;

		foreach (row; 0 .. 4) {
			lines ~= "";
		}
		foreach_reverse (col; 0 .. 4) {
			foreach (row; 0 .. 4) {
				import std.math : abs;

				if (abs(this[row, col]) < 1e-9) {
					lines[row] = "0" ~ lines[row];
				}
				else {
					lines[row] = text(this[row, col]) ~ lines[row];
				}
			}
			size_t maxLen = 0;
			foreach (row; 0 .. 4) {
				if (lines[row].length > maxLen) {
					maxLen = lines[row].length;
				}
			}
			foreach (row; 0 .. 4) {
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
