import std.stdio;
import gd.net.address;
import gd.net.tcp;
import gd.net.udp;
import gd.timer;

void main() {
	UdpSocket udp = new UdpSocket("::0", 0);
	udp.sendTo(resolveAddress("localhost", 8091)[0].address, "Hello!");
	writeln("Sent packet.");
	udp.onReceive.connect((Address address, ubyte[] buffer) {
		writeln("Received packet from ", address.toString, ":");

		char[] msg = cast(char[]) buffer;
		while (msg[$ - 1] == '\n')
			msg = msg[0 .. $ - 1];

		writeln(msg);
	});
}
