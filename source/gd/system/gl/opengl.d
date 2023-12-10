module gd.system.gl.opengl;
import gd.system.gl.exception;
import gd.system.gpu;
import gd.system.window;
import gd.bindings.gl;
import gd.math;
import std.typecons;
import std.sumtype;
import std.conv;

class GLShader : GPUShader {
private:

	GLContext context;
	GL.UInt id;

	this(GLContext context, const(ShaderSource)[] sources) {
		scope (failure) dispose();

		addDependency(context);
		this.context = context;

		context.ensureValidContext();

		GL.UInt[] shaders;

		scope (exit) {
			foreach (shader; shaders)
				GL.deleteShader(shader);
		}

		foreach (source; sources) {
			GL.Enum type;
			final switch (source.type) {
				case ShaderType.Fragment: type = GL.FRAGMENT_SHADER; break;
				case ShaderType.Vertex: type = GL.VERTEX_SHADER; break;
			}

			GL.UInt shader = GL.createShader(type);
			enforce!GLException(shader != 0, "Could not create " ~ source.type.to!string ~ " shader");

			const(char)* src = source.source.ptr;
			GL.Int length = source.source.length.to!(GL.Int);

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
				else {
					char[] buf = new char[size];
					GL.getShaderInfoLog(shader, size, null, buf.ptr);

					throw new GLException(source.source ~ "\n\n" ~ source.type.to!string ~ " shader compilation failed: " ~ buf[0 .. $ - 1].assumeUnique);
				}
			}

			shaders ~= shader;
		}

		id = GL.createProgram();
		enforce!GLException(id != 0, "Could not create shader program");

		foreach (shader; shaders)
			GL.attachShader(id, shader);

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
			else {
				char[] buf = new char[size];
				GL.getProgramInfoLog(id, size, null, buf.ptr);

				throw new GLException("Shader linking failed: " ~ buf[0 .. $ - 1].assumeUnique);
			}
		}
	}

	protected override void disposeImpl() {
		context.ensureValidContext();

		GL.deleteProgram(id);
	}

	alias Uniforms = SumType!(
		float, int,
		FVec2, FVec3, FVec4,
		IVec2, IVec3, IVec4,
		GPUImage,
	)[string];

	Uniforms uniforms;

	GL.Int[string] uniformLocations;
	GL.Int getUniformLocation(string name) {
		import std.string : toStringz;

		if (name in uniformLocations) {
			return uniformLocations[name];
		}

		GL.Int result = GL.getUniformLocation(id, name.toStringz);

		uniformLocations[name] = result;
		return result;
	}

	int[int] textureLocations;
	int currTexture;

	int assignTexture(GL.Int uniformLocation) {
		if (uniformLocation !in textureLocations) {
			GL.uniform1i(uniformLocation, currTexture);

			textureLocations[uniformLocation] = currTexture;
			currTexture += 1;
		}

		return textureLocations[uniformLocation];
	}

	void updateUniforms() {
		foreach (name, value; uniforms) {
			GL.Int loc = getUniformLocation(name);
			if (loc == -1)
				continue;
			// import std.stdio : writeln;
			// writeln("set ", name, " = ", value);
			value.match!(
				(int   v) => GL.uniform1i(loc, v),
				(float v) => GL.uniform1f(loc, v),
				(FVec2 v) => GL.uniform2f(loc, v.x, v.y),
				(FVec3 v) => GL.uniform3f(loc, v.x, v.y, v.z),
				(FVec4 v) => GL.uniform4f(loc, v.x, v.y, v.z, v.w),
				(IVec2 v) => GL.uniform2i(loc, v.x, v.y),
				(IVec3 v) => GL.uniform3i(loc, v.x, v.y, v.z),
				(IVec4 v) => GL.uniform4i(loc, v.x, v.y, v.z, v.w),
				(GPUImage img) {
					int texture = assignTexture(loc);
					GL.activeTexture(GL.TEXTURE0 + texture);
					GL.bindTexture(GL.TEXTURE_2D, (cast(GLImage) img).texture);
				},
			);
		}

		uniforms = null;
	}

