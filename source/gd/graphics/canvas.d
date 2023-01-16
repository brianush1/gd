module gd.graphics.canvas;
import gd.graphics.color;
import gd.graphics.rect;
import gd.geometry.path;
import gd.math;

enum Antialias {
	none,
	grayscale,
	subpixel,
}

/+
private final class ImageImpl {
	bool fboInitialized = false;
	GL.UInt fbo, rbo, texture;
	IVec2 size;

	~this() {
		if (fboInitialized) {
			GL.deleteRenderbuffers(1, &rbo);
			GL.deleteFramebuffers(1, &fbo);
		}

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

			if (GL.checkFramebufferStatus(GL.FRAMEBUFFER) != GL.FRAMEBUFFER_COMPLETE) {
				GL.deleteFramebuffers(1, &fbo);
				GL.deleteRenderbuffers(1, &rbo);
				throw new Exception("an error occurred while creating a framebuffer");
			}

			fboInitialized = true;
		}
	}
}

enum BlendingMode {
	normal,
	overwrite,
}

struct Fill {
	Color color = Color.fromHex("#000");
	FillRule rule = FillRule.nonZero;
	Antialias antialias = Antialias.grayscale;
	BlendingMode blendingMode = BlendingMode.normal;
}

class Image {

	private {
		ImageImpl impl;
		IRect bounds;

		this() {}
	}

	IVec2 size() const @property {
		return bounds.size;
	}

	Image slice(IRect rect) {
		Image result = new Image;
		result.impl = impl;
		result.bounds = bounds.clipArea(rect);
		return result;
	}

	void clear(Color color) {
		Fill fill;

		fill.color = color;
		fill.blendingMode = BlendingMode.overwrite;

		fillRect(Rect(0, 0, bounds.width, bounds.height), fill);
	}

	void fill(Path path, Fill options) {

	}

	void fillRect(Rect rect, Fill options) {

	}

}
+/
