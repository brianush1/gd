module gd.graphics.text.shaping;
import gd.graphics.text.font;
import gd.math;

struct ShapedGlyph {
	Glyph glyph;
	Vec2 position, scale;
}

struct TextDrawInfo {
	string text;
	FontFace[] fontFaces;
	double fontSize;
	Rect layoutRectangle;
}

ShapedGlyph[] shapeText(TextDrawInfo info) {
	import std.math : round;

	ShapedGlyph[] result;

	double size = round(info.fontSize);

	Glyph prevGlyph;
	double currX = 0;
	foreach (dchar ch; info.text) {
		Glyph glyph = info.fontFaces[0][ch];
		currX += info.fontFaces[0].kerningBetween(prevGlyph, glyph) * size;
		result ~= ShapedGlyph(glyph, Vec2(currX, 0), Vec2(size));
		currX += glyph.advance * size;
	}

	double ascent = info.fontFaces[0].metrics.ascent * size;
	double descent = -info.fontFaces[0].metrics.descent * size;
	Vec2 transform = info.layoutRectangle.position
		+ info.layoutRectangle.size / 2 + Vec2(
			-currX / 2,
			round(-descent + (ascent + descent) / 2),
		);
	foreach (ref glyph; result)
		glyph.position += transform;

	return result;
}
