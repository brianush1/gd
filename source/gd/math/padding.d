module gd.math.padding;
import gd.math.dim;

struct Padding {

	Dim top, right, bottom, left;

	this(Dim all) {
		top = bottom = left = right = all;
	}

	this(Dim vertical, Dim horiz) {
		top = bottom = vertical;
		left = right = horiz;
	}

	this(Dim top, Dim horiz, Dim bottom) {
		this.top = top;
		this.bottom = bottom;
		left = right = horiz;
	}

	this(Dim top, Dim right, Dim bottom, Dim left) {
		this.top = top;
		this.right = right;
		this.bottom = bottom;
		this.left = left;
	}

	this(double all) { this(Dim(all)); }

	this(Dim vertical, double horiz) { this(vertical, Dim(horiz)); }
	this(double vertical, Dim horiz) { this(Dim(vertical), horiz); }
	this(double vertical, double horiz) { this(Dim(vertical), Dim(horiz)); }

	this(Dim top, Dim horiz, double bottom) { this(top, horiz, Dim(bottom)); }
	this(Dim top, double horiz, Dim bottom) { this(top, Dim(horiz), bottom); }
	this(Dim top, double horiz, double bottom) { this(top, Dim(horiz), Dim(bottom)); }
	this(double top, Dim horiz, Dim bottom) { this(Dim(top), horiz, bottom); }
	this(double top, Dim horiz, double bottom) { this(Dim(top), horiz, Dim(bottom)); }
	this(double top, double horiz, Dim bottom) { this(Dim(top), Dim(horiz), bottom); }
	this(double top, double horiz, double bottom) { this(Dim(top), Dim(horiz), Dim(bottom)); }

	this(Dim top, Dim right, Dim bottom, double left) { this(top, right, bottom, Dim(left)); }
	this(Dim top, Dim right, double bottom, Dim left) { this(top, right, Dim(bottom), left); }
	this(Dim top, Dim right, double bottom, double left) { this(top, right, Dim(bottom), Dim(left)); }
	this(Dim top, double right, Dim bottom, Dim left) { this(top, Dim(right), bottom, left); }
	this(Dim top, double right, Dim bottom, double left) { this(top, Dim(right), bottom, Dim(left)); }
	this(Dim top, double right, double bottom, Dim left) { this(top, Dim(right), Dim(bottom), left); }
	this(Dim top, double right, double bottom, double left) { this(top, Dim(right), Dim(bottom), Dim(left)); }
	this(double top, Dim right, Dim bottom, Dim left) { this(Dim(top), right, bottom, left); }
	this(double top, Dim right, Dim bottom, double left) { this(Dim(top), right, bottom, Dim(left)); }
	this(double top, Dim right, double bottom, Dim left) { this(Dim(top), right, Dim(bottom), left); }
	this(double top, Dim right, double bottom, double left) { this(Dim(top), right, Dim(bottom), Dim(left)); }
	this(double top, double right, Dim bottom, Dim left) { this(Dim(top), Dim(right), bottom, left); }
	this(double top, double right, Dim bottom, double left) { this(Dim(top), Dim(right), bottom, Dim(left)); }
	this(double top, double right, double bottom, Dim left) { this(Dim(top), Dim(right), Dim(bottom), left); }
	this(double top, double right, double bottom, double left) { this(Dim(top), Dim(right), Dim(bottom), Dim(left)); }

	Padding opBinary(string op)(const(Padding) rhs) const if (op == "+" || op == "-") {
		Padding result;
		result.top = mixin("top" ~ op ~ "rhs.top");
		result.right = mixin("right" ~ op ~ "rhs.right");
		result.bottom = mixin("bottom" ~ op ~ "rhs.bottom");
		result.left = mixin("left" ~ op ~ "rhs.left");
		return result;
	}

	auto opOpAssign(string op, T)(T value) {
		auto res = mixin("this" ~ op ~ "value");
		scale = res.scale;
		offset = res.offset;
		return this;
	}

	auto opUnary(string op)() const if (op == "-") {
		return Padding(-top, -right, -bottom, -left);
	}

}
