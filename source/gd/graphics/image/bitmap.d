module gd.graphics.image.bitmap;
import gd.graphics.image.base;
import gd.graphics.color;
import gd.math;

import gd.internal.application;
import gd.internal.gpu;

enum BitmapFileFormat {
	PNG,
	BMP,
	GIF,
	JPEG,
	TIFF,
	WEBP,
	ICO,
}

class BitmapImage : Image {

	public GPUImage gpuImage;
	package(gd.graphics) {
		GPUImage backBuffer;

		void swapBuffers() {
			GPUImage temp = gpuImage;
			gpuImage = backBuffer;
			backBuffer = temp;
		}
	}

	this(int width, int height) {
		this(IVec2(width, height));
	}

	this(IVec2 size) {
		m_size = size;

		gpuImage = application.display.gpuContext.createImage(ImageFormat.RGBA, size, null);
		backBuffer = application.display.gpuContext.createImage(ImageFormat.RGBA, size, null);
	}

	private this(IVec2 size, const(void)[] data) {
		m_size = size;

		gpuImage = application.display.gpuContext.createImage(ImageFormat.RGBA, size, data);
		backBuffer = application.display.gpuContext.createImage(ImageFormat.RGBA, size, null);
	}

	static BitmapImage fromFile(string filename, BitmapFileFormat format) {
		import std.file : read;

		return fromMemory(read(filename), format);
	}

	static BitmapImage fromAsset(string assetName)(BitmapFileFormat format) {
		return fromMemory(import(assetName), format);
	}

	static BitmapImage fromMemory(const(void)[] buffer, BitmapFileFormat format) {
		import imageformats : read_png_from_mem, IFImage;

		assert(format == BitmapFileFormat.PNG);
		IFImage img = read_png_from_mem(cast(ubyte[]) buffer, 4);
		return new BitmapImage(IVec2(img.w, img.h), img.pixels);
	}

	private IVec2 m_size;
	override Vec2 size() const @property { return Vec2(m_size); }
	IVec2 isize() const @property { return m_size; }

	void readPixels(IRect rect, uint[] buffer) {
		assert(buffer.length >= rect.width * rect.height);

		gpuImage.readPixels(rect, cast(void[]) buffer);
	}

	uint[] readPixels(IRect rect) {
		uint[] result = new uint[rect.width * rect.height];
		readPixels(rect, result);
		return result;
	}

	void save(string filename, BitmapFileFormat format) {
		import imageformats : write_png;

		assert(format == BitmapFileFormat.PNG);
		write_png(filename, isize.x, isize.y, cast(ubyte[]) readPixels(IRect(IVec2(), size)));
	}

}
