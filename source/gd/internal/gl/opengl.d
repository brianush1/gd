module gd.internal.gl.opengl;
import gd.internal.gl.exception;
import gd.internal.gpu;
import gd.internal.window;
import gd.bindings.gl;
import gd.math;
import std.typecons;

class GLShader : GPUShader {

}

class GLMesh : GPUMesh {
private:

	GLContext context;

	MeshAttribute[] attributes;
	MeshUsage usage;

	this() {

	}

public:

	override void set(void[] data) {

	}

	override void update(size_t offset, void[] data) {

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

		context.switchToHeadless();

		GL.genTextures(1, &texture);
		GL.bindTexture(GL.TEXTURE_2D, texture);

		assert(format == ImageFormat.RGBA); // TODO: other formats

		GL.texParameteri(GL.TEXTURE_2D, GL.TEXTURE_WRAP_S, GL.REPEAT);
		GL.texParameteri(GL.TEXTURE_2D, GL.TEXTURE_WRAP_T, GL.REPEAT);
		GL.texParameteri(GL.TEXTURE_2D, GL.TEXTURE_MIN_FILTER, GL.LINEAR);
		GL.texParameteri(GL.TEXTURE_2D, GL.TEXTURE_MAG_FILTER, GL.LINEAR);
		GL.texImage2D(GL.TEXTURE_2D, 0, GL.RGBA,
			cast(GL.Sizei) size.x, cast(GL.Sizei) size.y,
			0, GL.RGBA, GL.UNSIGNED_BYTE, data.ptr == null ? null : flipImage(size.x, size.y, data).ptr,
		);
	}

	protected override void disposeImpl() {
		GL.deleteTextures(1, &texture);
	}

	void initializeFBO() {
		if (!fboInitialized) {
			GL.genFramebuffers(1, &fbo);
			GL.bindFramebuffer(GL.FRAMEBUFFER, fbo);
			GL.framebufferTexture2D(GL.FRAMEBUFFER, GL.COLOR_ATTACHMENT0, GL.TEXTURE_2D, texture, 0);

			GL.genRenderbuffers(1, &rbo);
			GL.bindRenderbuffer(GL.RENDERBUFFER, rbo);
			GL.renderbufferStorage(GL.RENDERBUFFER, GL.DEPTH24_STENCIL8,
				cast(GL.Sizei) size.x, cast(GL.Sizei) size.y);
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
			cast(GL.Int) rect.x, cast(GL.Int) rect.y,
			cast(GL.Sizei) rect.width, cast(GL.Sizei) rect.height,
			GL.RGBA, GL.UNSIGNED_BYTE,
			cast(GL.Sizei) dest.length, dest.ptr,
		);
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

class GLContext : GPUContext {

	private {
		// TODO: use weak maps
		void delegate()[Window] makeCurrentTable;
		GLWindowSurface[Window] surfaceCache;

		bool uninitialized = true;
		Window currentWindow;
		GL.UInt currentFbo;
	}

	protected override void disposeImpl() {}

	package(gd.internal) void registerWindow(Window window, void delegate() makeCurrent) {
		makeCurrentTable[window] = makeCurrent;
	}

	override GLShader createShader(ShaderSource[] sources) {
		return null;
	}

	override GLMesh createMesh(MeshAttribute[] attributes, MeshUsage usage) {
		return null;
	}

	override GLImage createImage(ImageFormat format, IVec2 size, const(void)[] data) {
		return new GLImage(this, format, size, data);
	}

	override GLWindowSurface surfaceOf(Window window) {
		if (window !in surfaceCache) {
			surfaceCache[window] = new GLWindowSurface(this, window);
		}

		return surfaceCache[window];
	}

	private void switchToHeadless(Flag!"force" force = No.force) {
		if (force || currentWindow !is null || uninitialized) {
			uninitialized = false;
			currentWindow = null;
			makeCurrentTable[null]();
		}
	}

	package(gd.internal) void switchToSurface(GPUSurface surface, Flag!"force" force = No.force) {
		bool changedWindow = false;

		if (auto img = cast(GLImage) surface) {
			// TODO: avoid unnecessary context switches; only switch to headless context
			// if the current window has been destroyed

			if (force || currentWindow !is null || uninitialized) {
				uninitialized = false;
				currentWindow = null;
				makeCurrentTable[null]();
				changedWindow = true;
			}

			img.initializeFBO();

			if (changedWindow || currentFbo != img.fbo) {
				currentFbo = img.fbo;
				GL.bindFramebuffer(GL.FRAMEBUFFER, img.fbo);
			}
		}
		else if (auto windowSurface = cast(GLWindowSurface) surface) {
			if (force || currentWindow !is windowSurface.window || uninitialized) {
				uninitialized = false;
				currentWindow = windowSurface.window;
				makeCurrentTable[windowSurface.window]();
				changedWindow = true;
			}

			if (changedWindow || currentFbo != 0) {
				currentFbo = 0;
				GL.bindFramebuffer(GL.FRAMEBUFFER, 0);
			}
		}
		else {
			throw new GLException("expected GL surface for render target in GL context");
		}
	}

	override void clearColorBuffer(GPUSurface surface, FVec4 color) {
		switchToSurface(surface);
		GL.clearColor(color.x, color.y, color.z, color.w);
		GL.clear(GL.COLOR_BUFFER_BIT);
	}

	override void clearDepthBuffer(GPUSurface surface, double depth) {
		switchToSurface(surface);
		GL.clearDepth(depth);
		GL.clear(GL.DEPTH_BUFFER_BIT);
	}

	override void draw(GPUSurface surface, DrawInfo info) {
		switchToSurface(surface);
		assert(0, "not implemented yet");
	}

}
