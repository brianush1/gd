module gd.graphics.backend.common;
import gd.graphics.color;
import gd.resource;
import gd.math;

/+

// Enums:

enum ShaderType {
	Fragment,
	Vertex,
}

enum DrawMode {
	Triangles,
	TriangleFan,
	TriangleStrip,
}

enum MeshUsage {

	/** Signals that the mesh will not be modified often */
	Static,

	/** Signals that the mesh will be modified often */
	Dynamic,

}

enum AttributeType {
	Float,
	FVec2,
	FVec3,
	FVec4,
	Int,
	IVec2,
	IVec3,
	IVec4,
}

size_t byteLength(AttributeType type) {
	final switch (type) {
		case AttributeType.Float: return float.sizeof;
		case AttributeType.FVec2: return FVec2.sizeof;
		case AttributeType.FVec3: return FVec3.sizeof;
		case AttributeType.FVec4: return FVec4.sizeof;
		case AttributeType.Int: return int.sizeof;
		case AttributeType.IVec2: return IVec2.sizeof;
		case AttributeType.IVec3: return IVec3.sizeof;
		case AttributeType.IVec4: return IVec4.sizeof;
	}
}

enum StencilFunction {
	Always,
	Never,
	Lt,
	Le,
	Gt,
	Ge,
	Eq,
	Neq,
}

enum StencilOp {
	Nop,
	Zero,
	Set,
	Inc,
	Dec,
	IncWrap,
	DecWrap,
	Inv,
}

// Structs:

struct ShaderSource {
	ShaderType type;
	string source;
}

struct Attribute {
	string name;
	AttributeType type;
	size_t byteOffset;
}

struct VertexFormat {
	Attribute[] attributes;
	size_t stride;

	VertexFormat add(string name, AttributeType type) {
		// TODO: bind to input based on name; currently uses order
		attributes ~= Attribute(name, type, stride);
		stride += type.byteLength;
		return this;
	}
}

struct Stencil {
	StencilFunction func = StencilFunction.Always;
	StencilOp stencilFail = StencilOp.Nop;
	StencilOp depthFail = StencilOp.Nop;
	StencilOp pass = StencilOp.Nop;
	ubyte refValue = 0;
	ubyte writeMask = 0xFF;
	ubyte readMask = 0xFF;
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

enum BlendFuncs : BlendFunc {
	Normal = BlendFunc(
		BlendFunc.Op.Add,
		BlendFunc.Factor.SrcAlpha,
		BlendFunc.Factor.OneMinusSrcAlpha,
	),
	Overwrite = BlendFunc(
		BlendFunc.Op.Add,
		BlendFunc.Factor.One,
		BlendFunc.Factor.Zero,
	),
	Add = BlendFunc(
		BlendFunc.Op.Add,
		BlendFunc.Factor.One,
		BlendFunc.Factor.One,
	),
}

// Resources:

abstract class Shader : Resource {

	void setUniform(string name, float value);
	void setUniform(string name, int value);
	void setUniform(string name, FVec2 value);
	void setUniform(string name, FVec3 value);
	void setUniform(string name, FVec4 value);
	void setUniform(string name, Color value);
	void setUniform(string name, IVec2 value);
	void setUniform(string name, IVec3 value);
	void setUniform(string name, IVec4 value);
	void setUniform(string name, Mat4 value);
	void setUniform(string name, Frame2 value);
	void setUniform(string name, Frame3 value);
	void setUniform(string name, Texture value);

}

struct MeshSlice {
	BaseMesh mesh;
	size_t startVertex, numVertices;
}

abstract class BaseMesh : Resource {
	VertexFormat format;
	MeshUsage usage;

	void upload(void[] data);

	size_t numVertices() const @property;

	inout(MeshSlice) opSlice() inout {
		return inout(MeshSlice)(this, 0, numVertices);
	}
}

abstract class Mesh(Vertex) : BaseMesh {
	void upload(const(Vertex)[] data) {

	}
}

abstract class Texture : Resource {
	IVec2 size() const @property;
}

abstract class Framebuffer : Texture {}

abstract class GraphicsContext : Resource {

	/** Creates a new shader from the given sources */
	Shader createShader(ShaderSource[] sources);

	RawMesh createRawMesh(VertexFormat format, MeshUsage usage);

	Mesh!Vertex createMesh(Vertex)(MeshUsage usage = MeshUsage.Static) if (is(Vertex == struct)) {
		RawMesh raw = createRawMesh(format, usage);
		Mesh!Vertex result = new Mesh!Vertex(raw);
		raw.addDependency(result);
		return result;
	}

	Framebuffer createFramebuffer(IVec2 size);

	Texture createTexture(IVec2 size, const(void)[] data);

	/**

	Sets the current rendering target

	Pass in $(D null) to draw onto the main window

	*/
	void renderTarget(Framebuffer framebuffer);

	/** Gets the current rendering target, or $(D null) */
	inout(Framebuffer) renderTarget() inout @property;

	/** Clears the color buffer with the given color */
	void clearColor(Color color);

	/** Clears the stencil buffer with the given value */
	void clearStencil(ubyte value);

	void stencil(Stencil value);

	void stencilSeparate(Stencil frontFace, Stencil backFace);

	/** Gets the color channel blending function */
	BlendFunc colorBlend() const @property;

	/** Gets the alpha channel blending function */
	BlendFunc alphaBlend() const @property;

	/** Same as $(REF colorBlend) */
	BlendFunc blend() const @property;

	void blend(BlendFunc value);

	void blendSeparate(BlendFunc color, BlendFunc alpha);

	/** Sets the viewport rectangle */
	void viewport(IVec2 location, IVec2 size);

	void colorWriteMask(bool r, bool g, bool b, bool a);

	void draw(T)(DrawMode mode, Shader shader, Mesh!T mesh) {
		draw(mode, shader, mesh[]);
	}

	void drawInstanced(T)(DrawMode mode, Shader shader, Mesh!T mesh, size_t count) {
		drawInstanced(mode, shader, mesh[], count);
	}

	void draw(DrawMode mode, Shader shader, MeshSlice mesh);
	void drawInstanced(DrawMode mode, Shader shader, MeshSlice mesh, size_t count);

}

+/
