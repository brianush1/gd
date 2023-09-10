module gd.shaders;
import gd.math;
import gd.internal.gpu;

private enum __glsl { // @suppress(dscanner.style.phobos_naming_convention)
	varying = 0x200,
	flat = 0x202,
	output = 0x203,
}

alias Varying = __glsl.varying;
alias Flat = __glsl.flat;
alias Output = __glsl.output;

struct Layout {
	int location;
}

struct VSOutput {
	FVec4 position;
}

abstract class Shader {

	package(gd) GPUShader gpuShader;

protected:

	IRect viewport() const @property {
		assert(0, "viewport can only be used inside a shader");
	}

	int instanceID() const @property {
		assert(0, "instanceID can only be used inside a shader");
	}

	FVec4 fragCoord() const @property {
		assert(0, "fragCoord can only be used inside a fragment shader");
	}

	bool isFrontFacing() const @property {
		assert(0, "isFrontFacing can only be used inside a fragment shader");
	}

	noreturn discard() {
		assert(0, "discard can only be used inside a fragment shader");
	}

}

alias Sampler2D = TSampler2D!float;
alias ISampler2D = TSampler2D!int;
alias USampler2D = TSampler2D!uint;

struct TSampler1D(T) {

	private this() {}

	TVec4!T get(float pos) {
		assert(0, "Sampler1D can only be used inside a fragment shader");
	}

}

struct TSampler2D(T) {

	package(gd) GPUImage gpuImage;

	this(GPUImage gpuImage) {
		this.gpuImage = gpuImage;
	}

	TVec4!T get(FVec2 pos) {
		assert(0, "Sampler2D can only be used inside a fragment shader");
	}

}

struct TSampler3D(T) {

	private this() {}

	TVec4!T get(FVec3 pos) {
		assert(0, "Sampler3D can only be used inside a fragment shader");
	}

}
