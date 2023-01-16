module gd.math.matrix;
import gd.math.vector;
import std.traits;
import std.math;

alias Mat4 = GMat4!double;
alias IMat4 = GMat4!int;
alias FMat4 = GMat4!float;
alias RMat4 = GMat4!real;

alias Frame3 = GFrame3!double;
alias IFrame3 = GFrame3!int;
alias FFrame3 = GFrame3!float;
alias RFrame3 = GFrame3!real;

// alias Mat3 = GMat3!double;
// alias IMat3 = GMat3!int;
// alias FMat3 = GMat3!float;
// alias RMat3 = GMat3!real;

alias Frame2 = GFrame2!double;
alias IFrame2 = GFrame2!int;
alias FFrame2 = GFrame2!float;
alias RFrame2 = GFrame2!real;

struct GFrame2(T) {
// fields:

	GVec2!T right;
	GVec2!T up;
	GVec2!T position;

// matrix constructors:

	this(V)(GFrame2!V base) {
		right = GVec2!T(base.right);
		up = GVec2!T(base.up);
		position = GVec2!T(base.position);
	}

	static GFrame2!T fromVectors(
		GVec2!T right,
		GVec2!T up,
		GVec2!T position,
	) {
		GFrame2!T result;
		result.right = right;
		result.up = up;
		result.position = position;
		return result;
	}

	static GFrame2!T fromComponents(
		T m00, T m01, T m02,
		T m10, T m11, T m12,
	) {
		return GFrame2!T.fromVectors(
			GVec2!T(m00, m10),
			GVec2!T(m01, m11),
			GVec2!T(m02, m12),
		);
	}

	static if (isFloatingPoint!T) {
		static GFrame2!T rotate(T theta) {
			return GFrame2!T.fromComponents(
				cos(-theta), sin(-theta), 0,
				-sin(-theta), cos(-theta), 0,
			);
		}
	}

	static GFrame2!T fromPosition(GVec2!T position) {
		return GFrame2!T.fromComponents(
			1, 0, position.x,
			0, 1, position.y,
		);
	}

	static GFrame2!T fromPosition(T x, T y) {
		return fromPosition(GVec2!T(x, y));
	}

// basic operations:

	/**

	Generalized GFrame2!T multiplication

	This method multiplies this frame by the given parameter and returns the result.

	*/
	auto mul(R)(GFrame2!R other) const {
		alias ResT = typeof(mixin("cast(T) 0 * cast(R) 0"));
		auto mat = GVec2!(GVec2!T)(right, up);
		return GFrame2!ResT.fromVectors(
			mat.dot(other.right),
			mat.dot(other.up),
			mat.dot(other.position) + position,
		);
	}

	GFrame2!T inverse() const {
		T determinantRecip = right.magnitudeSq;
		return GFrame2!T.fromVectors(
			GVec2!T(right.x, up.x) / determinantRecip,
			GVec2!T(right.y, up.y) / determinantRecip,
			GVec2!T(position.dot(right), position.dot(up)) / -determinantRecip,
		);
	}

	auto translate(R)(GVec2!R vec) const {
		alias ResT = typeof(mixin("cast(T) 0 + cast(R) 0"));
		GFrame2!ResT result = this;
		result.position = position + vec;
		return result;
	}

	GFrame2!T translate(T x, T y) const {
		return translate(GVec2!T(x, y));
	}

// conversions:

	string toString() const {
		import std.conv : text;

		return text(position, ", ", right, ", ", up);
	}

}

struct GMat4(T) {
// fields:

	private T[16] flat = [
		1, 0, 0, 0,
		0, 1, 0, 0,
		0, 0, 1, 0,
		0, 0, 0, 1,
	];

// matrix constructors:

	this(V)(GMat4!V base) {
		foreach (i; 0 .. 16) {
			flat[i] = cast(T) base.flat[i];
		}
	}

	this(V)(GFrame3!V base) {
		flat = [
			base.right.x, base.up.x, base.forward.x, base.position.x,
			base.right.y, base.up.y, base.forward.y, base.position.y,
			base.right.z, base.up.z, base.forward.z, base.position.z,
			0, 0, 0, 1,
		];
	}