public:

	override void setUniform(string name, float    value) { uniforms[name] = value; }
	override void setUniform(string name, int      value) { uniforms[name] = value; }
	override void setUniform(string name, FVec2    value) { uniforms[name] = value; }
	override void setUniform(string name, FVec3    value) { uniforms[name] = value; }
	override void setUniform(string name, FVec4    value) { uniforms[name] = value; }
	override void setUniform(string name, IVec2    value) { uniforms[name] = value; }
	override void setUniform(string name, IVec3    value) { uniforms[name] = value; }
	override void setUniform(string name, IVec4    value) { uniforms[name] = value; }
	// override void setUniform(string name, Mat4     value) { uniforms[name] = value; }
	// override void setUniform(string name, Frame2   value) { uniforms[name] = value; }
	// override void setUniform(string name, Frame3   value) { uniforms[name] = value; }
	override void setUniform(string name, GPUImage value) {
		assert(cast(GLImage) value, "expected GL image as argument to setUniform in GL shader");
		uniforms[name] = value;
	}

}

class GLBuffer : GPUBuffer {
private:

	GLContext context;

	// immutable(MeshAttribute[]) attributes;

	GL.UInt buffer;

	this(GLContext context, BufferUsage usage) {
		scope (failure) dispose();

		addDependency(context);
		this.context = context;
		m_usage = usage;

		context.ensureValidContext();

		GL.genBuffers(1, &buffer);
	}

	protected override void disposeImpl() {
		context.ensureValidContext();

		GL.deleteBuffers(1, &buffer);
	}

public:

	private BufferUsage m_usage;
	override BufferUsage usage() const @property { return m_usage; }

	override void upload(void[] data) {
		context.ensureValidContext();

		GL.bindBuffer(GL.ARRAY_BUFFER, buffer);
		GL.bufferData(GL.ARRAY_BUFFER, data.length.to!(GL.Sizeiptr), data.ptr,
			usage == BufferUsage.Dynamic ? GL.STREAM_DRAW : GL.STATIC_DRAW,
		);
	}

	override void update(size_t offset, void[] data) {
		context.ensureValidContext();

		GL.bindBuffer(GL.ARRAY_BUFFER, buffer);
		GL.bufferSubData(GL.ARRAY_BUFFER, offset.to!(GL.Intptr), data.length.to!(GL.Sizeiptr), data.ptr);
	}

}

class GLMesh : GPUMesh {
private:

	GLContext context;

	const(MeshAttribute)[] attributes;

	this(GLContext context, const(MeshAttribute)[] attributes) {
		scope (failure) dispose();

		addDependency(context);
		this.context = context;
		this.attributes = attributes;
	}

	protected override void disposeImpl() {}

public:

	private Rebindable!(const(GLBuffer)) m_vertices;
	override const(GLBuffer) vertices() const @property { return m_vertices; }
	override void vertices(const(GPUBuffer) value) @property {
		assert(cast(const(GLBuffer)) value, "expected GL buffer in GL mesh");
		m_vertices = cast(const(GLBuffer)) value;
	}

	private Rebindable!(const(GLBuffer)) m_indices;
	override const(GLBuffer) indices() const @property { return m_indices; }
	override void indices(const(GPUBuffer) value) @property {
		assert(cast(const(GLBuffer)) value, "expected GL buffer in GL mesh");
		m_indices = cast(const(GLBuffer)) value;
	}

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

class GLImage : GPUImage {
private:

	GLContext context;

	bool fboInitialized = false;
	GL.UInt fbo, rbo, texture;

