module gd.bindings.gles2;
import gd.bindings.loader;
import gd.resource;
import core.stdc.config;
import core.stdc.stddef;

version (gd_Android):

private static GLES2Library m_GLES2;
GLES2Library GLES2() @property { // @suppress(dscanner.confusing.function_attributes)
	if (m_GLES2 is null) {
		m_GLES2 = loadGLES2;
		registerLibraryResource(m_GLES2);
	}

	return m_GLES2;
}

GLES2Library loadGLES2() {
	version (Android) {} else {
		assert(0, "unsupported platform");
	}

	return loadStaticLibrary!(GLES2Library, delegate(string name) {
		return "gl" ~ cast(char)(name[0] + 'A' - 'a') ~ name[1 .. $];
	})();
}

abstract class GLES2Library : Resource {
extern (System) @nogc nothrow:

	alias Byte = byte;
	alias Clampf = float;
	alias Fixed = int;
	alias Short = short;
	alias UShort = ushort;
	alias Void = void;
	alias Sync = void*;
	alias Int64 = long;
	alias UInt64 = ulong;
	alias Enum = uint;
	alias UInt = uint;
	alias Char = char;
	alias Float = float;
	alias Sizeiptr = ulong;
	alias Intptr = long;
	alias Bitfield = uint;
	alias Int = int;
	alias Boolean = bool;
	alias Sizei = int;
	alias UByte = ubyte;

