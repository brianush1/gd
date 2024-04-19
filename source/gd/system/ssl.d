module gd.system.ssl;
import gd.system.socket;
import gd.resource;
import gd.signal;

abstract class SSLInfo : Resource {

	abstract void connect();
	abstract size_t send(const(void)[] data);
	abstract ubyte[] read();

}

abstract class SSLManager : Resource {

	abstract SSLInfo initSSL(Socket socket, bool verifyPeer, string hostname);

}
