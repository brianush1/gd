module gd.bindings.ssl;
import gd.bindings.loader;
import gd.resource;
import core.stdc.config;
import core.stdc.stddef;

version (gd_Linux):

private static SSLLibrary m_SSL;
SSLLibrary SSL() @property { // @suppress(dscanner.confusing.function_attributes)
	if (m_SSL is null) {
		m_SSL = loadSSL;
		registerLibraryResource(m_SSL);
	}

	return m_SSL;
}

SSLLibrary loadSSL() {
	string[] libraries;

	version (Posix) {
		libraries = [
			"libssl.so.3", "libssl.so.1.1", "libssl.so.1.0.2",
			"libssl.so.1.0.1", "libssl.so.1.0.0", "libssl.so"
		];
	}
	else {
		assert(0, "unsupported platform");
	}

	return loadSharedLibrary!(SSLLibrary, delegate(string name) {
		return "SSL_" ~ name[0 .. $];
	})(libraries);
}

abstract class SSLLibrary : Resource {
extern (System) @nogc nothrow:

	struct SSL;
	struct CTX;
	struct METHOD;
	struct X509_STORE_CTX;
	enum VERIFY_NONE = 0;
	enum VERIFY_PEER = 1;

	// copy it into the buf[0 .. size] and return actual length you read.
	// rwflag == 0 when reading, 1 when writing.
	extern(C) alias pem_password_cb = int function(char* buffer, int bufferSize, int rwflag, void* userPointer);
	extern(C) alias print_errors_cb = int function(const char*, size_t, void*);
	extern(C) alias client_cert_cb = int function(SSL *ssl, X509 **x509, EVP_PKEY **pkey);
	extern(C) alias keylog_cb = void function(SSL*, char*);

	struct X509;
	struct X509_STORE;
	struct EVP_PKEY;
	struct X509_VERIFY_PARAM;

	enum ERROR_WANT_READ = 2;
	enum ERROR_WANT_WRITE = 3;

	int library_init();
	@BindingName("OpenSSL_add_all_ciphers")
	void OpenSSL_add_all_ciphers();
	@BindingName("OpenSSL_add_all_digests")
	void OpenSSL_add_all_digests();
	void load_error_strings();

	@BindingName("SSLv23_client_method")
	METHOD* SSLv23_client_method();

	@BindingName("OPENSSL_init_ssl")
	void OPENSSL_init_ssl(ulong, void*);
	@BindingName("OPENSSL_init_crypto")
	void OPENSSL_init_crypto(ulong, void*);

	CTX* CTX_new(const METHOD*);
	@BindingName("SSL_new")
	SSL* new_(CTX*);
	int set_fd(SSL*, int);
	int connect(SSL*);
	int write(SSL*, const void*, int);
	int read(SSL*, void*, int);
	int shutdown(SSL*);
	void free(SSL*);
	void CTX_free(CTX*);

	int pending(const SSL*);
	int get_error(const SSL *ssl, int ret);

	void set_verify(SSL*, int, void*);

	void ctrl(SSL*, int, c_long, void*);

	@BindingName("SSLv3_client_method")
	METHOD* SSLv3_client_method();
	@BindingName("TLS_client_method")
	METHOD* TLS_client_method();

	void CTX_set_keylog_callback(CTX*, void function(SSL*, char* line));

	int CTX_set_default_verify_paths(CTX*);

	X509_STORE* CTX_get_cert_store(CTX*);
	c_long get_verify_result(const SSL* ssl);

	@BindingName("X509_VERIFY_PARAM_set1_host")
	int X509_VERIFY_PARAM_set1_host(X509_VERIFY_PARAM* a, const char* b, size_t l);
	X509_VERIFY_PARAM* get0_param(const SSL*);

	/+
	CTX_load_verify_locations
	CTX_set_client_CA_list
	+/

	// client cert things
	void CTX_set_client_cert_cb(CTX *ctx, int function(SSL *ssl, X509 **x509, EVP_PKEY **pkey));
}
