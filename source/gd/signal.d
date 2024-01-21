module gd.signal;
import std.typecons;
import std.uuid;

alias Handler(T...) = void delegate(T args);
alias Slot = UUID;

struct Signal(T...) {

	private {
		struct Connection {
			Slot slot;
			Handler!T handler;
		}

		Connection[] connections;
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
		Slot id = randomUUID();

		if (connections.length == 0 && m_onConnect != null) {
			m_onConnect.emit();
		}

		connections ~= Connection(id, handler);
		return id;
	}

	void disconnect(Slot id) {
		import std.algorithm : remove, countUntil;

		ptrdiff_t index = connections.countUntil!(x => x.slot == id);
		if (index != -1) {
			connections = connections.remove(index);
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
		import gd.threading : spawnTask;

		foreach (connection; connections.dup) {
			spawnTask({
				connection.handler(args);
			});
		}
	}

	Tuple!T wait() const {
		import core.thread.fiber : Fiber;

		Tuple!T result;

		Fiber fiber = Fiber.getThis();
		(cast() this).once((T args) {
			result = Tuple!T(args);
			fiber.call();
		});

		Fiber.yield();
		return result;
	}

}
