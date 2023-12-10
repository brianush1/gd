module gd.graphics.text.font;
import gd.graphics.text.ttf;
import gd.geom.path;

struct FontMetrics {
	double ascent, descent, lineGap, xHeight;
}

struct Glyph {
	private {
		FontFace font;
		int index = -1;
	}

	double advance;
	double lsb;

	Path outline() {
		Path path;

		stbtt_vertex* pvertices;
		int nvertices = stbtt_GetGlyphShape(&font.stbfont, index, &pvertices);
		stbtt_vertex[] vertices = pvertices[0 .. nvertices];
		foreach (v; vertices) {
			final switch (v.type) {
				case STBTT_vmove:
					path.moveTo(v.x * font.emScale, v.y * font.emScale * -1);
					break;
				case STBTT_vline:
					path.lineTo(v.x * font.emScale, v.y * font.emScale * -1);
					break;
				case STBTT_vcurve:
					path.quadTo(
						v.cx * font.emScale,
						v.cy * font.emScale * -1,
						v.x * font.emScale,
						v.y * font.emScale * -1,
					);
					break;
				case STBTT_vcubic:
					assert(0);
			}
		}

		return path;
	}

}

class FontFace {

	private {
		stbtt_fontinfo stbfont;
		double emScale;

		this() {}
	}

	private FontMetrics m_metrics;
	FontMetrics metrics() const @property { return m_metrics; }

	static FontFace fromBuffer(const(char)[] data) {
		return fromBuffer(cast(const(void)[]) data);
	}

	static FontFace fromBuffer(const(void)[] data) {
		import std.exception : enforce;

		FontFace result = new FontFace;
		stbtt_InitFont(&result.stbfont, cast(ubyte*) data.ptr,
			stbtt_GetFontOffsetForIndex(cast(ubyte*) data.ptr, 0));
		result.emScale = stbtt_ScaleForMappingEmToPixels(&result.stbfont, 1);
		int ascent, descent, lineGap, xHeight;
		stbtt_GetFontVMetrics(&result.stbfont, &ascent, &descent, &lineGap);
		int success = stbtt_GetFontXHeight(&result.stbfont, &xHeight);
		enforce(success, "could not get font metrics");
		FontMetrics m = {
			ascent: ascent * result.emScale,
			descent: descent * result.emScale,
			lineGap: lineGap * result.emScale,
			xHeight: xHeight * result.emScale,
		};
		result.m_metrics = m;
		return result;
	}

	private static FontFace[string] fontCache;

	static FontFace fromFile(string file) {
		import std.file : read;

		if (file in fontCache) {
			return fontCache[file];
		}
		else {
			return fontCache[file] = fromBuffer(read(file));
		}
	}

	Glyph opIndex(dchar c) {
		int index = stbtt_FindGlyphIndex(&stbfont, cast(int) c);
		int advance, lsb;
		stbtt_GetGlyphHMetrics(&stbfont, index, &advance, &lsb);
		Glyph result = {
			font: this,
			index: index,
			advance: advance * emScale,
			lsb: lsb * emScale,
		};
		return result;
	}

	double kerningBetween(Glyph a, Glyph b) {
		if (a.index == -1 || b.index == -1)
			return 0;
		return stbtt_GetGlyphKernAdvance(&stbfont, a.index, b.index) * emScale;
	}

}

enum FontStyle {
	Regular,
	Italic,
	Oblique,
}

enum FontType {
	Sans,
	Serif,
	Monospace,
}

import gd.bindings.fc : FC;
import gd.graphics.text : pt;

private FC.FcConfig* fcConfig;

shared static this() {
	FC.init_();
	fcConfig = FC.initLoadConfigAndFonts();
}

shared static ~this() {
	FC.configDestroy(fcConfig);
	FC.fini();
}

struct Font {
	string[] families;
	FontType type = FontType.Sans;
	double size = 9.75.pt;
	FontStyle style = FontStyle.Regular;
	int weight = 400;

	this(string[] families,
		FontType type = FontType.Sans,
		double size = 9.75.pt,
		FontStyle style = FontStyle.Regular,
		int weight = 400,
	) {
		this.families = families;
		this.type = type;
		this.size = size;
		this.style = style;
		this.weight = weight;
	}

	this(string family,
		FontType type = FontType.Sans,
		double size = 9.75.pt,
		FontStyle style = FontStyle.Regular,
		int weight = 400,
	) {
		this.families = [family];
		this.type = type;
		this.size = size;
		this.style = style;
		this.weight = weight;
	}

	this(FontType type,
		double size = 9.75.pt,
		FontStyle style = FontStyle.Regular,
		int weight = 400,
	) {
		this.type = type;
		this.size = size;
		this.style = style;
		this.weight = weight;
	}

	FontFace[] faces() {
		static FontFace[][Font] fontCache;

		if (this in fontCache) {
			return fontCache[this];
		}

		string[] transformedFamilies = families;
		final switch (type) {
		case FontType.Sans:
			transformedFamilies ~= ["sans-serif"];
			break;
		case FontType.Serif:
			transformedFamilies ~= ["serif"];
			break;
		case FontType.Monospace:
			transformedFamilies ~= ["monospace"];
			break;
		}

		FontFace[] finalFaces;

		foreach (family; transformedFamilies) {
			import std.string : toStringz, fromStringz;

			FC.FcPattern* pattern = FC.patternCreate();
			FC.patternAddString(pattern, FC.FAMILY, cast(const(FC.Char8)*) family.toStringz);
			FC.configSubstitute(fcConfig, pattern, FC.FcMatchKind.FcMatchPattern);
			FC.defaultSubstitute(pattern);

			FC.FcResult result;
			FC.FcPattern* match = FC.fontMatch(fcConfig, pattern, &result);
			FC.patternDestroy(pattern);

			scope (exit) {
				FC.patternDestroy(match);
			}

			if (match) {
				FC.Char8* fontFile;
				if (FC.patternGetString(match, FC.FILE, 0, &fontFile) != FC.FcResult.FcResultMatch) {
					continue;
				}

				finalFaces ~= FontFace.fromFile((cast(const(char)*) fontFile).fromStringz.idup);
			}
		}

		fontCache[this] = finalFaces;
		return finalFaces;
	}
}
