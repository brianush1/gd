import std.datetime;
import std.stdio;
import std.datetime;
import std.conv;
import gd;

void main() {
	Window win = new Window();
	win.title = "Demo Application";
	win.icon = BitmapImage.fromAsset!"icon.png"(BitmapFileFormat.PNG);
	win.background = Color.fromHex("#EFF0F1");

	Button button = new Button();
	button.background = Color.fromHex("#EFF0F1");
	button.position = Dim2(8);
	button.size = Dim2(85, 32);
	// button.border = Border(Color.fromHex("#B2B3B4"), 1, 3);
	// button.shadow = true;
	win.add(button);

	button.onMouseDown.connect((e) {
		button.background = Color.fromHex("#B4DAEE");
		// button.border = Border(Color.fromHex("#3DAEE9"), 1, 3);
		// button.shadow = false;
		button.invalidate();
	});

	button.onMouseUp.connect((e) {
		button.background = Color.fromHex("#EFF0F1");
		// button.border = Border(Color.fromHex("#B2B3B4"), 1, 3);
		// button.shadow = true;
		button.invalidate();
	});

	button.add(new Text("Button 🙂"));
}
