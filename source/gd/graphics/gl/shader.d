module gd.graphics.gl.shader;
import gd.graphics.shader;
import gd.graphics.image;
import gd.graphics.gl.image;
import gd.graphics.color;
import gd.math;
import gd.bindings.gl;
import gd.graphics.gl.context;
import gd.graphics.gl.exception;
import std.conv;

class GLShader : Shader {

	GLGraphicsContext context;
	GL.UInt id;

	package this(GLGraphicsContext context, ShaderSource[] sources) {
		this.context = context;

		id = GL.createProgram();
		if (id == 0) {
			throw new GLException("Could not create shader program");
		}

		GL.UInt[] shaders;

		foreach (source; sources) {
			GL.Enum type;
			final switch (source.type) {
			case ShaderType.Fragment:
				type = GL.FRAGMENT_SHADER;
				break;
			case ShaderType.Vertex:
				type = GL.VERTEX_SHADER;
				break;
			}

			GL.UInt shader = GL.createShader(type);
			if (shader == 0) {
				foreach (s; shaders) {
					GL.deleteShader(s);
				}

				GL.deleteProgram(id);

				throw new GLException("Could not create " ~ source.type.to!string ~ " shader");
			}

			const(char)* src = source.source.ptr;

			if (source.source.length > GL.Int.max) {
				throw new GLException("Length of " ~ source.type.to!string ~ " shader is too large");
			}

			GL.Int length = cast(GL.Int) source.source.length;

			GL.shaderSource(shader, 1, &src, &length);

			GL.compileShader(shader);

			GL.Int success;
			GL.getShaderiv(shader, GL.COMPILE_STATUS, &success);
			if (!success) {
				import std.exception : assumeUnique;

				GL.Int size;
				GL.getShaderiv(shader, GL.INFO_LOG_LENGTH, &size);

				if (size <= 1) {
					throw new GLException(source.type.to!string ~ " shader compilation failed");
				}

				char[] buf = new char[size - 1];
				GL.getShaderInfoLog(shader, size - 1, null, buf.ptr);

				throw new GLException(source.type.to!string ~ " shader compilation failed: " ~ buf.assumeUnique);
			}

			shaders ~= shader;
		}

		foreach (shader; shaders) {
			GL.attachShader(id, shader);
		}

		GL.linkProgram(id);

		GL.Int success;
		GL.getProgramiv(id, GL.LINK_STATUS, &success);
		if (!success) {
			import std.exception : assumeUnique;

			GL.Int size;
			GL.getProgramiv(id, GL.INFO_LOG_LENGTH, &size);

			if (size <= 1) {
				throw new GLException("Shader linking failed");
			}

			char[] buf = new char[size - 1];
			GL.getProgramInfoLog(id, size - 1, null, buf.ptr);

			throw new GLException("Shader linking failed: " ~ buf.assumeUnique);
		}

		foreach (shader; shaders) {
			GL.deleteShader(shader);
		}
	}

	package void useShader() {
		// if (context.currentShader !is this) {
		// 	context.currentShader = this;
		GL.useProgram(id);
		// }
	}

	private GL.Int[string] uniformLocations;
	private GL.Int getUniformLocation(string name) {
		import std.string : toStringz;

		if (name in uniformLocations) {
			return uniformLocations[name];
		}

		GL.Int result = GL.getUniformLocation(id, name.toStringz);

		uniformLocations[name] = result;
		return result;
	}

	override void setUniform(string name, float value) {
		useShader();

		GL.Int uniformLocation = getUniformLocation(name);
		if (uniformLocation == -1) {
			return;
		}

		GL.uniform1f(uniformLocation, value);
		checkGLError();
	}

	override void setUniform(string name, int value) {}
	override void setUniform(string name, FVec2 value) {}
	override void setUniform(string name, FVec3 value) {}
	override void setUniform(string name, FVec4 value) {}

	override void setUniform(string name, Color value) {
		useShader();

		GL.Int uniformLocation = getUniformLocation(name);
		if (uniformLocation == -1) {
			return;
		}

		GL.uniform4f(uniformLocation, value.r, value.g, value.b, value.a);
		checkGLError();
	}

	override void setUniform(string name, IVec2 value) {}
	override void setUniform(string name, IVec3 value) {}
	override void setUniform(string name, IVec4 value) {}
	override void setUniform(string name, Mat4 value) {}
	override void setUniform(string name, Frame2 value) {}
	override void setUniform(string name, Frame3 value) {}

	private {
		size_t[string] textureLocations;
		package Image[] textures;
		int currTexture;

		size_t assignTexture(string name) {
			if (name !in textureLocations) {
				useShader();

				GL.Int uniformLocation = getUniformLocation(name);
				if (uniformLocation == -1) {
					return -1;
				}

				GL.uniform1i(uniformLocation, currTexture);
				checkGLError();

				textureLocations[name] = currTexture;
				textures ~= null;
				currTexture += 1;
			}
			return textureLocations[name];
		}
	}

	override void setUniform(string name, Image value) {
		if (value && !cast(GLImage) value) {
			throw new GLException("Cannot set OpenGL uniform to non-OpenGL texture");
		}

		size_t texture = assignTexture(name);
		if (texture == -1) {
			return;
		}

		textures[texture] = value;
	}

}

