module gd.gui.event;
import gd.gui.element;

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