	static GMat4!T fromComponents(
		T m00, T m01, T m02, T m03,
		T m10, T m11, T m12, T m13,
		T m20, T m21, T m22, T m23,
		T m30, T m31, T m32, T m33,
	) {
		GMat4!T result;
		result.flat = [
			m00, m01, m02, m03,
			m10, m11, m12, m13,
			m20, m21, m22, m23,
			m30, m31, m32, m33,
		];
		return result;
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
		static GMat4!T perspectiveProjection(T fov, T aspectRatio, T near, T far) {
			if (0 >= fov || fov >= PI || aspectRatio <= 0 || near <= 0 || far <= near) {
				return GMat4!T.init;
			}

			T y = 1 / tan(fov / 2);
			return GMat4!T.fromComponents(
				y / aspectRatio, 0, 0, 0,
				0, y, 0, 0,
				0, 0, -far / (far - near), -2 * near * far / (far - near),
				0, 0, -1, 0,
			);
		}

		static GMat4!T orthographicProjection(T left, T right, T bottom, T top, T near, T far) {
			return GMat4!T.fromComponents(
				2.0 / (right - left), 0, 0, -(right + left) / (right - left),
				0, 2.0 / (top - bottom), 0, -(top + bottom) / (top - bottom),
				0, 0, -2.0 / (far - near), -(far + near) / (far - near),
				0, 0, 0, 1.0,
			);
		}

		static GMat4!T orthographicProjection(Vec2 viewPlaneSize, T near, T far) {
			return orthographicProjection(
				-viewPlaneSize.x / 2, viewPlaneSize.x / 2,
				-viewPlaneSize.y / 2, viewPlaneSize.y / 2,
				near, far,
			);
		}

		static GMat4!T fromEulerAngles(T x, T y, T z) {
			if (y == 0 && z == 0) { // rotate X
				return GMat4!T.fromComponents(
					1, 0, 0, 0,
					0, cos(-x), sin(-x), 0,
					0, -sin(-x), cos(-x), 0,
					0, 0, 0, 1,
				);
			}
			else if (x == 0 && z == 0) { // rotate Y
				return GMat4!T.fromComponents(
					cos(-y), 0, -sin(-y), 0,
					0, 1, 0, 0,
					sin(-y), 0, cos(-y), 0,
					0, 0, 0, 1,
				);
			}
			else if (x == 0 && y == 0) { // rotate Z
				return GMat4!T.fromComponents(
					cos(-z), sin(-z), 0, 0,
					-sin(-z), cos(-z), 0, 0,
					0, 0, 1, 0,
					0, 0, 0, 1,
				);
			}
			else { // rotate combination
				return GMat4!T.fromEulerAngles(x, 0, 0)
					.mul(GMat4!T.fromEulerAngles(0, y, 0))
					.mul(GMat4!T.fromEulerAngles(0, 0, z));
			}
		}
	}

	static GMat4!T fromPosition(GVec3!T position) {
		return GMat4!T.fromComponents(
			1, 0, 0, position.x,
			0, 1, 0, position.y,
			0, 0, 1, position.z,
			0, 0, 0, 1,
		);
	}

	static GMat4!T fromPosition(T x, T y, T z) {
		return fromPosition(GVec3!T(x, y, z));
	}

// indexing:

	ref inout(T) opIndex(size_t r, size_t c) return inout {
		return flat[r * 4 + c];
	}

	GVec4!T row(size_t r) const {
		return GVec4!T(this[r, 0], this[r, 1], this[r, 2], this[r, 3]);
	}

	GVec4!T column(size_t c) const {
		return GVec4!T(this[0, c], this[1, c], this[2, c], this[3, c]);
	}

	GVec3!T position() const {
		return column(3).xyz;
	}

	GVec3!T right() const {
		return column(0).xyz;
	}

	GVec3!T up() const {
		return column(1).xyz;
	}

	GVec3!T forward() const {
		return column(2).xyz;
	}

// transformations:

	static if (isFloatingPoint!T) {
		GMat4!T lookAt(GVec3!T value, GVec3!T up = GVec3!T(0, 1, 0)) const {
			GVec3!T forward = (value - position).unit;
			if (forward.magnitude < 1e-9) {
				return GMat4!T.fromPosition(position);
			}

			GVec3!T vx = forward.cross(up.unit);

			if (vx.magnitude < 1e-9) {
				vx = GVec3!T(1, 0, 0);
			}
			else {
				vx = vx.unit;
			}

			GVec3!T vy = vx.cross(forward).unit;
			GVec3!T vz = vx.cross(vy).unit;

			return GMat4!T.fromComponents(
				vx.x, vy.x, vz.x, position.x,
				vx.y, vy.y, vz.y, position.y,
				vx.z, vy.z, vz.z, position.z,
				0, 0, 0, 1,
			);
		}

		GMat4!T lookAt(T x, T y, T z) const {
			return lookAt(GVec3!T(x, y, z));
		}
	}

// basic operations:

	/**

	Generalized GMat4!T multiplication

	This method multiplies this matrix by the given parameter and returns the result.

	*/
	auto mul(R)(GMat4!R other) const {
		alias ResT = typeof(mixin("cast(T) 0 * cast(R) 0"));
		GMat4!ResT result;

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

	GMat4!T inverse() const {
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
			return GMat4!T.init;

		return GMat4!T.fromComponents(
			M_00 / determinantRecip, M_01 / determinantRecip, M_02 / determinantRecip, M_03 / determinantRecip,
			M_10 / determinantRecip, M_11 / determinantRecip, M_12 / determinantRecip, M_13 / determinantRecip,
			M_20 / determinantRecip, M_21 / determinantRecip, M_22 / determinantRecip, M_23 / determinantRecip,
			M_30 / determinantRecip, M_31 / determinantRecip, M_32 / determinantRecip, M_33 / determinantRecip,
		);
	}

	auto translate(R)(GVec3!R vec) const {
		alias ResT = typeof(mixin("cast(T) 0 + cast(R) 0"));
		GMat4!ResT result = this;
		result[0, 3] = this[0, 3] + vec.x;
		result[1, 3] = this[1, 3] + vec.y;
		result[2, 3] = this[2, 3] + vec.z;
		return result;
	}

	GMat4!T translate(T x, T y, T z) const {
		return translate(GVec3!T(x, y, z));
	}

// conversions:

	static if (isFloatingPoint!T) {
		GVec4!T toQuaternion() const {
			import std.algorithm : max;

			double sign(double x) {
				if (x < 0) {
					return -1;
				}
				else if (x > 0) {
					return 1;
				}
				else {
					return x; // 0 or NaN
				}
			}

			GVec4!T result = GVec4!T(
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

struct GFrame3(T) {
// fields:

	GVec3!T right;
	GVec3!T up;
	GVec3!T forward;
	GVec3!T position;

// matrix constructors:

	this(V)(GFrame3!V base) {
		right = GVec3!T(base.right);
		up = GVec3!T(base.up);
		forward = GVec3!T(base.forward);
		position = GVec3!T(base.position);
	}

	static GFrame3!T fromVectors(
		GVec3!T right,
		GVec3!T up,
		GVec3!T forward,
		GVec3!T position,
	) {
		GFrame3!T result;
		result.right = right;
		result.up = up;
		result.forward = forward;
		result.position = position;
		return result;
	}

	static GFrame3!T fromComponents(
		T m00, T m01, T m02, T m03,
		T m10, T m11, T m12, T m13,
		T m20, T m21, T m22, T m23,
	) {
		return GFrame3!T.fromVectors(
			GVec3!T(m00, m10, m20),
			GVec3!T(m01, m11, m21),
			GVec3!T(m02, m12, m22),
			GVec3!T(m03, m13, m23),
		);
	}

	static if (isFloatingPoint!T) {
		static GFrame3!T fromEulerAngles(T x, T y, T z) {
			if (y == 0 && z == 0) { // rotate X
				return GFrame3!T.fromComponents(
					1, 0, 0, 0,
					0, cos(-x), sin(-x), 0,
					0, -sin(-x), cos(-x), 0,
				);
			}
			else if (x == 0 && z == 0) { // rotate Y
				return GFrame3!T.fromComponents(
					cos(-y), 0, -sin(-y), 0,
					0, 1, 0, 0,
					sin(-y), 0, cos(-y), 0,
				);
			}
			else if (x == 0 && y == 0) { // rotate Z
				return GFrame3!T.fromComponents(
					cos(-z), sin(-z), 0, 0,
					-sin(-z), cos(-z), 0, 0,
					0, 0, 1, 0,
				);
			}
			else { // rotate combination
				return GFrame3!T.fromEulerAngles(x, 0, 0)
					.mul(GFrame3!T.fromEulerAngles(0, y, 0))
					.mul(GFrame3!T.fromEulerAngles(0, 0, z));
			}
		}
	}

	static GFrame3!T fromPosition(GVec3!T position) {
		return GFrame3!T.fromComponents(
			1, 0, 0, position.x,
			0, 1, 0, position.y,
			0, 0, 1, position.z,
		);
	}

	static GFrame3!T fromPosition(T x, T y, T z) {
		return fromPosition(GVec3!T(x, y, z));
	}

// transformations:

	static if (isFloatingPoint!T) {
		GFrame3!T lookAt(GVec3!T value, GVec3!T up = GVec3!T(0, 1, 0)) const {
			GVec3!T direction = (value - position).unit;
			if (direction.magnitude < 1e-9) {
				return GFrame3!T.fromPosition(position);
			}

			GVec3!T vx = direction.cross(up.unit);

			if (vx.magnitude < 1e-9) {
				vx = GVec3!T(1, 0, 0);
			}
			else {
				vx = vx.unit;
			}

			GVec3!T vy = vx.cross(direction).unit;
			GVec3!T vz = vx.cross(vy).unit;

			return GFrame3!T.fromComponents(
				vx.x, vy.x, vz.x, position.x,
				vx.y, vy.y, vz.y, position.y,
				vx.z, vy.z, vz.z, position.z,
			);
		}

		GFrame3!T lookAt(T x, T y, T z) const {
			return lookAt(GVec3!T(x, y, z));
		}
	}

// basic operations:

	/**

	Generalized GFrame3!T multiplication

	This method multiplies this frame by the given parameter and returns the result.

	*/
	auto mul(R)(GFrame3!R other) const {
		alias ResT = typeof(mixin("cast(T) 0 * cast(R) 0"));
		auto mat = GVec3!(GVec3!T)(right, up, forward);
		return GFrame3!ResT.fromVectors(
			mat.dot(other.right),
			mat.dot(other.up),
			mat.dot(other.forward),
			mat.dot(other.position) + position,
		);
	}

	GFrame3!T inverse() const {
		T determinantRecip = right.magnitudeSq;
		return GFrame3!T.fromVectors(
			GVec3!T(right.x, up.x, forward.x) / determinantRecip,
			GVec3!T(right.y, up.y, forward.y) / determinantRecip,
			GVec3!T(right.z, up.z, forward.z) / determinantRecip,
			GVec3!T(position.dot(right), position.dot(up), position.dot(forward)) / -determinantRecip,
		);
	}

	auto translate(R)(GVec3!R vec) const {
		alias ResT = typeof(mixin("cast(T) 0 + cast(R) 0"));
		GFrame3!ResT result = this;
		result.position = position + vec;
		return result;
	}

	GFrame3!T translate(T x, T y, T z) const {
		return translate(GVec3!T(x, y, z));
	}

// conversions:

	static if (isFloatingPoint!T) {
		GVec4!T toQuaternion() const {
			import std.algorithm : max;

			double sign(double x) {
				if (x < 0) {
					return -1;
				}
				else if (x > 0) {
					return 1;
				}
				else {
					return x; // 0 or NaN
				}
			}

			GVec4!T result = GVec4!T(
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