	this(GLContext context, ImageFormat format, IVec2 size, const(void)[] data) {
		scope (failure) dispose();

		addDependency(context);
		this.context = context;
		m_size = size;

		context.ensureValidContext();

		GL.genTextures(1, &texture);
		GL.bindTexture(GL.TEXTURE_2D, texture);

		GL.Enum glFormat;
		final switch (format) {
		case ImageFormat.RGBA:
			glFormat = GL.RGBA8;
			break;
		case ImageFormat.RGBA8I:
			glFormat = GL.RGBA8I;
			break;
		case ImageFormat.RGBA_SNORM:
			glFormat = GL.RGBA8_SNORM;
			break;
		case ImageFormat.RGBA32F:
			glFormat = GL.RGBA32F;
			break;
		case ImageFormat.R16U:
			glFormat = GL.R16UI;
			break;
		}

		GL.texParameteri(GL.TEXTURE_2D, GL.TEXTURE_WRAP_S, GL.REPEAT);
		GL.texParameteri(GL.TEXTURE_2D, GL.TEXTURE_WRAP_T, GL.REPEAT);
		GL.texParameteri(GL.TEXTURE_2D, GL.TEXTURE_MIN_FILTER, GL.LINEAR);
		GL.texParameteri(GL.TEXTURE_2D, GL.TEXTURE_MAG_FILTER, GL.LINEAR);
		GL.texImage2D(
			GL.TEXTURE_2D,
			0,
			glFormat,
			size.x.to!(GL.Sizei),
			size.y.to!(GL.Sizei),
			0,
			glFormat == GL.R16UI ? GL.RED_INTEGER : GL.RGBA,
			glFormat == GL.R16UI ? GL.UNSIGNED_SHORT : GL.UNSIGNED_BYTE,
			data.ptr == null ? null : flipImage(size.x, size.y, data).ptr,
		);
		if (glFormat == GL.R16UI) {
			GL.texParameteri(GL.TEXTURE_2D, GL.TEXTURE_MIN_FILTER, GL.NEAREST);
			GL.texParameteri(GL.TEXTURE_2D, GL.TEXTURE_MAG_FILTER, GL.NEAREST);
		}
	}

	protected override void disposeImpl() {
		context.runInContext(null, {
			if (fboInitialized) {
				GL.deleteRenderbuffers(1, &rbo);
				GL.deleteFramebuffers(1, &fbo);
			}

			GL.deleteTextures(1, &texture);
		});
	}

	void initializeFBO() {
		// FBOs are only ever initialized on the headless context
		// assert(context.currentWindow is null);

		if (!fboInitialized) {
			GL.genFramebuffers(1, &fbo);
			GL.bindFramebuffer(GL.FRAMEBUFFER, fbo);
			GL.framebufferTexture2D(GL.FRAMEBUFFER, GL.COLOR_ATTACHMENT0, GL.TEXTURE_2D, texture, 0);

			GL.genRenderbuffers(1, &rbo);
			GL.bindRenderbuffer(GL.RENDERBUFFER, rbo);
			GL.renderbufferStorage(GL.RENDERBUFFER, GL.DEPTH24_STENCIL8,
				size.x.to!(GL.Sizei), size.y.to!(GL.Sizei));
			GL.bindRenderbuffer(GL.RENDERBUFFER, 0);

			GL.framebufferRenderbuffer(GL.FRAMEBUFFER, GL.DEPTH_STENCIL_ATTACHMENT, GL.RENDERBUFFER, rbo);

			scope (exit) {
				GL.bindFramebuffer(GL.FRAMEBUFFER, 0);
			}

			GL.Enum status = GL.checkFramebufferStatus(GL.FRAMEBUFFER);
			if (status != GL.FRAMEBUFFER_COMPLETE) {
				import std.conv : text;

				GL.deleteFramebuffers(1, &fbo);
				GL.deleteRenderbuffers(1, &rbo);

				switch (status) {
				case GL.FRAMEBUFFER_UNDEFINED:
					throw new GLException("FRAMEBUFFER_UNDEFINED");
				case GL.FRAMEBUFFER_INCOMPLETE_ATTACHMENT:
					throw new GLException("FRAMEBUFFER_INCOMPLETE_ATTACHMENT");
				case GL.FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT:
					throw new GLException("FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT");
				case GL.FRAMEBUFFER_INCOMPLETE_DRAW_BUFFER:
					throw new GLException("FRAMEBUFFER_INCOMPLETE_DRAW_BUFFER");
				case GL.FRAMEBUFFER_INCOMPLETE_READ_BUFFER:
					throw new GLException("FRAMEBUFFER_INCOMPLETE_READ_BUFFER");
				case GL.FRAMEBUFFER_UNSUPPORTED:
					throw new GLException("FRAMEBUFFER_UNSUPPORTED");
				case GL.FRAMEBUFFER_INCOMPLETE_MULTISAMPLE:
					throw new GLException("FRAMEBUFFER_INCOMPLETE_MULTISAMPLE");
				case GL.FRAMEBUFFER_INCOMPLETE_LAYER_TARGETS:
					throw new GLException("FRAMEBUFFER_INCOMPLETE_LAYER_TARGETS");
				case 0:
					checkGLError();
					goto default;
				default:
					throw new GLException("an error occurred while creating a framebuffer (" ~ text(status) ~ ")");
				}
			}

			fboInitialized = true;
		}
	}

public:

