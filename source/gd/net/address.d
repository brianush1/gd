module gd.net.address;
import std.bitmanip;
import std.range;
import std.conv;

enum AddressFamily {
	IPv4,
	IPv6,
}

struct AddressInfo {
	Address address;
	string hostname;
}

struct Address {

	package(gd) {
		AddressFamily m_family;
		ubyte[16] m_address;
		ushort m_port;
		uint m_flowInfo;
		uint m_scopeId;
	}

	AddressFamily family() const @property => m_family;
	ushort port() const @property => m_port;

	static Address createIPv4(ubyte[4] ip, ushort port) {
		Address result;
		result.m_family = AddressFamily.IPv4;
		result.m_address[0 .. 4] = ip[];
		result.m_port = port;
		return result;
	}

	static Address createIPv6(ubyte[16] ip, ushort port, uint scopeId = 0) {
		Address result;
		result.m_family = AddressFamily.IPv6;
		result.m_address[0 .. 16] = ip[];
		result.m_port = port;
		result.m_scopeId = scopeId;
		return result;
	}

	string toString() const {
		import std.string : format;

		string result;

		final switch (family) {
		case AddressFamily.IPv4:
			result = format!"%d.%d.%d.%d"(m_address[0], m_address[1], m_address[2], m_address[3]);
			break;
		case AddressFamily.IPv6:
			if (m_address[0 .. 12] == [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0xFF, 0xFF]) {
				// IPv4-mapped address
				result = format!"[::ffff:%d.%d.%d.%d]"(m_address[12], m_address[13], m_address[14], m_address[15]);
			}
			else {
				result ~= "[";
				foreach (i; iota(0, m_address.length, 2)) {
					ushort v = bigEndianToNative!ushort(m_address[i .. i + 2].to!(ubyte[2]));

					if (i != 0 && !(result.length >= 2 && result[$ - 2 .. $] == "::"))
						result ~= ":";

					if (v != 0)
						result ~= format!"%x"(v);
				}
				result ~= "]";
			}
			break;
		}

		if (port != 0)
			result ~= format!":%d"(port);

		return result;
	}

}

// TODO: implement more full-featured DNS queries

AddressInfo[] resolveAddress(string address, ushort port) {
	import gd.system.application : application;

	AddressInfo[] infos = application.socketManager.resolve(address);
	foreach (ref info; infos)
		info.address.m_port = port;
	return infos;
}
