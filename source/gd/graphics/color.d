module gd.graphics.color;
import std.conv;

struct Color {

	float r = 0, g = 0, b = 0, a = 0;

	this(float r, float g, float b, float a = 1) {
		this.r = r;
		this.g = g;
		this.b = b;
		this.a = a;
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

	uint asUint(string order = "argb")() {
		import std.algorithm : clamp;

		static assert({
			if (order.length != 4) return false;

			bool[char] set;
			foreach (char ch; order) {
				if (ch in set) {
					return false;
				}

				if (ch != 'a' && ch != 'r' && ch != 'g' && ch != 'b') {
					return false;
				}

				set[ch] = true;
			}

			return true;
		}(), "order passed to asUint must be a permutation of 'argb'");

		uint result = 0;
		static foreach (i, char ch; order) {
			result |= clamp(cast(int)(mixin("" ~ ch) * 255), 0, 255) << 8 * (3 - i);
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