	private IVec2 m_size;
	override IVec2 size() const @property { return m_size; }

	override void readPixels(IRect rect, void[] dest) const {
		assert(dest.length >= cast(size_t) 4 * rect.width * rect.height);

		// TODO: avoid creating an FBO implicitly when reading from a texture
		auto context = (cast() this).context;
		context.switchToSurface(cast() this);

		GL.readnPixels(
			rect.x.to!(GL.Int), (size.y - rect.height - rect.y).to!(GL.Int),
			rect.width.to!(GL.Sizei), rect.height.to!(GL.Sizei),
			GL.RGBA, GL.UNSIGNED_BYTE,
			dest.length.to!(GL.Sizei), dest.ptr,
		);

		void[] flipped = flipImage(rect.width, rect.height, dest);
		dest[] = flipped[];
	}

	override void writePixels(IRect rect, const(void)[] src) {
		assert(0, "not implemented yet");
	}

}

class GLWindowSurface : GPUSurface {
private:

	GLContext context;
	Window window;

	this(GLContext context, Window window) {
		scope (failure) dispose();

		addDependency(context);
		addDependency(window);

		this.context = context;
		this.window = window;
	}

	protected override void disposeImpl() {}

public:

	override IVec2 size() const @property {
		return window.size;
	}

}

private class ContextData {
	void delegate() makeCurrent;
	GLWindowSurface surface;
}

class GLContext : GPUContext {

	private {
		// TODO: use weak map
		ContextData[Window] data;

		bool uninitialized = true;

		// TODO: avoid keeping window alive, this variable is just for cache purposes
		Window currentWindow;

		GL.UInt currentFbo;
	}

	protected override void disposeImpl() {}

	package(gd.system) void registerWindow(Window window, void delegate() makeCurrent) {
		data[window] = new ContextData();
		data[window].makeCurrent = makeCurrent;
	}

	override GLShader createShader(const(ShaderSource)[] sources) {
		return new GLShader(this, sources);
	}

	override GLBuffer createBuffer(BufferUsage usage) {
		return new GLBuffer(this, usage);
	}

	override GLMesh createMesh(const(MeshAttribute)[] attributes) {
		return new GLMesh(this, attributes);
	}

	override GLImage createImage(ImageFormat format, IVec2 size, const(void)[] data) {
		return new GLImage(this, format, size, data);
	}

	override GLWindowSurface surfaceOf(Window window) {
		assert(window in data, "window is not an OpenGL window");
		assert(window !is null, "cannot create null surface");

		auto wdata = data[window];
		if (wdata.surface is null) {
			wdata.surface = new GLWindowSurface(this, window);
		}

		return wdata.surface;
	}

	// this function may not use the GC
	private bool switchToHeadless(Flag!"force" force = No.force) {
		if (force || currentWindow !is null || uninitialized) {
			uninitialized = false;
			currentWindow = null;
			data[null].makeCurrent();
			return true;
		}
		else {
			return false;
		}
	}

	// this function may not use the GC
	private void ensureValidContext() {
		// FIXME: switch to a valid context if the current window has been destroyed
		if (uninitialized)
			switchToHeadless();
	}

	// this function may not use the GC
	private void runInContext(Window window, scope void delegate() dg) {
		if (window == currentWindow) {
			dg();
		}
		else {
			data[window].makeCurrent();
			scope (exit)
				data[currentWindow].makeCurrent();
			dg();
		}
	}

	// this function may not use the GC
	package(gd.system) void switchToSurface(GPUSurface surface, Flag!"force" force = No.force) {
		bool changedWindow = false;

		if (auto img = cast(GLImage) surface) {
			// changedWindow = switchToHeadless(force);
			ensureValidContext();

			img.initializeFBO();

			if (/* changedWindow || */ currentFbo != img.fbo) {
				currentFbo = img.fbo;
				GL.bindFramebuffer(GL.FRAMEBUFFER, img.fbo);
			}
		}
		else if (auto windowSurface = cast(GLWindowSurface) surface) {
			if (force || currentWindow !is windowSurface.window || uninitialized) {
				uninitialized = false;
				currentWindow = windowSurface.window;
				data[windowSurface.window].makeCurrent();
				changedWindow = true;
			}

			if (/* changedWindow || */ currentFbo != 0) {
				currentFbo = 0;
				GL.bindFramebuffer(GL.FRAMEBUFFER, 0);
			}
		}
		else {
			assert(false, "expected GL surface for render target in GL context");
		}
	}

