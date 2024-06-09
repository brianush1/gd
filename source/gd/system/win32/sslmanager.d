module gd.system.win32.sslmanager;
import gd.system.win32.socket;
import gd.system.win32.exception;
import gd.system.socket;
import gd.system.ssl;
import gd.system.application;
import gd.bindings.loader;
import gd.bindings.ssl;
import std.exception;

// large parts of this code were taken from https://web.archive.org/web/20210116110926/http://www.coastrd.com/c-schannel-smtp

version (gd_Win32):

import core.sys.windows.windows;
import core.sys.windows.sspi;
import core.sys.windows.security;
import core.sys.windows.schannel;
import core.sys.windows.wincrypt;
import core.sys.windows.ntsecpkg;

private {
	enum ISC_REQ_DELEGATE                = 0x00000001;
	enum ISC_REQ_MUTUAL_AUTH             = 0x00000002;
	enum ISC_REQ_REPLAY_DETECT           = 0x00000004;
	enum ISC_REQ_SEQUENCE_DETECT         = 0x00000008;
	enum ISC_REQ_CONFIDENTIALITY         = 0x00000010;
	enum ISC_REQ_USE_SESSION_KEY         = 0x00000020;
	enum ISC_REQ_PROMPT_FOR_CREDS        = 0x00000040;
	enum ISC_REQ_USE_SUPPLIED_CREDS      = 0x00000080;
	enum ISC_REQ_ALLOCATE_MEMORY         = 0x00000100;
	enum ISC_REQ_USE_DCE_STYLE           = 0x00000200;
	enum ISC_REQ_DATAGRAM                = 0x00000400;
	enum ISC_REQ_CONNECTION              = 0x00000800;
	enum ISC_REQ_CALL_LEVEL              = 0x00001000;
	enum ISC_REQ_FRAGMENT_SUPPLIED       = 0x00002000;
	enum ISC_REQ_EXTENDED_ERROR          = 0x00004000;
	enum ISC_REQ_STREAM                  = 0x00008000;
	enum ISC_REQ_INTEGRITY               = 0x00010000;
	enum ISC_REQ_IDENTIFY                = 0x00020000;
	enum ISC_REQ_NULL_SESSION            = 0x00040000;
	enum ISC_REQ_MANUAL_CRED_VALIDATION  = 0x00080000;
	enum ISC_REQ_RESERVED1               = 0x00100000;
	enum ISC_REQ_FRAGMENT_TO_FIT         = 0x00200000;
	
	enum SP_PROT_TLS1_2_SERVER           = 0x00000400;
	enum SP_PROT_TLS1_2_CLIENT           = 0x00000800;
	enum SP_PROT_TLS1_2                  = SP_PROT_TLS1_2_SERVER | SP_PROT_TLS1_2_CLIENT;

	enum SP_PROT_TLS1_3_SERVER           = 0x00001000;
	enum SP_PROT_TLS1_3_CLIENT           = 0x00002000;
	enum SP_PROT_TLS1_3                  = SP_PROT_TLS1_3_SERVER | SP_PROT_TLS1_3_CLIENT;

	enum SCH_USE_STRONG_CRYPTO           = 0x00400000;

}

