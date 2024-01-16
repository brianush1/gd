module gd.math.frame3;
import gd.math.vec3;
import gd.math.vec4;
import std.traits;
import std.math;

alias Frame3 = TFrame3!double;
alias IFrame3 = TFrame3!int;
alias FFrame3 = TFrame3!float;
alias RFrame3 = TFrame3!real;

/++

Represents a coordinate frame/transformation in 3D space. The orientation is encoded in terms
of an orthonormal basis, and the translation is encoded as a position vector.

+/
struct TFrame3(T) {
// fields:

	TVec3!T position = TVec3!T(0, 0, 0);
	TVec3!T right = TVec3!T(1, 0, 0);
	TVec3!T up = TVec3!T(0, 1, 0);
	TVec3!T forward = TVec3!T(0, 0, 1);

// frame constructors:

	/++ Constructs a $(D TFrame3) from a given translation vector. +/
	this(V)(TVec3!V position) { this.position = TVec3!T(position); }

	/// ditto
	this(T x, T y, T z) { position = TVec3!T(x, y, z); }

	/++ Constructs a $(D TFrame3) from the given parameters. +/
	this(V)(TVec3!V position, TVec3!T right, TVec3!T up, TVec3!T forward) {
		this.position = TVec3!T(position);
		this.right = TVec3!T(right);
		this.up = TVec3!T(up);
		this.forward = TVec3!T(forward);
	}

	/// ditto
	this(V)(TFrame3!V base) {
		position = TVec3!T(base.position);
		right = TVec3!T(base.right);
		up = TVec3!T(base.up);
		forward = TVec3!T(base.forward);
	}

