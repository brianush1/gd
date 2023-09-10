module gd.gui.style;
import gd.gui.padding;
import gd.graphics.color;
import gd.graphics.text;
import gd.math;

struct Border {
	Color color;
	Padding width = Padding(1);
}

struct Shadow {
	Color color;
	Vec2 offset;
	double blur = 0;
}

class Style {
	Dim2 position;
	Dim2 size = Dim2(1, 0, 1, 0);
	Font font = Font(FontType.Sans);
	Padding margin, padding;
	bool visible = true;
	Color background;
	double roundness = 0;
	Border[] border;
	Shadow[] shadow, textShadow;
}

class StyleSheet {
	void addStyle(Selector)(void delegate(Style) styleDg) {
		Style style = new Style();
		styleDg(style);

	}
}