	private void applyWriteInfo(GPUSurface surface, WriteInfo info) {
		info.clip = info.clip.clipArea(IRect(0, 0, surface.size));
		if (info.clip.size == surface.size && info.clip.position == IVec2(0)) {
			GL.disable(GL.SCISSOR_TEST);
		}
		else {
			GL.enable(GL.SCISSOR_TEST);
			if (GLWindowSurface winSurface = cast(GLWindowSurface) surface) {
				GL.scissor(
					info.clip.x.to!(GL.Int),
					(winSurface.window.bufferSize.y - surface.size.y - info.clip.y).to!(GL.Int),
					info.clip.width.to!(GL.Sizei),
					info.clip.height.to!(GL.Sizei),
				);
			}
			else {
				GL.scissor(
					info.clip.x.to!(GL.Int),
					(surface.size.y - info.clip.height - info.clip.y).to!(GL.Int),
					info.clip.width.to!(GL.Sizei),
					info.clip.height.to!(GL.Sizei),
				);
			}
		}
	}

	override void clearColorBuffer(GPUSurface surface, FVec4 color, WriteInfo info) {
		switchToSurface(surface);
		applyWriteInfo(surface, info);
		GL.clearColor(color.x, color.y, color.z, color.w);
		GL.clear(GL.COLOR_BUFFER_BIT);
	}

	override void clearColorBuffer(GPUSurface surface, IVec4 color, WriteInfo info) {
		switchToSurface(surface);
		applyWriteInfo(surface, info);
		GL.drawBuffer(GL.COLOR_ATTACHMENT0);
		GL.clearBufferiv(GL.COLOR, 0, color.components.ptr);
	}

	override void clearDepthBuffer(GPUSurface surface, double depth, WriteInfo info) {
		switchToSurface(surface);
		applyWriteInfo(surface, info);
		GL.clearDepth(depth);
		GL.clear(GL.DEPTH_BUFFER_BIT);
	}

