module gd.gui.themes.breeze;
import gd.gui.widgets;
import gd.gui.style;
import gd.graphics;
import gd.math;

StyleSheet theme;

shared static this() {
	theme = new StyleSheet();
	theme.addStyle!(Button)((Style s) { with (s) {
		font = Font(FontType.Sans);
		background = Color.fromHex("#EFF0F1");
		border ~= Border(Color.fromHex("#B2B3B4"));
		roundness = 3;
		shadow ~= Shadow(
			Color.fromHex("#0002"),
			Vec2(0, 1),
			0,
		);
	}});
}
