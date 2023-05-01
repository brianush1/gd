module gd.graphics.backend.opengl;
import gd.graphics.backend.common;
import gd.graphics.color;
import gd.bindings.gl;
import gd.math;

/+

final class OpenGLException : Exception {

	this(string msg, string file = __FILE__, size_t line = __LINE__) @nogc @safe pure nothrow {
		super(msg, file, line);
	}

}

final class OpenGLShader : Shader {

	private {
		OpenGLBackend context;

		GL.UInt program;

		GL.Int[string] uniformLocations;
	}

	private this(OpenGLBackend context, ShaderSource[] sources) {
		import std.conv : to;

		scope (failure) dispose();

		addDependency(context);
		this.context = context;

		program = GL.createProgram();
		if (program == 0) {
			throw new OpenGLException("Could not create shader program");
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

				GL.deleteProgram(program);

				throw new OpenGLException("Could not create " ~ source.type.to!string ~ " shader");
			}

			const(char)* src = source.source.ptr;

			if (source.source.length > GL.Int.max) {
				throw new OpenGLException("Length of " ~ source.type.to!string ~ " shader is too large");
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
					throw new OpenGLException(source.type.to!string ~ " shader compilation failed");
				}

				char[] buf = new char[size - 1];
				GL.getShaderInfoLog(shader, size - 1, null, buf.ptr);

				throw new OpenGLException(source.type.to!string ~ " shader compilation failed: " ~ buf.assumeUnique);
			}

