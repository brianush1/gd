module gd.graphics.text;
public import gd.graphics.text.font;

enum TextDirection {
	LTR,
	RTL,
}

enum TextAlign {
	Left,
	Center,
	Right,
	Justify,
}

double pt(double px) { return px * 4 / 3; }