private string getSECErrorString(DWORD errCode) {
	switch (errCode) {
		case SEC_E_BUFFER_TOO_SMALL: return "SEC_E_BUFFER_TOO_SMALL - The message buffer is too small. Used with the Digest SSP.";
		case SEC_E_CRYPTO_SYSTEM_INVALID: return "SEC_E_CRYPTO_SYSTEM_INVALID - The cipher chosen for the security context is not supported. Used with the Digest SSP.";
		case SEC_E_INCOMPLETE_MESSAGE: return "SEC_E_INCOMPLETE_MESSAGE - The data in the input buffer is incomplete. The application needs to read more data from the server and call DecryptMessage (General) again.";
		case SEC_E_INVALID_HANDLE: return "SEC_E_INVALID_HANDLE - A context handle that is not valid was specified in the phContext parameter. Used with the Digest and Schannel SSPs.";
		case SEC_E_INVALID_TOKEN: return "SEC_E_INVALID_TOKEN - The buffers are of the wrong type or no buffer of type SECBUFFER_DATA was found. Used with the Schannel SSP.";
		case SEC_E_MESSAGE_ALTERED: return "SEC_E_MESSAGE_ALTERED - The message has been altered. Used with the Digest and Schannel SSPs.";
		case SEC_E_OUT_OF_SEQUENCE: return "SEC_E_OUT_OF_SEQUENCE - The message was not received in the correct sequence.";
		case SEC_E_QOP_NOT_SUPPORTED: return "SEC_E_QOP_NOT_SUPPORTED - Neither confidentiality nor integrity are supported by the security context. Used with the Digest SSP.";
		case SEC_I_CONTEXT_EXPIRED: return "SEC_I_CONTEXT_EXPIRED - The message sender has finished using the connection and has initiated a shutdown.";
		case SEC_I_RENEGOTIATE: return "SEC_I_RENEGOTIATE - The remote party requires a new handshake sequence or the application has just initiated a shutdown.";
		case SEC_E_ENCRYPT_FAILURE: return "SEC_E_ENCRYPT_FAILURE - The specified data could not be encrypted.";
		case SEC_E_DECRYPT_FAILURE: return "SEC_E_DECRYPT_FAILURE - The specified data could not be decrypted.";
		case SEC_E_OK: return "SEC_E_OK";
		case SEC_E_INSUFFICIENT_MEMORY: return "SEC_E_INSUFFICIENT_MEMORY";
		// case SEC_E_INVALID_HANDLE: return "SEC_E_INVALID_HANDLE";
		case SEC_E_UNSUPPORTED_FUNCTION: return "SEC_E_UNSUPPORTED_FUNCTION";
		case SEC_E_TARGET_UNKNOWN: return "SEC_E_TARGET_UNKNOWN";
		case SEC_E_INTERNAL_ERROR: return "SEC_E_INTERNAL_ERROR";
		case SEC_E_SECPKG_NOT_FOUND: return "SEC_E_SECPKG_NOT_FOUND";
		case SEC_E_NOT_OWNER: return "SEC_E_NOT_OWNER";
		case SEC_E_CANNOT_INSTALL: return "SEC_E_CANNOT_INSTALL";
		// case SEC_E_INVALID_TOKEN: return "SEC_E_INVALID_TOKEN";
		case SEC_E_CANNOT_PACK: return "SEC_E_CANNOT_PACK";
		// case SEC_E_QOP_NOT_SUPPORTED: return "SEC_E_QOP_NOT_SUPPORTED";
		case SEC_E_NO_IMPERSONATION: return "SEC_E_NO_IMPERSONATION";
		case SEC_E_LOGON_DENIED: return "SEC_E_LOGON_DENIED";
		case SEC_E_UNKNOWN_CREDENTIALS: return "SEC_E_UNKNOWN_CREDENTIALS";
		case SEC_E_NO_CREDENTIALS: return "SEC_E_NO_CREDENTIALS";
		// case SEC_E_MESSAGE_ALTERED: return "SEC_E_MESSAGE_ALTERED";
		// case SEC_E_OUT_OF_SEQUENCE: return "SEC_E_OUT_OF_SEQUENCE";
		case SEC_E_NO_AUTHENTICATING_AUTHORITY: return "SEC_E_NO_AUTHENTICATING_AUTHORITY";
		case SEC_E_BAD_PKGID: return "SEC_E_BAD_PKGID";
		case SEC_E_CONTEXT_EXPIRED: return "SEC_E_CONTEXT_EXPIRED";
		// case SEC_E_INCOMPLETE_MESSAGE: return "SEC_E_INCOMPLETE_MESSAGE";
		case SEC_E_INCOMPLETE_CREDENTIALS: return "SEC_E_INCOMPLETE_CREDENTIALS";
		// case SEC_E_BUFFER_TOO_SMALL: return "SEC_E_BUFFER_TOO_SMALL";
		case SEC_E_WRONG_PRINCIPAL: return "SEC_E_WRONG_PRINCIPAL";
		case SEC_E_TIME_SKEW: return "SEC_E_TIME_SKEW";
		case SEC_E_UNTRUSTED_ROOT: return "SEC_E_UNTRUSTED_ROOT";
		case SEC_E_ILLEGAL_MESSAGE: return "SEC_E_ILLEGAL_MESSAGE";
		case SEC_E_CERT_UNKNOWN: return "SEC_E_CERT_UNKNOWN";
		case SEC_E_CERT_EXPIRED: return "SEC_E_CERT_EXPIRED";
		// case SEC_E_ENCRYPT_FAILURE: return "SEC_E_ENCRYPT_FAILURE";
		// case SEC_E_DECRYPT_FAILURE: return "SEC_E_DECRYPT_FAILURE";
		case SEC_E_ALGORITHM_MISMATCH: return "SEC_E_ALGORITHM_MISMATCH";
		case SEC_E_SECURITY_QOS_FAILED: return "SEC_E_SECURITY_QOS_FAILED";
		case SEC_E_UNFINISHED_CONTEXT_DELETED: return "SEC_E_UNFINISHED_CONTEXT_DELETED";
		case SEC_E_NO_TGT_REPLY: return "SEC_E_NO_TGT_REPLY";
		case SEC_E_NO_IP_ADDRESSES: return "SEC_E_NO_IP_ADDRESSES";
		case SEC_E_WRONG_CREDENTIAL_HANDLE: return "SEC_E_WRONG_CREDENTIAL_HANDLE";
		// case SEC_E_CRYPTO_SYSTEM_INVALID: return "SEC_E_CRYPTO_SYSTEM_INVALID";
		case SEC_E_MAX_REFERRALS_EXCEEDED: return "SEC_E_MAX_REFERRALS_EXCEEDED";
		case SEC_E_MUST_BE_KDC: return "SEC_E_MUST_BE_KDC";
		case SEC_E_STRONG_CRYPTO_NOT_SUPPORTED: return "SEC_E_STRONG_CRYPTO_NOT_SUPPORTED";
		case SEC_E_TOO_MANY_PRINCIPALS: return "SEC_E_TOO_MANY_PRINCIPALS";
		case SEC_E_NO_PA_DATA: return "SEC_E_NO_PA_DATA";
		case SEC_E_PKINIT_NAME_MISMATCH: return "SEC_E_PKINIT_NAME_MISMATCH";
		case SEC_E_SMARTCARD_LOGON_REQUIRED: return "SEC_E_SMARTCARD_LOGON_REQUIRED";
		case SEC_E_SHUTDOWN_IN_PROGRESS: return "SEC_E_SHUTDOWN_IN_PROGRESS";
		case SEC_E_KDC_INVALID_REQUEST: return "SEC_E_KDC_INVALID_REQUEST";
		case SEC_E_KDC_UNABLE_TO_REFER: return "SEC_E_KDC_UNABLE_TO_REFER";
		case SEC_E_KDC_UNKNOWN_ETYPE: return "SEC_E_KDC_UNKNOWN_ETYPE";
		case SEC_E_UNSUPPORTED_PREAUTH: return "SEC_E_UNSUPPORTED_PREAUTH";
		case SEC_E_DELEGATION_REQUIRED: return "SEC_E_DELEGATION_REQUIRED";
		case SEC_E_BAD_BINDINGS: return "SEC_E_BAD_BINDINGS";
		case SEC_E_MULTIPLE_ACCOUNTS: return "SEC_E_MULTIPLE_ACCOUNTS";
		case SEC_E_NO_KERB_KEY: return "SEC_E_NO_KERB_KEY";
		case SEC_E_CERT_WRONG_USAGE: return "SEC_E_CERT_WRONG_USAGE";
		case SEC_E_DOWNGRADE_DETECTED: return "SEC_E_DOWNGRADE_DETECTED";
		// case SEC_E_SMARTCARD_CERT_REVOKED: return "SEC_E_SMARTCARD_CERT_REVOKED";
		// case SEC_E_ISSUING_CA_UNTRUSTED: return "SEC_E_ISSUING_CA_UNTRUSTED";
		// case SEC_E_REVOCATION_OFFLINE_C: return "SEC_E_REVOCATION_OFFLINE_C";
		case SEC_E_PKINIT_CLIENT_FAILURE: return "SEC_E_PKINIT_CLIENT_FAILURE";
		// case SEC_E_SMARTCARD_CERT_EXPIRED: return "SEC_E_SMARTCARD_CERT_EXPIRED";
		case SEC_E_NO_S4U_PROT_SUPPORT: return "SEC_E_NO_S4U_PROT_SUPPORT";
		case SEC_E_CROSSREALM_DELEGATION_FAILURE: return "SEC_E_CROSSREALM_DELEGATION_FAILURE";
		case SEC_E_REVOCATION_OFFLINE_KDC: return "SEC_E_REVOCATION_OFFLINE_KDC";
		case SEC_E_ISSUING_CA_UNTRUSTED_KDC: return "SEC_E_ISSUING_CA_UNTRUSTED_KDC";
		case SEC_E_KDC_CERT_EXPIRED: return "SEC_E_KDC_CERT_EXPIRED";
		case SEC_E_KDC_CERT_REVOKED: return "SEC_E_KDC_CERT_REVOKED";
		case SEC_E_INVALID_PARAMETER: return "SEC_E_INVALID_PARAMETER";
		case SEC_E_DELEGATION_POLICY: return "SEC_E_DELEGATION_POLICY";
		case SEC_E_POLICY_NLTM_ONLY: return "SEC_E_POLICY_NLTM_ONLY";
		case SEC_E_NO_CONTEXT: return "SEC_E_NO_CONTEXT";
		case SEC_E_PKU2U_CERT_FAILURE: return "SEC_E_PKU2U_CERT_FAILURE";
		case SEC_E_MUTUAL_AUTH_FAILED: return "SEC_E_MUTUAL_AUTH_FAILED";
		case SEC_E_ONLY_HTTPS_ALLOWED: return "SEC_E_ONLY_HTTPS_ALLOWED";
		case SEC_E_APPLICATION_PROTOCOL_MISMATCH: return "SEC_E_APPLICATION_PROTOCOL_MISMATCH";
		case SEC_E_INVALID_UPN_NAME: return "SEC_E_INVALID_UPN_NAME";
		case SEC_E_EXT_BUFFER_TOO_SMALL: return "SEC_E_EXT_BUFFER_TOO_SMALL";
		case SEC_E_INSUFFICIENT_BUFFERS: return "SEC_E_INSUFFICIENT_BUFFERS";
		// case SEC_E_NO_SPM: return "SEC_E_NO_SPM";
		// case SEC_E_NOT_SUPPORTED: return "SEC_E_NOT_SUPPORTED";
		default: return "";
	}
}

