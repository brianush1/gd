module gd.gui.widgets.base;
import gd.gui.containers;
import gd.gui.padding;
import gd.gui.event;
import gd.geom;
import gd.signal;
import gd.graphics;
import gd.math;
import std.exception;

mixin template Property(T, string name, T initValue = T.init) {
	static assert(!is(T == K[N], K, size_t N), "'is' on static arrays is broken, so setters won't work");
	mixin("
		private T m_"~name~" = initValue;
		Signal!(T) on"~cast(char)(name[0] + 'A' - 'a') ~ name[1 .. $]~"Change;
		Signal!(T, T) on"~cast(char)(name[0] + 'A' - 'a') ~ name[1 .. $]~"ChangeEx;
	");
}

enum setter(string name, string access = "public") = access~" typeof(m_"~name~") "~name~"(typeof(m_"~name~") value)
@property {
	auto oldValue = m_"~name~";
	if (oldValue is value) {
		return oldValue;
	}
	m_"~name~" = value;
	on"~cast(char)(name[0] + 'A' - 'a') ~ name[1 .. $]~"Change.emit(value);
	on"~cast(char)(name[0] + 'A' - 'a') ~ name[1 .. $]~"ChangeEx.emit(oldValue, value);
	return m_"~name~";
}";

abstract class Widget {

	mixin Property!(Dim2, "position");
	mixin(setter!"position");
	const(Dim2) position() const @property { return m_position; }

	mixin Property!(Dim2, "size", Dim2(1, 0, 1, 0));
	mixin(setter!"size");
	const(Dim2) size() const @property { return m_size; }

	mixin Property!(Padding, "margin");
	mixin(setter!("margin"));
	const(Padding) margin() const @property { return m_margin; }

	mixin Property!(bool, "visible", true);
	mixin(setter!"visible");
	const(bool) visible() const @property { return m_visible; }

	mixin Property!(Color, "background");
	mixin(setter!"background");
	const(Color) background() const @property { return m_background; }

	private Container m_parent;
	final inout(Container) parent() inout @property { return m_parent; }

	// TODO: invalidate regions
	void invalidate() {
		if (parent)
			parent.invalidate();
	}

	void paint(Graphics g, Rect region) {
		// if (shadow) {
		// 	g.fill(Color.fromHex("#0002"), Area.roundedRect(Rect(
		// 		region.position + Vec2(0, 1),
		// 		region.size,
		// 	), border.radius));
		// }
		// if (border.width != 0)
		// 	g.fill(border.color, Area.roundedRect(region, border.radius));
		// g.fill(background, Area.roundedRect(
		// 	Rect(
		// 		region.position + Vec2(border.width),
		// 		region.size - Vec2(border.width) * 2,
		// 	),
		// 	border.radius - border.width
		// ));
		g.fill(background, Area.rect(region));
	}

	Signal!Event onMouseEnter;
	Signal!Event onMouseLeave;
	Signal!Event onMouseDown;
	Signal!Event onMouseUp;
	Signal!Event onMouseMove;
	Signal!Event onMouseMotion;

	Signal!Event onActivationStart;
	Signal!Event onActivationEnd;
	Signal!Event onActivate; // click event

}

abstract class Container : Widget {

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

	Widget[] getChildren() {
		return children.dup;
	}

	override void paint(Graphics g, Rect region) {
		super.paint(g, region);

		foreach (child; children) {
			Rect childRegion = Rect(
				region.position + child.position.compute(region.size),
				child.size.compute(region.size),
			);
			child.paint(g, childRegion);
		}
	}

}