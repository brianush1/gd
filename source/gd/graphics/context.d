module gd.graphics.context;
import gd.graphics.shader;
import gd.graphics.image;
import gd.graphics.mesh;
import gd.graphics.color;
import gd.resource;
import gd.math;

enum StencilFilter {
	Always,
	Never,
	Less,
	LessEqual,
	Greater,
	GreaterEqual,
	Equal,
	NotEqual,
}

enum StencilOp {
	NoChange,
	Zero,
	Set,
	Increment,
	Decrement,
	IncrementWrap,
	DecrementWrap,
	Invert,
}

struct Stencil {
	StencilFilter filter = StencilFilter.Always;
	StencilOp stencilFail = StencilOp.NoChange;
	StencilOp depthFail = StencilOp.NoChange;
	StencilOp pass = StencilOp.NoChange;
	ubyte refValue = 0;
	ubyte writeMask = 0xFF;
	ubyte readMask = 0xFF;
}

enum DrawMode {
	Triangles,
	TriangleFan,
	TriangleStrip,
}

struct BlendFunc {
	enum Factor {
		Zero,
		One,
		SrcColor,
		DstColor,
		SrcAlpha,
		DstAlpha,
		ConstColor,
		ConstAlpha,
		OneMinusSrcColor,
		OneMinusDstColor,
		OneMinusSrcAlpha,
		OneMinusDstAlpha,
		OneMinusConstColor,
		OneMinusConstAlpha,
	}

	enum Op {
		Add,
		SrcMinusDst,
		DstMinusSrc,
		Min,
		Max,
	}

	Op op;
	Factor sfactor;
	Factor dfactor;
	FVec4 constant = FVec4(0, 0, 0, 0);
}

abstract class GraphicsContext {

	abstract Shader createShader(ShaderSource[] sources);

	abstract Mesh createMesh(VertexFormat format, MeshUsage usage);

	Image createImage(IVec2 size) {
		return createImage(size, new uint[size.x * cast(size_t) size.y]);
	}

	abstract Image createImage(IVec2 size, const(uint)[] data);

	abstract void renderTarget(Image image) @property;
	abstract inout(Image) renderTarget() inout @property;

	abstract void clearColor(Color color);
	abstract void clearStencil(ubyte value);
	abstract void clearDepth();

	void stencil(Stencil value) { stencilSeparate(value, value); }
	abstract void stencilSeparate(Stencil frontFace, Stencil backFace);

	void blend(BlendFunc value) { blendSeparate(value, value); }
	abstract void blendSeparate(BlendFunc color, BlendFunc alpha);

	abstract void viewport(IVec2 location, IVec2 size);

	abstract void cullBack(bool value) @property;

	abstract void depthTest(bool value) @property;

	// void draw(T)(Shader shader, Mesh!T mesh, DrawMode mode = DrawMode.Triangles)
	// 	=> draw(mode, shader, mesh[]);
	// void drawInstanced(T)(Shader shader, Mesh!T mesh, size_t count, DrawMode mode = DrawMode.Triangles)
	// 	=> drawInstanced(mode, shader, mesh[], count);

	abstract void draw(Shader shader,
			Mesh mesh,
			size_t startVertex, size_t numVertices,
			DrawMode mode = DrawMode.Triangles);
	abstract void drawInstanced(Shader shader,
			Mesh mesh,
			size_t startVertex, size_t numVertices,
			size_t count,
			DrawMode mode = DrawMode.Triangles);

}
