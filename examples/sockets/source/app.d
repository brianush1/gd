import std.stdio;
import gd.net.address;
import gd.net.tcp;
import gd.net.udp;
import gd.timer;

void startUdpDemo() {
	UdpSocket udp = new UdpSocket("::0", 8091);
	writeln("UDP socket is listening. Try connecting with `nc -u localhost 8091` and typing some stuff!");
	udp.onReceive.connect((Address address, ubyte[] buffer) {
		writeln("Received packet from ", address.toString, ":");

		char[] msg = cast(char[]) buffer;
		while (msg[$ - 1] == '\n')
			msg = msg[0 .. $ - 1];

		writeln(msg);

		udp.sendTo(address, "I received a message from you. It said \"" ~ msg ~ "\".\n");
	});
}

void startTcpDemo() {
	string host = "example.com";

	writeln("Connecting to " ~ host);
	TcpClient client = new TcpClient(5.seconds, host, 80);
	writeln("Connected.");
	ubyte[] data;
	client.onReceive.connect((ubyte[] buffer) {
		data ~= buffer;
	});
	client.send("GET / HTTP/1.1\r\nHost: " ~ host ~ "\r\nConnection: close\r\n\r\n");
	writeln("Waiting until all data is received...");
	client.onClose.wait();
	writeln(cast(char[]) data);
}

void main() {
	startTcpDemo();
	startUdpDemo();
}
