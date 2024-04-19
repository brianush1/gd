module gd.system.linux.openssl;
import gd.system.linux.socket;
import gd.system.socket;
import gd.system.ssl;
import gd.system.application;
import gd.bindings.loader;
import gd.bindings.ssl;

version (gd_Linux):

// CRL = Certificate Revocation List
static immutable string[] sslErrorCodes = [
	"OK (code 0)",
	"Unspecified SSL/TLS error (code 1)",
	"Unable to get TLS issuer certificate (code 2)",
	"Unable to get TLS CRL (code 3)",
	"Unable to decrypt TLS certificate signature (code 4)",
	"Unable to decrypt TLS CRL signature (code 5)",
	"Unable to decode TLS issuer public key (code 6)",
	"TLS certificate signature failure (code 7)",
	"TLS CRL signature failure (code 8)",
	"TLS certificate not yet valid (code 9)",
	"TLS certificate expired (code 10)",
	"TLS CRL not yet valid (code 11)",
	"TLS CRL expired (code 12)",
	"TLS error in certificate not before field (code 13)",
	"TLS error in certificate not after field (code 14)",
	"TLS error in CRL last update field (code 15)",
	"TLS error in CRL next update field (code 16)",
	"TLS system out of memory (code 17)",
	"TLS certificate is self-signed (code 18)",
	"Self-signed certificate in TLS chain (code 19)",
	"Unable to get TLS issuer certificate locally (code 20)",
	"Unable to verify TLS leaf signature (code 21)",
	"TLS certificate chain too long (code 22)",
	"TLS certificate was revoked (code 23)",
	"TLS CA is invalid (code 24)",
	"TLS error: path length exceeded (code 25)",
	"TLS error: invalid purpose (code 26)",
	"TLS error: certificate untrusted (code 27)",
	"TLS error: certificate rejected (code 28)",
];

string getOpenSslErrorCode(long error) {
	import std.conv : to;

	if (error == 62)
		return "TLS certificate host name mismatch";

	if (error < 0 || error >= sslErrorCodes.length)
		return "SSL/TLS error code " ~ to!string(error);

	return sslErrorCodes[cast(size_t) error];
}

class OpenSSLException : Exception {

	this(string fn, string message, string file = __FILE__, size_t line = __LINE__, Throwable nextInChain = null) {
		super("ssl " ~ fn ~ ": " ~ message, file, line, nextInChain);
	}

}

class OpenSSLInfo : SSLInfo {

	SSL.CTX* ctx;
	SSL.SSL* ssl;
	Socket socket;

	package(gd.system) this(Socket socket) {
		scope (failure) dispose();

		addDependency(socket);
		this.socket = socket;
	}

	protected override void disposeImpl() {}

	override void connect() {
		while (true) {
			int ret = SSL.connect(ssl);
			if (ret == -1) {
				int err = SSL.get_error(ssl, ret);
				if (err == SSL.ERROR_WANT_READ) {
					socket.onReadAvailable.wait();
				}
				else if (err == SSL.ERROR_WANT_WRITE) {
					socket.onWriteAvailable.wait();
				}
				else {
					throw new OpenSSLException("connect", getOpenSslErrorCode(SSL.get_verify_result(ssl)));
				}
			}
			else {
				break;
			}
		}
	}

	override size_t send(const(void)[] data) {
		import std.conv : to;

		while (true) {
			int ret = SSL.write(ssl, data.ptr, data.length.to!int);
			if (ret <= 0) {
				int err = SSL.get_error(ssl, ret);
				if (err == SSL.ERROR_WANT_READ) {
					socket.onReadAvailable.wait();
				}
				else if (err == SSL.ERROR_WANT_WRITE) {
					socket.onWriteAvailable.wait();
				}
				else {
					throw new OpenSSLException("send", "");
				}
			}
			else {
				return cast(size_t) ret;
			}
		}
	}

	override ubyte[] read() {
		ubyte[4096] buffer;
		int ret = SSL.read(ssl, buffer.ptr, cast(int) buffer.length);
		if (ret >= 0) {
			return buffer[0 .. ret].dup;
		}
		else {
			return null;
		}
	}

}

class OpenSSLManager : SSLManager {

	package(gd.system) this(Application application) {
		scope (failure) dispose();

		addDependency(application);

		if ((cast(SharedLibrary) SSL).getProcAddress("SSL_library_init"))
			SSL.library_init();
		else
			SSL.OPENSSL_init_ssl(0, null);

		if ((cast(SharedLibrary) SSL).getProcAddress("OpenSSL_add_all_ciphers")) {
			SSL.OpenSSL_add_all_ciphers();
			SSL.OpenSSL_add_all_digests();
		}
		else {
			SSL.OPENSSL_init_crypto(0 /*OPENSSL_INIT_ADD_ALL_CIPHERS and ALL_DIGESTS together*/, null);
		}

		if ((cast(SharedLibrary) SSL).getProcAddress("SSL_load_error_strings"))
			SSL.load_error_strings();
		else
			SSL.OPENSSL_init_ssl(0x00200000L, null);
	}

	protected override void disposeImpl() {}

	override OpenSSLInfo initSSL(Socket socket, bool verifyPeer, string hostname) {
		OpenSSLInfo info = new OpenSSLInfo(socket);
		scope (failure) info.dispose();

		info.ctx = SSL.CTX_new(SSL.TLS_client_method());
		assert(info.ctx !is null);

		info.ssl = SSL.new_(info.ctx);

		if (hostname.length) {
			import std.string : toStringz;

			SSL.ctrl(info.ssl, 55 /*SSL_CTRL_SET_TLSEXT_HOSTNAME*/, 0 /*TLSEXT_NAMETYPE_host_name*/, cast(void*) toStringz(hostname));
			if (verifyPeer)
				SSL.X509_VERIFY_PARAM_set1_host(SSL.get0_param(info.ssl), hostname.ptr, hostname.length);
		}

		if (verifyPeer) {
			SSL.CTX_set_default_verify_paths(info.ctx);
			SSL.set_verify(info.ssl, SSL.VERIFY_PEER, cast(void*) &verifyCertificate);
		}
		else {
			SSL.set_verify(info.ssl, SSL.VERIFY_NONE, null);
		}

		SSL.set_fd(info.ssl, (cast(LinuxSocket) socket).fd);

		SSL.CTX_set_client_cert_cb(info.ctx, &clientCertCallback);

		socket.readAutomatically = false;

		return info;
	}

	private extern (C) static int verifyCertificate(int preverify_ok, SSL.X509_STORE_CTX* ctx) {
		return preverify_ok;
	}

	private extern (C) static int clientCertCallback(SSL.SSL* ssl, SSL.X509** x509, SSL.EVP_PKEY** pkey) {
		return 0;
	}

}
