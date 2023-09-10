module gd.geom.area;
import gd.geom.path;
import gd.math;

enum FillRule {

	/** Regions with a nonzero winding number are filled */
	NonZero,

	/** Regions with an odd winding number are filled */
	EvenOdd,

	/** Regions with a negative winding number are filled */
	CW,

	/** Regions with a positive winding number are filled */
	CCW,

}

alias Area = TArea!double;
alias FArea = TArea!float;
alias RArea = TArea!real;

enum Shape {
	ComplexPath,
	Rectangle,
	Ellipse,
}

struct TArea(T) {

	private TPath!T m_outline;

	this(FillRule fillRule, TPath!T outline) {
		m_outline = outline;
	}

	TPath!T outline() const @property { return m_outline; }

	static TArea!T rect(T x, T y, T width, T height) { return rect(TRect!T(x, y, width, height)); }
	static TArea!T rect(TVec2!T position, TVec2!T size) { return rect(TRect!T(position, size)); }
	static TArea!T rect(TRect!T rect) { return TArea!T(FillRule.NonZero, TPath!T()
		.moveTo(rect.position)
		.lineTo(rect.position.x, rect.position.y + rect.size.y)
		.lineTo(rect.position + rect.size)
		.lineTo(rect.position.x + rect.size.x, rect.position.y)
		.close()
	); }

	// TODO: replace these cubics with arcs
	static TArea!T roundedRect(TRect!T rect, T radius) {
		import std.math : tan, PI;
		double MAGIC = tan(PI / 8) * 4 / 3;
		TPath!T path;
		path.moveTo(rect.position + TVec2!T(radius, 0));
		path.cubicTo(
			rect.position + TVec2!T(radius * (1 - MAGIC), 0),
			rect.position + TVec2!T(0, radius * (1 - MAGIC)),
			rect.position + TVec2!T(0, radius),
		);
		path.lineTo(rect.position + TVec2!T(0, rect.size.y - radius));
		path.cubicTo(
			rect.position + TVec2!T(0, rect.size.y - radius * (1 - MAGIC)),
			rect.position + TVec2!T(radius * (1 - MAGIC), rect.size.y),
			rect.position + TVec2!T(radius, rect.size.y),
		);
		path.lineTo(rect.position + TVec2!T(rect.size.x - radius, rect.size.y));
		path.cubicTo(
			rect.position + TVec2!T(rect.size.x - radius * (1 - MAGIC), rect.size.y),
			rect.position + TVec2!T(rect.size.x, rect.size.y - radius * (1 - MAGIC)),
			rect.position + TVec2!T(rect.size.x, rect.size.y - radius),
		);
		path.lineTo(rect.position + TVec2!T(rect.size.x, radius));
		path.cubicTo(
			rect.position + TVec2!T(rect.size.x, radius * (1 - MAGIC)),
			rect.position + TVec2!T(rect.size.x - radius * (1 - MAGIC), 0),
			rect.position + TVec2!T(rect.size.x - radius, 0),
		);
		path.close();
		return TArea!T(FillRule.NonZero, path);
	}

}