			shaders ~= shader;
		}

		foreach (shader; shaders) {
			GL.attachShader(program, shader);
		}

		GL.linkProgram(program);

		GL.Int success;
		GL.getProgramiv(program, GL.LINK_STATUS, &success);
		if (!success) {
			import std.exception : assumeUnique;

			GL.Int size;
			GL.getProgramiv(program, GL.INFO_LOG_LENGTH, &size);

			if (size <= 1) {
				throw new OpenGLException("Shader linking failed");
			}

			char[] buf = new char[size - 1];
			GL.getProgramInfoLog(program, size - 1, null, buf.ptr);

			throw new OpenGLException("Shader linking failed: " ~ buf.assumeUnique);
		}

		foreach (shader; shaders) {
			GL.deleteShader(shader);
		}
	}

	protected override void disposeImpl() {
		GL.deleteProgram(program);
	}

	private void useShader() {
		if (context.shaderInUse !is this) {
			context.shaderInUse = this;
			GL.useProgram(program);
		}
	}

	private GL.Int getUniformLocation(string name) {
		import std.string : toStringz;

		if (name in uniformLocations) {
			return uniformLocations[name];
		}

		GL.Int result = GL.getUniformLocation(program, name.toStringz);

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
		if (GL.getError() != GL.NO_ERROR) {
			throw new OpenGLException("An error occurred while setting uniform '" ~ name ~ "' to float value");
		}
	}

	override void setUniform(string name, int value) {
		useShader();

		GL.Int uniformLocation = getUniformLocation(name);
		if (uniformLocation == -1) {
			return;
		}

		GL.uniform1i(uniformLocation, value);
		if (GL.getError() != GL.NO_ERROR) {
			throw new OpenGLException("An error occurred while setting uniform '" ~ name ~ "' to int value");
		}
	}

	override void setUniform(string name, FVec2 value) {
		useShader();

		GL.Int uniformLocation = getUniformLocation(name);
		if (uniformLocation == -1) {
			return;
		}

		GL.uniform2f(uniformLocation, value.x, value.y);
		if (GL.getError() != GL.NO_ERROR) {
			throw new OpenGLException("An error occurred while setting uniform '" ~ name ~ "' to FVec2 value");
		}
	}

	override void setUniform(string name, FVec3 value) {
		useShader();

		GL.Int uniformLocation = getUniformLocation(name);
		if (uniformLocation == -1) {
			return;
		}

		GL.uniform3f(uniformLocation, value.x, value.y, value.z);
		if (GL.getError() != GL.NO_ERROR) {
			throw new OpenGLException("An error occurred while setting uniform '" ~ name ~ "' to FVec3 value");
		}
	}

	override void setUniform(string name, FVec4 value) {
		useShader();

		GL.Int uniformLocation = getUniformLocation(name);
		if (uniformLocation == -1) {
			return;
		}

		GL.uniform4f(uniformLocation, value.x, value.y, value.z, value.w);
		if (GL.getError() != GL.NO_ERROR) {
			throw new OpenGLException("An error occurred while setting uniform '" ~ name ~ "' to FVec4 value");
		}
	}

	override void setUniform(string name, Color value) {
		useShader();

		GL.Int uniformLocation = getUniformLocation(name);
		if (uniformLocation == -1) {
			return;
		}

		GL.uniform4f(uniformLocation, value.r, value.g, value.b, value.a);
		if (GL.getError() != GL.NO_ERROR) {
			throw new OpenGLException("An error occurred while setting uniform '" ~ name ~ "' to Color value");
		}
	}

	override void setUniform(string name, IVec2 value) {
		useShader();

		GL.Int uniformLocation = getUniformLocation(name);
		if (uniformLocation == -1) {
			return;
		}

		GL.uniform2i(uniformLocation, value.x, value.y);
		if (GL.getError() != GL.NO_ERROR) {
			throw new OpenGLException("An error occurred while setting uniform '" ~ name ~ "' to IVec2 value");
		}
	}

	override void setUniform(string name, IVec3 value) {
		useShader();

		GL.Int uniformLocation = getUniformLocation(name);
		if (uniformLocation == -1) {
			return;
		}

		GL.uniform3i(uniformLocation, value.x, value.y, value.z);
		if (GL.getError() != GL.NO_ERROR) {
			throw new OpenGLException("An error occurred while setting uniform '" ~ name ~ "' to IVec3 value");
		}
	}

	override void setUniform(string name, IVec4 value) {
		useShader();

		GL.Int uniformLocation = getUniformLocation(name);
		if (uniformLocation == -1) {
			return;
		}

		GL.uniform4i(uniformLocation, value.x, value.y, value.z, value.w);
		if (GL.getError() != GL.NO_ERROR) {
			throw new OpenGLException("An error occurred while setting uniform '" ~ name ~ "' to IVec4 value");
		}
	}

	override void setUniform(string name, Frame2 value) {
		useShader();

		GL.Int uniformLocation = getUniformLocation(name);
		if (uniformLocation == -1) {
			return;
		}

		GL.uniformMatrix3fv(uniformLocation, 1, true, cast(const(GL.Float)*)&value);
		if (GL.getError() != GL.NO_ERROR) {
			throw new OpenGLException("An error occurred while setting uniform '" ~ name ~ "' to Frame2 value");
		}
	}

	private {
		size_t[string] textureLocations;
		Texture[] textures;
		int currTexture;

		size_t assignTexture(string name) {
			if (name !in textureLocations) {
				useShader();

				GL.Int uniformLocation = getUniformLocation(name);
				if (uniformLocation == -1) {
					return -1;
				}

				GL.uniform1i(uniformLocation, currTexture);
				if (GL.getError() != GL.NO_ERROR) {
					throw new OpenGLException("An error occurred while setting uniform '" ~ name ~ "' to texture value");
				}

				textureLocations[name] = currTexture;
				textures ~= null;
				currTexture += 1;
			}
			return textureLocations[name];
		}
	}

	override void setUniform(string name, Texture value) {
		if (value && !cast(OpenGLFramebuffer) value && !cast(OpenGLTexture) value) {
			throw new OpenGLException("Cannot set OpenGL uniform to non-OpenGL texture");
		}

		size_t texture = assignTexture(name);
		if (texture == -1) {
			return;
		}

		textures[texture] = value;
	}

}

final class OpenGLMesh : RawMesh {

	private {
		OpenGLBackend context;

		GL.UInt vao, buffer;

		MeshUsage usage;
	}

