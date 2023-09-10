module gd.gui.event;
import gd.gui.widgets;

class Event {

	private bool m_defaultPrevented = false;
	bool defaultPrevented() const @property { return m_defaultPrevented; }

	private bool m_propagationStopped = false;
	bool propagationStopped() const @property { return m_propagationStopped; }

	Widget target;

	void preventDefault() {
		m_defaultPrevented = true;
	}

	void stopPropagation() {
		m_propagationStopped = true;
	}

}

class ChangeEvent(T) : Event {

	T previousValue;
	T value;

}
