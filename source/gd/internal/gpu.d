module gd.internal.gpu;
import gd.internal.window;
import gd.graphics;
import gd.resource;
import gd.math;

enum ShaderType { Fragment, Vertex }

struct ShaderSource {
	ShaderType type;
	string source;
}

abstract class GPUShader : Resource {

	// void setUniform(string name, float value);
	// void setUniform(string name, int value);
	// void setUniform(string name, FVec2 value);
	// void setUniform(string name, FVec3 value);
	// void setUniform(string name, FVec4 value);
	// void setUniform(string name, IVec2 value);
	// void setUniform(string name, IVec3 value);
	// void setUniform(string name, IVec4 value);
	// void setUniform(string name, Mat4 value);
	// void setUniform(string name, Frame2 value);
	// void setUniform(string name, Frame3 value);
	// void setUniform(string name, GPUImage value);

}

enum MeshUsage {

	/** Hints that the mesh will not be modified often */
	Static,

	/** Hints that the mesh will be modified often */
	Dynamic,

}

enum ComponentType { Float32, Float64, Int32 }

struct MeshAttribute {
	ComponentType type;
	size_t dimension;
	size_t byteOffset;
}

abstract class GPUMesh : Resource {
	abstract void set(void[] data);
	abstract void update(size_t offset, void[] data);
}

enum ImageFormat { RGBA }

abstract class GPUSurface : Resource {
	abstract IVec2 size() const @property;
}

abstract class GPUImage : GPUSurface {
	abstract void readPixels(IRect rect, void[] dest) const;
	abstract void writePixels(IRect rect, const(void)[] src);
}

enum DrawMode {
	Triangles,
	TriangleFan,
	TriangleStrip,
}

enum DrawFlags : uint {
	CullBack  = 0b0000_0001,
	CullFront = 0b0000_0010,
	DepthTest = 0b0000_0100,
}

struct DrawInfo {
	DrawMode mode;
	DrawFlags flags;
	GPUShader shader;
	GPUMesh mesh;
	IRect viewport;
	size_t startVertex, numVertices;
	size_t count = 1;
}

abstract class GPUContext : Resource {

	abstract GPUShader createShader(ShaderSource[] sources);

	abstract GPUMesh createMesh(MeshAttribute[] attributes, MeshUsage usage);

	abstract GPUImage createImage(ImageFormat format, IVec2 size, const(void)[] data);

	abstract GPUSurface surfaceOf(Window window);

	abstract void clearColorBuffer(GPUSurface surface, FVec4 color);
	abstract void clearDepthBuffer(GPUSurface surface, double depth);

	void clearColorBuffer(GPUSurface surface) { clearColorBuffer(surface, FVec4(0, 0, 0, 0)); }
	void clearDepthBuffer(GPUSurface surface) { clearDepthBuffer(surface, 1); }

	abstract void draw(GPUSurface surface, DrawInfo info);

	/+abstract void clearStencil(ubyte value);

	void stencil(Stencil value) { stencilSeparate(value, value); }
	abstract void stencilSeparate(Stencil frontFace, Stencil backFace);

	void blend(BlendFunc value) { blendSeparate(value, value); }
	abstract void blendSeparate(BlendFunc color, BlendFunc alpha);

	abstract void cullBack(bool value) @property;

	abstract void depthTest(bool value) @property;

	abstract void draw(GPUShader shader,
			GPUMesh mesh,
			size_t startVertex, size_t numVertices,
			DrawMode mode = DrawMode.Triangles);
	abstract void drawInstanced(GPUShader shader,
			GPUMesh mesh,
			size_t startVertex, size_t numVertices,
			size_t count,
			DrawMode mode = DrawMode.Triangles);+/

}