	private this(OpenGLBackend context, VertexFormat format, MeshUsage usage) {
		scope (failure) dispose();

		addDependency(context);
		this.context = context;
		this.usage = usage;

		GL.genVertexArrays(1, &vao);
		GL.bindVertexArray(vao);

		GL.genBuffers(1, &buffer);
		GL.bindBuffer(GL.ARRAY_BUFFER, buffer);

		foreach (i, v; format.attributes) {
			GL.Int size;
			GL.Enum type;
			final switch (v.type) {
			case AttributeType.Float:
				size = 1;
				type = GL.FLOAT;
				break;
			case AttributeType.FVec2:
				size = 2;
				type = GL.FLOAT;
				break;
			case AttributeType.FVec3:
				size = 3;
				type = GL.FLOAT;
				break;
			case AttributeType.FVec4:
				size = 4;
				type = GL.FLOAT;
				break;
			case AttributeType.Int:
				size = 1;
				type = GL.INT;
				break;
			case AttributeType.IVec2:
				size = 2;
				type = GL.INT;
				break;
			case AttributeType.IVec3:
				size = 3;
				type = GL.INT;
				break;
			case AttributeType.IVec4:
				size = 4;
				type = GL.INT;
				break;
			}
			GL.vertexAttribPointer(cast(GL.UInt) i, size, type, false,
				cast(GL.Sizei) format.stride, cast(void*) v.byteOffset);
			GL.enableVertexAttribArray(cast(GL.UInt) i);
		}
	}

	protected override void disposeImpl() {
		GL.deleteVertexArrays(1, &vao);
		GL.deleteBuffers(1, &buffer);
	}

	override void upload(void[] data) {
		GL.bindVertexArray(vao);
		GL.bufferData(GL.ARRAY_BUFFER, cast(GL.Sizeiptr) data.length, data.ptr,
			usage == MeshUsage.Dynamic ? GL.STREAM_DRAW : GL.STATIC_DRAW,
		);
	}

}

final class OpenGLTexture : Texture {

	private {
		OpenGLBackend context;

		GL.UInt texture;

		IVec2 _size;
	}

	private static void[] flipImage(size_t width, size_t height, const(void)[] data) {
		void[] result = new void[4 * width * height];
		size_t length = 4 * width;
		foreach (j; 0 .. height) {
			size_t index1 = j * 4 * width;
			size_t index2 = (height - j - 1) * 4 * width;
			result[index1 .. index1 + length] = data[index2 .. index2 + length];
		}
		return result;
	}

	private this(OpenGLBackend context, IVec2 size, const(void)[] data) {
		scope (failure) dispose();

		addDependency(context);
		this.context = context;
		_size = size;

		GL.genTextures(1, &texture);
		GL.bindTexture(GL.TEXTURE_2D, texture);

		GL.texParameteri(GL.TEXTURE_2D, GL.TEXTURE_WRAP_S, GL.REPEAT);
		GL.texParameteri(GL.TEXTURE_2D, GL.TEXTURE_WRAP_T, GL.REPEAT);
		GL.texParameteri(GL.TEXTURE_2D, GL.TEXTURE_MIN_FILTER, GL.LINEAR);
		GL.texParameteri(GL.TEXTURE_2D, GL.TEXTURE_MAG_FILTER, GL.LINEAR);
		GL.texImage2D(GL.TEXTURE_2D, 0, GL.RGBA,
			cast(GL.Sizei) size.x, cast(GL.Sizei) size.y,
			0, GL.RGBA, GL.UNSIGNED_BYTE, flipImage(size.x, size.y, data).ptr);
	}

	protected override void disposeImpl() {
		GL.deleteTextures(1, &texture);
	}

	override IVec2 size() const @property {
		return _size;
	}

}

final class OpenGLFramebuffer : Framebuffer {

	private {
		OpenGLBackend context;

		GL.UInt fbo, rbo, texColorBuffer;

		IVec2 _size;
	}