class Win32SSLInfo : SSLInfo {

	Win32SSLManager sslManager;
	CredHandle hCreds;
	Win32Socket socket;
	CtxtHandle hContext;
	bool hasContext;

	SecPkgContext_StreamSizes sizes;

	private {
		bool verifyPeer;
		string hostname;
	}

	private inout(PSecurityFunctionTableW) sspi() inout @property => sslManager.sspi;

	package(gd.system) this(Win32SSLManager sslManager, Win32Socket socket) {
		scope (failure) dispose();

		addDependency(sslManager);
		addDependency(socket);
		this.sslManager = sslManager;
		this.socket = socket;
	}

	protected override void disposeImpl() {
		if (hasContext)
			sspi.DeleteSecurityContext(&hContext);
	}

	private enum DWORD dwSSPIFlags = 0
		| ISC_REQ_USE_SUPPLIED_CREDS
		| ISC_REQ_ALLOCATE_MEMORY
		| ISC_REQ_CONFIDENTIALITY
		| ISC_REQ_REPLAY_DETECT
		| ISC_REQ_SEQUENCE_DETECT
		| ISC_REQ_STREAM
		;

	override void connect() {
		import std.conv : to;

		SecBufferDesc outBuffer;
		SecBuffer[1] outBuffers;

		outBuffers[0].pvBuffer = null;
		outBuffers[0].BufferType = SECBUFFER_TOKEN;
		outBuffers[0].cbBuffer = 0;

		outBuffer.cBuffers = 1;
		outBuffer.pBuffers = outBuffers.ptr;
		outBuffer.ulVersion = SECBUFFER_VERSION;

		TimeStamp tsExpiry;
		DWORD dwSSPIOutFlags;

		wchar[] hostnameW = hostname.to!(wchar[]) ~ cast(wchar) 0;
		SECURITY_STATUS scRet = sspi.InitializeSecurityContextW(&hCreds,
			null, hostnameW.ptr,
			dwSSPIFlags, 0, SECURITY_NATIVE_DREP, null, 0, &hContext,
			&outBuffer, &dwSSPIOutFlags, &tsExpiry,
		);
		enforce(scRet == SEC_I_CONTINUE_NEEDED, "failed to initialize security context");
		hasContext = true;

		void sendResponse() {
			if (outBuffers[0].cbBuffer != 0 && outBuffers[0].pvBuffer != null) {
				scope (exit) {
					sspi.FreeContextBuffer(outBuffers[0].pvBuffer);
					outBuffers[0].pvBuffer = null;
				}

				socket.send(outBuffers[0].pvBuffer[0 .. outBuffers[0].cbBuffer]);
			}
		}

		sendResponse();

		handshakeLoop(true);
		socket.onReadAvailable.connect({
			while (true) {
				ubyte[4096] buffer;
				int received = recv(socket.fd, buffer.ptr, buffer.length, 0);
				if (received == SOCKET_ERROR) {
					int errno = WSAGetLastError();
					if (errno == EWOULDBLOCK) {
						break;
					}
					else {
						// TODO: how do we handle an error here
						import std.stdio : writeln;
						writeln("read error: ", errno);
						continue;
					}
				}
				else if (received > 0) {
					inputBuffer ~= buffer[0 .. received];
				}
				else {
					break;
				}
			}
		});
	}

