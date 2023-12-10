module gd.internal.gpu;
import gd.internal.window;
import gd.shaders;
import gd.graphics.color;
import gd.resource;
import gd.math;

enum ShaderType { Fragment, Vertex }

struct ShaderSource {
	ShaderType type;
	string source;
}

abstract class GPUShader : Resource {

	abstract void setUniform(string name, float value);
	abstract void setUniform(string name, int value);
	abstract void setUniform(string name, FVec2 value);
	abstract void setUniform(string name, FVec3 value);
	abstract void setUniform(string name, FVec4 value);
	abstract void setUniform(string name, IVec2 value);
	abstract void setUniform(string name, IVec3 value);
	abstract void setUniform(string name, IVec4 value);
	// abstract void setUniform(string name, Mat4 value);
	// abstract void setUniform(string name, Frame2 value);
	// abstract void setUniform(string name, Frame3 value);
	abstract void setUniform(string name, GPUImage value);

	void setUniform(T)(string name, TSampler2D!T value) {
		setUniform(name, value.gpuImage);
	}

}

enum BufferUsage {

	/** Hints that the buffer will not be modified often */
	Static,

	/** Hints that the buffer will be modified often */
	Dynamic,

}

enum ComponentType {
	Float16,
	Float32,
	Float64,
	Int8,
	Int16,
	Int32,
	UInt8,
	UInt16,
	UInt32,
}

struct MeshAttribute {
	ComponentType type;
	size_t dimension;
	size_t byteOffset;
	size_t stride;
}

abstract class GPUBuffer : Resource {
	abstract BufferUsage usage() const @property;
	abstract void upload(void[] data);
	abstract void update(size_t offset, void[] data);
}

abstract class GPUMesh : Resource {
	abstract const(GPUBuffer) vertices() const @property;
	abstract void vertices(const(GPUBuffer) value) @property;

	abstract const(GPUBuffer) indices() const @property;
	abstract void indices(const(GPUBuffer) value) @property;
}

enum ImageFormat {
	RGBA,
	RGBA8I,
	RGBA_SNORM,
	RGBA32F,
	R16U,
}

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
	None = 0,
	CullBack  = 0b0000_0001,
	CullFront = 0b0000_0010,
	DepthTest = 0b0000_0100,
	Blend     = 0b0000_1000,
}

struct WriteInfo {
	IRect clip = IRect(0, 0, int.max, int.max);
}

struct DrawInfo {
	WriteInfo write;
	DrawMode mode;
	DrawFlags flags;
	GPUMesh mesh;
	IRect viewport;
	size_t startVertex, numVertices;
	size_t instanceCount = 1;

	alias write this;
}

private string cutZeros(string s) {
	size_t len = 0;
	while (len < s.length && s[len] != '\0')
		len += 1;
	return s[0 .. len];
}

abstract class GPUContext : Resource {

	abstract GPUShader createShader(const(ShaderSource)[] sources);

	abstract GPUBuffer createBuffer(BufferUsage usage);

	abstract GPUMesh createMesh(const(MeshAttribute)[] attributes);

	GPUMesh createMesh(T)(GPUBuffer vertices) if (is(T == struct)) {
		import std.traits : FieldNameTuple;

		MeshAttribute[] attributes;

		size_t stride = T.sizeof;

		ComponentType componentTypeOf(K)() {
			static if (is(K : float)) return ComponentType.Float32;
			else static if (is(K : double)) return ComponentType.Float64;
			else static if (is(K : byte)) return ComponentType.Int8;
			else static if (is(K : short)) return ComponentType.Int16;
			else static if (is(K : int)) return ComponentType.Int32;
			else static if (is(K : ubyte)) return ComponentType.UInt8;
			else static if (is(K : ushort)) return ComponentType.UInt16;
			else static if (is(K : uint)) return ComponentType.UInt32;
			else static assert(0);
		}

		void walk(K)(size_t offset) {
			static if (is(K == TVec2!V2, V2)) {
				attributes ~= MeshAttribute(componentTypeOf!V2, 2, offset, stride);
			}
			else static if (is(K == TVec3!V3, V3)) {
				attributes ~= MeshAttribute(componentTypeOf!V2, 3, offset, stride);
			}
			else static if (is(K == TVec4!V4, V4)) {
				attributes ~= MeshAttribute(componentTypeOf!V2, 4, offset, stride);
			}
			else static if (is(typeof(componentTypeOf!K))) {
				attributes ~= MeshAttribute(componentTypeOf!K, 1, offset, stride);
			}
			else static if (is(K == struct)) {
				foreach (field; FieldNameTuple!K) {
					alias FieldType = typeof(__traits(getMember, K, field));
					walk!FieldType(offset + __traits(getMember, K, field).offsetof);
				}
			}
			else {
				static assert(0);
			}
		}

		walk!T(0);

		GPUMesh res = createMesh(attributes);
		res.vertices = vertices;
		return res;
	}