	private this(OpenGLBackend context, IVec2 size) {
		scope (failure) dispose();

		addDependency(context);
		this.context = context;
		_size = size;

		GL.genFramebuffers(1, &fbo);

		GL.bindFramebuffer(GL.FRAMEBUFFER, fbo);

		GL.genTextures(1, &texColorBuffer);
		GL.bindTexture(GL.TEXTURE_2D, texColorBuffer);

		GL.texImage2D(GL.TEXTURE_2D, 0, GL.RGBA,
			cast(GL.Sizei) size.x, cast(GL.Sizei) size.y,
			0, GL.RGBA, GL.UNSIGNED_BYTE, null);

		GL.texParameteri(GL.TEXTURE_2D, GL.TEXTURE_MIN_FILTER, GL.LINEAR);
		GL.texParameteri(GL.TEXTURE_2D, GL.TEXTURE_MAG_FILTER, GL.LINEAR);
		GL.bindTexture(GL.TEXTURE_2D, 0);

		GL.framebufferTexture2D(GL.FRAMEBUFFER, GL.COLOR_ATTACHMENT0,
			GL.TEXTURE_2D, texColorBuffer, 0);
		
		GL.genRenderbuffers(1, &rbo);

		GL.bindRenderbuffer(GL.RENDERBUFFER, rbo);
		GL.renderbufferStorage(GL.RENDERBUFFER, GL.DEPTH24_STENCIL8,
			cast(GL.Sizei) size.x, cast(GL.Sizei) size.y);
		GL.bindRenderbuffer(GL.RENDERBUFFER, 0);

		GL.framebufferRenderbuffer(GL.FRAMEBUFFER, GL.DEPTH_STENCIL_ATTACHMENT,
			GL.RENDERBUFFER, rbo);

		if (GL.checkFramebufferStatus(GL.FRAMEBUFFER) != GL.FRAMEBUFFER_COMPLETE) {
			throw new OpenGLException("An error occurred while creating a framebuffer");
		}

		if (context._renderTarget) {
			GL.bindFramebuffer(GL.FRAMEBUFFER, (cast(OpenGLFramebuffer) context._renderTarget).fbo);
		}
		else {
			GL.bindFramebuffer(GL.FRAMEBUFFER, 0);
		}
	}

	protected override void disposeImpl() {
		GL.deleteRenderbuffers(1, &rbo);
		GL.deleteTextures(1, &texColorBuffer);
		GL.deleteFramebuffers(1, &fbo);
	}

	override IVec2 size() const @property {
		return _size;
	}

}

final class OpenGLBackend : GraphicsContext {

	private OpenGLShader shaderInUse;

	this() {
		GL.disable(GL.MULTISAMPLE);
	}

	override Shader createShader(ShaderSource[] sources) {
		return new OpenGLShader(this, sources);
	}

	override RawMesh createRawMesh(VertexFormat format, MeshUsage usage) {
		return new OpenGLMesh(this, format, usage);
	}

	override Framebuffer createFramebuffer(IVec2 size) {
		return new OpenGLFramebuffer(this, size);
	}

	override Texture createTexture(IVec2 size, const(void)[] data) {
		return new OpenGLTexture(this, size, data);
	}

	private Framebuffer _renderTarget;

	override void renderTarget(Framebuffer framebuffer) {
		if (framebuffer && !cast(OpenGLFramebuffer) framebuffer) {
			throw new OpenGLException("Cannot bind non-OpenGL framebuffer to OpenGL context");
		}

		if (framebuffer !is _renderTarget) {
			_renderTarget = framebuffer;
			if (framebuffer) {
				GL.bindFramebuffer(GL.FRAMEBUFFER, (cast(OpenGLFramebuffer) framebuffer).fbo);
			}
			else {
				GL.bindFramebuffer(GL.FRAMEBUFFER, 0);
			}
		}
	}

	override inout(Framebuffer) renderTarget() inout @property {
		return _renderTarget;
	}

	override void clearColor(Color color) {
		GL.clearColor(color.r, color.g, color.b, color.a);
		GL.clear(GL.COLOR_BUFFER_BIT);
	}

	override void clearStencil(ubyte value) {
		GL.clearStencil(value);
		GL.clear(GL.STENCIL_BUFFER_BIT);
	}

	override void stencil(Stencil value) {
		stencilSeparate(value, value);
	}