	private void handshakeLoop(bool doInitialRead) {
		bool doRead = doInitialRead;

		SecBuffer[2] inBuffers;
		SecBuffer[1] outBuffers;
		SecBufferDesc inBuffer, outBuffer;

		ubyte[] ioBuffer;

		void sendResponse() {
			if (outBuffers[0].cbBuffer != 0 && outBuffers[0].pvBuffer != null) {
				scope (exit) {
					sspi.FreeContextBuffer(outBuffers[0].pvBuffer);
					outBuffers[0].pvBuffer = null;
				}

				socket.send(outBuffers[0].pvBuffer[0 .. outBuffers[0].cbBuffer]);
			}
		}

		SECURITY_STATUS scRet = SEC_I_CONTINUE_NEEDED;
		while (scRet == SEC_I_CONTINUE_NEEDED
			|| scRet == SEC_E_INCOMPLETE_MESSAGE
			|| scRet == SEC_I_INCOMPLETE_CREDENTIALS
		) {
			if (doRead) {
				ubyte[4096] buffer;
				int ret;
				while (true) {
					ret = recv(socket.fd, buffer.ptr, cast(int) buffer.length, 0);
					if (ret == SOCKET_ERROR) {
						int errno = WSAGetLastError();
						if (errno == EWOULDBLOCK) {
							socket.onReadAvailable.wait();
							continue;
						}
						else {
							throw new Win32Exception("read", errno);
						}
					}
					else {
						ioBuffer ~= buffer[0 .. ret];
						break;
					}
				}
			}
			else {
				doRead = true;
			}

			// Set up the input buffers. Buffer 0 is used to pass in data
			// received from the server. Schannel will consume some or all
			// of this. Leftover data (if any) will be placed in buffer 1 and
			// given a buffer type of SECBUFFER_EXTRA.
			inBuffers[0].pvBuffer    = ioBuffer.ptr;
			inBuffers[0].cbBuffer    = cast(DWORD) ioBuffer.length;
			inBuffers[0].BufferType  = SECBUFFER_TOKEN;

			inBuffers[1].pvBuffer    = NULL;
			inBuffers[1].cbBuffer    = 0;
			inBuffers[1].BufferType  = SECBUFFER_EMPTY;

			inBuffer.cBuffers        = 2;
			inBuffer.pBuffers        = inBuffers.ptr;
			inBuffer.ulVersion       = SECBUFFER_VERSION;

			// Set up the output buffers. These are initialized to NULL
			// so as to make it less likely we'll attempt to free random
			// garbage later.
			outBuffers[0].pvBuffer   = NULL;
			outBuffers[0].BufferType = SECBUFFER_TOKEN;
			outBuffers[0].cbBuffer   = 0;

			outBuffer.cBuffers       = 1;
			outBuffer.pBuffers       = outBuffers.ptr;
			outBuffer.ulVersion      = SECBUFFER_VERSION;

			TimeStamp tsExpiry;
			DWORD dwSSPIOutFlags;

			scRet = sspi.InitializeSecurityContextW(&hCreds, &hContext, null, dwSSPIFlags, 0,
				SECURITY_NATIVE_DREP, &inBuffer, 0, null, &outBuffer, &dwSSPIOutFlags, &tsExpiry);

			// If InitializeSecurityContext was successful (or if the error was
			// one of the special extended ones), send the contents of the output
			// buffer to the server.
			if (0
				|| scRet == SEC_E_OK
				|| scRet == SEC_I_CONTINUE_NEEDED
				|| (FAILED(scRet) && (dwSSPIOutFlags & ISC_RET_EXTENDED_ERROR))
			) {
				sendResponse();
			}

			// If InitializeSecurityContext returned SEC_E_INCOMPLETE_MESSAGE,
			// then we need to read more data from the server and try again.
			if (scRet == SEC_E_INCOMPLETE_MESSAGE)
				continue;

			// If InitializeSecurityContext returned SEC_E_OK, then the
			// handshake completed successfully.
			if (scRet == SEC_E_OK) {
				if (inBuffers[1].BufferType == SECBUFFER_EXTRA) {
					// If the "extra" buffer contains data, this is encrypted application
					// protocol layer stuff. It needs to be saved. The application layer
					// will later decrypt it with DecryptMessage.
					inputBuffer ~= ioBuffer[$ - inBuffers[1].cbBuffer .. $];
				}

				scRet = sspi.QueryContextAttributesW(&hContext, SECPKG_ATTR_STREAM_SIZES, &sizes);
				enforce(scRet == SEC_E_OK, "error reading SECPKG_ATTR_STREAM_SIZES");

				break;
			}

			enforce(!FAILED(scRet), "failed to initialize security context: " ~ getSECErrorString(scRet));

			// If InitializeSecurityContext returned SEC_I_INCOMPLETE_CREDENTIALS,
			// then the server just requested client authentication.
			enforce(scRet != SEC_I_INCOMPLETE_CREDENTIALS, "client credentials aren't supported yet");

			if (inBuffers[1].BufferType == SECBUFFER_EXTRA) {
				ioBuffer = ioBuffer[$ - inBuffers[1].cbBuffer .. $];
			}
			else {
				ioBuffer.length = 0;
			}
		}
	}

