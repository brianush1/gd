module gd.graphics.color;
import std.conv;

enum Colors : Color {
	Transparent = Color(0, 0, 0, 0),
	MediumVioletRed = Color.fromHex("C71585"),
	DeepPink = Color.fromHex("FF1493"),
	PaleVioletRed = Color.fromHex("DB7093"),
	HotPink = Color.fromHex("FF69B4"),
	LightPink = Color.fromHex("FFB6C1"),
	Pink = Color.fromHex("FFC0CB"),
	DarkRed = Color.fromHex("8B0000"),
	Red = Color.fromHex("FF0000"),
	Firebrick = Color.fromHex("B22222"),
	Crimson = Color.fromHex("DC143C"),
	IndianRed = Color.fromHex("CD5C5C"),
	LightCoral = Color.fromHex("F08080"),
	Salmon = Color.fromHex("FA8072"),
	DarkSalmon = Color.fromHex("E9967A"),
	LightSalmon = Color.fromHex("FFA07A"),
	OrangeRed = Color.fromHex("FF4500"),
	Tomato = Color.fromHex("FF6347"),
	DarkOrange = Color.fromHex("FF8C00"),
	Coral = Color.fromHex("FF7F50"),
	Orange = Color.fromHex("FFA500"),
	DarkKhaki = Color.fromHex("BDB76B"),
	Gold = Color.fromHex("FFD700"),
	Khaki = Color.fromHex("F0E68C"),
	PeachPuff = Color.fromHex("FFDAB9"),
	Yellow = Color.fromHex("FFFF00"),
	PaleGoldenrod = Color.fromHex("EEE8AA"),
	Moccasin = Color.fromHex("FFE4B5"),
	PapayaWhip = Color.fromHex("FFEFD5"),
	LightGoldenrodYellow = Color.fromHex("FAFAD2"),
	LemonChiffon = Color.fromHex("FFFACD"),
	LightYellow = Color.fromHex("FFFFE0"),
	Maroon = Color.fromHex("800000"),
	Brown = Color.fromHex("A52A2A"),
	SaddleBrown = Color.fromHex("8B4513"),
	Sienna = Color.fromHex("A0522D"),
	Chocolate = Color.fromHex("D2691E"),
	DarkGoldenrod = Color.fromHex("B8860B"),
	Peru = Color.fromHex("CD853F"),
	RosyBrown = Color.fromHex("BC8F8F"),
	Goldenrod = Color.fromHex("DAA520"),
	SandyBrown = Color.fromHex("F4A460"),
	Tan = Color.fromHex("D2B48C"),
	Burlywood = Color.fromHex("DEB887"),
	Wheat = Color.fromHex("F5DEB3"),
	NavajoWhite = Color.fromHex("FFDEAD"),
	Bisque = Color.fromHex("FFE4C4"),
	BlanchedAlmond = Color.fromHex("FFEBCD"),
	Cornsilk = Color.fromHex("FFF8DC"),
	Indigo = Color.fromHex("4B0082"),
	Purple = Color.fromHex("800080"),
	DarkMagenta = Color.fromHex("8B008B"),
	DarkViolet = Color.fromHex("9400D3"),
	DarkSlateBlue = Color.fromHex("483D8B"),
	BlueViolet = Color.fromHex("8A2BE2"),
	DarkOrchid = Color.fromHex("9932CC"),
	Fuchsia = Color.fromHex("FF00FF"),
	Magenta = Color.fromHex("FF00FF"),
	SlateBlue = Color.fromHex("6A5ACD"),
	MediumSlateBlue = Color.fromHex("7B68EE"),
	MediumOrchid = Color.fromHex("BA55D3"),
	MediumPurple = Color.fromHex("9370DB"),
	Orchid = Color.fromHex("DA70D6"),
	Violet = Color.fromHex("EE82EE"),
	Plum = Color.fromHex("DDA0DD"),
	Thistle = Color.fromHex("D8BFD8"),
	Lavender = Color.fromHex("E6E6FA"),
	MidnightBlue = Color.fromHex("191970"),
	Navy = Color.fromHex("000080"),
	DarkBlue = Color.fromHex("00008B"),
	MediumBlue = Color.fromHex("0000CD"),
	Blue = Color.fromHex("0000FF"),
	RoyalBlue = Color.fromHex("4169E1"),
	SteelBlue = Color.fromHex("4682B4"),
	DodgerBlue = Color.fromHex("1E90FF"),
	DeepSkyBlue = Color.fromHex("00BFFF"),
	CornflowerBlue = Color.fromHex("6495ED"),
	SkyBlue = Color.fromHex("87CEEB"),
	LightSkyBlue = Color.fromHex("87CEFA"),
	LightSteelBlue = Color.fromHex("B0C4DE"),
	LightBlue = Color.fromHex("ADD8E6"),
	PowderBlue = Color.fromHex("B0E0E6"),
	Teal = Color.fromHex("008080"),
	DarkCyan = Color.fromHex("008B8B"),
	LightSeaGreen = Color.fromHex("20B2AA"),
	CadetBlue = Color.fromHex("5F9EA0"),
	DarkTurquoise = Color.fromHex("00CED1"),
	MediumTurquoise = Color.fromHex("48D1CC"),
	Turquoise = Color.fromHex("40E0D0"),
	Aqua = Color.fromHex("00FFFF"),
	Cyan = Color.fromHex("00FFFF"),
	Aquamarine = Color.fromHex("7FFFD4"),
	PaleTurquoise = Color.fromHex("AFEEEE"),
	LightCyan = Color.fromHex("E0FFFF"),
	DarkGreen = Color.fromHex("006400"),
	Green = Color.fromHex("008000"),
	DarkOliveGreen = Color.fromHex("556B2F"),
	ForestGreen = Color.fromHex("228B22"),
	SeaGreen = Color.fromHex("2E8B57"),
	Olive = Color.fromHex("808000"),
	OliveDrab = Color.fromHex("6B8E23"),
	MediumSeaGreen = Color.fromHex("3CB371"),
	LimeGreen = Color.fromHex("32CD32"),
	Lime = Color.fromHex("00FF00"),
	SpringGreen = Color.fromHex("00FF7F"),
	MediumSpringGreen = Color.fromHex("00FA9A"),
	DarkSeaGreen = Color.fromHex("8FBC8F"),
	MediumAquamarine = Color.fromHex("66CDAA"),
	YellowGreen = Color.fromHex("9ACD32"),
	LawnGreen = Color.fromHex("7CFC00"),
	Chartreuse = Color.fromHex("7FFF00"),
	LightGreen = Color.fromHex("90EE90"),
	GreenYellow = Color.fromHex("ADFF2F"),
	PaleGreen = Color.fromHex("98FB98"),
	MistyRose = Color.fromHex("FFE4E1"),
	AntiqueWhite = Color.fromHex("FAEBD7"),
	Linen = Color.fromHex("FAF0E6"),
	Beige = Color.fromHex("F5F5DC"),
	WhiteSmoke = Color.fromHex("F5F5F5"),
	LavenderBlush = Color.fromHex("FFF0F5"),
	OldLace = Color.fromHex("FDF5E6"),
	AliceBlue = Color.fromHex("F0F8FF"),
	Seashell = Color.fromHex("FFF5EE"),
	GhostWhite = Color.fromHex("F8F8FF"),
	Honeydew = Color.fromHex("F0FFF0"),
	FloralWhite = Color.fromHex("FFFAF0"),
	Azure = Color.fromHex("F0FFFF"),
	MintCream = Color.fromHex("F5FFFA"),
	Snow = Color.fromHex("FFFAFA"),
	Ivory = Color.fromHex("FFFFF0"),
	White = Color.fromHex("FFFFFF"),
	Black = Color.fromHex("000000"),
	DarkSlateGray = Color.fromHex("2F4F4F"),
	DimGray = Color.fromHex("696969"),
	SlateGray = Color.fromHex("708090"),
	Gray = Color.fromHex("808080"),
	LightSlateGray = Color.fromHex("778899"),
	DarkGray = Color.fromHex("A9A9A9"),
	Silver = Color.fromHex("C0C0C0"),
	LightGray = Color.fromHex("D3D3D3"),
	Gainsboro = Color.fromHex("DCDCDC"),
}