	override void stencilSeparate(Stencil front, Stencil back) {
		GL.Enum convStencilFunc(StencilFunction func) {
			final switch (func) {
				case StencilFunction.Always: return GL.ALWAYS;
				case StencilFunction.Never: return GL.NEVER;
				case StencilFunction.Lt: return GL.LESS;
				case StencilFunction.Le: return GL.LEQUAL;
				case StencilFunction.Gt: return GL.GREATER;
				case StencilFunction.Ge: return GL.GEQUAL;
				case StencilFunction.Eq: return GL.EQUAL;
				case StencilFunction.Neq: return GL.NOTEQUAL;
			}
		}

		GL.Enum convStencilOp(StencilOp op) {
			final switch (op) {
				case StencilOp.Nop: return GL.KEEP;
				case StencilOp.Zero: return GL.ZERO;
				case StencilOp.Set: return GL.REPLACE;
				case StencilOp.Inc: return GL.INCR;
				case StencilOp.Dec: return GL.DECR;
				case StencilOp.IncWrap: return GL.INCR_WRAP;
				case StencilOp.DecWrap: return GL.DECR_WRAP;
				case StencilOp.Inv: return GL.INVERT;
			}
		}

		if (front.func == StencilFunction.Always
				&& front.stencilFail == StencilOp.Nop
				&& front.depthFail == StencilOp.Nop
				&& front.pass == StencilOp.Nop
				&& back.func == StencilFunction.Always
				&& back.stencilFail == StencilOp.Nop
				&& back.depthFail == StencilOp.Nop
				&& back.pass == StencilOp.Nop) {
			GL.disable(GL.STENCIL_TEST);
			return;
		}

		GL.enable(GL.STENCIL_TEST);

		if (front.writeMask == back.writeMask) {
			GL.stencilMask(front.writeMask);
		}
		else {
			GL.stencilMaskSeparate(GL.FRONT, front.writeMask);
			GL.stencilMaskSeparate(GL.BACK, back.writeMask);
		}

		if (front.func == back.func && front.refValue == back.refValue && front.readMask == back.readMask) {
			GL.stencilFunc(convStencilFunc(front.func), front.refValue, front.readMask);
		}
		else {
			GL.stencilFuncSeparate(GL.FRONT, convStencilFunc(front.func), front.refValue, front.readMask);
			GL.stencilFuncSeparate(GL.BACK, convStencilFunc(back.func), back.refValue, back.readMask);
		}

		if (front.stencilFail == back.stencilFail && front.depthFail == back.depthFail && front.pass == back.pass) {
			GL.stencilOp(
				convStencilOp(front.stencilFail),
				convStencilOp(front.depthFail),
				convStencilOp(front.pass),
			);
		}
		else {
			GL.stencilOpSeparate(GL.FRONT,
				convStencilOp(front.stencilFail),
				convStencilOp(front.depthFail),
				convStencilOp(front.pass),
			);
			GL.stencilOpSeparate(GL.BACK,
				convStencilOp(back.stencilFail),
				convStencilOp(back.depthFail),
				convStencilOp(back.pass),
			);
		}
	}

	private BlendFunc _colorBlend;
	private BlendFunc _alphaBlend;

	override BlendFunc colorBlend() const @property { return _colorBlend; }
	override BlendFunc alphaBlend() const @property { return _alphaBlend; }
	override BlendFunc blend() const @property { return _colorBlend; }

	override void blend(BlendFunc value) {
		blendSeparate(value, value);
	}

	private GL.Enum convBlendingOperation(BlendFunc.Op op) {
		final switch (op) {
			case BlendFunc.Op.Add: return GL.FUNC_ADD;
			case BlendFunc.Op.SrcMinusDst: return GL.FUNC_SUBTRACT;
			case BlendFunc.Op.DstMinusSrc: return GL.FUNC_REVERSE_SUBTRACT;
			case BlendFunc.Op.Min: return GL.MIN;
			case BlendFunc.Op.Max: return GL.MAX;
		}
	}