	private void sendMessage(const(void)[] data) {
		SecBuffer[4] buffers;

		ubyte[] buffer = new ubyte[sizes.cbHeader + data.length + sizes.cbTrailer];
		buffer[sizes.cbHeader .. sizes.cbHeader + data.length] = cast(const(ubyte)[]) data[];

		buffers[0].pvBuffer = buffer.ptr;
		buffers[0].cbBuffer = sizes.cbHeader;
		buffers[0].BufferType = SECBUFFER_STREAM_HEADER;

		buffers[1].pvBuffer = buffer.ptr + sizes.cbHeader;
		buffers[1].cbBuffer = cast(DWORD) data.length;
		buffers[1].BufferType = SECBUFFER_DATA;

		buffers[2].pvBuffer = buffer.ptr + sizes.cbHeader + data.length;
		buffers[2].cbBuffer = sizes.cbTrailer;
		buffers[2].BufferType = SECBUFFER_STREAM_TRAILER;

		buffers[3].pvBuffer = null;
		buffers[3].cbBuffer = 0;
		buffers[3].BufferType = SECBUFFER_EMPTY;

		SecBufferDesc message;
		message.ulVersion = SECBUFFER_VERSION;
		message.cBuffers = 4;
		message.pBuffers = buffers.ptr;
		SECURITY_STATUS scRet = sspi.EncryptMessage(&hContext, 0, &message, 0);
		enforce(!FAILED(scRet), "failed to encrypt message");

		buffer = buffer[0 .. buffers[0].cbBuffer + buffers[1].cbBuffer + buffers[2].cbBuffer];

		while (buffer.length > 0) {
			size_t bytesWritten = socket.send(buffer);
			buffer = buffer[bytesWritten .. $];
			if (buffer.length > 0)
				socket.onWriteAvailable.wait();
		}
	}

