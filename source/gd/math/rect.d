module gd.math.rect;
import gd.math;
import std.typecons;
import std.traits : isFloatingPoint;

alias Rect = TRect!double;
alias IRect = TRect!int;
alias FRect = TRect!float;
alias RRect = TRect!real;

struct TRect(T) {
	TVec2!T position, size;

	ref inout(T) x() inout @property { return position.x; }
	ref inout(T) y() inout @property { return position.y; }
	ref inout(T) width() inout @property { return size.x; }
	ref inout(T) height() inout @property { return size.y; }

	const(T) left() const @property { return position.x; }
	const(T) right() const @property { return position.x + size.x; }
	const(T) top() const @property { return position.y; }
	const(T) bottom() const @property { return position.y + size.y; }

	this(U)(TRect!U rect) {
		position = TVec2!T(rect.position);
		size = TVec2!T(rect.size);
	}

	this(U, V)(TVec2!U position, TVec2!V size) {
		this.position = position;
		this.size = size;
	}

	this(T x, T y, T width, T height) {
		position = TVec2!T(x, y);
		size = TVec2!T(width, height);
	}

	this(U)(T x, T y, TVec2!U size) {
		position = TVec2!T(x, y);
		this.size = size;
	}

	this(U)(TVec2!U position, T width, T height) {
		this.position = position;
		size = TVec2!T(width, height);
	}

	Nullable!(TRect!T) clip(TRect!T other) {
		import std.algorithm : min, max;

		T newLeft = max(left, other.left);
		T newRight = min(right, other.right);
		T newTop = max(top, other.top);
		T newBottom = min(bottom, other.bottom);

		if (newLeft > newRight || newTop > newBottom) {
			return Nullable!(TRect!T)();
		}
		else {
			return nullable(TRect!T(newLeft, newTop, newRight - newLeft, newBottom - newTop));
		}
	}

	TRect!T clipArea(TRect!T other) {
		auto res = clip(other);

		if (res.isNull) {
			return TRect!T(position, TVec2!T(0, 0));
		}
		else {
			return res.get;
		}
	}

	TRect!T minimalUnion(TRect!T other) {
		if (size.volume == 0) {
			return other;
		}
		else if (other.size.volume == 0) {
			return this;
		}
		else {
			import std.algorithm : min, max;

			TVec2!T pos = TVec2!T(min(left, other.left), min(top, other.top));
			return TRect!T(pos, TVec2!T(
				max(right, other.right) - pos.x,
				max(bottom, other.bottom) - pos.y,
			));
		}
	}

	TRect!T opBinary(string op)(const(TRect!T) other) {
		return TRect!T(
			mixin("position", op, "other.position"),
			mixin("size", op, "other.size"),
		);
	}

	TRect!T opBinary(string op)(const(T) other) {
		return TRect!T(
			mixin("position", op, "other"),
			mixin("size", op, "other"),
		);
	}

	static if (isFloatingPoint!T) {
		TRect!T round() const {
			import std.math : round;

			T newLeft = round(left);
			T newRight = round(right);
			T newTop = round(top);
			T newBottom = round(bottom);

			return TRect!T(
				TVec2!T(newLeft, newTop),
				TVec2!T(newRight - newLeft, newBottom - newTop),
			);
		}
	}
}
