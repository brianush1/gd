module gd.internal.gl.exception;
import gd.bindings.gl;
public import std.exception : enforce;

class GLException : Exception {

	this(string msg, string file = __FILE__, size_t line = __LINE__) @nogc @safe pure nothrow {
		super(msg, file, line);
	}

}

package void checkGLError() {
	final switch (GL.getError()) {
	case GL.NO_ERROR:
		return;
	case GL.INVALID_ENUM:
		throw new GLException("GL_INVALID_ENUM: An unacceptable value is specified for an enumerated argument.");
	case GL.INVALID_VALUE:
		throw new GLException("GL_INVALID_VALUE: A numeric argument is out of range.");
	case GL.INVALID_OPERATION:
		throw new GLException("GL_INVALID_OPERATION: The specified operation is not allowed in the current state.");
	case GL.INVALID_FRAMEBUFFER_OPERATION:
		throw new GLException("GL_INVALID_FRAMEBUFFER_OPERATION: The framebuffer object is not complete.");
	case GL.OUT_OF_MEMORY:
		throw new GLException("GL_OUT_OF_MEMORY: There is not enough memory left to execute the command. "
			~ "The state of the GL is undefined, except for the state of the error flags, after this error is recorded.");
	case GL.STACK_UNDERFLOW:
		throw new GLException("GL_STACK_UNDERFLOW: An attempt has been made to perform an operation that "
			~ "would cause an internal stack to underflow.");
	case GL.STACK_OVERFLOW:
		throw new GLException("GL_STACK_OVERFLOW: An attempt has been made to perform an operation that "
			~ "would cause an internal stack to overflow. ");
	}
}
