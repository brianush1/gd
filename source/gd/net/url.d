module gd.net.url;
import gd.net.address;
import std.string;
import std.conv;

int defaultPortForProtocol(string protocol) {
	if (protocol == "http:")
		return 80;
	else if (protocol == "https:")
		return 443;
	else
		return -1;
}

struct URL {

	string protocol;
	string hostname;

	string username, password;

	/++ The port number of the URL, or -1 if none was specified +/
	int port = -1;

	string pathname, query, hash;

	this(string url) {
		import std.regex : regex, matchFirst;
		import std.range : iota, retro;

		// TODO: replace this with a handrolled parser
		auto matches = url.matchFirst(regex(r"^(([^:/?#]+):)?(//([^/?#]*))?([^?#]*)(\?([^#]*))?(#(.*))?"));

		protocol = matches[1];
		string authority = matches[4];
		pathname = matches[5];
		query = matches[6];
		hash = matches[8];

		if (protocol == "http" || protocol == "https" || protocol == "file") {
			if (!pathname.startsWith("/"))
				pathname = "/" ~ pathname;
		}

		ptrdiff_t delim = authority.indexOf("@");
		if (delim != -1) {
			ptrdiff_t delim2 = authority[0 .. delim].indexOf(":");
			if (delim2 != -1) {
				username = authority[0 .. delim2];
				password = authority[delim2 + 1 .. delim];
			}
			else {
				username = authority[0 .. delim];
			}
			authority = authority[delim + 1 .. $];
		}

		int bracketCount = 0;
		foreach (i; iota(0, authority.length).retro) {
			import std.algorithm : max;

			if (authority[i] == ']')
				bracketCount += 1;
			else if (authority[i] == '[')
				bracketCount = max(0, bracketCount - 1);

			if (bracketCount == 0 && authority[i] == ':') {
				port = cast(int) authority[i + 1 .. $].to!ushort;
				authority = authority[0 .. i];
				break;
			}
		}

		hostname = authority;
	}

	string host() const @property {
		if (port == -1)
			return hostname;
		else
			return text(hostname, ":", port);
	}

	int effectivePort() const @property {
		if (port == -1)
			return defaultPortForProtocol(protocol);
		else
			return port;
	}

	string origin() const @property {
		if (protocol == "http:" || protocol == "https:") {
			string result = text(protocol, "//", hostname);
			int p = effectivePort;
			if (p != defaultPortForProtocol(protocol))
				result ~= text(":", p);
			return result;
		}
		else if (protocol == "file:") {
			return text(protocol, "//");
		}
		else {
			return protocol;
		}
	}

	string href() const @property {
		// TODO: include username and password
		return text(origin, pathname, query, hash);
	}

	string toString() const => href;

}
