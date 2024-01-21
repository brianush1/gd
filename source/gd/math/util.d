module gd.math.util;
import gd.math.vec2;
import gd.math.vec3;
import gd.math.vec4;
import std.math;

/++

Performs a linear interpolation between two values.
Equivalent to GLSL [mix](https://registry.khronos.org/OpenGL-Refpages/gl4/html/mix.xhtml)

See_Also: [slerp]

+/
T mix(T, A)(T from, T to, A alpha) {
	return from * (1 - alpha) + to * alpha;
}

/++

Performs a smooth Hermite interpolation between 0 and 1 when $(I edge0) < $(I x) < $(I edge1).
Equivalent to GLSL [smoothstep](https://registry.khronos.org/OpenGL-Refpages/gl4/html/smoothstep.xhtml)

+/
T smoothstep(T)(T edge0, T edge1, T x) {
	return smoothstep((x - edge0) / (edge1 - edge0));
}

/++

Performs a smooth Hermite interpolation between 0 and 1.
Equivalent to GLSL [smoothstep](https://registry.khronos.org/OpenGL-Refpages/gl4/html/smoothstep.xhtml)(0, 1, $(I x))

+/
T smoothstep(T)(T x) {
	if (x > 1)
		return 1;
	else if (x < 0)
		return 0;
	else
		return 3*x*x - 2*x*x*x;
}

/++

Returns `x` unchanged if it's zero or NaN. Equivalent to `x / abs(x)` otherwise.
Equivalent to GLSL [sign](https://registry.khronos.org/OpenGL-Refpages/gl4/html/sign.xhtml)

+/
T sign(T)(T x) {
	if (x > 0)
		return 1;
	else if (x < 0)
		return -1;
	else
		return x;
}

/++

Performs a spherical interpolation between two values. [slerp] will always interpolate over the shortest spherical path.

$(WARNING
	When interpolating between quaternions, because $(I q) and -$(I q) map to the same
	rotation, the path of rotation may turn either the short way or the long way. To ensure that slerp
	always takes the shortest $(I rotation path), you can check if the dot product of the two
	quaternions is negative and, if it is, negate one of the quaternions.
)

The length of the two vectors is linearly interpolated; in other words, if
we say $(I p) = slerp($(I a), $(I b), $(I alpha)), then |$(I p)| = $(REF mix)(|$(I a)|, |$(I b)|, $(I alpha)) holds.

See_Also: [mix]

+/
TVec2!T slerp(T)(TVec2!T from, TVec2!T to, T alpha) {
	return genericSlerp!(TVec2!T, T, TVec2!T(0, 1), TVec2!T(1, 0))(from, to, alpha);
}

/// ditto
TVec3!T slerp(T)(TVec3!T from, TVec3!T to, T alpha) {
	return genericSlerp!(TVec3!T, T, TVec3!T(0, 1, 0), TVec3!T(1, 0, 0))(from, to, alpha);
}

/// ditto
TVec4!T slerp(T)(TVec4!T from, TVec4!T to, T alpha) {
	return genericSlerp!(TVec4!T, T, TVec4!T(0, 1, 0, 0), TVec4!T(1, 0, 0, 0))(from, to, alpha);
}

private V genericSlerp(V, T, V arb1, V arb2)(V from, V to, T alpha) {
	if (from.magnitude < 1e-9 || to.magnitude < 1e-9) {
		return mix(from, to, alpha);
	}

	T len = mix(from.magnitude, to.magnitude, alpha);
	from = from.unit;
	to = to.unit;

	T dot = from.dot(to);

	// vectors going in the same direction
	if (dot > 1 - 1e-9) {
		return mix(from, to, alpha) * len;
	}

	// vectors going in opposite directions
	else if (dot < -1 + 1e-9) {
		// pick an arbitrary point to go through
		V arb = arb1;

		// if the point we picked wasn't good either, just pick a new one
		// this one is guaranteed to not be parallel with either `from` or `to`
		if (abs(arb.dot(to)) > 1 - 1e-9)
			arb = arb2;

		T angleAToArb = acos(from.dot(arb));
		T base = angleAToArb / PI;

		if (alpha < base) {
			return genericSlerp!(V, T, arb1, arb2)(from, arb, alpha / base) * len;
		}
		else {
			return genericSlerp!(V, T, arb1, arb2)(arb, to, (alpha - base) / (1 - base)) * len;
		}
	}

	T omega = acos(dot);
	T sinOmega = sin(omega);
	return (sin((1 - alpha) * omega) / sinOmega * from
		+ sin(alpha * omega) / sinOmega * to) * len;
}

@("Slerp")
unittest {
	Vec3[] vectors = [
		Vec3(0, 0, 0),
		Vec3(1, 0, 0),
		Vec3(0, 1, 0),
		Vec3(0, 0, 1),
		Vec3(-1, 0, 0),
		Vec3(0, -1, 0),
		Vec3(0, 0, -1),
		Vec3(2, 4, 6),
		Vec3(653, 345, 6735),
		Vec3(245e3, 3458, 5345),
		Vec3(-2, -4, -6),
		Vec3(-653, -345, -6735),
		Vec3(-245e3, -3458, -5345),
		Vec3(0.00001, 0, 0),
		Vec3(-0.00001, 0, 0),
	];

	foreach (a; vectors) foreach (b; vectors) {
		foreach (i; 0 .. 100 + 1) {
			double t = i / 100.0;
			Vec3 p = slerp(a, b, t);
			assert(abs(p.magnitude - mix(a.magnitude, b.magnitude, t)) < 1e-8);
		}
	}
}