	enum DEPTH_BUFFER_BIT = 0x00000100;
	enum STENCIL_BUFFER_BIT = 0x00000400;
	enum COLOR_BUFFER_BIT = 0x00004000;
	enum FALSE = 0;
	enum TRUE = 1;
	enum POINTS = 0x0000;
	enum LINES = 0x0001;
	enum LINE_LOOP = 0x0002;
	enum LINE_STRIP = 0x0003;
	enum TRIANGLES = 0x0004;
	enum TRIANGLE_STRIP = 0x0005;
	enum TRIANGLE_FAN = 0x0006;
	enum ZERO = 0;
	enum ONE = 1;
	enum SRC_COLOR = 0x0300;
	enum ONE_MINUS_SRC_COLOR = 0x0301;
	enum SRC_ALPHA = 0x0302;
	enum ONE_MINUS_SRC_ALPHA = 0x0303;
	enum DST_ALPHA = 0x0304;
	enum ONE_MINUS_DST_ALPHA = 0x0305;
	enum DST_COLOR = 0x0306;
	enum ONE_MINUS_DST_COLOR = 0x0307;
	enum SRC_ALPHA_SATURATE = 0x0308;
	enum FUNC_ADD = 0x8006;
	enum BLEND_EQUATION = 0x8009;
	enum BLEND_EQUATION_RGB = 0x8009;
	enum BLEND_EQUATION_ALPHA = 0x883D;
	enum FUNC_SUBTRACT = 0x800A;
	enum FUNC_REVERSE_SUBTRACT = 0x800B;
	enum BLEND_DST_RGB = 0x80C8;
	enum BLEND_SRC_RGB = 0x80C9;
	enum BLEND_DST_ALPHA = 0x80CA;
	enum BLEND_SRC_ALPHA = 0x80CB;
	enum CONSTANT_COLOR = 0x8001;
	enum ONE_MINUS_CONSTANT_COLOR = 0x8002;
	enum CONSTANT_ALPHA = 0x8003;
	enum ONE_MINUS_CONSTANT_ALPHA = 0x8004;
	enum BLEND_COLOR = 0x8005;
	enum ARRAY_BUFFER = 0x8892;
	enum ELEMENT_ARRAY_BUFFER = 0x8893;
	enum ARRAY_BUFFER_BINDING = 0x8894;
	enum ELEMENT_ARRAY_BUFFER_BINDING = 0x8895;
	enum STREAM_DRAW = 0x88E0;
	enum STATIC_DRAW = 0x88E4;
	enum DYNAMIC_DRAW = 0x88E8;
	enum BUFFER_SIZE = 0x8764;
	enum BUFFER_USAGE = 0x8765;
	enum CURRENT_VERTEX_ATTRIB = 0x8626;
	enum FRONT = 0x0404;
	enum BACK = 0x0405;
	enum FRONT_AND_BACK = 0x0408;
	enum TEXTURE_2D = 0x0DE1;
	enum CULL_FACE = 0x0B44;
	enum BLEND = 0x0BE2;
	enum DITHER = 0x0BD0;
	enum STENCIL_TEST = 0x0B90;
	enum DEPTH_TEST = 0x0B71;
	enum SCISSOR_TEST = 0x0C11;
	enum POLYGON_OFFSET_FILL = 0x8037;
	enum SAMPLE_ALPHA_TO_COVERAGE = 0x809E;
	enum SAMPLE_COVERAGE = 0x80A0;
	enum NO_ERROR = 0;
	enum INVALID_ENUM = 0x0500;
	enum INVALID_VALUE = 0x0501;
	enum INVALID_OPERATION = 0x0502;
	enum OUT_OF_MEMORY = 0x0505;
	enum CW = 0x0900;
	enum CCW = 0x0901;
	enum LINE_WIDTH = 0x0B21;
	enum ALIASED_POINT_SIZE_RANGE = 0x846D;
	enum ALIASED_LINE_WIDTH_RANGE = 0x846E;
	enum CULL_FACE_MODE = 0x0B45;
	enum FRONT_FACE = 0x0B46;
	enum DEPTH_RANGE = 0x0B70;
	enum DEPTH_WRITEMASK = 0x0B72;
	enum DEPTH_CLEAR_VALUE = 0x0B73;
	enum DEPTH_FUNC = 0x0B74;
	enum STENCIL_CLEAR_VALUE = 0x0B91;
	enum STENCIL_FUNC = 0x0B92;
	enum STENCIL_FAIL = 0x0B94;
	enum STENCIL_PASS_DEPTH_FAIL = 0x0B95;
	enum STENCIL_PASS_DEPTH_PASS = 0x0B96;
	enum STENCIL_REF = 0x0B97;
	enum STENCIL_VALUE_MASK = 0x0B93;
	enum STENCIL_WRITEMASK = 0x0B98;
	enum STENCIL_BACK_FUNC = 0x8800;
	enum STENCIL_BACK_FAIL = 0x8801;
	enum STENCIL_BACK_PASS_DEPTH_FAIL = 0x8802;
	enum STENCIL_BACK_PASS_DEPTH_PASS = 0x8803;
	enum STENCIL_BACK_REF = 0x8CA3;
	enum STENCIL_BACK_VALUE_MASK = 0x8CA4;
	enum STENCIL_BACK_WRITEMASK = 0x8CA5;
	enum VIEWPORT = 0x0BA2;
	enum SCISSOR_BOX = 0x0C10;
	enum COLOR_CLEAR_VALUE = 0x0C22;
	enum COLOR_WRITEMASK = 0x0C23;
	enum UNPACK_ALIGNMENT = 0x0CF5;
	enum PACK_ALIGNMENT = 0x0D05;
	enum MAX_TEXTURE_SIZE = 0x0D33;
	enum MAX_VIEWPORT_DIMS = 0x0D3A;
	enum SUBPIXEL_BITS = 0x0D50;
	enum RED_BITS = 0x0D52;
	enum GREEN_BITS = 0x0D53;
	enum BLUE_BITS = 0x0D54;
	enum ALPHA_BITS = 0x0D55;
	enum DEPTH_BITS = 0x0D56;
	enum STENCIL_BITS = 0x0D57;
	enum POLYGON_OFFSET_UNITS = 0x2A00;
	enum POLYGON_OFFSET_FACTOR = 0x8038;
	enum TEXTURE_BINDING_2D = 0x8069;
	enum SAMPLE_BUFFERS = 0x80A8;
	enum SAMPLES = 0x80A9;
	enum SAMPLE_COVERAGE_VALUE = 0x80AA;
	enum SAMPLE_COVERAGE_INVERT = 0x80AB;
	enum NUM_COMPRESSED_TEXTURE_FORMATS = 0x86A2;
	enum COMPRESSED_TEXTURE_FORMATS = 0x86A3;
	enum DONT_CARE = 0x1100;
	enum FASTEST = 0x1101;
	enum NICEST = 0x1102;
	enum GENERATE_MIPMAP_HINT = 0x8192;
	enum BYTE = 0x1400;
	enum UNSIGNED_BYTE = 0x1401;
	enum SHORT = 0x1402;
	enum UNSIGNED_SHORT = 0x1403;
	enum INT = 0x1404;
	enum UNSIGNED_INT = 0x1405;
	enum FLOAT = 0x1406;
	enum FIXED = 0x140C;
	enum DEPTH_COMPONENT = 0x1902;
	enum ALPHA = 0x1906;
	enum RGB = 0x1907;
	enum RGBA = 0x1908;
	enum LUMINANCE = 0x1909;
	enum LUMINANCE_ALPHA = 0x190A;
	enum UNSIGNED_SHORT_4_4_4_4 = 0x8033;
	enum UNSIGNED_SHORT_5_5_5_1 = 0x8034;
	enum UNSIGNED_SHORT_5_6_5 = 0x8363;
	enum FRAGMENT_SHADER = 0x8B30;
	enum VERTEX_SHADER = 0x8B31;
	enum MAX_VERTEX_ATTRIBS = 0x8869;
	enum MAX_VERTEX_UNIFORM_VECTORS = 0x8DFB;
	enum MAX_VARYING_VECTORS = 0x8DFC;
	enum MAX_COMBINED_TEXTURE_IMAGE_UNITS = 0x8B4D;
	enum MAX_VERTEX_TEXTURE_IMAGE_UNITS = 0x8B4C;
	enum MAX_TEXTURE_IMAGE_UNITS = 0x8872;
	enum MAX_FRAGMENT_UNIFORM_VECTORS = 0x8DFD;
	enum SHADER_TYPE = 0x8B4F;
	enum DELETE_STATUS = 0x8B80;
	enum LINK_STATUS = 0x8B82;
	enum VALIDATE_STATUS = 0x8B83;
	enum ATTACHED_SHADERS = 0x8B85;
	enum ACTIVE_UNIFORMS = 0x8B86;
	enum ACTIVE_UNIFORM_MAX_LENGTH = 0x8B87;
	enum ACTIVE_ATTRIBUTES = 0x8B89;
	enum ACTIVE_ATTRIBUTE_MAX_LENGTH = 0x8B8A;
	enum SHADING_LANGUAGE_VERSION = 0x8B8C;
	enum CURRENT_PROGRAM = 0x8B8D;
	enum NEVER = 0x0200;
	enum LESS = 0x0201;
	enum EQUAL = 0x0202;
	enum LEQUAL = 0x0203;
	enum GREATER = 0x0204;
	enum NOTEQUAL = 0x0205;
	enum GEQUAL = 0x0206;
	enum ALWAYS = 0x0207;
	enum KEEP = 0x1E00;
	enum REPLACE = 0x1E01;
	enum INCR = 0x1E02;
	enum DECR = 0x1E03;
	enum INVERT = 0x150A;
	enum INCR_WRAP = 0x8507;
	enum DECR_WRAP = 0x8508;
	enum VENDOR = 0x1F00;
	enum RENDERER = 0x1F01;
	enum VERSION = 0x1F02;
	enum EXTENSIONS = 0x1F03;
	enum NEAREST = 0x2600;
	enum LINEAR = 0x2601;
	enum NEAREST_MIPMAP_NEAREST = 0x2700;
	enum LINEAR_MIPMAP_NEAREST = 0x2701;
	enum NEAREST_MIPMAP_LINEAR = 0x2702;
	enum LINEAR_MIPMAP_LINEAR = 0x2703;
	enum TEXTURE_MAG_FILTER = 0x2800;
	enum TEXTURE_MIN_FILTER = 0x2801;
	enum TEXTURE_WRAP_S = 0x2802;
	enum TEXTURE_WRAP_T = 0x2803;
	enum TEXTURE = 0x1702;
	enum TEXTURE_CUBE_MAP = 0x8513;
	enum TEXTURE_BINDING_CUBE_MAP = 0x8514;
	enum TEXTURE_CUBE_MAP_POSITIVE_X = 0x8515;
	enum TEXTURE_CUBE_MAP_NEGATIVE_X = 0x8516;
	enum TEXTURE_CUBE_MAP_POSITIVE_Y = 0x8517;
	enum TEXTURE_CUBE_MAP_NEGATIVE_Y = 0x8518;
	enum TEXTURE_CUBE_MAP_POSITIVE_Z = 0x8519;
	enum TEXTURE_CUBE_MAP_NEGATIVE_Z = 0x851A;
	enum MAX_CUBE_MAP_TEXTURE_SIZE = 0x851C;
	enum TEXTURE0 = 0x84C0;
	enum TEXTURE1 = 0x84C1;
	enum TEXTURE2 = 0x84C2;
	enum TEXTURE3 = 0x84C3;
	enum TEXTURE4 = 0x84C4;
	enum TEXTURE5 = 0x84C5;
	enum TEXTURE6 = 0x84C6;
	enum TEXTURE7 = 0x84C7;
	enum TEXTURE8 = 0x84C8;
	enum TEXTURE9 = 0x84C9;
	enum TEXTURE10 = 0x84CA;
	enum TEXTURE11 = 0x84CB;
	enum TEXTURE12 = 0x84CC;
	enum TEXTURE13 = 0x84CD;
	enum TEXTURE14 = 0x84CE;
	enum TEXTURE15 = 0x84CF;
	enum TEXTURE16 = 0x84D0;
	enum TEXTURE17 = 0x84D1;
	enum TEXTURE18 = 0x84D2;
	enum TEXTURE19 = 0x84D3;
	enum TEXTURE20 = 0x84D4;
	enum TEXTURE21 = 0x84D5;
	enum TEXTURE22 = 0x84D6;
	enum TEXTURE23 = 0x84D7;
	enum TEXTURE24 = 0x84D8;
	enum TEXTURE25 = 0x84D9;
	enum TEXTURE26 = 0x84DA;
	enum TEXTURE27 = 0x84DB;
	enum TEXTURE28 = 0x84DC;
	enum TEXTURE29 = 0x84DD;
	enum TEXTURE30 = 0x84DE;
	enum TEXTURE31 = 0x84DF;
	enum ACTIVE_TEXTURE = 0x84E0;
	enum REPEAT = 0x2901;
	enum CLAMP_TO_EDGE = 0x812F;
	enum MIRRORED_REPEAT = 0x8370;
	enum FLOAT_VEC2 = 0x8B50;
	enum FLOAT_VEC3 = 0x8B51;
	enum FLOAT_VEC4 = 0x8B52;
	enum INT_VEC2 = 0x8B53;
	enum INT_VEC3 = 0x8B54;
	enum INT_VEC4 = 0x8B55;
	enum BOOL = 0x8B56;
	enum BOOL_VEC2 = 0x8B57;
	enum BOOL_VEC3 = 0x8B58;
	enum BOOL_VEC4 = 0x8B59;
	enum FLOAT_MAT2 = 0x8B5A;
	enum FLOAT_MAT3 = 0x8B5B;
	enum FLOAT_MAT4 = 0x8B5C;
	enum SAMPLER_2D = 0x8B5E;
	enum SAMPLER_CUBE = 0x8B60;
	enum VERTEX_ATTRIB_ARRAY_ENABLED = 0x8622;
	enum VERTEX_ATTRIB_ARRAY_SIZE = 0x8623;
	enum VERTEX_ATTRIB_ARRAY_STRIDE = 0x8624;
	enum VERTEX_ATTRIB_ARRAY_TYPE = 0x8625;
	enum VERTEX_ATTRIB_ARRAY_NORMALIZED = 0x886A;
	enum VERTEX_ATTRIB_ARRAY_POINTER = 0x8645;
	enum VERTEX_ATTRIB_ARRAY_BUFFER_BINDING = 0x889F;
	enum IMPLEMENTATION_COLOR_READ_TYPE = 0x8B9A;
	enum IMPLEMENTATION_COLOR_READ_FORMAT = 0x8B9B;
	enum COMPILE_STATUS = 0x8B81;
	enum INFO_LOG_LENGTH = 0x8B84;
	enum SHADER_SOURCE_LENGTH = 0x8B88;
	enum SHADER_COMPILER = 0x8DFA;
	enum SHADER_BINARY_FORMATS = 0x8DF8;
	enum NUM_SHADER_BINARY_FORMATS = 0x8DF9;
	enum LOW_FLOAT = 0x8DF0;
	enum MEDIUM_FLOAT = 0x8DF1;
	enum HIGH_FLOAT = 0x8DF2;
	enum LOW_INT = 0x8DF3;
	enum MEDIUM_INT = 0x8DF4;
	enum HIGH_INT = 0x8DF5;
	enum FRAMEBUFFER = 0x8D40;
	enum RENDERBUFFER = 0x8D41;
	enum RGBA4 = 0x8056;
	enum RGB5_A1 = 0x8057;
	enum RGB565 = 0x8D62;
	enum DEPTH_COMPONENT16 = 0x81A5;
	enum STENCIL_INDEX8 = 0x8D48;
	enum RENDERBUFFER_WIDTH = 0x8D42;
	enum RENDERBUFFER_HEIGHT = 0x8D43;
	enum RENDERBUFFER_INTERNAL_FORMAT = 0x8D44;
	enum RENDERBUFFER_RED_SIZE = 0x8D50;
	enum RENDERBUFFER_GREEN_SIZE = 0x8D51;
	enum RENDERBUFFER_BLUE_SIZE = 0x8D52;
	enum RENDERBUFFER_ALPHA_SIZE = 0x8D53;
	enum RENDERBUFFER_DEPTH_SIZE = 0x8D54;
	enum RENDERBUFFER_STENCIL_SIZE = 0x8D55;
	enum FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE = 0x8CD0;
	enum FRAMEBUFFER_ATTACHMENT_OBJECT_NAME = 0x8CD1;
	enum FRAMEBUFFER_ATTACHMENT_TEXTURE_LEVEL = 0x8CD2;
	enum FRAMEBUFFER_ATTACHMENT_TEXTURE_CUBE_MAP_FACE = 0x8CD3;
	enum COLOR_ATTACHMENT0 = 0x8CE0;
	enum DEPTH_ATTACHMENT = 0x8D00;
	enum STENCIL_ATTACHMENT = 0x8D20;
	enum NONE = 0;
	enum FRAMEBUFFER_COMPLETE = 0x8CD5;
	enum FRAMEBUFFER_INCOMPLETE_ATTACHMENT = 0x8CD6;
	enum FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT = 0x8CD7;
	enum FRAMEBUFFER_INCOMPLETE_DIMENSIONS = 0x8CD9;
	enum FRAMEBUFFER_UNSUPPORTED = 0x8CDD;
	enum FRAMEBUFFER_BINDING = 0x8CA6;
	enum RENDERBUFFER_BINDING = 0x8CA7;
	enum MAX_RENDERBUFFER_SIZE = 0x84E8;
	enum INVALID_FRAMEBUFFER_OPERATION = 0x0506;