	abstract GPUImage createImage(ImageFormat format, IVec2 size, const(void)[] data);

	abstract GPUSurface surfaceOf(Window window);

	abstract void clearColorBuffer(GPUSurface surface, FVec4 color, WriteInfo info);
	abstract void clearColorBuffer(GPUSurface surface, IVec4 color, WriteInfo info);
	abstract void clearDepthBuffer(GPUSurface surface, double depth, WriteInfo info);

	void clearColorBuffer(GPUSurface surface, WriteInfo info) { clearColorBuffer(surface, FVec4(0, 0, 0, 0), info); }
	void clearDepthBuffer(GPUSurface surface, WriteInfo info) { clearDepthBuffer(surface, 1, info); }

	void compileShader(T : Shader)(T shader) {
		import std.traits : moduleName;

		template getSource(string name) {
			static if (is(typeof(__traits(glsl__source, Object, "")))) {
				enum getSource = __traits(glsl__source, T, name);
			}
			else {
				mixin("import " ~ moduleName!T ~ "__shadersource;");
				enum getSource = __traits(getMember, mixin(T.mangleof), name);
			}
		}

		if (!shader.gpuShader) {
			ShaderSource[] sources;
			sources ~= ShaderSource(ShaderType.Vertex, "#version 330 core\n" ~ getSource!"VertexSource".cutZeros);
			sources ~= ShaderSource(ShaderType.Fragment, "#version 330 core\n" ~ getSource!"FragmentSource".cutZeros);

			shader.gpuShader = createShader(sources);
		}
	}

	void draw(T : Shader)(GPUSurface surface, T shader, DrawInfo info) {
		import std.traits : FieldNameTuple, getUDAs, moduleName;
		import std.conv : text;

		compileShader(shader);

		// TODO: avoid setting uniforms if they haven't changed

		template rename(string name) {
			static if (is(typeof(__traits(glsl__source, Object, "")))) {
				enum rename = __traits(glsl__rename, T, name);
			}
			else {
				mixin("import " ~ moduleName!T ~ "__shadersource;");
				enum rename = mixin(T.mangleof).Rename!name;
			}
		}

		template global(string name) {
			static if (is(typeof(__traits(glsl__source, Object, "")))) {
				enum global = __traits(glsl__global, name);
			}
			else {
				mixin("import " ~ moduleName!T ~ "__shadersource;");
				enum global = Global!name;
			}
		}

		void uploadUniform(U)(string base, U value) {
			static if (is(typeof(shader.gpuShader.setUniform(base, value)))) {
				shader.gpuShader.setUniform(base, value);
			}
			else static if (is(U == K[n], K, size_t n)) {
				foreach (i; 0 .. n) {
					uploadUniform!K(text(base, "[", i, "]"), value[i]);
				}
			}
			else static if (is(U == struct)) {
				foreach (i, field; FieldNameTuple!U) {
					uploadUniform!(typeof(__traits(getMember, value, field)))(
						text(base, ".f", i), __traits(getMember, value, field));
				}
			}
			else {
				// TODO: better error reporting
				static assert(0);
			}
		}

		foreach (field; FieldNameTuple!T) {
			alias FieldType = typeof(__traits(getMember, shader, field));
			enum isVarying = getUDAs!(__traits(getMember, shader, field), Varying).length > 0;
			enum isOutput = getUDAs!(__traits(getMember, shader, field), Output).length > 0;
			enum isUniform = !isVarying && !isOutput;
			static if (isUniform)
				uploadUniform!FieldType(rename!field.cutZeros, __traits(getMember, shader, field));
		}

		shader.gpuShader.setUniform(global!"viewportPos".cutZeros, info.viewport.position);
		shader.gpuShader.setUniform(global!"viewportSize".cutZeros, info.viewport.size);

		draw(surface, shader.gpuShader, info);
	}

	abstract void draw(GPUSurface surface, GPUShader shader, DrawInfo info);

	abstract void blit(
		GPUSurface surface,
		IRect surfaceRect,
		GPUImage source,
		IRect sourceRect,
	);

}
