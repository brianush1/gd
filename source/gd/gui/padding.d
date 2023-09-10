module gd.gui.padding;
import gd.math.dim;

struct Padding {

	Dim top;
	Dim right;
	Dim bottom;
	Dim left;

	Dim horizontal() const @property { return left + right; }

	Dim vertical() const @property { return top + bottom; }

	this(double top, double right, double bottom, double left) { this(Dim(top), Dim(right), Dim(bottom), Dim(left)); }
	this(Dim top, Dim right, Dim bottom, Dim left) {
		this.top = top;
		this.right = right;
		this.bottom = bottom;
		this.left = left;
	}

	this(double top, double leftAndRight, double bottom) { this(Dim(top), Dim(leftAndRight), Dim(bottom)); }
	this(Dim top, Dim leftAndRight, Dim bottom) {
		this.top = top;
		this.bottom = bottom;
		left = right = leftAndRight;
	}

	this(double topAndBottom, double leftAndRight) { this(Dim(topAndBottom), Dim(leftAndRight)); }
	this(Dim topAndBottom, Dim leftAndRight) {
		top = bottom = topAndBottom;
		left = right = leftAndRight;
	}

	this(double all) { this(Dim(all)); }
	this(Dim all) {
		top = right = bottom = left = all;
	}

}