struct Color {

	float r = 0, g = 0, b = 0, a = 0;

	this(float r, float g, float b, float a = 1) {
		this.r = r;
		this.g = g;
		this.b = b;
		this.a = a;
	}

	this(Color base, float alphaMultiplier = 1) {
		r = base.r;
		g = base.g;
		b = base.b;
		a = base.a * alphaMultiplier;
	}

	Color clamp() {
		import std.algorithm : clamp;

		return Color(
			clamp(r, 0f, 1f),
			clamp(g, 0f, 1f),
			clamp(b, 0f, 1f),
			clamp(a, 0f, 1f),
		);
	}

	uint asUint(string order = "rgba")() {
		import std.algorithm : clamp;

		static assert({
			if (order.length > 4) return false;

			foreach (char ch; order) {
				if (ch != 'a' && ch != 'r' && ch != 'g' && ch != 'b') {
					return false;
				}
			}

			return true;
		}(), "order passed to asUint must be some combination of 'rgba', up to a length of 4");

		uint result = 0;
		static foreach (i, char ch; order) {
			result |= clamp(cast(int)(mixin("" ~ ch) * 255), 0, 255) << 8 * i;
		}
		return result;
	}

	static Color fromHex(string hex) {
		if (hex.length > 0 && hex[0] == '#') {
			hex = hex[1 .. $];
		}

		try {
			if (hex.length == 3) {
				int p1 = hex[0 .. 1].to!int(16);
				int p2 = hex[1 .. 2].to!int(16);
				int p3 = hex[2 .. 3].to!int(16);
				return Color(p1 * 17 / 255f, p2 * 17 / 255f, p3 * 17 / 255f, 1);
			}
			else if (hex.length == 6) {
				int p1 = hex[0 .. 2].to!int(16);
				int p2 = hex[2 .. 4].to!int(16);
				int p3 = hex[4 .. 6].to!int(16);
				return Color(p1 / 255f, p2 / 255f, p3 / 255f, 1);
			}
			else if (hex.length == 4) {
				int p1 = hex[0 .. 1].to!int(16);
				int p2 = hex[1 .. 2].to!int(16);
				int p3 = hex[2 .. 3].to!int(16);
				int p4 = hex[3 .. 4].to!int(16);
				return Color(p1 * 17 / 255f, p2 * 17 / 255f, p3 * 17 / 255f, p4 * 17 / 255f);
			}
			else if (hex.length == 8) {
				int p1 = hex[0 .. 2].to!int(16);
				int p2 = hex[2 .. 4].to!int(16);
				int p3 = hex[4 .. 6].to!int(16);
				int p4 = hex[6 .. 8].to!int(16);
				return Color(p1 / 255f, p2 / 255f, p3 / 255f, p4 / 255f);
			}
			else {
				throw new Exception("invalid hex color");
			}
		}
		catch (ConvException) {
			throw new Exception("invalid hex color");
		}
	}

}
