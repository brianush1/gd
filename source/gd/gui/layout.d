module gd.gui.layout;
import gd.gui.widgets;
import gd.gui.containers;
import gd.gui.padding;
import gd.signal;
import gd.math;

abstract class Layout {

	mixin Property!(Padding, "padding");

	this(Container container) {

	}

	abstract void findAllInRegion(Rect region, scope void delegate(Widget) consumer);

}

enum FillDirection {
	TopToBottom,
	RightToLeft,
	BottomToTop,
	LeftToRight,
}

class ListLayout : Layout {

	mixin Property!(Padding, "padding");

	this(Container container) {
		super(container);
	}

}
