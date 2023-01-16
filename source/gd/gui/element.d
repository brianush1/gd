module gd.gui.element;
import gd.signal;
import gd.graphics;
import gd.math;
import std.exception;

final class Container {

	private Element m_boundElement;
	inout(Element) boundElement() inout @property { return m_boundElement; }

	private double zIndex;
	private Element head, tail;

	void append(Element child, Element sibling = tail) {
		assert(child !is null);

		// TODO: verify that no cycles are made

		if (child.m_parentContainer !is null) {
			child.m_parentContainer.remove(child);
		}

		child.m_parentContainer = this;
		if (sibling is null) {
			if (head is null) {
				head = tail = child;
			}
			else {
				prepend(child, head);
			}
		}
		else {
			sibling.m_nextSibling = child;
			child.m_prevSibling = sibling;
			if (sibling is tail) {
				tail = child;
			}
		}
	}

	void prepend(Element child, Element sibling = head) {
		assert(child !is null);

		// TODO: verify that no cycles are made

		if (child.m_parentContainer !is null) {
			child.m_parentContainer.remove(child);
		}

		child.m_parentContainer = this;
		if (sibling is null) {
			if (head is null) {
				head = tail = child;
			}
			else {
				append(child, head);
			}
		}
		else {
			child.m_nextSibling = sibling;
			sibling.m_prevSibling = child;
			if (sibling is head) {
				head = child;
			}
		}
	}

	void remove(Element child) {
		if (child.m_parentContainer !is this) {
			return;
		}

		// update head and tail of linked list
		if (head is child) head = head.m_nextSibling;
		if (tail is child) tail = tail.m_prevSibling;

		child.m_parentContainer = null; // reparent

		// update links of prev and next
		child.m_prevSibling.m_nextSibling = child.m_nextSibling;
		child.m_nextSibling.m_prevSibling = child.m_prevSibling;

		// remove siblings of child
		child.m_nextSibling = null;
		child.m_prevSibling = null;
	}

	int opApply(T)(scope int delegate(ref T) dg) if (is(Element : T)) {
		int result = 0;

		Element at = head;
		while (at !is null) {
			result = dg(at);
			if (result) break;
			at = at.m_nextSibling;
		}

		return result;
	}

	int opApplyReverse(T)(scope int delegate(ref T) dg) if (is(Element : T)) {
		int result = 0;

		Element at = tail;
		while (at !is null) {
			result = dg(at);
			if (result) break;
			at = at.m_prevSibling;
		}

		return result;
	}

}

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

abstract class Element {

	mixin Property!(Vec2, "absolutePosition");
	mixin(setter!("absolutePosition", "package"));
	inout(Vec2) absolutePosition() inout @property { return m_absolutePosition; }

	mixin Property!(Vec2, "absoluteSize");
	mixin(setter!("absoluteSize", "package"));
	inout(Vec2) absoluteSize() inout @property { return m_absoluteSize; }

	mixin Property!(Dim2, "position", Dim2(0, 0));
	mixin(setter!"position");
	inout(Dim2) position() inout @property { return m_position; }

	mixin Property!(Dim2, "size");
	mixin(setter!"size");
	inout(Dim2) size() inout @property { return m_size; }

	mixin Property!(bool, "visible", true);
	mixin(setter!"visible");
	inout(bool) visible() inout @property { return m_visible; }

	mixin Property!(Color, "background", Color.init);
	mixin(setter!"background");
	inout(Color) background() inout @property { return m_background; }

	private Container[] containers;
	inout(Container) container() inout @property { return containers[0]; }
	alias container this;

	this() {
		bind(new Container, 1);
	}

	protected final void bind(Container container, double zIndex = 0) {
		if (container.boundElement !is null) {
			container.boundElement.unbind(container);
		}

		container.m_boundElement = this;
		container.zIndex = zIndex;
		containers ~= container;
	}

	protected final void unbind(Container container) {
		import std.algorithm : remove, countUntil;

		if (container.boundElement !is this) {
			return;
		}

		enforce(container !is containers[0], "cannot unbind primary container from an element");

		containers = containers.remove(containers.countUntil(container));
	}

	private Container m_parentContainer;
	private Element m_prevSibling, m_nextSibling;

	final inout(Container) parentContainer() inout @property { return m_parentContainer; }
	final inout(Element) parentElement() inout @property { return parentContainer.boundElement; }
	final inout(Element) prevSibling() inout @property { return m_prevSibling; }
	final inout(Element) nextSibling() inout @property { return m_nextSibling; }

	void invalidate() {

	}

	void paint() {

	}

}

class Event {

	private bool m_defaultPrevented = false;
	bool defaultPrevented() const @property { return m_defaultPrevented; }

	private bool m_propagationStopped = false;
	bool propagationStopped() const @property { return m_propagationStopped; }

	Element target;

	void preventDefault() {
		m_defaultPrevented = true;
	}

	void stopPropagation() {
		m_propagationStopped = true;
	}

}
