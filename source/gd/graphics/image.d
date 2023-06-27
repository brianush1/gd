module gd.graphics.image;
import gd.graphics.color;
import gd.math;

import gd.internal.application;
import gd.internal.gpu;

enum ImageFileFormat {
	PNG,
	BMP,
	GIF,
	JPEG,
	TIFF,
	WEBP,
	ICO,
}

class Image {

	public GPUImage gpuImage;

	this(int width, int height) {
		this(IVec2(width, height));
	}

	this(IVec2 size) {
		m_size = size;

		gpuImage = application.display.gpuContext.createImage(ImageFormat.RGBA, size, null);
	}

	static Image fromFile(string filename, ImageFileFormat format) {
		assert(0, "not implemented"); // TODO: implement
	}

	private IVec2 m_size;
	IVec2 size() const @property { return m_size; }

	void readPixels(IRect rect, uint[] buffer) {
		assert(buffer.length >= rect.width * rect.height);

		gpuImage.readPixels(rect, cast(void[]) buffer);
	}

	uint[] readPixels(IRect rect) {
		uint[] result = new uint[rect.width * rect.height];
		readPixels(rect, result);
		return result;
	}

	void save(string filename, ImageFileFormat format) {
		import imageformats : write_png;

		assert(format == ImageFileFormat.PNG);
		write_png(filename, size.x, size.y, cast(ubyte[]) readPixels(IRect(IVec2(), size)));
	}

}
