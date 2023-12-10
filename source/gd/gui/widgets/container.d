module gd.gui.widgets.container;
import gd.gui.widgets.base;
import gd.gui.padding;
import gd.graphics;
import gd.signal;
import gd.math;

abstract class Layout {

	abstract void doLayout(Container container, Graphics g, Rect region);

}

class FixedLayout : Layout {

	override void doLayout(Container container, Graphics g, Rect region) {
		foreach (child; container) {
			Rect childRegion = Rect(
				region.position + child.position.compute(region.size),
				child.size.compute(region.size),
			);

			child.paint(g, childRegion);
		}
	}

}

class ListLayout : Layout {

	override void doLayout(Container container, Graphics g, Rect region) {
		double currY = 0;
		foreach (child; container) {
			double childHeight = child.size.compute(region.size).y;
			Rect childRegion = Rect(
				region.position.x, region.position.y + currY,
				region.width, childHeight,
			);
			currY += childHeight;

			child.paint(g, childRegion);
		}
	}

}

class Container : Widget {

	Layout layout;

	mixin Property!(Padding, "padding");
	mixin(setter!("padding"));
	const(Padding) padding() const @property { return m_padding; }

	this() {
		layout = new FixedLayout();
	}

	private Widget[] children;

	// TODO: disallow cycles
	final void add(Widget child) {
		if (child.m_parent) {
			child.m_parent.remove(child);
		}

		child.m_parent = this;
		children ~= child;
	}

	final void remove(Widget child) {
		import std.algorithm : remove, countUntil;

		size_t index = children.countUntil(child);
		if (index != -1) {
			child.m_parent = null;
			children = children.remove(index);
		}
	}

	int opApply(scope int delegate(Widget) dg) {
		int result = 0;
	
		foreach (item; children) {
			result = dg(item);
			if (result)
				break;
		}
	
		return result;
	}

	override void paint(Graphics g, Rect region) {
		super.paint(g, region);

		if (!layout)
			layout = new FixedLayout();

		double paddingTop = padding.top.compute(region.height);
		double paddingBottom = padding.bottom.compute(region.height);
		double paddingLeft = padding.left.compute(region.width);
		double paddingRight = padding.right.compute(region.width);
		layout.doLayout(this, g, Rect(
			region.x + paddingLeft, region.y + paddingTop,
			region.width - (paddingLeft + paddingRight), region.height - (paddingTop + paddingBottom),
		));
	}

}
