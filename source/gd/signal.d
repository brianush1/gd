module gd.signal;
import std.typecons;
import std.uuid;

alias Handler(T...) = void delegate(T args);
alias Slot = UUID;

struct Signal(T...) {

	private {
		struct Connection {
			Handler!T handler;
		}

		Connection[Slot] connections;
		Signal!()* m_onConnect;
		Signal!()* m_onFullDisconnect;
	}

	@disable this(ref return scope Signal!T rhs);

	bool hasConnections() {
		return connections.length != 0;
	}

	ref inout(Signal!()) onConnect() inout @property {
		if (m_onConnect == null) {
			(cast(Signal!T*) &this).m_onConnect = new Signal!();
		}
		return *m_onConnect;
	}

	ref inout(Signal!()) onFullDisconnect() inout @property {
		if (m_onFullDisconnect == null) {
			(cast(Signal!T*) &this).m_onFullDisconnect = new Signal!();
		}
		return *m_onFullDisconnect;
	}

	Slot connect(Handler!T handler) {
		Slot id;
		do {
			id = randomUUID();
		}
		while (id in connections); // it's HIGHLY unlikely that we have a collision
		// but why risk it?

		if (connections.length == 0 && m_onConnect != null) {
			m_onConnect.emit();
		}

		connections[id] = Connection(handler);
		return id;
	}

	void disconnect(Slot id) {
		if (id in connections) {
			connections.remove(id);
		}

		if (connections.length == 0 && m_onFullDisconnect != null) {
			m_onFullDisconnect.emit();
		}
	}

	Slot once(Handler!T handler) {
		Slot con;
		con = connect((T args) {
			disconnect(con);
			handler(args);
		});

		return con;
	}

	void emit(T args) const {
		import std.array : array;

		foreach (connection; connections.byValue.array) {
			connection.handler(args);
		}
	}

}
