module gd.gui.widgets.text;
import gd.gui.widgets;
import gd.graphics;
import gd.math;

class Text : Widget {

	Color color = Colors.Black;
	string text = "Text";
	Font font = Font(FontType.Sans);

	this() {}

	this(string text) {
		this.text = text;
	}

	override void paint(Graphics g, Rect region) {
		super.paint(g, region);

		g.drawString(color, text, font, region);
	}

}