	override size_t send(const(void)[] data) {
		import std.algorithm : min;

		for (size_t offset = 0; offset < data.length; offset += sizes.cbMaximumMessage)
			sendMessage(data[offset .. min(offset + sizes.cbMaximumMessage, $)]);

		return data.length;
	}

	private {
		ubyte[] inputBuffer;
		bool expired;
	}
	override ubyte[] read() {
		if (inputBuffer.length == 0 || expired)
			return [];

		SecBufferDesc message;
		SecBuffer[4] buffers;

		SECURITY_STATUS scRet = 0;

		// Decrypt the received data.
		buffers[0].pvBuffer = inputBuffer.ptr;
		buffers[0].cbBuffer = cast(DWORD) inputBuffer.length;
		buffers[0].BufferType = SECBUFFER_DATA;

		foreach (i; 1 .. 4) {
			buffers[i].pvBuffer = null;
			buffers[i].cbBuffer = 0;
			buffers[i].BufferType = SECBUFFER_EMPTY;
		}

		message.ulVersion = SECBUFFER_VERSION;
		message.cBuffers = 4;
		message.pBuffers = buffers.ptr;
		scRet = sspi.DecryptMessage(&hContext, &message, 0, null);
		if (scRet == SEC_E_OK) {
			assert(buffers[0].BufferType == SECBUFFER_STREAM_HEADER);
			assert(buffers[1].BufferType == SECBUFFER_DATA);
			assert(buffers[2].BufferType == SECBUFFER_STREAM_TRAILER);

			void[] data = buffers[1].pvBuffer[0 .. buffers[1].cbBuffer];

			if (buffers[3].BufferType == SECBUFFER_EXTRA) {
				inputBuffer = (cast(ubyte[]) buffers[3].pvBuffer[0 .. buffers[3].cbBuffer]).dup;
			}
			else {
				assert(buffers[3].BufferType == SECBUFFER_EMPTY);
				inputBuffer = [];
			}

			return (cast(ubyte[]) data).dup ~ read();
		}
		else if (scRet == SEC_I_RENEGOTIATE) {
			handshakeLoop(true);
			return [];
		}
		else if (scRet == SEC_I_CONTEXT_EXPIRED) {
			expired = true;
			return [];
		}
		else if (scRet == SEC_E_INCOMPLETE_MESSAGE) {
			return [];
		}
		else {
			throw new Exception("error in decrypting SSL data: " ~ getSECErrorString(scRet));
		}
	}

}

