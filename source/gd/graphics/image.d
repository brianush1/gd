module gd.graphics.image;
import gd.graphics.color;
import gd.geom.area;
import gd.math;

import gd.bindings.gl;

enum Antialias {
	None,
	Grayscale,
	Subpixel,
}

class Image {

	this(IVec2 size) {
		m_size = size;
	}

	this(int width, int height) {
		this(IVec2(width, height));
	}

	private IVec2 m_size;
	IVec2 size() const @property { return m_size; }

	void getPixels(IRect rect, uint[] buffer) {
		assert(buffer.length >= rect.width * rect.height);

	}

	uint[] getPixels(IRect rect) {
		uint[] result = new uint[rect.width * rect.height];
		getPixels(rect, result);
		return result;
	}

}
