module gd.graphics.rect;
import gd.math;
import std.typecons;

alias Rect = GRect!double;
alias IRect = GRect!int;
alias FRect = GRect!float;
alias RRect = GRect!real;

struct GRect(T) {
	GVec2!T position, size;

	ref inout(T) x() inout @property { return position.x; }
	ref inout(T) y() inout @property { return position.y; }
	ref inout(T) width() inout @property { return size.x; }
	ref inout(T) height() inout @property { return size.y; }

	const(T) left() const @property { return position.x; }
	const(T) right() const @property { return position.x + size.x; }
	const(T) top() const @property { return position.y; }
	const(T) bottom() const @property { return position.y + size.y; }

	this(U)(GRect!U rect) {
		position = GVec2!T(rect.position);
		size = GVec2!T(rect.size);
	}

	this(U, V)(GVec2!U position, GVec2!V size) {
		this.position = position;
		this.size = size;
	}

	this(T x, T y, T width, T height) {
		position = GVec2!T(x, y);
		size = GVec2!T(width, height);
	}

	Nullable!(GRect!T) clip(GRect!T other) {
		import std.algorithm : min, max;

		T newLeft = max(left, other.left);
		T newRight = min(right, other.right);
		T newTop = max(top, other.top);
		T newBottom = min(bottom, other.bottom);

		if (newLeft > newRight || newTop > newBottom) {
			return Nullable!(GRect!T)();
		}
		else {
			return nullable(GRect!T(newLeft, newTop, newRight - newLeft, newBottom - newTop));
		}
	}

	GRect!T clipArea(GRect!T other) {
		auto res = clip(other);

		if (res.isNull) {
			return GRect!T(position, GVec2!T(0, 0));
		}
		else {
			return res.get;
		}
	}

	GRect!T minimalUnion(GRect!T other) {
		if (size.volume == 0) {
			return other;
		}
		else if (other.size.volume == 0) {
			return this;
		}
		else {
			import std.algorithm : min, max;

			GVec2!T pos = GVec2!T(min(left, other.left), min(top, other.top));
			return GRect!T(pos, GVec2!T(
				max(right, other.right) - pos.x,
				max(bottom, other.bottom) - pos.y,
			));
		}
	}
}