	static if (isFloatingPoint!T) {
		/++

		Constructs a $(D TFrame3) from the given Euler angles.
		The angles are applied in XYZ order.

		This function is only available on floating-point transformations.

		+/
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

// indexing:

	ref inout(T) opIndex(size_t r, size_t c) return inout {
		assert(r < 3 && c < 4);
		switch (c) {
			case 0: return right.components[r];
			case 1: return up.components[r];
			case 2: return forward.components[r];
			case 3: return position.components[r];
			default: assert(0);
		}
	}

// transformations:

	static if (isFloatingPoint!T) {
		/++

		Constructs a $(D TFrame3) with the same position as the current one,
		but with a new rotation such that the forward vector points towards
		the vector defined by the `value` parameter, and the up vector is as
		close to `up` as possible.

		This function is only available on floating-point transformations.

		+/
		TFrame3!T lookAt(TVec3!T value, TVec3!T up = TVec3!T(0, 1, 0)) const {
			TVec3!T direction = (value - position).unit;
			if (direction.magnitude < 1e-9)
				return TFrame3!T(position);

			TVec3!T vx = direction.cross(up.unit);

			// TODO: this breaks if up = (1, 0, 0)
			vx = vx.magnitude < 1e-9 ? TVec3!T(1, 0, 0) : vx.unit;

			TVec3!T vy = vx.cross(direction).unit;
			TVec3!T vz = vx.cross(vy).unit;

			return TFrame3!T(position, vx, vy, vz);
		}

		/// ditto
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

	auto opBinary(string op, R)(TVec3!R other) const if (op == "*") {
		return (this * TFrame3!R(other)).position;
	}

	/++ Returns the inverse of this transformation. The inverse of a $(D TFrame3) is guaranteed to always exist. +/
	TFrame3!T inverse() const {
		T determinantRecip = right.magnitudeSq;
		return TFrame3!T(
			TVec3!T(position.dot(right), position.dot(up), position.dot(forward)) / -determinantRecip,
			TVec3!T(right.x, up.x, forward.x) / determinantRecip,
			TVec3!T(right.y, up.y, forward.y) / determinantRecip,
			TVec3!T(right.z, up.z, forward.z) / determinantRecip,
		);
	}

	/++ Returns a $(D TFrame3) representing only the rotation part of this transformation. +/
	TFrame3!T rotation() const => translate(-position);

	/++ Adds a vector directly to the translation component of this transformation. +/
	auto translate(R)(TVec3!R vec) const {
		alias ResT = typeof(mixin("cast(T) 0 + cast(R) 0"));
		TFrame3!ResT result = this;
		result.position = position + vec;
		return result;
	}

	/// ditto
	TFrame3!T translate(T x, T y, T z) const => translate(TVec3!T(x, y, z));

	static if (isFloatingPoint!T) {
		/++

		Returns a $(D TFrame3) where each axis is guaranteed to be normalized and perpendicular to one another. 

		Will be normalized to the right axis, then the up axis, then the forward axis.

		+/
		TFrame3!T orthonormalize() const {
			TVec3!T r = right;
			T rDotr = r.dot(r);
			TVec3!T u = up - up.dot(r) / rDotr * r;
			T uDotu = up.dot(up);
			TVec3!T f = forward - forward.dot(r) / rDotr * r - forward.dot(u) / uDotu * u;
			return TFrame3!T(
				position,
				r.normalize(),
				u.normalize(),
				f.normalize(),
			);
		}
	}

// conversions:

	static if (isFloatingPoint!T) {
		/++

		Converts the rotation component of this transformation into a quaternion.

		This function is only available on floating-point transformations.

		$(WARNING
			Traditionally, 4D vectors are represented as ⟨$(I x), $(I y), $(I z), $(I w)⟩,
			with $(I w) being the last component in the vector. However, quaternions are often
			defined as $(I w) + $(I x)$(B i) + $(I y)$(B j) + $(I z)$(B k), with $(I w) being
			the first component.

			In an attempt to cause the least confusion possible, $(REF toQuaternion)
			will return a 4D vector with the components corresponding, by name, to those in
			the definition of the quaternion. In other words, the $(I x), $(I y), and $(I z)
			components of the result of this function are the complex-valued parts of the quaternion;
			the $(I w) component is the real-valued part of the quaternion.
		)

		See_Also: [fromQuaternion], [gd.math.util.slerp|slerp]

		+/
		TVec4!T toQuaternion() const {
			TVec4!T result;

			T trace = this[0, 0] + this[1, 1] + this[2, 2];

			if (trace >= -1e-12) {
				T r = sqrt(1 + trace);
				T s = 1 / (2 * r);
				result.w = r / 2;
				result.x = (this[2, 1] - this[1, 2]) * s;
				result.y = (this[0, 2] - this[2, 0]) * s;
				result.z = (this[1, 0] - this[0, 1]) * s;
			}
			else {
				size_t x = 0;
				if (this[1, 1] > this[x, x]) x = 1;
				if (this[2, 2] > this[x, x]) x = 2;
				size_t y = x == 2 ? 0 : x + 1;
				size_t z = y == 2 ? 0 : y + 1;
				T r = sqrt(1 + this[x, x] - this[y, y] - this[z, z]);
				T s = 1 / (2 * r);
				result.w = (this[z, y] - this[y, z]) * s;
				result.components[x] = r / 2;
				result.components[y] = (this[x, y] + this[y, x]) * s;
				result.components[z] = (this[z, x] + this[x, z]) * s;
			}

			return result;
		}

		/++

		Converts a quaternion into a $(D TFrame3) that represents a rotation transformation.

		This function is only available on floating-point transformations.

		See_Also: [toQuaternion], [gd.math.util.slerp|slerp]

		+/
		static TFrame3!T fromQuaternion(TVec4!T value) {
			T a = value.w, b = value.x, c = value.y, d = value.z;

			TFrame3!T result;
			result.right = TVec3!T(a*a + b*b - c*c - d*d, 2*b*c + 2*a*d, 2*b*d - 2*a*c);
			result.up = TVec3!T(2*b*c - 2*a*d, a*a - b*b + c*c - d*d, 2*c*d + 2*a*b);
			result.forward = TVec3!T(2*b*d + 2*a*c, 2*c*d - 2*a*b, a*a - b*b - c*c + d*d);

			return result;
		}
	}

	string toString() const {
		import std.conv : text;

		return text(position, ", ", right, ", ", up, ", ", forward);
	}

}

@("Associativity")
unittest {
	Frame3 a = (Frame3.angles(46, 34, 67) * Frame3(-75, 34, 63.45)) * Frame3.angles(5, 3, 7);
	Frame3 b = Frame3.angles(46, 34, 67) * (Frame3(-75, 34, 63.45) * Frame3.angles(5, 3, 7));
	foreach (i; 0 .. 3)
		foreach (j; 0 .. 4)
			assert(abs(a[i, j] - b[i, j]) < 1e-12);
	assert(((Frame3.angles(46, 34, 67) * Frame3(-75, 34, 63.45)) * Vec3(5, 3, 7)).eq(
		Frame3.angles(46, 34, 67) * (Frame3(-75, 34, 63.45) * Vec3(5, 3, 7)), 1e-12));
}

@("Quaternion conversions")
unittest {
	import gd.math.mat3 : Mat3;

	Frame3[] framesToTest = [
		Frame3.angles(465, 374, -6.53),
		Frame3.angles(-67, 3, 4346) * Frame3(56, -65, 345),
	];

	// conversion of matrices with low traces can be unstable with some methods, we want to work against that
	foreach (trace; [
		-1, -0.75, -0.5, -0.25,
		0,
		0.25, 0.5, 0.75, 1, 1.5, 2, 2.5, 3,
	]) {
		Frame3 f1 = Frame3.angles(acos(trace / 2 - 0.5), 0, 0);
		Frame3 f2 = Frame3.angles(0, acos(trace / 2 - 0.5), 0);
		Frame3 f3 = Frame3.angles(0, 0, acos(trace / 2 - 0.5));

		assert(abs(Mat3(f1).trace - trace) < 1e-12);
		assert(abs(Mat3(f2).trace - trace) < 1e-12);
		assert(abs(Mat3(f3).trace - trace) < 1e-12);

		framesToTest ~= f1;
		framesToTest ~= f2;
		framesToTest ~= f3;
	}

	foreach (a; framesToTest) {
		Vec4 quat = a.toQuaternion;
		Frame3 b = Frame3.fromQuaternion(quat);
		foreach (i; 0 .. 3)
			foreach (j; 0 .. 3)
				assert(abs(a[i, j] - b[i, j]) < 1e-12);
		assert(b.position == Vec3(0));
	}
}
