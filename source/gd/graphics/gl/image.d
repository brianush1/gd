module gd.graphics.gl.image;
import gd.graphics.gl.context;
import gd.graphics.gl.exception;
import gd.graphics.image;
import gd.graphics.color;
import gd.geom.area;
import gd.math;

import gd.bindings.gl;

enum Antialias {
	None,
	Grayscale,
	Subpixel,
}

class GLImage : Image {
	GLGraphicsContext context;

	bool fboInitialized = false;
	GL.UInt fbo, rbo, texture;

	private IVec2 m_size;
	override IVec2 size() const @property { return m_size; }

	this(GLGraphicsContext context, IVec2 size, const(uint)[] data) {
		this.context = context;

		GL.Enum internalFormat = GL.RGBA;
		GL.Enum format = GL.RGBA;
		GL.Enum type = GL.UNSIGNED_BYTE;

		if (data.length != size.x * cast(size_t) size.y) {
			throw new GLException("image data must match image size");
		}

		m_size = size;

		GL.genTextures(1, &texture);
		GL.bindTexture(GL.TEXTURE_2D, texture);
		GL.texParameteri(GL.TEXTURE_2D, GL.TEXTURE_MIN_FILTER, GL.LINEAR);
		GL.texParameteri(GL.TEXTURE_2D, GL.TEXTURE_MAG_FILTER, GL.LINEAR);
		GL.texImage2D(GL.TEXTURE_2D, 0, internalFormat,
			cast(GL.Sizei) size.x, cast(GL.Sizei) size.y,
			0, format, type, data.ptr,
		);
	}

	override uint[] getPixels(IRect rect) {
		ubyte[] buffer = new ubyte[cast(size_t) 4 * rect.width * rect.height];

		initializeFBO();

		Image save = context.renderTarget;
		context.renderTarget = this;
		scope (exit)
			context.renderTarget = save;

		GL.readnPixels(
			cast(GL.Int) rect.x, cast(GL.Int) rect.y,
			cast(GL.Sizei) rect.width, cast(GL.Sizei) rect.height,
			GL.RGBA, GL.UNSIGNED_BYTE,
			cast(GL.Sizei) buffer.length, buffer.ptr,
		);

		return cast(uint[]) buffer;
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

			if (GL.checkFramebufferStatus(GL.FRAMEBUFFER) != GL.FRAMEBUFFER_COMPLETE) {
				GL.deleteFramebuffers(1, &fbo);
				GL.deleteRenderbuffers(1, &rbo);
				throw new GLException("an error occurred while creating a framebuffer");
			}

			fboInitialized = true;
		}
	}
}