	void activeTexture(Enum texture);
	void attachShader(UInt program, UInt shader);
	void bindAttribLocation(UInt program, UInt index, const(Char)* name);
	void bindBuffer(Enum target, UInt buffer);
	void bindFramebuffer(Enum target, UInt framebuffer);
	void bindRenderbuffer(Enum target, UInt renderbuffer);
	void bindTexture(Enum target, UInt texture);
	void blendColor(Float red, Float green, Float blue, Float alpha);
	void blendEquation(Enum mode);
	void blendEquationSeparate(Enum modeRGB, Enum modeAlpha);
	void blendFunc(Enum sfactor, Enum dfactor);
	void blendFuncSeparate(Enum sfactorRGB, Enum dfactorRGB, Enum sfactorAlpha, Enum dfactorAlpha);
	void bufferData(Enum target, Sizeiptr size, const(void)* data, Enum usage);
	void bufferSubData(Enum target, Intptr offset, Sizeiptr size, const(void)* data);
	Enum checkFramebufferStatus(Enum target);
	void clear(Bitfield mask);
	void clearColor(Float red, Float green, Float blue, Float alpha);
	void clearDepthf(Float d);
	void clearStencil(Int s);
	void colorMask(Boolean red, Boolean green, Boolean blue, Boolean alpha);
	void compileShader(UInt shader);
	void compressedTexImage2D(Enum target, Int level, Enum internalformat, Sizei width, Sizei height, Int border, Sizei imageSize, const(void)* data);
	void compressedTexSubImage2D(Enum target, Int level, Int xoffset, Int yoffset, Sizei width, Sizei height, Enum format, Sizei imageSize, const(void)* data);
	void copyTexImage2D(Enum target, Int level, Enum internalformat, Int x, Int y, Sizei width, Sizei height, Int border);
	void copyTexSubImage2D(Enum target, Int level, Int xoffset, Int yoffset, Int x, Int y, Sizei width, Sizei height);
	UInt createProgram();
	UInt createShader(Enum type);
	void cullFace(Enum mode);
	void deleteBuffers(Sizei n, const(UInt)* buffers);
	void deleteFramebuffers(Sizei n, const(UInt)* framebuffers);
	void deleteProgram(UInt program);
	void deleteRenderbuffers(Sizei n, const(UInt)* renderbuffers);
	void deleteShader(UInt shader);
	void deleteTextures(Sizei n, const(UInt)* textures);
	void depthFunc(Enum func);
	void depthMask(Boolean flag);
	void depthRangef(Float n, Float f);
	void detachShader(UInt program, UInt shader);
	void disable(Enum cap);
	void disableVertexAttribArray(UInt index);
	void drawArrays(Enum mode, Int first, Sizei count);
	void drawElements(Enum mode, Sizei count, Enum type, const(void)* indices);
	void enable(Enum cap);
	void enableVertexAttribArray(UInt index);
	void finish();
	void flush();
	void framebufferRenderbuffer(Enum target, Enum attachment, Enum renderbuffertarget, UInt renderbuffer);
	void framebufferTexture2D(Enum target, Enum attachment, Enum textarget, UInt texture, Int level);
	void frontFace(Enum mode);
	void genBuffers(Sizei n, UInt* buffers);
	void generateMipmap(Enum target);
	void genFramebuffers(Sizei n, UInt* framebuffers);
	void genRenderbuffers(Sizei n, UInt* renderbuffers);
	void genTextures(Sizei n, UInt* textures);
	void getActiveAttrib(UInt program, UInt index, Sizei bufSize, Sizei* length, Int* size, Enum* type, Char* name);
	void getActiveUniform(UInt program, UInt index, Sizei bufSize, Sizei* length, Int* size, Enum* type, Char* name);
	void getAttachedShaders(UInt program, Sizei maxCount, Sizei* count, UInt* shaders);
	Int getAttribLocation(UInt program, const(Char)* name);
	void getBooleanv(Enum pname, Boolean* data);
	void getBufferParameteriv(Enum target, Enum pname, Int* params);
	Enum getError();
	void getFloatv(Enum pname, Float* data);
	void getFramebufferAttachmentParameteriv(Enum target, Enum attachment, Enum pname, Int* params);
	void getIntegerv(Enum pname, Int* data);
	void getProgramiv(UInt program, Enum pname, Int* params);
	void getProgramInfoLog(UInt program, Sizei bufSize, Sizei* length, Char* infoLog);
	void getRenderbufferParameteriv(Enum target, Enum pname, Int* params);
	void getShaderiv(UInt shader, Enum pname, Int* params);
	void getShaderInfoLog(UInt shader, Sizei bufSize, Sizei* length, Char* infoLog);
	void getShaderPrecisionFormat(Enum shadertype, Enum precisiontype, Int* range, Int* precision);
	void getShaderSource(UInt shader, Sizei bufSize, Sizei* length, Char* source);
	const(UByte)* getString(Enum name);
	void getTexParameterfv(Enum target, Enum pname, Float* params);
	void getTexParameteriv(Enum target, Enum pname, Int* params);
	void getUniformfv(UInt program, Int location, Float* params);
	void getUniformiv(UInt program, Int location, Int* params);
	Int getUniformLocation(UInt program, const(Char)* name);
	void getVertexAttribfv(UInt index, Enum pname, Float* params);
	void getVertexAttribiv(UInt index, Enum pname, Int* params);
	void getVertexAttribPointerv(UInt index, Enum pname, void** pointer);
	void hint(Enum target, Enum mode);
	Boolean isBuffer(UInt buffer);
	Boolean isEnabled(Enum cap);
	Boolean isFramebuffer(UInt framebuffer);
	Boolean isProgram(UInt program);
	Boolean isRenderbuffer(UInt renderbuffer);
	Boolean isShader(UInt shader);
	Boolean isTexture(UInt texture);
	void lineWidth(Float width);
	void linkProgram(UInt program);
	void pixelStorei(Enum pname, Int param);
	void polygonOffset(Float factor, Float units);
	void readPixels(Int x, Int y, Sizei width, Sizei height, Enum format, Enum type, void* pixels);
	void releaseShaderCompiler();
	void renderbufferStorage(Enum target, Enum internalformat, Sizei width, Sizei height);
	void sampleCoverage(Float value, Boolean invert);
	void scissor(Int x, Int y, Sizei width, Sizei height);
	void shaderBinary(Sizei count, const(UInt)* shaders, Enum binaryformat, const(void)* binary, Sizei length);
	void shaderSource(UInt shader, Sizei count, const(const(Char)*)* string_, const(Int)* length);
	void stencilFunc(Enum func, Int ref_, UInt mask);
	void stencilFuncSeparate(Enum face, Enum func, Int ref_, UInt mask);
	void stencilMask(UInt mask);
	void stencilMaskSeparate(Enum face, UInt mask);
	void stencilOp(Enum fail, Enum zfail, Enum zpass);
	void stencilOpSeparate(Enum face, Enum sfail, Enum dpfail, Enum dppass);
	void texImage2D(Enum target, Int level, Int internalformat, Sizei width, Sizei height, Int border, Enum format, Enum type, const(void)* pixels);
	void texParameterf(Enum target, Enum pname, Float param);
	void texParameterfv(Enum target, Enum pname, const(Float)* params);
	void texParameteri(Enum target, Enum pname, Int param);
	void texParameteriv(Enum target, Enum pname, const(Int)* params);
	void texSubImage2D(Enum target, Int level, Int xoffset, Int yoffset, Sizei width, Sizei height, Enum format, Enum type, const(void)* pixels);
	void uniform1f(Int location, Float v0);
	void uniform1fv(Int location, Sizei count, const(Float)* value);
	void uniform1i(Int location, Int v0);
	void uniform1iv(Int location, Sizei count, const(Int)* value);
	void uniform2f(Int location, Float v0, Float v1);
	void uniform2fv(Int location, Sizei count, const(Float)* value);
	void uniform2i(Int location, Int v0, Int v1);
	void uniform2iv(Int location, Sizei count, const(Int)* value);
	void uniform3f(Int location, Float v0, Float v1, Float v2);
	void uniform3fv(Int location, Sizei count, const(Float)* value);
	void uniform3i(Int location, Int v0, Int v1, Int v2);
	void uniform3iv(Int location, Sizei count, const(Int)* value);
	void uniform4f(Int location, Float v0, Float v1, Float v2, Float v3);
	void uniform4fv(Int location, Sizei count, const(Float)* value);
	void uniform4i(Int location, Int v0, Int v1, Int v2, Int v3);
	void uniform4iv(Int location, Sizei count, const(Int)* value);
	void uniformMatrix2fv(Int location, Sizei count, Boolean transpose, const(Float)* value);
	void uniformMatrix3fv(Int location, Sizei count, Boolean transpose, const(Float)* value);
	void uniformMatrix4fv(Int location, Sizei count, Boolean transpose, const(Float)* value);
	void useProgram(UInt program);
	void validateProgram(UInt program);
	void vertexAttrib1f(UInt index, Float x);
	void vertexAttrib1fv(UInt index, const(Float)* v);
	void vertexAttrib2f(UInt index, Float x, Float y);
	void vertexAttrib2fv(UInt index, const(Float)* v);
	void vertexAttrib3f(UInt index, Float x, Float y, Float z);
	void vertexAttrib3fv(UInt index, const(Float)* v);
	void vertexAttrib4f(UInt index, Float x, Float y, Float z, Float w);
	void vertexAttrib4fv(UInt index, const(Float)* v);
	void vertexAttribPointer(UInt index, Int size, Enum type, Boolean normalized, Sizei stride, const(void)* pointer);
	void viewport(Int x, Int y, Sizei width, Sizei height);

}
