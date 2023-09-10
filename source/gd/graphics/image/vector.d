module gd.graphics.image.vector;
import gd.graphics.image.bitmap;
import gd.graphics.image.base;
import gd.math;

enum VectorFileFormat {
	SVG,
}

class VectorImage : Image {

	private Vec2 m_size;
	override Vec2 size() const @property { return m_size; }

	void save(string filename, VectorFileFormat format) {
		assert(format == VectorFileFormat.SVG);
		assert(0);
	}

	BitmapImage toBitmap(IVec2 size) const {
		// FIXME: implement this
		return new BitmapImage(size);
	}

}