	private GL.Enum convBlendingFactor(BlendFunc.Factor factor) {
		final switch (factor) {
			case BlendFunc.Factor.Zero: return GL.ZERO;
			case BlendFunc.Factor.One: return GL.ONE;
			case BlendFunc.Factor.SrcColor: return GL.SRC_COLOR;
			case BlendFunc.Factor.DstColor: return GL.DST_COLOR;
			case BlendFunc.Factor.SrcAlpha: return GL.SRC_ALPHA;
			case BlendFunc.Factor.DstAlpha: return GL.DST_ALPHA;
			case BlendFunc.Factor.ConstColor: return GL.CONSTANT_COLOR;
			case BlendFunc.Factor.ConstAlpha: return GL.CONSTANT_ALPHA;
			case BlendFunc.Factor.OneMinusSrcColor: return GL.ONE_MINUS_SRC_COLOR;
			case BlendFunc.Factor.OneMinusDstColor: return GL.ONE_MINUS_DST_COLOR;
			case BlendFunc.Factor.OneMinusSrcAlpha: return GL.ONE_MINUS_SRC_ALPHA;
			case BlendFunc.Factor.OneMinusDstAlpha: return GL.ONE_MINUS_DST_ALPHA;
			case BlendFunc.Factor.OneMinusConstColor: return GL.ONE_MINUS_CONSTANT_COLOR;
			case BlendFunc.Factor.OneMinusConstAlpha: return GL.ONE_MINUS_CONSTANT_ALPHA;
		}
	}

	override void blendSeparate(BlendFunc color, BlendFunc alpha) {
		_colorBlend = color;
		_alphaBlend = alpha;

		if (color == BlendFuncs.Overwrite && alpha == color) {
			// technically doesn't catch all functions equivalent to disabling blending
			// but it's good enough
			GL.disable(GL.BLEND);
			return;
		}

		GL.enable(GL.BLEND);

		if (color.op == alpha.op) {
			GL.blendEquation(convBlendingOperation(color.op));
		}
		else {
			GL.blendEquationSeparate(
				convBlendingOperation(color.op),
				convBlendingOperation(alpha.op),
			);
		}

		if (color.sfactor == alpha.sfactor && color.dfactor == alpha.dfactor) {
			GL.blendFunc(
				convBlendingFactor(color.sfactor),
				convBlendingFactor(color.dfactor),
			);
		}
		else {
			GL.blendFuncSeparate(
				convBlendingFactor(color.sfactor),
				convBlendingFactor(color.dfactor),
				convBlendingFactor(alpha.sfactor),
				convBlendingFactor(alpha.dfactor),
			);
		}

		GL.blendColor(
			color.constant.r,
			color.constant.g,
			color.constant.b,
			alpha.constant.a,
		);
	}

	override void viewport(IVec2 location, IVec2 size) {
		GL.viewport(location.x, location.y, size.x, size.y);
	}

	override void colorWriteMask(bool r, bool g, bool b, bool a) {
		GL.colorMask(r, g, b, a);
	}

	override void draw(DrawMode mode, Shader shader, MeshSlice mesh) {
		if (!cast(OpenGLMesh) mesh.mesh) {
			throw new OpenGLException("Cannot draw non-OpenGL mesh in OpenGL context");
		}

		if (!cast(OpenGLShader) shader) {
			throw new OpenGLException("Cannot use non-OpenGL shader in OpenGL context");
		}

		OpenGLShader glShader = cast(OpenGLShader) shader;

		glShader.useShader();

		foreach (i, texture; glShader.textures) {
			GL.activeTexture(GL.TEXTURE0 + cast(int) i);
			if (cast(OpenGLFramebuffer) texture) {
				GL.bindTexture(GL.TEXTURE_2D, (cast(OpenGLFramebuffer) texture).texColorBuffer);
			}
			else if (cast(OpenGLTexture) texture) {
				GL.bindTexture(GL.TEXTURE_2D, (cast(OpenGLTexture) texture).texture);
			}
			else {
				GL.bindTexture(GL.TEXTURE_2D, 0);
			}
		}

		GL.bindVertexArray((cast(OpenGLMesh) mesh.mesh).vao);

		GL.Enum glMode;
		final switch (mode) {
		case DrawMode.Triangles:
			glMode = GL.TRIANGLES;
			break;
		case DrawMode.TriangleFan:
			glMode = GL.TRIANGLE_FAN;
			break;
		case DrawMode.TriangleStrip:
			glMode = GL.TRIANGLE_STRIP;
			break;
		}

		GL.drawArrays(glMode, cast(GL.Int) mesh.startVertex, cast(GL.Sizei) mesh.numVertices);
	}

}

+/