class Win32SSLManager : SSLManager {

	private {
		HCERTSTORE certStore;
		PSecurityFunctionTableW sspi;
		CredHandle hCreds;
	}

	package(gd.system) this(Application application) {
		scope (failure) dispose();

		addDependency(application);

		sspi = InitSecurityInterfaceW();
		if (!sspi)
			throw new Exception("failed to initialize security interface");

		certStore = CertOpenSystemStoreW(0, "MY"w.ptr);
		if (!certStore)
			throw new Exception("failed to open system credential store");

		createCredentials(&hCreds);
	}

	protected override void disposeImpl() {}

	override Win32SSLInfo initSSL(Socket socket, bool verifyPeer, string hostname) {
		Win32SSLInfo info = new Win32SSLInfo(this, cast(Win32Socket) socket);
		scope (failure) info.dispose();

		info.verifyPeer = verifyPeer;
		info.hostname = hostname;
		info.hCreds = hCreds;

		socket.readAutomatically = false;

		return info;
	}

	private void createCredentials(CredHandle* hCreds) {
		import std.conv : to;

		SCHANNEL_CRED scCred;
		scCred.dwVersion = SCHANNEL_CRED_VERSION;
		scCred.grbitEnabledProtocols = SP_PROT_TLS1_2 | SP_PROT_TLS1_3;

		ALG_ID[] rgbSupportedAlgs;

		// rgbSupportedAlgs ~= CALG_DH_EPHEM;
		// rgbSupportedAlgs ~= CALG_RSA_KEYX;

		if (rgbSupportedAlgs.length > 0) {
			scCred.cSupportedAlgs = cast(DWORD) rgbSupportedAlgs.length;
			scCred.palgSupportedAlgs = rgbSupportedAlgs.ptr;
		}

		scCred.dwFlags |= SCH_USE_STRONG_CRYPTO;
		scCred.dwFlags |= SCH_CRED_AUTO_CRED_VALIDATION;
		scCred.dwFlags |= SCH_CRED_NO_DEFAULT_CREDS;

		TimeStamp tsExpiry;
		SECURITY_STATUS status = sspi.AcquireCredentialsHandleW(
			NULL,                 // Name of principal
			UNISP_NAME_W.to!(wchar[]).ptr,     // Name of package
			SECPKG_CRED_OUTBOUND, // Flags indicating use
			NULL,                 // Pointer to logon ID
			&scCred,              // Package specific data
			NULL,                 // Pointer to GetKey() func
			NULL,                 // Value to pass to GetKey()
			hCreds,               // (out) Cred Handle
			&tsExpiry);           // (out) Lifetime (optional)

		enforce(status == SEC_E_OK, "failed to acquire credentials (" ~ getSECErrorString(status) ~ ")");
	}

}