	override void draw(GPUSurface surface, GPUShader shader, DrawInfo info) {
		// TODO: use mode and flags and instanceCount
		if (info.instanceCount == 0)
			return;

		switchToSurface(surface);

		// TODO: save VAO per context and mesh instead of regenerating everytime
		GL.UInt vao;
		GL.genVertexArrays(1, &vao);
		GL.bindVertexArray(vao);
		scope (exit) {
			GL.bindVertexArray(0);
			GL.deleteVertexArrays(1, &vao);
		}

		if (GLWindowSurface winSurface = cast(GLWindowSurface) surface) {
			GL.viewport(
				info.viewport.x.to!(GL.Int),
				(winSurface.window.bufferSize.y - surface.size.y - info.viewport.y).to!(GL.Int),
				info.viewport.width.to!(GL.Sizei),
				info.viewport.height.to!(GL.Sizei),
			);
		}
		else {
			GL.viewport(
				info.viewport.x.to!(GL.Int),
				(surface.size.y - info.viewport.height - info.viewport.y).to!(GL.Int),
				info.viewport.width.to!(GL.Sizei),
				info.viewport.height.to!(GL.Sizei),
			);
		}

		applyWriteInfo(surface, info.write);

		assert(cast(GLMesh) info.mesh, "expected GL mesh in GL context");
		assert(cast(GLShader) shader, "expected GL shader in GL context");

		GLMesh mesh = cast(GLMesh) info.mesh;

		assert(mesh.vertices !is null, "null mesh vertex buffer cannot be used in rendering");

		if (mesh.indices !is null) {
			GL.bindBuffer(GL.ELEMENT_ARRAY_BUFFER, mesh.indices.buffer);
		}

		GL.bindBuffer(GL.ARRAY_BUFFER, mesh.vertices.buffer);
		foreach (i, attribute; mesh.attributes) {
			GL.Int size;
			GL.Enum type;

			final switch (attribute.type) {
				case ComponentType.Float16: type = GL.HALF_FLOAT; break;
				case ComponentType.Float32: type = GL.FLOAT; break;
				case ComponentType.Float64: type = GL.DOUBLE; break;
				case ComponentType.Int8: type = GL.BYTE; break;
				case ComponentType.Int16: type = GL.SHORT; break;
				case ComponentType.Int32: type = GL.INT; break;
				case ComponentType.UInt8: type = GL.UNSIGNED_BYTE; break;
				case ComponentType.UInt16: type = GL.UNSIGNED_SHORT; break;
				case ComponentType.UInt32: type = GL.UNSIGNED_INT; break;
			}

			size = attribute.dimension.to!(GL.Int);
			assert(size >= 1 && size <= 4, "invalid vertex component dimension");

			GL.vertexAttribPointer(i.to!(GL.UInt), size, type, false,
				attribute.stride.to!(GL.Sizei), cast(void*) attribute.byteOffset);
			GL.enableVertexAttribArray(i.to!(GL.UInt));
		}

		GLShader glShader = cast(GLShader) shader;

		GL.useProgram(glShader.id);

		glShader.updateUniforms();

		bool cullBack = (info.flags & DrawFlags.CullBack) != 0;
		bool cullFront = (info.flags & DrawFlags.CullFront) != 0;
		if (cullBack && cullFront) {
			GL.cullFace(GL.FRONT_AND_BACK);
			GL.enable(GL.CULL_FACE);
		}
		else if (cullBack) {
			GL.cullFace(GL.BACK);
			GL.enable(GL.CULL_FACE);
		}
		else if (cullFront) {
			GL.cullFace(GL.FRONT);
			GL.enable(GL.CULL_FACE);
		}
		else {
			GL.disable(GL.CULL_FACE);
		}

		if (info.flags & DrawFlags.DepthTest) {
			GL.enable(GL.DEPTH_TEST);
		}
		else {
			GL.disable(GL.DEPTH_TEST);
		}

		if (info.flags & DrawFlags.Blend) {
			// GL.enable(GL.BLEND);
			// GL.blendEquation(GL.FUNC_ADD);
			// GL.blendFunc(GL.ONE, GL.ONE);
			GL.enable(GL.COLOR_LOGIC_OP);
			GL.logicOp(GL.XOR);
		}
		else {
			GL.disable(GL.BLEND);
			GL.disable(GL.COLOR_LOGIC_OP);
		}

		GL.Enum mode;
		final switch (info.mode) {
			case DrawMode.Triangles: mode = GL.TRIANGLES; break;
			case DrawMode.TriangleFan: mode = GL.TRIANGLE_FAN; break;
			case DrawMode.TriangleStrip: mode = GL.TRIANGLE_STRIP; break;
		}

		// TODO: drawElements
		if (info.instanceCount == 1) {
			GL.drawArrays(
				mode,
				info.startVertex.to!(GL.Int),
				info.numVertices.to!(GL.Sizei),
			);
		}
		else {
			GL.drawArraysInstanced(
				mode,
				info.startVertex.to!(GL.Int),
				info.numVertices.to!(GL.Sizei),
				info.instanceCount.to!(GL.Sizei),
			);
		}
	}

	override void blit(
		GPUSurface surface,
		IRect surfaceRect,
		GPUImage source,
		IRect sourceRect,
	) {
		GLImage img = cast(GLImage) source;
		assert(img, "expected GL image in GL context");

		if (GLWindowSurface winSurface = cast(GLWindowSurface) surface) {
			surfaceRect.y = winSurface.window.bufferSize.y - surface.size.y - surfaceRect.y;
		}
		else {
			surfaceRect.y = surface.size.y - surfaceRect.height - surfaceRect.y;
		}

		sourceRect.y = source.size.y - sourceRect.height - sourceRect.y;

		img.initializeFBO();
		switchToSurface(surface);
		GL.blitNamedFramebuffer(
			img.fbo, 0,
			sourceRect.left, sourceRect.top, sourceRect.right, sourceRect.bottom,
			surfaceRect.left, surfaceRect.top, surfaceRect.right, surfaceRect.bottom,
			GL.COLOR_BUFFER_BIT, GL.NEAREST
		);
	}

}
