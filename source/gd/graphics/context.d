module gd.graphics.context;
import gd.graphics.image;
import gd.graphics.color;
import gd.geom.area;
import gd.math;

import gd.internal.application;
import gd.internal.gpu;

enum Antialias {
	None,
	Grayscale,
	Subpixel,
}

private GPUContext gpu() { return application.display.gpuContext; }

class Graphics {

	private GPUSurface surface;

	private this(GPUSurface surface) { this.surface = surface; }

	static Graphics fromImage(Image image) { return new Graphics(image.gpuImage); }
	static Graphics fromGPUSurface(GPUSurface surface) { return new Graphics(surface); }

	void clear(Color color) {
		gpu.clearColorBuffer(surface, FVec4(color.r, color.g, color.b, color.a));
	}

	void fill(Area area, Color color, Antialias antialias = Antialias.Grayscale) {
		assert(0, "not implemented"); // TODO: implement
	}

}
