module gd.bindings.gl;
import gd.bindings.loader;
import gd.resource;
import core.stdc.config;
import core.stdc.stddef;

private static GLLibrary m_GL;
GLLibrary GL() @property { // @suppress(dscanner.confusing.function_attributes)
	if (m_GL is null) {
		m_GL = loadGL;
		registerLibraryResource(m_GL);
	}

	return m_GL;
}

GLLibrary loadGL() {
	string[] libraries;

	version (Posix) {
		libraries = ["libGL.so.1", "libGL.so"];
	}
	else version (Windows) {
		libraries = ["OpenGL32.dll"];
	}
	else {
		assert(0, "unsupported platform");
	}

	return loadSharedLibrary!(GLLibrary, delegate(string name) {
		return "gl" ~ cast(char)(name[0] + 'A' - 'a') ~ name[1 .. $];
	}, "
		version (Windows) {
			import core.sys.windows.wingdi : wglGetProcAddress;
			void* sym = wglGetProcAddress(name);
			if (sym)
				return sym;
		}
	")(libraries);
}

abstract class GLLibrary : Resource {
extern (System) @nogc nothrow:
	// file '/usr/include/GL/gl.h'

	alias Enum = uint;
	alias Boolean = ubyte;
	alias Bitfield = uint;
	alias Void = void;
	alias Byte = byte;
	alias Short = short;
	alias Int = int;
	alias UByte = ubyte;
	alias UShort = ushort;
	alias UInt = uint;
	alias Sizei = int;
	alias Float = float;
	alias Clampf = float;
	alias Double = double;
	alias Clampd = double;

	enum FALSE = 0;
	enum TRUE = 1;

	enum BYTE = 0x1400;
	enum UNSIGNED_BYTE = 0x1401;
	enum SHORT = 0x1402;
	enum UNSIGNED_SHORT = 0x1403;
	enum INT = 0x1404;
	enum UNSIGNED_INT = 0x1405;
	enum FLOAT = 0x1406;
	enum GL_2_BYTES = 0x1407;
	enum GL_3_BYTES = 0x1408;
	enum GL_4_BYTES = 0x1409;
	enum DOUBLE = 0x140A;

	enum POINTS = 0x0000;
	enum LINES = 0x0001;
	enum LINE_LOOP = 0x0002;
	enum LINE_STRIP = 0x0003;
	enum TRIANGLES = 0x0004;
	enum TRIANGLE_STRIP = 0x0005;
	enum TRIANGLE_FAN = 0x0006;
	enum QUADS = 0x0007;
	enum QUAD_STRIP = 0x0008;
	enum POLYGON = 0x0009;

	enum VERTEX_ARRAY = 0x8074;
	enum NORMAL_ARRAY = 0x8075;
	enum COLOR_ARRAY = 0x8076;
	enum INDEX_ARRAY = 0x8077;
	enum TEXTURE_COORD_ARRAY = 0x8078;
	enum EDGE_FLAG_ARRAY = 0x8079;
	enum VERTEX_ARRAY_SIZE = 0x807A;
	enum VERTEX_ARRAY_TYPE = 0x807B;
	enum VERTEX_ARRAY_STRIDE = 0x807C;
	enum NORMAL_ARRAY_TYPE = 0x807E;
	enum NORMAL_ARRAY_STRIDE = 0x807F;
	enum COLOR_ARRAY_SIZE = 0x8081;
	enum COLOR_ARRAY_TYPE = 0x8082;
	enum COLOR_ARRAY_STRIDE = 0x8083;
	enum INDEX_ARRAY_TYPE = 0x8085;
	enum INDEX_ARRAY_STRIDE = 0x8086;
	enum TEXTURE_COORD_ARRAY_SIZE = 0x8088;
	enum TEXTURE_COORD_ARRAY_TYPE = 0x8089;
	enum TEXTURE_COORD_ARRAY_STRIDE = 0x808A;
	enum EDGE_FLAG_ARRAY_STRIDE = 0x808C;
	enum VERTEX_ARRAY_POINTER = 0x808E;
	enum NORMAL_ARRAY_POINTER = 0x808F;
	enum COLOR_ARRAY_POINTER = 0x8090;
	enum INDEX_ARRAY_POINTER = 0x8091;
	enum TEXTURE_COORD_ARRAY_POINTER = 0x8092;
	enum EDGE_FLAG_ARRAY_POINTER = 0x8093;
	enum V2F = 0x2A20;
	enum V3F = 0x2A21;
	enum C4UB_V2F = 0x2A22;
	enum C4UB_V3F = 0x2A23;
	enum C3F_V3F = 0x2A24;
	enum N3F_V3F = 0x2A25;
	enum C4F_N3F_V3F = 0x2A26;
	enum T2F_V3F = 0x2A27;
	enum T4F_V4F = 0x2A28;
	enum T2F_C4UB_V3F = 0x2A29;
	enum T2F_C3F_V3F = 0x2A2A;
	enum T2F_N3F_V3F = 0x2A2B;
	enum T2F_C4F_N3F_V3F = 0x2A2C;
	enum T4F_C4F_N3F_V4F = 0x2A2D;

	enum MATRIX_MODE = 0x0BA0;
	enum MODELVIEW = 0x1700;
	enum PROJECTION = 0x1701;
	enum TEXTURE = 0x1702;

	enum POINT_SMOOTH = 0x0B10;
	enum POINT_SIZE = 0x0B11;
	enum POINT_SIZE_GRANULARITY = 0x0B13;
	enum POINT_SIZE_RANGE = 0x0B12;

	enum LINE_SMOOTH = 0x0B20;
	enum LINE_STIPPLE = 0x0B24;
	enum LINE_STIPPLE_PATTERN = 0x0B25;
	enum LINE_STIPPLE_REPEAT = 0x0B26;
	enum LINE_WIDTH = 0x0B21;
	enum LINE_WIDTH_GRANULARITY = 0x0B23;
	enum LINE_WIDTH_RANGE = 0x0B22;

	enum POINT = 0x1B00;
	enum LINE = 0x1B01;
	enum FILL = 0x1B02;
	enum CW = 0x0900;
	enum CCW = 0x0901;
	enum FRONT = 0x0404;
	enum BACK = 0x0405;
	enum POLYGON_MODE = 0x0B40;
	enum POLYGON_SMOOTH = 0x0B41;
	enum POLYGON_STIPPLE = 0x0B42;
	enum EDGE_FLAG = 0x0B43;
	enum CULL_FACE = 0x0B44;
	enum CULL_FACE_MODE = 0x0B45;
	enum FRONT_FACE = 0x0B46;
	enum POLYGON_OFFSET_FACTOR = 0x8038;
	enum POLYGON_OFFSET_UNITS = 0x2A00;
	enum POLYGON_OFFSET_POINT = 0x2A01;
	enum POLYGON_OFFSET_LINE = 0x2A02;
	enum POLYGON_OFFSET_FILL = 0x8037;

	enum COMPILE = 0x1300;
	enum COMPILE_AND_EXECUTE = 0x1301;
	enum LIST_BASE = 0x0B32;
	enum LIST_INDEX = 0x0B33;
	enum LIST_MODE = 0x0B30;

	enum NEVER = 0x0200;
	enum LESS = 0x0201;
	enum EQUAL = 0x0202;
	enum LEQUAL = 0x0203;
	enum GREATER = 0x0204;
	enum NOTEQUAL = 0x0205;
	enum GEQUAL = 0x0206;
	enum ALWAYS = 0x0207;
	enum DEPTH_TEST = 0x0B71;
	enum DEPTH_BITS = 0x0D56;
	enum DEPTH_CLEAR_VALUE = 0x0B73;
	enum DEPTH_FUNC = 0x0B74;
	enum DEPTH_RANGE = 0x0B70;
	enum DEPTH_WRITEMASK = 0x0B72;
	enum DEPTH_COMPONENT = 0x1902;

	enum LIGHTING = 0x0B50;
	enum LIGHT0 = 0x4000;
	enum LIGHT1 = 0x4001;
	enum LIGHT2 = 0x4002;
	enum LIGHT3 = 0x4003;
	enum LIGHT4 = 0x4004;
	enum LIGHT5 = 0x4005;
	enum LIGHT6 = 0x4006;
	enum LIGHT7 = 0x4007;
	enum SPOT_EXPONENT = 0x1205;
	enum SPOT_CUTOFF = 0x1206;
	enum CONSTANT_ATTENUATION = 0x1207;
	enum LINEAR_ATTENUATION = 0x1208;
	enum QUADRATIC_ATTENUATION = 0x1209;
	enum AMBIENT = 0x1200;
	enum DIFFUSE = 0x1201;
	enum SPECULAR = 0x1202;
	enum SHININESS = 0x1601;
	enum EMISSION = 0x1600;
	enum POSITION = 0x1203;
	enum SPOT_DIRECTION = 0x1204;
	enum AMBIENT_AND_DIFFUSE = 0x1602;
	enum COLOR_INDEXES = 0x1603;
	enum LIGHT_MODEL_TWO_SIDE = 0x0B52;
	enum LIGHT_MODEL_LOCAL_VIEWER = 0x0B51;
	enum LIGHT_MODEL_AMBIENT = 0x0B53;
	enum FRONT_AND_BACK = 0x0408;
	enum SHADE_MODEL = 0x0B54;
	enum FLAT = 0x1D00;
	enum SMOOTH = 0x1D01;
	enum COLOR_MATERIAL = 0x0B57;
	enum COLOR_MATERIAL_FACE = 0x0B55;
	enum COLOR_MATERIAL_PARAMETER = 0x0B56;
	enum NORMALIZE = 0x0BA1;

	enum CLIP_PLANE0 = 0x3000;
	enum CLIP_PLANE1 = 0x3001;
	enum CLIP_PLANE2 = 0x3002;
	enum CLIP_PLANE3 = 0x3003;
	enum CLIP_PLANE4 = 0x3004;
	enum CLIP_PLANE5 = 0x3005;

	enum ACCUM_RED_BITS = 0x0D58;
	enum ACCUM_GREEN_BITS = 0x0D59;
	enum ACCUM_BLUE_BITS = 0x0D5A;
	enum ACCUM_ALPHA_BITS = 0x0D5B;
	enum ACCUM_CLEAR_VALUE = 0x0B80;
	enum ACCUM = 0x0100;
	enum ADD = 0x0104;
	enum LOAD = 0x0101;
	enum MULT = 0x0103;
	enum RETURN = 0x0102;

	enum ALPHA_TEST = 0x0BC0;
	enum ALPHA_TEST_REF = 0x0BC2;
	enum ALPHA_TEST_FUNC = 0x0BC1;

	enum BLEND = 0x0BE2;
	enum BLEND_SRC = 0x0BE1;
	enum BLEND_DST = 0x0BE0;
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

	enum FEEDBACK = 0x1C01;
	enum RENDER = 0x1C00;
	enum SELECT = 0x1C02;

	enum GL_2D = 0x0600;
	enum GL_3D = 0x0601;
	enum GL_3D_COLOR = 0x0602;
	enum GL_3D_COLOR_TEXTURE = 0x0603;
	enum GL_4D_COLOR_TEXTURE = 0x0604;
	enum POINT_TOKEN = 0x0701;
	enum LINE_TOKEN = 0x0702;
	enum LINE_RESET_TOKEN = 0x0707;
	enum POLYGON_TOKEN = 0x0703;
	enum BITMAP_TOKEN = 0x0704;
	enum DRAW_PIXEL_TOKEN = 0x0705;
	enum COPY_PIXEL_TOKEN = 0x0706;
	enum PASS_THROUGH_TOKEN = 0x0700;
	enum FEEDBACK_BUFFER_POINTER = 0x0DF0;
	enum FEEDBACK_BUFFER_SIZE = 0x0DF1;
	enum FEEDBACK_BUFFER_TYPE = 0x0DF2;

	enum SELECTION_BUFFER_POINTER = 0x0DF3;
	enum SELECTION_BUFFER_SIZE = 0x0DF4;

	enum FOG = 0x0B60;
	enum FOG_MODE = 0x0B65;
	enum FOG_DENSITY = 0x0B62;
	enum FOG_COLOR = 0x0B66;
	enum FOG_INDEX = 0x0B61;
	enum FOG_START = 0x0B63;
	enum FOG_END = 0x0B64;
	enum LINEAR = 0x2601;
	enum EXP = 0x0800;
	enum EXP2 = 0x0801;

	enum LOGIC_OP = 0x0BF1;
	enum INDEX_LOGIC_OP = 0x0BF1;
	enum COLOR_LOGIC_OP = 0x0BF2;
	enum LOGIC_OP_MODE = 0x0BF0;
	enum CLEAR = 0x1500;
	enum SET = 0x150F;
	enum COPY = 0x1503;
	enum COPY_INVERTED = 0x150C;
	enum NOOP = 0x1505;
	enum INVERT = 0x150A;
	enum AND = 0x1501;
	enum NAND = 0x150E;
	enum OR = 0x1507;
	enum NOR = 0x1508;
	enum XOR = 0x1506;
	enum EQUIV = 0x1509;
	enum AND_REVERSE = 0x1502;
	enum AND_INVERTED = 0x1504;
	enum OR_REVERSE = 0x150B;
	enum OR_INVERTED = 0x150D;

	enum STENCIL_BITS = 0x0D57;
	enum STENCIL_TEST = 0x0B90;
	enum STENCIL_CLEAR_VALUE = 0x0B91;
	enum STENCIL_FUNC = 0x0B92;
	enum STENCIL_VALUE_MASK = 0x0B93;
	enum STENCIL_FAIL = 0x0B94;
	enum STENCIL_PASS_DEPTH_FAIL = 0x0B95;
	enum STENCIL_PASS_DEPTH_PASS = 0x0B96;
	enum STENCIL_REF = 0x0B97;
	enum STENCIL_WRITEMASK = 0x0B98;
	enum STENCIL_INDEX = 0x1901;
	enum KEEP = 0x1E00;
	enum REPLACE = 0x1E01;
	enum INCR = 0x1E02;
	enum DECR = 0x1E03;

	enum NONE = 0;
	enum LEFT = 0x0406;
	enum RIGHT = 0x0407;

	enum FRONT_LEFT = 0x0400;
	enum FRONT_RIGHT = 0x0401;
	enum BACK_LEFT = 0x0402;
	enum BACK_RIGHT = 0x0403;
	enum AUX0 = 0x0409;
	enum AUX1 = 0x040A;
	enum AUX2 = 0x040B;
	enum AUX3 = 0x040C;
	enum COLOR_INDEX = 0x1900;
	enum RED = 0x1903;
	enum GREEN = 0x1904;
	enum BLUE = 0x1905;
	enum ALPHA = 0x1906;
	enum LUMINANCE = 0x1909;
	enum LUMINANCE_ALPHA = 0x190A;
	enum ALPHA_BITS = 0x0D55;
	enum RED_BITS = 0x0D52;
	enum GREEN_BITS = 0x0D53;
	enum BLUE_BITS = 0x0D54;
	enum INDEX_BITS = 0x0D51;
	enum SUBPIXEL_BITS = 0x0D50;
	enum AUX_BUFFERS = 0x0C00;
	enum READ_BUFFER = 0x0C02;
	enum DRAW_BUFFER = 0x0C01;
	enum DOUBLEBUFFER = 0x0C32;
	enum STEREO = 0x0C33;
	enum BITMAP = 0x1A00;
	enum COLOR = 0x1800;
	enum DEPTH = 0x1801;
	enum STENCIL = 0x1802;
	enum DITHER = 0x0BD0;
	enum RGB = 0x1907;
	enum RGBA = 0x1908;

	enum MAX_LIST_NESTING = 0x0B31;
	enum MAX_EVAL_ORDER = 0x0D30;
	enum MAX_LIGHTS = 0x0D31;
	enum MAX_CLIP_PLANES = 0x0D32;
	enum MAX_TEXTURE_SIZE = 0x0D33;
	enum MAX_PIXEL_MAP_TABLE = 0x0D34;
	enum MAX_ATTRIB_STACK_DEPTH = 0x0D35;
	enum MAX_MODELVIEW_STACK_DEPTH = 0x0D36;
	enum MAX_NAME_STACK_DEPTH = 0x0D37;
	enum MAX_PROJECTION_STACK_DEPTH = 0x0D38;
	enum MAX_TEXTURE_STACK_DEPTH = 0x0D39;
	enum MAX_VIEWPORT_DIMS = 0x0D3A;
	enum MAX_CLIENT_ATTRIB_STACK_DEPTH = 0x0D3B;

	enum ATTRIB_STACK_DEPTH = 0x0BB0;
	enum CLIENT_ATTRIB_STACK_DEPTH = 0x0BB1;
	enum COLOR_CLEAR_VALUE = 0x0C22;
	enum COLOR_WRITEMASK = 0x0C23;
	enum CURRENT_INDEX = 0x0B01;
	enum CURRENT_COLOR = 0x0B00;
	enum CURRENT_NORMAL = 0x0B02;
	enum CURRENT_RASTER_COLOR = 0x0B04;
	enum CURRENT_RASTER_DISTANCE = 0x0B09;
	enum CURRENT_RASTER_INDEX = 0x0B05;
	enum CURRENT_RASTER_POSITION = 0x0B07;
	enum CURRENT_RASTER_TEXTURE_COORDS = 0x0B06;
	enum CURRENT_RASTER_POSITION_VALID = 0x0B08;
	enum CURRENT_TEXTURE_COORDS = 0x0B03;
	enum INDEX_CLEAR_VALUE = 0x0C20;
	enum INDEX_MODE = 0x0C30;
	enum INDEX_WRITEMASK = 0x0C21;
	enum MODELVIEW_MATRIX = 0x0BA6;
	enum MODELVIEW_STACK_DEPTH = 0x0BA3;
	enum NAME_STACK_DEPTH = 0x0D70;
	enum PROJECTION_MATRIX = 0x0BA7;
	enum PROJECTION_STACK_DEPTH = 0x0BA4;
	enum RENDER_MODE = 0x0C40;
	enum RGBA_MODE = 0x0C31;
	enum TEXTURE_MATRIX = 0x0BA8;
	enum TEXTURE_STACK_DEPTH = 0x0BA5;
	enum VIEWPORT = 0x0BA2;

	enum AUTO_NORMAL = 0x0D80;
	enum MAP1_COLOR_4 = 0x0D90;
	enum MAP1_INDEX = 0x0D91;
	enum MAP1_NORMAL = 0x0D92;
	enum MAP1_TEXTURE_COORD_1 = 0x0D93;
	enum MAP1_TEXTURE_COORD_2 = 0x0D94;
	enum MAP1_TEXTURE_COORD_3 = 0x0D95;
	enum MAP1_TEXTURE_COORD_4 = 0x0D96;
	enum MAP1_VERTEX_3 = 0x0D97;
	enum MAP1_VERTEX_4 = 0x0D98;
	enum MAP2_COLOR_4 = 0x0DB0;
	enum MAP2_INDEX = 0x0DB1;
	enum MAP2_NORMAL = 0x0DB2;
	enum MAP2_TEXTURE_COORD_1 = 0x0DB3;
	enum MAP2_TEXTURE_COORD_2 = 0x0DB4;
	enum MAP2_TEXTURE_COORD_3 = 0x0DB5;
	enum MAP2_TEXTURE_COORD_4 = 0x0DB6;
	enum MAP2_VERTEX_3 = 0x0DB7;
	enum MAP2_VERTEX_4 = 0x0DB8;
	enum MAP1_GRID_DOMAIN = 0x0DD0;
	enum MAP1_GRID_SEGMENTS = 0x0DD1;
	enum MAP2_GRID_DOMAIN = 0x0DD2;
	enum MAP2_GRID_SEGMENTS = 0x0DD3;
	enum COEFF = 0x0A00;
	enum ORDER = 0x0A01;
	enum DOMAIN = 0x0A02;

	enum PERSPECTIVE_CORRECTION_HINT = 0x0C50;
	enum POINT_SMOOTH_HINT = 0x0C51;
	enum LINE_SMOOTH_HINT = 0x0C52;
	enum POLYGON_SMOOTH_HINT = 0x0C53;
	enum FOG_HINT = 0x0C54;
	enum DONT_CARE = 0x1100;
	enum FASTEST = 0x1101;
	enum NICEST = 0x1102;

	enum SCISSOR_BOX = 0x0C10;
	enum SCISSOR_TEST = 0x0C11;

	enum MAP_COLOR = 0x0D10;
	enum MAP_STENCIL = 0x0D11;
	enum INDEX_SHIFT = 0x0D12;
	enum INDEX_OFFSET = 0x0D13;
	enum RED_SCALE = 0x0D14;
	enum RED_BIAS = 0x0D15;
	enum GREEN_SCALE = 0x0D18;
	enum GREEN_BIAS = 0x0D19;
	enum BLUE_SCALE = 0x0D1A;
	enum BLUE_BIAS = 0x0D1B;
	enum ALPHA_SCALE = 0x0D1C;
	enum ALPHA_BIAS = 0x0D1D;
	enum DEPTH_SCALE = 0x0D1E;
	enum DEPTH_BIAS = 0x0D1F;
	enum PIXEL_MAP_S_TO_S_SIZE = 0x0CB1;
	enum PIXEL_MAP_I_TO_I_SIZE = 0x0CB0;
	enum PIXEL_MAP_I_TO_R_SIZE = 0x0CB2;
	enum PIXEL_MAP_I_TO_G_SIZE = 0x0CB3;
	enum PIXEL_MAP_I_TO_B_SIZE = 0x0CB4;
	enum PIXEL_MAP_I_TO_A_SIZE = 0x0CB5;
	enum PIXEL_MAP_R_TO_R_SIZE = 0x0CB6;
	enum PIXEL_MAP_G_TO_G_SIZE = 0x0CB7;
	enum PIXEL_MAP_B_TO_B_SIZE = 0x0CB8;
	enum PIXEL_MAP_A_TO_A_SIZE = 0x0CB9;
	enum PIXEL_MAP_S_TO_S = 0x0C71;
	enum PIXEL_MAP_I_TO_I = 0x0C70;
	enum PIXEL_MAP_I_TO_R = 0x0C72;
	enum PIXEL_MAP_I_TO_G = 0x0C73;
	enum PIXEL_MAP_I_TO_B = 0x0C74;
	enum PIXEL_MAP_I_TO_A = 0x0C75;
	enum PIXEL_MAP_R_TO_R = 0x0C76;
	enum PIXEL_MAP_G_TO_G = 0x0C77;
	enum PIXEL_MAP_B_TO_B = 0x0C78;
	enum PIXEL_MAP_A_TO_A = 0x0C79;
	enum PACK_ALIGNMENT = 0x0D05;
	enum PACK_LSB_FIRST = 0x0D01;
	enum PACK_ROW_LENGTH = 0x0D02;
	enum PACK_SKIP_PIXELS = 0x0D04;
	enum PACK_SKIP_ROWS = 0x0D03;
	enum PACK_SWAP_BYTES = 0x0D00;
	enum UNPACK_ALIGNMENT = 0x0CF5;
	enum UNPACK_LSB_FIRST = 0x0CF1;
	enum UNPACK_ROW_LENGTH = 0x0CF2;
	enum UNPACK_SKIP_PIXELS = 0x0CF4;
	enum UNPACK_SKIP_ROWS = 0x0CF3;
	enum UNPACK_SWAP_BYTES = 0x0CF0;
	enum ZOOM_X = 0x0D16;
	enum ZOOM_Y = 0x0D17;

	enum TEXTURE_ENV = 0x2300;
	enum TEXTURE_ENV_MODE = 0x2200;
	enum TEXTURE_1D = 0x0DE0;
	enum TEXTURE_2D = 0x0DE1;
	enum TEXTURE_WRAP_S = 0x2802;
	enum TEXTURE_WRAP_T = 0x2803;
	enum TEXTURE_MAG_FILTER = 0x2800;
	enum TEXTURE_MIN_FILTER = 0x2801;
	enum TEXTURE_ENV_COLOR = 0x2201;
	enum TEXTURE_GEN_S = 0x0C60;
	enum TEXTURE_GEN_T = 0x0C61;
	enum TEXTURE_GEN_R = 0x0C62;
	enum TEXTURE_GEN_Q = 0x0C63;
	enum TEXTURE_GEN_MODE = 0x2500;
	enum TEXTURE_BORDER_COLOR = 0x1004;
	enum TEXTURE_WIDTH = 0x1000;
	enum TEXTURE_HEIGHT = 0x1001;
	enum TEXTURE_BORDER = 0x1005;
	enum TEXTURE_COMPONENTS = 0x1003;
	enum TEXTURE_RED_SIZE = 0x805C;
	enum TEXTURE_GREEN_SIZE = 0x805D;
	enum TEXTURE_BLUE_SIZE = 0x805E;
	enum TEXTURE_ALPHA_SIZE = 0x805F;
	enum TEXTURE_LUMINANCE_SIZE = 0x8060;
	enum TEXTURE_INTENSITY_SIZE = 0x8061;
	enum NEAREST_MIPMAP_NEAREST = 0x2700;
	enum NEAREST_MIPMAP_LINEAR = 0x2702;
	enum LINEAR_MIPMAP_NEAREST = 0x2701;
	enum LINEAR_MIPMAP_LINEAR = 0x2703;
	enum OBJECT_LINEAR = 0x2401;
	enum OBJECT_PLANE = 0x2501;
	enum EYE_LINEAR = 0x2400;
	enum EYE_PLANE = 0x2502;
	enum SPHERE_MAP = 0x2402;
	enum DECAL = 0x2101;
	enum MODULATE = 0x2100;
	enum NEAREST = 0x2600;
	enum REPEAT = 0x2901;
	enum CLAMP = 0x2900;
	enum S = 0x2000;
	enum T = 0x2001;
	enum R = 0x2002;
	enum Q = 0x2003;

	enum VENDOR = 0x1F00;
	enum RENDERER = 0x1F01;
	enum VERSION = 0x1F02;
	enum EXTENSIONS = 0x1F03;

	enum NO_ERROR = 0;
	enum INVALID_ENUM = 0x0500;
	enum INVALID_VALUE = 0x0501;
	enum INVALID_OPERATION = 0x0502;
	enum STACK_OVERFLOW = 0x0503;
	enum STACK_UNDERFLOW = 0x0504;
	enum OUT_OF_MEMORY = 0x0505;

	enum CURRENT_BIT = 0x00000001;
	enum POINT_BIT = 0x00000002;
	enum LINE_BIT = 0x00000004;
	enum POLYGON_BIT = 0x00000008;
	enum POLYGON_STIPPLE_BIT = 0x00000010;
	enum PIXEL_MODE_BIT = 0x00000020;
	enum LIGHTING_BIT = 0x00000040;
	enum FOG_BIT = 0x00000080;
	enum DEPTH_BUFFER_BIT = 0x00000100;
	enum ACCUM_BUFFER_BIT = 0x00000200;
	enum STENCIL_BUFFER_BIT = 0x00000400;
	enum VIEWPORT_BIT = 0x00000800;
	enum TRANSFORM_BIT = 0x00001000;
	enum ENABLE_BIT = 0x00002000;
	enum COLOR_BUFFER_BIT = 0x00004000;
	enum HINT_BIT = 0x00008000;
	enum EVAL_BIT = 0x00010000;
	enum LIST_BIT = 0x00020000;
	enum TEXTURE_BIT = 0x00040000;
	enum SCISSOR_BIT = 0x00080000;
	enum ALL_ATTRIB_BITS = 0xFFFFFFFF;

	enum PROXY_TEXTURE_1D = 0x8063;
	enum PROXY_TEXTURE_2D = 0x8064;
	enum TEXTURE_PRIORITY = 0x8066;
	enum TEXTURE_RESIDENT = 0x8067;
	enum TEXTURE_BINDING_1D = 0x8068;
	enum TEXTURE_BINDING_2D = 0x8069;
	enum TEXTURE_INTERNAL_FORMAT = 0x1003;
	enum ALPHA4 = 0x803B;
	enum ALPHA8 = 0x803C;
	enum ALPHA12 = 0x803D;
	enum ALPHA16 = 0x803E;
	enum LUMINANCE4 = 0x803F;
	enum LUMINANCE8 = 0x8040;
	enum LUMINANCE12 = 0x8041;
	enum LUMINANCE16 = 0x8042;
	enum LUMINANCE4_ALPHA4 = 0x8043;
	enum LUMINANCE6_ALPHA2 = 0x8044;
	enum LUMINANCE8_ALPHA8 = 0x8045;
	enum LUMINANCE12_ALPHA4 = 0x8046;
	enum LUMINANCE12_ALPHA12 = 0x8047;
	enum LUMINANCE16_ALPHA16 = 0x8048;
	enum INTENSITY = 0x8049;
	enum INTENSITY4 = 0x804A;
	enum INTENSITY8 = 0x804B;
	enum INTENSITY12 = 0x804C;
	enum INTENSITY16 = 0x804D;
	enum R3_G3_B2 = 0x2A10;
	enum RGB4 = 0x804F;
	enum RGB5 = 0x8050;
	enum RGB8 = 0x8051;
	enum RGB10 = 0x8052;
	enum RGB12 = 0x8053;
	enum RGB16 = 0x8054;
	enum RGBA2 = 0x8055;
	enum RGBA4 = 0x8056;
	enum RGB5_A1 = 0x8057;
	enum RGBA8 = 0x8058;
	enum RGB10_A2 = 0x8059;
	enum RGBA12 = 0x805A;
	enum RGBA16 = 0x805B;
	enum CLIENT_PIXEL_STORE_BIT = 0x00000001;
	enum CLIENT_VERTEX_ARRAY_BIT = 0x00000002;
	enum ALL_CLIENT_ATTRIB_BITS = 0xFFFFFFFF;
	enum CLIENT_ALL_ATTRIB_BITS = 0xFFFFFFFF;

	void clearIndex(Float c);

	void clearColor(Clampf red, Clampf green, Clampf blue, Clampf alpha);

	void clear(Bitfield mask);

	void indexMask(UInt mask);

	void colorMask(Boolean red, Boolean green, Boolean blue, Boolean alpha);

	void alphaFunc(Enum func, Clampf ref_);

	void blendFunc(Enum sfactor, Enum dfactor);

	void logicOp(Enum opcode);

	void cullFace(Enum mode);

	void frontFace(Enum mode);

	void pointSize(Float size);

	void lineWidth(Float width);

	void lineStipple(Int factor, UShort pattern);

	void polygonMode(Enum face, Enum mode);

	void polygonOffset(Float factor, Float units);

	void polygonStipple(const(UByte)* mask);

	void getPolygonStipple(UByte* mask);

	void edgeFlag(Boolean flag);

	void edgeFlagv(const(Boolean)* flag);

	void scissor(Int x, Int y, Sizei width, Sizei height);

	void clipPlane(Enum plane, const(Double)* equation);

	void getClipPlane(Enum plane, Double* equation);

	void drawBuffer(Enum mode);

	void readBuffer(Enum mode);

	void enable(Enum cap);

	void disable(Enum cap);

	Boolean isEnabled(Enum cap);

	void enableClientState(Enum cap);

	void disableClientState(Enum cap);

	void getBooleanv(Enum pname, Boolean* params);

	void getDoublev(Enum pname, Double* params);

	void getFloatv(Enum pname, Float* params);

	void getIntegerv(Enum pname, Int* params);

	void pushAttrib(Bitfield mask);

	void popAttrib();

	void pushClientAttrib(Bitfield mask);

	void popClientAttrib();

	Int renderMode(Enum mode);

	Enum getError();

	const(UByte)* getString(Enum name);

	void finish();

	void flush();

	void hint(Enum target, Enum mode);

	void clearDepth(Clampd depth);

	void depthFunc(Enum func);

	void depthMask(Boolean flag);

	void depthRange(Clampd near_val, Clampd far_val);

	void clearAccum(Float red, Float green, Float blue, Float alpha);

	void accum(Enum op, Float value);

	void matrixMode(Enum mode);

	void ortho(Double left, Double right, Double bottom, Double top,
			Double near_val, Double far_val);

	void frustum(Double left, Double right, Double bottom, Double top,
			Double near_val, Double far_val);

	void viewport(Int x, Int y, Sizei width, Sizei height);

	void pushMatrix();

	void popMatrix();

	void loadIdentity();

	void loadMatrixd(const(Double)* m);
	void loadMatrixf(const(Float)* m);

	void multMatrixd(const(Double)* m);
	void multMatrixf(const(Float)* m);

	void rotated(Double angle, Double x, Double y, Double z);
	void rotatef(Float angle, Float x, Float y, Float z);

	void scaled(Double x, Double y, Double z);
	void scalef(Float x, Float y, Float z);

	void translated(Double x, Double y, Double z);
	void translatef(Float x, Float y, Float z);

	Boolean isList(UInt list);

	void deleteLists(UInt list, Sizei range);

	UInt genLists(Sizei range);

	void newList(UInt list, Enum mode);

	void endList();

	void callList(UInt list);

	void callLists(Sizei n, Enum type, const(Void)* lists);

	void listBase(UInt base);

	void begin(Enum mode);

	void end();

	void vertex2d(Double x, Double y);
	void vertex2f(Float x, Float y);
	void vertex2i(Int x, Int y);
	void vertex2s(Short x, Short y);

	void vertex3d(Double x, Double y, Double z);
	void vertex3f(Float x, Float y, Float z);
	void vertex3i(Int x, Int y, Int z);
	void vertex3s(Short x, Short y, Short z);

	void vertex4d(Double x, Double y, Double z, Double w);
	void vertex4f(Float x, Float y, Float z, Float w);
	void vertex4i(Int x, Int y, Int z, Int w);
	void vertex4s(Short x, Short y, Short z, Short w);

	void vertex2dv(const(Double)* v);
	void vertex2fv(const(Float)* v);
	void vertex2iv(const(Int)* v);
	void vertex2sv(const(Short)* v);

	void vertex3dv(const(Double)* v);
	void vertex3fv(const(Float)* v);
	void vertex3iv(const(Int)* v);
	void vertex3sv(const(Short)* v);

	void vertex4dv(const(Double)* v);
	void vertex4fv(const(Float)* v);
	void vertex4iv(const(Int)* v);
	void vertex4sv(const(Short)* v);

	void normal3b(Byte nx, Byte ny, Byte nz);
	void normal3d(Double nx, Double ny, Double nz);
	void normal3f(Float nx, Float ny, Float nz);
	void normal3i(Int nx, Int ny, Int nz);
	void normal3s(Short nx, Short ny, Short nz);

	void normal3bv(const(Byte)* v);
	void normal3dv(const(Double)* v);
	void normal3fv(const(Float)* v);
	void normal3iv(const(Int)* v);
	void normal3sv(const(Short)* v);

	void indexd(Double c);
	void indexf(Float c);
	void indexi(Int c);
	void indexs(Short c);
	void indexub(UByte c);

	void indexdv(const(Double)* c);
	void indexfv(const(Float)* c);
	void indexiv(const(Int)* c);
	void indexsv(const(Short)* c);
	void indexubv(const(UByte)* c);

	void color3b(Byte red, Byte green, Byte blue);
	void color3d(Double red, Double green, Double blue);
	void color3f(Float red, Float green, Float blue);
	void color3i(Int red, Int green, Int blue);
	void color3s(Short red, Short green, Short blue);
	void color3Ub(UByte red, UByte green, UByte blue);
	void color3Ui(UInt red, UInt green, UInt blue);
	void color3Us(UShort red, UShort green, UShort blue);

	void color4b(Byte red, Byte green, Byte blue, Byte alpha);
	void color4d(Double red, Double green, Double blue, Double alpha);
	void color4f(Float red, Float green, Float blue, Float alpha);
	void color4i(Int red, Int green, Int blue, Int alpha);
	void color4s(Short red, Short green, Short blue, Short alpha);
	void color4Ub(UByte red, UByte green, UByte blue, UByte alpha);
	void color4Ui(UInt red, UInt green, UInt blue, UInt alpha);
	void color4Us(UShort red, UShort green, UShort blue, UShort alpha);

	void color3bv(const(Byte)* v);
	void color3dv(const(Double)* v);
	void color3fv(const(Float)* v);
	void color3iv(const(Int)* v);
	void color3sv(const(Short)* v);
	void color3Ubv(const(UByte)* v);
	void color3Uiv(const(UInt)* v);
	void color3Usv(const(UShort)* v);

	void color4bv(const(Byte)* v);
	void color4dv(const(Double)* v);
	void color4fv(const(Float)* v);
	void color4iv(const(Int)* v);
	void color4sv(const(Short)* v);
	void color4Ubv(const(UByte)* v);
	void color4Uiv(const(UInt)* v);
	void color4Usv(const(UShort)* v);

	void texCoord1d(Double s);
	void texCoord1f(Float s);
	void texCoord1i(Int s);
	void texCoord1s(Short s);

	void texCoord2d(Double s, Double t);
	void texCoord2f(Float s, Float t);
	void texCoord2i(Int s, Int t);
	void texCoord2s(Short s, Short t);

	void texCoord3d(Double s, Double t, Double r);
	void texCoord3f(Float s, Float t, Float r);
	void texCoord3i(Int s, Int t, Int r);
	void texCoord3s(Short s, Short t, Short r);

	void texCoord4d(Double s, Double t, Double r, Double q);
	void texCoord4f(Float s, Float t, Float r, Float q);
	void texCoord4i(Int s, Int t, Int r, Int q);
	void texCoord4s(Short s, Short t, Short r, Short q);

	void texCoord1dv(const(Double)* v);
	void texCoord1fv(const(Float)* v);
	void texCoord1iv(const(Int)* v);
	void texCoord1sv(const(Short)* v);

	void texCoord2dv(const(Double)* v);
	void texCoord2fv(const(Float)* v);
	void texCoord2iv(const(Int)* v);
	void texCoord2sv(const(Short)* v);

	void texCoord3dv(const(Double)* v);
	void texCoord3fv(const(Float)* v);
	void texCoord3iv(const(Int)* v);
	void texCoord3sv(const(Short)* v);

	void texCoord4dv(const(Double)* v);
	void texCoord4fv(const(Float)* v);
	void texCoord4iv(const(Int)* v);
	void texCoord4sv(const(Short)* v);

	void rasterPos2d(Double x, Double y);
	void rasterPos2f(Float x, Float y);
	void rasterPos2i(Int x, Int y);
	void rasterPos2s(Short x, Short y);

	void rasterPos3d(Double x, Double y, Double z);
	void rasterPos3f(Float x, Float y, Float z);
	void rasterPos3i(Int x, Int y, Int z);
	void rasterPos3s(Short x, Short y, Short z);

	void rasterPos4d(Double x, Double y, Double z, Double w);
	void rasterPos4f(Float x, Float y, Float z, Float w);
	void rasterPos4i(Int x, Int y, Int z, Int w);
	void rasterPos4s(Short x, Short y, Short z, Short w);

	void rasterPos2dv(const(Double)* v);
	void rasterPos2fv(const(Float)* v);
	void rasterPos2iv(const(Int)* v);
	void rasterPos2sv(const(Short)* v);

	void rasterPos3dv(const(Double)* v);
	void rasterPos3fv(const(Float)* v);
	void rasterPos3iv(const(Int)* v);
	void rasterPos3sv(const(Short)* v);

	void rasterPos4dv(const(Double)* v);
	void rasterPos4fv(const(Float)* v);
	void rasterPos4iv(const(Int)* v);
	void rasterPos4sv(const(Short)* v);

	void rectd(Double x1, Double y1, Double x2, Double y2);
	void rectf(Float x1, Float y1, Float x2, Float y2);
	void recti(Int x1, Int y1, Int x2, Int y2);
	void rects(Short x1, Short y1, Short x2, Short y2);

	void rectdv(const(Double)* v1, const(Double)* v2);
	void rectfv(const(Float)* v1, const(Float)* v2);
	void rectiv(const(Int)* v1, const(Int)* v2);
	void rectsv(const(Short)* v1, const(Short)* v2);

	void vertexPointer(Int size, Enum type, Sizei stride, const(Void)* ptr);

	void normalPointer(Enum type, Sizei stride, const(Void)* ptr);

	void colorPointer(Int size, Enum type, Sizei stride, const(Void)* ptr);

	void indexPointer(Enum type, Sizei stride, const(Void)* ptr);

	void texCoordPointer(Int size, Enum type, Sizei stride, const(Void)* ptr);

	void edgeFlagPointer(Sizei stride, const(Void)* ptr);

	void getPointerv(Enum pname, Void** params);

	void arrayElement(Int i);

	void drawArrays(Enum mode, Int first, Sizei count);

	void drawElements(Enum mode, Sizei count, Enum type, const(Void)* indices);

	void interleavedArrays(Enum format, Sizei stride, const(Void)* pointer);

	void shadeModel(Enum mode);

	void lightf(Enum light, Enum pname, Float param);
	void lighti(Enum light, Enum pname, Int param);
	void lightfv(Enum light, Enum pname, const(Float)* params);
	void lightiv(Enum light, Enum pname, const(Int)* params);

	void getLightfv(Enum light, Enum pname, Float* params);
	void getLightiv(Enum light, Enum pname, Int* params);

	void lightModelf(Enum pname, Float param);
	void lightModeli(Enum pname, Int param);
	void lightModelfv(Enum pname, const(Float)* params);
	void lightModeliv(Enum pname, const(Int)* params);

	void materialf(Enum face, Enum pname, Float param);
	void materiali(Enum face, Enum pname, Int param);
	void materialfv(Enum face, Enum pname, const(Float)* params);
	void materialiv(Enum face, Enum pname, const(Int)* params);

	void getMaterialfv(Enum face, Enum pname, Float* params);
	void getMaterialiv(Enum face, Enum pname, Int* params);

	void colorMaterial(Enum face, Enum mode);

	void pixelZoom(Float xfactor, Float yfactor);

	void pixelStoref(Enum pname, Float param);
	void pixelStorei(Enum pname, Int param);

	void pixelTransferf(Enum pname, Float param);
	void pixelTransferi(Enum pname, Int param);

	void pixelMapfv(Enum map, Sizei mapsize, const(Float)* values);
	void pixelMapuiv(Enum map, Sizei mapsize, const(UInt)* values);
	void pixelMapusv(Enum map, Sizei mapsize, const(UShort)* values);

	void getPixelMapfv(Enum map, Float* values);
	void getPixelMapuiv(Enum map, UInt* values);
	void getPixelMapusv(Enum map, UShort* values);

	void bitmap(Sizei width, Sizei height, Float xorig, Float yorig,
			Float xmove, Float ymove, const(UByte)* bitmap);

	void readPixels(Int x, Int y, Sizei width, Sizei height, Enum format,
			Enum type, Void* pixels);

	void drawPixels(Sizei width, Sizei height, Enum format, Enum type,
			const(Void)* pixels);

	void copyPixels(Int x, Int y, Sizei width, Sizei height, Enum type);

	void stencilFunc(Enum func, Int ref_, UInt mask);

	void stencilMask(UInt mask);

	void stencilOp(Enum fail, Enum zfail, Enum zpass);

	void clearStencil(Int s);

	void texGend(Enum coord, Enum pname, Double param);
	void texGenf(Enum coord, Enum pname, Float param);
	void texGeni(Enum coord, Enum pname, Int param);

	void texGendv(Enum coord, Enum pname, const(Double)* params);
	void texGenfv(Enum coord, Enum pname, const(Float)* params);
	void texGeniv(Enum coord, Enum pname, const(Int)* params);

	void getTexGendv(Enum coord, Enum pname, Double* params);
	void getTexGenfv(Enum coord, Enum pname, Float* params);
	void getTexGeniv(Enum coord, Enum pname, Int* params);

	void texEnvf(Enum target, Enum pname, Float param);
	void texEnvi(Enum target, Enum pname, Int param);

	void texEnvfv(Enum target, Enum pname, const(Float)* params);
	void texEnviv(Enum target, Enum pname, const(Int)* params);

	void getTexEnvfv(Enum target, Enum pname, Float* params);
	void getTexEnviv(Enum target, Enum pname, Int* params);

	void texParameterf(Enum target, Enum pname, Float param);
	void texParameteri(Enum target, Enum pname, Int param);

	void texParameterfv(Enum target, Enum pname, const(Float)* params);
	void texParameteriv(Enum target, Enum pname, const(Int)* params);

	void getTexParameterfv(Enum target, Enum pname, Float* params);
	void getTexParameteriv(Enum target, Enum pname, Int* params);

	void getTexLevelParameterfv(Enum target, Int level, Enum pname, Float* params);
	void getTexLevelParameteriv(Enum target, Int level, Enum pname, Int* params);

	void texImage1D(Enum target, Int level, Int internalFormat, Sizei width,
			Int border, Enum format, Enum type, const(Void)* pixels);

	void texImage2D(Enum target, Int level, Int internalFormat, Sizei width,
			Sizei height, Int border, Enum format, Enum type, const(Void)* pixels);

	void getTexImage(Enum target, Int level, Enum format, Enum type, Void* pixels);

	void genTextures(Sizei n, UInt* textures);

	void deleteTextures(Sizei n, const(UInt)* textures);

	void bindTexture(Enum target, UInt texture);

	void prioritizeTextures(Sizei n, const(UInt)* textures, const(Clampf)* priorities);

	Boolean areTexturesResident(Sizei n, const(UInt)* textures, Boolean* residences);

	Boolean isTexture(UInt texture);

	void texSubImage1D(Enum target, Int level, Int xoffset, Sizei width,
			Enum format, Enum type, const(Void)* pixels);

	void texSubImage2D(Enum target, Int level, Int xoffset, Int yoffset,
			Sizei width, Sizei height, Enum format, Enum type, const(Void)* pixels);

	void copyTexImage1D(Enum target, Int level, Enum internalformat, Int x,
			Int y, Sizei width, Int border);

	void copyTexImage2D(Enum target, Int level, Enum internalformat, Int x,
			Int y, Sizei width, Sizei height, Int border);

	void copyTexSubImage1D(Enum target, Int level, Int xoffset, Int x,
			Int y, Sizei width);

	void copyTexSubImage2D(Enum target, Int level, Int xoffset,
			Int yoffset, Int x, Int y, Sizei width, Sizei height);

	void map1d(Enum target, Double u1, Double u2, Int stride, Int order,
			const(Double)* points);
	void map1f(Enum target, Float u1, Float u2, Int stride, Int order,
			const(Float)* points);

	void map2d(Enum target, Double u1, Double u2, Int ustride, Int uorder,
			Double v1, Double v2, Int vstride, Int vorder, const(Double)* points);
	void map2f(Enum target, Float u1, Float u2, Int ustride, Int uorder,
			Float v1, Float v2, Int vstride, Int vorder, const(Float)* points);

	void getMapdv(Enum target, Enum query, Double* v);
	void getMapfv(Enum target, Enum query, Float* v);
	void getMapiv(Enum target, Enum query, Int* v);

	void evalCoord1d(Double u);
	void evalCoord1f(Float u);

	void evalCoord1dv(const(Double)* u);
	void evalCoord1fv(const(Float)* u);

	void evalCoord2d(Double u, Double v);
	void evalCoord2f(Float u, Float v);

	void evalCoord2dv(const(Double)* u);
	void evalCoord2fv(const(Float)* u);

	void mapGrid1d(Int un, Double u1, Double u2);
	void mapGrid1f(Int un, Float u1, Float u2);

	void mapGrid2d(Int un, Double u1, Double u2, Int vn, Double v1, Double v2);
	void mapGrid2f(Int un, Float u1, Float u2, Int vn, Float v1, Float v2);

	void evalPoint1(Int i);

	void evalPoint2(Int i, Int j);

	void evalMesh1(Enum mode, Int i1, Int i2);

	void evalMesh2(Enum mode, Int i1, Int i2, Int j1, Int j2);

	void fogf(Enum pname, Float param);

	void fogi(Enum pname, Int param);

	void fogfv(Enum pname, const(Float)* params);

	void fogiv(Enum pname, const(Int)* params);

	void feedbackBuffer(Sizei size, Enum type, Float* buffer);

	void passThrough(Float token);

	void selectBuffer(Sizei size, UInt* buffer);

	void initNames();

	void loadName(UInt name);

	void pushName(UInt name);

	void popName();

	enum RESCALE_NORMAL = 0x803A;
	enum CLAMP_TO_EDGE = 0x812F;
	enum MAX_ELEMENTS_VERTICES = 0x80E8;
	enum MAX_ELEMENTS_INDICES = 0x80E9;
	enum BGR = 0x80E0;
	enum BGRA = 0x80E1;
	enum UNSIGNED_BYTE_3_3_2 = 0x8032;
	enum UNSIGNED_BYTE_2_3_3_REV = 0x8362;
	enum UNSIGNED_SHORT_5_6_5 = 0x8363;
	enum UNSIGNED_SHORT_5_6_5_REV = 0x8364;
	enum UNSIGNED_SHORT_4_4_4_4 = 0x8033;
	enum UNSIGNED_SHORT_4_4_4_4_REV = 0x8365;
	enum UNSIGNED_SHORT_5_5_5_1 = 0x8034;
	enum UNSIGNED_SHORT_1_5_5_5_REV = 0x8366;
	enum UNSIGNED_INT_8_8_8_8 = 0x8035;
	enum UNSIGNED_INT_8_8_8_8_REV = 0x8367;
	enum UNSIGNED_INT_10_10_10_2 = 0x8036;
	enum UNSIGNED_INT_2_10_10_10_REV = 0x8368;
	enum LIGHT_MODEL_COLOR_CONTROL = 0x81F8;
	enum SINGLE_COLOR = 0x81F9;
	enum SEPARATE_SPECULAR_COLOR = 0x81FA;
	enum TEXTURE_MIN_LOD = 0x813A;
	enum TEXTURE_MAX_LOD = 0x813B;
	enum TEXTURE_BASE_LEVEL = 0x813C;
	enum TEXTURE_MAX_LEVEL = 0x813D;
	enum SMOOTH_POINT_SIZE_RANGE = 0x0B12;
	enum SMOOTH_POINT_SIZE_GRANULARITY = 0x0B13;
	enum SMOOTH_LINE_WIDTH_RANGE = 0x0B22;
	enum SMOOTH_LINE_WIDTH_GRANULARITY = 0x0B23;
	enum ALIASED_POINT_SIZE_RANGE = 0x846D;
	enum ALIASED_LINE_WIDTH_RANGE = 0x846E;
	enum PACK_SKIP_IMAGES = 0x806B;
	enum PACK_IMAGE_HEIGHT = 0x806C;
	enum UNPACK_SKIP_IMAGES = 0x806D;
	enum UNPACK_IMAGE_HEIGHT = 0x806E;
	enum TEXTURE_3D = 0x806F;
	enum PROXY_TEXTURE_3D = 0x8070;
	enum TEXTURE_DEPTH = 0x8071;
	enum TEXTURE_WRAP_R = 0x8072;
	enum MAX_3D_TEXTURE_SIZE = 0x8073;
	enum TEXTURE_BINDING_3D = 0x806A;

	void drawRangeElements(Enum mode, UInt start, UInt end, Sizei count,
			Enum type, const(Void)* indices);

	void texImage3D(Enum target, Int level, Int internalFormat, Sizei width,
			Sizei height, Sizei depth, Int border, Enum format,
			Enum type, const(Void)* pixels);

	void texSubImage3D(Enum target, Int level, Int xoffset, Int yoffset, Int zoffset,
			Sizei width, Sizei height, Sizei depth, Enum format,
			Enum type, const(Void)* pixels);

	void copyTexSubImage3D(Enum target, Int level, Int xoffset,
			Int yoffset, Int zoffset, Int x, Int y, Sizei width, Sizei height);

	enum CONSTANT_COLOR = 0x8001;
	enum ONE_MINUS_CONSTANT_COLOR = 0x8002;
	enum CONSTANT_ALPHA = 0x8003;
	enum ONE_MINUS_CONSTANT_ALPHA = 0x8004;
	enum COLOR_TABLE = 0x80D0;
	enum POST_CONVOLUTION_COLOR_TABLE = 0x80D1;
	enum POST_COLOR_MATRIX_COLOR_TABLE = 0x80D2;
	enum PROXY_COLOR_TABLE = 0x80D3;
	enum PROXY_POST_CONVOLUTION_COLOR_TABLE = 0x80D4;
	enum PROXY_POST_COLOR_MATRIX_COLOR_TABLE = 0x80D5;
	enum COLOR_TABLE_SCALE = 0x80D6;
	enum COLOR_TABLE_BIAS = 0x80D7;
	enum COLOR_TABLE_FORMAT = 0x80D8;
	enum COLOR_TABLE_WIDTH = 0x80D9;
	enum COLOR_TABLE_RED_SIZE = 0x80DA;
	enum COLOR_TABLE_GREEN_SIZE = 0x80DB;
	enum COLOR_TABLE_BLUE_SIZE = 0x80DC;
	enum COLOR_TABLE_ALPHA_SIZE = 0x80DD;
	enum COLOR_TABLE_LUMINANCE_SIZE = 0x80DE;
	enum COLOR_TABLE_INTENSITY_SIZE = 0x80DF;
	enum CONVOLUTION_1D = 0x8010;
	enum CONVOLUTION_2D = 0x8011;
	enum SEPARABLE_2D = 0x8012;
	enum CONVOLUTION_BORDER_MODE = 0x8013;
	enum CONVOLUTION_FILTER_SCALE = 0x8014;
	enum CONVOLUTION_FILTER_BIAS = 0x8015;
	enum REDUCE = 0x8016;
	enum CONVOLUTION_FORMAT = 0x8017;
	enum CONVOLUTION_WIDTH = 0x8018;
	enum CONVOLUTION_HEIGHT = 0x8019;
	enum MAX_CONVOLUTION_WIDTH = 0x801A;
	enum MAX_CONVOLUTION_HEIGHT = 0x801B;
	enum POST_CONVOLUTION_RED_SCALE = 0x801C;
	enum POST_CONVOLUTION_GREEN_SCALE = 0x801D;
	enum POST_CONVOLUTION_BLUE_SCALE = 0x801E;
	enum POST_CONVOLUTION_ALPHA_SCALE = 0x801F;
	enum POST_CONVOLUTION_RED_BIAS = 0x8020;
	enum POST_CONVOLUTION_GREEN_BIAS = 0x8021;
	enum POST_CONVOLUTION_BLUE_BIAS = 0x8022;
	enum POST_CONVOLUTION_ALPHA_BIAS = 0x8023;
	enum CONSTANT_BORDER = 0x8151;
	enum REPLICATE_BORDER = 0x8153;
	enum CONVOLUTION_BORDER_COLOR = 0x8154;
	enum COLOR_MATRIX = 0x80B1;
	enum COLOR_MATRIX_STACK_DEPTH = 0x80B2;
	enum MAX_COLOR_MATRIX_STACK_DEPTH = 0x80B3;
	enum POST_COLOR_MATRIX_RED_SCALE = 0x80B4;
	enum POST_COLOR_MATRIX_GREEN_SCALE = 0x80B5;
	enum POST_COLOR_MATRIX_BLUE_SCALE = 0x80B6;
	enum POST_COLOR_MATRIX_ALPHA_SCALE = 0x80B7;
	enum POST_COLOR_MATRIX_RED_BIAS = 0x80B8;
	enum POST_COLOR_MATRIX_GREEN_BIAS = 0x80B9;
	enum POST_COLOR_MATRIX_BLUE_BIAS = 0x80BA;
	enum POST_COLOR_MATRIX_ALPHA_BIAS = 0x80BB;
	enum HISTOGRAM = 0x8024;
	enum PROXY_HISTOGRAM = 0x8025;
	enum HISTOGRAM_WIDTH = 0x8026;
	enum HISTOGRAM_FORMAT = 0x8027;
	enum HISTOGRAM_RED_SIZE = 0x8028;
	enum HISTOGRAM_GREEN_SIZE = 0x8029;
	enum HISTOGRAM_BLUE_SIZE = 0x802A;
	enum HISTOGRAM_ALPHA_SIZE = 0x802B;
	enum HISTOGRAM_LUMINANCE_SIZE = 0x802C;
	enum HISTOGRAM_SINK = 0x802D;
	enum MINMAX = 0x802E;
	enum MINMAX_FORMAT = 0x802F;
	enum MINMAX_SINK = 0x8030;
	enum TABLE_TOO_LARGE = 0x8031;
	enum BLEND_EQUATION = 0x8009;
	enum MIN = 0x8007;
	enum MAX = 0x8008;
	enum FUNC_ADD = 0x8006;
	enum FUNC_SUBTRACT = 0x800A;
	enum FUNC_REVERSE_SUBTRACT = 0x800B;
	enum BLEND_COLOR = 0x8005;

	void colorTable(Enum target, Enum internalformat, Sizei width,
			Enum format, Enum type, const(Void)* table);

	void colorSubTable(Enum target, Sizei start, Sizei count, Enum format,
			Enum type, const(Void)* data);

	void colorTableParameteriv(Enum target, Enum pname, const(Int)* params);

	void colorTableParameterfv(Enum target, Enum pname, const(Float)* params);

	void copyColorSubTable(Enum target, Sizei start, Int x, Int y, Sizei width);

	void copyColorTable(Enum target, Enum internalformat, Int x, Int y, Sizei width);

	void getColorTable(Enum target, Enum format, Enum type, Void* table);

	void getColorTableParameterfv(Enum target, Enum pname, Float* params);

	void getColorTableParameteriv(Enum target, Enum pname, Int* params);

	void histogram(Enum target, Sizei width, Enum internalformat, Boolean sink);

	void resetHistogram(Enum target);

	void getHistogram(Enum target, Boolean reset, Enum format, Enum type, Void* values);

	void getHistogramParameterfv(Enum target, Enum pname, Float* params);

	void getHistogramParameteriv(Enum target, Enum pname, Int* params);

	void minmax(Enum target, Enum internalformat, Boolean sink);

	void resetMinmax(Enum target);

	void getMinmax(Enum target, Boolean reset, Enum format, Enum types, Void* values);

	void getMinmaxParameterfv(Enum target, Enum pname, Float* params);

	void getMinmaxParameteriv(Enum target, Enum pname, Int* params);

	void convolutionFilter1D(Enum target, Enum internalformat, Sizei width,
			Enum format, Enum type, const(Void)* image);

	void convolutionFilter2D(Enum target, Enum internalformat, Sizei width,
			Sizei height, Enum format, Enum type, const(Void)* image);

	void convolutionParameterf(Enum target, Enum pname, Float params);

	void convolutionParameterfv(Enum target, Enum pname, const(Float)* params);

	void convolutionParameteri(Enum target, Enum pname, Int params);

	void convolutionParameteriv(Enum target, Enum pname, const(Int)* params);

	void copyConvolutionFilter1D(Enum target, Enum internalformat, Int x,
			Int y, Sizei width);

	void copyConvolutionFilter2D(Enum target, Enum internalformat, Int x,
			Int y, Sizei width, Sizei height);

	void getConvolutionFilter(Enum target, Enum format, Enum type, Void* image);

	void getConvolutionParameterfv(Enum target, Enum pname, Float* params);

	void getConvolutionParameteriv(Enum target, Enum pname, Int* params);

	void separableFilter2D(Enum target, Enum internalformat, Sizei width,
			Sizei height, Enum format, Enum type, const(Void)* row, const(Void)* column);

	void getSeparableFilter(Enum target, Enum format, Enum type,
			Void* row, Void* column, Void* span);

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
	enum CLIENT_ACTIVE_TEXTURE = 0x84E1;
	enum MAX_TEXTURE_UNITS = 0x84E2;

	enum NORMAL_MAP = 0x8511;
	enum REFLECTION_MAP = 0x8512;
	enum TEXTURE_CUBE_MAP = 0x8513;
	enum TEXTURE_BINDING_CUBE_MAP = 0x8514;
	enum TEXTURE_CUBE_MAP_POSITIVE_X = 0x8515;
	enum TEXTURE_CUBE_MAP_NEGATIVE_X = 0x8516;
	enum TEXTURE_CUBE_MAP_POSITIVE_Y = 0x8517;
	enum TEXTURE_CUBE_MAP_NEGATIVE_Y = 0x8518;
	enum TEXTURE_CUBE_MAP_POSITIVE_Z = 0x8519;
	enum TEXTURE_CUBE_MAP_NEGATIVE_Z = 0x851A;
	enum PROXY_TEXTURE_CUBE_MAP = 0x851B;
	enum MAX_CUBE_MAP_TEXTURE_SIZE = 0x851C;

	enum COMPRESSED_ALPHA = 0x84E9;
	enum COMPRESSED_LUMINANCE = 0x84EA;
	enum COMPRESSED_LUMINANCE_ALPHA = 0x84EB;
	enum COMPRESSED_INTENSITY = 0x84EC;
	enum COMPRESSED_RGB = 0x84ED;
	enum COMPRESSED_RGBA = 0x84EE;
	enum TEXTURE_COMPRESSION_HINT = 0x84EF;
	enum TEXTURE_COMPRESSED_IMAGE_SIZE = 0x86A0;
	enum TEXTURE_COMPRESSED = 0x86A1;
	enum NUM_COMPRESSED_TEXTURE_FORMATS = 0x86A2;
	enum COMPRESSED_TEXTURE_FORMATS = 0x86A3;

	enum MULTISAMPLE = 0x809D;
	enum SAMPLE_ALPHA_TO_COVERAGE = 0x809E;
	enum SAMPLE_ALPHA_TO_ONE = 0x809F;
	enum SAMPLE_COVERAGE = 0x80A0;
	enum SAMPLE_BUFFERS = 0x80A8;
	enum SAMPLES = 0x80A9;
	enum SAMPLE_COVERAGE_VALUE = 0x80AA;
	enum SAMPLE_COVERAGE_INVERT = 0x80AB;
	enum MULTISAMPLE_BIT = 0x20000000;

	enum TRANSPOSE_MODELVIEW_MATRIX = 0x84E3;
	enum TRANSPOSE_PROJECTION_MATRIX = 0x84E4;
	enum TRANSPOSE_TEXTURE_MATRIX = 0x84E5;
	enum TRANSPOSE_COLOR_MATRIX = 0x84E6;

	enum COMBINE = 0x8570;
	enum COMBINE_RGB = 0x8571;
	enum COMBINE_ALPHA = 0x8572;
	enum SOURCE0_RGB = 0x8580;
	enum SOURCE1_RGB = 0x8581;
	enum SOURCE2_RGB = 0x8582;
	enum SOURCE0_ALPHA = 0x8588;
	enum SOURCE1_ALPHA = 0x8589;
	enum SOURCE2_ALPHA = 0x858A;
	enum OPERAND0_RGB = 0x8590;
	enum OPERAND1_RGB = 0x8591;
	enum OPERAND2_RGB = 0x8592;
	enum OPERAND0_ALPHA = 0x8598;
	enum OPERAND1_ALPHA = 0x8599;
	enum OPERAND2_ALPHA = 0x859A;
	enum RGB_SCALE = 0x8573;
	enum ADD_SIGNED = 0x8574;
	enum INTERPOLATE = 0x8575;
	enum SUBTRACT = 0x84E7;
	enum CONSTANT = 0x8576;
	enum PRIMARY_COLOR = 0x8577;
	enum PREVIOUS = 0x8578;

	enum DOT3_RGB = 0x86AE;
	enum DOT3_RGBA = 0x86AF;

	enum CLAMP_TO_BORDER = 0x812D;

	void activeTexture(Enum texture);

	void clientActiveTexture(Enum texture);

	void compressedTexImage1D(Enum target, Int level, Enum internalformat,
			Sizei width, Int border, Sizei imageSize, const(Void)* data);

	void compressedTexImage2D(Enum target, Int level, Enum internalformat,
			Sizei width, Sizei height, Int border, Sizei imageSize, const(Void)* data);

	void compressedTexImage3D(Enum target, Int level, Enum internalformat, Sizei width,
			Sizei height, Sizei depth, Int border, Sizei imageSize, const(Void)* data);

	void compressedTexSubImage1D(Enum target, Int level, Int xoffset,
			Sizei width, Enum format, Sizei imageSize, const(Void)* data);

	void compressedTexSubImage2D(Enum target, Int level, Int xoffset, Int yoffset,
			Sizei width, Sizei height, Enum format, Sizei imageSize, const(Void)* data);

	void compressedTexSubImage3D(Enum target, Int level, Int xoffset, Int yoffset, Int zoffset,
			Sizei width, Sizei height, Sizei depth, Enum format,
			Sizei imageSize, const(Void)* data);

	void getCompressedTexImage(Enum target, Int lod, Void* img);

	void multiTexCoord1d(Enum target, Double s);

	void multiTexCoord1dv(Enum target, const(Double)* v);

	void multiTexCoord1f(Enum target, Float s);

	void multiTexCoord1fv(Enum target, const(Float)* v);

	void multiTexCoord1i(Enum target, Int s);

	void multiTexCoord1iv(Enum target, const(Int)* v);

	void multiTexCoord1s(Enum target, Short s);

	void multiTexCoord1sv(Enum target, const(Short)* v);

	void multiTexCoord2d(Enum target, Double s, Double t);

	void multiTexCoord2dv(Enum target, const(Double)* v);

	void multiTexCoord2f(Enum target, Float s, Float t);

	void multiTexCoord2fv(Enum target, const(Float)* v);

	void multiTexCoord2i(Enum target, Int s, Int t);

	void multiTexCoord2iv(Enum target, const(Int)* v);

	void multiTexCoord2s(Enum target, Short s, Short t);

	void multiTexCoord2sv(Enum target, const(Short)* v);

	void multiTexCoord3d(Enum target, Double s, Double t, Double r);

	void multiTexCoord3dv(Enum target, const(Double)* v);

	void multiTexCoord3f(Enum target, Float s, Float t, Float r);

	void multiTexCoord3fv(Enum target, const(Float)* v);

	void multiTexCoord3i(Enum target, Int s, Int t, Int r);

	void multiTexCoord3iv(Enum target, const(Int)* v);

	void multiTexCoord3s(Enum target, Short s, Short t, Short r);

	void multiTexCoord3sv(Enum target, const(Short)* v);

	void multiTexCoord4d(Enum target, Double s, Double t, Double r, Double q);

	void multiTexCoord4dv(Enum target, const(Double)* v);

	void multiTexCoord4f(Enum target, Float s, Float t, Float r, Float q);

	void multiTexCoord4fv(Enum target, const(Float)* v);

	void multiTexCoord4i(Enum target, Int s, Int t, Int r, Int q);

	void multiTexCoord4iv(Enum target, const(Int)* v);

	void multiTexCoord4s(Enum target, Short s, Short t, Short r, Short q);

	void multiTexCoord4sv(Enum target, const(Short)* v);

	void loadTransposeMatrixd(ref const(Double)[16] m);

	void loadTransposeMatrixf(ref const(Float)[16] m);

	void multTransposeMatrixd(ref const(Double)[16] m);

	void multTransposeMatrixf(ref const(Float)[16] m);

	void sampleCoverage(Clampf value, Boolean invert);

	enum TEXTURE0_ARB = 0x84C0;
	enum TEXTURE1_ARB = 0x84C1;
	enum TEXTURE2_ARB = 0x84C2;
	enum TEXTURE3_ARB = 0x84C3;
	enum TEXTURE4_ARB = 0x84C4;
	enum TEXTURE5_ARB = 0x84C5;
	enum TEXTURE6_ARB = 0x84C6;
	enum TEXTURE7_ARB = 0x84C7;
	enum TEXTURE8_ARB = 0x84C8;
	enum TEXTURE9_ARB = 0x84C9;
	enum TEXTURE10_ARB = 0x84CA;
	enum TEXTURE11_ARB = 0x84CB;
	enum TEXTURE12_ARB = 0x84CC;
	enum TEXTURE13_ARB = 0x84CD;
	enum TEXTURE14_ARB = 0x84CE;
	enum TEXTURE15_ARB = 0x84CF;
	enum TEXTURE16_ARB = 0x84D0;
	enum TEXTURE17_ARB = 0x84D1;
	enum TEXTURE18_ARB = 0x84D2;
	enum TEXTURE19_ARB = 0x84D3;
	enum TEXTURE20_ARB = 0x84D4;
	enum TEXTURE21_ARB = 0x84D5;
	enum TEXTURE22_ARB = 0x84D6;
	enum TEXTURE23_ARB = 0x84D7;
	enum TEXTURE24_ARB = 0x84D8;
	enum TEXTURE25_ARB = 0x84D9;
	enum TEXTURE26_ARB = 0x84DA;
	enum TEXTURE27_ARB = 0x84DB;
	enum TEXTURE28_ARB = 0x84DC;
	enum TEXTURE29_ARB = 0x84DD;
	enum TEXTURE30_ARB = 0x84DE;
	enum TEXTURE31_ARB = 0x84DF;
	enum ACTIVE_TEXTURE_ARB = 0x84E0;
	enum CLIENT_ACTIVE_TEXTURE_ARB = 0x84E1;
	enum MAX_TEXTURE_UNITS_ARB = 0x84E2;

	void activeTextureARB(Enum texture);
	void clientActiveTextureARB(Enum texture);
	void multiTexCoord1dARB(Enum target, Double s);
	void multiTexCoord1dvARB(Enum target, const(Double)* v);
	void multiTexCoord1fARB(Enum target, Float s);
	void multiTexCoord1fvARB(Enum target, const(Float)* v);
	void multiTexCoord1iARB(Enum target, Int s);
	void multiTexCoord1ivARB(Enum target, const(Int)* v);
	void multiTexCoord1sARB(Enum target, Short s);
	void multiTexCoord1svARB(Enum target, const(Short)* v);
	void multiTexCoord2dARB(Enum target, Double s, Double t);
	void multiTexCoord2dvARB(Enum target, const(Double)* v);
	void multiTexCoord2fARB(Enum target, Float s, Float t);
	void multiTexCoord2fvARB(Enum target, const(Float)* v);
	void multiTexCoord2iARB(Enum target, Int s, Int t);
	void multiTexCoord2ivARB(Enum target, const(Int)* v);
	void multiTexCoord2sARB(Enum target, Short s, Short t);
	void multiTexCoord2svARB(Enum target, const(Short)* v);
	void multiTexCoord3dARB(Enum target, Double s, Double t, Double r);
	void multiTexCoord3dvARB(Enum target, const(Double)* v);
	void multiTexCoord3fARB(Enum target, Float s, Float t, Float r);
	void multiTexCoord3fvARB(Enum target, const(Float)* v);
	void multiTexCoord3iARB(Enum target, Int s, Int t, Int r);
	void multiTexCoord3ivARB(Enum target, const(Int)* v);
	void multiTexCoord3sARB(Enum target, Short s, Short t, Short r);
	void multiTexCoord3svARB(Enum target, const(Short)* v);
	void multiTexCoord4dARB(Enum target, Double s, Double t, Double r, Double q);
	void multiTexCoord4dvARB(Enum target, const(Double)* v);
	void multiTexCoord4fARB(Enum target, Float s, Float t, Float r, Float q);
	void multiTexCoord4fvARB(Enum target, const(Float)* v);
	void multiTexCoord4iARB(Enum target, Int s, Int t, Int r, Int q);
	void multiTexCoord4ivARB(Enum target, const(Int)* v);
	void multiTexCoord4sARB(Enum target, Short s, Short t, Short r, Short q);
	void multiTexCoord4svARB(Enum target, const(Short)* v);

	enum DEPTH_STENCIL_MESA = 0x8750;
	enum UNSIGNED_INT_24_8_MESA = 0x8751;
	enum UNSIGNED_INT_8_24_REV_MESA = 0x8752;
	enum UNSIGNED_SHORT_15_1_MESA = 0x8753;
	enum UNSIGNED_SHORT_1_15_REV_MESA = 0x8754;

	enum ALPHA_BLEND_EQUATION_ATI = 0x883D;

	void blendEquationSeparateATI(Enum modeRGB, Enum modeA);

	@BindingName("glEGLImageTargetTexture2DOES")
	void eglImageTargetTexture2DOES(Enum target, GLeglImageOES image);
	@BindingName("glEGLImageTargetRenderbufferStorageOES")
	void eglImageTargetRenderbufferStorageOES(Enum target, GLeglImageOES image);

	// file '/usr/include/GL/glext.h'

	import core.stdc.config;

	enum GLEXT_VERSION = 20_190_805;

	enum BLEND_DST_RGB = 0x80C8;
	enum BLEND_SRC_RGB = 0x80C9;
	enum BLEND_DST_ALPHA = 0x80CA;
	enum BLEND_SRC_ALPHA = 0x80CB;
	enum POINT_FADE_THRESHOLD_SIZE = 0x8128;
	enum DEPTH_COMPONENT16 = 0x81A5;
	enum DEPTH_COMPONENT24 = 0x81A6;
	enum DEPTH_COMPONENT32 = 0x81A7;
	enum MIRRORED_REPEAT = 0x8370;
	enum MAX_TEXTURE_LOD_BIAS = 0x84FD;
	enum TEXTURE_LOD_BIAS = 0x8501;
	enum INCR_WRAP = 0x8507;
	enum DECR_WRAP = 0x8508;
	enum TEXTURE_DEPTH_SIZE = 0x884A;
	enum TEXTURE_COMPARE_MODE = 0x884C;
	enum TEXTURE_COMPARE_FUNC = 0x884D;
	enum POINT_SIZE_MIN = 0x8126;
	enum POINT_SIZE_MAX = 0x8127;
	enum POINT_DISTANCE_ATTENUATION = 0x8129;
	enum GENERATE_MIPMAP = 0x8191;
	enum GENERATE_MIPMAP_HINT = 0x8192;
	enum FOG_COORDINATE_SOURCE = 0x8450;
	enum FOG_COORDINATE = 0x8451;
	enum FRAGMENT_DEPTH = 0x8452;
	enum CURRENT_FOG_COORDINATE = 0x8453;
	enum FOG_COORDINATE_ARRAY_TYPE = 0x8454;
	enum FOG_COORDINATE_ARRAY_STRIDE = 0x8455;
	enum FOG_COORDINATE_ARRAY_POINTER = 0x8456;
	enum FOG_COORDINATE_ARRAY = 0x8457;
	enum COLOR_SUM = 0x8458;
	enum CURRENT_SECONDARY_COLOR = 0x8459;
	enum SECONDARY_COLOR_ARRAY_SIZE = 0x845A;
	enum SECONDARY_COLOR_ARRAY_TYPE = 0x845B;
	enum SECONDARY_COLOR_ARRAY_STRIDE = 0x845C;
	enum SECONDARY_COLOR_ARRAY_POINTER = 0x845D;
	enum SECONDARY_COLOR_ARRAY = 0x845E;
	enum TEXTURE_FILTER_CONTROL = 0x8500;
	enum DEPTH_TEXTURE_MODE = 0x884B;
	enum COMPARE_R_TO_TEXTURE = 0x884E;
	// enum BLEND_COLOR = 0x8005;
	// enum BLEND_EQUATION = 0x8009;
	// enum CONSTANT_COLOR = 0x8001;
	// enum ONE_MINUS_CONSTANT_COLOR = 0x8002;
	// enum CONSTANT_ALPHA = 0x8003;
	// enum ONE_MINUS_CONSTANT_ALPHA = 0x8004;
	// enum FUNC_ADD = 0x8006;
	// enum FUNC_REVERSE_SUBTRACT = 0x800B;
	// enum FUNC_SUBTRACT = 0x800A;
	// enum MIN = 0x8007;
	// enum MAX = 0x8008;
	void blendFuncSeparate(Enum sfactorRGB, Enum dfactorRGB,
			Enum sfactorAlpha, Enum dfactorAlpha);
	void multiDrawArrays(Enum mode, const(Int)* first,
			const(Sizei)* count, Sizei drawcount);
	void multiDrawElements(Enum mode, const(Sizei)* count, Enum type,
			const(void*)* indices, Sizei drawcount);
	void pointParameterf(Enum pname, Float param);
	void pointParameterfv(Enum pname, const(Float)* params);
	void pointParameteri(Enum pname, Int param);
	void pointParameteriv(Enum pname, const(Int)* params);
	void fogCoordf(Float coord);
	void fogCoordfv(const(Float)* coord);
	void fogCoordd(Double coord);
	void fogCoorddv(const(Double)* coord);
	void fogCoordPointer(Enum type, Sizei stride, const(void)* pointer);
	void secondaryColor3b(Byte red, Byte green, Byte blue);
	void secondaryColor3bv(const(Byte)* v);
	void secondaryColor3d(Double red, Double green, Double blue);
	void secondaryColor3dv(const(Double)* v);
	void secondaryColor3f(Float red, Float green, Float blue);
	void secondaryColor3fv(const(Float)* v);
	void secondaryColor3i(Int red, Int green, Int blue);
	void secondaryColor3iv(const(Int)* v);
	void secondaryColor3s(Short red, Short green, Short blue);
	void secondaryColor3sv(const(Short)* v);
	void secondaryColor3Ub(UByte red, UByte green, UByte blue);
	void secondaryColor3Ubv(const(UByte)* v);
	void secondaryColor3Ui(UInt red, UInt green, UInt blue);
	void secondaryColor3Uiv(const(UInt)* v);
	void secondaryColor3Us(UShort red, UShort green, UShort blue);
	void secondaryColor3Usv(const(UShort)* v);
	void secondaryColorPointer(Int size, Enum type, Sizei stride, const(void)* pointer);
	void windowPos2d(Double x, Double y);
	void windowPos2dv(const(Double)* v);
	void windowPos2f(Float x, Float y);
	void windowPos2fv(const(Float)* v);
	void windowPos2i(Int x, Int y);
	void windowPos2iv(const(Int)* v);
	void windowPos2s(Short x, Short y);
	void windowPos2sv(const(Short)* v);
	void windowPos3d(Double x, Double y, Double z);
	void windowPos3dv(const(Double)* v);
	void windowPos3f(Float x, Float y, Float z);
	void windowPos3fv(const(Float)* v);
	void windowPos3i(Int x, Int y, Int z);
	void windowPos3iv(const(Int)* v);
	void windowPos3s(Short x, Short y, Short z);
	void windowPos3sv(const(Short)* v);
	void blendColor(Float red, Float green, Float blue, Float alpha);
	void blendEquation(Enum mode);

	alias Sizeiptr = c_long;
	alias Intptr = c_long;
	enum BUFFER_SIZE = 0x8764;
	enum BUFFER_USAGE = 0x8765;
	enum QUERY_COUNTER_BITS = 0x8864;
	enum CURRENT_QUERY = 0x8865;
	enum QUERY_RESULT = 0x8866;
	enum QUERY_RESULT_AVAILABLE = 0x8867;
	enum ARRAY_BUFFER = 0x8892;
	enum ELEMENT_ARRAY_BUFFER = 0x8893;
	enum ARRAY_BUFFER_BINDING = 0x8894;
	enum ELEMENT_ARRAY_BUFFER_BINDING = 0x8895;
	enum VERTEX_ATTRIB_ARRAY_BUFFER_BINDING = 0x889F;
	enum READ_ONLY = 0x88B8;
	enum WRITE_ONLY = 0x88B9;
	enum READ_WRITE = 0x88BA;
	enum BUFFER_ACCESS = 0x88BB;
	enum BUFFER_MAPPED = 0x88BC;
	enum BUFFER_MAP_POINTER = 0x88BD;
	enum STREAM_DRAW = 0x88E0;
	enum STREAM_READ = 0x88E1;
	enum STREAM_COPY = 0x88E2;
	enum STATIC_DRAW = 0x88E4;
	enum STATIC_READ = 0x88E5;
	enum STATIC_COPY = 0x88E6;
	enum DYNAMIC_DRAW = 0x88E8;
	enum DYNAMIC_READ = 0x88E9;
	enum DYNAMIC_COPY = 0x88EA;
	enum SAMPLES_PASSED = 0x8914;
	enum SRC1_ALPHA = 0x8589;
	enum VERTEX_ARRAY_BUFFER_BINDING = 0x8896;
	enum NORMAL_ARRAY_BUFFER_BINDING = 0x8897;
	enum COLOR_ARRAY_BUFFER_BINDING = 0x8898;
	enum INDEX_ARRAY_BUFFER_BINDING = 0x8899;
	enum TEXTURE_COORD_ARRAY_BUFFER_BINDING = 0x889A;
	enum EDGE_FLAG_ARRAY_BUFFER_BINDING = 0x889B;
	enum SECONDARY_COLOR_ARRAY_BUFFER_BINDING = 0x889C;
	enum FOG_COORDINATE_ARRAY_BUFFER_BINDING = 0x889D;
	enum WEIGHT_ARRAY_BUFFER_BINDING = 0x889E;
	enum FOG_COORD_SRC = 0x8450;
	enum FOG_COORD = 0x8451;
	enum CURRENT_FOG_COORD = 0x8453;
	enum FOG_COORD_ARRAY_TYPE = 0x8454;
	enum FOG_COORD_ARRAY_STRIDE = 0x8455;
	enum FOG_COORD_ARRAY_POINTER = 0x8456;
	enum FOG_COORD_ARRAY = 0x8457;
	enum FOG_COORD_ARRAY_BUFFER_BINDING = 0x889D;
	enum SRC0_RGB = 0x8580;
	enum SRC1_RGB = 0x8581;
	enum SRC2_RGB = 0x8582;
	enum SRC0_ALPHA = 0x8588;
	enum SRC2_ALPHA = 0x858A;
	void genQueries(Sizei n, UInt* ids);
	void deleteQueries(Sizei n, const(UInt)* ids);
	Boolean isQuery(UInt id);
	void beginQuery(Enum target, UInt id);
	void endQuery(Enum target);
	void getQueryiv(Enum target, Enum pname, Int* params);
	void getQueryObjectiv(UInt id, Enum pname, Int* params);
	void getQueryObjectuiv(UInt id, Enum pname, UInt* params);
	void bindBuffer(Enum target, UInt buffer);
	void deleteBuffers(Sizei n, const(UInt)* buffers);
	void genBuffers(Sizei n, UInt* buffers);
	Boolean isBuffer(UInt buffer);
	void bufferData(Enum target, Sizeiptr size, const(void)* data, Enum usage);
	void bufferSubData(Enum target, Intptr offset, Sizeiptr size, const(void)* data);
	void getBufferSubData(Enum target, Intptr offset, Sizeiptr size, void* data);
	void* mapBuffer(Enum target, Enum access);
	Boolean unmapBuffer(Enum target);
	void getBufferParameteriv(Enum target, Enum pname, Int* params);
	void getBufferPointerv(Enum target, Enum pname, void** params);

	alias Char = char;
	enum BLEND_EQUATION_RGB = 0x8009;
	enum VERTEX_ATTRIB_ARRAY_ENABLED = 0x8622;
	enum VERTEX_ATTRIB_ARRAY_SIZE = 0x8623;
	enum VERTEX_ATTRIB_ARRAY_STRIDE = 0x8624;
	enum VERTEX_ATTRIB_ARRAY_TYPE = 0x8625;
	enum CURRENT_VERTEX_ATTRIB = 0x8626;
	enum VERTEX_PROGRAM_POINT_SIZE = 0x8642;
	enum VERTEX_ATTRIB_ARRAY_POINTER = 0x8645;
	enum STENCIL_BACK_FUNC = 0x8800;
	enum STENCIL_BACK_FAIL = 0x8801;
	enum STENCIL_BACK_PASS_DEPTH_FAIL = 0x8802;
	enum STENCIL_BACK_PASS_DEPTH_PASS = 0x8803;
	enum MAX_DRAW_BUFFERS = 0x8824;
	enum DRAW_BUFFER0 = 0x8825;
	enum DRAW_BUFFER1 = 0x8826;
	enum DRAW_BUFFER2 = 0x8827;
	enum DRAW_BUFFER3 = 0x8828;
	enum DRAW_BUFFER4 = 0x8829;
	enum DRAW_BUFFER5 = 0x882A;
	enum DRAW_BUFFER6 = 0x882B;
	enum DRAW_BUFFER7 = 0x882C;
	enum DRAW_BUFFER8 = 0x882D;
	enum DRAW_BUFFER9 = 0x882E;
	enum DRAW_BUFFER10 = 0x882F;
	enum DRAW_BUFFER11 = 0x8830;
	enum DRAW_BUFFER12 = 0x8831;
	enum DRAW_BUFFER13 = 0x8832;
	enum DRAW_BUFFER14 = 0x8833;
	enum DRAW_BUFFER15 = 0x8834;
	enum BLEND_EQUATION_ALPHA = 0x883D;
	enum MAX_VERTEX_ATTRIBS = 0x8869;
	enum VERTEX_ATTRIB_ARRAY_NORMALIZED = 0x886A;
	enum MAX_TEXTURE_IMAGE_UNITS = 0x8872;
	enum FRAGMENT_SHADER = 0x8B30;
	enum VERTEX_SHADER = 0x8B31;
	enum MAX_FRAGMENT_UNIFORM_COMPONENTS = 0x8B49;
	enum MAX_VERTEX_UNIFORM_COMPONENTS = 0x8B4A;
	enum MAX_VARYING_FLOATS = 0x8B4B;
	enum MAX_VERTEX_TEXTURE_IMAGE_UNITS = 0x8B4C;
	enum MAX_COMBINED_TEXTURE_IMAGE_UNITS = 0x8B4D;
	enum SHADER_TYPE = 0x8B4F;
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
	enum SAMPLER_1D = 0x8B5D;
	enum SAMPLER_2D = 0x8B5E;
	enum SAMPLER_3D = 0x8B5F;
	enum SAMPLER_CUBE = 0x8B60;
	enum SAMPLER_1D_SHADOW = 0x8B61;
	enum SAMPLER_2D_SHADOW = 0x8B62;
	enum DELETE_STATUS = 0x8B80;
	enum COMPILE_STATUS = 0x8B81;
	enum LINK_STATUS = 0x8B82;
	enum VALIDATE_STATUS = 0x8B83;
	enum INFO_LOG_LENGTH = 0x8B84;
	enum ATTACHED_SHADERS = 0x8B85;
	enum ACTIVE_UNIFORMS = 0x8B86;
	enum ACTIVE_UNIFORM_MAX_LENGTH = 0x8B87;
	enum SHADER_SOURCE_LENGTH = 0x8B88;
	enum ACTIVE_ATTRIBUTES = 0x8B89;
	enum ACTIVE_ATTRIBUTE_MAX_LENGTH = 0x8B8A;
	enum FRAGMENT_SHADER_DERIVATIVE_HINT = 0x8B8B;
	enum SHADING_LANGUAGE_VERSION = 0x8B8C;
	enum CURRENT_PROGRAM = 0x8B8D;
	enum POINT_SPRITE_COORD_ORIGIN = 0x8CA0;
	enum LOWER_LEFT = 0x8CA1;
	enum UPPER_LEFT = 0x8CA2;
	enum STENCIL_BACK_REF = 0x8CA3;
	enum STENCIL_BACK_VALUE_MASK = 0x8CA4;
	enum STENCIL_BACK_WRITEMASK = 0x8CA5;
	enum VERTEX_PROGRAM_TWO_SIDE = 0x8643;
	enum POINT_SPRITE = 0x8861;
	enum COORD_REPLACE = 0x8862;
	enum MAX_TEXTURE_COORDS = 0x8871;
	void blendEquationSeparate(Enum modeRGB, Enum modeAlpha);
	void drawBuffers(Sizei n, const(Enum)* bufs);
	void stencilOpSeparate(Enum face, Enum sfail, Enum dpfail, Enum dppass);
	void stencilFuncSeparate(Enum face, Enum func, Int ref_, UInt mask);
	void stencilMaskSeparate(Enum face, UInt mask);
	void attachShader(UInt program, UInt shader);
	void bindAttribLocation(UInt program, UInt index, const(Char)* name);
	void compileShader(UInt shader);
	UInt createProgram();
	UInt createShader(Enum type);
	void deleteProgram(UInt program);
	void deleteShader(UInt shader);
	void detachShader(UInt program, UInt shader);
	void disableVertexAttribArray(UInt index);
	void enableVertexAttribArray(UInt index);
	void getActiveAttrib(UInt program, UInt index, Sizei bufSize,
			Sizei* length, Int* size, Enum* type, Char* name);
	void getActiveUniform(UInt program, UInt index, Sizei bufSize,
			Sizei* length, Int* size, Enum* type, Char* name);
	void getAttachedShaders(UInt program, Sizei maxCount, Sizei* count, UInt* shaders);
	Int getAttribLocation(UInt program, const(Char)* name);
	void getProgramiv(UInt program, Enum pname, Int* params);
	void getProgramInfoLog(UInt program, Sizei bufSize, Sizei* length, Char* infoLog);
	void getShaderiv(UInt shader, Enum pname, Int* params);
	void getShaderInfoLog(UInt shader, Sizei bufSize, Sizei* length, Char* infoLog);
	void getShaderSource(UInt shader, Sizei bufSize, Sizei* length, Char* source);
	Int getUniformLocation(UInt program, const(Char)* name);
	void getUniformfv(UInt program, Int location, Float* params);
	void getUniformiv(UInt program, Int location, Int* params);
	void getVertexAttribdv(UInt index, Enum pname, Double* params);
	void getVertexAttribfv(UInt index, Enum pname, Float* params);
	void getVertexAttribiv(UInt index, Enum pname, Int* params);
	void getVertexAttribPointerv(UInt index, Enum pname, void** pointer);
	Boolean isProgram(UInt program);
	Boolean isShader(UInt shader);
	void linkProgram(UInt program);
	void shaderSource(UInt shader, Sizei count, const(Char*)* string, const(Int)* length);
	void useProgram(UInt program);
	void uniform1f(Int location, Float v0);
	void uniform2f(Int location, Float v0, Float v1);
	void uniform3f(Int location, Float v0, Float v1, Float v2);
	void uniform4f(Int location, Float v0, Float v1, Float v2, Float v3);
	void uniform1i(Int location, Int v0);
	void uniform2i(Int location, Int v0, Int v1);
	void uniform3i(Int location, Int v0, Int v1, Int v2);
	void uniform4i(Int location, Int v0, Int v1, Int v2, Int v3);
	void uniform1fv(Int location, Sizei count, const(Float)* value);
	void uniform2fv(Int location, Sizei count, const(Float)* value);
	void uniform3fv(Int location, Sizei count, const(Float)* value);
	void uniform4fv(Int location, Sizei count, const(Float)* value);
	void uniform1iv(Int location, Sizei count, const(Int)* value);
	void uniform2iv(Int location, Sizei count, const(Int)* value);
	void uniform3iv(Int location, Sizei count, const(Int)* value);
	void uniform4iv(Int location, Sizei count, const(Int)* value);
	void uniformMatrix2fv(Int location, Sizei count, Boolean transpose,
			const(Float)* value);
	void uniformMatrix3fv(Int location, Sizei count, Boolean transpose,
			const(Float)* value);
	void uniformMatrix4fv(Int location, Sizei count, Boolean transpose,
			const(Float)* value);
	void validateProgram(UInt program);
	void vertexAttrib1d(UInt index, Double x);
	void vertexAttrib1dv(UInt index, const(Double)* v);
	void vertexAttrib1f(UInt index, Float x);
	void vertexAttrib1fv(UInt index, const(Float)* v);
	void vertexAttrib1s(UInt index, Short x);
	void vertexAttrib1sv(UInt index, const(Short)* v);
	void vertexAttrib2d(UInt index, Double x, Double y);
	void vertexAttrib2dv(UInt index, const(Double)* v);
	void vertexAttrib2f(UInt index, Float x, Float y);
	void vertexAttrib2fv(UInt index, const(Float)* v);
	void vertexAttrib2s(UInt index, Short x, Short y);
	void vertexAttrib2sv(UInt index, const(Short)* v);
	void vertexAttrib3d(UInt index, Double x, Double y, Double z);
	void vertexAttrib3dv(UInt index, const(Double)* v);
	void vertexAttrib3f(UInt index, Float x, Float y, Float z);
	void vertexAttrib3fv(UInt index, const(Float)* v);
	void vertexAttrib3s(UInt index, Short x, Short y, Short z);
	void vertexAttrib3sv(UInt index, const(Short)* v);
	void vertexAttrib4Nbv(UInt index, const(Byte)* v);
	void vertexAttrib4Niv(UInt index, const(Int)* v);
	void vertexAttrib4Nsv(UInt index, const(Short)* v);
	void vertexAttrib4Nub(UInt index, UByte x, UByte y, UByte z, UByte w);
	void vertexAttrib4Nubv(UInt index, const(UByte)* v);
	void vertexAttrib4Nuiv(UInt index, const(UInt)* v);
	void vertexAttrib4Nusv(UInt index, const(UShort)* v);
	void vertexAttrib4bv(UInt index, const(Byte)* v);
	void vertexAttrib4d(UInt index, Double x, Double y, Double z, Double w);
	void vertexAttrib4dv(UInt index, const(Double)* v);
	void vertexAttrib4f(UInt index, Float x, Float y, Float z, Float w);
	void vertexAttrib4fv(UInt index, const(Float)* v);
	void vertexAttrib4iv(UInt index, const(Int)* v);
	void vertexAttrib4s(UInt index, Short x, Short y, Short z, Short w);
	void vertexAttrib4sv(UInt index, const(Short)* v);
	void vertexAttrib4Ubv(UInt index, const(UByte)* v);
	void vertexAttrib4Uiv(UInt index, const(UInt)* v);
	void vertexAttrib4Usv(UInt index, const(UShort)* v);
	void vertexAttribPointer(UInt index, Int size, Enum type,
			Boolean normalized, Sizei stride, const(void)* pointer);

	enum PIXEL_PACK_BUFFER = 0x88EB;
	enum PIXEL_UNPACK_BUFFER = 0x88EC;
	enum PIXEL_PACK_BUFFER_BINDING = 0x88ED;
	enum PIXEL_UNPACK_BUFFER_BINDING = 0x88EF;
	enum FLOAT_MAT2x3 = 0x8B65;
	enum FLOAT_MAT2x4 = 0x8B66;
	enum FLOAT_MAT3x2 = 0x8B67;
	enum FLOAT_MAT3x4 = 0x8B68;
	enum FLOAT_MAT4x2 = 0x8B69;
	enum FLOAT_MAT4x3 = 0x8B6A;
	enum SRGB = 0x8C40;
	enum SRGB8 = 0x8C41;
	enum SRGB_ALPHA = 0x8C42;
	enum SRGB8_ALPHA8 = 0x8C43;
	enum COMPRESSED_SRGB = 0x8C48;
	enum COMPRESSED_SRGB_ALPHA = 0x8C49;
	enum CURRENT_RASTER_SECONDARY_COLOR = 0x845F;
	enum SLUMINANCE_ALPHA = 0x8C44;
	enum SLUMINANCE8_ALPHA8 = 0x8C45;
	enum SLUMINANCE = 0x8C46;
	enum SLUMINANCE8 = 0x8C47;
	enum COMPRESSED_SLUMINANCE = 0x8C4A;
	enum COMPRESSED_SLUMINANCE_ALPHA = 0x8C4B;
	void uniformMatrix2x3fv(Int location, Sizei count, Boolean transpose,
			const(Float)* value);
	void uniformMatrix3x2fv(Int location, Sizei count, Boolean transpose,
			const(Float)* value);
	void uniformMatrix2x4fv(Int location, Sizei count, Boolean transpose,
			const(Float)* value);
	void uniformMatrix4x2fv(Int location, Sizei count, Boolean transpose,
			const(Float)* value);
	void uniformMatrix3x4fv(Int location, Sizei count, Boolean transpose,
			const(Float)* value);
	void uniformMatrix4x3fv(Int location, Sizei count, Boolean transpose,
			const(Float)* value);

	alias Half = ushort;
	enum COMPARE_REF_TO_TEXTURE = 0x884E;
	enum CLIP_DISTANCE0 = 0x3000;
	enum CLIP_DISTANCE1 = 0x3001;
	enum CLIP_DISTANCE2 = 0x3002;
	enum CLIP_DISTANCE3 = 0x3003;
	enum CLIP_DISTANCE4 = 0x3004;
	enum CLIP_DISTANCE5 = 0x3005;
	enum CLIP_DISTANCE6 = 0x3006;
	enum CLIP_DISTANCE7 = 0x3007;
	enum MAX_CLIP_DISTANCES = 0x0D32;
	enum MAJOR_VERSION = 0x821B;
	enum MINOR_VERSION = 0x821C;
	enum NUM_EXTENSIONS = 0x821D;
	enum CONTEXT_FLAGS = 0x821E;
	enum COMPRESSED_RED = 0x8225;
	enum COMPRESSED_RG = 0x8226;
	enum CONTEXT_FLAG_FORWARD_COMPATIBLE_BIT = 0x00000001;
	enum RGBA32F = 0x8814;
	enum RGB32F = 0x8815;
	enum RGBA16F = 0x881A;
	enum RGB16F = 0x881B;
	enum VERTEX_ATTRIB_ARRAY_INTEGER = 0x88FD;
	enum MAX_ARRAY_TEXTURE_LAYERS = 0x88FF;
	enum MIN_PROGRAM_TEXEL_OFFSET = 0x8904;
	enum MAX_PROGRAM_TEXEL_OFFSET = 0x8905;
	enum CLAMP_READ_COLOR = 0x891C;
	enum FIXED_ONLY = 0x891D;
	enum MAX_VARYING_COMPONENTS = 0x8B4B;
	enum TEXTURE_1D_ARRAY = 0x8C18;
	enum PROXY_TEXTURE_1D_ARRAY = 0x8C19;
	enum TEXTURE_2D_ARRAY = 0x8C1A;
	enum PROXY_TEXTURE_2D_ARRAY = 0x8C1B;
	enum TEXTURE_BINDING_1D_ARRAY = 0x8C1C;
	enum TEXTURE_BINDING_2D_ARRAY = 0x8C1D;
	enum R11F_G11F_B10F = 0x8C3A;
	enum UNSIGNED_INT_10F_11F_11F_REV = 0x8C3B;
	enum RGB9_E5 = 0x8C3D;
	enum UNSIGNED_INT_5_9_9_9_REV = 0x8C3E;
	enum TEXTURE_SHARED_SIZE = 0x8C3F;
	enum TRANSFORM_FEEDBACK_VARYING_MAX_LENGTH = 0x8C76;
	enum TRANSFORM_FEEDBACK_BUFFER_MODE = 0x8C7F;
	enum MAX_TRANSFORM_FEEDBACK_SEPARATE_COMPONENTS = 0x8C80;
	enum TRANSFORM_FEEDBACK_VARYINGS = 0x8C83;
	enum TRANSFORM_FEEDBACK_BUFFER_START = 0x8C84;
	enum TRANSFORM_FEEDBACK_BUFFER_SIZE = 0x8C85;
	enum PRIMITIVES_GENERATED = 0x8C87;
	enum TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN = 0x8C88;
	enum RASTERIZER_DISCARD = 0x8C89;
	enum MAX_TRANSFORM_FEEDBACK_INTERLEAVED_COMPONENTS = 0x8C8A;
	enum MAX_TRANSFORM_FEEDBACK_SEPARATE_ATTRIBS = 0x8C8B;
	enum INTERLEAVED_ATTRIBS = 0x8C8C;
	enum SEPARATE_ATTRIBS = 0x8C8D;
	enum TRANSFORM_FEEDBACK_BUFFER = 0x8C8E;
	enum TRANSFORM_FEEDBACK_BUFFER_BINDING = 0x8C8F;
	enum RGBA32UI = 0x8D70;
	enum RGB32UI = 0x8D71;
	enum RGBA16UI = 0x8D76;
	enum RGB16UI = 0x8D77;
	enum RGBA8UI = 0x8D7C;
	enum RGB8UI = 0x8D7D;
	enum RGBA32I = 0x8D82;
	enum RGB32I = 0x8D83;
	enum RGBA16I = 0x8D88;
	enum RGB16I = 0x8D89;
	enum RGBA8I = 0x8D8E;
	enum RGB8I = 0x8D8F;
	enum RED_INTEGER = 0x8D94;
	enum GREEN_INTEGER = 0x8D95;
	enum BLUE_INTEGER = 0x8D96;
	enum RGB_INTEGER = 0x8D98;
	enum RGBA_INTEGER = 0x8D99;
	enum BGR_INTEGER = 0x8D9A;
	enum BGRA_INTEGER = 0x8D9B;
	enum SAMPLER_1D_ARRAY = 0x8DC0;
	enum SAMPLER_2D_ARRAY = 0x8DC1;
	enum SAMPLER_1D_ARRAY_SHADOW = 0x8DC3;
	enum SAMPLER_2D_ARRAY_SHADOW = 0x8DC4;
	enum SAMPLER_CUBE_SHADOW = 0x8DC5;
	enum UNSIGNED_INT_VEC2 = 0x8DC6;
	enum UNSIGNED_INT_VEC3 = 0x8DC7;
	enum UNSIGNED_INT_VEC4 = 0x8DC8;
	enum INT_SAMPLER_1D = 0x8DC9;
	enum INT_SAMPLER_2D = 0x8DCA;
	enum INT_SAMPLER_3D = 0x8DCB;
	enum INT_SAMPLER_CUBE = 0x8DCC;
	enum INT_SAMPLER_1D_ARRAY = 0x8DCE;
	enum INT_SAMPLER_2D_ARRAY = 0x8DCF;
	enum UNSIGNED_INT_SAMPLER_1D = 0x8DD1;
	enum UNSIGNED_INT_SAMPLER_2D = 0x8DD2;
	enum UNSIGNED_INT_SAMPLER_3D = 0x8DD3;
	enum UNSIGNED_INT_SAMPLER_CUBE = 0x8DD4;
	enum UNSIGNED_INT_SAMPLER_1D_ARRAY = 0x8DD6;
	enum UNSIGNED_INT_SAMPLER_2D_ARRAY = 0x8DD7;
	enum QUERY_WAIT = 0x8E13;
	enum QUERY_NO_WAIT = 0x8E14;
	enum QUERY_BY_REGION_WAIT = 0x8E15;
	enum QUERY_BY_REGION_NO_WAIT = 0x8E16;
	enum BUFFER_ACCESS_FLAGS = 0x911F;
	enum BUFFER_MAP_LENGTH = 0x9120;
	enum BUFFER_MAP_OFFSET = 0x9121;
	enum DEPTH_COMPONENT32F = 0x8CAC;
	enum DEPTH32F_STENCIL8 = 0x8CAD;
	enum FLOAT_32_UNSIGNED_INT_24_8_REV = 0x8DAD;
	enum INVALID_FRAMEBUFFER_OPERATION = 0x0506;
	enum FRAMEBUFFER_ATTACHMENT_COLOR_ENCODING = 0x8210;
	enum FRAMEBUFFER_ATTACHMENT_COMPONENT_TYPE = 0x8211;
	enum FRAMEBUFFER_ATTACHMENT_RED_SIZE = 0x8212;
	enum FRAMEBUFFER_ATTACHMENT_GREEN_SIZE = 0x8213;
	enum FRAMEBUFFER_ATTACHMENT_BLUE_SIZE = 0x8214;
	enum FRAMEBUFFER_ATTACHMENT_ALPHA_SIZE = 0x8215;
	enum FRAMEBUFFER_ATTACHMENT_DEPTH_SIZE = 0x8216;
	enum FRAMEBUFFER_ATTACHMENT_STENCIL_SIZE = 0x8217;
	enum FRAMEBUFFER_DEFAULT = 0x8218;
	enum FRAMEBUFFER_UNDEFINED = 0x8219;
	enum DEPTH_STENCIL_ATTACHMENT = 0x821A;
	enum MAX_RENDERBUFFER_SIZE = 0x84E8;
	enum DEPTH_STENCIL = 0x84F9;
	enum UNSIGNED_INT_24_8 = 0x84FA;
	enum DEPTH24_STENCIL8 = 0x88F0;
	enum TEXTURE_STENCIL_SIZE = 0x88F1;
	enum TEXTURE_RED_TYPE = 0x8C10;
	enum TEXTURE_GREEN_TYPE = 0x8C11;
	enum TEXTURE_BLUE_TYPE = 0x8C12;
	enum TEXTURE_ALPHA_TYPE = 0x8C13;
	enum TEXTURE_DEPTH_TYPE = 0x8C16;
	enum UNSIGNED_NORMALIZED = 0x8C17;
	enum FRAMEBUFFER_BINDING = 0x8CA6;
	enum DRAW_FRAMEBUFFER_BINDING = 0x8CA6;
	enum RENDERBUFFER_BINDING = 0x8CA7;
	enum READ_FRAMEBUFFER = 0x8CA8;
	enum DRAW_FRAMEBUFFER = 0x8CA9;
	enum READ_FRAMEBUFFER_BINDING = 0x8CAA;
	enum RENDERBUFFER_SAMPLES = 0x8CAB;
	enum FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE = 0x8CD0;
	enum FRAMEBUFFER_ATTACHMENT_OBJECT_NAME = 0x8CD1;
	enum FRAMEBUFFER_ATTACHMENT_TEXTURE_LEVEL = 0x8CD2;
	enum FRAMEBUFFER_ATTACHMENT_TEXTURE_CUBE_MAP_FACE = 0x8CD3;
	enum FRAMEBUFFER_ATTACHMENT_TEXTURE_LAYER = 0x8CD4;
	enum FRAMEBUFFER_COMPLETE = 0x8CD5;
	enum FRAMEBUFFER_INCOMPLETE_ATTACHMENT = 0x8CD6;
	enum FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT = 0x8CD7;
	enum FRAMEBUFFER_INCOMPLETE_DRAW_BUFFER = 0x8CDB;
	enum FRAMEBUFFER_INCOMPLETE_READ_BUFFER = 0x8CDC;
	enum FRAMEBUFFER_UNSUPPORTED = 0x8CDD;
	enum MAX_COLOR_ATTACHMENTS = 0x8CDF;
	enum COLOR_ATTACHMENT0 = 0x8CE0;
	enum COLOR_ATTACHMENT1 = 0x8CE1;
	enum COLOR_ATTACHMENT2 = 0x8CE2;
	enum COLOR_ATTACHMENT3 = 0x8CE3;
	enum COLOR_ATTACHMENT4 = 0x8CE4;
	enum COLOR_ATTACHMENT5 = 0x8CE5;
	enum COLOR_ATTACHMENT6 = 0x8CE6;
	enum COLOR_ATTACHMENT7 = 0x8CE7;
	enum COLOR_ATTACHMENT8 = 0x8CE8;
	enum COLOR_ATTACHMENT9 = 0x8CE9;
	enum COLOR_ATTACHMENT10 = 0x8CEA;
	enum COLOR_ATTACHMENT11 = 0x8CEB;
	enum COLOR_ATTACHMENT12 = 0x8CEC;
	enum COLOR_ATTACHMENT13 = 0x8CED;
	enum COLOR_ATTACHMENT14 = 0x8CEE;
	enum COLOR_ATTACHMENT15 = 0x8CEF;
	enum COLOR_ATTACHMENT16 = 0x8CF0;
	enum COLOR_ATTACHMENT17 = 0x8CF1;
	enum COLOR_ATTACHMENT18 = 0x8CF2;
	enum COLOR_ATTACHMENT19 = 0x8CF3;
	enum COLOR_ATTACHMENT20 = 0x8CF4;
	enum COLOR_ATTACHMENT21 = 0x8CF5;
	enum COLOR_ATTACHMENT22 = 0x8CF6;
	enum COLOR_ATTACHMENT23 = 0x8CF7;
	enum COLOR_ATTACHMENT24 = 0x8CF8;
	enum COLOR_ATTACHMENT25 = 0x8CF9;
	enum COLOR_ATTACHMENT26 = 0x8CFA;
	enum COLOR_ATTACHMENT27 = 0x8CFB;
	enum COLOR_ATTACHMENT28 = 0x8CFC;
	enum COLOR_ATTACHMENT29 = 0x8CFD;
	enum COLOR_ATTACHMENT30 = 0x8CFE;
	enum COLOR_ATTACHMENT31 = 0x8CFF;
	enum DEPTH_ATTACHMENT = 0x8D00;
	enum STENCIL_ATTACHMENT = 0x8D20;
	enum FRAMEBUFFER = 0x8D40;
	enum RENDERBUFFER = 0x8D41;
	enum RENDERBUFFER_WIDTH = 0x8D42;
	enum RENDERBUFFER_HEIGHT = 0x8D43;
	enum RENDERBUFFER_INTERNAL_FORMAT = 0x8D44;
	enum STENCIL_INDEX1 = 0x8D46;
	enum STENCIL_INDEX4 = 0x8D47;
	enum STENCIL_INDEX8 = 0x8D48;
	enum STENCIL_INDEX16 = 0x8D49;
	enum RENDERBUFFER_RED_SIZE = 0x8D50;
	enum RENDERBUFFER_GREEN_SIZE = 0x8D51;
	enum RENDERBUFFER_BLUE_SIZE = 0x8D52;
	enum RENDERBUFFER_ALPHA_SIZE = 0x8D53;
	enum RENDERBUFFER_DEPTH_SIZE = 0x8D54;
	enum RENDERBUFFER_STENCIL_SIZE = 0x8D55;
	enum FRAMEBUFFER_INCOMPLETE_MULTISAMPLE = 0x8D56;
	enum MAX_SAMPLES = 0x8D57;
	enum INDEX = 0x8222;
	enum TEXTURE_LUMINANCE_TYPE = 0x8C14;
	enum TEXTURE_INTENSITY_TYPE = 0x8C15;
	enum FRAMEBUFFER_SRGB = 0x8DB9;
	enum HALF_FLOAT = 0x140B;
	enum MAP_READ_BIT = 0x0001;
	enum MAP_WRITE_BIT = 0x0002;
	enum MAP_INVALIDATE_RANGE_BIT = 0x0004;
	enum MAP_INVALIDATE_BUFFER_BIT = 0x0008;
	enum MAP_FLUSH_EXPLICIT_BIT = 0x0010;
	enum MAP_UNSYNCHRONIZED_BIT = 0x0020;
	enum COMPRESSED_RED_RGTC1 = 0x8DBB;
	enum COMPRESSED_SIGNED_RED_RGTC1 = 0x8DBC;
	enum COMPRESSED_RG_RGTC2 = 0x8DBD;
	enum COMPRESSED_SIGNED_RG_RGTC2 = 0x8DBE;
	enum RG = 0x8227;
	enum RG_INTEGER = 0x8228;
	enum R8 = 0x8229;
	enum R16 = 0x822A;
	enum RG8 = 0x822B;
	enum RG16 = 0x822C;
	enum R16F = 0x822D;
	enum R32F = 0x822E;
	enum RG16F = 0x822F;
	enum RG32F = 0x8230;
	enum R8I = 0x8231;
	enum R8UI = 0x8232;
	enum R16I = 0x8233;
	enum R16UI = 0x8234;
	enum R32I = 0x8235;
	enum R32UI = 0x8236;
	enum RG8I = 0x8237;
	enum RG8UI = 0x8238;
	enum RG16I = 0x8239;
	enum RG16UI = 0x823A;
	enum RG32I = 0x823B;
	enum RG32UI = 0x823C;
	enum VERTEX_ARRAY_BINDING = 0x85B5;
	enum CLAMP_VERTEX_COLOR = 0x891A;
	enum CLAMP_FRAGMENT_COLOR = 0x891B;
	enum ALPHA_INTEGER = 0x8D97;
	void colorMaski(UInt index, Boolean r, Boolean g, Boolean b, Boolean a);
	void getBooleani_v(Enum target, UInt index, Boolean* data);
	void getIntegeri_v(Enum target, UInt index, Int* data);
	void enablei(Enum target, UInt index);
	void disablei(Enum target, UInt index);
	Boolean isEnabledi(Enum target, UInt index);
	void beginTransformFeedback(Enum primitiveMode);
	void endTransformFeedback();
	void bindBufferRange(Enum target, UInt index, UInt buffer,
			Intptr offset, Sizeiptr size);
	void bindBufferBase(Enum target, UInt index, UInt buffer);
	void transformFeedbackVaryings(UInt program, Sizei count,
			const(Char*)* varyings, Enum bufferMode);
	void getTransformFeedbackVarying(UInt program, UInt index, Sizei bufSize,
			Sizei* length, Sizei* size, Enum* type, Char* name);
	void clampColor(Enum target, Enum clamp);
	void beginConditionalRender(UInt id, Enum mode);
	void endConditionalRender();
	void vertexAttribIPointer(UInt index, Int size, Enum type,
			Sizei stride, const(void)* pointer);
	void getVertexAttribIiv(UInt index, Enum pname, Int* params);
	void getVertexAttribIuiv(UInt index, Enum pname, UInt* params);
	void vertexAttribI1i(UInt index, Int x);
	void vertexAttribI2i(UInt index, Int x, Int y);
	void vertexAttribI3i(UInt index, Int x, Int y, Int z);
	void vertexAttribI4i(UInt index, Int x, Int y, Int z, Int w);
	void vertexAttribI1Ui(UInt index, UInt x);
	void vertexAttribI2Ui(UInt index, UInt x, UInt y);
	void vertexAttribI3Ui(UInt index, UInt x, UInt y, UInt z);
	void vertexAttribI4Ui(UInt index, UInt x, UInt y, UInt z, UInt w);
	void vertexAttribI1iv(UInt index, const(Int)* v);
	void vertexAttribI2iv(UInt index, const(Int)* v);
	void vertexAttribI3iv(UInt index, const(Int)* v);
	void vertexAttribI4iv(UInt index, const(Int)* v);
	void vertexAttribI1Uiv(UInt index, const(UInt)* v);
	void vertexAttribI2Uiv(UInt index, const(UInt)* v);
	void vertexAttribI3Uiv(UInt index, const(UInt)* v);
	void vertexAttribI4Uiv(UInt index, const(UInt)* v);
	void vertexAttribI4bv(UInt index, const(Byte)* v);
	void vertexAttribI4sv(UInt index, const(Short)* v);
	void vertexAttribI4Ubv(UInt index, const(UByte)* v);
	void vertexAttribI4Usv(UInt index, const(UShort)* v);
	void getUniformuiv(UInt program, Int location, UInt* params);
	void bindFragDataLocation(UInt program, UInt color, const(Char)* name);
	Int getFragDataLocation(UInt program, const(Char)* name);
	void uniform1Ui(Int location, UInt v0);
	void uniform2Ui(Int location, UInt v0, UInt v1);
	void uniform3Ui(Int location, UInt v0, UInt v1, UInt v2);
	void uniform4Ui(Int location, UInt v0, UInt v1, UInt v2, UInt v3);
	void uniform1Uiv(Int location, Sizei count, const(UInt)* value);
	void uniform2Uiv(Int location, Sizei count, const(UInt)* value);
	void uniform3Uiv(Int location, Sizei count, const(UInt)* value);
	void uniform4Uiv(Int location, Sizei count, const(UInt)* value);
	void texParameterIiv(Enum target, Enum pname, const(Int)* params);
	void texParameterIuiv(Enum target, Enum pname, const(UInt)* params);
	void getTexParameterIiv(Enum target, Enum pname, Int* params);
	void getTexParameterIuiv(Enum target, Enum pname, UInt* params);
	void clearBufferiv(Enum buffer, Int drawbuffer, const(Int)* value);
	void clearBufferuiv(Enum buffer, Int drawbuffer, const(UInt)* value);
	void clearBufferfv(Enum buffer, Int drawbuffer, const(Float)* value);
	void clearBufferfi(Enum buffer, Int drawbuffer, Float depth, Int stencil);
	const(UByte)* getStringi(Enum name, UInt index);
	Boolean isRenderbuffer(UInt renderbuffer);
	void bindRenderbuffer(Enum target, UInt renderbuffer);
	void deleteRenderbuffers(Sizei n, const(UInt)* renderbuffers);
	void genRenderbuffers(Sizei n, UInt* renderbuffers);
	void renderbufferStorage(Enum target, Enum internalformat, Sizei width, Sizei height);
	void getRenderbufferParameteriv(Enum target, Enum pname, Int* params);
	Boolean isFramebuffer(UInt framebuffer);
	void bindFramebuffer(Enum target, UInt framebuffer);
	void deleteFramebuffers(Sizei n, const(UInt)* framebuffers);
	void genFramebuffers(Sizei n, UInt* framebuffers);
	Enum checkFramebufferStatus(Enum target);
	void framebufferTexture1D(Enum target, Enum attachment, Enum textarget,
			UInt texture, Int level);
	void framebufferTexture2D(Enum target, Enum attachment, Enum textarget,
			UInt texture, Int level);
	void framebufferTexture3D(Enum target, Enum attachment, Enum textarget,
			UInt texture, Int level, Int zoffset);
	void framebufferRenderbuffer(Enum target, Enum attachment,
			Enum renderbuffertarget, UInt renderbuffer);
	void getFramebufferAttachmentParameteriv(Enum target, Enum attachment,
			Enum pname, Int* params);
	void generateMipmap(Enum target);
	void blitFramebuffer(Int srcX0, Int srcY0, Int srcX1, Int srcY1,
			Int dstX0, Int dstY0, Int dstX1, Int dstY1, Bitfield mask, Enum filter);
	void renderbufferStorageMultisample(Enum target, Sizei samples,
			Enum internalformat, Sizei width, Sizei height);
	void framebufferTextureLayer(Enum target, Enum attachment, UInt texture,
			Int level, Int layer);
	void* mapBufferRange(Enum target, Intptr offset, Sizeiptr length, Bitfield access);
	void flushMappedBufferRange(Enum target, Intptr offset, Sizeiptr length);
	void bindVertexArray(UInt array);
	void deleteVertexArrays(Sizei n, const(UInt)* arrays);
	void genVertexArrays(Sizei n, UInt* arrays);
	Boolean isVertexArray(UInt array);

	enum SAMPLER_2D_RECT = 0x8B63;
	enum SAMPLER_2D_RECT_SHADOW = 0x8B64;
	enum SAMPLER_BUFFER = 0x8DC2;
	enum INT_SAMPLER_2D_RECT = 0x8DCD;
	enum INT_SAMPLER_BUFFER = 0x8DD0;
	enum UNSIGNED_INT_SAMPLER_2D_RECT = 0x8DD5;
	enum UNSIGNED_INT_SAMPLER_BUFFER = 0x8DD8;
	enum TEXTURE_BUFFER = 0x8C2A;
	enum MAX_TEXTURE_BUFFER_SIZE = 0x8C2B;
	enum TEXTURE_BINDING_BUFFER = 0x8C2C;
	enum TEXTURE_BUFFER_DATA_STORE_BINDING = 0x8C2D;
	enum TEXTURE_RECTANGLE = 0x84F5;
	enum TEXTURE_BINDING_RECTANGLE = 0x84F6;
	enum PROXY_TEXTURE_RECTANGLE = 0x84F7;
	enum MAX_RECTANGLE_TEXTURE_SIZE = 0x84F8;
	enum R8_SNORM = 0x8F94;
	enum RG8_SNORM = 0x8F95;
	enum RGB8_SNORM = 0x8F96;
	enum RGBA8_SNORM = 0x8F97;
	enum R16_SNORM = 0x8F98;
	enum RG16_SNORM = 0x8F99;
	enum RGB16_SNORM = 0x8F9A;
	enum RGBA16_SNORM = 0x8F9B;
	enum SIGNED_NORMALIZED = 0x8F9C;
	enum PRIMITIVE_RESTART = 0x8F9D;
	enum PRIMITIVE_RESTART_INDEX = 0x8F9E;
	enum COPY_READ_BUFFER = 0x8F36;
	enum COPY_WRITE_BUFFER = 0x8F37;
	enum UNIFORM_BUFFER = 0x8A11;
	enum UNIFORM_BUFFER_BINDING = 0x8A28;
	enum UNIFORM_BUFFER_START = 0x8A29;
	enum UNIFORM_BUFFER_SIZE = 0x8A2A;
	enum MAX_VERTEX_UNIFORM_BLOCKS = 0x8A2B;
	enum MAX_GEOMETRY_UNIFORM_BLOCKS = 0x8A2C;
	enum MAX_FRAGMENT_UNIFORM_BLOCKS = 0x8A2D;
	enum MAX_COMBINED_UNIFORM_BLOCKS = 0x8A2E;
	enum MAX_UNIFORM_BUFFER_BINDINGS = 0x8A2F;
	enum MAX_UNIFORM_BLOCK_SIZE = 0x8A30;
	enum MAX_COMBINED_VERTEX_UNIFORM_COMPONENTS = 0x8A31;
	enum MAX_COMBINED_GEOMETRY_UNIFORM_COMPONENTS = 0x8A32;
	enum MAX_COMBINED_FRAGMENT_UNIFORM_COMPONENTS = 0x8A33;
	enum UNIFORM_BUFFER_OFFSET_ALIGNMENT = 0x8A34;
	enum ACTIVE_UNIFORM_BLOCK_MAX_NAME_LENGTH = 0x8A35;
	enum ACTIVE_UNIFORM_BLOCKS = 0x8A36;
	enum UNIFORM_TYPE = 0x8A37;
	enum UNIFORM_SIZE = 0x8A38;
	enum UNIFORM_NAME_LENGTH = 0x8A39;
	enum UNIFORM_BLOCK_INDEX = 0x8A3A;
	enum UNIFORM_OFFSET = 0x8A3B;
	enum UNIFORM_ARRAY_STRIDE = 0x8A3C;
	enum UNIFORM_MATRIX_STRIDE = 0x8A3D;
	enum UNIFORM_IS_ROW_MAJOR = 0x8A3E;
	enum UNIFORM_BLOCK_BINDING = 0x8A3F;
	enum UNIFORM_BLOCK_DATA_SIZE = 0x8A40;
	enum UNIFORM_BLOCK_NAME_LENGTH = 0x8A41;
	enum UNIFORM_BLOCK_ACTIVE_UNIFORMS = 0x8A42;
	enum UNIFORM_BLOCK_ACTIVE_UNIFORM_INDICES = 0x8A43;
	enum UNIFORM_BLOCK_REFERENCED_BY_VERTEX_SHADER = 0x8A44;
	enum UNIFORM_BLOCK_REFERENCED_BY_GEOMETRY_SHADER = 0x8A45;
	enum UNIFORM_BLOCK_REFERENCED_BY_FRAGMENT_SHADER = 0x8A46;
	enum INVALID_INDEX = 0xFFFFFFFFU;
	void drawArraysInstanced(Enum mode, Int first, Sizei count, Sizei instancecount);
	void drawElementsInstanced(Enum mode, Sizei count, Enum type,
			const(void)* indices, Sizei instancecount);
	void texBuffer(Enum target, Enum internalformat, UInt buffer);
	void primitiveRestartIndex(UInt index);
	void copyBufferSubData(Enum readTarget, Enum writeTarget,
			Intptr readOffset, Intptr writeOffset, Sizeiptr size);
	void getUniformIndices(UInt program, Sizei uniformCount,
			const(Char*)* uniformNames, UInt* uniformIndices);
	void getActiveUniformsiv(UInt program, Sizei uniformCount,
			const(UInt)* uniformIndices, Enum pname, Int* params);
	void getActiveUniformName(UInt program, UInt uniformIndex,
			Sizei bufSize, Sizei* length, Char* uniformName);
	UInt getUniformBlockIndex(UInt program, const(Char)* uniformBlockName);
	void getActiveUniformBlockiv(UInt program, UInt uniformBlockIndex,
			Enum pname, Int* params);
	void getActiveUniformBlockName(UInt program, UInt uniformBlockIndex,
			Sizei bufSize, Sizei* length, Char* uniformBlockName);
	void uniformBlockBinding(UInt program, UInt uniformBlockIndex, UInt uniformBlockBinding);

	struct Private_GLsync;
	alias Sync = Private_GLsync*;
	alias GLuint64 = c_ulong;
	alias GLint64 = c_long;
	enum CONTEXT_CORE_PROFILE_BIT = 0x00000001;
	enum CONTEXT_COMPATIBILITY_PROFILE_BIT = 0x00000002;
	enum LINES_ADJACENCY = 0x000A;
	enum LINE_STRIP_ADJACENCY = 0x000B;
	enum TRIANGLES_ADJACENCY = 0x000C;
	enum TRIANGLE_STRIP_ADJACENCY = 0x000D;
	enum PROGRAM_POINT_SIZE = 0x8642;
	enum MAX_GEOMETRY_TEXTURE_IMAGE_UNITS = 0x8C29;
	enum FRAMEBUFFER_ATTACHMENT_LAYERED = 0x8DA7;
	enum FRAMEBUFFER_INCOMPLETE_LAYER_TARGETS = 0x8DA8;
	enum GEOMETRY_SHADER = 0x8DD9;
	enum GEOMETRY_VERTICES_OUT = 0x8916;
	enum GEOMETRY_INPUT_TYPE = 0x8917;
	enum GEOMETRY_OUTPUT_TYPE = 0x8918;
	enum MAX_GEOMETRY_UNIFORM_COMPONENTS = 0x8DDF;
	enum MAX_GEOMETRY_OUTPUT_VERTICES = 0x8DE0;
	enum MAX_GEOMETRY_TOTAL_OUTPUT_COMPONENTS = 0x8DE1;
	enum MAX_VERTEX_OUTPUT_COMPONENTS = 0x9122;
	enum MAX_GEOMETRY_INPUT_COMPONENTS = 0x9123;
	enum MAX_GEOMETRY_OUTPUT_COMPONENTS = 0x9124;
	enum MAX_FRAGMENT_INPUT_COMPONENTS = 0x9125;
	enum CONTEXT_PROFILE_MASK = 0x9126;
	enum DEPTH_CLAMP = 0x864F;
	enum QUADS_FOLLOW_PROVOKING_VERTEX_CONVENTION = 0x8E4C;
	enum FIRST_VERTEX_CONVENTION = 0x8E4D;
	enum LAST_VERTEX_CONVENTION = 0x8E4E;
	enum PROVOKING_VERTEX = 0x8E4F;
	enum TEXTURE_CUBE_MAP_SEAMLESS = 0x884F;
	enum MAX_SERVER_WAIT_TIMEOUT = 0x9111;
	enum OBJECT_TYPE = 0x9112;
	enum SYNC_CONDITION = 0x9113;
	enum SYNC_STATUS = 0x9114;
	enum SYNC_FLAGS = 0x9115;
	enum SYNC_FENCE = 0x9116;
	enum SYNC_GPU_COMMANDS_COMPLETE = 0x9117;
	enum UNSIGNALED = 0x9118;
	enum SIGNALED = 0x9119;
	enum ALREADY_SIGNALED = 0x911A;
	enum TIMEOUT_EXPIRED = 0x911B;
	enum CONDITION_SATISFIED = 0x911C;
	enum WAIT_FAILED = 0x911D;
	enum TIMEOUT_IGNORED = 0xFFFFFFFFFFFFFFFFUL;
	enum SYNC_FLUSH_COMMANDS_BIT = 0x00000001;
	enum SAMPLE_POSITION = 0x8E50;
	enum SAMPLE_MASK = 0x8E51;
	enum SAMPLE_MASK_VALUE = 0x8E52;
	enum MAX_SAMPLE_MASK_WORDS = 0x8E59;
	enum TEXTURE_2D_MULTISAMPLE = 0x9100;
	enum PROXY_TEXTURE_2D_MULTISAMPLE = 0x9101;
	enum TEXTURE_2D_MULTISAMPLE_ARRAY = 0x9102;
	enum PROXY_TEXTURE_2D_MULTISAMPLE_ARRAY = 0x9103;
	enum TEXTURE_BINDING_2D_MULTISAMPLE = 0x9104;
	enum TEXTURE_BINDING_2D_MULTISAMPLE_ARRAY = 0x9105;
	enum TEXTURE_SAMPLES = 0x9106;
	enum TEXTURE_FIXED_SAMPLE_LOCATIONS = 0x9107;
	enum SAMPLER_2D_MULTISAMPLE = 0x9108;
	enum INT_SAMPLER_2D_MULTISAMPLE = 0x9109;
	enum UNSIGNED_INT_SAMPLER_2D_MULTISAMPLE = 0x910A;
	enum SAMPLER_2D_MULTISAMPLE_ARRAY = 0x910B;
	enum INT_SAMPLER_2D_MULTISAMPLE_ARRAY = 0x910C;
	enum UNSIGNED_INT_SAMPLER_2D_MULTISAMPLE_ARRAY = 0x910D;
	enum MAX_COLOR_TEXTURE_SAMPLES = 0x910E;
	enum MAX_DEPTH_TEXTURE_SAMPLES = 0x910F;
	enum MAX_INTEGER_SAMPLES = 0x9110;
	void drawElementsBaseVertex(Enum mode, Sizei count, Enum type,
			const(void)* indices, Int basevertex);
	void drawRangeElementsBaseVertex(Enum mode, UInt start, UInt end,
			Sizei count, Enum type, const(void)* indices, Int basevertex);
	void drawElementsInstancedBaseVertex(Enum mode, Sizei count, Enum type,
			const(void)* indices, Sizei instancecount, Int basevertex);
	void multiDrawElementsBaseVertex(Enum mode, const(Sizei)* count, Enum type,
			const(void*)* indices, Sizei drawcount, const(Int)* basevertex);
	void provokingVertex(Enum mode);
	Sync fenceSync(Enum condition, Bitfield flags);
	Boolean isSync(Sync sync);
	void deleteSync(Sync sync);
	Enum clientWaitSync(Sync sync, Bitfield flags, GLuint64 timeout);
	void waitSync(Sync sync, Bitfield flags, GLuint64 timeout);
	void getInteger64v(Enum pname, GLint64* data);
	void getSynciv(Sync sync, Enum pname, Sizei bufSize, Sizei* length, Int* values);
	void getInteger64i_v(Enum target, UInt index, GLint64* data);
	void getBufferParameteri64v(Enum target, Enum pname, GLint64* params);
	void framebufferTexture(Enum target, Enum attachment, UInt texture, Int level);
	void texImage2DMultisample(Enum target, Sizei samples, Enum internalformat,
			Sizei width, Sizei height, Boolean fixedsamplelocations);
	void texImage3DMultisample(Enum target, Sizei samples, Enum internalformat,
			Sizei width, Sizei height, Sizei depth, Boolean fixedsamplelocations);
	void getMultisamplefv(Enum pname, UInt index, Float* val);
	void sampleMaski(UInt maskNumber, Bitfield mask);

	enum VERTEX_ATTRIB_ARRAY_DIVISOR = 0x88FE;
	enum SRC1_COLOR = 0x88F9;
	enum ONE_MINUS_SRC1_COLOR = 0x88FA;
	enum ONE_MINUS_SRC1_ALPHA = 0x88FB;
	enum MAX_DUAL_SOURCE_DRAW_BUFFERS = 0x88FC;
	enum ANY_SAMPLES_PASSED = 0x8C2F;
	enum SAMPLER_BINDING = 0x8919;
	enum RGB10_A2UI = 0x906F;
	enum TEXTURE_SWIZZLE_R = 0x8E42;
	enum TEXTURE_SWIZZLE_G = 0x8E43;
	enum TEXTURE_SWIZZLE_B = 0x8E44;
	enum TEXTURE_SWIZZLE_A = 0x8E45;
	enum TEXTURE_SWIZZLE_RGBA = 0x8E46;
	enum TIME_ELAPSED = 0x88BF;
	enum TIMESTAMP = 0x8E28;
	enum INT_2_10_10_10_REV = 0x8D9F;
	void bindFragDataLocationIndexed(UInt program, UInt colorNumber,
			UInt index, const(Char)* name);
	Int getFragDataIndex(UInt program, const(Char)* name);
	void genSamplers(Sizei count, UInt* samplers);
	void deleteSamplers(Sizei count, const(UInt)* samplers);
	Boolean isSampler(UInt sampler);
	void bindSampler(UInt unit, UInt sampler);
	void samplerParameteri(UInt sampler, Enum pname, Int param);
	void samplerParameteriv(UInt sampler, Enum pname, const(Int)* param);
	void samplerParameterf(UInt sampler, Enum pname, Float param);
	void samplerParameterfv(UInt sampler, Enum pname, const(Float)* param);
	void samplerParameterIiv(UInt sampler, Enum pname, const(Int)* param);
	void samplerParameterIuiv(UInt sampler, Enum pname, const(UInt)* param);
	void getSamplerParameteriv(UInt sampler, Enum pname, Int* params);
	void getSamplerParameterIiv(UInt sampler, Enum pname, Int* params);
	void getSamplerParameterfv(UInt sampler, Enum pname, Float* params);
	void getSamplerParameterIuiv(UInt sampler, Enum pname, UInt* params);
	void queryCounter(UInt id, Enum target);
	void getQueryObjecti64v(UInt id, Enum pname, GLint64* params);
	void getQueryObjectui64v(UInt id, Enum pname, GLuint64* params);
	void vertexAttribDivisor(UInt index, UInt divisor);
	void vertexAttribP1Ui(UInt index, Enum type, Boolean normalized, UInt value);
	void vertexAttribP1Uiv(UInt index, Enum type, Boolean normalized, const(UInt)* value);
	void vertexAttribP2Ui(UInt index, Enum type, Boolean normalized, UInt value);
	void vertexAttribP2Uiv(UInt index, Enum type, Boolean normalized, const(UInt)* value);
	void vertexAttribP3Ui(UInt index, Enum type, Boolean normalized, UInt value);
	void vertexAttribP3Uiv(UInt index, Enum type, Boolean normalized, const(UInt)* value);
	void vertexAttribP4Ui(UInt index, Enum type, Boolean normalized, UInt value);
	void vertexAttribP4Uiv(UInt index, Enum type, Boolean normalized, const(UInt)* value);
	void vertexP2Ui(Enum type, UInt value);
	void vertexP2Uiv(Enum type, const(UInt)* value);
	void vertexP3Ui(Enum type, UInt value);
	void vertexP3Uiv(Enum type, const(UInt)* value);
	void vertexP4Ui(Enum type, UInt value);
	void vertexP4Uiv(Enum type, const(UInt)* value);
	void texCoordP1Ui(Enum type, UInt coords);
	void texCoordP1Uiv(Enum type, const(UInt)* coords);
	void texCoordP2Ui(Enum type, UInt coords);
	void texCoordP2Uiv(Enum type, const(UInt)* coords);
	void texCoordP3Ui(Enum type, UInt coords);
	void texCoordP3Uiv(Enum type, const(UInt)* coords);
	void texCoordP4Ui(Enum type, UInt coords);
	void texCoordP4Uiv(Enum type, const(UInt)* coords);
	void multiTexCoordP1Ui(Enum texture, Enum type, UInt coords);
	void multiTexCoordP1Uiv(Enum texture, Enum type, const(UInt)* coords);
	void multiTexCoordP2Ui(Enum texture, Enum type, UInt coords);
	void multiTexCoordP2Uiv(Enum texture, Enum type, const(UInt)* coords);
	void multiTexCoordP3Ui(Enum texture, Enum type, UInt coords);
	void multiTexCoordP3Uiv(Enum texture, Enum type, const(UInt)* coords);
	void multiTexCoordP4Ui(Enum texture, Enum type, UInt coords);
	void multiTexCoordP4Uiv(Enum texture, Enum type, const(UInt)* coords);
	void normalP3Ui(Enum type, UInt coords);
	void normalP3Uiv(Enum type, const(UInt)* coords);
	void colorP3Ui(Enum type, UInt color);
	void colorP3Uiv(Enum type, const(UInt)* color);
	void colorP4Ui(Enum type, UInt color);
	void colorP4Uiv(Enum type, const(UInt)* color);
	void secondaryColorP3Ui(Enum type, UInt color);
	void secondaryColorP3Uiv(Enum type, const(UInt)* color);

	enum SAMPLE_SHADING = 0x8C36;
	enum MIN_SAMPLE_SHADING_VALUE = 0x8C37;
	enum MIN_PROGRAM_TEXTURE_GATHER_OFFSET = 0x8E5E;
	enum MAX_PROGRAM_TEXTURE_GATHER_OFFSET = 0x8E5F;
	enum TEXTURE_CUBE_MAP_ARRAY = 0x9009;
	enum TEXTURE_BINDING_CUBE_MAP_ARRAY = 0x900A;
	enum PROXY_TEXTURE_CUBE_MAP_ARRAY = 0x900B;
	enum SAMPLER_CUBE_MAP_ARRAY = 0x900C;
	enum SAMPLER_CUBE_MAP_ARRAY_SHADOW = 0x900D;
	enum INT_SAMPLER_CUBE_MAP_ARRAY = 0x900E;
	enum UNSIGNED_INT_SAMPLER_CUBE_MAP_ARRAY = 0x900F;
	enum DRAW_INDIRECT_BUFFER = 0x8F3F;
	enum DRAW_INDIRECT_BUFFER_BINDING = 0x8F43;
	enum GEOMETRY_SHADER_INVOCATIONS = 0x887F;
	enum MAX_GEOMETRY_SHADER_INVOCATIONS = 0x8E5A;
	enum MIN_FRAGMENT_INTERPOLATION_OFFSET = 0x8E5B;
	enum MAX_FRAGMENT_INTERPOLATION_OFFSET = 0x8E5C;
	enum FRAGMENT_INTERPOLATION_OFFSET_BITS = 0x8E5D;
	enum MAX_VERTEX_STREAMS = 0x8E71;
	enum DOUBLE_VEC2 = 0x8FFC;
	enum DOUBLE_VEC3 = 0x8FFD;
	enum DOUBLE_VEC4 = 0x8FFE;
	enum DOUBLE_MAT2 = 0x8F46;
	enum DOUBLE_MAT3 = 0x8F47;
	enum DOUBLE_MAT4 = 0x8F48;
	enum DOUBLE_MAT2x3 = 0x8F49;
	enum DOUBLE_MAT2x4 = 0x8F4A;
	enum DOUBLE_MAT3x2 = 0x8F4B;
	enum DOUBLE_MAT3x4 = 0x8F4C;
	enum DOUBLE_MAT4x2 = 0x8F4D;
	enum DOUBLE_MAT4x3 = 0x8F4E;
	enum ACTIVE_SUBROUTINES = 0x8DE5;
	enum ACTIVE_SUBROUTINE_UNIFORMS = 0x8DE6;
	enum ACTIVE_SUBROUTINE_UNIFORM_LOCATIONS = 0x8E47;
	enum ACTIVE_SUBROUTINE_MAX_LENGTH = 0x8E48;
	enum ACTIVE_SUBROUTINE_UNIFORM_MAX_LENGTH = 0x8E49;
	enum MAX_SUBROUTINES = 0x8DE7;
	enum MAX_SUBROUTINE_UNIFORM_LOCATIONS = 0x8DE8;
	enum NUM_COMPATIBLE_SUBROUTINES = 0x8E4A;
	enum COMPATIBLE_SUBROUTINES = 0x8E4B;
	enum PATCHES = 0x000E;
	enum PATCH_VERTICES = 0x8E72;
	enum PATCH_DEFAULT_INNER_LEVEL = 0x8E73;
	enum PATCH_DEFAULT_OUTER_LEVEL = 0x8E74;
	enum TESS_CONTROL_OUTPUT_VERTICES = 0x8E75;
	enum TESS_GEN_MODE = 0x8E76;
	enum TESS_GEN_SPACING = 0x8E77;
	enum TESS_GEN_VERTEX_ORDER = 0x8E78;
	enum TESS_GEN_POINT_MODE = 0x8E79;
	enum ISOLINES = 0x8E7A;
	enum FRACTIONAL_ODD = 0x8E7B;
	enum FRACTIONAL_EVEN = 0x8E7C;
	enum MAX_PATCH_VERTICES = 0x8E7D;
	enum MAX_TESS_GEN_LEVEL = 0x8E7E;
	enum MAX_TESS_CONTROL_UNIFORM_COMPONENTS = 0x8E7F;
	enum MAX_TESS_EVALUATION_UNIFORM_COMPONENTS = 0x8E80;
	enum MAX_TESS_CONTROL_TEXTURE_IMAGE_UNITS = 0x8E81;
	enum MAX_TESS_EVALUATION_TEXTURE_IMAGE_UNITS = 0x8E82;
	enum MAX_TESS_CONTROL_OUTPUT_COMPONENTS = 0x8E83;
	enum MAX_TESS_PATCH_COMPONENTS = 0x8E84;
	enum MAX_TESS_CONTROL_TOTAL_OUTPUT_COMPONENTS = 0x8E85;
	enum MAX_TESS_EVALUATION_OUTPUT_COMPONENTS = 0x8E86;
	enum MAX_TESS_CONTROL_UNIFORM_BLOCKS = 0x8E89;
	enum MAX_TESS_EVALUATION_UNIFORM_BLOCKS = 0x8E8A;
	enum MAX_TESS_CONTROL_INPUT_COMPONENTS = 0x886C;
	enum MAX_TESS_EVALUATION_INPUT_COMPONENTS = 0x886D;
	enum MAX_COMBINED_TESS_CONTROL_UNIFORM_COMPONENTS = 0x8E1E;
	enum MAX_COMBINED_TESS_EVALUATION_UNIFORM_COMPONENTS = 0x8E1F;
	enum UNIFORM_BLOCK_REFERENCED_BY_TESS_CONTROL_SHADER = 0x84F0;
	enum UNIFORM_BLOCK_REFERENCED_BY_TESS_EVALUATION_SHADER = 0x84F1;
	enum TESS_EVALUATION_SHADER = 0x8E87;
	enum TESS_CONTROL_SHADER = 0x8E88;
	enum TRANSFORM_FEEDBACK = 0x8E22;
	enum TRANSFORM_FEEDBACK_BUFFER_PAUSED = 0x8E23;
	enum TRANSFORM_FEEDBACK_BUFFER_ACTIVE = 0x8E24;
	enum TRANSFORM_FEEDBACK_BINDING = 0x8E25;
	enum MAX_TRANSFORM_FEEDBACK_BUFFERS = 0x8E70;
	void minSampleShading(Float value);
	void blendEquationi(UInt buf, Enum mode);
	void blendEquationSeparatei(UInt buf, Enum modeRGB, Enum modeAlpha);
	void blendFunci(UInt buf, Enum src, Enum dst);
	void blendFuncSeparatei(UInt buf, Enum srcRGB, Enum dstRGB,
			Enum srcAlpha, Enum dstAlpha);
	void drawArraysIndirect(Enum mode, const(void)* indirect);
	void drawElementsIndirect(Enum mode, Enum type, const(void)* indirect);
	void uniform1d(Int location, Double x);
	void uniform2d(Int location, Double x, Double y);
	void uniform3d(Int location, Double x, Double y, Double z);
	void uniform4d(Int location, Double x, Double y, Double z, Double w);
	void uniform1dv(Int location, Sizei count, const(Double)* value);
	void uniform2dv(Int location, Sizei count, const(Double)* value);
	void uniform3dv(Int location, Sizei count, const(Double)* value);
	void uniform4dv(Int location, Sizei count, const(Double)* value);
	void uniformMatrix2dv(Int location, Sizei count, Boolean transpose,
			const(Double)* value);
	void uniformMatrix3dv(Int location, Sizei count, Boolean transpose,
			const(Double)* value);
	void uniformMatrix4dv(Int location, Sizei count, Boolean transpose,
			const(Double)* value);
	void uniformMatrix2x3dv(Int location, Sizei count, Boolean transpose,
			const(Double)* value);
	void uniformMatrix2x4dv(Int location, Sizei count, Boolean transpose,
			const(Double)* value);
	void uniformMatrix3x2dv(Int location, Sizei count, Boolean transpose,
			const(Double)* value);
	void uniformMatrix3x4dv(Int location, Sizei count, Boolean transpose,
			const(Double)* value);
	void uniformMatrix4x2dv(Int location, Sizei count, Boolean transpose,
			const(Double)* value);
	void uniformMatrix4x3dv(Int location, Sizei count, Boolean transpose,
			const(Double)* value);
	void getUniformdv(UInt program, Int location, Double* params);
	Int getSubroutineUniformLocation(UInt program, Enum shadertype, const(Char)* name);
	UInt getSubroutineIndex(UInt program, Enum shadertype, const(Char)* name);
	void getActiveSubroutineUniformiv(UInt program, Enum shadertype,
			UInt index, Enum pname, Int* values);
	void getActiveSubroutineUniformName(UInt program, Enum shadertype,
			UInt index, Sizei bufsize, Sizei* length, Char* name);
	void getActiveSubroutineName(UInt program, Enum shadertype, UInt index,
			Sizei bufsize, Sizei* length, Char* name);
	void uniformSubroutinesuiv(Enum shadertype, Sizei count, const(UInt)* indices);
	void getUniformSubroutineuiv(Enum shadertype, Int location, UInt* params);
	void getProgramStageiv(UInt program, Enum shadertype, Enum pname, Int* values);
	void patchParameteri(Enum pname, Int value);
	void patchParameterfv(Enum pname, const(Float)* values);
	void bindTransformFeedback(Enum target, UInt id);
	void deleteTransformFeedbacks(Sizei n, const(UInt)* ids);
	void genTransformFeedbacks(Sizei n, UInt* ids);
	Boolean isTransformFeedback(UInt id);
	void pauseTransformFeedback();
	void resumeTransformFeedback();
	void drawTransformFeedback(Enum mode, UInt id);
	void drawTransformFeedbackStream(Enum mode, UInt id, UInt stream);
	void beginQueryIndexed(Enum target, UInt index, UInt id);
	void endQueryIndexed(Enum target, UInt index);
	void getQueryIndexediv(Enum target, UInt index, Enum pname, Int* params);

	enum FIXED = 0x140C;
	enum IMPLEMENTATION_COLOR_READ_TYPE = 0x8B9A;
	enum IMPLEMENTATION_COLOR_READ_FORMAT = 0x8B9B;
	enum LOW_FLOAT = 0x8DF0;
	enum MEDIUM_FLOAT = 0x8DF1;
	enum HIGH_FLOAT = 0x8DF2;
	enum LOW_INT = 0x8DF3;
	enum MEDIUM_INT = 0x8DF4;
	enum HIGH_INT = 0x8DF5;
	enum SHADER_COMPILER = 0x8DFA;
	enum SHADER_BINARY_FORMATS = 0x8DF8;
	enum NUM_SHADER_BINARY_FORMATS = 0x8DF9;
	enum MAX_VERTEX_UNIFORM_VECTORS = 0x8DFB;
	enum MAX_VARYING_VECTORS = 0x8DFC;
	enum MAX_FRAGMENT_UNIFORM_VECTORS = 0x8DFD;
	enum RGB565 = 0x8D62;
	enum PROGRAM_BINARY_RETRIEVABLE_HINT = 0x8257;
	enum PROGRAM_BINARY_LENGTH = 0x8741;
	enum NUM_PROGRAM_BINARY_FORMATS = 0x87FE;
	enum PROGRAM_BINARY_FORMATS = 0x87FF;
	enum VERTEX_SHADER_BIT = 0x00000001;
	enum FRAGMENT_SHADER_BIT = 0x00000002;
	enum GEOMETRY_SHADER_BIT = 0x00000004;
	enum TESS_CONTROL_SHADER_BIT = 0x00000008;
	enum TESS_EVALUATION_SHADER_BIT = 0x00000010;
	enum ALL_SHADER_BITS = 0xFFFFFFFF;
	enum PROGRAM_SEPARABLE = 0x8258;
	enum ACTIVE_PROGRAM = 0x8259;
	enum PROGRAM_PIPELINE_BINDING = 0x825A;
	enum MAX_VIEWPORTS = 0x825B;
	enum VIEWPORT_SUBPIXEL_BITS = 0x825C;
	enum VIEWPORT_BOUNDS_RANGE = 0x825D;
	enum LAYER_PROVOKING_VERTEX = 0x825E;
	enum VIEWPORT_INDEX_PROVOKING_VERTEX = 0x825F;
	enum UNDEFINED_VERTEX = 0x8260;
	void releaseShaderCompiler();
	void shaderBinary(Sizei count, const(UInt)* shaders, Enum binaryformat,
			const(void)* binary, Sizei length);
	void getShaderPrecisionFormat(Enum shadertype, Enum precisiontype,
			Int* range, Int* precision);
	void depthRangef(Float n, Float f);
	void clearDepthf(Float d);
	void getProgramBinary(UInt program, Sizei bufSize, Sizei* length,
			Enum* binaryFormat, void* binary);
	void programBinary(UInt program, Enum binaryFormat, const(void)* binary, Sizei length);
	void programParameteri(UInt program, Enum pname, Int value);
	void useProgramStages(UInt pipeline, Bitfield stages, UInt program);
	void activeShaderProgram(UInt pipeline, UInt program);
	UInt createShaderProgramv(Enum type, Sizei count, const(Char*)* strings);
	void bindProgramPipeline(UInt pipeline);
	void deleteProgramPipelines(Sizei n, const(UInt)* pipelines);
	void genProgramPipelines(Sizei n, UInt* pipelines);
	Boolean isProgramPipeline(UInt pipeline);
	void getProgramPipelineiv(UInt pipeline, Enum pname, Int* params);
	void programUniform1i(UInt program, Int location, Int v0);
	void programUniform1iv(UInt program, Int location, Sizei count, const(Int)* value);
	void programUniform1f(UInt program, Int location, Float v0);
	void programUniform1fv(UInt program, Int location, Sizei count, const(Float)* value);
	void programUniform1d(UInt program, Int location, Double v0);
	void programUniform1dv(UInt program, Int location, Sizei count, const(Double)* value);
	void programUniform1Ui(UInt program, Int location, UInt v0);
	void programUniform1Uiv(UInt program, Int location, Sizei count, const(UInt)* value);
	void programUniform2i(UInt program, Int location, Int v0, Int v1);
	void programUniform2iv(UInt program, Int location, Sizei count, const(Int)* value);
	void programUniform2f(UInt program, Int location, Float v0, Float v1);
	void programUniform2fv(UInt program, Int location, Sizei count, const(Float)* value);
	void programUniform2d(UInt program, Int location, Double v0, Double v1);
	void programUniform2dv(UInt program, Int location, Sizei count, const(Double)* value);
	void programUniform2Ui(UInt program, Int location, UInt v0, UInt v1);
	void programUniform2Uiv(UInt program, Int location, Sizei count, const(UInt)* value);
	void programUniform3i(UInt program, Int location, Int v0, Int v1, Int v2);
	void programUniform3iv(UInt program, Int location, Sizei count, const(Int)* value);
	void programUniform3f(UInt program, Int location, Float v0, Float v1, Float v2);
	void programUniform3fv(UInt program, Int location, Sizei count, const(Float)* value);
	void programUniform3d(UInt program, Int location, Double v0, Double v1, Double v2);
	void programUniform3dv(UInt program, Int location, Sizei count, const(Double)* value);
	void programUniform3Ui(UInt program, Int location, UInt v0, UInt v1, UInt v2);
	void programUniform3Uiv(UInt program, Int location, Sizei count, const(UInt)* value);
	void programUniform4i(UInt program, Int location, Int v0, Int v1, Int v2, Int v3);
	void programUniform4iv(UInt program, Int location, Sizei count, const(Int)* value);
	void programUniform4f(UInt program, Int location, Float v0,
			Float v1, Float v2, Float v3);
	void programUniform4fv(UInt program, Int location, Sizei count, const(Float)* value);
	void programUniform4d(UInt program, Int location, Double v0, Double v1,
			Double v2, Double v3);
	void programUniform4dv(UInt program, Int location, Sizei count, const(Double)* value);
	void programUniform4Ui(UInt program, Int location, UInt v0, UInt v1, UInt v2,
			UInt v3);
	void programUniform4Uiv(UInt program, Int location, Sizei count, const(UInt)* value);
	void programUniformMatrix2fv(UInt program, Int location, Sizei count,
			Boolean transpose, const(Float)* value);
	void programUniformMatrix3fv(UInt program, Int location, Sizei count,
			Boolean transpose, const(Float)* value);
	void programUniformMatrix4fv(UInt program, Int location, Sizei count,
			Boolean transpose, const(Float)* value);
	void programUniformMatrix2dv(UInt program, Int location, Sizei count,
			Boolean transpose, const(Double)* value);
	void programUniformMatrix3dv(UInt program, Int location, Sizei count,
			Boolean transpose, const(Double)* value);
	void programUniformMatrix4dv(UInt program, Int location, Sizei count,
			Boolean transpose, const(Double)* value);
	void programUniformMatrix2x3fv(UInt program, Int location, Sizei count,
			Boolean transpose, const(Float)* value);
	void programUniformMatrix3x2fv(UInt program, Int location, Sizei count,
			Boolean transpose, const(Float)* value);
	void programUniformMatrix2x4fv(UInt program, Int location, Sizei count,
			Boolean transpose, const(Float)* value);
	void programUniformMatrix4x2fv(UInt program, Int location, Sizei count,
			Boolean transpose, const(Float)* value);
	void programUniformMatrix3x4fv(UInt program, Int location, Sizei count,
			Boolean transpose, const(Float)* value);
	void programUniformMatrix4x3fv(UInt program, Int location, Sizei count,
			Boolean transpose, const(Float)* value);
	void programUniformMatrix2x3dv(UInt program, Int location, Sizei count,
			Boolean transpose, const(Double)* value);
	void programUniformMatrix3x2dv(UInt program, Int location, Sizei count,
			Boolean transpose, const(Double)* value);
	void programUniformMatrix2x4dv(UInt program, Int location, Sizei count,
			Boolean transpose, const(Double)* value);
	void programUniformMatrix4x2dv(UInt program, Int location, Sizei count,
			Boolean transpose, const(Double)* value);
	void programUniformMatrix3x4dv(UInt program, Int location, Sizei count,
			Boolean transpose, const(Double)* value);
	void programUniformMatrix4x3dv(UInt program, Int location, Sizei count,
			Boolean transpose, const(Double)* value);
	void validateProgramPipeline(UInt pipeline);
	void getProgramPipelineInfoLog(UInt pipeline, Sizei bufSize,
			Sizei* length, Char* infoLog);
	void vertexAttribL1d(UInt index, Double x);
	void vertexAttribL2d(UInt index, Double x, Double y);
	void vertexAttribL3d(UInt index, Double x, Double y, Double z);
	void vertexAttribL4d(UInt index, Double x, Double y, Double z, Double w);
	void vertexAttribL1dv(UInt index, const(Double)* v);
	void vertexAttribL2dv(UInt index, const(Double)* v);
	void vertexAttribL3dv(UInt index, const(Double)* v);
	void vertexAttribL4dv(UInt index, const(Double)* v);
	void vertexAttribLPointer(UInt index, Int size, Enum type,
			Sizei stride, const(void)* pointer);
	void getVertexAttribLdv(UInt index, Enum pname, Double* params);
	void viewportArrayv(UInt first, Sizei count, const(Float)* v);
	void viewportIndexedf(UInt index, Float x, Float y, Float w, Float h);
	void viewportIndexedfv(UInt index, const(Float)* v);
	void scissorArrayv(UInt first, Sizei count, const(Int)* v);
	void scissorIndexed(UInt index, Int left, Int bottom, Sizei width, Sizei height);
	void scissorIndexedv(UInt index, const(Int)* v);
	void depthRangeArrayv(UInt first, Sizei count, const(Double)* v);
	void depthRangeIndexed(UInt index, Double n, Double f);
	void getFloati_v(Enum target, UInt index, Float* data);
	void getDoublei_v(Enum target, UInt index, Double* data);

	enum COPY_READ_BUFFER_BINDING = 0x8F36;
	enum COPY_WRITE_BUFFER_BINDING = 0x8F37;
	enum TRANSFORM_FEEDBACK_ACTIVE = 0x8E24;
	enum TRANSFORM_FEEDBACK_PAUSED = 0x8E23;
	enum UNPACK_COMPRESSED_BLOCK_WIDTH = 0x9127;
	enum UNPACK_COMPRESSED_BLOCK_HEIGHT = 0x9128;
	enum UNPACK_COMPRESSED_BLOCK_DEPTH = 0x9129;
	enum UNPACK_COMPRESSED_BLOCK_SIZE = 0x912A;
	enum PACK_COMPRESSED_BLOCK_WIDTH = 0x912B;
	enum PACK_COMPRESSED_BLOCK_HEIGHT = 0x912C;
	enum PACK_COMPRESSED_BLOCK_DEPTH = 0x912D;
	enum PACK_COMPRESSED_BLOCK_SIZE = 0x912E;
	enum NUM_SAMPLE_COUNTS = 0x9380;
	enum MIN_MAP_BUFFER_ALIGNMENT = 0x90BC;
	enum ATOMIC_COUNTER_BUFFER = 0x92C0;
	enum ATOMIC_COUNTER_BUFFER_BINDING = 0x92C1;
	enum ATOMIC_COUNTER_BUFFER_START = 0x92C2;
	enum ATOMIC_COUNTER_BUFFER_SIZE = 0x92C3;
	enum ATOMIC_COUNTER_BUFFER_DATA_SIZE = 0x92C4;
	enum ATOMIC_COUNTER_BUFFER_ACTIVE_ATOMIC_COUNTERS = 0x92C5;
	enum ATOMIC_COUNTER_BUFFER_ACTIVE_ATOMIC_COUNTER_INDICES = 0x92C6;
	enum ATOMIC_COUNTER_BUFFER_REFERENCED_BY_VERTEX_SHADER = 0x92C7;
	enum ATOMIC_COUNTER_BUFFER_REFERENCED_BY_TESS_CONTROL_SHADER = 0x92C8;
	enum ATOMIC_COUNTER_BUFFER_REFERENCED_BY_TESS_EVALUATION_SHADER = 0x92C9;
	enum ATOMIC_COUNTER_BUFFER_REFERENCED_BY_GEOMETRY_SHADER = 0x92CA;
	enum ATOMIC_COUNTER_BUFFER_REFERENCED_BY_FRAGMENT_SHADER = 0x92CB;
	enum MAX_VERTEX_ATOMIC_COUNTER_BUFFERS = 0x92CC;
	enum MAX_TESS_CONTROL_ATOMIC_COUNTER_BUFFERS = 0x92CD;
	enum MAX_TESS_EVALUATION_ATOMIC_COUNTER_BUFFERS = 0x92CE;
	enum MAX_GEOMETRY_ATOMIC_COUNTER_BUFFERS = 0x92CF;
	enum MAX_FRAGMENT_ATOMIC_COUNTER_BUFFERS = 0x92D0;
	enum MAX_COMBINED_ATOMIC_COUNTER_BUFFERS = 0x92D1;
	enum MAX_VERTEX_ATOMIC_COUNTERS = 0x92D2;
	enum MAX_TESS_CONTROL_ATOMIC_COUNTERS = 0x92D3;
	enum MAX_TESS_EVALUATION_ATOMIC_COUNTERS = 0x92D4;
	enum MAX_GEOMETRY_ATOMIC_COUNTERS = 0x92D5;
	enum MAX_FRAGMENT_ATOMIC_COUNTERS = 0x92D6;
	enum MAX_COMBINED_ATOMIC_COUNTERS = 0x92D7;
	enum MAX_ATOMIC_COUNTER_BUFFER_SIZE = 0x92D8;
	enum MAX_ATOMIC_COUNTER_BUFFER_BINDINGS = 0x92DC;
	enum ACTIVE_ATOMIC_COUNTER_BUFFERS = 0x92D9;
	enum UNIFORM_ATOMIC_COUNTER_BUFFER_INDEX = 0x92DA;
	enum UNSIGNED_INT_ATOMIC_COUNTER = 0x92DB;
	enum VERTEX_ATTRIB_ARRAY_BARRIER_BIT = 0x00000001;
	enum ELEMENT_ARRAY_BARRIER_BIT = 0x00000002;
	enum UNIFORM_BARRIER_BIT = 0x00000004;
	enum TEXTURE_FETCH_BARRIER_BIT = 0x00000008;
	enum SHADER_IMAGE_ACCESS_BARRIER_BIT = 0x00000020;
	enum COMMAND_BARRIER_BIT = 0x00000040;
	enum PIXEL_BUFFER_BARRIER_BIT = 0x00000080;
	enum TEXTURE_UPDATE_BARRIER_BIT = 0x00000100;
	enum BUFFER_UPDATE_BARRIER_BIT = 0x00000200;
	enum FRAMEBUFFER_BARRIER_BIT = 0x00000400;
	enum TRANSFORM_FEEDBACK_BARRIER_BIT = 0x00000800;
	enum ATOMIC_COUNTER_BARRIER_BIT = 0x00001000;
	enum ALL_BARRIER_BITS = 0xFFFFFFFF;
	enum MAX_IMAGE_UNITS = 0x8F38;
	enum MAX_COMBINED_IMAGE_UNITS_AND_FRAGMENT_OUTPUTS = 0x8F39;
	enum IMAGE_BINDING_NAME = 0x8F3A;
	enum IMAGE_BINDING_LEVEL = 0x8F3B;
	enum IMAGE_BINDING_LAYERED = 0x8F3C;
	enum IMAGE_BINDING_LAYER = 0x8F3D;
	enum IMAGE_BINDING_ACCESS = 0x8F3E;
	enum IMAGE_1D = 0x904C;
	enum IMAGE_2D = 0x904D;
	enum IMAGE_3D = 0x904E;
	enum IMAGE_2D_RECT = 0x904F;
	enum IMAGE_CUBE = 0x9050;
	enum IMAGE_BUFFER = 0x9051;
	enum IMAGE_1D_ARRAY = 0x9052;
	enum IMAGE_2D_ARRAY = 0x9053;
	enum IMAGE_CUBE_MAP_ARRAY = 0x9054;
	enum IMAGE_2D_MULTISAMPLE = 0x9055;
	enum IMAGE_2D_MULTISAMPLE_ARRAY = 0x9056;
	enum INT_IMAGE_1D = 0x9057;
	enum INT_IMAGE_2D = 0x9058;
	enum INT_IMAGE_3D = 0x9059;
	enum INT_IMAGE_2D_RECT = 0x905A;
	enum INT_IMAGE_CUBE = 0x905B;
	enum INT_IMAGE_BUFFER = 0x905C;
	enum INT_IMAGE_1D_ARRAY = 0x905D;
	enum INT_IMAGE_2D_ARRAY = 0x905E;
	enum INT_IMAGE_CUBE_MAP_ARRAY = 0x905F;
	enum INT_IMAGE_2D_MULTISAMPLE = 0x9060;
	enum INT_IMAGE_2D_MULTISAMPLE_ARRAY = 0x9061;
	enum UNSIGNED_INT_IMAGE_1D = 0x9062;
	enum UNSIGNED_INT_IMAGE_2D = 0x9063;
	enum UNSIGNED_INT_IMAGE_3D = 0x9064;
	enum UNSIGNED_INT_IMAGE_2D_RECT = 0x9065;
	enum UNSIGNED_INT_IMAGE_CUBE = 0x9066;
	enum UNSIGNED_INT_IMAGE_BUFFER = 0x9067;
	enum UNSIGNED_INT_IMAGE_1D_ARRAY = 0x9068;
	enum UNSIGNED_INT_IMAGE_2D_ARRAY = 0x9069;
	enum UNSIGNED_INT_IMAGE_CUBE_MAP_ARRAY = 0x906A;
	enum UNSIGNED_INT_IMAGE_2D_MULTISAMPLE = 0x906B;
	enum UNSIGNED_INT_IMAGE_2D_MULTISAMPLE_ARRAY = 0x906C;
	enum MAX_IMAGE_SAMPLES = 0x906D;
	enum IMAGE_BINDING_FORMAT = 0x906E;
	enum IMAGE_FORMAT_COMPATIBILITY_TYPE = 0x90C7;
	enum IMAGE_FORMAT_COMPATIBILITY_BY_SIZE = 0x90C8;
	enum IMAGE_FORMAT_COMPATIBILITY_BY_CLASS = 0x90C9;
	enum MAX_VERTEX_IMAGE_UNIFORMS = 0x90CA;
	enum MAX_TESS_CONTROL_IMAGE_UNIFORMS = 0x90CB;
	enum MAX_TESS_EVALUATION_IMAGE_UNIFORMS = 0x90CC;
	enum MAX_GEOMETRY_IMAGE_UNIFORMS = 0x90CD;
	enum MAX_FRAGMENT_IMAGE_UNIFORMS = 0x90CE;
	enum MAX_COMBINED_IMAGE_UNIFORMS = 0x90CF;
	enum COMPRESSED_RGBA_BPTC_UNORM = 0x8E8C;
	enum COMPRESSED_SRGB_ALPHA_BPTC_UNORM = 0x8E8D;
	enum COMPRESSED_RGB_BPTC_SIGNED_FLOAT = 0x8E8E;
	enum COMPRESSED_RGB_BPTC_UNSIGNED_FLOAT = 0x8E8F;
	enum TEXTURE_IMMUTABLE_FORMAT = 0x912F;
	void drawArraysInstancedBaseInstance(Enum mode, Int first, Sizei count,
			Sizei instancecount, UInt baseinstance);
	void drawElementsInstancedBaseInstance(Enum mode, Sizei count, Enum type,
			const(void)* indices, Sizei instancecount, UInt baseinstance);
	void drawElementsInstancedBaseVertexBaseInstance(Enum mode, Sizei count, Enum type,
			const(void)* indices, Sizei instancecount, Int basevertex, UInt baseinstance);
	void getInternalformativ(Enum target, Enum internalformat, Enum pname,
			Sizei bufSize, Int* params);
	void getActiveAtomicCounterBufferiv(UInt program, UInt bufferIndex,
			Enum pname, Int* params);
	void bindImageTexture(UInt unit, UInt texture, Int level,
			Boolean layered, Int layer, Enum access, Enum format);
	void memoryBarrier(Bitfield barriers);
	void texStorage1D(Enum target, Sizei levels, Enum internalformat, Sizei width);
	void texStorage2D(Enum target, Sizei levels, Enum internalformat,
			Sizei width, Sizei height);
	void texStorage3D(Enum target, Sizei levels, Enum internalformat,
			Sizei width, Sizei height, Sizei depth);
	void drawTransformFeedbackInstanced(Enum mode, UInt id, Sizei instancecount);
	void drawTransformFeedbackStreamInstanced(Enum mode, UInt id,
			UInt stream, Sizei instancecount);

	alias GLDEBUGPROC = void function(Enum source, Enum type, UInt id,
			Enum severity, Sizei length, const(Char)* message, const(void)* userParam);
	enum NUM_SHADING_LANGUAGE_VERSIONS = 0x82E9;
	enum VERTEX_ATTRIB_ARRAY_LONG = 0x874E;
	enum COMPRESSED_RGB8_ETC2 = 0x9274;
	enum COMPRESSED_SRGB8_ETC2 = 0x9275;
	enum COMPRESSED_RGB8_PUNCHTHROUGH_ALPHA1_ETC2 = 0x9276;
	enum COMPRESSED_SRGB8_PUNCHTHROUGH_ALPHA1_ETC2 = 0x9277;
	enum COMPRESSED_RGBA8_ETC2_EAC = 0x9278;
	enum COMPRESSED_SRGB8_ALPHA8_ETC2_EAC = 0x9279;
	enum COMPRESSED_R11_EAC = 0x9270;
	enum COMPRESSED_SIGNED_R11_EAC = 0x9271;
	enum COMPRESSED_RG11_EAC = 0x9272;
	enum COMPRESSED_SIGNED_RG11_EAC = 0x9273;
	enum PRIMITIVE_RESTART_FIXED_INDEX = 0x8D69;
	enum ANY_SAMPLES_PASSED_CONSERVATIVE = 0x8D6A;
	enum MAX_ELEMENT_INDEX = 0x8D6B;
	enum COMPUTE_SHADER = 0x91B9;
	enum MAX_COMPUTE_UNIFORM_BLOCKS = 0x91BB;
	enum MAX_COMPUTE_TEXTURE_IMAGE_UNITS = 0x91BC;
	enum MAX_COMPUTE_IMAGE_UNIFORMS = 0x91BD;
	enum MAX_COMPUTE_SHARED_MEMORY_SIZE = 0x8262;
	enum MAX_COMPUTE_UNIFORM_COMPONENTS = 0x8263;
	enum MAX_COMPUTE_ATOMIC_COUNTER_BUFFERS = 0x8264;
	enum MAX_COMPUTE_ATOMIC_COUNTERS = 0x8265;
	enum MAX_COMBINED_COMPUTE_UNIFORM_COMPONENTS = 0x8266;
	enum MAX_COMPUTE_WORK_GROUP_INVOCATIONS = 0x90EB;
	enum MAX_COMPUTE_WORK_GROUP_COUNT = 0x91BE;
	enum MAX_COMPUTE_WORK_GROUP_SIZE = 0x91BF;
	enum COMPUTE_WORK_GROUP_SIZE = 0x8267;
	enum UNIFORM_BLOCK_REFERENCED_BY_COMPUTE_SHADER = 0x90EC;
	enum ATOMIC_COUNTER_BUFFER_REFERENCED_BY_COMPUTE_SHADER = 0x90ED;
	enum DISPATCH_INDIRECT_BUFFER = 0x90EE;
	enum DISPATCH_INDIRECT_BUFFER_BINDING = 0x90EF;
	enum COMPUTE_SHADER_BIT = 0x00000020;
	enum DEBUG_OUTPUT_SYNCHRONOUS = 0x8242;
	enum DEBUG_NEXT_LOGGED_MESSAGE_LENGTH = 0x8243;
	enum DEBUG_CALLBACK_FUNCTION = 0x8244;
	enum DEBUG_CALLBACK_USER_PARAM = 0x8245;
	enum DEBUG_SOURCE_API = 0x8246;
	enum DEBUG_SOURCE_WINDOW_SYSTEM = 0x8247;
	enum DEBUG_SOURCE_SHADER_COMPILER = 0x8248;
	enum DEBUG_SOURCE_THIRD_PARTY = 0x8249;
	enum DEBUG_SOURCE_APPLICATION = 0x824A;
	enum DEBUG_SOURCE_OTHER = 0x824B;
	enum DEBUG_TYPE_ERROR = 0x824C;
	enum DEBUG_TYPE_DEPRECATED_BEHAVIOR = 0x824D;
	enum DEBUG_TYPE_UNDEFINED_BEHAVIOR = 0x824E;
	enum DEBUG_TYPE_PORTABILITY = 0x824F;
	enum DEBUG_TYPE_PERFORMANCE = 0x8250;
	enum DEBUG_TYPE_OTHER = 0x8251;
	enum MAX_DEBUG_MESSAGE_LENGTH = 0x9143;
	enum MAX_DEBUG_LOGGED_MESSAGES = 0x9144;
	enum DEBUG_LOGGED_MESSAGES = 0x9145;
	enum DEBUG_SEVERITY_HIGH = 0x9146;
	enum DEBUG_SEVERITY_MEDIUM = 0x9147;
	enum DEBUG_SEVERITY_LOW = 0x9148;
	enum DEBUG_TYPE_MARKER = 0x8268;
	enum DEBUG_TYPE_PUSH_GROUP = 0x8269;
	enum DEBUG_TYPE_POP_GROUP = 0x826A;
	enum DEBUG_SEVERITY_NOTIFICATION = 0x826B;
	enum MAX_DEBUG_GROUP_STACK_DEPTH = 0x826C;
	enum DEBUG_GROUP_STACK_DEPTH = 0x826D;
	enum BUFFER = 0x82E0;
	enum SHADER = 0x82E1;
	enum PROGRAM = 0x82E2;
	enum QUERY = 0x82E3;
	enum PROGRAM_PIPELINE = 0x82E4;
	enum SAMPLER = 0x82E6;
	enum MAX_LABEL_LENGTH = 0x82E8;
	enum DEBUG_OUTPUT = 0x92E0;
	enum CONTEXT_FLAG_DEBUG_BIT = 0x00000002;
	enum MAX_UNIFORM_LOCATIONS = 0x826E;
	enum FRAMEBUFFER_DEFAULT_WIDTH = 0x9310;
	enum FRAMEBUFFER_DEFAULT_HEIGHT = 0x9311;
	enum FRAMEBUFFER_DEFAULT_LAYERS = 0x9312;
	enum FRAMEBUFFER_DEFAULT_SAMPLES = 0x9313;
	enum FRAMEBUFFER_DEFAULT_FIXED_SAMPLE_LOCATIONS = 0x9314;
	enum MAX_FRAMEBUFFER_WIDTH = 0x9315;
	enum MAX_FRAMEBUFFER_HEIGHT = 0x9316;
	enum MAX_FRAMEBUFFER_LAYERS = 0x9317;
	enum MAX_FRAMEBUFFER_SAMPLES = 0x9318;
	enum INTERNALFORMAT_SUPPORTED = 0x826F;
	enum INTERNALFORMAT_PREFERRED = 0x8270;
	enum INTERNALFORMAT_RED_SIZE = 0x8271;
	enum INTERNALFORMAT_GREEN_SIZE = 0x8272;
	enum INTERNALFORMAT_BLUE_SIZE = 0x8273;
	enum INTERNALFORMAT_ALPHA_SIZE = 0x8274;
	enum INTERNALFORMAT_DEPTH_SIZE = 0x8275;
	enum INTERNALFORMAT_STENCIL_SIZE = 0x8276;
	enum INTERNALFORMAT_SHARED_SIZE = 0x8277;
	enum INTERNALFORMAT_RED_TYPE = 0x8278;
	enum INTERNALFORMAT_GREEN_TYPE = 0x8279;
	enum INTERNALFORMAT_BLUE_TYPE = 0x827A;
	enum INTERNALFORMAT_ALPHA_TYPE = 0x827B;
	enum INTERNALFORMAT_DEPTH_TYPE = 0x827C;
	enum INTERNALFORMAT_STENCIL_TYPE = 0x827D;
	enum MAX_WIDTH = 0x827E;
	enum MAX_HEIGHT = 0x827F;
	enum MAX_DEPTH = 0x8280;
	enum MAX_LAYERS = 0x8281;
	enum MAX_COMBINED_DIMENSIONS = 0x8282;
	enum COLOR_COMPONENTS = 0x8283;
	enum DEPTH_COMPONENTS = 0x8284;
	enum STENCIL_COMPONENTS = 0x8285;
	enum COLOR_RENDERABLE = 0x8286;
	enum DEPTH_RENDERABLE = 0x8287;
	enum STENCIL_RENDERABLE = 0x8288;
	enum FRAMEBUFFER_RENDERABLE = 0x8289;
	enum FRAMEBUFFER_RENDERABLE_LAYERED = 0x828A;
	enum FRAMEBUFFER_BLEND = 0x828B;
	enum READ_PIXELS = 0x828C;
	enum READ_PIXELS_FORMAT = 0x828D;
	enum READ_PIXELS_TYPE = 0x828E;
	enum TEXTURE_IMAGE_FORMAT = 0x828F;
	enum TEXTURE_IMAGE_TYPE = 0x8290;
	enum GET_TEXTURE_IMAGE_FORMAT = 0x8291;
	enum GET_TEXTURE_IMAGE_TYPE = 0x8292;
	enum MIPMAP = 0x8293;
	enum MANUAL_GENERATE_MIPMAP = 0x8294;
	enum AUTO_GENERATE_MIPMAP = 0x8295;
	enum COLOR_ENCODING = 0x8296;
	enum SRGB_READ = 0x8297;
	enum SRGB_WRITE = 0x8298;
	enum FILTER = 0x829A;
	enum VERTEX_TEXTURE = 0x829B;
	enum TESS_CONTROL_TEXTURE = 0x829C;
	enum TESS_EVALUATION_TEXTURE = 0x829D;
	enum GEOMETRY_TEXTURE = 0x829E;
	enum FRAGMENT_TEXTURE = 0x829F;
	enum COMPUTE_TEXTURE = 0x82A0;
	enum TEXTURE_SHADOW = 0x82A1;
	enum TEXTURE_GATHER = 0x82A2;
	enum TEXTURE_GATHER_SHADOW = 0x82A3;
	enum SHADER_IMAGE_LOAD = 0x82A4;
	enum SHADER_IMAGE_STORE = 0x82A5;
	enum SHADER_IMAGE_ATOMIC = 0x82A6;
	enum IMAGE_TEXEL_SIZE = 0x82A7;
	enum IMAGE_COMPATIBILITY_CLASS = 0x82A8;
	enum IMAGE_PIXEL_FORMAT = 0x82A9;
	enum IMAGE_PIXEL_TYPE = 0x82AA;
	enum SIMULTANEOUS_TEXTURE_AND_DEPTH_TEST = 0x82AC;
	enum SIMULTANEOUS_TEXTURE_AND_STENCIL_TEST = 0x82AD;
	enum SIMULTANEOUS_TEXTURE_AND_DEPTH_WRITE = 0x82AE;
	enum SIMULTANEOUS_TEXTURE_AND_STENCIL_WRITE = 0x82AF;
	enum TEXTURE_COMPRESSED_BLOCK_WIDTH = 0x82B1;
	enum TEXTURE_COMPRESSED_BLOCK_HEIGHT = 0x82B2;
	enum TEXTURE_COMPRESSED_BLOCK_SIZE = 0x82B3;
	enum CLEAR_BUFFER = 0x82B4;
	enum TEXTURE_VIEW = 0x82B5;
	enum VIEW_COMPATIBILITY_CLASS = 0x82B6;
	enum FULL_SUPPORT = 0x82B7;
	enum CAVEAT_SUPPORT = 0x82B8;
	enum IMAGE_CLASS_4_X_32 = 0x82B9;
	enum IMAGE_CLASS_2_X_32 = 0x82BA;
	enum IMAGE_CLASS_1_X_32 = 0x82BB;
	enum IMAGE_CLASS_4_X_16 = 0x82BC;
	enum IMAGE_CLASS_2_X_16 = 0x82BD;
	enum IMAGE_CLASS_1_X_16 = 0x82BE;
	enum IMAGE_CLASS_4_X_8 = 0x82BF;
	enum IMAGE_CLASS_2_X_8 = 0x82C0;
	enum IMAGE_CLASS_1_X_8 = 0x82C1;
	enum IMAGE_CLASS_11_11_10 = 0x82C2;
	enum IMAGE_CLASS_10_10_10_2 = 0x82C3;
	enum VIEW_CLASS_128_BITS = 0x82C4;
	enum VIEW_CLASS_96_BITS = 0x82C5;
	enum VIEW_CLASS_64_BITS = 0x82C6;
	enum VIEW_CLASS_48_BITS = 0x82C7;
	enum VIEW_CLASS_32_BITS = 0x82C8;
	enum VIEW_CLASS_24_BITS = 0x82C9;
	enum VIEW_CLASS_16_BITS = 0x82CA;
	enum VIEW_CLASS_8_BITS = 0x82CB;
	enum VIEW_CLASS_S3TC_DXT1_RGB = 0x82CC;
	enum VIEW_CLASS_S3TC_DXT1_RGBA = 0x82CD;
	enum VIEW_CLASS_S3TC_DXT3_RGBA = 0x82CE;
	enum VIEW_CLASS_S3TC_DXT5_RGBA = 0x82CF;
	enum VIEW_CLASS_RGTC1_RED = 0x82D0;
	enum VIEW_CLASS_RGTC2_RG = 0x82D1;
	enum VIEW_CLASS_BPTC_UNORM = 0x82D2;
	enum VIEW_CLASS_BPTC_FLOAT = 0x82D3;
	enum UNIFORM = 0x92E1;
	enum UNIFORM_BLOCK = 0x92E2;
	enum PROGRAM_INPUT = 0x92E3;
	enum PROGRAM_OUTPUT = 0x92E4;
	enum BUFFER_VARIABLE = 0x92E5;
	enum SHADER_STORAGE_BLOCK = 0x92E6;
	enum VERTEX_SUBROUTINE = 0x92E8;
	enum TESS_CONTROL_SUBROUTINE = 0x92E9;
	enum TESS_EVALUATION_SUBROUTINE = 0x92EA;
	enum GEOMETRY_SUBROUTINE = 0x92EB;
	enum FRAGMENT_SUBROUTINE = 0x92EC;
	enum COMPUTE_SUBROUTINE = 0x92ED;
	enum VERTEX_SUBROUTINE_UNIFORM = 0x92EE;
	enum TESS_CONTROL_SUBROUTINE_UNIFORM = 0x92EF;
	enum TESS_EVALUATION_SUBROUTINE_UNIFORM = 0x92F0;
	enum GEOMETRY_SUBROUTINE_UNIFORM = 0x92F1;
	enum FRAGMENT_SUBROUTINE_UNIFORM = 0x92F2;
	enum COMPUTE_SUBROUTINE_UNIFORM = 0x92F3;
	enum TRANSFORM_FEEDBACK_VARYING = 0x92F4;
	enum ACTIVE_RESOURCES = 0x92F5;
	enum MAX_NAME_LENGTH = 0x92F6;
	enum MAX_NUM_ACTIVE_VARIABLES = 0x92F7;
	enum MAX_NUM_COMPATIBLE_SUBROUTINES = 0x92F8;
	enum NAME_LENGTH = 0x92F9;
	enum TYPE = 0x92FA;
	enum ARRAY_SIZE = 0x92FB;
	enum OFFSET = 0x92FC;
	enum BLOCK_INDEX = 0x92FD;
	enum ARRAY_STRIDE = 0x92FE;
	enum MATRIX_STRIDE = 0x92FF;
	enum IS_ROW_MAJOR = 0x9300;
	enum ATOMIC_COUNTER_BUFFER_INDEX = 0x9301;
	enum BUFFER_BINDING = 0x9302;
	enum BUFFER_DATA_SIZE = 0x9303;
	enum NUM_ACTIVE_VARIABLES = 0x9304;
	enum ACTIVE_VARIABLES = 0x9305;
	enum REFERENCED_BY_VERTEX_SHADER = 0x9306;
	enum REFERENCED_BY_TESS_CONTROL_SHADER = 0x9307;
	enum REFERENCED_BY_TESS_EVALUATION_SHADER = 0x9308;
	enum REFERENCED_BY_GEOMETRY_SHADER = 0x9309;
	enum REFERENCED_BY_FRAGMENT_SHADER = 0x930A;
	enum REFERENCED_BY_COMPUTE_SHADER = 0x930B;
	enum TOP_LEVEL_ARRAY_SIZE = 0x930C;
	enum TOP_LEVEL_ARRAY_STRIDE = 0x930D;
	enum LOCATION = 0x930E;
	enum LOCATION_INDEX = 0x930F;
	enum IS_PER_PATCH = 0x92E7;
	enum SHADER_STORAGE_BUFFER = 0x90D2;
	enum SHADER_STORAGE_BUFFER_BINDING = 0x90D3;
	enum SHADER_STORAGE_BUFFER_START = 0x90D4;
	enum SHADER_STORAGE_BUFFER_SIZE = 0x90D5;
	enum MAX_VERTEX_SHADER_STORAGE_BLOCKS = 0x90D6;
	enum MAX_GEOMETRY_SHADER_STORAGE_BLOCKS = 0x90D7;
	enum MAX_TESS_CONTROL_SHADER_STORAGE_BLOCKS = 0x90D8;
	enum MAX_TESS_EVALUATION_SHADER_STORAGE_BLOCKS = 0x90D9;
	enum MAX_FRAGMENT_SHADER_STORAGE_BLOCKS = 0x90DA;
	enum MAX_COMPUTE_SHADER_STORAGE_BLOCKS = 0x90DB;
	enum MAX_COMBINED_SHADER_STORAGE_BLOCKS = 0x90DC;
	enum MAX_SHADER_STORAGE_BUFFER_BINDINGS = 0x90DD;
	enum MAX_SHADER_STORAGE_BLOCK_SIZE = 0x90DE;
	enum SHADER_STORAGE_BUFFER_OFFSET_ALIGNMENT = 0x90DF;
	enum SHADER_STORAGE_BARRIER_BIT = 0x00002000;
	enum MAX_COMBINED_SHADER_OUTPUT_RESOURCES = 0x8F39;
	enum DEPTH_STENCIL_TEXTURE_MODE = 0x90EA;
	enum TEXTURE_BUFFER_OFFSET = 0x919D;
	enum TEXTURE_BUFFER_SIZE = 0x919E;
	enum TEXTURE_BUFFER_OFFSET_ALIGNMENT = 0x919F;
	enum TEXTURE_VIEW_MIN_LEVEL = 0x82DB;
	enum TEXTURE_VIEW_NUM_LEVELS = 0x82DC;
	enum TEXTURE_VIEW_MIN_LAYER = 0x82DD;
	enum TEXTURE_VIEW_NUM_LAYERS = 0x82DE;
	enum TEXTURE_IMMUTABLE_LEVELS = 0x82DF;
	enum VERTEX_ATTRIB_BINDING = 0x82D4;
	enum VERTEX_ATTRIB_RELATIVE_OFFSET = 0x82D5;
	enum VERTEX_BINDING_DIVISOR = 0x82D6;
	enum VERTEX_BINDING_OFFSET = 0x82D7;
	enum VERTEX_BINDING_STRIDE = 0x82D8;
	enum MAX_VERTEX_ATTRIB_RELATIVE_OFFSET = 0x82D9;
	enum MAX_VERTEX_ATTRIB_BINDINGS = 0x82DA;
	enum VERTEX_BINDING_BUFFER = 0x8F4F;
	enum DISPLAY_LIST = 0x82E7;
	void clearBufferData(Enum target, Enum internalformat, Enum format,
			Enum type, const(void)* data);
	void clearBufferSubData(Enum target, Enum internalformat, Intptr offset,
			Sizeiptr size, Enum format, Enum type, const(void)* data);
	void dispatchCompute(UInt num_groups_x, UInt num_groups_y, UInt num_groups_z);
	void dispatchComputeIndirect(Intptr indirect);
	void copyImageSubData(UInt srcName, Enum srcTarget, Int srcLevel, Int srcX, Int srcY,
			Int srcZ, UInt dstName, Enum dstTarget, Int dstLevel, Int dstX,
			Int dstY, Int dstZ, Sizei srcWidth, Sizei srcHeight, Sizei srcDepth);
	void framebufferParameteri(Enum target, Enum pname, Int param);
	void getFramebufferParameteriv(Enum target, Enum pname, Int* params);
	void getInternalformati64v(Enum target, Enum internalformat, Enum pname,
			Sizei bufSize, GLint64* params);
	void invalidateTexSubImage(UInt texture, Int level, Int xoffset,
			Int yoffset, Int zoffset, Sizei width, Sizei height, Sizei depth);
	void invalidateTexImage(UInt texture, Int level);
	void invalidateBufferSubData(UInt buffer, Intptr offset, Sizeiptr length);
	void invalidateBufferData(UInt buffer);
	void invalidateFramebuffer(Enum target, Sizei numAttachments, const(Enum)* attachments);
	void invalidateSubFramebuffer(Enum target, Sizei numAttachments,
			const(Enum)* attachments, Int x, Int y, Sizei width, Sizei height);
	void multiDrawArraysIndirect(Enum mode, const(void)* indirect,
			Sizei drawcount, Sizei stride);
	void multiDrawElementsIndirect(Enum mode, Enum type,
			const(void)* indirect, Sizei drawcount, Sizei stride);
	void getProgramInterfaceiv(UInt program, Enum programInterface, Enum pname, Int* params);
	UInt getProgramResourceIndex(UInt program, Enum programInterface, const(Char)* name);
	void getProgramResourceName(UInt program, Enum programInterface,
			UInt index, Sizei bufSize, Sizei* length, Char* name);
	void getProgramResourceiv(UInt program, Enum programInterface, UInt index,
			Sizei propCount, const(Enum)* props, Sizei bufSize,
			Sizei* length, Int* params);
	Int getProgramResourceLocation(UInt program, Enum programInterface, const(Char)* name);
	Int getProgramResourceLocationIndex(UInt program,
			Enum programInterface, const(Char)* name);
	void shaderStorageBlockBinding(UInt program, UInt storageBlockIndex,
			UInt storageBlockBinding);
	void texBufferRange(Enum target, Enum internalformat, UInt buffer,
			Intptr offset, Sizeiptr size);
	void texStorage2DMultisample(Enum target, Sizei samples, Enum internalformat,
			Sizei width, Sizei height, Boolean fixedsamplelocations);
	void texStorage3DMultisample(Enum target, Sizei samples, Enum internalformat,
			Sizei width, Sizei height, Sizei depth, Boolean fixedsamplelocations);
	void textureView(UInt texture, Enum target, UInt origtexture, Enum internalformat,
			UInt minlevel, UInt numlevels, UInt minlayer, UInt numlayers);
	void bindVertexBuffer(UInt bindingindex, UInt buffer, Intptr offset, Sizei stride);
	void vertexAttribFormat(UInt attribindex, Int size, Enum type,
			Boolean normalized, UInt relativeoffset);
	void vertexAttribIFormat(UInt attribindex, Int size, Enum type, UInt relativeoffset);
	void vertexAttribLFormat(UInt attribindex, Int size, Enum type, UInt relativeoffset);
	void vertexAttribBinding(UInt attribindex, UInt bindingindex);
	void vertexBindingDivisor(UInt bindingindex, UInt divisor);
	void debugMessageControl(Enum source, Enum type, Enum severity,
			Sizei count, const(UInt)* ids, Boolean enabled);
	void debugMessageInsert(Enum source, Enum type, UInt id, Enum severity,
			Sizei length, const(Char)* buf);
	void debugMessageCallback(GLDEBUGPROC callback, const(void)* userParam);
	UInt getDebugMessageLog(UInt count, Sizei bufSize, Enum* sources, Enum* types,
			UInt* ids, Enum* severities, Sizei* lengths, Char* messageLog);
	void pushDebugGroup(Enum source, UInt id, Sizei length, const(Char)* message);
	void popDebugGroup();
	void objectLabel(Enum identifier, UInt name, Sizei length, const(Char)* label);
	void getObjectLabel(Enum identifier, UInt name, Sizei bufSize,
			Sizei* length, Char* label);
	void objectPtrLabel(const(void)* ptr, Sizei length, const(Char)* label);
	void getObjectPtrLabel(const(void)* ptr, Sizei bufSize, Sizei* length, Char* label);

	enum MAX_VERTEX_ATTRIB_STRIDE = 0x82E5;
	enum PRIMITIVE_RESTART_FOR_PATCHES_SUPPORTED = 0x8221;
	enum TEXTURE_BUFFER_BINDING = 0x8C2A;
	enum MAP_PERSISTENT_BIT = 0x0040;
	enum MAP_COHERENT_BIT = 0x0080;
	enum DYNAMIC_STORAGE_BIT = 0x0100;
	enum CLIENT_STORAGE_BIT = 0x0200;
	enum CLIENT_MAPPED_BUFFER_BARRIER_BIT = 0x00004000;
	enum BUFFER_IMMUTABLE_STORAGE = 0x821F;
	enum BUFFER_STORAGE_FLAGS = 0x8220;
	enum CLEAR_TEXTURE = 0x9365;
	enum LOCATION_COMPONENT = 0x934A;
	enum TRANSFORM_FEEDBACK_BUFFER_INDEX = 0x934B;
	enum TRANSFORM_FEEDBACK_BUFFER_STRIDE = 0x934C;
	enum QUERY_BUFFER = 0x9192;
	enum QUERY_BUFFER_BARRIER_BIT = 0x00008000;
	enum QUERY_BUFFER_BINDING = 0x9193;
	enum QUERY_RESULT_NO_WAIT = 0x9194;
	enum MIRROR_CLAMP_TO_EDGE = 0x8743;
	void bufferStorage(Enum target, Sizeiptr size, const(void)* data, Bitfield flags);
	void clearTexImage(UInt texture, Int level, Enum format, Enum type, const(void)* data);
	void clearTexSubImage(UInt texture, Int level, Int xoffset, Int yoffset, Int zoffset,
			Sizei width, Sizei height, Sizei depth, Enum format,
			Enum type, const(void)* data);
	void bindBuffersBase(Enum target, UInt first, Sizei count, const(UInt)* buffers);
	void bindBuffersRange(Enum target, UInt first, Sizei count,
			const(UInt)* buffers, const(Intptr)* offsets, const(Sizeiptr)* sizes);
	void bindTextures(UInt first, Sizei count, const(UInt)* textures);
	void bindSamplers(UInt first, Sizei count, const(UInt)* samplers);
	void bindImageTextures(UInt first, Sizei count, const(UInt)* textures);
	void bindVertexBuffers(UInt first, Sizei count, const(UInt)* buffers,
			const(Intptr)* offsets, const(Sizei)* strides);

	enum CONTEXT_LOST = 0x0507;
	enum NEGATIVE_ONE_TO_ONE = 0x935E;
	enum ZERO_TO_ONE = 0x935F;
	enum CLIP_ORIGIN = 0x935C;
	enum CLIP_DEPTH_MODE = 0x935D;
	enum QUERY_WAIT_INVERTED = 0x8E17;
	enum QUERY_NO_WAIT_INVERTED = 0x8E18;
	enum QUERY_BY_REGION_WAIT_INVERTED = 0x8E19;
	enum QUERY_BY_REGION_NO_WAIT_INVERTED = 0x8E1A;
	enum MAX_CULL_DISTANCES = 0x82F9;
	enum MAX_COMBINED_CLIP_AND_CULL_DISTANCES = 0x82FA;
	enum TEXTURE_TARGET = 0x1006;
	enum QUERY_TARGET = 0x82EA;
	enum GUILTY_CONTEXT_RESET = 0x8253;
	enum INNOCENT_CONTEXT_RESET = 0x8254;
	enum UNKNOWN_CONTEXT_RESET = 0x8255;
	enum RESET_NOTIFICATION_STRATEGY = 0x8256;
	enum LOSE_CONTEXT_ON_RESET = 0x8252;
	enum NO_RESET_NOTIFICATION = 0x8261;
	enum CONTEXT_FLAG_ROBUST_ACCESS_BIT = 0x00000004;
	enum CONTEXT_RELEASE_BEHAVIOR = 0x82FB;
	enum CONTEXT_RELEASE_BEHAVIOR_FLUSH = 0x82FC;
	void clipControl(Enum origin, Enum depth);
	void createTransformFeedbacks(Sizei n, UInt* ids);
	void transformFeedbackBufferBase(UInt xfb, UInt index, UInt buffer);
	void transformFeedbackBufferRange(UInt xfb, UInt index, UInt buffer,
			Intptr offset, Sizeiptr size);
	void getTransformFeedbackiv(UInt xfb, Enum pname, Int* param);
	void getTransformFeedbacki_v(UInt xfb, Enum pname, UInt index, Int* param);
	void getTransformFeedbacki64_v(UInt xfb, Enum pname, UInt index, GLint64* param);
	void createBuffers(Sizei n, UInt* buffers);
	void namedBufferStorage(UInt buffer, Sizeiptr size, const(void)* data, Bitfield flags);
	void namedBufferData(UInt buffer, Sizeiptr size, const(void)* data, Enum usage);
	void namedBufferSubData(UInt buffer, Intptr offset, Sizeiptr size, const(void)* data);
	void copyNamedBufferSubData(UInt readBuffer, UInt writeBuffer,
			Intptr readOffset, Intptr writeOffset, Sizeiptr size);
	void clearNamedBufferData(UInt buffer, Enum internalformat, Enum format,
			Enum type, const(void)* data);
	void clearNamedBufferSubData(UInt buffer, Enum internalformat,
			Intptr offset, Sizeiptr size, Enum format, Enum type, const(void)* data);
	void* mapNamedBuffer(UInt buffer, Enum access);
	void* mapNamedBufferRange(UInt buffer, Intptr offset, Sizeiptr length, Bitfield access);
	Boolean unmapNamedBuffer(UInt buffer);
	void flushMappedNamedBufferRange(UInt buffer, Intptr offset, Sizeiptr length);
	void getNamedBufferParameteriv(UInt buffer, Enum pname, Int* params);
	void getNamedBufferParameteri64v(UInt buffer, Enum pname, GLint64* params);
	void getNamedBufferPointerv(UInt buffer, Enum pname, void** params);
	void getNamedBufferSubData(UInt buffer, Intptr offset, Sizeiptr size, void* data);
	void createFramebuffers(Sizei n, UInt* framebuffers);
	void namedFramebufferRenderbuffer(UInt framebuffer, Enum attachment,
			Enum renderbuffertarget, UInt renderbuffer);
	void namedFramebufferParameteri(UInt framebuffer, Enum pname, Int param);
	void namedFramebufferTexture(UInt framebuffer, Enum attachment, UInt texture, Int level);
	void namedFramebufferTextureLayer(UInt framebuffer, Enum attachment,
			UInt texture, Int level, Int layer);
	void namedFramebufferDrawBuffer(UInt framebuffer, Enum buf);
	void namedFramebufferDrawBuffers(UInt framebuffer, Sizei n, const(Enum)* bufs);
	void namedFramebufferReadBuffer(UInt framebuffer, Enum src);
	void invalidateNamedFramebufferData(UInt framebuffer,
			Sizei numAttachments, const(Enum)* attachments);
	void invalidateNamedFramebufferSubData(UInt framebuffer, Sizei numAttachments,
			const(Enum)* attachments, Int x, Int y, Sizei width, Sizei height);
	void clearNamedFramebufferiv(UInt framebuffer, Enum buffer,
			Int drawbuffer, const(Int)* value);
	void clearNamedFramebufferuiv(UInt framebuffer, Enum buffer,
			Int drawbuffer, const(UInt)* value);
	void clearNamedFramebufferfv(UInt framebuffer, Enum buffer,
			Int drawbuffer, const(Float)* value);
	void clearNamedFramebufferfi(UInt framebuffer, Enum buffer,
			Int drawbuffer, Float depth, Int stencil);
	void blitNamedFramebuffer(UInt readFramebuffer, UInt drawFramebuffer, Int srcX0, Int srcY0,
			Int srcX1, Int srcY1, Int dstX0, Int dstY0, Int dstX1,
			Int dstY1, Bitfield mask, Enum filter);
	Enum checkNamedFramebufferStatus(UInt framebuffer, Enum target);
	void getNamedFramebufferParameteriv(UInt framebuffer, Enum pname, Int* param);
	void getNamedFramebufferAttachmentParameteriv(UInt framebuffer,
			Enum attachment, Enum pname, Int* params);
	void createRenderbuffers(Sizei n, UInt* renderbuffers);
	void namedRenderbufferStorage(UInt renderbuffer, Enum internalformat,
			Sizei width, Sizei height);
	void namedRenderbufferStorageMultisample(UInt renderbuffer,
			Sizei samples, Enum internalformat, Sizei width, Sizei height);
	void getNamedRenderbufferParameteriv(UInt renderbuffer, Enum pname, Int* params);
	void createTextures(Enum target, Sizei n, UInt* textures);
	void textureBuffer(UInt texture, Enum internalformat, UInt buffer);
	void textureBufferRange(UInt texture, Enum internalformat, UInt buffer,
			Intptr offset, Sizeiptr size);
	void textureStorage1D(UInt texture, Sizei levels, Enum internalformat, Sizei width);
	void textureStorage2D(UInt texture, Sizei levels, Enum internalformat,
			Sizei width, Sizei height);
	void textureStorage3D(UInt texture, Sizei levels, Enum internalformat,
			Sizei width, Sizei height, Sizei depth);
	void textureStorage2DMultisample(UInt texture, Sizei samples,
			Enum internalformat, Sizei width, Sizei height, Boolean fixedsamplelocations);
	void textureStorage3DMultisample(UInt texture, Sizei samples, Enum internalformat,
			Sizei width, Sizei height, Sizei depth, Boolean fixedsamplelocations);
	void textureSubImage1D(UInt texture, Int level, Int xoffset,
			Sizei width, Enum format, Enum type, const(void)* pixels);
	void textureSubImage2D(UInt texture, Int level, Int xoffset, Int yoffset,
			Sizei width, Sizei height, Enum format, Enum type, const(void)* pixels);
	void textureSubImage3D(UInt texture, Int level, Int xoffset, Int yoffset, Int zoffset,
			Sizei width, Sizei height, Sizei depth, Enum format,
			Enum type, const(void)* pixels);
	void compressedTextureSubImage1D(UInt texture, Int level, Int xoffset,
			Sizei width, Enum format, Sizei imageSize, const(void)* data);
	void compressedTextureSubImage2D(UInt texture, Int level, Int xoffset, Int yoffset,
			Sizei width, Sizei height, Enum format, Sizei imageSize, const(void)* data);
	void compressedTextureSubImage3D(UInt texture, Int level, Int xoffset, Int yoffset, Int zoffset,
			Sizei width, Sizei height, Sizei depth, Enum format,
			Sizei imageSize, const(void)* data);
	void copyTextureSubImage1D(UInt texture, Int level, Int xoffset, Int x,
			Int y, Sizei width);
	void copyTextureSubImage2D(UInt texture, Int level, Int xoffset,
			Int yoffset, Int x, Int y, Sizei width, Sizei height);
	void copyTextureSubImage3D(UInt texture, Int level, Int xoffset,
			Int yoffset, Int zoffset, Int x, Int y, Sizei width, Sizei height);
	void textureParameterf(UInt texture, Enum pname, Float param);
	void textureParameterfv(UInt texture, Enum pname, const(Float)* param);
	void textureParameteri(UInt texture, Enum pname, Int param);
	void textureParameterIiv(UInt texture, Enum pname, const(Int)* params);
	void textureParameterIuiv(UInt texture, Enum pname, const(UInt)* params);
	void textureParameteriv(UInt texture, Enum pname, const(Int)* param);
	void generateTextureMipmap(UInt texture);
	void bindTextureUnit(UInt unit, UInt texture);
	void getTextureImage(UInt texture, Int level, Enum format, Enum type,
			Sizei bufSize, void* pixels);
	void getCompressedTextureImage(UInt texture, Int level, Sizei bufSize, void* pixels);
	void getTextureLevelParameterfv(UInt texture, Int level, Enum pname, Float* params);
	void getTextureLevelParameteriv(UInt texture, Int level, Enum pname, Int* params);
	void getTextureParameterfv(UInt texture, Enum pname, Float* params);
	void getTextureParameterIiv(UInt texture, Enum pname, Int* params);
	void getTextureParameterIuiv(UInt texture, Enum pname, UInt* params);
	void getTextureParameteriv(UInt texture, Enum pname, Int* params);
	void createVertexArrays(Sizei n, UInt* arrays);
	void disableVertexArrayAttrib(UInt vaobj, UInt index);
	void enableVertexArrayAttrib(UInt vaobj, UInt index);
	void vertexArrayElementBuffer(UInt vaobj, UInt buffer);
	void vertexArrayVertexBuffer(UInt vaobj, UInt bindingindex, UInt buffer,
			Intptr offset, Sizei stride);
	void vertexArrayVertexBuffers(UInt vaobj, UInt first, Sizei count,
			const(UInt)* buffers, const(Intptr)* offsets, const(Sizei)* strides);
	void vertexArrayAttribBinding(UInt vaobj, UInt attribindex, UInt bindingindex);
	void vertexArrayAttribFormat(UInt vaobj, UInt attribindex, Int size,
			Enum type, Boolean normalized, UInt relativeoffset);
	void vertexArrayAttribIFormat(UInt vaobj, UInt attribindex, Int size,
			Enum type, UInt relativeoffset);
	void vertexArrayAttribLFormat(UInt vaobj, UInt attribindex, Int size,
			Enum type, UInt relativeoffset);
	void vertexArrayBindingDivisor(UInt vaobj, UInt bindingindex, UInt divisor);
	void getVertexArrayiv(UInt vaobj, Enum pname, Int* param);
	void getVertexArrayIndexediv(UInt vaobj, UInt index, Enum pname, Int* param);
	void getVertexArrayIndexed64iv(UInt vaobj, UInt index, Enum pname, GLint64* param);
	void createSamplers(Sizei n, UInt* samplers);
	void createProgramPipelines(Sizei n, UInt* pipelines);
	void createQueries(Enum target, Sizei n, UInt* ids);
	void getQueryBufferObjecti64v(UInt id, UInt buffer, Enum pname, Intptr offset);
	void getQueryBufferObjectiv(UInt id, UInt buffer, Enum pname, Intptr offset);
	void getQueryBufferObjectui64v(UInt id, UInt buffer, Enum pname, Intptr offset);
	void getQueryBufferObjectuiv(UInt id, UInt buffer, Enum pname, Intptr offset);
	void memoryBarrierByRegion(Bitfield barriers);
	void getTextureSubImage(UInt texture, Int level, Int xoffset, Int yoffset, Int zoffset,
			Sizei width, Sizei height, Sizei depth, Enum format,
			Enum type, Sizei bufSize, void* pixels);
	void getCompressedTextureSubImage(UInt texture, Int level, Int xoffset, Int yoffset,
			Int zoffset, Sizei width, Sizei height, Sizei depth,
			Sizei bufSize, void* pixels);
	Enum getGraphicsResetStatus();
	void getnCompressedTexImage(Enum target, Int lod, Sizei bufSize, void* pixels);
	void getnTexImage(Enum target, Int level, Enum format, Enum type,
			Sizei bufSize, void* pixels);
	void getnUniformdv(UInt program, Int location, Sizei bufSize, Double* params);
	void getnUniformfv(UInt program, Int location, Sizei bufSize, Float* params);
	void getnUniformiv(UInt program, Int location, Sizei bufSize, Int* params);
	void getnUniformuiv(UInt program, Int location, Sizei bufSize, UInt* params);
	void readnPixels(Int x, Int y, Sizei width, Sizei height, Enum format,
			Enum type, Sizei bufSize, void* data);
	void getnMapdv(Enum target, Enum query, Sizei bufSize, Double* v);
	void getnMapfv(Enum target, Enum query, Sizei bufSize, Float* v);
	void getnMapiv(Enum target, Enum query, Sizei bufSize, Int* v);
	void getnPixelMapfv(Enum map, Sizei bufSize, Float* values);
	void getnPixelMapuiv(Enum map, Sizei bufSize, UInt* values);
	void getnPixelMapusv(Enum map, Sizei bufSize, UShort* values);
	void getnPolygonStipple(Sizei bufSize, UByte* pattern);
	void getnColorTable(Enum target, Enum format, Enum type, Sizei bufSize, void* table);
	void getnConvolutionFilter(Enum target, Enum format, Enum type,
			Sizei bufSize, void* image);
	void getnSeparableFilter(Enum target, Enum format, Enum type,
			Sizei rowBufSize, void* row, Sizei columnBufSize, void* column, void* span);
	void getnHistogram(Enum target, Boolean reset, Enum format, Enum type,
			Sizei bufSize, void* values);
	void getnMinmax(Enum target, Boolean reset, Enum format, Enum type,
			Sizei bufSize, void* values);
	void textureBarrier();

	enum SHADER_BINARY_FORMAT_SPIR_V = 0x9551;
	enum SPIR_V_BINARY = 0x9552;
	enum PARAMETER_BUFFER = 0x80EE;
	enum PARAMETER_BUFFER_BINDING = 0x80EF;
	enum CONTEXT_FLAG_NO_ERROR_BIT = 0x00000008;
	enum VERTICES_SUBMITTED = 0x82EE;
	enum PRIMITIVES_SUBMITTED = 0x82EF;
	enum VERTEX_SHADER_INVOCATIONS = 0x82F0;
	enum TESS_CONTROL_SHADER_PATCHES = 0x82F1;
	enum TESS_EVALUATION_SHADER_INVOCATIONS = 0x82F2;
	enum GEOMETRY_SHADER_PRIMITIVES_EMITTED = 0x82F3;
	enum FRAGMENT_SHADER_INVOCATIONS = 0x82F4;
	enum COMPUTE_SHADER_INVOCATIONS = 0x82F5;
	enum CLIPPING_INPUT_PRIMITIVES = 0x82F6;
	enum CLIPPING_OUTPUT_PRIMITIVES = 0x82F7;
	enum POLYGON_OFFSET_CLAMP = 0x8E1B;
	enum SPIR_V_EXTENSIONS = 0x9553;
	enum NUM_SPIR_V_EXTENSIONS = 0x9554;
	enum TEXTURE_MAX_ANISOTROPY = 0x84FE;
	enum MAX_TEXTURE_MAX_ANISOTROPY = 0x84FF;
	enum TRANSFORM_FEEDBACK_OVERFLOW = 0x82EC;
	enum TRANSFORM_FEEDBACK_STREAM_OVERFLOW = 0x82ED;
	void specializeShader(UInt shader, const(Char)* pEntryPoint, UInt numSpecializationConstants,
			const(UInt)* pConstantIndex, const(UInt)* pConstantValue);
	void multiDrawArraysIndirectCount(Enum mode, const(void)* indirect,
			Intptr drawcount, Sizei maxdrawcount, Sizei stride);
	void multiDrawElementsIndirectCount(Enum mode, Enum type,
			const(void)* indirect, Intptr drawcount, Sizei maxdrawcount, Sizei stride);
	void polygonOffsetClamp(Float factor, Float units, Float clamp);

	enum PRIMITIVE_BOUNDING_BOX_ARB = 0x92BE;
	enum MULTISAMPLE_LINE_WIDTH_RANGE_ARB = 0x9381;
	enum MULTISAMPLE_LINE_WIDTH_GRANULARITY_ARB = 0x9382;
	void primitiveBoundingBoxARB(Float minX, Float minY, Float minZ,
			Float minW, Float maxX, Float maxY, Float maxZ, Float maxW);

	alias GLuint64EXT = c_ulong;
	enum UNSIGNED_INT64_ARB = 0x140F;
	GLuint64 getTextureHandleARB(UInt texture);
	GLuint64 getTextureSamplerHandleARB(UInt texture, UInt sampler);
	void makeTextureHandleResidentARB(GLuint64 handle);
	void makeTextureHandleNonResidentARB(GLuint64 handle);
	GLuint64 getImageHandleARB(UInt texture, Int level, Boolean layered,
			Int layer, Enum format);
	void makeImageHandleResidentARB(GLuint64 handle, Enum access);
	void makeImageHandleNonResidentARB(GLuint64 handle);
	void uniformHandleui64ARB(Int location, GLuint64 value);
	void uniformHandleui64vARB(Int location, Sizei count, const(GLuint64)* value);
	void programUniformHandleui64ARB(UInt program, Int location, GLuint64 value);
	void programUniformHandleui64vARB(UInt program, Int location,
			Sizei count, const(GLuint64)* values);
	Boolean isTextureHandleResidentARB(GLuint64 handle);
	Boolean isImageHandleResidentARB(GLuint64 handle);
	void vertexAttribL1Ui64ARB(UInt index, GLuint64EXT x);
	void vertexAttribL1Ui64vARB(UInt index, const(GLuint64EXT)* v);
	void getVertexAttribLui64vARB(UInt index, Enum pname, GLuint64EXT* params);

	struct Privatecl_context;
	struct Privatecl_event;
	enum SYNC_CL_EVENT_ARB = 0x8240;
	enum SYNC_CL_EVENT_COMPLETE_ARB = 0x8241;
	Sync createSyncFromCLeventARB(Privatecl_context* context,
			Privatecl_event* event, Bitfield flags);

	enum RGBA_FLOAT_MODE_ARB = 0x8820;
	enum CLAMP_VERTEX_COLOR_ARB = 0x891A;
	enum CLAMP_FRAGMENT_COLOR_ARB = 0x891B;
	enum CLAMP_READ_COLOR_ARB = 0x891C;
	enum FIXED_ONLY_ARB = 0x891D;
	void clampColorARB(Enum target, Enum clamp);

	enum MAX_COMPUTE_VARIABLE_GROUP_INVOCATIONS_ARB = 0x9344;
	enum MAX_COMPUTE_FIXED_GROUP_INVOCATIONS_ARB = 0x90EB;
	enum MAX_COMPUTE_VARIABLE_GROUP_SIZE_ARB = 0x9345;
	enum MAX_COMPUTE_FIXED_GROUP_SIZE_ARB = 0x91BF;
	void dispatchComputeGroupSizeARB(UInt num_groups_x, UInt num_groups_y,
			UInt num_groups_z, UInt group_size_x, UInt group_size_y, UInt group_size_z);

	alias GLDEBUGPROCARB = void function(Enum source, Enum type, UInt id,
			Enum severity, Sizei length, const(Char)* message, const(void)* userParam);
	enum DEBUG_OUTPUT_SYNCHRONOUS_ARB = 0x8242;
	enum DEBUG_NEXT_LOGGED_MESSAGE_LENGTH_ARB = 0x8243;
	enum DEBUG_CALLBACK_FUNCTION_ARB = 0x8244;
	enum DEBUG_CALLBACK_USER_PARAM_ARB = 0x8245;
	enum DEBUG_SOURCE_API_ARB = 0x8246;
	enum DEBUG_SOURCE_WINDOW_SYSTEM_ARB = 0x8247;
	enum DEBUG_SOURCE_SHADER_COMPILER_ARB = 0x8248;
	enum DEBUG_SOURCE_THIRD_PARTY_ARB = 0x8249;
	enum DEBUG_SOURCE_APPLICATION_ARB = 0x824A;
	enum DEBUG_SOURCE_OTHER_ARB = 0x824B;
	enum DEBUG_TYPE_ERROR_ARB = 0x824C;
	enum DEBUG_TYPE_DEPRECATED_BEHAVIOR_ARB = 0x824D;
	enum DEBUG_TYPE_UNDEFINED_BEHAVIOR_ARB = 0x824E;
	enum DEBUG_TYPE_PORTABILITY_ARB = 0x824F;
	enum DEBUG_TYPE_PERFORMANCE_ARB = 0x8250;
	enum DEBUG_TYPE_OTHER_ARB = 0x8251;
	enum MAX_DEBUG_MESSAGE_LENGTH_ARB = 0x9143;
	enum MAX_DEBUG_LOGGED_MESSAGES_ARB = 0x9144;
	enum DEBUG_LOGGED_MESSAGES_ARB = 0x9145;
	enum DEBUG_SEVERITY_HIGH_ARB = 0x9146;
	enum DEBUG_SEVERITY_MEDIUM_ARB = 0x9147;
	enum DEBUG_SEVERITY_LOW_ARB = 0x9148;
	void debugMessageControlARB(Enum source, Enum type, Enum severity,
			Sizei count, const(UInt)* ids, Boolean enabled);
	void debugMessageInsertARB(Enum source, Enum type, UInt id,
			Enum severity, Sizei length, const(Char)* buf);
	void debugMessageCallbackARB(GLDEBUGPROCARB callback, const(void)* userParam);
	UInt getDebugMessageLogARB(UInt count, Sizei bufSize, Enum* sources,
			Enum* types, UInt* ids, Enum* severities, Sizei* lengths, Char* messageLog);

	enum DEPTH_COMPONENT16_ARB = 0x81A5;
	enum DEPTH_COMPONENT24_ARB = 0x81A6;
	enum DEPTH_COMPONENT32_ARB = 0x81A7;
	enum TEXTURE_DEPTH_SIZE_ARB = 0x884A;
	enum DEPTH_TEXTURE_MODE_ARB = 0x884B;

	enum MAX_DRAW_BUFFERS_ARB = 0x8824;
	enum DRAW_BUFFER0_ARB = 0x8825;
	enum DRAW_BUFFER1_ARB = 0x8826;
	enum DRAW_BUFFER2_ARB = 0x8827;
	enum DRAW_BUFFER3_ARB = 0x8828;
	enum DRAW_BUFFER4_ARB = 0x8829;
	enum DRAW_BUFFER5_ARB = 0x882A;
	enum DRAW_BUFFER6_ARB = 0x882B;
	enum DRAW_BUFFER7_ARB = 0x882C;
	enum DRAW_BUFFER8_ARB = 0x882D;
	enum DRAW_BUFFER9_ARB = 0x882E;
	enum DRAW_BUFFER10_ARB = 0x882F;
	enum DRAW_BUFFER11_ARB = 0x8830;
	enum DRAW_BUFFER12_ARB = 0x8831;
	enum DRAW_BUFFER13_ARB = 0x8832;
	enum DRAW_BUFFER14_ARB = 0x8833;
	enum DRAW_BUFFER15_ARB = 0x8834;
	void drawBuffersARB(Sizei n, const(Enum)* bufs);

	void blendEquationiARB(UInt buf, Enum mode);
	void blendEquationSeparateiARB(UInt buf, Enum modeRGB, Enum modeAlpha);
	void blendFunciARB(UInt buf, Enum src, Enum dst);
	void blendFuncSeparateiARB(UInt buf, Enum srcRGB, Enum dstRGB,
			Enum srcAlpha, Enum dstAlpha);

	void drawArraysInstancedARB(Enum mode, Int first, Sizei count, Sizei primcount);
	void drawElementsInstancedARB(Enum mode, Sizei count, Enum type,
			const(void)* indices, Sizei primcount);

	enum FRAGMENT_PROGRAM_ARB = 0x8804;
	enum PROGRAM_FORMAT_ASCII_ARB = 0x8875;
	enum PROGRAM_LENGTH_ARB = 0x8627;
	enum PROGRAM_FORMAT_ARB = 0x8876;
	enum PROGRAM_BINDING_ARB = 0x8677;
	enum PROGRAM_INSTRUCTIONS_ARB = 0x88A0;
	enum MAX_PROGRAM_INSTRUCTIONS_ARB = 0x88A1;
	enum PROGRAM_NATIVE_INSTRUCTIONS_ARB = 0x88A2;
	enum MAX_PROGRAM_NATIVE_INSTRUCTIONS_ARB = 0x88A3;
	enum PROGRAM_TEMPORARIES_ARB = 0x88A4;
	enum MAX_PROGRAM_TEMPORARIES_ARB = 0x88A5;
	enum PROGRAM_NATIVE_TEMPORARIES_ARB = 0x88A6;
	enum MAX_PROGRAM_NATIVE_TEMPORARIES_ARB = 0x88A7;
	enum PROGRAM_PARAMETERS_ARB = 0x88A8;
	enum MAX_PROGRAM_PARAMETERS_ARB = 0x88A9;
	enum PROGRAM_NATIVE_PARAMETERS_ARB = 0x88AA;
	enum MAX_PROGRAM_NATIVE_PARAMETERS_ARB = 0x88AB;
	enum PROGRAM_ATTRIBS_ARB = 0x88AC;
	enum MAX_PROGRAM_ATTRIBS_ARB = 0x88AD;
	enum PROGRAM_NATIVE_ATTRIBS_ARB = 0x88AE;
	enum MAX_PROGRAM_NATIVE_ATTRIBS_ARB = 0x88AF;
	enum MAX_PROGRAM_LOCAL_PARAMETERS_ARB = 0x88B4;
	enum MAX_PROGRAM_ENV_PARAMETERS_ARB = 0x88B5;
	enum PROGRAM_UNDER_NATIVE_LIMITS_ARB = 0x88B6;
	enum PROGRAM_ALU_INSTRUCTIONS_ARB = 0x8805;
	enum PROGRAM_TEX_INSTRUCTIONS_ARB = 0x8806;
	enum PROGRAM_TEX_INDIRECTIONS_ARB = 0x8807;
	enum PROGRAM_NATIVE_ALU_INSTRUCTIONS_ARB = 0x8808;
	enum PROGRAM_NATIVE_TEX_INSTRUCTIONS_ARB = 0x8809;
	enum PROGRAM_NATIVE_TEX_INDIRECTIONS_ARB = 0x880A;
	enum MAX_PROGRAM_ALU_INSTRUCTIONS_ARB = 0x880B;
	enum MAX_PROGRAM_TEX_INSTRUCTIONS_ARB = 0x880C;
	enum MAX_PROGRAM_TEX_INDIRECTIONS_ARB = 0x880D;
	enum MAX_PROGRAM_NATIVE_ALU_INSTRUCTIONS_ARB = 0x880E;
	enum MAX_PROGRAM_NATIVE_TEX_INSTRUCTIONS_ARB = 0x880F;
	enum MAX_PROGRAM_NATIVE_TEX_INDIRECTIONS_ARB = 0x8810;
	enum PROGRAM_STRING_ARB = 0x8628;
	enum PROGRAM_ERROR_POSITION_ARB = 0x864B;
	enum CURRENT_MATRIX_ARB = 0x8641;
	enum TRANSPOSE_CURRENT_MATRIX_ARB = 0x88B7;
	enum CURRENT_MATRIX_STACK_DEPTH_ARB = 0x8640;
	enum MAX_PROGRAM_MATRICES_ARB = 0x862F;
	enum MAX_PROGRAM_MATRIX_STACK_DEPTH_ARB = 0x862E;
	enum MAX_TEXTURE_COORDS_ARB = 0x8871;
	enum MAX_TEXTURE_IMAGE_UNITS_ARB = 0x8872;
	enum PROGRAM_ERROR_STRING_ARB = 0x8874;
	enum MATRIX0_ARB = 0x88C0;
	enum MATRIX1_ARB = 0x88C1;
	enum MATRIX2_ARB = 0x88C2;
	enum MATRIX3_ARB = 0x88C3;
	enum MATRIX4_ARB = 0x88C4;
	enum MATRIX5_ARB = 0x88C5;
	enum MATRIX6_ARB = 0x88C6;
	enum MATRIX7_ARB = 0x88C7;
	enum MATRIX8_ARB = 0x88C8;
	enum MATRIX9_ARB = 0x88C9;
	enum MATRIX10_ARB = 0x88CA;
	enum MATRIX11_ARB = 0x88CB;
	enum MATRIX12_ARB = 0x88CC;
	enum MATRIX13_ARB = 0x88CD;
	enum MATRIX14_ARB = 0x88CE;
	enum MATRIX15_ARB = 0x88CF;
	enum MATRIX16_ARB = 0x88D0;
	enum MATRIX17_ARB = 0x88D1;
	enum MATRIX18_ARB = 0x88D2;
	enum MATRIX19_ARB = 0x88D3;
	enum MATRIX20_ARB = 0x88D4;
	enum MATRIX21_ARB = 0x88D5;
	enum MATRIX22_ARB = 0x88D6;
	enum MATRIX23_ARB = 0x88D7;
	enum MATRIX24_ARB = 0x88D8;
	enum MATRIX25_ARB = 0x88D9;
	enum MATRIX26_ARB = 0x88DA;
	enum MATRIX27_ARB = 0x88DB;
	enum MATRIX28_ARB = 0x88DC;
	enum MATRIX29_ARB = 0x88DD;
	enum MATRIX30_ARB = 0x88DE;
	enum MATRIX31_ARB = 0x88DF;
	void programStringARB(Enum target, Enum format, Sizei len, const(void)* string);
	void bindProgramARB(Enum target, UInt program);
	void deleteProgramsARB(Sizei n, const(UInt)* programs);
	void genProgramsARB(Sizei n, UInt* programs);
	void programEnvParameter4dARB(Enum target, UInt index, Double x,
			Double y, Double z, Double w);
	void programEnvParameter4dvARB(Enum target, UInt index, const(Double)* params);
	void programEnvParameter4fARB(Enum target, UInt index, Float x,
			Float y, Float z, Float w);
	void programEnvParameter4fvARB(Enum target, UInt index, const(Float)* params);
	void programLocalParameter4dARB(Enum target, UInt index, Double x,
			Double y, Double z, Double w);
	void programLocalParameter4dvARB(Enum target, UInt index, const(Double)* params);
	void programLocalParameter4fARB(Enum target, UInt index, Float x,
			Float y, Float z, Float w);
	void programLocalParameter4fvARB(Enum target, UInt index, const(Float)* params);
	void getProgramEnvParameterdvARB(Enum target, UInt index, Double* params);
	void getProgramEnvParameterfvARB(Enum target, UInt index, Float* params);
	void getProgramLocalParameterdvARB(Enum target, UInt index, Double* params);
	void getProgramLocalParameterfvARB(Enum target, UInt index, Float* params);
	void getProgramivARB(Enum target, Enum pname, Int* params);
	void getProgramStringARB(Enum target, Enum pname, void* string);
	Boolean isProgramARB(UInt program);

	enum FRAGMENT_SHADER_ARB = 0x8B30;
	enum MAX_FRAGMENT_UNIFORM_COMPONENTS_ARB = 0x8B49;
	enum FRAGMENT_SHADER_DERIVATIVE_HINT_ARB = 0x8B8B;

	enum LINES_ADJACENCY_ARB = 0x000A;
	enum LINE_STRIP_ADJACENCY_ARB = 0x000B;
	enum TRIANGLES_ADJACENCY_ARB = 0x000C;
	enum TRIANGLE_STRIP_ADJACENCY_ARB = 0x000D;
	enum PROGRAM_POINT_SIZE_ARB = 0x8642;
	enum MAX_GEOMETRY_TEXTURE_IMAGE_UNITS_ARB = 0x8C29;
	enum FRAMEBUFFER_ATTACHMENT_LAYERED_ARB = 0x8DA7;
	enum FRAMEBUFFER_INCOMPLETE_LAYER_TARGETS_ARB = 0x8DA8;
	enum FRAMEBUFFER_INCOMPLETE_LAYER_COUNT_ARB = 0x8DA9;
	enum GEOMETRY_SHADER_ARB = 0x8DD9;
	enum GEOMETRY_VERTICES_OUT_ARB = 0x8DDA;
	enum GEOMETRY_INPUT_TYPE_ARB = 0x8DDB;
	enum GEOMETRY_OUTPUT_TYPE_ARB = 0x8DDC;
	enum MAX_GEOMETRY_VARYING_COMPONENTS_ARB = 0x8DDD;
	enum MAX_VERTEX_VARYING_COMPONENTS_ARB = 0x8DDE;
	enum MAX_GEOMETRY_UNIFORM_COMPONENTS_ARB = 0x8DDF;
	enum MAX_GEOMETRY_OUTPUT_VERTICES_ARB = 0x8DE0;
	enum MAX_GEOMETRY_TOTAL_OUTPUT_COMPONENTS_ARB = 0x8DE1;
	void programParameteriARB(UInt program, Enum pname, Int value);
	void framebufferTextureARB(Enum target, Enum attachment, UInt texture, Int level);
	void framebufferTextureLayerARB(Enum target, Enum attachment,
			UInt texture, Int level, Int layer);
	void framebufferTextureFaceARB(Enum target, Enum attachment,
			UInt texture, Int level, Enum face);

	enum SHADER_BINARY_FORMAT_SPIR_V_ARB = 0x9551;
	enum SPIR_V_BINARY_ARB = 0x9552;
	void specializeShaderARB(UInt shader, const(Char)* pEntryPoint,
			UInt numSpecializationConstants, const(UInt)* pConstantIndex,
			const(UInt)* pConstantValue);

	enum INT64_ARB = 0x140E;
	enum INT64_VEC2_ARB = 0x8FE9;
	enum INT64_VEC3_ARB = 0x8FEA;
	enum INT64_VEC4_ARB = 0x8FEB;
	enum UNSIGNED_INT64_VEC2_ARB = 0x8FF5;
	enum UNSIGNED_INT64_VEC3_ARB = 0x8FF6;
	enum UNSIGNED_INT64_VEC4_ARB = 0x8FF7;
	void uniform1i64ARB(Int location, GLint64 x);
	void uniform2i64ARB(Int location, GLint64 x, GLint64 y);
	void uniform3i64ARB(Int location, GLint64 x, GLint64 y, GLint64 z);
	void uniform4i64ARB(Int location, GLint64 x, GLint64 y, GLint64 z, GLint64 w);
	void uniform1i64vARB(Int location, Sizei count, const(GLint64)* value);
	void uniform2i64vARB(Int location, Sizei count, const(GLint64)* value);
	void uniform3i64vARB(Int location, Sizei count, const(GLint64)* value);
	void uniform4i64vARB(Int location, Sizei count, const(GLint64)* value);
	void uniform1Ui64ARB(Int location, GLuint64 x);
	void uniform2Ui64ARB(Int location, GLuint64 x, GLuint64 y);
	void uniform3Ui64ARB(Int location, GLuint64 x, GLuint64 y, GLuint64 z);
	void uniform4Ui64ARB(Int location, GLuint64 x, GLuint64 y, GLuint64 z, GLuint64 w);
	void uniform1Ui64vARB(Int location, Sizei count, const(GLuint64)* value);
	void uniform2Ui64vARB(Int location, Sizei count, const(GLuint64)* value);
	void uniform3Ui64vARB(Int location, Sizei count, const(GLuint64)* value);
	void uniform4Ui64vARB(Int location, Sizei count, const(GLuint64)* value);
	void getUniformi64vARB(UInt program, Int location, GLint64* params);
	void getUniformui64vARB(UInt program, Int location, GLuint64* params);
	void getnUniformi64vARB(UInt program, Int location, Sizei bufSize, GLint64* params);
	void getnUniformui64vARB(UInt program, Int location, Sizei bufSize, GLuint64* params);
	void programUniform1i64ARB(UInt program, Int location, GLint64 x);
	void programUniform2i64ARB(UInt program, Int location, GLint64 x, GLint64 y);
	void programUniform3i64ARB(UInt program, Int location, GLint64 x, GLint64 y, GLint64 z);
	void programUniform4i64ARB(UInt program, Int location, GLint64 x,
			GLint64 y, GLint64 z, GLint64 w);
	void programUniform1i64vARB(UInt program, Int location, Sizei count,
			const(GLint64)* value);
	void programUniform2i64vARB(UInt program, Int location, Sizei count,
			const(GLint64)* value);
	void programUniform3i64vARB(UInt program, Int location, Sizei count,
			const(GLint64)* value);
	void programUniform4i64vARB(UInt program, Int location, Sizei count,
			const(GLint64)* value);
	void programUniform1Ui64ARB(UInt program, Int location, GLuint64 x);
	void programUniform2Ui64ARB(UInt program, Int location, GLuint64 x, GLuint64 y);
	void programUniform3Ui64ARB(UInt program, Int location, GLuint64 x, GLuint64 y, GLuint64 z);
	void programUniform4Ui64ARB(UInt program, Int location, GLuint64 x,
			GLuint64 y, GLuint64 z, GLuint64 w);
	void programUniform1Ui64vARB(UInt program, Int location, Sizei count,
			const(GLuint64)* value);
	void programUniform2Ui64vARB(UInt program, Int location, Sizei count,
			const(GLuint64)* value);
	void programUniform3Ui64vARB(UInt program, Int location, Sizei count,
			const(GLuint64)* value);
	void programUniform4Ui64vARB(UInt program, Int location, Sizei count,
			const(GLuint64)* value);

	alias GLhalfARB = ushort;
	enum HALF_FLOAT_ARB = 0x140B;

	enum PARAMETER_BUFFER_ARB = 0x80EE;
	enum PARAMETER_BUFFER_BINDING_ARB = 0x80EF;
	void multiDrawArraysIndirectCountARB(Enum mode, const(void)* indirect,
			Intptr drawcount, Sizei maxdrawcount, Sizei stride);
	void multiDrawElementsIndirectCountARB(Enum mode, Enum type,
			const(void)* indirect, Intptr drawcount, Sizei maxdrawcount, Sizei stride);

	enum VERTEX_ATTRIB_ARRAY_DIVISOR_ARB = 0x88FE;
	void vertexAttribDivisorARB(UInt index, UInt divisor);

	enum SRGB_DECODE_ARB = 0x8299;
	enum VIEW_CLASS_EAC_R11 = 0x9383;
	enum VIEW_CLASS_EAC_RG11 = 0x9384;
	enum VIEW_CLASS_ETC2_RGB = 0x9385;
	enum VIEW_CLASS_ETC2_RGBA = 0x9386;
	enum VIEW_CLASS_ETC2_EAC_RGBA = 0x9387;
	enum VIEW_CLASS_ASTC_4x4_RGBA = 0x9388;
	enum VIEW_CLASS_ASTC_5x4_RGBA = 0x9389;
	enum VIEW_CLASS_ASTC_5x5_RGBA = 0x938A;
	enum VIEW_CLASS_ASTC_6x5_RGBA = 0x938B;
	enum VIEW_CLASS_ASTC_6x6_RGBA = 0x938C;
	enum VIEW_CLASS_ASTC_8x5_RGBA = 0x938D;
	enum VIEW_CLASS_ASTC_8x6_RGBA = 0x938E;
	enum VIEW_CLASS_ASTC_8x8_RGBA = 0x938F;
	enum VIEW_CLASS_ASTC_10x5_RGBA = 0x9390;
	enum VIEW_CLASS_ASTC_10x6_RGBA = 0x9391;
	enum VIEW_CLASS_ASTC_10x8_RGBA = 0x9392;
	enum VIEW_CLASS_ASTC_10x10_RGBA = 0x9393;
	enum VIEW_CLASS_ASTC_12x10_RGBA = 0x9394;
	enum VIEW_CLASS_ASTC_12x12_RGBA = 0x9395;

	enum MATRIX_PALETTE_ARB = 0x8840;
	enum MAX_MATRIX_PALETTE_STACK_DEPTH_ARB = 0x8841;
	enum MAX_PALETTE_MATRICES_ARB = 0x8842;
	enum CURRENT_PALETTE_MATRIX_ARB = 0x8843;
	enum MATRIX_INDEX_ARRAY_ARB = 0x8844;
	enum CURRENT_MATRIX_INDEX_ARB = 0x8845;
	enum MATRIX_INDEX_ARRAY_SIZE_ARB = 0x8846;
	enum MATRIX_INDEX_ARRAY_TYPE_ARB = 0x8847;
	enum MATRIX_INDEX_ARRAY_STRIDE_ARB = 0x8848;
	enum MATRIX_INDEX_ARRAY_POINTER_ARB = 0x8849;
	void currentPaletteMatrixARB(Int index);
	void matrixIndexubvARB(Int size, const(UByte)* indices);
	void matrixIndexusvARB(Int size, const(UShort)* indices);
	void matrixIndexuivARB(Int size, const(UInt)* indices);
	void matrixIndexPointerARB(Int size, Enum type, Sizei stride, const(void)* pointer);

	enum MULTISAMPLE_ARB = 0x809D;
	enum SAMPLE_ALPHA_TO_COVERAGE_ARB = 0x809E;
	enum SAMPLE_ALPHA_TO_ONE_ARB = 0x809F;
	enum SAMPLE_COVERAGE_ARB = 0x80A0;
	enum SAMPLE_BUFFERS_ARB = 0x80A8;
	enum SAMPLES_ARB = 0x80A9;
	enum SAMPLE_COVERAGE_VALUE_ARB = 0x80AA;
	enum SAMPLE_COVERAGE_INVERT_ARB = 0x80AB;
	enum MULTISAMPLE_BIT_ARB = 0x20000000;
	void sampleCoverageARB(Float value, Boolean invert);

	enum QUERY_COUNTER_BITS_ARB = 0x8864;
	enum CURRENT_QUERY_ARB = 0x8865;
	enum QUERY_RESULT_ARB = 0x8866;
	enum QUERY_RESULT_AVAILABLE_ARB = 0x8867;
	enum SAMPLES_PASSED_ARB = 0x8914;
	void genQueriesARB(Sizei n, UInt* ids);
	void deleteQueriesARB(Sizei n, const(UInt)* ids);
	Boolean isQueryARB(UInt id);
	void beginQueryARB(Enum target, UInt id);
	void endQueryARB(Enum target);
	void getQueryivARB(Enum target, Enum pname, Int* params);
	void getQueryObjectivARB(UInt id, Enum pname, Int* params);
	void getQueryObjectuivARB(UInt id, Enum pname, UInt* params);

	enum MAX_SHADER_COMPILER_THREADS_ARB = 0x91B0;
	enum COMPLETION_STATUS_ARB = 0x91B1;
	void maxShaderCompilerThreadsARB(UInt count);

	enum VERTICES_SUBMITTED_ARB = 0x82EE;
	enum PRIMITIVES_SUBMITTED_ARB = 0x82EF;
	enum VERTEX_SHADER_INVOCATIONS_ARB = 0x82F0;
	enum TESS_CONTROL_SHADER_PATCHES_ARB = 0x82F1;
	enum TESS_EVALUATION_SHADER_INVOCATIONS_ARB = 0x82F2;
	enum GEOMETRY_SHADER_PRIMITIVES_EMITTED_ARB = 0x82F3;
	enum FRAGMENT_SHADER_INVOCATIONS_ARB = 0x82F4;
	enum COMPUTE_SHADER_INVOCATIONS_ARB = 0x82F5;
	enum CLIPPING_INPUT_PRIMITIVES_ARB = 0x82F6;
	enum CLIPPING_OUTPUT_PRIMITIVES_ARB = 0x82F7;

	enum PIXEL_PACK_BUFFER_ARB = 0x88EB;
	enum PIXEL_UNPACK_BUFFER_ARB = 0x88EC;
	enum PIXEL_PACK_BUFFER_BINDING_ARB = 0x88ED;
	enum PIXEL_UNPACK_BUFFER_BINDING_ARB = 0x88EF;

	enum POINT_SIZE_MIN_ARB = 0x8126;
	enum POINT_SIZE_MAX_ARB = 0x8127;
	enum POINT_FADE_THRESHOLD_SIZE_ARB = 0x8128;
	enum POINT_DISTANCE_ATTENUATION_ARB = 0x8129;
	void pointParameterfARB(Enum pname, Float param);
	void pointParameterfvARB(Enum pname, const(Float)* params);

	enum POINT_SPRITE_ARB = 0x8861;
	enum COORD_REPLACE_ARB = 0x8862;

	enum CONTEXT_FLAG_ROBUST_ACCESS_BIT_ARB = 0x00000004;
	enum LOSE_CONTEXT_ON_RESET_ARB = 0x8252;
	enum GUILTY_CONTEXT_RESET_ARB = 0x8253;
	enum INNOCENT_CONTEXT_RESET_ARB = 0x8254;
	enum UNKNOWN_CONTEXT_RESET_ARB = 0x8255;
	enum RESET_NOTIFICATION_STRATEGY_ARB = 0x8256;
	enum NO_RESET_NOTIFICATION_ARB = 0x8261;
	Enum getGraphicsResetStatusARB();
	void getnTexImageARB(Enum target, Int level, Enum format, Enum type,
			Sizei bufSize, void* img);
	void readnPixelsARB(Int x, Int y, Sizei width, Sizei height,
			Enum format, Enum type, Sizei bufSize, void* data);
	void getnCompressedTexImageARB(Enum target, Int lod, Sizei bufSize, void* img);
	void getnUniformfvARB(UInt program, Int location, Sizei bufSize, Float* params);
	void getnUniformivARB(UInt program, Int location, Sizei bufSize, Int* params);
	void getnUniformuivARB(UInt program, Int location, Sizei bufSize, UInt* params);
	void getnUniformdvARB(UInt program, Int location, Sizei bufSize, Double* params);
	void getnMapdvARB(Enum target, Enum query, Sizei bufSize, Double* v);
	void getnMapfvARB(Enum target, Enum query, Sizei bufSize, Float* v);
	void getnMapivARB(Enum target, Enum query, Sizei bufSize, Int* v);
	void getnPixelMapfvARB(Enum map, Sizei bufSize, Float* values);
	void getnPixelMapuivARB(Enum map, Sizei bufSize, UInt* values);
	void getnPixelMapusvARB(Enum map, Sizei bufSize, UShort* values);
	void getnPolygonStippleARB(Sizei bufSize, UByte* pattern);
	void getnColorTableARB(Enum target, Enum format, Enum type, Sizei bufSize, void* table);
	void getnConvolutionFilterARB(Enum target, Enum format, Enum type,
			Sizei bufSize, void* image);
	void getnSeparableFilterARB(Enum target, Enum format, Enum type,
			Sizei rowBufSize, void* row, Sizei columnBufSize, void* column, void* span);
	void getnHistogramARB(Enum target, Boolean reset, Enum format,
			Enum type, Sizei bufSize, void* values);
	void getnMinmaxARB(Enum target, Boolean reset, Enum format, Enum type,
			Sizei bufSize, void* values);

	enum SAMPLE_LOCATION_SUBPIXEL_BITS_ARB = 0x933D;
	enum SAMPLE_LOCATION_PIXEL_GRID_WIDTH_ARB = 0x933E;
	enum SAMPLE_LOCATION_PIXEL_GRID_HEIGHT_ARB = 0x933F;
	enum PROGRAMMABLE_SAMPLE_LOCATION_TABLE_SIZE_ARB = 0x9340;
	enum SAMPLE_LOCATION_ARB = 0x8E50;
	enum PROGRAMMABLE_SAMPLE_LOCATION_ARB = 0x9341;
	enum FRAMEBUFFER_PROGRAMMABLE_SAMPLE_LOCATIONS_ARB = 0x9342;
	enum FRAMEBUFFER_SAMPLE_LOCATION_PIXEL_GRID_ARB = 0x9343;
	void framebufferSampleLocationsfvARB(Enum target, UInt start,
			Sizei count, const(Float)* v);
	void namedFramebufferSampleLocationsfvARB(UInt framebuffer, UInt start,
			Sizei count, const(Float)* v);
	void evaluateDepthValuesARB();

	enum SAMPLE_SHADING_ARB = 0x8C36;
	enum MIN_SAMPLE_SHADING_VALUE_ARB = 0x8C37;
	void minSampleShadingARB(Float value);

	alias GLhandleARB = uint;

	alias GLcharARB = char;
	enum PROGRAM_OBJECT_ARB = 0x8B40;
	enum SHADER_OBJECT_ARB = 0x8B48;
	enum OBJECT_TYPE_ARB = 0x8B4E;
	enum OBJECT_SUBTYPE_ARB = 0x8B4F;
	enum FLOAT_VEC2_ARB = 0x8B50;
	enum FLOAT_VEC3_ARB = 0x8B51;
	enum FLOAT_VEC4_ARB = 0x8B52;
	enum INT_VEC2_ARB = 0x8B53;
	enum INT_VEC3_ARB = 0x8B54;
	enum INT_VEC4_ARB = 0x8B55;
	enum BOOL_ARB = 0x8B56;
	enum BOOL_VEC2_ARB = 0x8B57;
	enum BOOL_VEC3_ARB = 0x8B58;
	enum BOOL_VEC4_ARB = 0x8B59;
	enum FLOAT_MAT2_ARB = 0x8B5A;
	enum FLOAT_MAT3_ARB = 0x8B5B;
	enum FLOAT_MAT4_ARB = 0x8B5C;
	enum SAMPLER_1D_ARB = 0x8B5D;
	enum SAMPLER_2D_ARB = 0x8B5E;
	enum SAMPLER_3D_ARB = 0x8B5F;
	enum SAMPLER_CUBE_ARB = 0x8B60;
	enum SAMPLER_1D_SHADOW_ARB = 0x8B61;
	enum SAMPLER_2D_SHADOW_ARB = 0x8B62;
	enum SAMPLER_2D_RECT_ARB = 0x8B63;
	enum SAMPLER_2D_RECT_SHADOW_ARB = 0x8B64;
	enum OBJECT_DELETE_STATUS_ARB = 0x8B80;
	enum OBJECT_COMPILE_STATUS_ARB = 0x8B81;
	enum OBJECT_LINK_STATUS_ARB = 0x8B82;
	enum OBJECT_VALIDATE_STATUS_ARB = 0x8B83;
	enum OBJECT_INFO_LOG_LENGTH_ARB = 0x8B84;
	enum OBJECT_ATTACHED_OBJECTS_ARB = 0x8B85;
	enum OBJECT_ACTIVE_UNIFORMS_ARB = 0x8B86;
	enum OBJECT_ACTIVE_UNIFORM_MAX_LENGTH_ARB = 0x8B87;
	enum OBJECT_SHADER_SOURCE_LENGTH_ARB = 0x8B88;
	void deleteObjectARB(GLhandleARB obj);
	GLhandleARB getHandleARB(Enum pname);
	void detachObjectARB(GLhandleARB containerObj, GLhandleARB attachedObj);
	GLhandleARB createShaderObjectARB(Enum shaderType);
	void shaderSourceARB(GLhandleARB shaderObj, Sizei count,
			const(GLcharARB*)* string, const(Int)* length);
	void compileShaderARB(GLhandleARB shaderObj);
	GLhandleARB createProgramObjectARB();
	void attachObjectARB(GLhandleARB containerObj, GLhandleARB obj);
	void linkProgramARB(GLhandleARB programObj);
	void useProgramObjectARB(GLhandleARB programObj);
	void validateProgramARB(GLhandleARB programObj);
	void uniform1fARB(Int location, Float v0);
	void uniform2fARB(Int location, Float v0, Float v1);
	void uniform3fARB(Int location, Float v0, Float v1, Float v2);
	void uniform4fARB(Int location, Float v0, Float v1, Float v2, Float v3);
	void uniform1iARB(Int location, Int v0);
	void uniform2iARB(Int location, Int v0, Int v1);
	void uniform3iARB(Int location, Int v0, Int v1, Int v2);
	void uniform4iARB(Int location, Int v0, Int v1, Int v2, Int v3);
	void uniform1fvARB(Int location, Sizei count, const(Float)* value);
	void uniform2fvARB(Int location, Sizei count, const(Float)* value);
	void uniform3fvARB(Int location, Sizei count, const(Float)* value);
	void uniform4fvARB(Int location, Sizei count, const(Float)* value);
	void uniform1ivARB(Int location, Sizei count, const(Int)* value);
	void uniform2ivARB(Int location, Sizei count, const(Int)* value);
	void uniform3ivARB(Int location, Sizei count, const(Int)* value);
	void uniform4ivARB(Int location, Sizei count, const(Int)* value);
	void uniformMatrix2fvARB(Int location, Sizei count, Boolean transpose,
			const(Float)* value);
	void uniformMatrix3fvARB(Int location, Sizei count, Boolean transpose,
			const(Float)* value);
	void uniformMatrix4fvARB(Int location, Sizei count, Boolean transpose,
			const(Float)* value);
	void getObjectParameterfvARB(GLhandleARB obj, Enum pname, Float* params);
	void getObjectParameterivARB(GLhandleARB obj, Enum pname, Int* params);
	void getInfoLogARB(GLhandleARB obj, Sizei maxLength, Sizei* length, GLcharARB* infoLog);
	void getAttachedObjectsARB(GLhandleARB containerObj, Sizei maxCount,
			Sizei* count, GLhandleARB* obj);
	Int getUniformLocationARB(GLhandleARB programObj, const(GLcharARB)* name);
	void getActiveUniformARB(GLhandleARB programObj, UInt index, Sizei maxLength,
			Sizei* length, Int* size, Enum* type, GLcharARB* name);
	void getUniformfvARB(GLhandleARB programObj, Int location, Float* params);
	void getUniformivARB(GLhandleARB programObj, Int location, Int* params);
	void getShaderSourceARB(GLhandleARB obj, Sizei maxLength, Sizei* length, GLcharARB* source);

	enum SHADING_LANGUAGE_VERSION_ARB = 0x8B8C;

	enum SHADER_INCLUDE_ARB = 0x8DAE;
	enum NAMED_STRING_LENGTH_ARB = 0x8DE9;
	enum NAMED_STRING_TYPE_ARB = 0x8DEA;
	void namedStringARB(Enum type, Int namelen, const(Char)* name,
			Int stringlen, const(Char)* string);
	void deleteNamedStringARB(Int namelen, const(Char)* name);
	void compileShaderIncludeARB(UInt shader, Sizei count,
			const(Char*)* path, const(Int)* length);
	Boolean isNamedStringARB(Int namelen, const(Char)* name);
	void getNamedStringARB(Int namelen, const(Char)* name, Sizei bufSize,
			Int* stringlen, Char* string);
	void getNamedStringivARB(Int namelen, const(Char)* name, Enum pname, Int* params);

	enum TEXTURE_COMPARE_MODE_ARB = 0x884C;
	enum TEXTURE_COMPARE_FUNC_ARB = 0x884D;
	enum COMPARE_R_TO_TEXTURE_ARB = 0x884E;

	enum TEXTURE_COMPARE_FAIL_VALUE_ARB = 0x80BF;

	enum SPARSE_STORAGE_BIT_ARB = 0x0400;
	enum SPARSE_BUFFER_PAGE_SIZE_ARB = 0x82F8;
	void bufferPageCommitmentARB(Enum target, Intptr offset, Sizeiptr size, Boolean commit);
	void namedBufferPageCommitmentEXT(UInt buffer, Intptr offset,
			Sizeiptr size, Boolean commit);
	void namedBufferPageCommitmentARB(UInt buffer, Intptr offset,
			Sizeiptr size, Boolean commit);

	enum TEXTURE_SPARSE_ARB = 0x91A6;
	enum VIRTUAL_PAGE_SIZE_INDEX_ARB = 0x91A7;
	enum NUM_SPARSE_LEVELS_ARB = 0x91AA;
	enum NUM_VIRTUAL_PAGE_SIZES_ARB = 0x91A8;
	enum VIRTUAL_PAGE_SIZE_X_ARB = 0x9195;
	enum VIRTUAL_PAGE_SIZE_Y_ARB = 0x9196;
	enum VIRTUAL_PAGE_SIZE_Z_ARB = 0x9197;
	enum MAX_SPARSE_TEXTURE_SIZE_ARB = 0x9198;
	enum MAX_SPARSE_3D_TEXTURE_SIZE_ARB = 0x9199;
	enum MAX_SPARSE_ARRAY_TEXTURE_LAYERS_ARB = 0x919A;
	enum SPARSE_TEXTURE_FULL_ARRAY_CUBE_MIPMAPS_ARB = 0x91A9;
	void texPageCommitmentARB(Enum target, Int level, Int xoffset, Int yoffset,
			Int zoffset, Sizei width, Sizei height, Sizei depth, Boolean commit);

	enum CLAMP_TO_BORDER_ARB = 0x812D;

	enum TEXTURE_BUFFER_ARB = 0x8C2A;
	enum MAX_TEXTURE_BUFFER_SIZE_ARB = 0x8C2B;
	enum TEXTURE_BINDING_BUFFER_ARB = 0x8C2C;
	enum TEXTURE_BUFFER_DATA_STORE_BINDING_ARB = 0x8C2D;
	enum TEXTURE_BUFFER_FORMAT_ARB = 0x8C2E;
	void texBufferARB(Enum target, Enum internalformat, UInt buffer);

	enum COMPRESSED_ALPHA_ARB = 0x84E9;
	enum COMPRESSED_LUMINANCE_ARB = 0x84EA;
	enum COMPRESSED_LUMINANCE_ALPHA_ARB = 0x84EB;
	enum COMPRESSED_INTENSITY_ARB = 0x84EC;
	enum COMPRESSED_RGB_ARB = 0x84ED;
	enum COMPRESSED_RGBA_ARB = 0x84EE;
	enum TEXTURE_COMPRESSION_HINT_ARB = 0x84EF;
	enum TEXTURE_COMPRESSED_IMAGE_SIZE_ARB = 0x86A0;
	enum TEXTURE_COMPRESSED_ARB = 0x86A1;
	enum NUM_COMPRESSED_TEXTURE_FORMATS_ARB = 0x86A2;
	enum COMPRESSED_TEXTURE_FORMATS_ARB = 0x86A3;
	void compressedTexImage3DARB(Enum target, Int level, Enum internalformat, Sizei width,
			Sizei height, Sizei depth, Int border, Sizei imageSize, const(void)* data);
	void compressedTexImage2DARB(Enum target, Int level, Enum internalformat,
			Sizei width, Sizei height, Int border, Sizei imageSize, const(void)* data);
	void compressedTexImage1DARB(Enum target, Int level, Enum internalformat,
			Sizei width, Int border, Sizei imageSize, const(void)* data);
	void compressedTexSubImage3DARB(Enum target, Int level, Int xoffset, Int yoffset, Int zoffset,
			Sizei width, Sizei height, Sizei depth, Enum format,
			Sizei imageSize, const(void)* data);
	void compressedTexSubImage2DARB(Enum target, Int level, Int xoffset, Int yoffset,
			Sizei width, Sizei height, Enum format, Sizei imageSize, const(void)* data);
	void compressedTexSubImage1DARB(Enum target, Int level, Int xoffset,
			Sizei width, Enum format, Sizei imageSize, const(void)* data);
	void getCompressedTexImageARB(Enum target, Int level, void* img);

	enum COMPRESSED_RGBA_BPTC_UNORM_ARB = 0x8E8C;
	enum COMPRESSED_SRGB_ALPHA_BPTC_UNORM_ARB = 0x8E8D;
	enum COMPRESSED_RGB_BPTC_SIGNED_FLOAT_ARB = 0x8E8E;
	enum COMPRESSED_RGB_BPTC_UNSIGNED_FLOAT_ARB = 0x8E8F;

	enum NORMAL_MAP_ARB = 0x8511;
	enum REFLECTION_MAP_ARB = 0x8512;
	enum TEXTURE_CUBE_MAP_ARB = 0x8513;
	enum TEXTURE_BINDING_CUBE_MAP_ARB = 0x8514;
	enum TEXTURE_CUBE_MAP_POSITIVE_X_ARB = 0x8515;
	enum TEXTURE_CUBE_MAP_NEGATIVE_X_ARB = 0x8516;
	enum TEXTURE_CUBE_MAP_POSITIVE_Y_ARB = 0x8517;
	enum TEXTURE_CUBE_MAP_NEGATIVE_Y_ARB = 0x8518;
	enum TEXTURE_CUBE_MAP_POSITIVE_Z_ARB = 0x8519;
	enum TEXTURE_CUBE_MAP_NEGATIVE_Z_ARB = 0x851A;
	enum PROXY_TEXTURE_CUBE_MAP_ARB = 0x851B;
	enum MAX_CUBE_MAP_TEXTURE_SIZE_ARB = 0x851C;

	enum TEXTURE_CUBE_MAP_ARRAY_ARB = 0x9009;
	enum TEXTURE_BINDING_CUBE_MAP_ARRAY_ARB = 0x900A;
	enum PROXY_TEXTURE_CUBE_MAP_ARRAY_ARB = 0x900B;
	enum SAMPLER_CUBE_MAP_ARRAY_ARB = 0x900C;
	enum SAMPLER_CUBE_MAP_ARRAY_SHADOW_ARB = 0x900D;
	enum INT_SAMPLER_CUBE_MAP_ARRAY_ARB = 0x900E;
	enum UNSIGNED_INT_SAMPLER_CUBE_MAP_ARRAY_ARB = 0x900F;

	enum COMBINE_ARB = 0x8570;
	enum COMBINE_RGB_ARB = 0x8571;
	enum COMBINE_ALPHA_ARB = 0x8572;
	enum SOURCE0_RGB_ARB = 0x8580;
	enum SOURCE1_RGB_ARB = 0x8581;
	enum SOURCE2_RGB_ARB = 0x8582;
	enum SOURCE0_ALPHA_ARB = 0x8588;
	enum SOURCE1_ALPHA_ARB = 0x8589;
	enum SOURCE2_ALPHA_ARB = 0x858A;
	enum OPERAND0_RGB_ARB = 0x8590;
	enum OPERAND1_RGB_ARB = 0x8591;
	enum OPERAND2_RGB_ARB = 0x8592;
	enum OPERAND0_ALPHA_ARB = 0x8598;
	enum OPERAND1_ALPHA_ARB = 0x8599;
	enum OPERAND2_ALPHA_ARB = 0x859A;
	enum RGB_SCALE_ARB = 0x8573;
	enum ADD_SIGNED_ARB = 0x8574;
	enum INTERPOLATE_ARB = 0x8575;
	enum SUBTRACT_ARB = 0x84E7;
	enum CONSTANT_ARB = 0x8576;
	enum PRIMARY_COLOR_ARB = 0x8577;
	enum PREVIOUS_ARB = 0x8578;

	enum DOT3_RGB_ARB = 0x86AE;
	enum DOT3_RGBA_ARB = 0x86AF;

	enum TEXTURE_REDUCTION_MODE_ARB = 0x9366;
	enum WEIGHTED_AVERAGE_ARB = 0x9367;

	enum TEXTURE_RED_TYPE_ARB = 0x8C10;
	enum TEXTURE_GREEN_TYPE_ARB = 0x8C11;
	enum TEXTURE_BLUE_TYPE_ARB = 0x8C12;
	enum TEXTURE_ALPHA_TYPE_ARB = 0x8C13;
	enum TEXTURE_LUMINANCE_TYPE_ARB = 0x8C14;
	enum TEXTURE_INTENSITY_TYPE_ARB = 0x8C15;
	enum TEXTURE_DEPTH_TYPE_ARB = 0x8C16;
	enum UNSIGNED_NORMALIZED_ARB = 0x8C17;
	enum RGBA32F_ARB = 0x8814;
	enum RGB32F_ARB = 0x8815;
	enum ALPHA32F_ARB = 0x8816;
	enum INTENSITY32F_ARB = 0x8817;
	enum LUMINANCE32F_ARB = 0x8818;
	enum LUMINANCE_ALPHA32F_ARB = 0x8819;
	enum RGBA16F_ARB = 0x881A;
	enum RGB16F_ARB = 0x881B;
	enum ALPHA16F_ARB = 0x881C;
	enum INTENSITY16F_ARB = 0x881D;
	enum LUMINANCE16F_ARB = 0x881E;
	enum LUMINANCE_ALPHA16F_ARB = 0x881F;

	enum MIN_PROGRAM_TEXTURE_GATHER_OFFSET_ARB = 0x8E5E;
	enum MAX_PROGRAM_TEXTURE_GATHER_OFFSET_ARB = 0x8E5F;
	enum MAX_PROGRAM_TEXTURE_GATHER_COMPONENTS_ARB = 0x8F9F;

	enum MIRRORED_REPEAT_ARB = 0x8370;

	enum TEXTURE_RECTANGLE_ARB = 0x84F5;
	enum TEXTURE_BINDING_RECTANGLE_ARB = 0x84F6;
	enum PROXY_TEXTURE_RECTANGLE_ARB = 0x84F7;
	enum MAX_RECTANGLE_TEXTURE_SIZE_ARB = 0x84F8;

	enum TRANSFORM_FEEDBACK_OVERFLOW_ARB = 0x82EC;
	enum TRANSFORM_FEEDBACK_STREAM_OVERFLOW_ARB = 0x82ED;

	enum TRANSPOSE_MODELVIEW_MATRIX_ARB = 0x84E3;
	enum TRANSPOSE_PROJECTION_MATRIX_ARB = 0x84E4;
	enum TRANSPOSE_TEXTURE_MATRIX_ARB = 0x84E5;
	enum TRANSPOSE_COLOR_MATRIX_ARB = 0x84E6;
	void loadTransposeMatrixfARB(const(Float)* m);
	void loadTransposeMatrixdARB(const(Double)* m);
	void multTransposeMatrixfARB(const(Float)* m);
	void multTransposeMatrixdARB(const(Double)* m);

	enum MAX_VERTEX_UNITS_ARB = 0x86A4;
	enum ACTIVE_VERTEX_UNITS_ARB = 0x86A5;
	enum WEIGHT_SUM_UNITY_ARB = 0x86A6;
	enum VERTEX_BLEND_ARB = 0x86A7;
	enum CURRENT_WEIGHT_ARB = 0x86A8;
	enum WEIGHT_ARRAY_TYPE_ARB = 0x86A9;
	enum WEIGHT_ARRAY_STRIDE_ARB = 0x86AA;
	enum WEIGHT_ARRAY_SIZE_ARB = 0x86AB;
	enum WEIGHT_ARRAY_POINTER_ARB = 0x86AC;
	enum WEIGHT_ARRAY_ARB = 0x86AD;
	enum MODELVIEW0_ARB = 0x1700;
	enum MODELVIEW1_ARB = 0x850A;
	enum MODELVIEW2_ARB = 0x8722;
	enum MODELVIEW3_ARB = 0x8723;
	enum MODELVIEW4_ARB = 0x8724;
	enum MODELVIEW5_ARB = 0x8725;
	enum MODELVIEW6_ARB = 0x8726;
	enum MODELVIEW7_ARB = 0x8727;
	enum MODELVIEW8_ARB = 0x8728;
	enum MODELVIEW9_ARB = 0x8729;
	enum MODELVIEW10_ARB = 0x872A;
	enum MODELVIEW11_ARB = 0x872B;
	enum MODELVIEW12_ARB = 0x872C;
	enum MODELVIEW13_ARB = 0x872D;
	enum MODELVIEW14_ARB = 0x872E;
	enum MODELVIEW15_ARB = 0x872F;
	enum MODELVIEW16_ARB = 0x8730;
	enum MODELVIEW17_ARB = 0x8731;
	enum MODELVIEW18_ARB = 0x8732;
	enum MODELVIEW19_ARB = 0x8733;
	enum MODELVIEW20_ARB = 0x8734;
	enum MODELVIEW21_ARB = 0x8735;
	enum MODELVIEW22_ARB = 0x8736;
	enum MODELVIEW23_ARB = 0x8737;
	enum MODELVIEW24_ARB = 0x8738;
	enum MODELVIEW25_ARB = 0x8739;
	enum MODELVIEW26_ARB = 0x873A;
	enum MODELVIEW27_ARB = 0x873B;
	enum MODELVIEW28_ARB = 0x873C;
	enum MODELVIEW29_ARB = 0x873D;
	enum MODELVIEW30_ARB = 0x873E;
	enum MODELVIEW31_ARB = 0x873F;
	void weightbvARB(Int size, const(Byte)* weights);
	void weightsvARB(Int size, const(Short)* weights);
	void weightivARB(Int size, const(Int)* weights);
	void weightfvARB(Int size, const(Float)* weights);
	void weightdvARB(Int size, const(Double)* weights);
	void weightubvARB(Int size, const(UByte)* weights);
	void weightusvARB(Int size, const(UShort)* weights);
	void weightuivARB(Int size, const(UInt)* weights);
	void weightPointerARB(Int size, Enum type, Sizei stride, const(void)* pointer);
	void vertexBlendARB(Int count);

	alias GLsizeiptrARB = c_long;
	alias GLintptrARB = c_long;
	enum BUFFER_SIZE_ARB = 0x8764;
	enum BUFFER_USAGE_ARB = 0x8765;
	enum ARRAY_BUFFER_ARB = 0x8892;
	enum ELEMENT_ARRAY_BUFFER_ARB = 0x8893;
	enum ARRAY_BUFFER_BINDING_ARB = 0x8894;
	enum ELEMENT_ARRAY_BUFFER_BINDING_ARB = 0x8895;
	enum VERTEX_ARRAY_BUFFER_BINDING_ARB = 0x8896;
	enum NORMAL_ARRAY_BUFFER_BINDING_ARB = 0x8897;
	enum COLOR_ARRAY_BUFFER_BINDING_ARB = 0x8898;
	enum INDEX_ARRAY_BUFFER_BINDING_ARB = 0x8899;
	enum TEXTURE_COORD_ARRAY_BUFFER_BINDING_ARB = 0x889A;
	enum EDGE_FLAG_ARRAY_BUFFER_BINDING_ARB = 0x889B;
	enum SECONDARY_COLOR_ARRAY_BUFFER_BINDING_ARB = 0x889C;
	enum FOG_COORDINATE_ARRAY_BUFFER_BINDING_ARB = 0x889D;
	enum WEIGHT_ARRAY_BUFFER_BINDING_ARB = 0x889E;
	enum VERTEX_ATTRIB_ARRAY_BUFFER_BINDING_ARB = 0x889F;
	enum READ_ONLY_ARB = 0x88B8;
	enum WRITE_ONLY_ARB = 0x88B9;
	enum READ_WRITE_ARB = 0x88BA;
	enum BUFFER_ACCESS_ARB = 0x88BB;
	enum BUFFER_MAPPED_ARB = 0x88BC;
	enum BUFFER_MAP_POINTER_ARB = 0x88BD;
	enum STREAM_DRAW_ARB = 0x88E0;
	enum STREAM_READ_ARB = 0x88E1;
	enum STREAM_COPY_ARB = 0x88E2;
	enum STATIC_DRAW_ARB = 0x88E4;
	enum STATIC_READ_ARB = 0x88E5;
	enum STATIC_COPY_ARB = 0x88E6;
	enum DYNAMIC_DRAW_ARB = 0x88E8;
	enum DYNAMIC_READ_ARB = 0x88E9;
	enum DYNAMIC_COPY_ARB = 0x88EA;
	void bindBufferARB(Enum target, UInt buffer);
	void deleteBuffersARB(Sizei n, const(UInt)* buffers);
	void genBuffersARB(Sizei n, UInt* buffers);
	Boolean isBufferARB(UInt buffer);
	void bufferDataARB(Enum target, GLsizeiptrARB size, const(void)* data, Enum usage);
	void bufferSubDataARB(Enum target, GLintptrARB offset, GLsizeiptrARB size, const(void)* data);
	void getBufferSubDataARB(Enum target, GLintptrARB offset, GLsizeiptrARB size, void* data);
	void* mapBufferARB(Enum target, Enum access);
	Boolean unmapBufferARB(Enum target);
	void getBufferParameterivARB(Enum target, Enum pname, Int* params);
	void getBufferPointervARB(Enum target, Enum pname, void** params);

	enum COLOR_SUM_ARB = 0x8458;
	enum VERTEX_PROGRAM_ARB = 0x8620;
	enum VERTEX_ATTRIB_ARRAY_ENABLED_ARB = 0x8622;
	enum VERTEX_ATTRIB_ARRAY_SIZE_ARB = 0x8623;
	enum VERTEX_ATTRIB_ARRAY_STRIDE_ARB = 0x8624;
	enum VERTEX_ATTRIB_ARRAY_TYPE_ARB = 0x8625;
	enum CURRENT_VERTEX_ATTRIB_ARB = 0x8626;
	enum VERTEX_PROGRAM_POINT_SIZE_ARB = 0x8642;
	enum VERTEX_PROGRAM_TWO_SIDE_ARB = 0x8643;
	enum VERTEX_ATTRIB_ARRAY_POINTER_ARB = 0x8645;
	enum MAX_VERTEX_ATTRIBS_ARB = 0x8869;
	enum VERTEX_ATTRIB_ARRAY_NORMALIZED_ARB = 0x886A;
	enum PROGRAM_ADDRESS_REGISTERS_ARB = 0x88B0;
	enum MAX_PROGRAM_ADDRESS_REGISTERS_ARB = 0x88B1;
	enum PROGRAM_NATIVE_ADDRESS_REGISTERS_ARB = 0x88B2;
	enum MAX_PROGRAM_NATIVE_ADDRESS_REGISTERS_ARB = 0x88B3;
	void vertexAttrib1dARB(UInt index, Double x);
	void vertexAttrib1dvARB(UInt index, const(Double)* v);
	void vertexAttrib1fARB(UInt index, Float x);
	void vertexAttrib1fvARB(UInt index, const(Float)* v);
	void vertexAttrib1sARB(UInt index, Short x);
	void vertexAttrib1svARB(UInt index, const(Short)* v);
	void vertexAttrib2dARB(UInt index, Double x, Double y);
	void vertexAttrib2dvARB(UInt index, const(Double)* v);
	void vertexAttrib2fARB(UInt index, Float x, Float y);
	void vertexAttrib2fvARB(UInt index, const(Float)* v);
	void vertexAttrib2sARB(UInt index, Short x, Short y);
	void vertexAttrib2svARB(UInt index, const(Short)* v);
	void vertexAttrib3dARB(UInt index, Double x, Double y, Double z);
	void vertexAttrib3dvARB(UInt index, const(Double)* v);
	void vertexAttrib3fARB(UInt index, Float x, Float y, Float z);
	void vertexAttrib3fvARB(UInt index, const(Float)* v);
	void vertexAttrib3sARB(UInt index, Short x, Short y, Short z);
	void vertexAttrib3svARB(UInt index, const(Short)* v);
	void vertexAttrib4NbvARB(UInt index, const(Byte)* v);
	void vertexAttrib4NivARB(UInt index, const(Int)* v);
	void vertexAttrib4NsvARB(UInt index, const(Short)* v);
	void vertexAttrib4NubARB(UInt index, UByte x, UByte y, UByte z, UByte w);
	void vertexAttrib4NubvARB(UInt index, const(UByte)* v);
	void vertexAttrib4NuivARB(UInt index, const(UInt)* v);
	void vertexAttrib4NusvARB(UInt index, const(UShort)* v);
	void vertexAttrib4bvARB(UInt index, const(Byte)* v);
	void vertexAttrib4dARB(UInt index, Double x, Double y, Double z, Double w);
	void vertexAttrib4dvARB(UInt index, const(Double)* v);
	void vertexAttrib4fARB(UInt index, Float x, Float y, Float z, Float w);
	void vertexAttrib4fvARB(UInt index, const(Float)* v);
	void vertexAttrib4ivARB(UInt index, const(Int)* v);
	void vertexAttrib4sARB(UInt index, Short x, Short y, Short z, Short w);
	void vertexAttrib4svARB(UInt index, const(Short)* v);
	void vertexAttrib4UbvARB(UInt index, const(UByte)* v);
	void vertexAttrib4UivARB(UInt index, const(UInt)* v);
	void vertexAttrib4UsvARB(UInt index, const(UShort)* v);
	void vertexAttribPointerARB(UInt index, Int size, Enum type,
			Boolean normalized, Sizei stride, const(void)* pointer);
	void enableVertexAttribArrayARB(UInt index);
	void disableVertexAttribArrayARB(UInt index);
	void getVertexAttribdvARB(UInt index, Enum pname, Double* params);
	void getVertexAttribfvARB(UInt index, Enum pname, Float* params);
	void getVertexAttribivARB(UInt index, Enum pname, Int* params);
	void getVertexAttribPointervARB(UInt index, Enum pname, void** pointer);

	enum VERTEX_SHADER_ARB = 0x8B31;
	enum MAX_VERTEX_UNIFORM_COMPONENTS_ARB = 0x8B4A;
	enum MAX_VARYING_FLOATS_ARB = 0x8B4B;
	enum MAX_VERTEX_TEXTURE_IMAGE_UNITS_ARB = 0x8B4C;
	enum MAX_COMBINED_TEXTURE_IMAGE_UNITS_ARB = 0x8B4D;
	enum OBJECT_ACTIVE_ATTRIBUTES_ARB = 0x8B89;
	enum OBJECT_ACTIVE_ATTRIBUTE_MAX_LENGTH_ARB = 0x8B8A;
	void bindAttribLocationARB(GLhandleARB programObj, UInt index, const(GLcharARB)* name);
	void getActiveAttribARB(GLhandleARB programObj, UInt index, Sizei maxLength,
			Sizei* length, Int* size, Enum* type, GLcharARB* name);
	Int getAttribLocationARB(GLhandleARB programObj, const(GLcharARB)* name);

	void windowPos2dARB(Double x, Double y);
	void windowPos2dvARB(const(Double)* v);
	void windowPos2fARB(Float x, Float y);
	void windowPos2fvARB(const(Float)* v);
	void windowPos2iARB(Int x, Int y);
	void windowPos2ivARB(const(Int)* v);
	void windowPos2sARB(Short x, Short y);
	void windowPos2svARB(const(Short)* v);
	void windowPos3dARB(Double x, Double y, Double z);
	void windowPos3dvARB(const(Double)* v);
	void windowPos3fARB(Float x, Float y, Float z);
	void windowPos3fvARB(const(Float)* v);
	void windowPos3iARB(Int x, Int y, Int z);
	void windowPos3ivARB(const(Int)* v);
	void windowPos3sARB(Short x, Short y, Short z);
	void windowPos3svARB(const(Short)* v);

	enum MULTIPLY_KHR = 0x9294;
	enum SCREEN_KHR = 0x9295;
	enum OVERLAY_KHR = 0x9296;
	enum DARKEN_KHR = 0x9297;
	enum LIGHTEN_KHR = 0x9298;
	enum COLORDODGE_KHR = 0x9299;
	enum COLORBURN_KHR = 0x929A;
	enum HARDLIGHT_KHR = 0x929B;
	enum SOFTLIGHT_KHR = 0x929C;
	enum DIFFERENCE_KHR = 0x929E;
	enum EXCLUSION_KHR = 0x92A0;
	enum HSL_HUE_KHR = 0x92AD;
	enum HSL_SATURATION_KHR = 0x92AE;
	enum HSL_COLOR_KHR = 0x92AF;
	enum HSL_LUMINOSITY_KHR = 0x92B0;
	void blendBarrierKHR();

	enum BLEND_ADVANCED_COHERENT_KHR = 0x9285;

	enum CONTEXT_FLAG_NO_ERROR_BIT_KHR = 0x00000008;

	enum MAX_SHADER_COMPILER_THREADS_KHR = 0x91B0;
	enum COMPLETION_STATUS_KHR = 0x91B1;
	void maxShaderCompilerThreadsKHR(UInt count);

	enum CONTEXT_ROBUST_ACCESS = 0x90F3;

	enum SUBGROUP_SIZE_KHR = 0x9532;
	enum SUBGROUP_SUPPORTED_STAGES_KHR = 0x9533;
	enum SUBGROUP_SUPPORTED_FEATURES_KHR = 0x9534;
	enum SUBGROUP_QUAD_ALL_STAGES_KHR = 0x9535;
	enum SUBGROUP_FEATURE_BASIC_BIT_KHR = 0x00000001;
	enum SUBGROUP_FEATURE_VOTE_BIT_KHR = 0x00000002;
	enum SUBGROUP_FEATURE_ARITHMETIC_BIT_KHR = 0x00000004;
	enum SUBGROUP_FEATURE_BALLOT_BIT_KHR = 0x00000008;
	enum SUBGROUP_FEATURE_SHUFFLE_BIT_KHR = 0x00000010;
	enum SUBGROUP_FEATURE_SHUFFLE_RELATIVE_BIT_KHR = 0x00000020;
	enum SUBGROUP_FEATURE_CLUSTERED_BIT_KHR = 0x00000040;
	enum SUBGROUP_FEATURE_QUAD_BIT_KHR = 0x00000080;

	enum COMPRESSED_RGBA_ASTC_4x4_KHR = 0x93B0;
	enum COMPRESSED_RGBA_ASTC_5x4_KHR = 0x93B1;
	enum COMPRESSED_RGBA_ASTC_5x5_KHR = 0x93B2;
	enum COMPRESSED_RGBA_ASTC_6x5_KHR = 0x93B3;
	enum COMPRESSED_RGBA_ASTC_6x6_KHR = 0x93B4;
	enum COMPRESSED_RGBA_ASTC_8x5_KHR = 0x93B5;
	enum COMPRESSED_RGBA_ASTC_8x6_KHR = 0x93B6;
	enum COMPRESSED_RGBA_ASTC_8x8_KHR = 0x93B7;
	enum COMPRESSED_RGBA_ASTC_10x5_KHR = 0x93B8;
	enum COMPRESSED_RGBA_ASTC_10x6_KHR = 0x93B9;
	enum COMPRESSED_RGBA_ASTC_10x8_KHR = 0x93BA;
	enum COMPRESSED_RGBA_ASTC_10x10_KHR = 0x93BB;
	enum COMPRESSED_RGBA_ASTC_12x10_KHR = 0x93BC;
	enum COMPRESSED_RGBA_ASTC_12x12_KHR = 0x93BD;
	enum COMPRESSED_SRGB8_ALPHA8_ASTC_4x4_KHR = 0x93D0;
	enum COMPRESSED_SRGB8_ALPHA8_ASTC_5x4_KHR = 0x93D1;
	enum COMPRESSED_SRGB8_ALPHA8_ASTC_5x5_KHR = 0x93D2;
	enum COMPRESSED_SRGB8_ALPHA8_ASTC_6x5_KHR = 0x93D3;
	enum COMPRESSED_SRGB8_ALPHA8_ASTC_6x6_KHR = 0x93D4;
	enum COMPRESSED_SRGB8_ALPHA8_ASTC_8x5_KHR = 0x93D5;
	enum COMPRESSED_SRGB8_ALPHA8_ASTC_8x6_KHR = 0x93D6;
	enum COMPRESSED_SRGB8_ALPHA8_ASTC_8x8_KHR = 0x93D7;
	enum COMPRESSED_SRGB8_ALPHA8_ASTC_10x5_KHR = 0x93D8;
	enum COMPRESSED_SRGB8_ALPHA8_ASTC_10x6_KHR = 0x93D9;
	enum COMPRESSED_SRGB8_ALPHA8_ASTC_10x8_KHR = 0x93DA;
	enum COMPRESSED_SRGB8_ALPHA8_ASTC_10x10_KHR = 0x93DB;
	enum COMPRESSED_SRGB8_ALPHA8_ASTC_12x10_KHR = 0x93DC;
	enum COMPRESSED_SRGB8_ALPHA8_ASTC_12x12_KHR = 0x93DD;

	void multiTexCoord1bOES(Enum texture, Byte s);
	void multiTexCoord1bvOES(Enum texture, const(Byte)* coords);
	void multiTexCoord2bOES(Enum texture, Byte s, Byte t);
	void multiTexCoord2bvOES(Enum texture, const(Byte)* coords);
	void multiTexCoord3bOES(Enum texture, Byte s, Byte t, Byte r);
	void multiTexCoord3bvOES(Enum texture, const(Byte)* coords);
	void multiTexCoord4bOES(Enum texture, Byte s, Byte t, Byte r, Byte q);
	void multiTexCoord4bvOES(Enum texture, const(Byte)* coords);
	void texCoord1bOES(Byte s);
	void texCoord1bvOES(const(Byte)* coords);
	void texCoord2bOES(Byte s, Byte t);
	void texCoord2bvOES(const(Byte)* coords);
	void texCoord3bOES(Byte s, Byte t, Byte r);
	void texCoord3bvOES(const(Byte)* coords);
	void texCoord4bOES(Byte s, Byte t, Byte r, Byte q);
	void texCoord4bvOES(const(Byte)* coords);
	void vertex2bOES(Byte x, Byte y);
	void vertex2bvOES(const(Byte)* coords);
	void vertex3bOES(Byte x, Byte y, Byte z);
	void vertex3bvOES(const(Byte)* coords);
	void vertex4bOES(Byte x, Byte y, Byte z, Byte w);
	void vertex4bvOES(const(Byte)* coords);

	enum PALETTE4_RGB8_OES = 0x8B90;
	enum PALETTE4_RGBA8_OES = 0x8B91;
	enum PALETTE4_R5_G6_B5_OES = 0x8B92;
	enum PALETTE4_RGBA4_OES = 0x8B93;
	enum PALETTE4_RGB5_A1_OES = 0x8B94;
	enum PALETTE8_RGB8_OES = 0x8B95;
	enum PALETTE8_RGBA8_OES = 0x8B96;
	enum PALETTE8_R5_G6_B5_OES = 0x8B97;
	enum PALETTE8_RGBA4_OES = 0x8B98;
	enum PALETTE8_RGB5_A1_OES = 0x8B99;

	alias Fixed = int;
	enum FIXED_OES = 0x140C;
	void alphaFuncxOES(Enum func, Fixed ref_);
	void clearColorxOES(Fixed red, Fixed green, Fixed blue, Fixed alpha);
	void clearDepthxOES(Fixed depth);
	void clipPlanexOES(Enum plane, const(Fixed)* equation);
	void color4xOES(Fixed red, Fixed green, Fixed blue, Fixed alpha);
	void depthRangexOES(Fixed n, Fixed f);
	void fogxOES(Enum pname, Fixed param);
	void fogxvOES(Enum pname, const(Fixed)* param);
	void frustumxOES(Fixed l, Fixed r, Fixed b, Fixed t, Fixed n, Fixed f);
	void getClipPlanexOES(Enum plane, Fixed* equation);
	void getFixedvOES(Enum pname, Fixed* params);
	void getTexEnvxvOES(Enum target, Enum pname, Fixed* params);
	void getTexParameterxvOES(Enum target, Enum pname, Fixed* params);
	void lightModelxOES(Enum pname, Fixed param);
	void lightModelxvOES(Enum pname, const(Fixed)* param);
	void lightxOES(Enum light, Enum pname, Fixed param);
	void lightxvOES(Enum light, Enum pname, const(Fixed)* params);
	void lineWidthxOES(Fixed width);
	void loadMatrixxOES(const(Fixed)* m);
	void materialxOES(Enum face, Enum pname, Fixed param);
	void materialxvOES(Enum face, Enum pname, const(Fixed)* param);
	void multMatrixxOES(const(Fixed)* m);
	void multiTexCoord4xOES(Enum texture, Fixed s, Fixed t, Fixed r, Fixed q);
	void normal3xOES(Fixed nx, Fixed ny, Fixed nz);
	void orthoxOES(Fixed l, Fixed r, Fixed b, Fixed t, Fixed n, Fixed f);
	void pointParameterxvOES(Enum pname, const(Fixed)* params);
	void pointSizexOES(Fixed size);
	void polygonOffsetxOES(Fixed factor, Fixed units);
	void rotatexOES(Fixed angle, Fixed x, Fixed y, Fixed z);
	void scalexOES(Fixed x, Fixed y, Fixed z);
	void texEnvxOES(Enum target, Enum pname, Fixed param);
	void texEnvxvOES(Enum target, Enum pname, const(Fixed)* params);
	void texParameterxOES(Enum target, Enum pname, Fixed param);
	void texParameterxvOES(Enum target, Enum pname, const(Fixed)* params);
	void translatexOES(Fixed x, Fixed y, Fixed z);
	void accumxOES(Enum op, Fixed value);
	void bitmapxOES(Sizei width, Sizei height, Fixed xorig, Fixed yorig,
			Fixed xmove, Fixed ymove, const(UByte)* bitmap);
	void blendColorxOES(Fixed red, Fixed green, Fixed blue, Fixed alpha);
	void clearAccumxOES(Fixed red, Fixed green, Fixed blue, Fixed alpha);
	void color3xOES(Fixed red, Fixed green, Fixed blue);
	void color3xvOES(const(Fixed)* components);
	void color4xvOES(const(Fixed)* components);
	void convolutionParameterxOES(Enum target, Enum pname, Fixed param);
	void convolutionParameterxvOES(Enum target, Enum pname, const(Fixed)* params);
	void evalCoord1xOES(Fixed u);
	void evalCoord1xvOES(const(Fixed)* coords);
	void evalCoord2xOES(Fixed u, Fixed v);
	void evalCoord2xvOES(const(Fixed)* coords);
	void feedbackBufferxOES(Sizei n, Enum type, const(Fixed)* buffer);
	void getConvolutionParameterxvOES(Enum target, Enum pname, Fixed* params);
	void getHistogramParameterxvOES(Enum target, Enum pname, Fixed* params);
	void getLightxOES(Enum light, Enum pname, Fixed* params);
	void getMapxvOES(Enum target, Enum query, Fixed* v);
	void getMaterialxOES(Enum face, Enum pname, Fixed param);
	void getPixelMapxv(Enum map, Int size, Fixed* values);
	void getTexGenxvOES(Enum coord, Enum pname, Fixed* params);
	void getTexLevelParameterxvOES(Enum target, Int level, Enum pname, Fixed* params);
	void indexxOES(Fixed component);
	void indexxvOES(const(Fixed)* component);
	void loadTransposeMatrixxOES(const(Fixed)* m);
	void map1xOES(Enum target, Fixed u1, Fixed u2, Int stride, Int order, Fixed points);
	void map2xOES(Enum target, Fixed u1, Fixed u2, Int ustride, Int uorder,
			Fixed v1, Fixed v2, Int vstride, Int vorder, Fixed points);
	void mapGrid1xOES(Int n, Fixed u1, Fixed u2);
	void mapGrid2xOES(Int n, Fixed u1, Fixed u2, Fixed v1, Fixed v2);
	void multTransposeMatrixxOES(const(Fixed)* m);
	void multiTexCoord1xOES(Enum texture, Fixed s);
	void multiTexCoord1xvOES(Enum texture, const(Fixed)* coords);
	void multiTexCoord2xOES(Enum texture, Fixed s, Fixed t);
	void multiTexCoord2xvOES(Enum texture, const(Fixed)* coords);
	void multiTexCoord3xOES(Enum texture, Fixed s, Fixed t, Fixed r);
	void multiTexCoord3xvOES(Enum texture, const(Fixed)* coords);
	void multiTexCoord4xvOES(Enum texture, const(Fixed)* coords);
	void normal3xvOES(const(Fixed)* coords);
	void passThroughxOES(Fixed token);
	void pixelMapx(Enum map, Int size, const(Fixed)* values);
	void pixelStorex(Enum pname, Fixed param);
	void pixelTransferxOES(Enum pname, Fixed param);
	void pixelZoomxOES(Fixed xfactor, Fixed yfactor);
	void prioritizeTexturesxOES(Sizei n, const(UInt)* textures, const(Fixed)* priorities);
	void rasterPos2xOES(Fixed x, Fixed y);
	void rasterPos2xvOES(const(Fixed)* coords);
	void rasterPos3xOES(Fixed x, Fixed y, Fixed z);
	void rasterPos3xvOES(const(Fixed)* coords);
	void rasterPos4xOES(Fixed x, Fixed y, Fixed z, Fixed w);
	void rasterPos4xvOES(const(Fixed)* coords);
	void rectxOES(Fixed x1, Fixed y1, Fixed x2, Fixed y2);
	void rectxvOES(const(Fixed)* v1, const(Fixed)* v2);
	void texCoord1xOES(Fixed s);
	void texCoord1xvOES(const(Fixed)* coords);
	void texCoord2xOES(Fixed s, Fixed t);
	void texCoord2xvOES(const(Fixed)* coords);
	void texCoord3xOES(Fixed s, Fixed t, Fixed r);
	void texCoord3xvOES(const(Fixed)* coords);
	void texCoord4xOES(Fixed s, Fixed t, Fixed r, Fixed q);
	void texCoord4xvOES(const(Fixed)* coords);
	void texGenxOES(Enum coord, Enum pname, Fixed param);
	void texGenxvOES(Enum coord, Enum pname, const(Fixed)* params);
	void vertex2xOES(Fixed x);
	void vertex2xvOES(const(Fixed)* coords);
	void vertex3xOES(Fixed x, Fixed y);
	void vertex3xvOES(const(Fixed)* coords);
	void vertex4xOES(Fixed x, Fixed y, Fixed z);
	void vertex4xvOES(const(Fixed)* coords);

	Bitfield queryMatrixxOES(Fixed* mantissa, Int* exponent);

	enum IMPLEMENTATION_COLOR_READ_TYPE_OES = 0x8B9A;
	enum IMPLEMENTATION_COLOR_READ_FORMAT_OES = 0x8B9B;

	void clearDepthfOES(Clampf depth);
	void clipPlanefOES(Enum plane, const(Float)* equation);
	void depthRangefOES(Clampf n, Clampf f);
	void frustumfOES(Float l, Float r, Float b, Float t, Float n, Float f);
	void getClipPlanefOES(Enum plane, Float* equation);
	void orthofOES(Float l, Float r, Float b, Float t, Float n, Float f);

	enum MULTISAMPLE_3DFX = 0x86B2;
	enum SAMPLE_BUFFERS_3DFX = 0x86B3;
	enum SAMPLES_3DFX = 0x86B4;
	enum MULTISAMPLE_BIT_3DFX = 0x20000000;

	void tbufferMask3DFX(UInt mask);

	enum COMPRESSED_RGB_FXT1_3DFX = 0x86B0;
	enum COMPRESSED_RGBA_FXT1_3DFX = 0x86B1;

	enum FACTOR_MIN_AMD = 0x901C;
	enum FACTOR_MAX_AMD = 0x901D;

	alias GLDEBUGPROCAMD = void function(UInt id, Enum category,
			Enum severity, Sizei length, const(Char)* message, void* userParam);
	enum MAX_DEBUG_MESSAGE_LENGTH_AMD = 0x9143;
	enum MAX_DEBUG_LOGGED_MESSAGES_AMD = 0x9144;
	enum DEBUG_LOGGED_MESSAGES_AMD = 0x9145;
	enum DEBUG_SEVERITY_HIGH_AMD = 0x9146;
	enum DEBUG_SEVERITY_MEDIUM_AMD = 0x9147;
	enum DEBUG_SEVERITY_LOW_AMD = 0x9148;
	enum DEBUG_CATEGORY_API_ERROR_AMD = 0x9149;
	enum DEBUG_CATEGORY_WINDOW_SYSTEM_AMD = 0x914A;
	enum DEBUG_CATEGORY_DEPRECATION_AMD = 0x914B;
	enum DEBUG_CATEGORY_UNDEFINED_BEHAVIOR_AMD = 0x914C;
	enum DEBUG_CATEGORY_PERFORMANCE_AMD = 0x914D;
	enum DEBUG_CATEGORY_SHADER_COMPILER_AMD = 0x914E;
	enum DEBUG_CATEGORY_APPLICATION_AMD = 0x914F;
	enum DEBUG_CATEGORY_OTHER_AMD = 0x9150;
	void debugMessageEnableAMD(Enum category, Enum severity, Sizei count,
			const(UInt)* ids, Boolean enabled);
	void debugMessageInsertAMD(Enum category, Enum severity, UInt id,
			Sizei length, const(Char)* buf);
	void debugMessageCallbackAMD(GLDEBUGPROCAMD callback, void* userParam);
	UInt getDebugMessageLogAMD(UInt count, Sizei bufsize, Enum* categories,
			UInt* severities, UInt* ids, Sizei* lengths, Char* message);

	enum DEPTH_CLAMP_NEAR_AMD = 0x901E;
	enum DEPTH_CLAMP_FAR_AMD = 0x901F;

	void blendFuncIndexedAMD(UInt buf, Enum src, Enum dst);
	void blendFuncSeparateIndexedAMD(UInt buf, Enum srcRGB, Enum dstRGB,
			Enum srcAlpha, Enum dstAlpha);
	void blendEquationIndexedAMD(UInt buf, Enum mode);
	void blendEquationSeparateIndexedAMD(UInt buf, Enum modeRGB, Enum modeAlpha);

	enum RENDERBUFFER_STORAGE_SAMPLES_AMD = 0x91B2;
	enum MAX_COLOR_FRAMEBUFFER_SAMPLES_AMD = 0x91B3;
	enum MAX_COLOR_FRAMEBUFFER_STORAGE_SAMPLES_AMD = 0x91B4;
	enum MAX_DEPTH_STENCIL_FRAMEBUFFER_SAMPLES_AMD = 0x91B5;
	enum NUM_SUPPORTED_MULTISAMPLE_MODES_AMD = 0x91B6;
	enum SUPPORTED_MULTISAMPLE_MODES_AMD = 0x91B7;
	void renderbufferStorageMultisampleAdvancedAMD(Enum target, Sizei samples,
			Sizei storageSamples, Enum internalformat, Sizei width, Sizei height);
	void namedRenderbufferStorageMultisampleAdvancedAMD(UInt renderbuffer, Sizei samples,
			Sizei storageSamples, Enum internalformat, Sizei width, Sizei height);

	enum SUBSAMPLE_DISTANCE_AMD = 0x883F;
	enum PIXELS_PER_SAMPLE_PATTERN_X_AMD = 0x91AE;
	enum PIXELS_PER_SAMPLE_PATTERN_Y_AMD = 0x91AF;
	enum ALL_PIXELS_AMD = 0xFFFFFFFF;
	void framebufferSamplePositionsfvAMD(Enum target, UInt numsamples,
			UInt pixelindex, const(Float)* values);
	void namedFramebufferSamplePositionsfvAMD(UInt framebuffer,
			UInt numsamples, UInt pixelindex, const(Float)* values);
	void getFramebufferParameterfvAMD(Enum target, Enum pname,
			UInt numsamples, UInt pixelindex, Sizei size, Float* values);
	void getNamedFramebufferParameterfvAMD(UInt framebuffer, Enum pname,
			UInt numsamples, UInt pixelindex, Sizei size, Float* values);

	enum FLOAT16_NV = 0x8FF8;
	enum FLOAT16_VEC2_NV = 0x8FF9;
	enum FLOAT16_VEC3_NV = 0x8FFA;
	enum FLOAT16_VEC4_NV = 0x8FFB;
	enum FLOAT16_MAT2_AMD = 0x91C5;
	enum FLOAT16_MAT3_AMD = 0x91C6;
	enum FLOAT16_MAT4_AMD = 0x91C7;
	enum FLOAT16_MAT2x3_AMD = 0x91C8;
	enum FLOAT16_MAT2x4_AMD = 0x91C9;
	enum FLOAT16_MAT3x2_AMD = 0x91CA;
	enum FLOAT16_MAT3x4_AMD = 0x91CB;
	enum FLOAT16_MAT4x2_AMD = 0x91CC;
	enum FLOAT16_MAT4x3_AMD = 0x91CD;

	alias GLint64EXT = c_long;
	enum INT64_NV = 0x140E;
	enum UNSIGNED_INT64_NV = 0x140F;
	enum INT8_NV = 0x8FE0;
	enum INT8_VEC2_NV = 0x8FE1;
	enum INT8_VEC3_NV = 0x8FE2;
	enum INT8_VEC4_NV = 0x8FE3;
	enum INT16_NV = 0x8FE4;
	enum INT16_VEC2_NV = 0x8FE5;
	enum INT16_VEC3_NV = 0x8FE6;
	enum INT16_VEC4_NV = 0x8FE7;
	enum INT64_VEC2_NV = 0x8FE9;
	enum INT64_VEC3_NV = 0x8FEA;
	enum INT64_VEC4_NV = 0x8FEB;
	enum UNSIGNED_INT8_NV = 0x8FEC;
	enum UNSIGNED_INT8_VEC2_NV = 0x8FED;
	enum UNSIGNED_INT8_VEC3_NV = 0x8FEE;
	enum UNSIGNED_INT8_VEC4_NV = 0x8FEF;
	enum UNSIGNED_INT16_NV = 0x8FF0;
	enum UNSIGNED_INT16_VEC2_NV = 0x8FF1;
	enum UNSIGNED_INT16_VEC3_NV = 0x8FF2;
	enum UNSIGNED_INT16_VEC4_NV = 0x8FF3;
	enum UNSIGNED_INT64_VEC2_NV = 0x8FF5;
	enum UNSIGNED_INT64_VEC3_NV = 0x8FF6;
	enum UNSIGNED_INT64_VEC4_NV = 0x8FF7;
	void uniform1i64NV(Int location, GLint64EXT x);
	void uniform2i64NV(Int location, GLint64EXT x, GLint64EXT y);
	void uniform3i64NV(Int location, GLint64EXT x, GLint64EXT y, GLint64EXT z);
	void uniform4i64NV(Int location, GLint64EXT x, GLint64EXT y, GLint64EXT z, GLint64EXT w);
	void uniform1i64vNV(Int location, Sizei count, const(GLint64EXT)* value);
	void uniform2i64vNV(Int location, Sizei count, const(GLint64EXT)* value);
	void uniform3i64vNV(Int location, Sizei count, const(GLint64EXT)* value);
	void uniform4i64vNV(Int location, Sizei count, const(GLint64EXT)* value);
	void uniform1Ui64NV(Int location, GLuint64EXT x);
	void uniform2Ui64NV(Int location, GLuint64EXT x, GLuint64EXT y);
	void uniform3Ui64NV(Int location, GLuint64EXT x, GLuint64EXT y, GLuint64EXT z);
	void uniform4Ui64NV(Int location, GLuint64EXT x, GLuint64EXT y, GLuint64EXT z, GLuint64EXT w);
	void uniform1Ui64vNV(Int location, Sizei count, const(GLuint64EXT)* value);
	void uniform2Ui64vNV(Int location, Sizei count, const(GLuint64EXT)* value);
	void uniform3Ui64vNV(Int location, Sizei count, const(GLuint64EXT)* value);
	void uniform4Ui64vNV(Int location, Sizei count, const(GLuint64EXT)* value);
	void getUniformi64vNV(UInt program, Int location, GLint64EXT* params);
	void getUniformui64vNV(UInt program, Int location, GLuint64EXT* params);
	void programUniform1i64NV(UInt program, Int location, GLint64EXT x);
	void programUniform2i64NV(UInt program, Int location, GLint64EXT x, GLint64EXT y);
	void programUniform3i64NV(UInt program, Int location, GLint64EXT x,
			GLint64EXT y, GLint64EXT z);
	void programUniform4i64NV(UInt program, Int location, GLint64EXT x,
			GLint64EXT y, GLint64EXT z, GLint64EXT w);
	void programUniform1i64vNV(UInt program, Int location, Sizei count,
			const(GLint64EXT)* value);
	void programUniform2i64vNV(UInt program, Int location, Sizei count,
			const(GLint64EXT)* value);
	void programUniform3i64vNV(UInt program, Int location, Sizei count,
			const(GLint64EXT)* value);
	void programUniform4i64vNV(UInt program, Int location, Sizei count,
			const(GLint64EXT)* value);
	void programUniform1Ui64NV(UInt program, Int location, GLuint64EXT x);
	void programUniform2Ui64NV(UInt program, Int location, GLuint64EXT x, GLuint64EXT y);
	void programUniform3Ui64NV(UInt program, Int location, GLuint64EXT x,
			GLuint64EXT y, GLuint64EXT z);
	void programUniform4Ui64NV(UInt program, Int location, GLuint64EXT x,
			GLuint64EXT y, GLuint64EXT z, GLuint64EXT w);
	void programUniform1Ui64vNV(UInt program, Int location, Sizei count,
			const(GLuint64EXT)* value);
	void programUniform2Ui64vNV(UInt program, Int location, Sizei count,
			const(GLuint64EXT)* value);
	void programUniform3Ui64vNV(UInt program, Int location, Sizei count,
			const(GLuint64EXT)* value);
	void programUniform4Ui64vNV(UInt program, Int location, Sizei count,
			const(GLuint64EXT)* value);

	enum VERTEX_ELEMENT_SWIZZLE_AMD = 0x91A4;
	enum VERTEX_ID_SWIZZLE_AMD = 0x91A5;
	void vertexAttribParameteriAMD(UInt index, Enum pname, Int param);

	void multiDrawArraysIndirectAMD(Enum mode, const(void)* indirect,
			Sizei primcount, Sizei stride);
	void multiDrawElementsIndirectAMD(Enum mode, Enum type,
			const(void)* indirect, Sizei primcount, Sizei stride);

	enum DATA_BUFFER_AMD = 0x9151;
	enum PERFORMANCE_MONITOR_AMD = 0x9152;
	enum QUERY_OBJECT_AMD = 0x9153;
	enum VERTEX_ARRAY_OBJECT_AMD = 0x9154;
	enum SAMPLER_OBJECT_AMD = 0x9155;
	void genNamesAMD(Enum identifier, UInt num, UInt* names);
	void deleteNamesAMD(Enum identifier, UInt num, const(UInt)* names);
	Boolean isNameAMD(Enum identifier, UInt name);

	enum OCCLUSION_QUERY_EVENT_MASK_AMD = 0x874F;
	enum QUERY_DEPTH_PASS_EVENT_BIT_AMD = 0x00000001;
	enum QUERY_DEPTH_FAIL_EVENT_BIT_AMD = 0x00000002;
	enum QUERY_STENCIL_FAIL_EVENT_BIT_AMD = 0x00000004;
	enum QUERY_DEPTH_BOUNDS_FAIL_EVENT_BIT_AMD = 0x00000008;
	enum QUERY_ALL_EVENT_BITS_AMD = 0xFFFFFFFF;
	void queryObjectParameteruiAMD(Enum target, UInt id, Enum pname, UInt param);

	enum COUNTER_TYPE_AMD = 0x8BC0;
	enum COUNTER_RANGE_AMD = 0x8BC1;
	enum UNSIGNED_INT64_AMD = 0x8BC2;
	enum PERCENTAGE_AMD = 0x8BC3;
	enum PERFMON_RESULT_AVAILABLE_AMD = 0x8BC4;
	enum PERFMON_RESULT_SIZE_AMD = 0x8BC5;
	enum PERFMON_RESULT_AMD = 0x8BC6;
	void getPerfMonitorGroupsAMD(Int* numGroups, Sizei groupsSize, UInt* groups);
	void getPerfMonitorCountersAMD(UInt group, Int* numCounters,
			Int* maxActiveCounters, Sizei counterSize, UInt* counters);
	void getPerfMonitorGroupStringAMD(UInt group, Sizei bufSize,
			Sizei* length, Char* groupString);
	void getPerfMonitorCounterStringAMD(UInt group, UInt counter,
			Sizei bufSize, Sizei* length, Char* counterString);
	void getPerfMonitorCounterInfoAMD(UInt group, UInt counter, Enum pname, void* data);
	void genPerfMonitorsAMD(Sizei n, UInt* monitors);
	void deletePerfMonitorsAMD(Sizei n, UInt* monitors);
	void selectPerfMonitorCountersAMD(UInt monitor, Boolean enable,
			UInt group, Int numCounters, UInt* counterList);
	void beginPerfMonitorAMD(UInt monitor);
	void endPerfMonitorAMD(UInt monitor);
	void getPerfMonitorCounterDataAMD(UInt monitor, Enum pname,
			Sizei dataSize, UInt* data, Int* bytesWritten);

	enum EXTERNAL_VIRTUAL_MEMORY_BUFFER_AMD = 0x9160;

	enum QUERY_BUFFER_AMD = 0x9192;
	enum QUERY_BUFFER_BINDING_AMD = 0x9193;
	enum QUERY_RESULT_NO_WAIT_AMD = 0x9194;

	void setMultisamplefvAMD(Enum pname, UInt index, const(Float)* val);

	enum VIRTUAL_PAGE_SIZE_X_AMD = 0x9195;
	enum VIRTUAL_PAGE_SIZE_Y_AMD = 0x9196;
	enum VIRTUAL_PAGE_SIZE_Z_AMD = 0x9197;
	enum MAX_SPARSE_TEXTURE_SIZE_AMD = 0x9198;
	enum MAX_SPARSE_3D_TEXTURE_SIZE_AMD = 0x9199;
	enum MAX_SPARSE_ARRAY_TEXTURE_LAYERS = 0x919A;
	enum MIN_SPARSE_LEVEL_AMD = 0x919B;
	enum MIN_LOD_WARNING_AMD = 0x919C;
	enum TEXTURE_STORAGE_SPARSE_BIT_AMD = 0x00000001;
	void texStorageSparseAMD(Enum target, Enum internalFormat, Sizei width,
			Sizei height, Sizei depth, Sizei layers, Bitfield flags);
	void textureStorageSparseAMD(UInt texture, Enum target, Enum internalFormat,
			Sizei width, Sizei height, Sizei depth, Sizei layers, Bitfield flags);

	enum SET_AMD = 0x874A;
	enum REPLACE_VALUE_AMD = 0x874B;
	enum STENCIL_OP_VALUE_AMD = 0x874C;
	enum STENCIL_BACK_OP_VALUE_AMD = 0x874D;
	void stencilOpValueAMD(Enum face, UInt value);

	enum STREAM_RASTERIZATION_AMD = 0x91A0;

	enum SAMPLER_BUFFER_AMD = 0x9001;
	enum INT_SAMPLER_BUFFER_AMD = 0x9002;
	enum UNSIGNED_INT_SAMPLER_BUFFER_AMD = 0x9003;
	enum TESSELLATION_MODE_AMD = 0x9004;
	enum TESSELLATION_FACTOR_AMD = 0x9005;
	enum DISCRETE_AMD = 0x9006;
	enum CONTINUOUS_AMD = 0x9007;
	void tessellationFactorAMD(Float factor);
	void tessellationModeAMD(Enum mode);

	enum AUX_DEPTH_STENCIL_APPLE = 0x8A14;

	enum UNPACK_CLIENT_STORAGE_APPLE = 0x85B2;

	enum ELEMENT_ARRAY_APPLE = 0x8A0C;
	enum ELEMENT_ARRAY_TYPE_APPLE = 0x8A0D;
	enum ELEMENT_ARRAY_POINTER_APPLE = 0x8A0E;
	void elementPointerAPPLE(Enum type, const(void)* pointer);
	void drawElementArrayAPPLE(Enum mode, Int first, Sizei count);
	void drawRangeElementArrayAPPLE(Enum mode, UInt start, UInt end,
			Int first, Sizei count);
	void multiDrawElementArrayAPPLE(Enum mode, const(Int)* first,
			const(Sizei)* count, Sizei primcount);
	void multiDrawRangeElementArrayAPPLE(Enum mode, UInt start, UInt end,
			const(Int)* first, const(Sizei)* count, Sizei primcount);

	enum DRAW_PIXELS_APPLE = 0x8A0A;
	enum FENCE_APPLE = 0x8A0B;
	void genFencesAPPLE(Sizei n, UInt* fences);
	void deleteFencesAPPLE(Sizei n, const(UInt)* fences);
	void setFenceAPPLE(UInt fence);
	Boolean isFenceAPPLE(UInt fence);
	Boolean testFenceAPPLE(UInt fence);
	void finishFenceAPPLE(UInt fence);
	Boolean testObjectAPPLE(Enum object, UInt name);
	void finishObjectAPPLE(Enum object, Int name);

	enum HALF_APPLE = 0x140B;
	enum RGBA_FLOAT32_APPLE = 0x8814;
	enum RGB_FLOAT32_APPLE = 0x8815;
	enum ALPHA_FLOAT32_APPLE = 0x8816;
	enum INTENSITY_FLOAT32_APPLE = 0x8817;
	enum LUMINANCE_FLOAT32_APPLE = 0x8818;
	enum LUMINANCE_ALPHA_FLOAT32_APPLE = 0x8819;
	enum RGBA_FLOAT16_APPLE = 0x881A;
	enum RGB_FLOAT16_APPLE = 0x881B;
	enum ALPHA_FLOAT16_APPLE = 0x881C;
	enum INTENSITY_FLOAT16_APPLE = 0x881D;
	enum LUMINANCE_FLOAT16_APPLE = 0x881E;
	enum LUMINANCE_ALPHA_FLOAT16_APPLE = 0x881F;
	enum COLOR_FLOAT_APPLE = 0x8A0F;

	enum BUFFER_SERIALIZED_MODIFY_APPLE = 0x8A12;
	enum BUFFER_FLUSHING_UNMAP_APPLE = 0x8A13;
	void bufferParameteriAPPLE(Enum target, Enum pname, Int param);
	void flushMappedBufferRangeAPPLE(Enum target, Intptr offset, Sizeiptr size);

	enum BUFFER_OBJECT_APPLE = 0x85B3;
	enum RELEASED_APPLE = 0x8A19;
	enum VOLATILE_APPLE = 0x8A1A;
	enum RETAINED_APPLE = 0x8A1B;
	enum UNDEFINED_APPLE = 0x8A1C;
	enum PURGEABLE_APPLE = 0x8A1D;
	Enum objectPurgeableAPPLE(Enum objectType, UInt name, Enum option);
	Enum objectUnpurgeableAPPLE(Enum objectType, UInt name, Enum option);
	void getObjectParameterivAPPLE(Enum objectType, UInt name, Enum pname, Int* params);

	enum RGB_422_APPLE = 0x8A1F;
	enum UNSIGNED_SHORT_8_8_APPLE = 0x85BA;
	enum UNSIGNED_SHORT_8_8_REV_APPLE = 0x85BB;
	enum RGB_RAW_422_APPLE = 0x8A51;

	enum PACK_ROW_BYTES_APPLE = 0x8A15;
	enum UNPACK_ROW_BYTES_APPLE = 0x8A16;

	enum LIGHT_MODEL_SPECULAR_VECTOR_APPLE = 0x85B0;

	enum TEXTURE_RANGE_LENGTH_APPLE = 0x85B7;
	enum TEXTURE_RANGE_POINTER_APPLE = 0x85B8;
	enum TEXTURE_STORAGE_HINT_APPLE = 0x85BC;
	enum STORAGE_PRIVATE_APPLE = 0x85BD;
	enum STORAGE_CACHED_APPLE = 0x85BE;
	enum STORAGE_SHARED_APPLE = 0x85BF;
	void textureRangeAPPLE(Enum target, Sizei length, const(void)* pointer);
	void getTexParameterPointervAPPLE(Enum target, Enum pname, void** params);

	enum TRANSFORM_HINT_APPLE = 0x85B1;

	enum VERTEX_ARRAY_BINDING_APPLE = 0x85B5;
	void bindVertexArrayAPPLE(UInt array);
	void deleteVertexArraysAPPLE(Sizei n, const(UInt)* arrays);
	void genVertexArraysAPPLE(Sizei n, UInt* arrays);
	Boolean isVertexArrayAPPLE(UInt array);

	enum VERTEX_ARRAY_RANGE_APPLE = 0x851D;
	enum VERTEX_ARRAY_RANGE_LENGTH_APPLE = 0x851E;
	enum VERTEX_ARRAY_STORAGE_HINT_APPLE = 0x851F;
	enum VERTEX_ARRAY_RANGE_POINTER_APPLE = 0x8521;
	enum STORAGE_CLIENT_APPLE = 0x85B4;
	void vertexArrayRangeAPPLE(Sizei length, void* pointer);
	void flushVertexArrayRangeAPPLE(Sizei length, void* pointer);
	void vertexArrayParameteriAPPLE(Enum pname, Int param);

	enum VERTEX_ATTRIB_MAP1_APPLE = 0x8A00;
	enum VERTEX_ATTRIB_MAP2_APPLE = 0x8A01;
	enum VERTEX_ATTRIB_MAP1_SIZE_APPLE = 0x8A02;
	enum VERTEX_ATTRIB_MAP1_COEFF_APPLE = 0x8A03;
	enum VERTEX_ATTRIB_MAP1_ORDER_APPLE = 0x8A04;
	enum VERTEX_ATTRIB_MAP1_DOMAIN_APPLE = 0x8A05;
	enum VERTEX_ATTRIB_MAP2_SIZE_APPLE = 0x8A06;
	enum VERTEX_ATTRIB_MAP2_COEFF_APPLE = 0x8A07;
	enum VERTEX_ATTRIB_MAP2_ORDER_APPLE = 0x8A08;
	enum VERTEX_ATTRIB_MAP2_DOMAIN_APPLE = 0x8A09;
	void enableVertexAttribAPPLE(UInt index, Enum pname);
	void disableVertexAttribAPPLE(UInt index, Enum pname);
	Boolean isVertexAttribEnabledAPPLE(UInt index, Enum pname);
	void mapVertexAttrib1dAPPLE(UInt index, UInt size, Double u1,
			Double u2, Int stride, Int order, const(Double)* points);
	void mapVertexAttrib1fAPPLE(UInt index, UInt size, Float u1, Float u2,
			Int stride, Int order, const(Float)* points);
	void mapVertexAttrib2dAPPLE(UInt index, UInt size, Double u1, Double u2,
			Int ustride, Int uorder, Double v1, Double v2, Int vstride,
			Int vorder, const(Double)* points);
	void mapVertexAttrib2fAPPLE(UInt index, UInt size, Float u1, Float u2,
			Int ustride, Int uorder, Float v1, Float v2, Int vstride,
			Int vorder, const(Float)* points);

	enum YCBCR_422_APPLE = 0x85B9;

	enum MAX_DRAW_BUFFERS_ATI = 0x8824;
	enum DRAW_BUFFER0_ATI = 0x8825;
	enum DRAW_BUFFER1_ATI = 0x8826;
	enum DRAW_BUFFER2_ATI = 0x8827;
	enum DRAW_BUFFER3_ATI = 0x8828;
	enum DRAW_BUFFER4_ATI = 0x8829;
	enum DRAW_BUFFER5_ATI = 0x882A;
	enum DRAW_BUFFER6_ATI = 0x882B;
	enum DRAW_BUFFER7_ATI = 0x882C;
	enum DRAW_BUFFER8_ATI = 0x882D;
	enum DRAW_BUFFER9_ATI = 0x882E;
	enum DRAW_BUFFER10_ATI = 0x882F;
	enum DRAW_BUFFER11_ATI = 0x8830;
	enum DRAW_BUFFER12_ATI = 0x8831;
	enum DRAW_BUFFER13_ATI = 0x8832;
	enum DRAW_BUFFER14_ATI = 0x8833;
	enum DRAW_BUFFER15_ATI = 0x8834;
	void drawBuffersATI(Sizei n, const(Enum)* bufs);

	enum ELEMENT_ARRAY_ATI = 0x8768;
	enum ELEMENT_ARRAY_TYPE_ATI = 0x8769;
	enum ELEMENT_ARRAY_POINTER_ATI = 0x876A;
	void elementPointerATI(Enum type, const(void)* pointer);
	void drawElementArrayATI(Enum mode, Sizei count);
	void drawRangeElementArrayATI(Enum mode, UInt start, UInt end, Sizei count);

	enum BUMP_ROT_MATRIX_ATI = 0x8775;
	enum BUMP_ROT_MATRIX_SIZE_ATI = 0x8776;
	enum BUMP_NUM_TEX_UNITS_ATI = 0x8777;
	enum BUMP_TEX_UNITS_ATI = 0x8778;
	enum DUDV_ATI = 0x8779;
	enum DU8DV8_ATI = 0x877A;
	enum BUMP_ENVMAP_ATI = 0x877B;
	enum BUMP_TARGET_ATI = 0x877C;
	void texBumpParameterivATI(Enum pname, const(Int)* param);
	void texBumpParameterfvATI(Enum pname, const(Float)* param);
	void getTexBumpParameterivATI(Enum pname, Int* param);
	void getTexBumpParameterfvATI(Enum pname, Float* param);

	enum FRAGMENT_SHADER_ATI = 0x8920;
	enum REG_0_ATI = 0x8921;
	enum REG_1_ATI = 0x8922;
	enum REG_2_ATI = 0x8923;
	enum REG_3_ATI = 0x8924;
	enum REG_4_ATI = 0x8925;
	enum REG_5_ATI = 0x8926;
	enum REG_6_ATI = 0x8927;
	enum REG_7_ATI = 0x8928;
	enum REG_8_ATI = 0x8929;
	enum REG_9_ATI = 0x892A;
	enum REG_10_ATI = 0x892B;
	enum REG_11_ATI = 0x892C;
	enum REG_12_ATI = 0x892D;
	enum REG_13_ATI = 0x892E;
	enum REG_14_ATI = 0x892F;
	enum REG_15_ATI = 0x8930;
	enum REG_16_ATI = 0x8931;
	enum REG_17_ATI = 0x8932;
	enum REG_18_ATI = 0x8933;
	enum REG_19_ATI = 0x8934;
	enum REG_20_ATI = 0x8935;
	enum REG_21_ATI = 0x8936;
	enum REG_22_ATI = 0x8937;
	enum REG_23_ATI = 0x8938;
	enum REG_24_ATI = 0x8939;
	enum REG_25_ATI = 0x893A;
	enum REG_26_ATI = 0x893B;
	enum REG_27_ATI = 0x893C;
	enum REG_28_ATI = 0x893D;
	enum REG_29_ATI = 0x893E;
	enum REG_30_ATI = 0x893F;
	enum REG_31_ATI = 0x8940;
	enum CON_0_ATI = 0x8941;
	enum CON_1_ATI = 0x8942;
	enum CON_2_ATI = 0x8943;
	enum CON_3_ATI = 0x8944;
	enum CON_4_ATI = 0x8945;
	enum CON_5_ATI = 0x8946;
	enum CON_6_ATI = 0x8947;
	enum CON_7_ATI = 0x8948;
	enum CON_8_ATI = 0x8949;
	enum CON_9_ATI = 0x894A;
	enum CON_10_ATI = 0x894B;
	enum CON_11_ATI = 0x894C;
	enum CON_12_ATI = 0x894D;
	enum CON_13_ATI = 0x894E;
	enum CON_14_ATI = 0x894F;
	enum CON_15_ATI = 0x8950;
	enum CON_16_ATI = 0x8951;
	enum CON_17_ATI = 0x8952;
	enum CON_18_ATI = 0x8953;
	enum CON_19_ATI = 0x8954;
	enum CON_20_ATI = 0x8955;
	enum CON_21_ATI = 0x8956;
	enum CON_22_ATI = 0x8957;
	enum CON_23_ATI = 0x8958;
	enum CON_24_ATI = 0x8959;
	enum CON_25_ATI = 0x895A;
	enum CON_26_ATI = 0x895B;
	enum CON_27_ATI = 0x895C;
	enum CON_28_ATI = 0x895D;
	enum CON_29_ATI = 0x895E;
	enum CON_30_ATI = 0x895F;
	enum CON_31_ATI = 0x8960;
	enum MOV_ATI = 0x8961;
	enum ADD_ATI = 0x8963;
	enum MUL_ATI = 0x8964;
	enum SUB_ATI = 0x8965;
	enum DOT3_ATI = 0x8966;
	enum DOT4_ATI = 0x8967;
	enum MAD_ATI = 0x8968;
	enum LERP_ATI = 0x8969;
	enum CND_ATI = 0x896A;
	enum CND0_ATI = 0x896B;
	enum DOT2_ADD_ATI = 0x896C;
	enum SECONDARY_INTERPOLATOR_ATI = 0x896D;
	enum NUM_FRAGMENT_REGISTERS_ATI = 0x896E;
	enum NUM_FRAGMENT_CONSTANTS_ATI = 0x896F;
	enum NUM_PASSES_ATI = 0x8970;
	enum NUM_INSTRUCTIONS_PER_PASS_ATI = 0x8971;
	enum NUM_INSTRUCTIONS_TOTAL_ATI = 0x8972;
	enum NUM_INPUT_INTERPOLATOR_COMPONENTS_ATI = 0x8973;
	enum NUM_LOOPBACK_COMPONENTS_ATI = 0x8974;
	enum COLOR_ALPHA_PAIRING_ATI = 0x8975;
	enum SWIZZLE_STR_ATI = 0x8976;
	enum SWIZZLE_STQ_ATI = 0x8977;
	enum SWIZZLE_STR_DR_ATI = 0x8978;
	enum SWIZZLE_STQ_DQ_ATI = 0x8979;
	enum SWIZZLE_STRQ_ATI = 0x897A;
	enum SWIZZLE_STRQ_DQ_ATI = 0x897B;
	enum RED_BIT_ATI = 0x00000001;
	enum GREEN_BIT_ATI = 0x00000002;
	enum BLUE_BIT_ATI = 0x00000004;
	enum GL_2X_BIT_ATI = 0x00000001;
	enum GL_4X_BIT_ATI = 0x00000002;
	enum GL_8X_BIT_ATI = 0x00000004;
	enum HALF_BIT_ATI = 0x00000008;
	enum QUARTER_BIT_ATI = 0x00000010;
	enum EIGHTH_BIT_ATI = 0x00000020;
	enum SATURATE_BIT_ATI = 0x00000040;
	enum COMP_BIT_ATI = 0x00000002;
	enum NEGATE_BIT_ATI = 0x00000004;
	enum BIAS_BIT_ATI = 0x00000008;
	UInt genFragmentShadersATI(UInt range);
	void bindFragmentShaderATI(UInt id);
	void deleteFragmentShaderATI(UInt id);
	void beginFragmentShaderATI();
	void endFragmentShaderATI();
	void passTexCoordATI(UInt dst, UInt coord, Enum swizzle);
	void sampleMapATI(UInt dst, UInt interp, Enum swizzle);
	void colorFragmentOp1ATI(Enum op, UInt dst, UInt dstMask, UInt dstMod,
			UInt arg1, UInt arg1Rep, UInt arg1Mod);
	void colorFragmentOp2ATI(Enum op, UInt dst, UInt dstMask, UInt dstMod,
			UInt arg1, UInt arg1Rep, UInt arg1Mod, UInt arg2, UInt arg2Rep, UInt arg2Mod);
	void colorFragmentOp3ATI(Enum op, UInt dst, UInt dstMask, UInt dstMod, UInt arg1,
			UInt arg1Rep, UInt arg1Mod, UInt arg2, UInt arg2Rep,
			UInt arg2Mod, UInt arg3, UInt arg3Rep, UInt arg3Mod);
	void alphaFragmentOp1ATI(Enum op, UInt dst, UInt dstMod, UInt arg1,
			UInt arg1Rep, UInt arg1Mod);
	void alphaFragmentOp2ATI(Enum op, UInt dst, UInt dstMod, UInt arg1,
			UInt arg1Rep, UInt arg1Mod, UInt arg2, UInt arg2Rep, UInt arg2Mod);
	void alphaFragmentOp3ATI(Enum op, UInt dst, UInt dstMod, UInt arg1, UInt arg1Rep,
			UInt arg1Mod, UInt arg2, UInt arg2Rep, UInt arg2Mod,
			UInt arg3, UInt arg3Rep, UInt arg3Mod);
	void setFragmentShaderConstantATI(UInt dst, const(Float)* value);

	void* mapObjectBufferATI(UInt buffer);
	void unmapObjectBufferATI(UInt buffer);

	enum VBO_FREE_MEMORY_ATI = 0x87FB;
	enum TEXTURE_FREE_MEMORY_ATI = 0x87FC;
	enum RENDERBUFFER_FREE_MEMORY_ATI = 0x87FD;

	enum RGBA_FLOAT_MODE_ATI = 0x8820;
	enum COLOR_CLEAR_UNCLAMPED_VALUE_ATI = 0x8835;

	enum PN_TRIANGLES_ATI = 0x87F0;
	enum MAX_PN_TRIANGLES_TESSELATION_LEVEL_ATI = 0x87F1;
	enum PN_TRIANGLES_POINT_MODE_ATI = 0x87F2;
	enum PN_TRIANGLES_NORMAL_MODE_ATI = 0x87F3;
	enum PN_TRIANGLES_TESSELATION_LEVEL_ATI = 0x87F4;
	enum PN_TRIANGLES_POINT_MODE_LINEAR_ATI = 0x87F5;
	enum PN_TRIANGLES_POINT_MODE_CUBIC_ATI = 0x87F6;
	enum PN_TRIANGLES_NORMAL_MODE_LINEAR_ATI = 0x87F7;
	enum PN_TRIANGLES_NORMAL_MODE_QUADRATIC_ATI = 0x87F8;
	@BindingName("glPNTrianglesiATI")
	void pnTrianglesiATI(Enum pname, Int param);
	@BindingName("glPNTrianglesfATI")
	void pnTrianglesfATI(Enum pname, Float param);

	enum STENCIL_BACK_FUNC_ATI = 0x8800;
	enum STENCIL_BACK_FAIL_ATI = 0x8801;
	enum STENCIL_BACK_PASS_DEPTH_FAIL_ATI = 0x8802;
	enum STENCIL_BACK_PASS_DEPTH_PASS_ATI = 0x8803;
	void stencilOpSeparateATI(Enum face, Enum sfail, Enum dpfail, Enum dppass);
	void stencilFuncSeparateATI(Enum frontfunc, Enum backfunc, Int ref_, UInt mask);

	enum TEXT_FRAGMENT_SHADER_ATI = 0x8200;

	enum MODULATE_ADD_ATI = 0x8744;
	enum MODULATE_SIGNED_ADD_ATI = 0x8745;
	enum MODULATE_SUBTRACT_ATI = 0x8746;

	enum RGBA_FLOAT32_ATI = 0x8814;
	enum RGB_FLOAT32_ATI = 0x8815;
	enum ALPHA_FLOAT32_ATI = 0x8816;
	enum INTENSITY_FLOAT32_ATI = 0x8817;
	enum LUMINANCE_FLOAT32_ATI = 0x8818;
	enum LUMINANCE_ALPHA_FLOAT32_ATI = 0x8819;
	enum RGBA_FLOAT16_ATI = 0x881A;
	enum RGB_FLOAT16_ATI = 0x881B;
	enum ALPHA_FLOAT16_ATI = 0x881C;
	enum INTENSITY_FLOAT16_ATI = 0x881D;
	enum LUMINANCE_FLOAT16_ATI = 0x881E;
	enum LUMINANCE_ALPHA_FLOAT16_ATI = 0x881F;

	enum MIRROR_CLAMP_ATI = 0x8742;
	enum MIRROR_CLAMP_TO_EDGE_ATI = 0x8743;

	enum STATIC_ATI = 0x8760;
	enum DYNAMIC_ATI = 0x8761;
	enum PRESERVE_ATI = 0x8762;
	enum DISCARD_ATI = 0x8763;
	enum OBJECT_BUFFER_SIZE_ATI = 0x8764;
	enum OBJECT_BUFFER_USAGE_ATI = 0x8765;
	enum ARRAY_OBJECT_BUFFER_ATI = 0x8766;
	enum ARRAY_OBJECT_OFFSET_ATI = 0x8767;
	UInt newObjectBufferATI(Sizei size, const(void)* pointer, Enum usage);
	Boolean isObjectBufferATI(UInt buffer);
	void updateObjectBufferATI(UInt buffer, UInt offset, Sizei size,
			const(void)* pointer, Enum preserve);
	void getObjectBufferfvATI(UInt buffer, Enum pname, Float* params);
	void getObjectBufferivATI(UInt buffer, Enum pname, Int* params);
	void freeObjectBufferATI(UInt buffer);
	void arrayObjectATI(Enum array, Int size, Enum type, Sizei stride,
			UInt buffer, UInt offset);
	void getArrayObjectfvATI(Enum array, Enum pname, Float* params);
	void getArrayObjectivATI(Enum array, Enum pname, Int* params);
	void variantArrayObjectATI(UInt id, Enum type, Sizei stride, UInt buffer, UInt offset);
	void getVariantArrayObjectfvATI(UInt id, Enum pname, Float* params);
	void getVariantArrayObjectivATI(UInt id, Enum pname, Int* params);

	void vertexAttribArrayObjectATI(UInt index, Int size, Enum type,
			Boolean normalized, Sizei stride, UInt buffer, UInt offset);
	void getVertexAttribArrayObjectfvATI(UInt index, Enum pname, Float* params);
	void getVertexAttribArrayObjectivATI(UInt index, Enum pname, Int* params);

	enum MAX_VERTEX_STREAMS_ATI = 0x876B;
	enum VERTEX_STREAM0_ATI = 0x876C;
	enum VERTEX_STREAM1_ATI = 0x876D;
	enum VERTEX_STREAM2_ATI = 0x876E;
	enum VERTEX_STREAM3_ATI = 0x876F;
	enum VERTEX_STREAM4_ATI = 0x8770;
	enum VERTEX_STREAM5_ATI = 0x8771;
	enum VERTEX_STREAM6_ATI = 0x8772;
	enum VERTEX_STREAM7_ATI = 0x8773;
	enum VERTEX_SOURCE_ATI = 0x8774;
	void vertexStream1sATI(Enum stream, Short x);
	void vertexStream1svATI(Enum stream, const(Short)* coords);
	void vertexStream1iATI(Enum stream, Int x);
	void vertexStream1ivATI(Enum stream, const(Int)* coords);
	void vertexStream1fATI(Enum stream, Float x);
	void vertexStream1fvATI(Enum stream, const(Float)* coords);
	void vertexStream1dATI(Enum stream, Double x);
	void vertexStream1dvATI(Enum stream, const(Double)* coords);
	void vertexStream2sATI(Enum stream, Short x, Short y);
	void vertexStream2svATI(Enum stream, const(Short)* coords);
	void vertexStream2iATI(Enum stream, Int x, Int y);
	void vertexStream2ivATI(Enum stream, const(Int)* coords);
	void vertexStream2fATI(Enum stream, Float x, Float y);
	void vertexStream2fvATI(Enum stream, const(Float)* coords);
	void vertexStream2dATI(Enum stream, Double x, Double y);
	void vertexStream2dvATI(Enum stream, const(Double)* coords);
	void vertexStream3sATI(Enum stream, Short x, Short y, Short z);
	void vertexStream3svATI(Enum stream, const(Short)* coords);
	void vertexStream3iATI(Enum stream, Int x, Int y, Int z);
	void vertexStream3ivATI(Enum stream, const(Int)* coords);
	void vertexStream3fATI(Enum stream, Float x, Float y, Float z);
	void vertexStream3fvATI(Enum stream, const(Float)* coords);
	void vertexStream3dATI(Enum stream, Double x, Double y, Double z);
	void vertexStream3dvATI(Enum stream, const(Double)* coords);
	void vertexStream4sATI(Enum stream, Short x, Short y, Short z, Short w);
	void vertexStream4svATI(Enum stream, const(Short)* coords);
	void vertexStream4iATI(Enum stream, Int x, Int y, Int z, Int w);
	void vertexStream4ivATI(Enum stream, const(Int)* coords);
	void vertexStream4fATI(Enum stream, Float x, Float y, Float z, Float w);
	void vertexStream4fvATI(Enum stream, const(Float)* coords);
	void vertexStream4dATI(Enum stream, Double x, Double y, Double z, Double w);
	void vertexStream4dvATI(Enum stream, const(Double)* coords);
	void normalStream3bATI(Enum stream, Byte nx, Byte ny, Byte nz);
	void normalStream3bvATI(Enum stream, const(Byte)* coords);
	void normalStream3sATI(Enum stream, Short nx, Short ny, Short nz);
	void normalStream3svATI(Enum stream, const(Short)* coords);
	void normalStream3iATI(Enum stream, Int nx, Int ny, Int nz);
	void normalStream3ivATI(Enum stream, const(Int)* coords);
	void normalStream3fATI(Enum stream, Float nx, Float ny, Float nz);
	void normalStream3fvATI(Enum stream, const(Float)* coords);
	void normalStream3dATI(Enum stream, Double nx, Double ny, Double nz);
	void normalStream3dvATI(Enum stream, const(Double)* coords);
	void clientActiveVertexStreamATI(Enum stream);
	void vertexBlendEnviATI(Enum pname, Int param);
	void vertexBlendEnvfATI(Enum pname, Float param);

	enum GL_422_EXT = 0x80CC;
	enum GL_422_REV_EXT = 0x80CD;
	enum GL_422_AVERAGE_EXT = 0x80CE;
	enum GL_422_REV_AVERAGE_EXT = 0x80CF;

	alias GLeglImageOES = void*;
	@BindingName("glEGLImageTargetTexStorageEXT")
	void eglImageTargetTexStorageEXT(Enum target, GLeglImageOES image, const(Int)* attrib_list);
	@BindingName("glEGLImageTargetTextureStorageEXT")
	void eglImageTargetTextureStorageEXT(UInt texture, GLeglImageOES image,
			const(Int)* attrib_list);

	enum ABGR_EXT = 0x8000;

	enum BGR_EXT = 0x80E0;
	enum BGRA_EXT = 0x80E1;

	enum MAX_VERTEX_BINDABLE_UNIFORMS_EXT = 0x8DE2;
	enum MAX_FRAGMENT_BINDABLE_UNIFORMS_EXT = 0x8DE3;
	enum MAX_GEOMETRY_BINDABLE_UNIFORMS_EXT = 0x8DE4;
	enum MAX_BINDABLE_UNIFORM_SIZE_EXT = 0x8DED;
	enum UNIFORM_BUFFER_EXT = 0x8DEE;
	enum UNIFORM_BUFFER_BINDING_EXT = 0x8DEF;
	void uniformBufferEXT(UInt program, Int location, UInt buffer);
	Int getUniformBufferSizeEXT(UInt program, Int location);
	Intptr getUniformOffsetEXT(UInt program, Int location);

	enum CONSTANT_COLOR_EXT = 0x8001;
	enum ONE_MINUS_CONSTANT_COLOR_EXT = 0x8002;
	enum CONSTANT_ALPHA_EXT = 0x8003;
	enum ONE_MINUS_CONSTANT_ALPHA_EXT = 0x8004;
	enum BLEND_COLOR_EXT = 0x8005;
	void blendColorEXT(Float red, Float green, Float blue, Float alpha);

	enum BLEND_EQUATION_RGB_EXT = 0x8009;
	enum BLEND_EQUATION_ALPHA_EXT = 0x883D;
	void blendEquationSeparateEXT(Enum modeRGB, Enum modeAlpha);

	enum BLEND_DST_RGB_EXT = 0x80C8;
	enum BLEND_SRC_RGB_EXT = 0x80C9;
	enum BLEND_DST_ALPHA_EXT = 0x80CA;
	enum BLEND_SRC_ALPHA_EXT = 0x80CB;
	void blendFuncSeparateEXT(Enum sfactorRGB, Enum dfactorRGB,
			Enum sfactorAlpha, Enum dfactorAlpha);

	enum MIN_EXT = 0x8007;
	enum MAX_EXT = 0x8008;
	enum FUNC_ADD_EXT = 0x8006;
	enum BLEND_EQUATION_EXT = 0x8009;
	void blendEquationEXT(Enum mode);

	enum FUNC_SUBTRACT_EXT = 0x800A;
	enum FUNC_REVERSE_SUBTRACT_EXT = 0x800B;

	enum CLIP_VOLUME_CLIPPING_HINT_EXT = 0x80F0;

	enum CMYK_EXT = 0x800C;
	enum CMYKA_EXT = 0x800D;
	enum PACK_CMYK_HINT_EXT = 0x800E;
	enum UNPACK_CMYK_HINT_EXT = 0x800F;

	void colorSubTableEXT(Enum target, Sizei start, Sizei count,
			Enum format, Enum type, const(void)* data);
	void copyColorSubTableEXT(Enum target, Sizei start, Int x, Int y, Sizei width);

	enum ARRAY_ELEMENT_LOCK_FIRST_EXT = 0x81A8;
	enum ARRAY_ELEMENT_LOCK_COUNT_EXT = 0x81A9;
	void lockArraysEXT(Int first, Sizei count);
	void unlockArraysEXT();

	enum CONVOLUTION_1D_EXT = 0x8010;
	enum CONVOLUTION_2D_EXT = 0x8011;
	enum SEPARABLE_2D_EXT = 0x8012;
	enum CONVOLUTION_BORDER_MODE_EXT = 0x8013;
	enum CONVOLUTION_FILTER_SCALE_EXT = 0x8014;
	enum CONVOLUTION_FILTER_BIAS_EXT = 0x8015;
	enum REDUCE_EXT = 0x8016;
	enum CONVOLUTION_FORMAT_EXT = 0x8017;
	enum CONVOLUTION_WIDTH_EXT = 0x8018;
	enum CONVOLUTION_HEIGHT_EXT = 0x8019;
	enum MAX_CONVOLUTION_WIDTH_EXT = 0x801A;
	enum MAX_CONVOLUTION_HEIGHT_EXT = 0x801B;
	enum POST_CONVOLUTION_RED_SCALE_EXT = 0x801C;
	enum POST_CONVOLUTION_GREEN_SCALE_EXT = 0x801D;
	enum POST_CONVOLUTION_BLUE_SCALE_EXT = 0x801E;
	enum POST_CONVOLUTION_ALPHA_SCALE_EXT = 0x801F;
	enum POST_CONVOLUTION_RED_BIAS_EXT = 0x8020;
	enum POST_CONVOLUTION_GREEN_BIAS_EXT = 0x8021;
	enum POST_CONVOLUTION_BLUE_BIAS_EXT = 0x8022;
	enum POST_CONVOLUTION_ALPHA_BIAS_EXT = 0x8023;
	void convolutionFilter1DEXT(Enum target, Enum internalformat,
			Sizei width, Enum format, Enum type, const(void)* image);
	void convolutionFilter2DEXT(Enum target, Enum internalformat,
			Sizei width, Sizei height, Enum format, Enum type, const(void)* image);
	void convolutionParameterfEXT(Enum target, Enum pname, Float params);
	void convolutionParameterfvEXT(Enum target, Enum pname, const(Float)* params);
	void convolutionParameteriEXT(Enum target, Enum pname, Int params);
	void convolutionParameterivEXT(Enum target, Enum pname, const(Int)* params);
	void copyConvolutionFilter1DEXT(Enum target, Enum internalformat, Int x,
			Int y, Sizei width);
	void copyConvolutionFilter2DEXT(Enum target, Enum internalformat, Int x,
			Int y, Sizei width, Sizei height);
	void getConvolutionFilterEXT(Enum target, Enum format, Enum type, void* image);
	void getConvolutionParameterfvEXT(Enum target, Enum pname, Float* params);
	void getConvolutionParameterivEXT(Enum target, Enum pname, Int* params);
	void getSeparableFilterEXT(Enum target, Enum format, Enum type,
			void* row, void* column, void* span);
	void separableFilter2DEXT(Enum target, Enum internalformat, Sizei width,
			Sizei height, Enum format, Enum type, const(void)* row, const(void)* column);

	enum TANGENT_ARRAY_EXT = 0x8439;
	enum BINORMAL_ARRAY_EXT = 0x843A;
	enum CURRENT_TANGENT_EXT = 0x843B;
	enum CURRENT_BINORMAL_EXT = 0x843C;
	enum TANGENT_ARRAY_TYPE_EXT = 0x843E;
	enum TANGENT_ARRAY_STRIDE_EXT = 0x843F;
	enum BINORMAL_ARRAY_TYPE_EXT = 0x8440;
	enum BINORMAL_ARRAY_STRIDE_EXT = 0x8441;
	enum TANGENT_ARRAY_POINTER_EXT = 0x8442;
	enum BINORMAL_ARRAY_POINTER_EXT = 0x8443;
	enum MAP1_TANGENT_EXT = 0x8444;
	enum MAP2_TANGENT_EXT = 0x8445;
	enum MAP1_BINORMAL_EXT = 0x8446;
	enum MAP2_BINORMAL_EXT = 0x8447;
	void tangent3bEXT(Byte tx, Byte ty, Byte tz);
	void tangent3bvEXT(const(Byte)* v);
	void tangent3dEXT(Double tx, Double ty, Double tz);
	void tangent3dvEXT(const(Double)* v);
	void tangent3fEXT(Float tx, Float ty, Float tz);
	void tangent3fvEXT(const(Float)* v);
	void tangent3iEXT(Int tx, Int ty, Int tz);
	void tangent3ivEXT(const(Int)* v);
	void tangent3sEXT(Short tx, Short ty, Short tz);
	void tangent3svEXT(const(Short)* v);
	void binormal3bEXT(Byte bx, Byte by, Byte bz);
	void binormal3bvEXT(const(Byte)* v);
	void binormal3dEXT(Double bx, Double by, Double bz);
	void binormal3dvEXT(const(Double)* v);
	void binormal3fEXT(Float bx, Float by, Float bz);
	void binormal3fvEXT(const(Float)* v);
	void binormal3iEXT(Int bx, Int by, Int bz);
	void binormal3ivEXT(const(Int)* v);
	void binormal3sEXT(Short bx, Short by, Short bz);
	void binormal3svEXT(const(Short)* v);
	void tangentPointerEXT(Enum type, Sizei stride, const(void)* pointer);
	void binormalPointerEXT(Enum type, Sizei stride, const(void)* pointer);

	void copyTexImage1DEXT(Enum target, Int level, Enum internalformat,
			Int x, Int y, Sizei width, Int border);
	void copyTexImage2DEXT(Enum target, Int level, Enum internalformat,
			Int x, Int y, Sizei width, Sizei height, Int border);
	void copyTexSubImage1DEXT(Enum target, Int level, Int xoffset,
			Int x, Int y, Sizei width);
	void copyTexSubImage2DEXT(Enum target, Int level, Int xoffset,
			Int yoffset, Int x, Int y, Sizei width, Sizei height);
	void copyTexSubImage3DEXT(Enum target, Int level, Int xoffset,
			Int yoffset, Int zoffset, Int x, Int y, Sizei width, Sizei height);

	enum CULL_VERTEX_EXT = 0x81AA;
	enum CULL_VERTEX_EYE_POSITION_EXT = 0x81AB;
	enum CULL_VERTEX_OBJECT_POSITION_EXT = 0x81AC;
	void cullParameterdvEXT(Enum pname, Double* params);
	void cullParameterfvEXT(Enum pname, Float* params);

	enum PROGRAM_PIPELINE_OBJECT_EXT = 0x8A4F;
	enum PROGRAM_OBJECT_EXT = 0x8B40;
	enum SHADER_OBJECT_EXT = 0x8B48;
	enum BUFFER_OBJECT_EXT = 0x9151;
	enum QUERY_OBJECT_EXT = 0x9153;
	enum VERTEX_ARRAY_OBJECT_EXT = 0x9154;
	void labelObjectEXT(Enum type, UInt object, Sizei length, const(Char)* label);
	void getObjectLabelEXT(Enum type, UInt object, Sizei bufSize,
			Sizei* length, Char* label);

	void insertEventMarkerEXT(Sizei length, const(Char)* marker);
	void pushGroupMarkerEXT(Sizei length, const(Char)* marker);
	void popGroupMarkerEXT();

	enum DEPTH_BOUNDS_TEST_EXT = 0x8890;
	enum DEPTH_BOUNDS_EXT = 0x8891;
	void depthBoundsEXT(Clampd zmin, Clampd zmax);

	enum PROGRAM_MATRIX_EXT = 0x8E2D;
	enum TRANSPOSE_PROGRAM_MATRIX_EXT = 0x8E2E;
	enum PROGRAM_MATRIX_STACK_DEPTH_EXT = 0x8E2F;
	void matrixLoadfEXT(Enum mode, const(Float)* m);
	void matrixLoaddEXT(Enum mode, const(Double)* m);
	void matrixMultfEXT(Enum mode, const(Float)* m);
	void matrixMultdEXT(Enum mode, const(Double)* m);
	void matrixLoadIdentityEXT(Enum mode);
	void matrixRotatefEXT(Enum mode, Float angle, Float x, Float y, Float z);
	void matrixRotatedEXT(Enum mode, Double angle, Double x, Double y, Double z);
	void matrixScalefEXT(Enum mode, Float x, Float y, Float z);
	void matrixScaledEXT(Enum mode, Double x, Double y, Double z);
	void matrixTranslatefEXT(Enum mode, Float x, Float y, Float z);
	void matrixTranslatedEXT(Enum mode, Double x, Double y, Double z);
	void matrixFrustumEXT(Enum mode, Double left, Double right,
			Double bottom, Double top, Double zNear, Double zFar);
	void matrixOrthoEXT(Enum mode, Double left, Double right,
			Double bottom, Double top, Double zNear, Double zFar);
	void matrixPopEXT(Enum mode);
	void matrixPushEXT(Enum mode);
	void clientAttribDefaultEXT(Bitfield mask);
	void pushClientAttribDefaultEXT(Bitfield mask);
	void textureParameterfEXT(UInt texture, Enum target, Enum pname, Float param);
	void textureParameterfvEXT(UInt texture, Enum target, Enum pname, const(Float)* params);
	void textureParameteriEXT(UInt texture, Enum target, Enum pname, Int param);
	void textureParameterivEXT(UInt texture, Enum target, Enum pname, const(Int)* params);
	void textureImage1DEXT(UInt texture, Enum target, Int level, Int internalformat,
			Sizei width, Int border, Enum format, Enum type, const(void)* pixels);
	void textureImage2DEXT(UInt texture, Enum target, Int level, Int internalformat,
			Sizei width, Sizei height, Int border, Enum format,
			Enum type, const(void)* pixels);
	void textureSubImage1DEXT(UInt texture, Enum target, Int level,
			Int xoffset, Sizei width, Enum format, Enum type, const(void)* pixels);
	void textureSubImage2DEXT(UInt texture, Enum target, Int level, Int xoffset,
			Int yoffset, Sizei width, Sizei height, Enum format,
			Enum type, const(void)* pixels);
	void copyTextureImage1DEXT(UInt texture, Enum target, Int level,
			Enum internalformat, Int x, Int y, Sizei width, Int border);
	void copyTextureImage2DEXT(UInt texture, Enum target, Int level,
			Enum internalformat, Int x, Int y, Sizei width, Sizei height, Int border);
	void copyTextureSubImage1DEXT(UInt texture, Enum target, Int level,
			Int xoffset, Int x, Int y, Sizei width);
	void copyTextureSubImage2DEXT(UInt texture, Enum target, Int level,
			Int xoffset, Int yoffset, Int x, Int y, Sizei width, Sizei height);
	void getTextureImageEXT(UInt texture, Enum target, Int level,
			Enum format, Enum type, void* pixels);
	void getTextureParameterfvEXT(UInt texture, Enum target, Enum pname, Float* params);
	void getTextureParameterivEXT(UInt texture, Enum target, Enum pname, Int* params);
	void getTextureLevelParameterfvEXT(UInt texture, Enum target, Int level,
			Enum pname, Float* params);
	void getTextureLevelParameterivEXT(UInt texture, Enum target, Int level,
			Enum pname, Int* params);
	void textureImage3DEXT(UInt texture, Enum target, Int level, Int internalformat, Sizei width,
			Sizei height, Sizei depth, Int border, Enum format,
			Enum type, const(void)* pixels);
	void textureSubImage3DEXT(UInt texture, Enum target, Int level, Int xoffset, Int yoffset,
			Int zoffset, Sizei width, Sizei height, Sizei depth,
			Enum format, Enum type, const(void)* pixels);
	void copyTextureSubImage3DEXT(UInt texture, Enum target, Int level, Int xoffset,
			Int yoffset, Int zoffset, Int x, Int y, Sizei width, Sizei height);
	void bindMultiTextureEXT(Enum texunit, Enum target, UInt texture);
	void multiTexCoordPointerEXT(Enum texunit, Int size, Enum type,
			Sizei stride, const(void)* pointer);
	void multiTexEnvfEXT(Enum texunit, Enum target, Enum pname, Float param);
	void multiTexEnvfvEXT(Enum texunit, Enum target, Enum pname, const(Float)* params);
	void multiTexEnviEXT(Enum texunit, Enum target, Enum pname, Int param);
	void multiTexEnvivEXT(Enum texunit, Enum target, Enum pname, const(Int)* params);
	void multiTexGendEXT(Enum texunit, Enum coord, Enum pname, Double param);
	void multiTexGendvEXT(Enum texunit, Enum coord, Enum pname, const(Double)* params);
	void multiTexGenfEXT(Enum texunit, Enum coord, Enum pname, Float param);
	void multiTexGenfvEXT(Enum texunit, Enum coord, Enum pname, const(Float)* params);
	void multiTexGeniEXT(Enum texunit, Enum coord, Enum pname, Int param);
	void multiTexGenivEXT(Enum texunit, Enum coord, Enum pname, const(Int)* params);
	void getMultiTexEnvfvEXT(Enum texunit, Enum target, Enum pname, Float* params);
	void getMultiTexEnvivEXT(Enum texunit, Enum target, Enum pname, Int* params);
	void getMultiTexGendvEXT(Enum texunit, Enum coord, Enum pname, Double* params);
	void getMultiTexGenfvEXT(Enum texunit, Enum coord, Enum pname, Float* params);
	void getMultiTexGenivEXT(Enum texunit, Enum coord, Enum pname, Int* params);
	void multiTexParameteriEXT(Enum texunit, Enum target, Enum pname, Int param);
	void multiTexParameterivEXT(Enum texunit, Enum target, Enum pname, const(Int)* params);
	void multiTexParameterfEXT(Enum texunit, Enum target, Enum pname, Float param);
	void multiTexParameterfvEXT(Enum texunit, Enum target, Enum pname,
			const(Float)* params);
	void multiTexImage1DEXT(Enum texunit, Enum target, Int level, Int internalformat,
			Sizei width, Int border, Enum format, Enum type, const(void)* pixels);
	void multiTexImage2DEXT(Enum texunit, Enum target, Int level, Int internalformat,
			Sizei width, Sizei height, Int border, Enum format,
			Enum type, const(void)* pixels);
	void multiTexSubImage1DEXT(Enum texunit, Enum target, Int level,
			Int xoffset, Sizei width, Enum format, Enum type, const(void)* pixels);
	void multiTexSubImage2DEXT(Enum texunit, Enum target, Int level, Int xoffset,
			Int yoffset, Sizei width, Sizei height, Enum format,
			Enum type, const(void)* pixels);
	void copyMultiTexImage1DEXT(Enum texunit, Enum target, Int level,
			Enum internalformat, Int x, Int y, Sizei width, Int border);
	void copyMultiTexImage2DEXT(Enum texunit, Enum target, Int level,
			Enum internalformat, Int x, Int y, Sizei width, Sizei height, Int border);
	void copyMultiTexSubImage1DEXT(Enum texunit, Enum target, Int level,
			Int xoffset, Int x, Int y, Sizei width);
	void copyMultiTexSubImage2DEXT(Enum texunit, Enum target, Int level,
			Int xoffset, Int yoffset, Int x, Int y, Sizei width, Sizei height);
	void getMultiTexImageEXT(Enum texunit, Enum target, Int level,
			Enum format, Enum type, void* pixels);
	void getMultiTexParameterfvEXT(Enum texunit, Enum target, Enum pname, Float* params);
	void getMultiTexParameterivEXT(Enum texunit, Enum target, Enum pname, Int* params);
	void getMultiTexLevelParameterfvEXT(Enum texunit, Enum target,
			Int level, Enum pname, Float* params);
	void getMultiTexLevelParameterivEXT(Enum texunit, Enum target,
			Int level, Enum pname, Int* params);
	void multiTexImage3DEXT(Enum texunit, Enum target, Int level, Int internalformat, Sizei width,
			Sizei height, Sizei depth, Int border, Enum format,
			Enum type, const(void)* pixels);
	void multiTexSubImage3DEXT(Enum texunit, Enum target, Int level, Int xoffset, Int yoffset,
			Int zoffset, Sizei width, Sizei height, Sizei depth,
			Enum format, Enum type, const(void)* pixels);
	void copyMultiTexSubImage3DEXT(Enum texunit, Enum target, Int level, Int xoffset,
			Int yoffset, Int zoffset, Int x, Int y, Sizei width, Sizei height);
	void enableClientStateIndexedEXT(Enum array, UInt index);
	void disableClientStateIndexedEXT(Enum array, UInt index);
	void getFloatIndexedvEXT(Enum target, UInt index, Float* data);
	void getDoubleIndexedvEXT(Enum target, UInt index, Double* data);
	void getPointerIndexedvEXT(Enum target, UInt index, void** data);
	void enableIndexedEXT(Enum target, UInt index);
	void disableIndexedEXT(Enum target, UInt index);
	Boolean isEnabledIndexedEXT(Enum target, UInt index);
	void getIntegerIndexedvEXT(Enum target, UInt index, Int* data);
	void getBooleanIndexedvEXT(Enum target, UInt index, Boolean* data);
	void compressedTextureImage3DEXT(UInt texture, Enum target, Int level, Enum internalformat,
			Sizei width, Sizei height, Sizei depth, Int border,
			Sizei imageSize, const(void)* bits);
	void compressedTextureImage2DEXT(UInt texture, Enum target, Int level, Enum internalformat,
			Sizei width, Sizei height, Int border, Sizei imageSize, const(void)* bits);
	void compressedTextureImage1DEXT(UInt texture, Enum target, Int level,
			Enum internalformat, Sizei width, Int border,
			Sizei imageSize, const(void)* bits);
	void compressedTextureSubImage3DEXT(UInt texture, Enum target, Int level, Int xoffset, Int yoffset,
			Int zoffset, Sizei width, Sizei height, Sizei depth,
			Enum format, Sizei imageSize, const(void)* bits);
	void compressedTextureSubImage2DEXT(UInt texture, Enum target, Int level, Int xoffset, Int yoffset,
			Sizei width, Sizei height, Enum format, Sizei imageSize, const(void)* bits);
	void compressedTextureSubImage1DEXT(UInt texture, Enum target, Int level,
			Int xoffset, Sizei width, Enum format, Sizei imageSize, const(void)* bits);
	void getCompressedTextureImageEXT(UInt texture, Enum target, Int lod, void* img);
	void compressedMultiTexImage3DEXT(Enum texunit, Enum target, Int level, Enum internalformat,
			Sizei width, Sizei height, Sizei depth, Int border,
			Sizei imageSize, const(void)* bits);
	void compressedMultiTexImage2DEXT(Enum texunit, Enum target, Int level, Enum internalformat,
			Sizei width, Sizei height, Int border, Sizei imageSize, const(void)* bits);
	void compressedMultiTexImage1DEXT(Enum texunit, Enum target, Int level,
			Enum internalformat, Sizei width, Int border,
			Sizei imageSize, const(void)* bits);
	void compressedMultiTexSubImage3DEXT(Enum texunit, Enum target, Int level, Int xoffset, Int yoffset,
			Int zoffset, Sizei width, Sizei height, Sizei depth,
			Enum format, Sizei imageSize, const(void)* bits);
	void compressedMultiTexSubImage2DEXT(Enum texunit, Enum target, Int level, Int xoffset, Int yoffset,
			Sizei width, Sizei height, Enum format, Sizei imageSize, const(void)* bits);
	void compressedMultiTexSubImage1DEXT(Enum texunit, Enum target, Int level,
			Int xoffset, Sizei width, Enum format, Sizei imageSize, const(void)* bits);
	void getCompressedMultiTexImageEXT(Enum texunit, Enum target, Int lod, void* img);
	void matrixLoadTransposefEXT(Enum mode, const(Float)* m);
	void matrixLoadTransposedEXT(Enum mode, const(Double)* m);
	void matrixMultTransposefEXT(Enum mode, const(Float)* m);
	void matrixMultTransposedEXT(Enum mode, const(Double)* m);
	void namedBufferDataEXT(UInt buffer, Sizeiptr size, const(void)* data, Enum usage);
	void namedBufferSubDataEXT(UInt buffer, Intptr offset, Sizeiptr size, const(void)* data);
	void* mapNamedBufferEXT(UInt buffer, Enum access);
	Boolean unmapNamedBufferEXT(UInt buffer);
	void getNamedBufferParameterivEXT(UInt buffer, Enum pname, Int* params);
	void getNamedBufferPointervEXT(UInt buffer, Enum pname, void** params);
	void getNamedBufferSubDataEXT(UInt buffer, Intptr offset, Sizeiptr size, void* data);
	void programUniform1fEXT(UInt program, Int location, Float v0);
	void programUniform2fEXT(UInt program, Int location, Float v0, Float v1);
	void programUniform3fEXT(UInt program, Int location, Float v0, Float v1, Float v2);
	void programUniform4fEXT(UInt program, Int location, Float v0,
			Float v1, Float v2, Float v3);
	void programUniform1iEXT(UInt program, Int location, Int v0);
	void programUniform2iEXT(UInt program, Int location, Int v0, Int v1);
	void programUniform3iEXT(UInt program, Int location, Int v0, Int v1, Int v2);
	void programUniform4iEXT(UInt program, Int location, Int v0, Int v1, Int v2, Int v3);
	void programUniform1fvEXT(UInt program, Int location, Sizei count, const(Float)* value);
	void programUniform2fvEXT(UInt program, Int location, Sizei count, const(Float)* value);
	void programUniform3fvEXT(UInt program, Int location, Sizei count, const(Float)* value);
	void programUniform4fvEXT(UInt program, Int location, Sizei count, const(Float)* value);
	void programUniform1ivEXT(UInt program, Int location, Sizei count, const(Int)* value);
	void programUniform2ivEXT(UInt program, Int location, Sizei count, const(Int)* value);
	void programUniform3ivEXT(UInt program, Int location, Sizei count, const(Int)* value);
	void programUniform4ivEXT(UInt program, Int location, Sizei count, const(Int)* value);
	void programUniformMatrix2fvEXT(UInt program, Int location, Sizei count,
			Boolean transpose, const(Float)* value);
	void programUniformMatrix3fvEXT(UInt program, Int location, Sizei count,
			Boolean transpose, const(Float)* value);
	void programUniformMatrix4fvEXT(UInt program, Int location, Sizei count,
			Boolean transpose, const(Float)* value);
	void programUniformMatrix2x3fvEXT(UInt program, Int location,
			Sizei count, Boolean transpose, const(Float)* value);
	void programUniformMatrix3x2fvEXT(UInt program, Int location,
			Sizei count, Boolean transpose, const(Float)* value);
	void programUniformMatrix2x4fvEXT(UInt program, Int location,
			Sizei count, Boolean transpose, const(Float)* value);
	void programUniformMatrix4x2fvEXT(UInt program, Int location,
			Sizei count, Boolean transpose, const(Float)* value);
	void programUniformMatrix3x4fvEXT(UInt program, Int location,
			Sizei count, Boolean transpose, const(Float)* value);
	void programUniformMatrix4x3fvEXT(UInt program, Int location,
			Sizei count, Boolean transpose, const(Float)* value);
	void textureBufferEXT(UInt texture, Enum target, Enum internalformat, UInt buffer);
	void multiTexBufferEXT(Enum texunit, Enum target, Enum internalformat, UInt buffer);
	void textureParameterIivEXT(UInt texture, Enum target, Enum pname, const(Int)* params);
	void textureParameterIuivEXT(UInt texture, Enum target, Enum pname,
			const(UInt)* params);
	void getTextureParameterIivEXT(UInt texture, Enum target, Enum pname, Int* params);
	void getTextureParameterIuivEXT(UInt texture, Enum target, Enum pname, UInt* params);
	void multiTexParameterIivEXT(Enum texunit, Enum target, Enum pname, const(Int)* params);
	void multiTexParameterIuivEXT(Enum texunit, Enum target, Enum pname,
			const(UInt)* params);
	void getMultiTexParameterIivEXT(Enum texunit, Enum target, Enum pname, Int* params);
	void getMultiTexParameterIuivEXT(Enum texunit, Enum target, Enum pname, UInt* params);
	void programUniform1UiEXT(UInt program, Int location, UInt v0);
	void programUniform2UiEXT(UInt program, Int location, UInt v0, UInt v1);
	void programUniform3UiEXT(UInt program, Int location, UInt v0, UInt v1, UInt v2);
	void programUniform4UiEXT(UInt program, Int location, UInt v0,
			UInt v1, UInt v2, UInt v3);
	void programUniform1UivEXT(UInt program, Int location, Sizei count, const(UInt)* value);
	void programUniform2UivEXT(UInt program, Int location, Sizei count, const(UInt)* value);
	void programUniform3UivEXT(UInt program, Int location, Sizei count, const(UInt)* value);
	void programUniform4UivEXT(UInt program, Int location, Sizei count, const(UInt)* value);
	void namedProgramLocalParameters4fvEXT(UInt program, Enum target,
			UInt index, Sizei count, const(Float)* params);
	void namedProgramLocalParameterI4iEXT(UInt program, Enum target,
			UInt index, Int x, Int y, Int z, Int w);
	void namedProgramLocalParameterI4ivEXT(UInt program, Enum target,
			UInt index, const(Int)* params);
	void namedProgramLocalParametersI4ivEXT(UInt program, Enum target,
			UInt index, Sizei count, const(Int)* params);
	void namedProgramLocalParameterI4UiEXT(UInt program, Enum target,
			UInt index, UInt x, UInt y, UInt z, UInt w);
	void namedProgramLocalParameterI4UivEXT(UInt program, Enum target,
			UInt index, const(UInt)* params);
	void namedProgramLocalParametersI4UivEXT(UInt program, Enum target,
			UInt index, Sizei count, const(UInt)* params);
	void getNamedProgramLocalParameterIivEXT(UInt program, Enum target,
			UInt index, Int* params);
	void getNamedProgramLocalParameterIuivEXT(UInt program, Enum target,
			UInt index, UInt* params);
	void enableClientStateiEXT(Enum array, UInt index);
	void disableClientStateiEXT(Enum array, UInt index);
	void getFloati_vEXT(Enum pname, UInt index, Float* params);
	void getDoublei_vEXT(Enum pname, UInt index, Double* params);
	void getPointeri_vEXT(Enum pname, UInt index, void** params);
	void namedProgramStringEXT(UInt program, Enum target, Enum format,
			Sizei len, const(void)* string);
	void namedProgramLocalParameter4dEXT(UInt program, Enum target,
			UInt index, Double x, Double y, Double z, Double w);
	void namedProgramLocalParameter4dvEXT(UInt program, Enum target,
			UInt index, const(Double)* params);
	void namedProgramLocalParameter4fEXT(UInt program, Enum target,
			UInt index, Float x, Float y, Float z, Float w);
	void namedProgramLocalParameter4fvEXT(UInt program, Enum target,
			UInt index, const(Float)* params);
	void getNamedProgramLocalParameterdvEXT(UInt program, Enum target,
			UInt index, Double* params);
	void getNamedProgramLocalParameterfvEXT(UInt program, Enum target,
			UInt index, Float* params);
	void getNamedProgramivEXT(UInt program, Enum target, Enum pname, Int* params);
	void getNamedProgramStringEXT(UInt program, Enum target, Enum pname, void* string);
	void namedRenderbufferStorageEXT(UInt renderbuffer, Enum internalformat,
			Sizei width, Sizei height);
	void getNamedRenderbufferParameterivEXT(UInt renderbuffer, Enum pname, Int* params);
	void namedRenderbufferStorageMultisampleEXT(UInt renderbuffer,
			Sizei samples, Enum internalformat, Sizei width, Sizei height);
	void namedRenderbufferStorageMultisampleCoverageEXT(UInt renderbuffer, Sizei coverageSamples,
			Sizei colorSamples, Enum internalformat, Sizei width, Sizei height);
	Enum checkNamedFramebufferStatusEXT(UInt framebuffer, Enum target);
	void namedFramebufferTexture1DEXT(UInt framebuffer, Enum attachment,
			Enum textarget, UInt texture, Int level);
	void namedFramebufferTexture2DEXT(UInt framebuffer, Enum attachment,
			Enum textarget, UInt texture, Int level);
	void namedFramebufferTexture3DEXT(UInt framebuffer, Enum attachment,
			Enum textarget, UInt texture, Int level, Int zoffset);
	void namedFramebufferRenderbufferEXT(UInt framebuffer, Enum attachment,
			Enum renderbuffertarget, UInt renderbuffer);
	void getNamedFramebufferAttachmentParameterivEXT(UInt framebuffer,
			Enum attachment, Enum pname, Int* params);
	void generateTextureMipmapEXT(UInt texture, Enum target);
	void generateMultiTexMipmapEXT(Enum texunit, Enum target);
	void framebufferDrawBufferEXT(UInt framebuffer, Enum mode);
	void framebufferDrawBuffersEXT(UInt framebuffer, Sizei n, const(Enum)* bufs);
	void framebufferReadBufferEXT(UInt framebuffer, Enum mode);
	void getFramebufferParameterivEXT(UInt framebuffer, Enum pname, Int* params);
	void namedCopyBufferSubDataEXT(UInt readBuffer, UInt writeBuffer,
			Intptr readOffset, Intptr writeOffset, Sizeiptr size);
	void namedFramebufferTextureEXT(UInt framebuffer, Enum attachment,
			UInt texture, Int level);
	void namedFramebufferTextureLayerEXT(UInt framebuffer, Enum attachment,
			UInt texture, Int level, Int layer);
	void namedFramebufferTextureFaceEXT(UInt framebuffer, Enum attachment,
			UInt texture, Int level, Enum face);
	void textureRenderbufferEXT(UInt texture, Enum target, UInt renderbuffer);
	void multiTexRenderbufferEXT(Enum texunit, Enum target, UInt renderbuffer);
	void vertexArrayVertexOffsetEXT(UInt vaobj, UInt buffer, Int size,
			Enum type, Sizei stride, Intptr offset);
	void vertexArrayColorOffsetEXT(UInt vaobj, UInt buffer, Int size,
			Enum type, Sizei stride, Intptr offset);
	void vertexArrayEdgeFlagOffsetEXT(UInt vaobj, UInt buffer, Sizei stride, Intptr offset);
	void vertexArrayIndexOffsetEXT(UInt vaobj, UInt buffer, Enum type,
			Sizei stride, Intptr offset);
	void vertexArrayNormalOffsetEXT(UInt vaobj, UInt buffer, Enum type,
			Sizei stride, Intptr offset);
	void vertexArrayTexCoordOffsetEXT(UInt vaobj, UInt buffer, Int size,
			Enum type, Sizei stride, Intptr offset);
	void vertexArrayMultiTexCoordOffsetEXT(UInt vaobj, UInt buffer,
			Enum texunit, Int size, Enum type, Sizei stride, Intptr offset);
	void vertexArrayFogCoordOffsetEXT(UInt vaobj, UInt buffer, Enum type,
			Sizei stride, Intptr offset);
	void vertexArraySecondaryColorOffsetEXT(UInt vaobj, UInt buffer,
			Int size, Enum type, Sizei stride, Intptr offset);
	void vertexArrayVertexAttribOffsetEXT(UInt vaobj, UInt buffer, UInt index,
			Int size, Enum type, Boolean normalized, Sizei stride, Intptr offset);
	void vertexArrayVertexAttribIOffsetEXT(UInt vaobj, UInt buffer,
			UInt index, Int size, Enum type, Sizei stride, Intptr offset);
	void enableVertexArrayEXT(UInt vaobj, Enum array);
	void disableVertexArrayEXT(UInt vaobj, Enum array);
	void enableVertexArrayAttribEXT(UInt vaobj, UInt index);
	void disableVertexArrayAttribEXT(UInt vaobj, UInt index);
	void getVertexArrayIntegervEXT(UInt vaobj, Enum pname, Int* param);
	void getVertexArrayPointervEXT(UInt vaobj, Enum pname, void** param);
	void getVertexArrayIntegeri_vEXT(UInt vaobj, UInt index, Enum pname, Int* param);
	void getVertexArrayPointeri_vEXT(UInt vaobj, UInt index, Enum pname, void** param);
	void* mapNamedBufferRangeEXT(UInt buffer, Intptr offset,
			Sizeiptr length, Bitfield access);
	void flushMappedNamedBufferRangeEXT(UInt buffer, Intptr offset, Sizeiptr length);
	void namedBufferStorageEXT(UInt buffer, Sizeiptr size, const(void)* data, Bitfield flags);
	void clearNamedBufferDataEXT(UInt buffer, Enum internalformat,
			Enum format, Enum type, const(void)* data);
	void clearNamedBufferSubDataEXT(UInt buffer, Enum internalformat,
			Sizeiptr offset, Sizeiptr size, Enum format, Enum type, const(void)* data);
	void namedFramebufferParameteriEXT(UInt framebuffer, Enum pname, Int param);
	void getNamedFramebufferParameterivEXT(UInt framebuffer, Enum pname, Int* params);
	void programUniform1dEXT(UInt program, Int location, Double x);
	void programUniform2dEXT(UInt program, Int location, Double x, Double y);
	void programUniform3dEXT(UInt program, Int location, Double x, Double y, Double z);
	void programUniform4dEXT(UInt program, Int location, Double x,
			Double y, Double z, Double w);
	void programUniform1dvEXT(UInt program, Int location, Sizei count,
			const(Double)* value);
	void programUniform2dvEXT(UInt program, Int location, Sizei count,
			const(Double)* value);
	void programUniform3dvEXT(UInt program, Int location, Sizei count,
			const(Double)* value);
	void programUniform4dvEXT(UInt program, Int location, Sizei count,
			const(Double)* value);
	void programUniformMatrix2dvEXT(UInt program, Int location, Sizei count,
			Boolean transpose, const(Double)* value);
	void programUniformMatrix3dvEXT(UInt program, Int location, Sizei count,
			Boolean transpose, const(Double)* value);
	void programUniformMatrix4dvEXT(UInt program, Int location, Sizei count,
			Boolean transpose, const(Double)* value);
	void programUniformMatrix2x3dvEXT(UInt program, Int location,
			Sizei count, Boolean transpose, const(Double)* value);
	void programUniformMatrix2x4dvEXT(UInt program, Int location,
			Sizei count, Boolean transpose, const(Double)* value);
	void programUniformMatrix3x2dvEXT(UInt program, Int location,
			Sizei count, Boolean transpose, const(Double)* value);
	void programUniformMatrix3x4dvEXT(UInt program, Int location,
			Sizei count, Boolean transpose, const(Double)* value);
	void programUniformMatrix4x2dvEXT(UInt program, Int location,
			Sizei count, Boolean transpose, const(Double)* value);
	void programUniformMatrix4x3dvEXT(UInt program, Int location,
			Sizei count, Boolean transpose, const(Double)* value);
	void textureBufferRangeEXT(UInt texture, Enum target,
			Enum internalformat, UInt buffer, Intptr offset, Sizeiptr size);
	void textureStorage1DEXT(UInt texture, Enum target, Sizei levels,
			Enum internalformat, Sizei width);
	void textureStorage2DEXT(UInt texture, Enum target, Sizei levels,
			Enum internalformat, Sizei width, Sizei height);
	void textureStorage3DEXT(UInt texture, Enum target, Sizei levels,
			Enum internalformat, Sizei width, Sizei height, Sizei depth);
	void textureStorage2DMultisampleEXT(UInt texture, Enum target, Sizei samples,
			Enum internalformat, Sizei width, Sizei height, Boolean fixedsamplelocations);
	void textureStorage3DMultisampleEXT(UInt texture, Enum target, Sizei samples, Enum internalformat,
			Sizei width, Sizei height, Sizei depth, Boolean fixedsamplelocations);
	void vertexArrayBindVertexBufferEXT(UInt vaobj, UInt bindingindex,
			UInt buffer, Intptr offset, Sizei stride);
	void vertexArrayVertexAttribFormatEXT(UInt vaobj, UInt attribindex,
			Int size, Enum type, Boolean normalized, UInt relativeoffset);
	void vertexArrayVertexAttribIFormatEXT(UInt vaobj, UInt attribindex,
			Int size, Enum type, UInt relativeoffset);
	void vertexArrayVertexAttribLFormatEXT(UInt vaobj, UInt attribindex,
			Int size, Enum type, UInt relativeoffset);
	void vertexArrayVertexAttribBindingEXT(UInt vaobj, UInt attribindex, UInt bindingindex);
	void vertexArrayVertexBindingDivisorEXT(UInt vaobj, UInt bindingindex, UInt divisor);
	void vertexArrayVertexAttribLOffsetEXT(UInt vaobj, UInt buffer,
			UInt index, Int size, Enum type, Sizei stride, Intptr offset);
	void texturePageCommitmentEXT(UInt texture, Int level, Int xoffset, Int yoffset,
			Int zoffset, Sizei width, Sizei height, Sizei depth, Boolean commit);
	void vertexArrayVertexAttribDivisorEXT(UInt vaobj, UInt index, UInt divisor);

	void colorMaskIndexedEXT(UInt index, Boolean r, Boolean g, Boolean b, Boolean a);

	void drawArraysInstancedEXT(Enum mode, Int start, Sizei count, Sizei primcount);
	void drawElementsInstancedEXT(Enum mode, Sizei count, Enum type,
			const(void)* indices, Sizei primcount);

	enum MAX_ELEMENTS_VERTICES_EXT = 0x80E8;
	enum MAX_ELEMENTS_INDICES_EXT = 0x80E9;
	void drawRangeElementsEXT(Enum mode, UInt start, UInt end, Sizei count,
			Enum type, const(void)* indices);

	alias GLeglClientBufferEXT = void*;
	void bufferStorageExternalEXT(Enum target, Intptr offset, Sizeiptr size,
			GLeglClientBufferEXT clientBuffer, Bitfield flags);
	void namedBufferStorageExternalEXT(UInt buffer, Intptr offset,
			Sizeiptr size, GLeglClientBufferEXT clientBuffer, Bitfield flags);

	enum FOG_COORDINATE_SOURCE_EXT = 0x8450;
	enum FOG_COORDINATE_EXT = 0x8451;
	enum FRAGMENT_DEPTH_EXT = 0x8452;
	enum CURRENT_FOG_COORDINATE_EXT = 0x8453;
	enum FOG_COORDINATE_ARRAY_TYPE_EXT = 0x8454;
	enum FOG_COORDINATE_ARRAY_STRIDE_EXT = 0x8455;
	enum FOG_COORDINATE_ARRAY_POINTER_EXT = 0x8456;
	enum FOG_COORDINATE_ARRAY_EXT = 0x8457;
	void fogCoordfEXT(Float coord);
	void fogCoordfvEXT(const(Float)* coord);
	void fogCoorddEXT(Double coord);
	void fogCoorddvEXT(const(Double)* coord);
	void fogCoordPointerEXT(Enum type, Sizei stride, const(void)* pointer);

	enum READ_FRAMEBUFFER_EXT = 0x8CA8;
	enum DRAW_FRAMEBUFFER_EXT = 0x8CA9;
	enum DRAW_FRAMEBUFFER_BINDING_EXT = 0x8CA6;
	enum READ_FRAMEBUFFER_BINDING_EXT = 0x8CAA;
	void blitFramebufferEXT(Int srcX0, Int srcY0, Int srcX1, Int srcY1,
			Int dstX0, Int dstY0, Int dstX1, Int dstY1, Bitfield mask, Enum filter);

	enum RENDERBUFFER_SAMPLES_EXT = 0x8CAB;
	enum FRAMEBUFFER_INCOMPLETE_MULTISAMPLE_EXT = 0x8D56;
	enum MAX_SAMPLES_EXT = 0x8D57;
	void renderbufferStorageMultisampleEXT(Enum target, Sizei samples,
			Enum internalformat, Sizei width, Sizei height);

	enum SCALED_RESOLVE_FASTEST_EXT = 0x90BA;
	enum SCALED_RESOLVE_NICEST_EXT = 0x90BB;

	enum INVALID_FRAMEBUFFER_OPERATION_EXT = 0x0506;
	enum MAX_RENDERBUFFER_SIZE_EXT = 0x84E8;
	enum FRAMEBUFFER_BINDING_EXT = 0x8CA6;
	enum RENDERBUFFER_BINDING_EXT = 0x8CA7;
	enum FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE_EXT = 0x8CD0;
	enum FRAMEBUFFER_ATTACHMENT_OBJECT_NAME_EXT = 0x8CD1;
	enum FRAMEBUFFER_ATTACHMENT_TEXTURE_LEVEL_EXT = 0x8CD2;
	enum FRAMEBUFFER_ATTACHMENT_TEXTURE_CUBE_MAP_FACE_EXT = 0x8CD3;
	enum FRAMEBUFFER_ATTACHMENT_TEXTURE_3D_ZOFFSET_EXT = 0x8CD4;
	enum FRAMEBUFFER_COMPLETE_EXT = 0x8CD5;
	enum FRAMEBUFFER_INCOMPLETE_ATTACHMENT_EXT = 0x8CD6;
	enum FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT_EXT = 0x8CD7;
	enum FRAMEBUFFER_INCOMPLETE_DIMENSIONS_EXT = 0x8CD9;
	enum FRAMEBUFFER_INCOMPLETE_FORMATS_EXT = 0x8CDA;
	enum FRAMEBUFFER_INCOMPLETE_DRAW_BUFFER_EXT = 0x8CDB;
	enum FRAMEBUFFER_INCOMPLETE_READ_BUFFER_EXT = 0x8CDC;
	enum FRAMEBUFFER_UNSUPPORTED_EXT = 0x8CDD;
	enum MAX_COLOR_ATTACHMENTS_EXT = 0x8CDF;
	enum COLOR_ATTACHMENT0_EXT = 0x8CE0;
	enum COLOR_ATTACHMENT1_EXT = 0x8CE1;
	enum COLOR_ATTACHMENT2_EXT = 0x8CE2;
	enum COLOR_ATTACHMENT3_EXT = 0x8CE3;
	enum COLOR_ATTACHMENT4_EXT = 0x8CE4;
	enum COLOR_ATTACHMENT5_EXT = 0x8CE5;
	enum COLOR_ATTACHMENT6_EXT = 0x8CE6;
	enum COLOR_ATTACHMENT7_EXT = 0x8CE7;
	enum COLOR_ATTACHMENT8_EXT = 0x8CE8;
	enum COLOR_ATTACHMENT9_EXT = 0x8CE9;
	enum COLOR_ATTACHMENT10_EXT = 0x8CEA;
	enum COLOR_ATTACHMENT11_EXT = 0x8CEB;
	enum COLOR_ATTACHMENT12_EXT = 0x8CEC;
	enum COLOR_ATTACHMENT13_EXT = 0x8CED;
	enum COLOR_ATTACHMENT14_EXT = 0x8CEE;
	enum COLOR_ATTACHMENT15_EXT = 0x8CEF;
	enum DEPTH_ATTACHMENT_EXT = 0x8D00;
	enum STENCIL_ATTACHMENT_EXT = 0x8D20;
	enum FRAMEBUFFER_EXT = 0x8D40;
	enum RENDERBUFFER_EXT = 0x8D41;
	enum RENDERBUFFER_WIDTH_EXT = 0x8D42;
	enum RENDERBUFFER_HEIGHT_EXT = 0x8D43;
	enum RENDERBUFFER_INTERNAL_FORMAT_EXT = 0x8D44;
	enum STENCIL_INDEX1_EXT = 0x8D46;
	enum STENCIL_INDEX4_EXT = 0x8D47;
	enum STENCIL_INDEX8_EXT = 0x8D48;
	enum STENCIL_INDEX16_EXT = 0x8D49;
	enum RENDERBUFFER_RED_SIZE_EXT = 0x8D50;
	enum RENDERBUFFER_GREEN_SIZE_EXT = 0x8D51;
	enum RENDERBUFFER_BLUE_SIZE_EXT = 0x8D52;
	enum RENDERBUFFER_ALPHA_SIZE_EXT = 0x8D53;
	enum RENDERBUFFER_DEPTH_SIZE_EXT = 0x8D54;
	enum RENDERBUFFER_STENCIL_SIZE_EXT = 0x8D55;
	Boolean isRenderbufferEXT(UInt renderbuffer);
	void bindRenderbufferEXT(Enum target, UInt renderbuffer);
	void deleteRenderbuffersEXT(Sizei n, const(UInt)* renderbuffers);
	void genRenderbuffersEXT(Sizei n, UInt* renderbuffers);
	void renderbufferStorageEXT(Enum target, Enum internalformat, Sizei width, Sizei height);
	void getRenderbufferParameterivEXT(Enum target, Enum pname, Int* params);
	Boolean isFramebufferEXT(UInt framebuffer);
	void bindFramebufferEXT(Enum target, UInt framebuffer);
	void deleteFramebuffersEXT(Sizei n, const(UInt)* framebuffers);
	void genFramebuffersEXT(Sizei n, UInt* framebuffers);
	Enum checkFramebufferStatusEXT(Enum target);
	void framebufferTexture1DEXT(Enum target, Enum attachment,
			Enum textarget, UInt texture, Int level);
	void framebufferTexture2DEXT(Enum target, Enum attachment,
			Enum textarget, UInt texture, Int level);
	void framebufferTexture3DEXT(Enum target, Enum attachment,
			Enum textarget, UInt texture, Int level, Int zoffset);
	void framebufferRenderbufferEXT(Enum target, Enum attachment,
			Enum renderbuffertarget, UInt renderbuffer);
	void getFramebufferAttachmentParameterivEXT(Enum target, Enum attachment,
			Enum pname, Int* params);
	void generateMipmapEXT(Enum target);

	enum FRAMEBUFFER_SRGB_EXT = 0x8DB9;
	enum FRAMEBUFFER_SRGB_CAPABLE_EXT = 0x8DBA;

	enum GEOMETRY_SHADER_EXT = 0x8DD9;
	enum GEOMETRY_VERTICES_OUT_EXT = 0x8DDA;
	enum GEOMETRY_INPUT_TYPE_EXT = 0x8DDB;
	enum GEOMETRY_OUTPUT_TYPE_EXT = 0x8DDC;
	enum MAX_GEOMETRY_TEXTURE_IMAGE_UNITS_EXT = 0x8C29;
	enum MAX_GEOMETRY_VARYING_COMPONENTS_EXT = 0x8DDD;
	enum MAX_VERTEX_VARYING_COMPONENTS_EXT = 0x8DDE;
	enum MAX_VARYING_COMPONENTS_EXT = 0x8B4B;
	enum MAX_GEOMETRY_UNIFORM_COMPONENTS_EXT = 0x8DDF;
	enum MAX_GEOMETRY_OUTPUT_VERTICES_EXT = 0x8DE0;
	enum MAX_GEOMETRY_TOTAL_OUTPUT_COMPONENTS_EXT = 0x8DE1;
	enum LINES_ADJACENCY_EXT = 0x000A;
	enum LINE_STRIP_ADJACENCY_EXT = 0x000B;
	enum TRIANGLES_ADJACENCY_EXT = 0x000C;
	enum TRIANGLE_STRIP_ADJACENCY_EXT = 0x000D;
	enum FRAMEBUFFER_INCOMPLETE_LAYER_TARGETS_EXT = 0x8DA8;
	enum FRAMEBUFFER_INCOMPLETE_LAYER_COUNT_EXT = 0x8DA9;
	enum FRAMEBUFFER_ATTACHMENT_LAYERED_EXT = 0x8DA7;
	enum FRAMEBUFFER_ATTACHMENT_TEXTURE_LAYER_EXT = 0x8CD4;
	enum PROGRAM_POINT_SIZE_EXT = 0x8642;
	void programParameteriEXT(UInt program, Enum pname, Int value);

	void programEnvParameters4fvEXT(Enum target, UInt index, Sizei count,
			const(Float)* params);
	void programLocalParameters4fvEXT(Enum target, UInt index, Sizei count,
			const(Float)* params);

	enum VERTEX_ATTRIB_ARRAY_INTEGER_EXT = 0x88FD;
	enum SAMPLER_1D_ARRAY_EXT = 0x8DC0;
	enum SAMPLER_2D_ARRAY_EXT = 0x8DC1;
	enum SAMPLER_BUFFER_EXT = 0x8DC2;
	enum SAMPLER_1D_ARRAY_SHADOW_EXT = 0x8DC3;
	enum SAMPLER_2D_ARRAY_SHADOW_EXT = 0x8DC4;
	enum SAMPLER_CUBE_SHADOW_EXT = 0x8DC5;
	enum UNSIGNED_INT_VEC2_EXT = 0x8DC6;
	enum UNSIGNED_INT_VEC3_EXT = 0x8DC7;
	enum UNSIGNED_INT_VEC4_EXT = 0x8DC8;
	enum INT_SAMPLER_1D_EXT = 0x8DC9;
	enum INT_SAMPLER_2D_EXT = 0x8DCA;
	enum INT_SAMPLER_3D_EXT = 0x8DCB;
	enum INT_SAMPLER_CUBE_EXT = 0x8DCC;
	enum INT_SAMPLER_2D_RECT_EXT = 0x8DCD;
	enum INT_SAMPLER_1D_ARRAY_EXT = 0x8DCE;
	enum INT_SAMPLER_2D_ARRAY_EXT = 0x8DCF;
	enum INT_SAMPLER_BUFFER_EXT = 0x8DD0;
	enum UNSIGNED_INT_SAMPLER_1D_EXT = 0x8DD1;
	enum UNSIGNED_INT_SAMPLER_2D_EXT = 0x8DD2;
	enum UNSIGNED_INT_SAMPLER_3D_EXT = 0x8DD3;
	enum UNSIGNED_INT_SAMPLER_CUBE_EXT = 0x8DD4;
	enum UNSIGNED_INT_SAMPLER_2D_RECT_EXT = 0x8DD5;
	enum UNSIGNED_INT_SAMPLER_1D_ARRAY_EXT = 0x8DD6;
	enum UNSIGNED_INT_SAMPLER_2D_ARRAY_EXT = 0x8DD7;
	enum UNSIGNED_INT_SAMPLER_BUFFER_EXT = 0x8DD8;
	enum MIN_PROGRAM_TEXEL_OFFSET_EXT = 0x8904;
	enum MAX_PROGRAM_TEXEL_OFFSET_EXT = 0x8905;
	void getUniformuivEXT(UInt program, Int location, UInt* params);
	void bindFragDataLocationEXT(UInt program, UInt color, const(Char)* name);
	Int getFragDataLocationEXT(UInt program, const(Char)* name);
	void uniform1UiEXT(Int location, UInt v0);
	void uniform2UiEXT(Int location, UInt v0, UInt v1);
	void uniform3UiEXT(Int location, UInt v0, UInt v1, UInt v2);
	void uniform4UiEXT(Int location, UInt v0, UInt v1, UInt v2, UInt v3);
	void uniform1UivEXT(Int location, Sizei count, const(UInt)* value);
	void uniform2UivEXT(Int location, Sizei count, const(UInt)* value);
	void uniform3UivEXT(Int location, Sizei count, const(UInt)* value);
	void uniform4UivEXT(Int location, Sizei count, const(UInt)* value);

	enum HISTOGRAM_EXT = 0x8024;
	enum PROXY_HISTOGRAM_EXT = 0x8025;
	enum HISTOGRAM_WIDTH_EXT = 0x8026;
	enum HISTOGRAM_FORMAT_EXT = 0x8027;
	enum HISTOGRAM_RED_SIZE_EXT = 0x8028;
	enum HISTOGRAM_GREEN_SIZE_EXT = 0x8029;
	enum HISTOGRAM_BLUE_SIZE_EXT = 0x802A;
	enum HISTOGRAM_ALPHA_SIZE_EXT = 0x802B;
	enum HISTOGRAM_LUMINANCE_SIZE_EXT = 0x802C;
	enum HISTOGRAM_SINK_EXT = 0x802D;
	enum MINMAX_EXT = 0x802E;
	enum MINMAX_FORMAT_EXT = 0x802F;
	enum MINMAX_SINK_EXT = 0x8030;
	enum TABLE_TOO_LARGE_EXT = 0x8031;
	void getHistogramEXT(Enum target, Boolean reset, Enum format, Enum type, void* values);
	void getHistogramParameterfvEXT(Enum target, Enum pname, Float* params);
	void getHistogramParameterivEXT(Enum target, Enum pname, Int* params);
	void getMinmaxEXT(Enum target, Boolean reset, Enum format, Enum type, void* values);
	void getMinmaxParameterfvEXT(Enum target, Enum pname, Float* params);
	void getMinmaxParameterivEXT(Enum target, Enum pname, Int* params);
	void histogramEXT(Enum target, Sizei width, Enum internalformat, Boolean sink);
	void minmaxEXT(Enum target, Enum internalformat, Boolean sink);
	void resetHistogramEXT(Enum target);
	void resetMinmaxEXT(Enum target);

	enum IUI_V2F_EXT = 0x81AD;
	enum IUI_V3F_EXT = 0x81AE;
	enum IUI_N3F_V2F_EXT = 0x81AF;
	enum IUI_N3F_V3F_EXT = 0x81B0;
	enum T2F_IUI_V2F_EXT = 0x81B1;
	enum T2F_IUI_V3F_EXT = 0x81B2;
	enum T2F_IUI_N3F_V2F_EXT = 0x81B3;
	enum T2F_IUI_N3F_V3F_EXT = 0x81B4;

	enum INDEX_TEST_EXT = 0x81B5;
	enum INDEX_TEST_FUNC_EXT = 0x81B6;
	enum INDEX_TEST_REF_EXT = 0x81B7;
	void indexFuncEXT(Enum func, Clampf ref_);

	enum INDEX_MATERIAL_EXT = 0x81B8;
	enum INDEX_MATERIAL_PARAMETER_EXT = 0x81B9;
	enum INDEX_MATERIAL_FACE_EXT = 0x81BA;
	void indexMaterialEXT(Enum face, Enum mode);

	enum FRAGMENT_MATERIAL_EXT = 0x8349;
	enum FRAGMENT_NORMAL_EXT = 0x834A;
	enum FRAGMENT_COLOR_EXT = 0x834C;
	enum ATTENUATION_EXT = 0x834D;
	enum SHADOW_ATTENUATION_EXT = 0x834E;
	enum TEXTURE_APPLICATION_MODE_EXT = 0x834F;
	enum TEXTURE_LIGHT_EXT = 0x8350;
	enum TEXTURE_MATERIAL_FACE_EXT = 0x8351;
	enum TEXTURE_MATERIAL_PARAMETER_EXT = 0x8352;
	void applyTextureEXT(Enum mode);
	void textureLightEXT(Enum pname);
	void textureMaterialEXT(Enum face, Enum mode);

	enum TEXTURE_TILING_EXT = 0x9580;
	enum DEDICATED_MEMORY_OBJECT_EXT = 0x9581;
	enum PROTECTED_MEMORY_OBJECT_EXT = 0x959B;
	enum NUM_TILING_TYPES_EXT = 0x9582;
	enum TILING_TYPES_EXT = 0x9583;
	enum OPTIMAL_TILING_EXT = 0x9584;
	enum LINEAR_TILING_EXT = 0x9585;
	enum NUM_DEVICE_UUIDS_EXT = 0x9596;
	enum DEVICE_UUID_EXT = 0x9597;
	enum DRIVER_UUID_EXT = 0x9598;
	enum UUID_SIZE_EXT = 16;
	void getUnsignedBytevEXT(Enum pname, UByte* data);
	void getUnsignedBytei_vEXT(Enum target, UInt index, UByte* data);
	void deleteMemoryObjectsEXT(Sizei n, const(UInt)* memoryObjects);
	Boolean isMemoryObjectEXT(UInt memoryObject);
	void createMemoryObjectsEXT(Sizei n, UInt* memoryObjects);
	void memoryObjectParameterivEXT(UInt memoryObject, Enum pname, const(Int)* params);
	void getMemoryObjectParameterivEXT(UInt memoryObject, Enum pname, Int* params);
	void texStorageMem2DEXT(Enum target, Sizei levels, Enum internalFormat,
			Sizei width, Sizei height, UInt memory, GLuint64 offset);
	void texStorageMem2DMultisampleEXT(Enum target, Sizei samples, Enum internalFormat, Sizei width,
			Sizei height, Boolean fixedSampleLocations, UInt memory, GLuint64 offset);
	void texStorageMem3DEXT(Enum target, Sizei levels, Enum internalFormat,
			Sizei width, Sizei height, Sizei depth, UInt memory, GLuint64 offset);
	void texStorageMem3DMultisampleEXT(Enum target, Sizei samples, Enum internalFormat, Sizei width, Sizei height,
			Sizei depth, Boolean fixedSampleLocations, UInt memory, GLuint64 offset);
	void bufferStorageMemEXT(Enum target, Sizeiptr size, UInt memory, GLuint64 offset);
	void textureStorageMem2DEXT(UInt texture, Sizei levels, Enum internalFormat,
			Sizei width, Sizei height, UInt memory, GLuint64 offset);
	void textureStorageMem2DMultisampleEXT(UInt texture, Sizei samples, Enum internalFormat, Sizei width,
			Sizei height, Boolean fixedSampleLocations, UInt memory, GLuint64 offset);
	void textureStorageMem3DEXT(UInt texture, Sizei levels, Enum internalFormat,
			Sizei width, Sizei height, Sizei depth, UInt memory, GLuint64 offset);
	void textureStorageMem3DMultisampleEXT(UInt texture, Sizei samples,
			Enum internalFormat, Sizei width, Sizei height,
			Sizei depth, Boolean fixedSampleLocations, UInt memory, GLuint64 offset);
	void namedBufferStorageMemEXT(UInt buffer, Sizeiptr size, UInt memory, GLuint64 offset);
	void texStorageMem1DEXT(Enum target, Sizei levels, Enum internalFormat,
			Sizei width, UInt memory, GLuint64 offset);
	void textureStorageMem1DEXT(UInt texture, Sizei levels,
			Enum internalFormat, Sizei width, UInt memory, GLuint64 offset);

	enum HANDLE_TYPE_OPAQUE_FD_EXT = 0x9586;
	void importMemoryFdEXT(UInt memory, GLuint64 size, Enum handleType, Int fd);

	enum HANDLE_TYPE_OPAQUE_WIN32_EXT = 0x9587;
	enum HANDLE_TYPE_OPAQUE_WIN32_KMT_EXT = 0x9588;
	enum DEVICE_LUID_EXT = 0x9599;
	enum DEVICE_NODE_MASK_EXT = 0x959A;
	enum LUID_SIZE_EXT = 8;
	enum HANDLE_TYPE_D3D12_TILEPOOL_EXT = 0x9589;
	enum HANDLE_TYPE_D3D12_RESOURCE_EXT = 0x958A;
	enum HANDLE_TYPE_D3D11_IMAGE_EXT = 0x958B;
	enum HANDLE_TYPE_D3D11_IMAGE_KMT_EXT = 0x958C;
	void importMemoryWin32HandleEXT(UInt memory, GLuint64 size, Enum handleType, void* handle);
	void importMemoryWin32NameEXT(UInt memory, GLuint64 size,
			Enum handleType, const(void)* name);

	void multiDrawArraysEXT(Enum mode, const(Int)* first,
			const(Sizei)* count, Sizei primcount);
	void multiDrawElementsEXT(Enum mode, const(Sizei)* count, Enum type,
			const(void*)* indices, Sizei primcount);

	enum MULTISAMPLE_EXT = 0x809D;
	enum SAMPLE_ALPHA_TO_MASK_EXT = 0x809E;
	enum SAMPLE_ALPHA_TO_ONE_EXT = 0x809F;
	enum SAMPLE_MASK_EXT = 0x80A0;
	enum GL_1PASS_EXT = 0x80A1;
	enum GL_2PASS_0_EXT = 0x80A2;
	enum GL_2PASS_1_EXT = 0x80A3;
	enum GL_4PASS_0_EXT = 0x80A4;
	enum GL_4PASS_1_EXT = 0x80A5;
	enum GL_4PASS_2_EXT = 0x80A6;
	enum GL_4PASS_3_EXT = 0x80A7;
	enum SAMPLE_BUFFERS_EXT = 0x80A8;
	enum SAMPLES_EXT = 0x80A9;
	enum SAMPLE_MASK_VALUE_EXT = 0x80AA;
	enum SAMPLE_MASK_INVERT_EXT = 0x80AB;
	enum SAMPLE_PATTERN_EXT = 0x80AC;
	enum MULTISAMPLE_BIT_EXT = 0x20000000;
	void sampleMaskEXT(Clampf value, Boolean invert);
	void samplePatternEXT(Enum pattern);

	enum DEPTH_STENCIL_EXT = 0x84F9;
	enum UNSIGNED_INT_24_8_EXT = 0x84FA;
	enum DEPTH24_STENCIL8_EXT = 0x88F0;
	enum TEXTURE_STENCIL_SIZE_EXT = 0x88F1;

	enum R11F_G11F_B10F_EXT = 0x8C3A;
	enum UNSIGNED_INT_10F_11F_11F_REV_EXT = 0x8C3B;
	enum RGBA_SIGNED_COMPONENTS_EXT = 0x8C3C;

	enum UNSIGNED_BYTE_3_3_2_EXT = 0x8032;
	enum UNSIGNED_SHORT_4_4_4_4_EXT = 0x8033;
	enum UNSIGNED_SHORT_5_5_5_1_EXT = 0x8034;
	enum UNSIGNED_INT_8_8_8_8_EXT = 0x8035;
	enum UNSIGNED_INT_10_10_10_2_EXT = 0x8036;

	enum COLOR_INDEX1_EXT = 0x80E2;
	enum COLOR_INDEX2_EXT = 0x80E3;
	enum COLOR_INDEX4_EXT = 0x80E4;
	enum COLOR_INDEX8_EXT = 0x80E5;
	enum COLOR_INDEX12_EXT = 0x80E6;
	enum COLOR_INDEX16_EXT = 0x80E7;
	enum TEXTURE_INDEX_SIZE_EXT = 0x80ED;
	void colorTableEXT(Enum target, Enum internalFormat, Sizei width,
			Enum format, Enum type, const(void)* table);
	void getColorTableEXT(Enum target, Enum format, Enum type, void* data);
	void getColorTableParameterivEXT(Enum target, Enum pname, Int* params);
	void getColorTableParameterfvEXT(Enum target, Enum pname, Float* params);

	enum PIXEL_PACK_BUFFER_EXT = 0x88EB;
	enum PIXEL_UNPACK_BUFFER_EXT = 0x88EC;
	enum PIXEL_PACK_BUFFER_BINDING_EXT = 0x88ED;
	enum PIXEL_UNPACK_BUFFER_BINDING_EXT = 0x88EF;

	enum PIXEL_TRANSFORM_2D_EXT = 0x8330;
	enum PIXEL_MAG_FILTER_EXT = 0x8331;
	enum PIXEL_MIN_FILTER_EXT = 0x8332;
	enum PIXEL_CUBIC_WEIGHT_EXT = 0x8333;
	enum CUBIC_EXT = 0x8334;
	enum AVERAGE_EXT = 0x8335;
	enum PIXEL_TRANSFORM_2D_STACK_DEPTH_EXT = 0x8336;
	enum MAX_PIXEL_TRANSFORM_2D_STACK_DEPTH_EXT = 0x8337;
	enum PIXEL_TRANSFORM_2D_MATRIX_EXT = 0x8338;
	void pixelTransformParameteriEXT(Enum target, Enum pname, Int param);
	void pixelTransformParameterfEXT(Enum target, Enum pname, Float param);
	void pixelTransformParameterivEXT(Enum target, Enum pname, const(Int)* params);
	void pixelTransformParameterfvEXT(Enum target, Enum pname, const(Float)* params);
	void getPixelTransformParameterivEXT(Enum target, Enum pname, Int* params);
	void getPixelTransformParameterfvEXT(Enum target, Enum pname, Float* params);

	enum POINT_SIZE_MIN_EXT = 0x8126;
	enum POINT_SIZE_MAX_EXT = 0x8127;
	enum POINT_FADE_THRESHOLD_SIZE_EXT = 0x8128;
	enum DISTANCE_ATTENUATION_EXT = 0x8129;
	void pointParameterfEXT(Enum pname, Float param);
	void pointParameterfvEXT(Enum pname, const(Float)* params);

	enum POLYGON_OFFSET_EXT = 0x8037;
	enum POLYGON_OFFSET_FACTOR_EXT = 0x8038;
	enum POLYGON_OFFSET_BIAS_EXT = 0x8039;
	void polygonOffsetEXT(Float factor, Float bias);

	enum POLYGON_OFFSET_CLAMP_EXT = 0x8E1B;
	void polygonOffsetClampEXT(Float factor, Float units, Float clamp);

	enum QUADS_FOLLOW_PROVOKING_VERTEX_CONVENTION_EXT = 0x8E4C;
	enum FIRST_VERTEX_CONVENTION_EXT = 0x8E4D;
	enum LAST_VERTEX_CONVENTION_EXT = 0x8E4E;
	enum PROVOKING_VERTEX_EXT = 0x8E4F;
	void provokingVertexEXT(Enum mode);

	enum RASTER_MULTISAMPLE_EXT = 0x9327;
	enum RASTER_SAMPLES_EXT = 0x9328;
	enum MAX_RASTER_SAMPLES_EXT = 0x9329;
	enum RASTER_FIXED_SAMPLE_LOCATIONS_EXT = 0x932A;
	enum MULTISAMPLE_RASTERIZATION_ALLOWED_EXT = 0x932B;
	enum EFFECTIVE_RASTER_SAMPLES_EXT = 0x932C;
	void rasterSamplesEXT(UInt samples, Boolean fixedsamplelocations);

	enum RESCALE_NORMAL_EXT = 0x803A;

	enum COLOR_SUM_EXT = 0x8458;
	enum CURRENT_SECONDARY_COLOR_EXT = 0x8459;
	enum SECONDARY_COLOR_ARRAY_SIZE_EXT = 0x845A;
	enum SECONDARY_COLOR_ARRAY_TYPE_EXT = 0x845B;
	enum SECONDARY_COLOR_ARRAY_STRIDE_EXT = 0x845C;
	enum SECONDARY_COLOR_ARRAY_POINTER_EXT = 0x845D;
	enum SECONDARY_COLOR_ARRAY_EXT = 0x845E;
	void secondaryColor3bEXT(Byte red, Byte green, Byte blue);
	void secondaryColor3bvEXT(const(Byte)* v);
	void secondaryColor3dEXT(Double red, Double green, Double blue);
	void secondaryColor3dvEXT(const(Double)* v);
	void secondaryColor3fEXT(Float red, Float green, Float blue);
	void secondaryColor3fvEXT(const(Float)* v);
	void secondaryColor3iEXT(Int red, Int green, Int blue);
	void secondaryColor3ivEXT(const(Int)* v);
	void secondaryColor3sEXT(Short red, Short green, Short blue);
	void secondaryColor3svEXT(const(Short)* v);
	void secondaryColor3UbEXT(UByte red, UByte green, UByte blue);
	void secondaryColor3UbvEXT(const(UByte)* v);
	void secondaryColor3UiEXT(UInt red, UInt green, UInt blue);
	void secondaryColor3UivEXT(const(UInt)* v);
	void secondaryColor3UsEXT(UShort red, UShort green, UShort blue);
	void secondaryColor3UsvEXT(const(UShort)* v);
	void secondaryColorPointerEXT(Int size, Enum type, Sizei stride, const(void)* pointer);

	enum LAYOUT_GENERAL_EXT = 0x958D;
	enum LAYOUT_COLOR_ATTACHMENT_EXT = 0x958E;
	enum LAYOUT_DEPTH_STENCIL_ATTACHMENT_EXT = 0x958F;
	enum LAYOUT_DEPTH_STENCIL_READ_ONLY_EXT = 0x9590;
	enum LAYOUT_SHADER_READ_ONLY_EXT = 0x9591;
	enum LAYOUT_TRANSFER_SRC_EXT = 0x9592;
	enum LAYOUT_TRANSFER_DST_EXT = 0x9593;
	enum LAYOUT_DEPTH_READ_ONLY_STENCIL_ATTACHMENT_EXT = 0x9530;
	enum LAYOUT_DEPTH_ATTACHMENT_STENCIL_READ_ONLY_EXT = 0x9531;
	void genSemaphoresEXT(Sizei n, UInt* semaphores);
	void deleteSemaphoresEXT(Sizei n, const(UInt)* semaphores);
	Boolean isSemaphoreEXT(UInt semaphore);
	void semaphoreParameterui64vEXT(UInt semaphore, Enum pname, const(GLuint64)* params);
	void getSemaphoreParameterui64vEXT(UInt semaphore, Enum pname, GLuint64* params);
	void waitSemaphoreEXT(UInt semaphore, UInt numBufferBarriers, const(UInt)* buffers,
			UInt numTextureBarriers, const(UInt)* textures, const(Enum)* srcLayouts);
	void signalSemaphoreEXT(UInt semaphore, UInt numBufferBarriers, const(UInt)* buffers,
			UInt numTextureBarriers, const(UInt)* textures, const(Enum)* dstLayouts);

	void importSemaphoreFdEXT(UInt semaphore, Enum handleType, Int fd);

	enum HANDLE_TYPE_D3D12_FENCE_EXT = 0x9594;
	enum D3D12_FENCE_VALUE_EXT = 0x9595;
	void importSemaphoreWin32HandleEXT(UInt semaphore, Enum handleType, void* handle);
	void importSemaphoreWin32NameEXT(UInt semaphore, Enum handleType, const(void)* name);

	enum ACTIVE_PROGRAM_EXT = 0x8B8D;
	void useShaderProgramEXT(Enum type, UInt program);
	void activeProgramEXT(UInt program);
	UInt createShaderProgramEXT(Enum type, const(Char)* string);

	enum LIGHT_MODEL_COLOR_CONTROL_EXT = 0x81F8;
	enum SINGLE_COLOR_EXT = 0x81F9;
	enum SEPARATE_SPECULAR_COLOR_EXT = 0x81FA;

	enum FRAGMENT_SHADER_DISCARDS_SAMPLES_EXT = 0x8A52;

	void framebufferFetchBarrierEXT();

	enum MAX_IMAGE_UNITS_EXT = 0x8F38;
	enum MAX_COMBINED_IMAGE_UNITS_AND_FRAGMENT_OUTPUTS_EXT = 0x8F39;
	enum IMAGE_BINDING_NAME_EXT = 0x8F3A;
	enum IMAGE_BINDING_LEVEL_EXT = 0x8F3B;
	enum IMAGE_BINDING_LAYERED_EXT = 0x8F3C;
	enum IMAGE_BINDING_LAYER_EXT = 0x8F3D;
	enum IMAGE_BINDING_ACCESS_EXT = 0x8F3E;
	enum IMAGE_1D_EXT = 0x904C;
	enum IMAGE_2D_EXT = 0x904D;
	enum IMAGE_3D_EXT = 0x904E;
	enum IMAGE_2D_RECT_EXT = 0x904F;
	enum IMAGE_CUBE_EXT = 0x9050;
	enum IMAGE_BUFFER_EXT = 0x9051;
	enum IMAGE_1D_ARRAY_EXT = 0x9052;
	enum IMAGE_2D_ARRAY_EXT = 0x9053;
	enum IMAGE_CUBE_MAP_ARRAY_EXT = 0x9054;
	enum IMAGE_2D_MULTISAMPLE_EXT = 0x9055;
	enum IMAGE_2D_MULTISAMPLE_ARRAY_EXT = 0x9056;
	enum INT_IMAGE_1D_EXT = 0x9057;
	enum INT_IMAGE_2D_EXT = 0x9058;
	enum INT_IMAGE_3D_EXT = 0x9059;
	enum INT_IMAGE_2D_RECT_EXT = 0x905A;
	enum INT_IMAGE_CUBE_EXT = 0x905B;
	enum INT_IMAGE_BUFFER_EXT = 0x905C;
	enum INT_IMAGE_1D_ARRAY_EXT = 0x905D;
	enum INT_IMAGE_2D_ARRAY_EXT = 0x905E;
	enum INT_IMAGE_CUBE_MAP_ARRAY_EXT = 0x905F;
	enum INT_IMAGE_2D_MULTISAMPLE_EXT = 0x9060;
	enum INT_IMAGE_2D_MULTISAMPLE_ARRAY_EXT = 0x9061;
	enum UNSIGNED_INT_IMAGE_1D_EXT = 0x9062;
	enum UNSIGNED_INT_IMAGE_2D_EXT = 0x9063;
	enum UNSIGNED_INT_IMAGE_3D_EXT = 0x9064;
	enum UNSIGNED_INT_IMAGE_2D_RECT_EXT = 0x9065;
	enum UNSIGNED_INT_IMAGE_CUBE_EXT = 0x9066;
	enum UNSIGNED_INT_IMAGE_BUFFER_EXT = 0x9067;
	enum UNSIGNED_INT_IMAGE_1D_ARRAY_EXT = 0x9068;
	enum UNSIGNED_INT_IMAGE_2D_ARRAY_EXT = 0x9069;
	enum UNSIGNED_INT_IMAGE_CUBE_MAP_ARRAY_EXT = 0x906A;
	enum UNSIGNED_INT_IMAGE_2D_MULTISAMPLE_EXT = 0x906B;
	enum UNSIGNED_INT_IMAGE_2D_MULTISAMPLE_ARRAY_EXT = 0x906C;
	enum MAX_IMAGE_SAMPLES_EXT = 0x906D;
	enum IMAGE_BINDING_FORMAT_EXT = 0x906E;
	enum VERTEX_ATTRIB_ARRAY_BARRIER_BIT_EXT = 0x00000001;
	enum ELEMENT_ARRAY_BARRIER_BIT_EXT = 0x00000002;
	enum UNIFORM_BARRIER_BIT_EXT = 0x00000004;
	enum TEXTURE_FETCH_BARRIER_BIT_EXT = 0x00000008;
	enum SHADER_IMAGE_ACCESS_BARRIER_BIT_EXT = 0x00000020;
	enum COMMAND_BARRIER_BIT_EXT = 0x00000040;
	enum PIXEL_BUFFER_BARRIER_BIT_EXT = 0x00000080;
	enum TEXTURE_UPDATE_BARRIER_BIT_EXT = 0x00000100;
	enum BUFFER_UPDATE_BARRIER_BIT_EXT = 0x00000200;
	enum FRAMEBUFFER_BARRIER_BIT_EXT = 0x00000400;
	enum TRANSFORM_FEEDBACK_BARRIER_BIT_EXT = 0x00000800;
	enum ATOMIC_COUNTER_BARRIER_BIT_EXT = 0x00001000;
	enum ALL_BARRIER_BITS_EXT = 0xFFFFFFFF;
	void bindImageTextureEXT(UInt index, UInt texture, Int level,
			Boolean layered, Int layer, Enum access, Int format);
	void memoryBarrierEXT(Bitfield barriers);

	enum SHARED_TEXTURE_PALETTE_EXT = 0x81FB;

	enum STENCIL_TAG_BITS_EXT = 0x88F2;
	enum STENCIL_CLEAR_TAG_VALUE_EXT = 0x88F3;
	void stencilClearTagEXT(Sizei stencilTagBits, UInt stencilClearTag);

	enum STENCIL_TEST_TWO_SIDE_EXT = 0x8910;
	enum ACTIVE_STENCIL_FACE_EXT = 0x8911;
	void activeStencilFaceEXT(Enum face);

	enum INCR_WRAP_EXT = 0x8507;
	enum DECR_WRAP_EXT = 0x8508;

	void texSubImage1DEXT(Enum target, Int level, Int xoffset, Sizei width,
			Enum format, Enum type, const(void)* pixels);
	void texSubImage2DEXT(Enum target, Int level, Int xoffset, Int yoffset,
			Sizei width, Sizei height, Enum format, Enum type, const(void)* pixels);

	enum ALPHA4_EXT = 0x803B;
	enum ALPHA8_EXT = 0x803C;
	enum ALPHA12_EXT = 0x803D;
	enum ALPHA16_EXT = 0x803E;
	enum LUMINANCE4_EXT = 0x803F;
	enum LUMINANCE8_EXT = 0x8040;
	enum LUMINANCE12_EXT = 0x8041;
	enum LUMINANCE16_EXT = 0x8042;
	enum LUMINANCE4_ALPHA4_EXT = 0x8043;
	enum LUMINANCE6_ALPHA2_EXT = 0x8044;
	enum LUMINANCE8_ALPHA8_EXT = 0x8045;
	enum LUMINANCE12_ALPHA4_EXT = 0x8046;
	enum LUMINANCE12_ALPHA12_EXT = 0x8047;
	enum LUMINANCE16_ALPHA16_EXT = 0x8048;
	enum INTENSITY_EXT = 0x8049;
	enum INTENSITY4_EXT = 0x804A;
	enum INTENSITY8_EXT = 0x804B;
	enum INTENSITY12_EXT = 0x804C;
	enum INTENSITY16_EXT = 0x804D;
	enum RGB2_EXT = 0x804E;
	enum RGB4_EXT = 0x804F;
	enum RGB5_EXT = 0x8050;
	enum RGB8_EXT = 0x8051;
	enum RGB10_EXT = 0x8052;
	enum RGB12_EXT = 0x8053;
	enum RGB16_EXT = 0x8054;
	enum RGBA2_EXT = 0x8055;
	enum RGBA4_EXT = 0x8056;
	enum RGB5_A1_EXT = 0x8057;
	enum RGBA8_EXT = 0x8058;
	enum RGB10_A2_EXT = 0x8059;
	enum RGBA12_EXT = 0x805A;
	enum RGBA16_EXT = 0x805B;
	enum TEXTURE_RED_SIZE_EXT = 0x805C;
	enum TEXTURE_GREEN_SIZE_EXT = 0x805D;
	enum TEXTURE_BLUE_SIZE_EXT = 0x805E;
	enum TEXTURE_ALPHA_SIZE_EXT = 0x805F;
	enum TEXTURE_LUMINANCE_SIZE_EXT = 0x8060;
	enum TEXTURE_INTENSITY_SIZE_EXT = 0x8061;
	enum REPLACE_EXT = 0x8062;
	enum PROXY_TEXTURE_1D_EXT = 0x8063;
	enum PROXY_TEXTURE_2D_EXT = 0x8064;
	enum TEXTURE_TOO_LARGE_EXT = 0x8065;

	enum PACK_SKIP_IMAGES_EXT = 0x806B;
	enum PACK_IMAGE_HEIGHT_EXT = 0x806C;
	enum UNPACK_SKIP_IMAGES_EXT = 0x806D;
	enum UNPACK_IMAGE_HEIGHT_EXT = 0x806E;
	enum TEXTURE_3D_EXT = 0x806F;
	enum PROXY_TEXTURE_3D_EXT = 0x8070;
	enum TEXTURE_DEPTH_EXT = 0x8071;
	enum TEXTURE_WRAP_R_EXT = 0x8072;
	enum MAX_3D_TEXTURE_SIZE_EXT = 0x8073;
	void texImage3DEXT(Enum target, Int level, Enum internalformat, Sizei width,
			Sizei height, Sizei depth, Int border, Enum format,
			Enum type, const(void)* pixels);
	void texSubImage3DEXT(Enum target, Int level, Int xoffset, Int yoffset, Int zoffset,
			Sizei width, Sizei height, Sizei depth, Enum format,
			Enum type, const(void)* pixels);

	enum TEXTURE_1D_ARRAY_EXT = 0x8C18;
	enum PROXY_TEXTURE_1D_ARRAY_EXT = 0x8C19;
	enum TEXTURE_2D_ARRAY_EXT = 0x8C1A;
	enum PROXY_TEXTURE_2D_ARRAY_EXT = 0x8C1B;
	enum TEXTURE_BINDING_1D_ARRAY_EXT = 0x8C1C;
	enum TEXTURE_BINDING_2D_ARRAY_EXT = 0x8C1D;
	enum MAX_ARRAY_TEXTURE_LAYERS_EXT = 0x88FF;
	enum COMPARE_REF_DEPTH_TO_TEXTURE_EXT = 0x884E;
	void framebufferTextureLayerEXT(Enum target, Enum attachment,
			UInt texture, Int level, Int layer);

	enum TEXTURE_BUFFER_EXT = 0x8C2A;
	enum MAX_TEXTURE_BUFFER_SIZE_EXT = 0x8C2B;
	enum TEXTURE_BINDING_BUFFER_EXT = 0x8C2C;
	enum TEXTURE_BUFFER_DATA_STORE_BINDING_EXT = 0x8C2D;
	enum TEXTURE_BUFFER_FORMAT_EXT = 0x8C2E;
	void texBufferEXT(Enum target, Enum internalformat, UInt buffer);

	enum COMPRESSED_LUMINANCE_LATC1_EXT = 0x8C70;
	enum COMPRESSED_SIGNED_LUMINANCE_LATC1_EXT = 0x8C71;
	enum COMPRESSED_LUMINANCE_ALPHA_LATC2_EXT = 0x8C72;
	enum COMPRESSED_SIGNED_LUMINANCE_ALPHA_LATC2_EXT = 0x8C73;

	enum COMPRESSED_RED_RGTC1_EXT = 0x8DBB;
	enum COMPRESSED_SIGNED_RED_RGTC1_EXT = 0x8DBC;
	enum COMPRESSED_RED_GREEN_RGTC2_EXT = 0x8DBD;
	enum COMPRESSED_SIGNED_RED_GREEN_RGTC2_EXT = 0x8DBE;

	enum COMPRESSED_RGB_S3TC_DXT1_EXT = 0x83F0;
	enum COMPRESSED_RGBA_S3TC_DXT1_EXT = 0x83F1;
	enum COMPRESSED_RGBA_S3TC_DXT3_EXT = 0x83F2;
	enum COMPRESSED_RGBA_S3TC_DXT5_EXT = 0x83F3;

	enum NORMAL_MAP_EXT = 0x8511;
	enum REFLECTION_MAP_EXT = 0x8512;
	enum TEXTURE_CUBE_MAP_EXT = 0x8513;
	enum TEXTURE_BINDING_CUBE_MAP_EXT = 0x8514;
	enum TEXTURE_CUBE_MAP_POSITIVE_X_EXT = 0x8515;
	enum TEXTURE_CUBE_MAP_NEGATIVE_X_EXT = 0x8516;
	enum TEXTURE_CUBE_MAP_POSITIVE_Y_EXT = 0x8517;
	enum TEXTURE_CUBE_MAP_NEGATIVE_Y_EXT = 0x8518;
	enum TEXTURE_CUBE_MAP_POSITIVE_Z_EXT = 0x8519;
	enum TEXTURE_CUBE_MAP_NEGATIVE_Z_EXT = 0x851A;
	enum PROXY_TEXTURE_CUBE_MAP_EXT = 0x851B;
	enum MAX_CUBE_MAP_TEXTURE_SIZE_EXT = 0x851C;

	enum COMBINE_EXT = 0x8570;
	enum COMBINE_RGB_EXT = 0x8571;
	enum COMBINE_ALPHA_EXT = 0x8572;
	enum RGB_SCALE_EXT = 0x8573;
	enum ADD_SIGNED_EXT = 0x8574;
	enum INTERPOLATE_EXT = 0x8575;
	enum CONSTANT_EXT = 0x8576;
	enum PRIMARY_COLOR_EXT = 0x8577;
	enum PREVIOUS_EXT = 0x8578;
	enum SOURCE0_RGB_EXT = 0x8580;
	enum SOURCE1_RGB_EXT = 0x8581;
	enum SOURCE2_RGB_EXT = 0x8582;
	enum SOURCE0_ALPHA_EXT = 0x8588;
	enum SOURCE1_ALPHA_EXT = 0x8589;
	enum SOURCE2_ALPHA_EXT = 0x858A;
	enum OPERAND0_RGB_EXT = 0x8590;
	enum OPERAND1_RGB_EXT = 0x8591;
	enum OPERAND2_RGB_EXT = 0x8592;
	enum OPERAND0_ALPHA_EXT = 0x8598;
	enum OPERAND1_ALPHA_EXT = 0x8599;
	enum OPERAND2_ALPHA_EXT = 0x859A;

	enum DOT3_RGB_EXT = 0x8740;
	enum DOT3_RGBA_EXT = 0x8741;

	enum TEXTURE_MAX_ANISOTROPY_EXT = 0x84FE;
	enum MAX_TEXTURE_MAX_ANISOTROPY_EXT = 0x84FF;

	enum TEXTURE_REDUCTION_MODE_EXT = 0x9366;
	enum WEIGHTED_AVERAGE_EXT = 0x9367;

	enum RGBA32UI_EXT = 0x8D70;
	enum RGB32UI_EXT = 0x8D71;
	enum ALPHA32UI_EXT = 0x8D72;
	enum INTENSITY32UI_EXT = 0x8D73;
	enum LUMINANCE32UI_EXT = 0x8D74;
	enum LUMINANCE_ALPHA32UI_EXT = 0x8D75;
	enum RGBA16UI_EXT = 0x8D76;
	enum RGB16UI_EXT = 0x8D77;
	enum ALPHA16UI_EXT = 0x8D78;
	enum INTENSITY16UI_EXT = 0x8D79;
	enum LUMINANCE16UI_EXT = 0x8D7A;
	enum LUMINANCE_ALPHA16UI_EXT = 0x8D7B;
	enum RGBA8UI_EXT = 0x8D7C;
	enum RGB8UI_EXT = 0x8D7D;
	enum ALPHA8UI_EXT = 0x8D7E;
	enum INTENSITY8UI_EXT = 0x8D7F;
	enum LUMINANCE8UI_EXT = 0x8D80;
	enum LUMINANCE_ALPHA8UI_EXT = 0x8D81;
	enum RGBA32I_EXT = 0x8D82;
	enum RGB32I_EXT = 0x8D83;
	enum ALPHA32I_EXT = 0x8D84;
	enum INTENSITY32I_EXT = 0x8D85;
	enum LUMINANCE32I_EXT = 0x8D86;
	enum LUMINANCE_ALPHA32I_EXT = 0x8D87;
	enum RGBA16I_EXT = 0x8D88;
	enum RGB16I_EXT = 0x8D89;
	enum ALPHA16I_EXT = 0x8D8A;
	enum INTENSITY16I_EXT = 0x8D8B;
	enum LUMINANCE16I_EXT = 0x8D8C;
	enum LUMINANCE_ALPHA16I_EXT = 0x8D8D;
	enum RGBA8I_EXT = 0x8D8E;
	enum RGB8I_EXT = 0x8D8F;
	enum ALPHA8I_EXT = 0x8D90;
	enum INTENSITY8I_EXT = 0x8D91;
	enum LUMINANCE8I_EXT = 0x8D92;
	enum LUMINANCE_ALPHA8I_EXT = 0x8D93;
	enum RED_INTEGER_EXT = 0x8D94;
	enum GREEN_INTEGER_EXT = 0x8D95;
	enum BLUE_INTEGER_EXT = 0x8D96;
	enum ALPHA_INTEGER_EXT = 0x8D97;
	enum RGB_INTEGER_EXT = 0x8D98;
	enum RGBA_INTEGER_EXT = 0x8D99;
	enum BGR_INTEGER_EXT = 0x8D9A;
	enum BGRA_INTEGER_EXT = 0x8D9B;
	enum LUMINANCE_INTEGER_EXT = 0x8D9C;
	enum LUMINANCE_ALPHA_INTEGER_EXT = 0x8D9D;
	enum RGBA_INTEGER_MODE_EXT = 0x8D9E;
	void texParameterIivEXT(Enum target, Enum pname, const(Int)* params);
	void texParameterIuivEXT(Enum target, Enum pname, const(UInt)* params);
	void getTexParameterIivEXT(Enum target, Enum pname, Int* params);
	void getTexParameterIuivEXT(Enum target, Enum pname, UInt* params);
	void clearColorIiEXT(Int red, Int green, Int blue, Int alpha);
	void clearColorIuiEXT(UInt red, UInt green, UInt blue, UInt alpha);

	enum MAX_TEXTURE_LOD_BIAS_EXT = 0x84FD;
	enum TEXTURE_FILTER_CONTROL_EXT = 0x8500;
	enum TEXTURE_LOD_BIAS_EXT = 0x8501;

	enum MIRROR_CLAMP_EXT = 0x8742;
	enum MIRROR_CLAMP_TO_EDGE_EXT = 0x8743;
	enum MIRROR_CLAMP_TO_BORDER_EXT = 0x8912;

	enum TEXTURE_PRIORITY_EXT = 0x8066;
	enum TEXTURE_RESIDENT_EXT = 0x8067;
	enum TEXTURE_1D_BINDING_EXT = 0x8068;
	enum TEXTURE_2D_BINDING_EXT = 0x8069;
	enum TEXTURE_3D_BINDING_EXT = 0x806A;
	Boolean areTexturesResidentEXT(Sizei n, const(UInt)* textures, Boolean* residences);
	void bindTextureEXT(Enum target, UInt texture);
	void deleteTexturesEXT(Sizei n, const(UInt)* textures);
	void genTexturesEXT(Sizei n, UInt* textures);
	Boolean isTextureEXT(UInt texture);
	void prioritizeTexturesEXT(Sizei n, const(UInt)* textures, const(Clampf)* priorities);

	enum PERTURB_EXT = 0x85AE;
	enum TEXTURE_NORMAL_EXT = 0x85AF;
	void textureNormalEXT(Enum mode);

	enum SRGB_EXT = 0x8C40;
	enum SRGB8_EXT = 0x8C41;
	enum SRGB_ALPHA_EXT = 0x8C42;
	enum SRGB8_ALPHA8_EXT = 0x8C43;
	enum SLUMINANCE_ALPHA_EXT = 0x8C44;
	enum SLUMINANCE8_ALPHA8_EXT = 0x8C45;
	enum SLUMINANCE_EXT = 0x8C46;
	enum SLUMINANCE8_EXT = 0x8C47;
	enum COMPRESSED_SRGB_EXT = 0x8C48;
	enum COMPRESSED_SRGB_ALPHA_EXT = 0x8C49;
	enum COMPRESSED_SLUMINANCE_EXT = 0x8C4A;
	enum COMPRESSED_SLUMINANCE_ALPHA_EXT = 0x8C4B;
	enum COMPRESSED_SRGB_S3TC_DXT1_EXT = 0x8C4C;
	enum COMPRESSED_SRGB_ALPHA_S3TC_DXT1_EXT = 0x8C4D;
	enum COMPRESSED_SRGB_ALPHA_S3TC_DXT3_EXT = 0x8C4E;
	enum COMPRESSED_SRGB_ALPHA_S3TC_DXT5_EXT = 0x8C4F;

	enum SR8_EXT = 0x8FBD;

	enum TEXTURE_SRGB_DECODE_EXT = 0x8A48;
	enum DECODE_EXT = 0x8A49;
	enum SKIP_DECODE_EXT = 0x8A4A;

	enum RGB9_E5_EXT = 0x8C3D;
	enum UNSIGNED_INT_5_9_9_9_REV_EXT = 0x8C3E;
	enum TEXTURE_SHARED_SIZE_EXT = 0x8C3F;

	enum ALPHA_SNORM = 0x9010;
	enum LUMINANCE_SNORM = 0x9011;
	enum LUMINANCE_ALPHA_SNORM = 0x9012;
	enum INTENSITY_SNORM = 0x9013;
	enum ALPHA8_SNORM = 0x9014;
	enum LUMINANCE8_SNORM = 0x9015;
	enum LUMINANCE8_ALPHA8_SNORM = 0x9016;
	enum INTENSITY8_SNORM = 0x9017;
	enum ALPHA16_SNORM = 0x9018;
	enum LUMINANCE16_SNORM = 0x9019;
	enum LUMINANCE16_ALPHA16_SNORM = 0x901A;
	enum INTENSITY16_SNORM = 0x901B;
	enum RED_SNORM = 0x8F90;
	enum RG_SNORM = 0x8F91;
	enum RGB_SNORM = 0x8F92;
	enum RGBA_SNORM = 0x8F93;

	enum TEXTURE_SWIZZLE_R_EXT = 0x8E42;
	enum TEXTURE_SWIZZLE_G_EXT = 0x8E43;
	enum TEXTURE_SWIZZLE_B_EXT = 0x8E44;
	enum TEXTURE_SWIZZLE_A_EXT = 0x8E45;
	enum TEXTURE_SWIZZLE_RGBA_EXT = 0x8E46;

	enum TIME_ELAPSED_EXT = 0x88BF;
	void getQueryObjecti64vEXT(UInt id, Enum pname, GLint64* params);
	void getQueryObjectui64vEXT(UInt id, Enum pname, GLuint64* params);

	enum TRANSFORM_FEEDBACK_BUFFER_EXT = 0x8C8E;
	enum TRANSFORM_FEEDBACK_BUFFER_START_EXT = 0x8C84;
	enum TRANSFORM_FEEDBACK_BUFFER_SIZE_EXT = 0x8C85;
	enum TRANSFORM_FEEDBACK_BUFFER_BINDING_EXT = 0x8C8F;
	enum INTERLEAVED_ATTRIBS_EXT = 0x8C8C;
	enum SEPARATE_ATTRIBS_EXT = 0x8C8D;
	enum PRIMITIVES_GENERATED_EXT = 0x8C87;
	enum TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN_EXT = 0x8C88;
	enum RASTERIZER_DISCARD_EXT = 0x8C89;
	enum MAX_TRANSFORM_FEEDBACK_INTERLEAVED_COMPONENTS_EXT = 0x8C8A;
	enum MAX_TRANSFORM_FEEDBACK_SEPARATE_ATTRIBS_EXT = 0x8C8B;
	enum MAX_TRANSFORM_FEEDBACK_SEPARATE_COMPONENTS_EXT = 0x8C80;
	enum TRANSFORM_FEEDBACK_VARYINGS_EXT = 0x8C83;
	enum TRANSFORM_FEEDBACK_BUFFER_MODE_EXT = 0x8C7F;
	enum TRANSFORM_FEEDBACK_VARYING_MAX_LENGTH_EXT = 0x8C76;
	void beginTransformFeedbackEXT(Enum primitiveMode);
	void endTransformFeedbackEXT();
	void bindBufferRangeEXT(Enum target, UInt index, UInt buffer,
			Intptr offset, Sizeiptr size);
	void bindBufferOffsetEXT(Enum target, UInt index, UInt buffer, Intptr offset);
	void bindBufferBaseEXT(Enum target, UInt index, UInt buffer);
	void transformFeedbackVaryingsEXT(UInt program, Sizei count,
			const(Char*)* varyings, Enum bufferMode);
	void getTransformFeedbackVaryingEXT(UInt program, UInt index,
			Sizei bufSize, Sizei* length, Sizei* size, Enum* type, Char* name);

	enum VERTEX_ARRAY_EXT = 0x8074;
	enum NORMAL_ARRAY_EXT = 0x8075;
	enum COLOR_ARRAY_EXT = 0x8076;
	enum INDEX_ARRAY_EXT = 0x8077;
	enum TEXTURE_COORD_ARRAY_EXT = 0x8078;
	enum EDGE_FLAG_ARRAY_EXT = 0x8079;
	enum VERTEX_ARRAY_SIZE_EXT = 0x807A;
	enum VERTEX_ARRAY_TYPE_EXT = 0x807B;
	enum VERTEX_ARRAY_STRIDE_EXT = 0x807C;
	enum VERTEX_ARRAY_COUNT_EXT = 0x807D;
	enum NORMAL_ARRAY_TYPE_EXT = 0x807E;
	enum NORMAL_ARRAY_STRIDE_EXT = 0x807F;
	enum NORMAL_ARRAY_COUNT_EXT = 0x8080;
	enum COLOR_ARRAY_SIZE_EXT = 0x8081;
	enum COLOR_ARRAY_TYPE_EXT = 0x8082;
	enum COLOR_ARRAY_STRIDE_EXT = 0x8083;
	enum COLOR_ARRAY_COUNT_EXT = 0x8084;
	enum INDEX_ARRAY_TYPE_EXT = 0x8085;
	enum INDEX_ARRAY_STRIDE_EXT = 0x8086;
	enum INDEX_ARRAY_COUNT_EXT = 0x8087;
	enum TEXTURE_COORD_ARRAY_SIZE_EXT = 0x8088;
	enum TEXTURE_COORD_ARRAY_TYPE_EXT = 0x8089;
	enum TEXTURE_COORD_ARRAY_STRIDE_EXT = 0x808A;
	enum TEXTURE_COORD_ARRAY_COUNT_EXT = 0x808B;
	enum EDGE_FLAG_ARRAY_STRIDE_EXT = 0x808C;
	enum EDGE_FLAG_ARRAY_COUNT_EXT = 0x808D;
	enum VERTEX_ARRAY_POINTER_EXT = 0x808E;
	enum NORMAL_ARRAY_POINTER_EXT = 0x808F;
	enum COLOR_ARRAY_POINTER_EXT = 0x8090;
	enum INDEX_ARRAY_POINTER_EXT = 0x8091;
	enum TEXTURE_COORD_ARRAY_POINTER_EXT = 0x8092;
	enum EDGE_FLAG_ARRAY_POINTER_EXT = 0x8093;
	void arrayElementEXT(Int i);
	void colorPointerEXT(Int size, Enum type, Sizei stride, Sizei count,
			const(void)* pointer);
	void drawArraysEXT(Enum mode, Int first, Sizei count);
	void edgeFlagPointerEXT(Sizei stride, Sizei count, const(Boolean)* pointer);
	void getPointervEXT(Enum pname, void** params);
	void indexPointerEXT(Enum type, Sizei stride, Sizei count, const(void)* pointer);
	void normalPointerEXT(Enum type, Sizei stride, Sizei count, const(void)* pointer);
	void texCoordPointerEXT(Int size, Enum type, Sizei stride, Sizei count,
			const(void)* pointer);
	void vertexPointerEXT(Int size, Enum type, Sizei stride,
			Sizei count, const(void)* pointer);

	enum DOUBLE_VEC2_EXT = 0x8FFC;
	enum DOUBLE_VEC3_EXT = 0x8FFD;
	enum DOUBLE_VEC4_EXT = 0x8FFE;
	enum DOUBLE_MAT2_EXT = 0x8F46;
	enum DOUBLE_MAT3_EXT = 0x8F47;
	enum DOUBLE_MAT4_EXT = 0x8F48;
	enum DOUBLE_MAT2x3_EXT = 0x8F49;
	enum DOUBLE_MAT2x4_EXT = 0x8F4A;
	enum DOUBLE_MAT3x2_EXT = 0x8F4B;
	enum DOUBLE_MAT3x4_EXT = 0x8F4C;
	enum DOUBLE_MAT4x2_EXT = 0x8F4D;
	enum DOUBLE_MAT4x3_EXT = 0x8F4E;
	void vertexAttribL1dEXT(UInt index, Double x);
	void vertexAttribL2dEXT(UInt index, Double x, Double y);
	void vertexAttribL3dEXT(UInt index, Double x, Double y, Double z);
	void vertexAttribL4dEXT(UInt index, Double x, Double y, Double z, Double w);
	void vertexAttribL1dvEXT(UInt index, const(Double)* v);
	void vertexAttribL2dvEXT(UInt index, const(Double)* v);
	void vertexAttribL3dvEXT(UInt index, const(Double)* v);
	void vertexAttribL4dvEXT(UInt index, const(Double)* v);
	void vertexAttribLPointerEXT(UInt index, Int size, Enum type,
			Sizei stride, const(void)* pointer);
	void getVertexAttribLdvEXT(UInt index, Enum pname, Double* params);

	enum VERTEX_SHADER_EXT = 0x8780;
	enum VERTEX_SHADER_BINDING_EXT = 0x8781;
	enum OP_INDEX_EXT = 0x8782;
	enum OP_NEGATE_EXT = 0x8783;
	enum OP_DOT3_EXT = 0x8784;
	enum OP_DOT4_EXT = 0x8785;
	enum OP_MUL_EXT = 0x8786;
	enum OP_ADD_EXT = 0x8787;
	enum OP_MADD_EXT = 0x8788;
	enum OP_FRAC_EXT = 0x8789;
	enum OP_MAX_EXT = 0x878A;
	enum OP_MIN_EXT = 0x878B;
	enum OP_SET_GE_EXT = 0x878C;
	enum OP_SET_LT_EXT = 0x878D;
	enum OP_CLAMP_EXT = 0x878E;
	enum OP_FLOOR_EXT = 0x878F;
	enum OP_ROUND_EXT = 0x8790;
	enum OP_EXP_BASE_2_EXT = 0x8791;
	enum OP_LOG_BASE_2_EXT = 0x8792;
	enum OP_POWER_EXT = 0x8793;
	enum OP_RECIP_EXT = 0x8794;
	enum OP_RECIP_SQRT_EXT = 0x8795;
	enum OP_SUB_EXT = 0x8796;
	enum OP_CROSS_PRODUCT_EXT = 0x8797;
	enum OP_MULTIPLY_MATRIX_EXT = 0x8798;
	enum OP_MOV_EXT = 0x8799;
	enum OUTPUT_VERTEX_EXT = 0x879A;
	enum OUTPUT_COLOR0_EXT = 0x879B;
	enum OUTPUT_COLOR1_EXT = 0x879C;
	enum OUTPUT_TEXTURE_COORD0_EXT = 0x879D;
	enum OUTPUT_TEXTURE_COORD1_EXT = 0x879E;
	enum OUTPUT_TEXTURE_COORD2_EXT = 0x879F;
	enum OUTPUT_TEXTURE_COORD3_EXT = 0x87A0;
	enum OUTPUT_TEXTURE_COORD4_EXT = 0x87A1;
	enum OUTPUT_TEXTURE_COORD5_EXT = 0x87A2;
	enum OUTPUT_TEXTURE_COORD6_EXT = 0x87A3;
	enum OUTPUT_TEXTURE_COORD7_EXT = 0x87A4;
	enum OUTPUT_TEXTURE_COORD8_EXT = 0x87A5;
	enum OUTPUT_TEXTURE_COORD9_EXT = 0x87A6;
	enum OUTPUT_TEXTURE_COORD10_EXT = 0x87A7;
	enum OUTPUT_TEXTURE_COORD11_EXT = 0x87A8;
	enum OUTPUT_TEXTURE_COORD12_EXT = 0x87A9;
	enum OUTPUT_TEXTURE_COORD13_EXT = 0x87AA;
	enum OUTPUT_TEXTURE_COORD14_EXT = 0x87AB;
	enum OUTPUT_TEXTURE_COORD15_EXT = 0x87AC;
	enum OUTPUT_TEXTURE_COORD16_EXT = 0x87AD;
	enum OUTPUT_TEXTURE_COORD17_EXT = 0x87AE;
	enum OUTPUT_TEXTURE_COORD18_EXT = 0x87AF;
	enum OUTPUT_TEXTURE_COORD19_EXT = 0x87B0;
	enum OUTPUT_TEXTURE_COORD20_EXT = 0x87B1;
	enum OUTPUT_TEXTURE_COORD21_EXT = 0x87B2;
	enum OUTPUT_TEXTURE_COORD22_EXT = 0x87B3;
	enum OUTPUT_TEXTURE_COORD23_EXT = 0x87B4;
	enum OUTPUT_TEXTURE_COORD24_EXT = 0x87B5;
	enum OUTPUT_TEXTURE_COORD25_EXT = 0x87B6;
	enum OUTPUT_TEXTURE_COORD26_EXT = 0x87B7;
	enum OUTPUT_TEXTURE_COORD27_EXT = 0x87B8;
	enum OUTPUT_TEXTURE_COORD28_EXT = 0x87B9;
	enum OUTPUT_TEXTURE_COORD29_EXT = 0x87BA;
	enum OUTPUT_TEXTURE_COORD30_EXT = 0x87BB;
	enum OUTPUT_TEXTURE_COORD31_EXT = 0x87BC;
	enum OUTPUT_FOG_EXT = 0x87BD;
	enum SCALAR_EXT = 0x87BE;
	enum VECTOR_EXT = 0x87BF;
	enum MATRIX_EXT = 0x87C0;
	enum VARIANT_EXT = 0x87C1;
	enum INVARIANT_EXT = 0x87C2;
	enum LOCAL_CONSTANT_EXT = 0x87C3;
	enum LOCAL_EXT = 0x87C4;
	enum MAX_VERTEX_SHADER_INSTRUCTIONS_EXT = 0x87C5;
	enum MAX_VERTEX_SHADER_VARIANTS_EXT = 0x87C6;
	enum MAX_VERTEX_SHADER_INVARIANTS_EXT = 0x87C7;
	enum MAX_VERTEX_SHADER_LOCAL_CONSTANTS_EXT = 0x87C8;
	enum MAX_VERTEX_SHADER_LOCALS_EXT = 0x87C9;
	enum MAX_OPTIMIZED_VERTEX_SHADER_INSTRUCTIONS_EXT = 0x87CA;
	enum MAX_OPTIMIZED_VERTEX_SHADER_VARIANTS_EXT = 0x87CB;
	enum MAX_OPTIMIZED_VERTEX_SHADER_LOCAL_CONSTANTS_EXT = 0x87CC;
	enum MAX_OPTIMIZED_VERTEX_SHADER_INVARIANTS_EXT = 0x87CD;
	enum MAX_OPTIMIZED_VERTEX_SHADER_LOCALS_EXT = 0x87CE;
	enum VERTEX_SHADER_INSTRUCTIONS_EXT = 0x87CF;
	enum VERTEX_SHADER_VARIANTS_EXT = 0x87D0;
	enum VERTEX_SHADER_INVARIANTS_EXT = 0x87D1;
	enum VERTEX_SHADER_LOCAL_CONSTANTS_EXT = 0x87D2;
	enum VERTEX_SHADER_LOCALS_EXT = 0x87D3;
	enum VERTEX_SHADER_OPTIMIZED_EXT = 0x87D4;
	enum X_EXT = 0x87D5;
	enum Y_EXT = 0x87D6;
	enum Z_EXT = 0x87D7;
	enum W_EXT = 0x87D8;
	enum NEGATIVE_X_EXT = 0x87D9;
	enum NEGATIVE_Y_EXT = 0x87DA;
	enum NEGATIVE_Z_EXT = 0x87DB;
	enum NEGATIVE_W_EXT = 0x87DC;
	enum ZERO_EXT = 0x87DD;
	enum ONE_EXT = 0x87DE;
	enum NEGATIVE_ONE_EXT = 0x87DF;
	enum NORMALIZED_RANGE_EXT = 0x87E0;
	enum FULL_RANGE_EXT = 0x87E1;
	enum CURRENT_VERTEX_EXT = 0x87E2;
	enum MVP_MATRIX_EXT = 0x87E3;
	enum VARIANT_VALUE_EXT = 0x87E4;
	enum VARIANT_DATATYPE_EXT = 0x87E5;
	enum VARIANT_ARRAY_STRIDE_EXT = 0x87E6;
	enum VARIANT_ARRAY_TYPE_EXT = 0x87E7;
	enum VARIANT_ARRAY_EXT = 0x87E8;
	enum VARIANT_ARRAY_POINTER_EXT = 0x87E9;
	enum INVARIANT_VALUE_EXT = 0x87EA;
	enum INVARIANT_DATATYPE_EXT = 0x87EB;
	enum LOCAL_CONSTANT_VALUE_EXT = 0x87EC;
	enum LOCAL_CONSTANT_DATATYPE_EXT = 0x87ED;
	void beginVertexShaderEXT();
	void endVertexShaderEXT();
	void bindVertexShaderEXT(UInt id);
	UInt genVertexShadersEXT(UInt range);
	void deleteVertexShaderEXT(UInt id);
	void shaderOp1EXT(Enum op, UInt res, UInt arg1);
	void shaderOp2EXT(Enum op, UInt res, UInt arg1, UInt arg2);
	void shaderOp3EXT(Enum op, UInt res, UInt arg1, UInt arg2, UInt arg3);
	void swizzleEXT(UInt res, UInt in_, Enum outX, Enum outY, Enum outZ, Enum outW);
	void writeMaskEXT(UInt res, UInt in_, Enum outX, Enum outY, Enum outZ, Enum outW);
	void insertComponentEXT(UInt res, UInt src, UInt num);
	void extractComponentEXT(UInt res, UInt src, UInt num);
	UInt genSymbolsEXT(Enum datatype, Enum storagetype, Enum range, UInt components);
	void setInvariantEXT(UInt id, Enum type, const(void)* addr);
	void setLocalConstantEXT(UInt id, Enum type, const(void)* addr);
	void variantbvEXT(UInt id, const(Byte)* addr);
	void variantsvEXT(UInt id, const(Short)* addr);
	void variantivEXT(UInt id, const(Int)* addr);
	void variantfvEXT(UInt id, const(Float)* addr);
	void variantdvEXT(UInt id, const(Double)* addr);
	void variantubvEXT(UInt id, const(UByte)* addr);
	void variantusvEXT(UInt id, const(UShort)* addr);
	void variantuivEXT(UInt id, const(UInt)* addr);
	void variantPointerEXT(UInt id, Enum type, UInt stride, const(void)* addr);
	void enableVariantClientStateEXT(UInt id);
	void disableVariantClientStateEXT(UInt id);
	UInt bindLightParameterEXT(Enum light, Enum value);
	UInt bindMaterialParameterEXT(Enum face, Enum value);
	UInt bindTexGenParameterEXT(Enum unit, Enum coord, Enum value);
	UInt bindTextureUnitParameterEXT(Enum unit, Enum value);
	UInt bindParameterEXT(Enum value);
	Boolean isVariantEnabledEXT(UInt id, Enum cap);
	void getVariantBooleanvEXT(UInt id, Enum value, Boolean* data);
	void getVariantIntegervEXT(UInt id, Enum value, Int* data);
	void getVariantFloatvEXT(UInt id, Enum value, Float* data);
	void getVariantPointervEXT(UInt id, Enum value, void** data);
	void getInvariantBooleanvEXT(UInt id, Enum value, Boolean* data);
	void getInvariantIntegervEXT(UInt id, Enum value, Int* data);
	void getInvariantFloatvEXT(UInt id, Enum value, Float* data);
	void getLocalConstantBooleanvEXT(UInt id, Enum value, Boolean* data);
	void getLocalConstantIntegervEXT(UInt id, Enum value, Int* data);
	void getLocalConstantFloatvEXT(UInt id, Enum value, Float* data);

	enum MODELVIEW0_STACK_DEPTH_EXT = 0x0BA3;
	enum MODELVIEW1_STACK_DEPTH_EXT = 0x8502;
	enum MODELVIEW0_MATRIX_EXT = 0x0BA6;
	enum MODELVIEW1_MATRIX_EXT = 0x8506;
	enum VERTEX_WEIGHTING_EXT = 0x8509;
	enum MODELVIEW0_EXT = 0x1700;
	enum MODELVIEW1_EXT = 0x850A;
	enum CURRENT_VERTEX_WEIGHT_EXT = 0x850B;
	enum VERTEX_WEIGHT_ARRAY_EXT = 0x850C;
	enum VERTEX_WEIGHT_ARRAY_SIZE_EXT = 0x850D;
	enum VERTEX_WEIGHT_ARRAY_TYPE_EXT = 0x850E;
	enum VERTEX_WEIGHT_ARRAY_STRIDE_EXT = 0x850F;
	enum VERTEX_WEIGHT_ARRAY_POINTER_EXT = 0x8510;
	void vertexWeightfEXT(Float weight);
	void vertexWeightfvEXT(const(Float)* weight);
	void vertexWeightPointerEXT(Int size, Enum type, Sizei stride, const(void)* pointer);

	Boolean acquireKeyedMutexWin32EXT(UInt memory, GLuint64 key, UInt timeout);
	Boolean releaseKeyedMutexWin32EXT(UInt memory, GLuint64 key);

	enum INCLUSIVE_EXT = 0x8F10;
	enum EXCLUSIVE_EXT = 0x8F11;
	enum WINDOW_RECTANGLE_EXT = 0x8F12;
	enum WINDOW_RECTANGLE_MODE_EXT = 0x8F13;
	enum MAX_WINDOW_RECTANGLES_EXT = 0x8F14;
	enum NUM_WINDOW_RECTANGLES_EXT = 0x8F15;
	void windowRectanglesEXT(Enum mode, Sizei count, const(Int)* box);

	enum SYNC_X11_FENCE_EXT = 0x90E1;
	Sync importSyncEXT(Enum external_sync_type, Intptr external_sync, Bitfield flags);

	void frameTerminatorGREMEDY();

	void stringMarkerGREMEDY(Sizei len, const(void)* string);

	enum IGNORE_BORDER_HP = 0x8150;
	enum CONSTANT_BORDER_HP = 0x8151;
	enum REPLICATE_BORDER_HP = 0x8153;
	enum CONVOLUTION_BORDER_COLOR_HP = 0x8154;

	enum IMAGE_SCALE_X_HP = 0x8155;
	enum IMAGE_SCALE_Y_HP = 0x8156;
	enum IMAGE_TRANSLATE_X_HP = 0x8157;
	enum IMAGE_TRANSLATE_Y_HP = 0x8158;
	enum IMAGE_ROTATE_ANGLE_HP = 0x8159;
	enum IMAGE_ROTATE_ORIGIN_X_HP = 0x815A;
	enum IMAGE_ROTATE_ORIGIN_Y_HP = 0x815B;
	enum IMAGE_MAG_FILTER_HP = 0x815C;
	enum IMAGE_MIN_FILTER_HP = 0x815D;
	enum IMAGE_CUBIC_WEIGHT_HP = 0x815E;
	enum CUBIC_HP = 0x815F;
	enum AVERAGE_HP = 0x8160;
	enum IMAGE_TRANSFORM_2D_HP = 0x8161;
	enum POST_IMAGE_TRANSFORM_COLOR_TABLE_HP = 0x8162;
	enum PROXY_POST_IMAGE_TRANSFORM_COLOR_TABLE_HP = 0x8163;
	void imageTransformParameteriHP(Enum target, Enum pname, Int param);
	void imageTransformParameterfHP(Enum target, Enum pname, Float param);
	void imageTransformParameterivHP(Enum target, Enum pname, const(Int)* params);
	void imageTransformParameterfvHP(Enum target, Enum pname, const(Float)* params);
	void getImageTransformParameterivHP(Enum target, Enum pname, Int* params);
	void getImageTransformParameterfvHP(Enum target, Enum pname, Float* params);

	enum OCCLUSION_TEST_HP = 0x8165;
	enum OCCLUSION_TEST_RESULT_HP = 0x8166;

	enum TEXTURE_LIGHTING_MODE_HP = 0x8167;
	enum TEXTURE_POST_SPECULAR_HP = 0x8168;
	enum TEXTURE_PRE_SPECULAR_HP = 0x8169;

	enum CULL_VERTEX_IBM = 103_050;

	void multiModeDrawArraysIBM(const(Enum)* mode, const(Int)* first,
			const(Sizei)* count, Sizei primcount, Int modestride);
	void multiModeDrawElementsIBM(const(Enum)* mode, const(Sizei)* count,
			Enum type, const(void*)* indices, Sizei primcount, Int modestride);

	enum RASTER_POSITION_UNCLIPPED_IBM = 0x19262;

	enum ALL_STATIC_DATA_IBM = 103_060;
	enum STATIC_VERTEX_ARRAY_IBM = 103_061;
	void flushStaticDataIBM(Enum target);

	enum MIRRORED_REPEAT_IBM = 0x8370;

	enum VERTEX_ARRAY_LIST_IBM = 103_070;
	enum NORMAL_ARRAY_LIST_IBM = 103_071;
	enum COLOR_ARRAY_LIST_IBM = 103_072;
	enum INDEX_ARRAY_LIST_IBM = 103_073;
	enum TEXTURE_COORD_ARRAY_LIST_IBM = 103_074;
	enum EDGE_FLAG_ARRAY_LIST_IBM = 103_075;
	enum FOG_COORDINATE_ARRAY_LIST_IBM = 103_076;
	enum SECONDARY_COLOR_ARRAY_LIST_IBM = 103_077;
	enum VERTEX_ARRAY_LIST_STRIDE_IBM = 103_080;
	enum NORMAL_ARRAY_LIST_STRIDE_IBM = 103_081;
	enum COLOR_ARRAY_LIST_STRIDE_IBM = 103_082;
	enum INDEX_ARRAY_LIST_STRIDE_IBM = 103_083;
	enum TEXTURE_COORD_ARRAY_LIST_STRIDE_IBM = 103_084;
	enum EDGE_FLAG_ARRAY_LIST_STRIDE_IBM = 103_085;
	enum FOG_COORDINATE_ARRAY_LIST_STRIDE_IBM = 103_086;
	enum SECONDARY_COLOR_ARRAY_LIST_STRIDE_IBM = 103_087;
	void colorPointerListIBM(Int size, Enum type, Int stride,
			const(void*)* pointer, Int ptrstride);
	void secondaryColorPointerListIBM(Int size, Enum type, Int stride,
			const(void*)* pointer, Int ptrstride);
	void edgeFlagPointerListIBM(Int stride, const(Boolean*)* pointer, Int ptrstride);
	void fogCoordPointerListIBM(Enum type, Int stride, const(void*)* pointer, Int ptrstride);
	void indexPointerListIBM(Enum type, Int stride, const(void*)* pointer, Int ptrstride);
	void normalPointerListIBM(Enum type, Int stride, const(void*)* pointer, Int ptrstride);
	void texCoordPointerListIBM(Int size, Enum type, Int stride,
			const(void*)* pointer, Int ptrstride);
	void vertexPointerListIBM(Int size, Enum type, Int stride,
			const(void*)* pointer, Int ptrstride);

	void blendFuncSeparateINGR(Enum sfactorRGB, Enum dfactorRGB,
			Enum sfactorAlpha, Enum dfactorAlpha);

	enum RED_MIN_CLAMP_INGR = 0x8560;
	enum GREEN_MIN_CLAMP_INGR = 0x8561;
	enum BLUE_MIN_CLAMP_INGR = 0x8562;
	enum ALPHA_MIN_CLAMP_INGR = 0x8563;
	enum RED_MAX_CLAMP_INGR = 0x8564;
	enum GREEN_MAX_CLAMP_INGR = 0x8565;
	enum BLUE_MAX_CLAMP_INGR = 0x8566;
	enum ALPHA_MAX_CLAMP_INGR = 0x8567;

	enum INTERLACE_READ_INGR = 0x8568;

	enum BLACKHOLE_RENDER_INTEL = 0x83FC;

	enum CONSERVATIVE_RASTERIZATION_INTEL = 0x83FE;

	void applyFramebufferAttachmentCMAAINTEL();

	enum TEXTURE_MEMORY_LAYOUT_INTEL = 0x83FF;
	enum LAYOUT_DEFAULT_INTEL = 0;
	enum LAYOUT_LINEAR_INTEL = 1;
	enum LAYOUT_LINEAR_CPU_CACHED_INTEL = 2;
	void syncTextureINTEL(UInt texture);
	void unmapTexture2DINTEL(UInt texture, Int level);
	void* mapTexture2DINTEL(UInt texture, Int level, Bitfield access,
			Int* stride, Enum* layout);

	enum PARALLEL_ARRAYS_INTEL = 0x83F4;
	enum VERTEX_ARRAY_PARALLEL_POINTERS_INTEL = 0x83F5;
	enum NORMAL_ARRAY_PARALLEL_POINTERS_INTEL = 0x83F6;
	enum COLOR_ARRAY_PARALLEL_POINTERS_INTEL = 0x83F7;
	enum TEXTURE_COORD_ARRAY_PARALLEL_POINTERS_INTEL = 0x83F8;
	void vertexPointervINTEL(Int size, Enum type, const(void*)* pointer);
	void normalPointervINTEL(Enum type, const(void*)* pointer);
	void colorPointervINTEL(Int size, Enum type, const(void*)* pointer);
	void texCoordPointervINTEL(Int size, Enum type, const(void*)* pointer);

	enum PERFQUERY_SINGLE_CONTEXT_INTEL = 0x00000000;
	enum PERFQUERY_GLOBAL_CONTEXT_INTEL = 0x00000001;
	enum PERFQUERY_WAIT_INTEL = 0x83FB;
	enum PERFQUERY_FLUSH_INTEL = 0x83FA;
	enum PERFQUERY_DONOT_FLUSH_INTEL = 0x83F9;
	enum PERFQUERY_COUNTER_EVENT_INTEL = 0x94F0;
	enum PERFQUERY_COUNTER_DURATION_NORM_INTEL = 0x94F1;
	enum PERFQUERY_COUNTER_DURATION_RAW_INTEL = 0x94F2;
	enum PERFQUERY_COUNTER_THROUGHPUT_INTEL = 0x94F3;
	enum PERFQUERY_COUNTER_RAW_INTEL = 0x94F4;
	enum PERFQUERY_COUNTER_TIMESTAMP_INTEL = 0x94F5;
	enum PERFQUERY_COUNTER_DATA_UINT32_INTEL = 0x94F8;
	enum PERFQUERY_COUNTER_DATA_UINT64_INTEL = 0x94F9;
	enum PERFQUERY_COUNTER_DATA_FLOAT_INTEL = 0x94FA;
	enum PERFQUERY_COUNTER_DATA_DOUBLE_INTEL = 0x94FB;
	enum PERFQUERY_COUNTER_DATA_BOOL32_INTEL = 0x94FC;
	enum PERFQUERY_QUERY_NAME_LENGTH_MAX_INTEL = 0x94FD;
	enum PERFQUERY_COUNTER_NAME_LENGTH_MAX_INTEL = 0x94FE;
	enum PERFQUERY_COUNTER_DESC_LENGTH_MAX_INTEL = 0x94FF;
	enum PERFQUERY_GPA_EXTENDED_COUNTERS_INTEL = 0x9500;
	void beginPerfQueryINTEL(UInt queryHandle);
	void createPerfQueryINTEL(UInt queryId, UInt* queryHandle);
	void deletePerfQueryINTEL(UInt queryHandle);
	void endPerfQueryINTEL(UInt queryHandle);
	void getFirstPerfQueryIdINTEL(UInt* queryId);
	void getNextPerfQueryIdINTEL(UInt queryId, UInt* nextQueryId);
	void getPerfCounterInfoINTEL(UInt queryId, UInt counterId,
			UInt counterNameLength, Char* counterName, UInt counterDescLength,
			Char* counterDesc, UInt* counterOffset, UInt* counterDataSize,
			UInt* counterTypeEnum, UInt* counterDataTypeEnum, GLuint64* rawCounterMaxValue);
	void getPerfQueryDataINTEL(UInt queryHandle, UInt flags, Sizei dataSize,
			void* data, UInt* bytesWritten);
	void getPerfQueryIdByNameINTEL(Char* queryName, UInt* queryId);
	void getPerfQueryInfoINTEL(UInt queryId, UInt queryNameLength, Char* queryName,
			UInt* dataSize, UInt* noCounters, UInt* noInstances, UInt* capsMask);

	enum TEXTURE_1D_STACK_MESAX = 0x8759;
	enum TEXTURE_2D_STACK_MESAX = 0x875A;
	enum PROXY_TEXTURE_1D_STACK_MESAX = 0x875B;
	enum PROXY_TEXTURE_2D_STACK_MESAX = 0x875C;
	enum TEXTURE_1D_STACK_BINDING_MESAX = 0x875D;
	enum TEXTURE_2D_STACK_BINDING_MESAX = 0x875E;

	enum FRAMEBUFFER_FLIP_Y_MESA = 0x8BBB;
	void framebufferParameteriMESA(Enum target, Enum pname, Int param);
	void getFramebufferParameterivMESA(Enum target, Enum pname, Int* params);

	enum PACK_INVERT_MESA = 0x8758;

	enum PROGRAM_BINARY_FORMAT_MESA = 0x875F;

	void resizeBuffersMESA();

	enum TILE_RASTER_ORDER_FIXED_MESA = 0x8BB8;
	enum TILE_RASTER_ORDER_INCREASING_X_MESA = 0x8BB9;
	enum TILE_RASTER_ORDER_INCREASING_Y_MESA = 0x8BBA;

	void windowPos2dMESA(Double x, Double y);
	void windowPos2dvMESA(const(Double)* v);
	void windowPos2fMESA(Float x, Float y);
	void windowPos2fvMESA(const(Float)* v);
	void windowPos2iMESA(Int x, Int y);
	void windowPos2ivMESA(const(Int)* v);
	void windowPos2sMESA(Short x, Short y);
	void windowPos2svMESA(const(Short)* v);
	void windowPos3dMESA(Double x, Double y, Double z);
	void windowPos3dvMESA(const(Double)* v);
	void windowPos3fMESA(Float x, Float y, Float z);
	void windowPos3fvMESA(const(Float)* v);
	void windowPos3iMESA(Int x, Int y, Int z);
	void windowPos3ivMESA(const(Int)* v);
	void windowPos3sMESA(Short x, Short y, Short z);
	void windowPos3svMESA(const(Short)* v);
	void windowPos4dMESA(Double x, Double y, Double z, Double w);
	void windowPos4dvMESA(const(Double)* v);
	void windowPos4fMESA(Float x, Float y, Float z, Float w);
	void windowPos4fvMESA(const(Float)* v);
	void windowPos4iMESA(Int x, Int y, Int z, Int w);
	void windowPos4ivMESA(const(Int)* v);
	void windowPos4sMESA(Short x, Short y, Short z, Short w);
	void windowPos4svMESA(const(Short)* v);

	enum UNSIGNED_SHORT_8_8_MESA = 0x85BA;
	enum UNSIGNED_SHORT_8_8_REV_MESA = 0x85BB;
	enum YCBCR_MESA = 0x8757;

	void beginConditionalRenderNVX(UInt id);
	void endConditionalRenderNVX();

	enum GPU_MEMORY_INFO_DEDICATED_VIDMEM_NVX = 0x9047;
	enum GPU_MEMORY_INFO_TOTAL_AVAILABLE_MEMORY_NVX = 0x9048;
	enum GPU_MEMORY_INFO_CURRENT_AVAILABLE_VIDMEM_NVX = 0x9049;
	enum GPU_MEMORY_INFO_EVICTION_COUNT_NVX = 0x904A;
	enum GPU_MEMORY_INFO_EVICTED_MEMORY_NVX = 0x904B;

	enum UPLOAD_GPU_MASK_NVX = 0x954A;
	void uploadGpuMaskNVX(Bitfield mask);
	void multicastViewportArrayvNVX(UInt gpu, UInt first, Sizei count, const(Float)* v);
	void multicastViewportPositionWScaleNVX(UInt gpu, UInt index, Float xcoeff, Float ycoeff);
	void multicastScissorArrayvNVX(UInt gpu, UInt first, Sizei count, const(Int)* v);
	UInt asyncCopyBufferSubDataNVX(Sizei waitSemaphoreCount,
			const(UInt)* waitSemaphoreArray, const(GLuint64)* fenceValueArray,
			UInt readGpu, Bitfield writeGpuMask, UInt readBuffer,
			UInt writeBuffer, Intptr readOffset, Intptr writeOffset,
			Sizeiptr size, Sizei signalSemaphoreCount,
			const(UInt)* signalSemaphoreArray, const(GLuint64)* signalValueArray);
	UInt asyncCopyImageSubDataNVX(Sizei waitSemaphoreCount,
			const(UInt)* waitSemaphoreArray, const(GLuint64)* waitValueArray,
			UInt srcGpu, Bitfield dstGpuMask, UInt srcName, Enum srcTarget, Int srcLevel, Int srcX,
			Int srcY, Int srcZ, UInt dstName, Enum dstTarget, Int dstLevel, Int dstX, Int dstY,
			Int dstZ, Sizei srcWidth, Sizei srcHeight, Sizei srcDepth, Sizei signalSemaphoreCount,
			const(UInt)* signalSemaphoreArray, const(GLuint64)* signalValueArray);

	enum LGPU_SEPARATE_STORAGE_BIT_NVX = 0x0800;
	enum MAX_LGPU_GPUS_NVX = 0x92BA;
	@BindingName("glLGPUNamedBufferSubDataNVX")
	void lgpuNamedBufferSubDataNVX(Bitfield gpuMask, UInt buffer,
			Intptr offset, Sizeiptr size, const(void)* data);
	@BindingName("glLGPUCopyImageSubDataNVX")
	void lgpuCopyImageSubDataNVX(UInt sourceGpu, Bitfield destinationGpuMask, UInt srcName, Enum srcTarget,
			Int srcLevel, Int srcX, Int srxY, Int srcZ, UInt dstName, Enum dstTarget,
			Int dstLevel, Int dstX, Int dstY, Int dstZ, Sizei width,
			Sizei height, Sizei depth);
	@BindingName("glLGPUInterlockNVX")
	void lgpuInterlockNVX();

	UInt createProgressFenceNVX();
	void signalSemaphoreui64NVX(UInt signalGpu, Sizei fenceObjectCount,
			const(UInt)* semaphoreArray, const(GLuint64)* fenceValueArray);
	void waitSemaphoreui64NVX(UInt waitGpu, Sizei fenceObjectCount,
			const(UInt)* semaphoreArray, const(GLuint64)* fenceValueArray);
	void clientWaitSemaphoreui64NVX(Sizei fenceObjectCount,
			const(UInt)* semaphoreArray, const(GLuint64)* fenceValueArray);

	enum ALPHA_TO_COVERAGE_DITHER_DEFAULT_NV = 0x934D;
	enum ALPHA_TO_COVERAGE_DITHER_ENABLE_NV = 0x934E;
	enum ALPHA_TO_COVERAGE_DITHER_DISABLE_NV = 0x934F;
	enum ALPHA_TO_COVERAGE_DITHER_MODE_NV = 0x92BF;
	void alphaToCoverageDitherControlNV(Enum mode);

	void multiDrawArraysIndirectBindlessNV(Enum mode, const(void)* indirect,
			Sizei drawCount, Sizei stride, Int vertexBufferCount);
	void multiDrawElementsIndirectBindlessNV(Enum mode, Enum type,
			const(void)* indirect, Sizei drawCount, Sizei stride, Int vertexBufferCount);

	void multiDrawArraysIndirectBindlessCountNV(Enum mode, const(void)* indirect,
			Sizei drawCount, Sizei maxDrawCount, Sizei stride, Int vertexBufferCount);
	void multiDrawElementsIndirectBindlessCountNV(Enum mode, Enum type, const(void)* indirect,
			Sizei drawCount, Sizei maxDrawCount, Sizei stride, Int vertexBufferCount);

	GLuint64 getTextureHandleNV(UInt texture);
	GLuint64 getTextureSamplerHandleNV(UInt texture, UInt sampler);
	void makeTextureHandleResidentNV(GLuint64 handle);
	void makeTextureHandleNonResidentNV(GLuint64 handle);
	GLuint64 getImageHandleNV(UInt texture, Int level, Boolean layered,
			Int layer, Enum format);
	void makeImageHandleResidentNV(GLuint64 handle, Enum access);
	void makeImageHandleNonResidentNV(GLuint64 handle);
	void uniformHandleui64NV(Int location, GLuint64 value);
	void uniformHandleui64vNV(Int location, Sizei count, const(GLuint64)* value);
	void programUniformHandleui64NV(UInt program, Int location, GLuint64 value);
	void programUniformHandleui64vNV(UInt program, Int location,
			Sizei count, const(GLuint64)* values);
	Boolean isTextureHandleResidentNV(GLuint64 handle);
	Boolean isImageHandleResidentNV(GLuint64 handle);

	enum BLEND_OVERLAP_NV = 0x9281;
	enum BLEND_PREMULTIPLIED_SRC_NV = 0x9280;
	enum BLUE_NV = 0x1905;
	enum COLORBURN_NV = 0x929A;
	enum COLORDODGE_NV = 0x9299;
	enum CONJOINT_NV = 0x9284;
	enum CONTRAST_NV = 0x92A1;
	enum DARKEN_NV = 0x9297;
	enum DIFFERENCE_NV = 0x929E;
	enum DISJOINT_NV = 0x9283;
	enum DST_ATOP_NV = 0x928F;
	enum DST_IN_NV = 0x928B;
	enum DST_NV = 0x9287;
	enum DST_OUT_NV = 0x928D;
	enum DST_OVER_NV = 0x9289;
	enum EXCLUSION_NV = 0x92A0;
	enum GREEN_NV = 0x1904;
	enum HARDLIGHT_NV = 0x929B;
	enum HARDMIX_NV = 0x92A9;
	enum HSL_COLOR_NV = 0x92AF;
	enum HSL_HUE_NV = 0x92AD;
	enum HSL_LUMINOSITY_NV = 0x92B0;
	enum HSL_SATURATION_NV = 0x92AE;
	enum INVERT_OVG_NV = 0x92B4;
	enum INVERT_RGB_NV = 0x92A3;
	enum LIGHTEN_NV = 0x9298;
	enum LINEARBURN_NV = 0x92A5;
	enum LINEARDODGE_NV = 0x92A4;
	enum LINEARLIGHT_NV = 0x92A7;
	enum MINUS_CLAMPED_NV = 0x92B3;
	enum MINUS_NV = 0x929F;
	enum MULTIPLY_NV = 0x9294;
	enum OVERLAY_NV = 0x9296;
	enum PINLIGHT_NV = 0x92A8;
	enum PLUS_CLAMPED_ALPHA_NV = 0x92B2;
	enum PLUS_CLAMPED_NV = 0x92B1;
	enum PLUS_DARKER_NV = 0x9292;
	enum PLUS_NV = 0x9291;
	enum RED_NV = 0x1903;
	enum SCREEN_NV = 0x9295;
	enum SOFTLIGHT_NV = 0x929C;
	enum SRC_ATOP_NV = 0x928E;
	enum SRC_IN_NV = 0x928A;
	enum SRC_NV = 0x9286;
	enum SRC_OUT_NV = 0x928C;
	enum SRC_OVER_NV = 0x9288;
	enum UNCORRELATED_NV = 0x9282;
	enum VIVIDLIGHT_NV = 0x92A6;
	enum XOR_NV = 0x1506;
	void blendParameteriNV(Enum pname, Int value);
	void blendBarrierNV();

	enum BLEND_ADVANCED_COHERENT_NV = 0x9285;

	enum VIEWPORT_POSITION_W_SCALE_NV = 0x937C;
	enum VIEWPORT_POSITION_W_SCALE_X_COEFF_NV = 0x937D;
	enum VIEWPORT_POSITION_W_SCALE_Y_COEFF_NV = 0x937E;
	void viewportPositionWScaleNV(UInt index, Float xcoeff, Float ycoeff);

	enum TERMINATE_SEQUENCE_COMMAND_NV = 0x0000;
	enum NOP_COMMAND_NV = 0x0001;
	enum DRAW_ELEMENTS_COMMAND_NV = 0x0002;
	enum DRAW_ARRAYS_COMMAND_NV = 0x0003;
	enum DRAW_ELEMENTS_STRIP_COMMAND_NV = 0x0004;
	enum DRAW_ARRAYS_STRIP_COMMAND_NV = 0x0005;
	enum DRAW_ELEMENTS_INSTANCED_COMMAND_NV = 0x0006;
	enum DRAW_ARRAYS_INSTANCED_COMMAND_NV = 0x0007;
	enum ELEMENT_ADDRESS_COMMAND_NV = 0x0008;
	enum ATTRIBUTE_ADDRESS_COMMAND_NV = 0x0009;
	enum UNIFORM_ADDRESS_COMMAND_NV = 0x000A;
	enum BLEND_COLOR_COMMAND_NV = 0x000B;
	enum STENCIL_REF_COMMAND_NV = 0x000C;
	enum LINE_WIDTH_COMMAND_NV = 0x000D;
	enum POLYGON_OFFSET_COMMAND_NV = 0x000E;
	enum ALPHA_REF_COMMAND_NV = 0x000F;
	enum VIEWPORT_COMMAND_NV = 0x0010;
	enum SCISSOR_COMMAND_NV = 0x0011;
	enum FRONT_FACE_COMMAND_NV = 0x0012;
	void createStatesNV(Sizei n, UInt* states);
	void deleteStatesNV(Sizei n, const(UInt)* states);
	Boolean isStateNV(UInt state);
	void stateCaptureNV(UInt state, Enum mode);
	UInt getCommandHeaderNV(Enum tokenID, UInt size);
	UShort getStageIndexNV(Enum shadertype);
	void drawCommandsNV(Enum primitiveMode, UInt buffer,
			const(Intptr)* indirects, const(Sizei)* sizes, UInt count);
	void drawCommandsAddressNV(Enum primitiveMode, const(GLuint64)* indirects,
			const(Sizei)* sizes, UInt count);
	void drawCommandsStatesNV(UInt buffer, const(Intptr)* indirects,
			const(Sizei)* sizes, const(UInt)* states, const(UInt)* fbos, UInt count);
	void drawCommandsStatesAddressNV(const(GLuint64)* indirects,
			const(Sizei)* sizes, const(UInt)* states, const(UInt)* fbos, UInt count);
	void createCommandListsNV(Sizei n, UInt* lists);
	void deleteCommandListsNV(Sizei n, const(UInt)* lists);
	Boolean isCommandListNV(UInt list);
	void listDrawCommandsStatesClientNV(UInt list, UInt segment,
			const(void*)* indirects, const(Sizei)* sizes,
			const(UInt)* states, const(UInt)* fbos, UInt count);
	void commandListSegmentsNV(UInt list, UInt segments);
	void compileCommandListNV(UInt list);
	void callCommandListNV(UInt list);

	enum COMPUTE_PROGRAM_NV = 0x90FB;
	enum COMPUTE_PROGRAM_PARAMETER_BUFFER_NV = 0x90FC;

	enum QUERY_WAIT_NV = 0x8E13;
	enum QUERY_NO_WAIT_NV = 0x8E14;
	enum QUERY_BY_REGION_WAIT_NV = 0x8E15;
	enum QUERY_BY_REGION_NO_WAIT_NV = 0x8E16;
	void beginConditionalRenderNV(UInt id, Enum mode);
	void endConditionalRenderNV();

	enum CONSERVATIVE_RASTERIZATION_NV = 0x9346;
	enum SUBPIXEL_PRECISION_BIAS_X_BITS_NV = 0x9347;
	enum SUBPIXEL_PRECISION_BIAS_Y_BITS_NV = 0x9348;
	enum MAX_SUBPIXEL_PRECISION_BIAS_BITS_NV = 0x9349;
	void subpixelPrecisionBiasNV(UInt xbits, UInt ybits);

	enum CONSERVATIVE_RASTER_DILATE_NV = 0x9379;
	enum CONSERVATIVE_RASTER_DILATE_RANGE_NV = 0x937A;
	enum CONSERVATIVE_RASTER_DILATE_GRANULARITY_NV = 0x937B;
	void conservativeRasterParameterfNV(Enum pname, Float value);

	enum CONSERVATIVE_RASTER_MODE_PRE_SNAP_NV = 0x9550;

	enum CONSERVATIVE_RASTER_MODE_NV = 0x954D;
	enum CONSERVATIVE_RASTER_MODE_POST_SNAP_NV = 0x954E;
	enum CONSERVATIVE_RASTER_MODE_PRE_SNAP_TRIANGLES_NV = 0x954F;
	void conservativeRasterParameteriNV(Enum pname, Int param);

	enum DEPTH_STENCIL_TO_RGBA_NV = 0x886E;
	enum DEPTH_STENCIL_TO_BGRA_NV = 0x886F;

	void copyImageSubDataNV(UInt srcName, Enum srcTarget, Int srcLevel, Int srcX, Int srcY,
			Int srcZ, UInt dstName, Enum dstTarget, Int dstLevel, Int dstX,
			Int dstY, Int dstZ, Sizei width, Sizei height, Sizei depth);

	enum MAX_DEEP_3D_TEXTURE_WIDTH_HEIGHT_NV = 0x90D0;
	enum MAX_DEEP_3D_TEXTURE_DEPTH_NV = 0x90D1;

	enum DEPTH_COMPONENT32F_NV = 0x8DAB;
	enum DEPTH32F_STENCIL8_NV = 0x8DAC;
	enum FLOAT_32_UNSIGNED_INT_24_8_REV_NV = 0x8DAD;
	enum DEPTH_BUFFER_FLOAT_MODE_NV = 0x8DAF;
	void depthRangedNV(Double zNear, Double zFar);
	void clearDepthdNV(Double depth);
	void depthBoundsdNV(Double zmin, Double zmax);

	enum DEPTH_CLAMP_NV = 0x864F;

	void drawTextureNV(UInt texture, UInt sampler, Float x0, Float y0,
			Float x1, Float y1, Float z, Float s0, Float t0, Float s1, Float t1);

	alias GLVULKANPROCNV = void function();
	void drawVkImageNV(GLuint64 vkImage, UInt sampler, Float x0, Float y0,
			Float x1, Float y1, Float z, Float s0, Float t0, Float s1, Float t1);
	GLVULKANPROCNV getVkProcAddrNV(const(Char)* name);
	void waitVkSemaphoreNV(GLuint64 vkSemaphore);
	void signalVkSemaphoreNV(GLuint64 vkSemaphore);
	void signalVkFenceNV(GLuint64 vkFence);

	enum EVAL_2D_NV = 0x86C0;
	enum EVAL_TRIANGULAR_2D_NV = 0x86C1;
	enum MAP_TESSELLATION_NV = 0x86C2;
	enum MAP_ATTRIB_U_ORDER_NV = 0x86C3;
	enum MAP_ATTRIB_V_ORDER_NV = 0x86C4;
	enum EVAL_FRACTIONAL_TESSELLATION_NV = 0x86C5;
	enum EVAL_VERTEX_ATTRIB0_NV = 0x86C6;
	enum EVAL_VERTEX_ATTRIB1_NV = 0x86C7;
	enum EVAL_VERTEX_ATTRIB2_NV = 0x86C8;
	enum EVAL_VERTEX_ATTRIB3_NV = 0x86C9;
	enum EVAL_VERTEX_ATTRIB4_NV = 0x86CA;
	enum EVAL_VERTEX_ATTRIB5_NV = 0x86CB;
	enum EVAL_VERTEX_ATTRIB6_NV = 0x86CC;
	enum EVAL_VERTEX_ATTRIB7_NV = 0x86CD;
	enum EVAL_VERTEX_ATTRIB8_NV = 0x86CE;
	enum EVAL_VERTEX_ATTRIB9_NV = 0x86CF;
	enum EVAL_VERTEX_ATTRIB10_NV = 0x86D0;
	enum EVAL_VERTEX_ATTRIB11_NV = 0x86D1;
	enum EVAL_VERTEX_ATTRIB12_NV = 0x86D2;
	enum EVAL_VERTEX_ATTRIB13_NV = 0x86D3;
	enum EVAL_VERTEX_ATTRIB14_NV = 0x86D4;
	enum EVAL_VERTEX_ATTRIB15_NV = 0x86D5;
	enum MAX_MAP_TESSELLATION_NV = 0x86D6;
	enum MAX_RATIONAL_EVAL_ORDER_NV = 0x86D7;
	void mapControlPointsNV(Enum target, UInt index, Enum type, Sizei ustride,
			Sizei vstride, Int uorder, Int vorder, Boolean packed, const(void)* points);
	void mapParameterivNV(Enum target, Enum pname, const(Int)* params);
	void mapParameterfvNV(Enum target, Enum pname, const(Float)* params);
	void getMapControlPointsNV(Enum target, UInt index, Enum type,
			Sizei ustride, Sizei vstride, Boolean packed, void* points);
	void getMapParameterivNV(Enum target, Enum pname, Int* params);
	void getMapParameterfvNV(Enum target, Enum pname, Float* params);
	void getMapAttribParameterivNV(Enum target, UInt index, Enum pname, Int* params);
	void getMapAttribParameterfvNV(Enum target, UInt index, Enum pname, Float* params);
	void evalMapsNV(Enum target, Enum mode);

	enum SAMPLE_POSITION_NV = 0x8E50;
	enum SAMPLE_MASK_NV = 0x8E51;
	enum SAMPLE_MASK_VALUE_NV = 0x8E52;
	enum TEXTURE_BINDING_RENDERBUFFER_NV = 0x8E53;
	enum TEXTURE_RENDERBUFFER_DATA_STORE_BINDING_NV = 0x8E54;
	enum TEXTURE_RENDERBUFFER_NV = 0x8E55;
	enum SAMPLER_RENDERBUFFER_NV = 0x8E56;
	enum INT_SAMPLER_RENDERBUFFER_NV = 0x8E57;
	enum UNSIGNED_INT_SAMPLER_RENDERBUFFER_NV = 0x8E58;
	enum MAX_SAMPLE_MASK_WORDS_NV = 0x8E59;
	void getMultisamplefvNV(Enum pname, UInt index, Float* val);
	void sampleMaskIndexedNV(UInt index, Bitfield mask);
	void texRenderbufferNV(Enum target, UInt renderbuffer);

	enum ALL_COMPLETED_NV = 0x84F2;
	enum FENCE_STATUS_NV = 0x84F3;
	enum FENCE_CONDITION_NV = 0x84F4;
	void deleteFencesNV(Sizei n, const(UInt)* fences);
	void genFencesNV(Sizei n, UInt* fences);
	Boolean isFenceNV(UInt fence);
	Boolean testFenceNV(UInt fence);
	void getFenceivNV(UInt fence, Enum pname, Int* params);
	void finishFenceNV(UInt fence);
	void setFenceNV(UInt fence, Enum condition);

	enum FILL_RECTANGLE_NV = 0x933C;

	enum FLOAT_R_NV = 0x8880;
	enum FLOAT_RG_NV = 0x8881;
	enum FLOAT_RGB_NV = 0x8882;
	enum FLOAT_RGBA_NV = 0x8883;
	enum FLOAT_R16_NV = 0x8884;
	enum FLOAT_R32_NV = 0x8885;
	enum FLOAT_RG16_NV = 0x8886;
	enum FLOAT_RG32_NV = 0x8887;
	enum FLOAT_RGB16_NV = 0x8888;
	enum FLOAT_RGB32_NV = 0x8889;
	enum FLOAT_RGBA16_NV = 0x888A;
	enum FLOAT_RGBA32_NV = 0x888B;
	enum TEXTURE_FLOAT_COMPONENTS_NV = 0x888C;
	enum FLOAT_CLEAR_COLOR_VALUE_NV = 0x888D;
	enum FLOAT_RGBA_MODE_NV = 0x888E;

	enum FOG_DISTANCE_MODE_NV = 0x855A;
	enum EYE_RADIAL_NV = 0x855B;
	enum EYE_PLANE_ABSOLUTE_NV = 0x855C;

	enum FRAGMENT_COVERAGE_TO_COLOR_NV = 0x92DD;
	enum FRAGMENT_COVERAGE_COLOR_NV = 0x92DE;
	void fragmentCoverageColorNV(UInt color);

	enum MAX_FRAGMENT_PROGRAM_LOCAL_PARAMETERS_NV = 0x8868;
	enum FRAGMENT_PROGRAM_NV = 0x8870;
	enum MAX_TEXTURE_COORDS_NV = 0x8871;
	enum MAX_TEXTURE_IMAGE_UNITS_NV = 0x8872;
	enum FRAGMENT_PROGRAM_BINDING_NV = 0x8873;
	enum PROGRAM_ERROR_STRING_NV = 0x8874;
	void programNamedParameter4fNV(UInt id, Sizei len, const(UByte)* name,
			Float x, Float y, Float z, Float w);
	void programNamedParameter4fvNV(UInt id, Sizei len,
			const(UByte)* name, const(Float)* v);
	void programNamedParameter4dNV(UInt id, Sizei len, const(UByte)* name,
			Double x, Double y, Double z, Double w);
	void programNamedParameter4dvNV(UInt id, Sizei len,
			const(UByte)* name, const(Double)* v);
	void getProgramNamedParameterfvNV(UInt id, Sizei len,
			const(UByte)* name, Float* params);
	void getProgramNamedParameterdvNV(UInt id, Sizei len,
			const(UByte)* name, Double* params);

	enum MAX_PROGRAM_EXEC_INSTRUCTIONS_NV = 0x88F4;
	enum MAX_PROGRAM_CALL_DEPTH_NV = 0x88F5;
	enum MAX_PROGRAM_IF_DEPTH_NV = 0x88F6;
	enum MAX_PROGRAM_LOOP_DEPTH_NV = 0x88F7;
	enum MAX_PROGRAM_LOOP_COUNT_NV = 0x88F8;

	enum COVERAGE_MODULATION_TABLE_NV = 0x9331;
	enum COLOR_SAMPLES_NV = 0x8E20;
	enum DEPTH_SAMPLES_NV = 0x932D;
	enum STENCIL_SAMPLES_NV = 0x932E;
	enum MIXED_DEPTH_SAMPLES_SUPPORTED_NV = 0x932F;
	enum MIXED_STENCIL_SAMPLES_SUPPORTED_NV = 0x9330;
	enum COVERAGE_MODULATION_NV = 0x9332;
	enum COVERAGE_MODULATION_TABLE_SIZE_NV = 0x9333;
	void coverageModulationTableNV(Sizei n, const(Float)* v);
	void getCoverageModulationTableNV(Sizei bufsize, Float* v);
	void coverageModulationNV(Enum components);

	enum RENDERBUFFER_COVERAGE_SAMPLES_NV = 0x8CAB;
	enum RENDERBUFFER_COLOR_SAMPLES_NV = 0x8E10;
	enum MAX_MULTISAMPLE_COVERAGE_MODES_NV = 0x8E11;
	enum MULTISAMPLE_COVERAGE_MODES_NV = 0x8E12;
	void renderbufferStorageMultisampleCoverageNV(Enum target, Sizei coverageSamples,
			Sizei colorSamples, Enum internalformat, Sizei width, Sizei height);

	enum GEOMETRY_PROGRAM_NV = 0x8C26;
	enum MAX_PROGRAM_OUTPUT_VERTICES_NV = 0x8C27;
	enum MAX_PROGRAM_TOTAL_OUTPUT_COMPONENTS_NV = 0x8C28;
	void programVertexLimitNV(Enum target, Int limit);
	void framebufferTextureEXT(Enum target, Enum attachment, UInt texture, Int level);
	void framebufferTextureFaceEXT(Enum target, Enum attachment,
			UInt texture, Int level, Enum face);

	enum PER_GPU_STORAGE_BIT_NV = 0x0800;
	enum MULTICAST_GPUS_NV = 0x92BA;
	enum RENDER_GPU_MASK_NV = 0x9558;
	enum PER_GPU_STORAGE_NV = 0x9548;
	enum MULTICAST_PROGRAMMABLE_SAMPLE_LOCATION_NV = 0x9549;
	void renderGpuMaskNV(Bitfield mask);
	void multicastBufferSubDataNV(Bitfield gpuMask, UInt buffer,
			Intptr offset, Sizeiptr size, const(void)* data);
	void multicastCopyBufferSubDataNV(UInt readGpu, Bitfield writeGpuMask, UInt readBuffer,
			UInt writeBuffer, Intptr readOffset, Intptr writeOffset, Sizeiptr size);
	void multicastCopyImageSubDataNV(UInt srcGpu, Bitfield dstGpuMask, UInt srcName, Enum srcTarget,
			Int srcLevel, Int srcX, Int srcY, Int srcZ, UInt dstName, Enum dstTarget,
			Int dstLevel, Int dstX, Int dstY, Int dstZ, Sizei srcWidth,
			Sizei srcHeight, Sizei srcDepth);
	void multicastBlitFramebufferNV(UInt srcGpu, UInt dstGpu, Int srcX0, Int srcY0,
			Int srcX1, Int srcY1, Int dstX0, Int dstY0, Int dstX1,
			Int dstY1, Bitfield mask, Enum filter);
	void multicastFramebufferSampleLocationsfvNV(UInt gpu, UInt framebuffer,
			UInt start, Sizei count, const(Float)* v);
	void multicastBarrierNV();
	void multicastWaitSyncNV(UInt signalGpu, Bitfield waitGpuMask);
	void multicastGetQueryObjectivNV(UInt gpu, UInt id, Enum pname, Int* params);
	void multicastGetQueryObjectuivNV(UInt gpu, UInt id, Enum pname, UInt* params);
	void multicastGetQueryObjecti64vNV(UInt gpu, UInt id, Enum pname, GLint64* params);
	void multicastGetQueryObjectui64vNV(UInt gpu, UInt id, Enum pname, GLuint64* params);

	enum MIN_PROGRAM_TEXEL_OFFSET_NV = 0x8904;
	enum MAX_PROGRAM_TEXEL_OFFSET_NV = 0x8905;
	enum PROGRAM_ATTRIB_COMPONENTS_NV = 0x8906;
	enum PROGRAM_RESULT_COMPONENTS_NV = 0x8907;
	enum MAX_PROGRAM_ATTRIB_COMPONENTS_NV = 0x8908;
	enum MAX_PROGRAM_RESULT_COMPONENTS_NV = 0x8909;
	enum MAX_PROGRAM_GENERIC_ATTRIBS_NV = 0x8DA5;
	enum MAX_PROGRAM_GENERIC_RESULTS_NV = 0x8DA6;
	void programLocalParameterI4iNV(Enum target, UInt index, Int x, Int y, Int z, Int w);
	void programLocalParameterI4ivNV(Enum target, UInt index, const(Int)* params);
	void programLocalParametersI4ivNV(Enum target, UInt index, Sizei count,
			const(Int)* params);
	void programLocalParameterI4UiNV(Enum target, UInt index, UInt x,
			UInt y, UInt z, UInt w);
	void programLocalParameterI4UivNV(Enum target, UInt index, const(UInt)* params);
	void programLocalParametersI4UivNV(Enum target, UInt index, Sizei count,
			const(UInt)* params);
	void programEnvParameterI4iNV(Enum target, UInt index, Int x, Int y, Int z, Int w);
	void programEnvParameterI4ivNV(Enum target, UInt index, const(Int)* params);
	void programEnvParametersI4ivNV(Enum target, UInt index, Sizei count,
			const(Int)* params);
	void programEnvParameterI4UiNV(Enum target, UInt index, UInt x,
			UInt y, UInt z, UInt w);
	void programEnvParameterI4UivNV(Enum target, UInt index, const(UInt)* params);
	void programEnvParametersI4UivNV(Enum target, UInt index, Sizei count,
			const(UInt)* params);
	void getProgramLocalParameterIivNV(Enum target, UInt index, Int* params);
	void getProgramLocalParameterIuivNV(Enum target, UInt index, UInt* params);
	void getProgramEnvParameterIivNV(Enum target, UInt index, Int* params);
	void getProgramEnvParameterIuivNV(Enum target, UInt index, UInt* params);

	enum MAX_GEOMETRY_PROGRAM_INVOCATIONS_NV = 0x8E5A;
	enum MIN_FRAGMENT_INTERPOLATION_OFFSET_NV = 0x8E5B;
	enum MAX_FRAGMENT_INTERPOLATION_OFFSET_NV = 0x8E5C;
	enum FRAGMENT_PROGRAM_INTERPOLATION_OFFSET_BITS_NV = 0x8E5D;
	enum MIN_PROGRAM_TEXTURE_GATHER_OFFSET_NV = 0x8E5E;
	enum MAX_PROGRAM_TEXTURE_GATHER_OFFSET_NV = 0x8E5F;
	enum MAX_PROGRAM_SUBROUTINE_PARAMETERS_NV = 0x8F44;
	enum MAX_PROGRAM_SUBROUTINE_NUM_NV = 0x8F45;
	void programSubroutineParametersuivNV(Enum target, Sizei count, const(UInt)* params);
	void getProgramSubroutineParameteruivNV(Enum target, UInt index, UInt* param);

	alias GLhalfNV = ushort;
	enum HALF_FLOAT_NV = 0x140B;
	void vertex2hNV(GLhalfNV x, GLhalfNV y);
	void vertex2hvNV(const(GLhalfNV)* v);
	void vertex3hNV(GLhalfNV x, GLhalfNV y, GLhalfNV z);
	void vertex3hvNV(const(GLhalfNV)* v);
	void vertex4hNV(GLhalfNV x, GLhalfNV y, GLhalfNV z, GLhalfNV w);
	void vertex4hvNV(const(GLhalfNV)* v);
	void normal3hNV(GLhalfNV nx, GLhalfNV ny, GLhalfNV nz);
	void normal3hvNV(const(GLhalfNV)* v);
	void color3hNV(GLhalfNV red, GLhalfNV green, GLhalfNV blue);
	void color3hvNV(const(GLhalfNV)* v);
	void color4hNV(GLhalfNV red, GLhalfNV green, GLhalfNV blue, GLhalfNV alpha);
	void color4hvNV(const(GLhalfNV)* v);
	void texCoord1hNV(GLhalfNV s);
	void texCoord1hvNV(const(GLhalfNV)* v);
	void texCoord2hNV(GLhalfNV s, GLhalfNV t);
	void texCoord2hvNV(const(GLhalfNV)* v);
	void texCoord3hNV(GLhalfNV s, GLhalfNV t, GLhalfNV r);
	void texCoord3hvNV(const(GLhalfNV)* v);
	void texCoord4hNV(GLhalfNV s, GLhalfNV t, GLhalfNV r, GLhalfNV q);
	void texCoord4hvNV(const(GLhalfNV)* v);
	void multiTexCoord1hNV(Enum target, GLhalfNV s);
	void multiTexCoord1hvNV(Enum target, const(GLhalfNV)* v);
	void multiTexCoord2hNV(Enum target, GLhalfNV s, GLhalfNV t);
	void multiTexCoord2hvNV(Enum target, const(GLhalfNV)* v);
	void multiTexCoord3hNV(Enum target, GLhalfNV s, GLhalfNV t, GLhalfNV r);
	void multiTexCoord3hvNV(Enum target, const(GLhalfNV)* v);
	void multiTexCoord4hNV(Enum target, GLhalfNV s, GLhalfNV t, GLhalfNV r, GLhalfNV q);
	void multiTexCoord4hvNV(Enum target, const(GLhalfNV)* v);
	void fogCoordhNV(GLhalfNV fog);
	void fogCoordhvNV(const(GLhalfNV)* fog);
	void secondaryColor3hNV(GLhalfNV red, GLhalfNV green, GLhalfNV blue);
	void secondaryColor3hvNV(const(GLhalfNV)* v);
	void vertexWeighthNV(GLhalfNV weight);
	void vertexWeighthvNV(const(GLhalfNV)* weight);
	void vertexAttrib1hNV(UInt index, GLhalfNV x);
	void vertexAttrib1hvNV(UInt index, const(GLhalfNV)* v);
	void vertexAttrib2hNV(UInt index, GLhalfNV x, GLhalfNV y);
	void vertexAttrib2hvNV(UInt index, const(GLhalfNV)* v);
	void vertexAttrib3hNV(UInt index, GLhalfNV x, GLhalfNV y, GLhalfNV z);
	void vertexAttrib3hvNV(UInt index, const(GLhalfNV)* v);
	void vertexAttrib4hNV(UInt index, GLhalfNV x, GLhalfNV y, GLhalfNV z, GLhalfNV w);
	void vertexAttrib4hvNV(UInt index, const(GLhalfNV)* v);
	void vertexAttribs1hvNV(UInt index, Sizei n, const(GLhalfNV)* v);
	void vertexAttribs2hvNV(UInt index, Sizei n, const(GLhalfNV)* v);
	void vertexAttribs3hvNV(UInt index, Sizei n, const(GLhalfNV)* v);
	void vertexAttribs4hvNV(UInt index, Sizei n, const(GLhalfNV)* v);

	enum MULTISAMPLES_NV = 0x9371;
	enum SUPERSAMPLE_SCALE_X_NV = 0x9372;
	enum SUPERSAMPLE_SCALE_Y_NV = 0x9373;
	enum CONFORMANT_NV = 0x9374;
	void getInternalformatSampleivNV(Enum target, Enum internalformat,
			Sizei samples, Enum pname, Sizei bufSize, Int* params);

	enum MAX_SHININESS_NV = 0x8504;
	enum MAX_SPOT_EXPONENT_NV = 0x8505;

	enum ATTACHED_MEMORY_OBJECT_NV = 0x95A4;
	enum ATTACHED_MEMORY_OFFSET_NV = 0x95A5;
	enum MEMORY_ATTACHABLE_ALIGNMENT_NV = 0x95A6;
	enum MEMORY_ATTACHABLE_SIZE_NV = 0x95A7;
	enum MEMORY_ATTACHABLE_NV = 0x95A8;
	enum DETACHED_MEMORY_INCARNATION_NV = 0x95A9;
	enum DETACHED_TEXTURES_NV = 0x95AA;
	enum DETACHED_BUFFERS_NV = 0x95AB;
	enum MAX_DETACHED_TEXTURES_NV = 0x95AC;
	enum MAX_DETACHED_BUFFERS_NV = 0x95AD;
	void getMemoryObjectDetachedResourcesuivNV(UInt memory, Enum pname,
			Int first, Sizei count, UInt* params);
	void resetMemoryObjectParameterNV(UInt memory, Enum pname);
	void texAttachMemoryNV(Enum target, UInt memory, GLuint64 offset);
	void bufferAttachMemoryNV(Enum target, UInt memory, GLuint64 offset);
	void textureAttachMemoryNV(UInt texture, UInt memory, GLuint64 offset);
	void namedBufferAttachMemoryNV(UInt buffer, UInt memory, GLuint64 offset);

	enum MESH_SHADER_NV = 0x9559;
	enum TASK_SHADER_NV = 0x955A;
	enum MAX_MESH_UNIFORM_BLOCKS_NV = 0x8E60;
	enum MAX_MESH_TEXTURE_IMAGE_UNITS_NV = 0x8E61;
	enum MAX_MESH_IMAGE_UNIFORMS_NV = 0x8E62;
	enum MAX_MESH_UNIFORM_COMPONENTS_NV = 0x8E63;
	enum MAX_MESH_ATOMIC_COUNTER_BUFFERS_NV = 0x8E64;
	enum MAX_MESH_ATOMIC_COUNTERS_NV = 0x8E65;
	enum MAX_MESH_SHADER_STORAGE_BLOCKS_NV = 0x8E66;
	enum MAX_COMBINED_MESH_UNIFORM_COMPONENTS_NV = 0x8E67;
	enum MAX_TASK_UNIFORM_BLOCKS_NV = 0x8E68;
	enum MAX_TASK_TEXTURE_IMAGE_UNITS_NV = 0x8E69;
	enum MAX_TASK_IMAGE_UNIFORMS_NV = 0x8E6A;
	enum MAX_TASK_UNIFORM_COMPONENTS_NV = 0x8E6B;
	enum MAX_TASK_ATOMIC_COUNTER_BUFFERS_NV = 0x8E6C;
	enum MAX_TASK_ATOMIC_COUNTERS_NV = 0x8E6D;
	enum MAX_TASK_SHADER_STORAGE_BLOCKS_NV = 0x8E6E;
	enum MAX_COMBINED_TASK_UNIFORM_COMPONENTS_NV = 0x8E6F;
	enum MAX_MESH_WORK_GROUP_INVOCATIONS_NV = 0x95A2;
	enum MAX_TASK_WORK_GROUP_INVOCATIONS_NV = 0x95A3;
	enum MAX_MESH_TOTAL_MEMORY_SIZE_NV = 0x9536;
	enum MAX_TASK_TOTAL_MEMORY_SIZE_NV = 0x9537;
	enum MAX_MESH_OUTPUT_VERTICES_NV = 0x9538;
	enum MAX_MESH_OUTPUT_PRIMITIVES_NV = 0x9539;
	enum MAX_TASK_OUTPUT_COUNT_NV = 0x953A;
	enum MAX_DRAW_MESH_TASKS_COUNT_NV = 0x953D;
	enum MAX_MESH_VIEWS_NV = 0x9557;
	enum MESH_OUTPUT_PER_VERTEX_GRANULARITY_NV = 0x92DF;
	enum MESH_OUTPUT_PER_PRIMITIVE_GRANULARITY_NV = 0x9543;
	enum MAX_MESH_WORK_GROUP_SIZE_NV = 0x953B;
	enum MAX_TASK_WORK_GROUP_SIZE_NV = 0x953C;
	enum MESH_WORK_GROUP_SIZE_NV = 0x953E;
	enum TASK_WORK_GROUP_SIZE_NV = 0x953F;
	enum MESH_VERTICES_OUT_NV = 0x9579;
	enum MESH_PRIMITIVES_OUT_NV = 0x957A;
	enum MESH_OUTPUT_TYPE_NV = 0x957B;
	enum UNIFORM_BLOCK_REFERENCED_BY_MESH_SHADER_NV = 0x959C;
	enum UNIFORM_BLOCK_REFERENCED_BY_TASK_SHADER_NV = 0x959D;
	enum REFERENCED_BY_MESH_SHADER_NV = 0x95A0;
	enum REFERENCED_BY_TASK_SHADER_NV = 0x95A1;
	enum MESH_SHADER_BIT_NV = 0x00000040;
	enum TASK_SHADER_BIT_NV = 0x00000080;
	enum MESH_SUBROUTINE_NV = 0x957C;
	enum TASK_SUBROUTINE_NV = 0x957D;
	enum MESH_SUBROUTINE_UNIFORM_NV = 0x957E;
	enum TASK_SUBROUTINE_UNIFORM_NV = 0x957F;
	enum ATOMIC_COUNTER_BUFFER_REFERENCED_BY_MESH_SHADER_NV = 0x959E;
	enum ATOMIC_COUNTER_BUFFER_REFERENCED_BY_TASK_SHADER_NV = 0x959F;
	void drawMeshTasksNV(UInt first, UInt count);
	void drawMeshTasksIndirectNV(Intptr indirect);
	void multiDrawMeshTasksIndirectNV(Intptr indirect, Sizei drawcount, Sizei stride);
	void multiDrawMeshTasksIndirectCountNV(Intptr indirect, Intptr drawcount,
			Sizei maxdrawcount, Sizei stride);

	enum MULTISAMPLE_FILTER_HINT_NV = 0x8534;

	enum PIXEL_COUNTER_BITS_NV = 0x8864;
	enum CURRENT_OCCLUSION_QUERY_ID_NV = 0x8865;
	enum PIXEL_COUNT_NV = 0x8866;
	enum PIXEL_COUNT_AVAILABLE_NV = 0x8867;
	void genOcclusionQueriesNV(Sizei n, UInt* ids);
	void deleteOcclusionQueriesNV(Sizei n, const(UInt)* ids);
	Boolean isOcclusionQueryNV(UInt id);
	void beginOcclusionQueryNV(UInt id);
	void endOcclusionQueryNV();
	void getOcclusionQueryivNV(UInt id, Enum pname, Int* params);
	void getOcclusionQueryuivNV(UInt id, Enum pname, UInt* params);

	enum DEPTH_STENCIL_NV = 0x84F9;
	enum UNSIGNED_INT_24_8_NV = 0x84FA;

	enum MAX_PROGRAM_PARAMETER_BUFFER_BINDINGS_NV = 0x8DA0;
	enum MAX_PROGRAM_PARAMETER_BUFFER_SIZE_NV = 0x8DA1;
	enum VERTEX_PROGRAM_PARAMETER_BUFFER_NV = 0x8DA2;
	enum GEOMETRY_PROGRAM_PARAMETER_BUFFER_NV = 0x8DA3;
	enum FRAGMENT_PROGRAM_PARAMETER_BUFFER_NV = 0x8DA4;
	void programBufferParametersfvNV(Enum target, UInt bindingIndex,
			UInt wordIndex, Sizei count, const(Float)* params);
	void programBufferParametersIivNV(Enum target, UInt bindingIndex,
			UInt wordIndex, Sizei count, const(Int)* params);
	void programBufferParametersIuivNV(Enum target, UInt bindingIndex,
			UInt wordIndex, Sizei count, const(UInt)* params);

	enum PATH_FORMAT_SVG_NV = 0x9070;
	enum PATH_FORMAT_PS_NV = 0x9071;
	enum STANDARD_FONT_NAME_NV = 0x9072;
	enum SYSTEM_FONT_NAME_NV = 0x9073;
	enum FILE_NAME_NV = 0x9074;
	enum PATH_STROKE_WIDTH_NV = 0x9075;
	enum PATH_END_CAPS_NV = 0x9076;
	enum PATH_INITIAL_END_CAP_NV = 0x9077;
	enum PATH_TERMINAL_END_CAP_NV = 0x9078;
	enum PATH_JOIN_STYLE_NV = 0x9079;
	enum PATH_MITER_LIMIT_NV = 0x907A;
	enum PATH_DASH_CAPS_NV = 0x907B;
	enum PATH_INITIAL_DASH_CAP_NV = 0x907C;
	enum PATH_TERMINAL_DASH_CAP_NV = 0x907D;
	enum PATH_DASH_OFFSET_NV = 0x907E;
	enum PATH_CLIENT_LENGTH_NV = 0x907F;
	enum PATH_FILL_MODE_NV = 0x9080;
	enum PATH_FILL_MASK_NV = 0x9081;
	enum PATH_FILL_COVER_MODE_NV = 0x9082;
	enum PATH_STROKE_COVER_MODE_NV = 0x9083;
	enum PATH_STROKE_MASK_NV = 0x9084;
	enum COUNT_UP_NV = 0x9088;
	enum COUNT_DOWN_NV = 0x9089;
	enum PATH_OBJECT_BOUNDING_BOX_NV = 0x908A;
	enum CONVEX_HULL_NV = 0x908B;
	enum BOUNDING_BOX_NV = 0x908D;
	enum TRANSLATE_X_NV = 0x908E;
	enum TRANSLATE_Y_NV = 0x908F;
	enum TRANSLATE_2D_NV = 0x9090;
	enum TRANSLATE_3D_NV = 0x9091;
	enum AFFINE_2D_NV = 0x9092;
	enum AFFINE_3D_NV = 0x9094;
	enum TRANSPOSE_AFFINE_2D_NV = 0x9096;
	enum TRANSPOSE_AFFINE_3D_NV = 0x9098;
	enum UTF8_NV = 0x909A;
	enum UTF16_NV = 0x909B;
	enum BOUNDING_BOX_OF_BOUNDING_BOXES_NV = 0x909C;
	enum PATH_COMMAND_COUNT_NV = 0x909D;
	enum PATH_COORD_COUNT_NV = 0x909E;
	enum PATH_DASH_ARRAY_COUNT_NV = 0x909F;
	enum PATH_COMPUTED_LENGTH_NV = 0x90A0;
	enum PATH_FILL_BOUNDING_BOX_NV = 0x90A1;
	enum PATH_STROKE_BOUNDING_BOX_NV = 0x90A2;
	enum SQUARE_NV = 0x90A3;
	enum ROUND_NV = 0x90A4;
	enum TRIANGULAR_NV = 0x90A5;
	enum BEVEL_NV = 0x90A6;
	enum MITER_REVERT_NV = 0x90A7;
	enum MITER_TRUNCATE_NV = 0x90A8;
	enum SKIP_MISSING_GLYPH_NV = 0x90A9;
	enum USE_MISSING_GLYPH_NV = 0x90AA;
	enum PATH_ERROR_POSITION_NV = 0x90AB;
	enum ACCUM_ADJACENT_PAIRS_NV = 0x90AD;
	enum ADJACENT_PAIRS_NV = 0x90AE;
	enum FIRST_TO_REST_NV = 0x90AF;
	enum PATH_GEN_MODE_NV = 0x90B0;
	enum PATH_GEN_COEFF_NV = 0x90B1;
	enum PATH_GEN_COMPONENTS_NV = 0x90B3;
	enum PATH_STENCIL_FUNC_NV = 0x90B7;
	enum PATH_STENCIL_REF_NV = 0x90B8;
	enum PATH_STENCIL_VALUE_MASK_NV = 0x90B9;
	enum PATH_STENCIL_DEPTH_OFFSET_FACTOR_NV = 0x90BD;
	enum PATH_STENCIL_DEPTH_OFFSET_UNITS_NV = 0x90BE;
	enum PATH_COVER_DEPTH_FUNC_NV = 0x90BF;
	enum PATH_DASH_OFFSET_RESET_NV = 0x90B4;
	enum MOVE_TO_RESETS_NV = 0x90B5;
	enum MOVE_TO_CONTINUES_NV = 0x90B6;
	enum CLOSE_PATH_NV = 0x00;
	enum MOVE_TO_NV = 0x02;
	enum RELATIVE_MOVE_TO_NV = 0x03;
	enum LINE_TO_NV = 0x04;
	enum RELATIVE_LINE_TO_NV = 0x05;
	enum HORIZONTAL_LINE_TO_NV = 0x06;
	enum RELATIVE_HORIZONTAL_LINE_TO_NV = 0x07;
	enum VERTICAL_LINE_TO_NV = 0x08;
	enum RELATIVE_VERTICAL_LINE_TO_NV = 0x09;
	enum QUADRATIC_CURVE_TO_NV = 0x0A;
	enum RELATIVE_QUADRATIC_CURVE_TO_NV = 0x0B;
	enum CUBIC_CURVE_TO_NV = 0x0C;
	enum RELATIVE_CUBIC_CURVE_TO_NV = 0x0D;
	enum SMOOTH_QUADRATIC_CURVE_TO_NV = 0x0E;
	enum RELATIVE_SMOOTH_QUADRATIC_CURVE_TO_NV = 0x0F;
	enum SMOOTH_CUBIC_CURVE_TO_NV = 0x10;
	enum RELATIVE_SMOOTH_CUBIC_CURVE_TO_NV = 0x11;
	enum SMALL_CCW_ARC_TO_NV = 0x12;
	enum RELATIVE_SMALL_CCW_ARC_TO_NV = 0x13;
	enum SMALL_CW_ARC_TO_NV = 0x14;
	enum RELATIVE_SMALL_CW_ARC_TO_NV = 0x15;
	enum LARGE_CCW_ARC_TO_NV = 0x16;
	enum RELATIVE_LARGE_CCW_ARC_TO_NV = 0x17;
	enum LARGE_CW_ARC_TO_NV = 0x18;
	enum RELATIVE_LARGE_CW_ARC_TO_NV = 0x19;
	enum RESTART_PATH_NV = 0xF0;
	enum DUP_FIRST_CUBIC_CURVE_TO_NV = 0xF2;
	enum DUP_LAST_CUBIC_CURVE_TO_NV = 0xF4;
	enum RECT_NV = 0xF6;
	enum CIRCULAR_CCW_ARC_TO_NV = 0xF8;
	enum CIRCULAR_CW_ARC_TO_NV = 0xFA;
	enum CIRCULAR_TANGENT_ARC_TO_NV = 0xFC;
	enum ARC_TO_NV = 0xFE;
	enum RELATIVE_ARC_TO_NV = 0xFF;
	enum BOLD_BIT_NV = 0x01;
	enum ITALIC_BIT_NV = 0x02;
	enum GLYPH_WIDTH_BIT_NV = 0x01;
	enum GLYPH_HEIGHT_BIT_NV = 0x02;
	enum GLYPH_HORIZONTAL_BEARING_X_BIT_NV = 0x04;
	enum GLYPH_HORIZONTAL_BEARING_Y_BIT_NV = 0x08;
	enum GLYPH_HORIZONTAL_BEARING_ADVANCE_BIT_NV = 0x10;
	enum GLYPH_VERTICAL_BEARING_X_BIT_NV = 0x20;
	enum GLYPH_VERTICAL_BEARING_Y_BIT_NV = 0x40;
	enum GLYPH_VERTICAL_BEARING_ADVANCE_BIT_NV = 0x80;
	enum GLYPH_HAS_KERNING_BIT_NV = 0x100;
	enum FONT_X_MIN_BOUNDS_BIT_NV = 0x00010000;
	enum FONT_Y_MIN_BOUNDS_BIT_NV = 0x00020000;
	enum FONT_X_MAX_BOUNDS_BIT_NV = 0x00040000;
	enum FONT_Y_MAX_BOUNDS_BIT_NV = 0x00080000;
	enum FONT_UNITS_PER_EM_BIT_NV = 0x00100000;
	enum FONT_ASCENDER_BIT_NV = 0x00200000;
	enum FONT_DESCENDER_BIT_NV = 0x00400000;
	enum FONT_HEIGHT_BIT_NV = 0x00800000;
	enum FONT_MAX_ADVANCE_WIDTH_BIT_NV = 0x01000000;
	enum FONT_MAX_ADVANCE_HEIGHT_BIT_NV = 0x02000000;
	enum FONT_UNDERLINE_POSITION_BIT_NV = 0x04000000;
	enum FONT_UNDERLINE_THICKNESS_BIT_NV = 0x08000000;
	enum FONT_HAS_KERNING_BIT_NV = 0x10000000;
	enum ROUNDED_RECT_NV = 0xE8;
	enum RELATIVE_ROUNDED_RECT_NV = 0xE9;
	enum ROUNDED_RECT2_NV = 0xEA;
	enum RELATIVE_ROUNDED_RECT2_NV = 0xEB;
	enum ROUNDED_RECT4_NV = 0xEC;
	enum RELATIVE_ROUNDED_RECT4_NV = 0xED;
	enum ROUNDED_RECT8_NV = 0xEE;
	enum RELATIVE_ROUNDED_RECT8_NV = 0xEF;
	enum RELATIVE_RECT_NV = 0xF7;
	enum FONT_GLYPHS_AVAILABLE_NV = 0x9368;
	enum FONT_TARGET_UNAVAILABLE_NV = 0x9369;
	enum FONT_UNAVAILABLE_NV = 0x936A;
	enum FONT_UNINTELLIGIBLE_NV = 0x936B;
	enum CONIC_CURVE_TO_NV = 0x1A;
	enum RELATIVE_CONIC_CURVE_TO_NV = 0x1B;
	enum FONT_NUM_GLYPH_INDICES_BIT_NV = 0x20000000;
	enum STANDARD_FONT_FORMAT_NV = 0x936C;
	enum GL_2_BYTES_NV = 0x1407;
	enum GL_3_BYTES_NV = 0x1408;
	enum GL_4_BYTES_NV = 0x1409;
	enum EYE_LINEAR_NV = 0x2400;
	enum OBJECT_LINEAR_NV = 0x2401;
	enum CONSTANT_NV = 0x8576;
	enum PATH_FOG_GEN_MODE_NV = 0x90AC;
	enum PRIMARY_COLOR_NV = 0x852C;
	enum SECONDARY_COLOR_NV = 0x852D;
	enum PATH_GEN_COLOR_FORMAT_NV = 0x90B2;
	enum PATH_PROJECTION_NV = 0x1701;
	enum PATH_MODELVIEW_NV = 0x1700;
	enum PATH_MODELVIEW_STACK_DEPTH_NV = 0x0BA3;
	enum PATH_MODELVIEW_MATRIX_NV = 0x0BA6;
	enum PATH_MAX_MODELVIEW_STACK_DEPTH_NV = 0x0D36;
	enum PATH_TRANSPOSE_MODELVIEW_MATRIX_NV = 0x84E3;
	enum PATH_PROJECTION_STACK_DEPTH_NV = 0x0BA4;
	enum PATH_PROJECTION_MATRIX_NV = 0x0BA7;
	enum PATH_MAX_PROJECTION_STACK_DEPTH_NV = 0x0D38;
	enum PATH_TRANSPOSE_PROJECTION_MATRIX_NV = 0x84E4;
	enum FRAGMENT_INPUT_NV = 0x936D;
	UInt genPathsNV(Sizei range);
	void deletePathsNV(UInt path, Sizei range);
	Boolean isPathNV(UInt path);
	void pathCommandsNV(UInt path, Sizei numCommands, const(UByte)* commands,
			Sizei numCoords, Enum coordType, const(void)* coords);
	void pathCoordsNV(UInt path, Sizei numCoords, Enum coordType, const(void)* coords);
	void pathSubCommandsNV(UInt path, Sizei commandStart, Sizei commandsToDelete, Sizei numCommands,
			const(UByte)* commands, Sizei numCoords, Enum coordType, const(void)* coords);
	void pathSubCoordsNV(UInt path, Sizei coordStart, Sizei numCoords,
			Enum coordType, const(void)* coords);
	void pathStringNV(UInt path, Enum format, Sizei length, const(void)* pathString);
	void pathGlyphsNV(UInt firstPathName, Enum fontTarget, const(void)* fontName, Bitfield fontStyle,
			Sizei numGlyphs, Enum type, const(void)* charcodes,
			Enum handleMissingGlyphs, UInt pathParameterTemplate, Float emScale);
	void pathGlyphRangeNV(UInt firstPathName, Enum fontTarget,
			const(void)* fontName, Bitfield fontStyle, UInt firstGlyph,
			Sizei numGlyphs, Enum handleMissingGlyphs,
			UInt pathParameterTemplate, Float emScale);
	void weightPathsNV(UInt resultPath, Sizei numPaths, const(UInt)* paths,
			const(Float)* weights);
	void copyPathNV(UInt resultPath, UInt srcPath);
	void interpolatePathsNV(UInt resultPath, UInt pathA, UInt pathB, Float weight);
	void transformPathNV(UInt resultPath, UInt srcPath, Enum transformType,
			const(Float)* transformValues);
	void pathParameterivNV(UInt path, Enum pname, const(Int)* value);
	void pathParameteriNV(UInt path, Enum pname, Int value);
	void pathParameterfvNV(UInt path, Enum pname, const(Float)* value);
	void pathParameterfNV(UInt path, Enum pname, Float value);
	void pathDashArrayNV(UInt path, Sizei dashCount, const(Float)* dashArray);
	void pathStencilFuncNV(Enum func, Int ref_, UInt mask);
	void pathStencilDepthOffsetNV(Float factor, Float units);
	void stencilFillPathNV(UInt path, Enum fillMode, UInt mask);
	void stencilStrokePathNV(UInt path, Int reference, UInt mask);
	void stencilFillPathInstancedNV(Sizei numPaths, Enum pathNameType, const(void)* paths, UInt pathBase,
			Enum fillMode, UInt mask, Enum transformType, const(Float)* transformValues);
	void stencilStrokePathInstancedNV(Sizei numPaths, Enum pathNameType, const(void)* paths, UInt pathBase,
			Int reference, UInt mask, Enum transformType, const(Float)* transformValues);
	void pathCoverDepthFuncNV(Enum func);
	void coverFillPathNV(UInt path, Enum coverMode);
	void coverStrokePathNV(UInt path, Enum coverMode);
	void coverFillPathInstancedNV(Sizei numPaths, Enum pathNameType, const(void)* paths,
			UInt pathBase, Enum coverMode, Enum transformType,
			const(Float)* transformValues);
	void coverStrokePathInstancedNV(Sizei numPaths, Enum pathNameType, const(void)* paths,
			UInt pathBase, Enum coverMode, Enum transformType,
			const(Float)* transformValues);
	void getPathParameterivNV(UInt path, Enum pname, Int* value);
	void getPathParameterfvNV(UInt path, Enum pname, Float* value);
	void getPathCommandsNV(UInt path, UByte* commands);
	void getPathCoordsNV(UInt path, Float* coords);
	void getPathDashArrayNV(UInt path, Float* dashArray);
	void getPathMetricsNV(Bitfield metricQueryMask, Sizei numPaths, Enum pathNameType,
			const(void)* paths, UInt pathBase, Sizei stride, Float* metrics);
	void getPathMetricRangeNV(Bitfield metricQueryMask, UInt firstPathName,
			Sizei numPaths, Sizei stride, Float* metrics);
	void getPathSpacingNV(Enum pathListMode, Sizei numPaths, Enum pathNameType, const(void)* paths, UInt pathBase,
			Float advanceScale, Float kerningScale, Enum transformType,
			Float* returnedSpacing);
	Boolean isPointInFillPathNV(UInt path, UInt mask, Float x, Float y);
	Boolean isPointInStrokePathNV(UInt path, Float x, Float y);
	Float getPathLengthNV(UInt path, Sizei startSegment, Sizei numSegments);
	Boolean pointAlongPathNV(UInt path, Sizei startSegment, Sizei numSegments,
			Float distance, Float* x, Float* y, Float* tangentX, Float* tangentY);
	void matrixLoad3x2fNV(Enum matrixMode, const(Float)* m);
	void matrixLoad3x3fNV(Enum matrixMode, const(Float)* m);
	void matrixLoadTranspose3x3fNV(Enum matrixMode, const(Float)* m);
	void matrixMult3x2fNV(Enum matrixMode, const(Float)* m);
	void matrixMult3x3fNV(Enum matrixMode, const(Float)* m);
	void matrixMultTranspose3x3fNV(Enum matrixMode, const(Float)* m);
	void stencilThenCoverFillPathNV(UInt path, Enum fillMode, UInt mask, Enum coverMode);
	void stencilThenCoverStrokePathNV(UInt path, Int reference, UInt mask, Enum coverMode);
	void stencilThenCoverFillPathInstancedNV(Sizei numPaths, Enum pathNameType, const(void)* paths, UInt pathBase,
			Enum fillMode, UInt mask, Enum coverMode, Enum transformType,
			const(Float)* transformValues);
	void stencilThenCoverStrokePathInstancedNV(Sizei numPaths, Enum pathNameType, const(void)* paths, UInt pathBase,
			Int reference, UInt mask, Enum coverMode, Enum transformType,
			const(Float)* transformValues);
	Enum pathGlyphIndexRangeNV(Enum fontTarget, const(void)* fontName, Bitfield fontStyle,
			UInt pathParameterTemplate, Float emScale, ref UInt[2] baseAndCount);
	Enum pathGlyphIndexArrayNV(UInt firstPathName, Enum fontTarget, const(void)* fontName, Bitfield fontStyle,
			UInt firstGlyphIndex, Sizei numGlyphs, UInt pathParameterTemplate, Float emScale);
	Enum pathMemoryGlyphIndexArrayNV(UInt firstPathName, Enum fontTarget,
			Sizeiptr fontSize, const(void)* fontData,
			Sizei faceIndex, UInt firstGlyphIndex, Sizei numGlyphs,
			UInt pathParameterTemplate, Float emScale);
	void programPathFragmentInputGenNV(UInt program, Int location,
			Enum genMode, Int components, const(Float)* coeffs);
	void getProgramResourcefvNV(UInt program, Enum programInterface, UInt index,
			Sizei propCount, const(Enum)* props, Sizei bufSize,
			Sizei* length, Float* params);
	void pathColorGenNV(Enum color, Enum genMode, Enum colorFormat, const(Float)* coeffs);
	void pathTexGenNV(Enum texCoordSet, Enum genMode, Int components, const(Float)* coeffs);
	void pathFogGenNV(Enum genMode);
	void getPathColorGenivNV(Enum color, Enum pname, Int* value);
	void getPathColorGenfvNV(Enum color, Enum pname, Float* value);
	void getPathTexGenivNV(Enum texCoordSet, Enum pname, Int* value);
	void getPathTexGenfvNV(Enum texCoordSet, Enum pname, Float* value);

	enum SHARED_EDGE_NV = 0xC0;

	enum WRITE_PIXEL_DATA_RANGE_NV = 0x8878;
	enum READ_PIXEL_DATA_RANGE_NV = 0x8879;
	enum WRITE_PIXEL_DATA_RANGE_LENGTH_NV = 0x887A;
	enum READ_PIXEL_DATA_RANGE_LENGTH_NV = 0x887B;
	enum WRITE_PIXEL_DATA_RANGE_POINTER_NV = 0x887C;
	enum READ_PIXEL_DATA_RANGE_POINTER_NV = 0x887D;
	void pixelDataRangeNV(Enum target, Sizei length, const(void)* pointer);
	void flushPixelDataRangeNV(Enum target);

	enum POINT_SPRITE_NV = 0x8861;
	enum COORD_REPLACE_NV = 0x8862;
	enum POINT_SPRITE_R_MODE_NV = 0x8863;
	void pointParameteriNV(Enum pname, Int param);
	void pointParameterivNV(Enum pname, const(Int)* params);

	enum FRAME_NV = 0x8E26;
	enum FIELDS_NV = 0x8E27;
	enum CURRENT_TIME_NV = 0x8E28;
	enum NUM_FILL_STREAMS_NV = 0x8E29;
	enum PRESENT_TIME_NV = 0x8E2A;
	enum PRESENT_DURATION_NV = 0x8E2B;
	void presentFrameKeyedNV(UInt video_slot, GLuint64EXT minPresentTime,
			UInt beginPresentTimeId, UInt presentDurationId,
			Enum type, Enum target0, UInt fill0, UInt key0, Enum target1,
			UInt fill1, UInt key1);
	void presentFrameDualFillNV(UInt video_slot, GLuint64EXT minPresentTime,
			UInt beginPresentTimeId, UInt presentDurationId,
			Enum type, Enum target0, UInt fill0, Enum target1, UInt fill1,
			Enum target2, UInt fill2, Enum target3, UInt fill3);
	void getVideoivNV(UInt video_slot, Enum pname, Int* params);
	void getVideouivNV(UInt video_slot, Enum pname, UInt* params);
	void getVideoi64vNV(UInt video_slot, Enum pname, GLint64EXT* params);
	void getVideoui64vNV(UInt video_slot, Enum pname, GLuint64EXT* params);

	enum PRIMITIVE_RESTART_NV = 0x8558;
	enum PRIMITIVE_RESTART_INDEX_NV = 0x8559;
	void primitiveRestartNV();
	void primitiveRestartIndexNV(UInt index);

	enum QUERY_RESOURCE_TYPE_VIDMEM_ALLOC_NV = 0x9540;
	enum QUERY_RESOURCE_MEMTYPE_VIDMEM_NV = 0x9542;
	enum QUERY_RESOURCE_SYS_RESERVED_NV = 0x9544;
	enum QUERY_RESOURCE_TEXTURE_NV = 0x9545;
	enum QUERY_RESOURCE_RENDERBUFFER_NV = 0x9546;
	enum QUERY_RESOURCE_BUFFEROBJECT_NV = 0x9547;
	Int queryResourceNV(Enum queryType, Int tagId, UInt bufSize, Int* buffer);

	void genQueryResourceTagNV(Sizei n, Int* tagIds);
	void deleteQueryResourceTagNV(Sizei n, const(Int)* tagIds);
	void queryResourceTagNV(Int tagId, const(Char)* tagString);

	enum REGISTER_COMBINERS_NV = 0x8522;
	enum VARIABLE_A_NV = 0x8523;
	enum VARIABLE_B_NV = 0x8524;
	enum VARIABLE_C_NV = 0x8525;
	enum VARIABLE_D_NV = 0x8526;
	enum VARIABLE_E_NV = 0x8527;
	enum VARIABLE_F_NV = 0x8528;
	enum VARIABLE_G_NV = 0x8529;
	enum CONSTANT_COLOR0_NV = 0x852A;
	enum CONSTANT_COLOR1_NV = 0x852B;
	enum SPARE0_NV = 0x852E;
	enum SPARE1_NV = 0x852F;
	enum DISCARD_NV = 0x8530;
	enum E_TIMES_F_NV = 0x8531;
	enum SPARE0_PLUS_SECONDARY_COLOR_NV = 0x8532;
	enum UNSIGNED_IDENTITY_NV = 0x8536;
	enum UNSIGNED_INVERT_NV = 0x8537;
	enum EXPAND_NORMAL_NV = 0x8538;
	enum EXPAND_NEGATE_NV = 0x8539;
	enum HALF_BIAS_NORMAL_NV = 0x853A;
	enum HALF_BIAS_NEGATE_NV = 0x853B;
	enum SIGNED_IDENTITY_NV = 0x853C;
	enum SIGNED_NEGATE_NV = 0x853D;
	enum SCALE_BY_TWO_NV = 0x853E;
	enum SCALE_BY_FOUR_NV = 0x853F;
	enum SCALE_BY_ONE_HALF_NV = 0x8540;
	enum BIAS_BY_NEGATIVE_ONE_HALF_NV = 0x8541;
	enum COMBINER_INPUT_NV = 0x8542;
	enum COMBINER_MAPPING_NV = 0x8543;
	enum COMBINER_COMPONENT_USAGE_NV = 0x8544;
	enum COMBINER_AB_DOT_PRODUCT_NV = 0x8545;
	enum COMBINER_CD_DOT_PRODUCT_NV = 0x8546;
	enum COMBINER_MUX_SUM_NV = 0x8547;
	enum COMBINER_SCALE_NV = 0x8548;
	enum COMBINER_BIAS_NV = 0x8549;
	enum COMBINER_AB_OUTPUT_NV = 0x854A;
	enum COMBINER_CD_OUTPUT_NV = 0x854B;
	enum COMBINER_SUM_OUTPUT_NV = 0x854C;
	enum MAX_GENERAL_COMBINERS_NV = 0x854D;
	enum NUM_GENERAL_COMBINERS_NV = 0x854E;
	enum COLOR_SUM_CLAMP_NV = 0x854F;
	enum COMBINER0_NV = 0x8550;
	enum COMBINER1_NV = 0x8551;
	enum COMBINER2_NV = 0x8552;
	enum COMBINER3_NV = 0x8553;
	enum COMBINER4_NV = 0x8554;
	enum COMBINER5_NV = 0x8555;
	enum COMBINER6_NV = 0x8556;
	enum COMBINER7_NV = 0x8557;
	void combinerParameterfvNV(Enum pname, const(Float)* params);
	void combinerParameterfNV(Enum pname, Float param);
	void combinerParameterivNV(Enum pname, const(Int)* params);
	void combinerParameteriNV(Enum pname, Int param);
	void combinerInputNV(Enum stage, Enum portion, Enum variable,
			Enum input, Enum mapping, Enum componentUsage);
	void combinerOutputNV(Enum stage, Enum portion, Enum abOutput, Enum cdOutput, Enum sumOutput, Enum scale,
			Enum bias, Boolean abDotProduct, Boolean cdDotProduct, Boolean muxSum);
	void finalCombinerInputNV(Enum variable, Enum input, Enum mapping, Enum componentUsage);
	void getCombinerInputParameterfvNV(Enum stage, Enum portion,
			Enum variable, Enum pname, Float* params);
	void getCombinerInputParameterivNV(Enum stage, Enum portion,
			Enum variable, Enum pname, Int* params);
	void getCombinerOutputParameterfvNV(Enum stage, Enum portion, Enum pname, Float* params);
	void getCombinerOutputParameterivNV(Enum stage, Enum portion, Enum pname, Int* params);
	void getFinalCombinerInputParameterfvNV(Enum variable, Enum pname, Float* params);
	void getFinalCombinerInputParameterivNV(Enum variable, Enum pname, Int* params);

	enum PER_STAGE_CONSTANTS_NV = 0x8535;
	void combinerStageParameterfvNV(Enum stage, Enum pname, const(Float)* params);
	void getCombinerStageParameterfvNV(Enum stage, Enum pname, Float* params);

	enum REPRESENTATIVE_FRAGMENT_TEST_NV = 0x937F;

	enum PURGED_CONTEXT_RESET_NV = 0x92BB;

	enum SAMPLE_LOCATION_SUBPIXEL_BITS_NV = 0x933D;
	enum SAMPLE_LOCATION_PIXEL_GRID_WIDTH_NV = 0x933E;
	enum SAMPLE_LOCATION_PIXEL_GRID_HEIGHT_NV = 0x933F;
	enum PROGRAMMABLE_SAMPLE_LOCATION_TABLE_SIZE_NV = 0x9340;
	enum SAMPLE_LOCATION_NV = 0x8E50;
	enum PROGRAMMABLE_SAMPLE_LOCATION_NV = 0x9341;
	enum FRAMEBUFFER_PROGRAMMABLE_SAMPLE_LOCATIONS_NV = 0x9342;
	enum FRAMEBUFFER_SAMPLE_LOCATION_PIXEL_GRID_NV = 0x9343;
	void framebufferSampleLocationsfvNV(Enum target, UInt start,
			Sizei count, const(Float)* v);
	void namedFramebufferSampleLocationsfvNV(UInt framebuffer, UInt start,
			Sizei count, const(Float)* v);
	void resolveDepthValuesNV();

	enum SCISSOR_TEST_EXCLUSIVE_NV = 0x9555;
	enum SCISSOR_BOX_EXCLUSIVE_NV = 0x9556;
	void scissorExclusiveNV(Int x, Int y, Sizei width, Sizei height);
	void scissorExclusiveArrayvNV(UInt first, Sizei count, const(Int)* v);

	enum BUFFER_GPU_ADDRESS_NV = 0x8F1D;
	enum GPU_ADDRESS_NV = 0x8F34;
	enum MAX_SHADER_BUFFER_ADDRESS_NV = 0x8F35;
	void makeBufferResidentNV(Enum target, Enum access);
	void makeBufferNonResidentNV(Enum target);
	Boolean isBufferResidentNV(Enum target);
	void makeNamedBufferResidentNV(UInt buffer, Enum access);
	void makeNamedBufferNonResidentNV(UInt buffer);
	Boolean isNamedBufferResidentNV(UInt buffer);
	void getBufferParameterui64vNV(Enum target, Enum pname, GLuint64EXT* params);
	void getNamedBufferParameterui64vNV(UInt buffer, Enum pname, GLuint64EXT* params);
	void getIntegerui64vNV(Enum value, GLuint64EXT* result);
	void uniformui64NV(Int location, GLuint64EXT value);
	void uniformui64vNV(Int location, Sizei count, const(GLuint64EXT)* value);
	void programUniformui64NV(UInt program, Int location, GLuint64EXT value);
	void programUniformui64vNV(UInt program, Int location, Sizei count,
			const(GLuint64EXT)* value);

	enum SHADER_GLOBAL_ACCESS_BARRIER_BIT_NV = 0x00000010;

	enum SUBGROUP_FEATURE_PARTITIONED_BIT_NV = 0x00000100;

	enum WARP_SIZE_NV = 0x9339;
	enum WARPS_PER_SM_NV = 0x933A;
	enum SM_COUNT_NV = 0x933B;

	enum SHADING_RATE_IMAGE_NV = 0x9563;
	enum SHADING_RATE_NO_INVOCATIONS_NV = 0x9564;
	enum SHADING_RATE_1_INVOCATION_PER_PIXEL_NV = 0x9565;
	enum SHADING_RATE_1_INVOCATION_PER_1X2_PIXELS_NV = 0x9566;
	enum SHADING_RATE_1_INVOCATION_PER_2X1_PIXELS_NV = 0x9567;
	enum SHADING_RATE_1_INVOCATION_PER_2X2_PIXELS_NV = 0x9568;
	enum SHADING_RATE_1_INVOCATION_PER_2X4_PIXELS_NV = 0x9569;
	enum SHADING_RATE_1_INVOCATION_PER_4X2_PIXELS_NV = 0x956A;
	enum SHADING_RATE_1_INVOCATION_PER_4X4_PIXELS_NV = 0x956B;
	enum SHADING_RATE_2_INVOCATIONS_PER_PIXEL_NV = 0x956C;
	enum SHADING_RATE_4_INVOCATIONS_PER_PIXEL_NV = 0x956D;
	enum SHADING_RATE_8_INVOCATIONS_PER_PIXEL_NV = 0x956E;
	enum SHADING_RATE_16_INVOCATIONS_PER_PIXEL_NV = 0x956F;
	enum SHADING_RATE_IMAGE_BINDING_NV = 0x955B;
	enum SHADING_RATE_IMAGE_TEXEL_WIDTH_NV = 0x955C;
	enum SHADING_RATE_IMAGE_TEXEL_HEIGHT_NV = 0x955D;
	enum SHADING_RATE_IMAGE_PALETTE_SIZE_NV = 0x955E;
	enum MAX_COARSE_FRAGMENT_SAMPLES_NV = 0x955F;
	enum SHADING_RATE_SAMPLE_ORDER_DEFAULT_NV = 0x95AE;
	enum SHADING_RATE_SAMPLE_ORDER_PIXEL_MAJOR_NV = 0x95AF;
	enum SHADING_RATE_SAMPLE_ORDER_SAMPLE_MAJOR_NV = 0x95B0;
	void bindShadingRateImageNV(UInt texture);
	void getShadingRateImagePaletteNV(UInt viewport, UInt entry, Enum* rate);
	void getShadingRateSampleLocationivNV(Enum rate, UInt samples,
			UInt index, Int* location);
	void shadingRateImageBarrierNV(Boolean synchronize);
	void shadingRateImagePaletteNV(UInt viewport, UInt first,
			Sizei count, const(Enum)* rates);
	void shadingRateSampleOrderNV(Enum order);
	void shadingRateSampleOrderCustomNV(Enum rate, UInt samples, const(Int)* locations);

	enum MAX_PROGRAM_PATCH_ATTRIBS_NV = 0x86D8;
	enum TESS_CONTROL_PROGRAM_NV = 0x891E;
	enum TESS_EVALUATION_PROGRAM_NV = 0x891F;
	enum TESS_CONTROL_PROGRAM_PARAMETER_BUFFER_NV = 0x8C74;
	enum TESS_EVALUATION_PROGRAM_PARAMETER_BUFFER_NV = 0x8C75;

	enum EMBOSS_LIGHT_NV = 0x855D;
	enum EMBOSS_CONSTANT_NV = 0x855E;
	enum EMBOSS_MAP_NV = 0x855F;

	enum NORMAL_MAP_NV = 0x8511;
	enum REFLECTION_MAP_NV = 0x8512;

	void textureBarrierNV();

	enum COMBINE4_NV = 0x8503;
	enum SOURCE3_RGB_NV = 0x8583;
	enum SOURCE3_ALPHA_NV = 0x858B;
	enum OPERAND3_RGB_NV = 0x8593;
	enum OPERAND3_ALPHA_NV = 0x859B;

	enum TEXTURE_UNSIGNED_REMAP_MODE_NV = 0x888F;

	enum TEXTURE_COVERAGE_SAMPLES_NV = 0x9045;
	enum TEXTURE_COLOR_SAMPLES_NV = 0x9046;
	void texImage2DMultisampleCoverageNV(Enum target, Sizei coverageSamples, Sizei colorSamples,
			Int internalFormat, Sizei width, Sizei height, Boolean fixedSampleLocations);
	void texImage3DMultisampleCoverageNV(Enum target, Sizei coverageSamples,
			Sizei colorSamples, Int internalFormat,
			Sizei width, Sizei height, Sizei depth, Boolean fixedSampleLocations);
	void textureImage2DMultisampleNV(UInt texture, Enum target, Sizei samples,
			Int internalFormat, Sizei width, Sizei height, Boolean fixedSampleLocations);
	void textureImage3DMultisampleNV(UInt texture, Enum target, Sizei samples, Int internalFormat,
			Sizei width, Sizei height, Sizei depth, Boolean fixedSampleLocations);
	void textureImage2DMultisampleCoverageNV(UInt texture, Enum target, Sizei coverageSamples, Sizei colorSamples,
			Int internalFormat, Sizei width, Sizei height, Boolean fixedSampleLocations);
	void textureImage3DMultisampleCoverageNV(UInt texture, Enum target,
			Sizei coverageSamples, Sizei colorSamples, Int internalFormat,
			Sizei width, Sizei height, Sizei depth, Boolean fixedSampleLocations);

	enum TEXTURE_RECTANGLE_NV = 0x84F5;
	enum TEXTURE_BINDING_RECTANGLE_NV = 0x84F6;
	enum PROXY_TEXTURE_RECTANGLE_NV = 0x84F7;
	enum MAX_RECTANGLE_TEXTURE_SIZE_NV = 0x84F8;

	enum OFFSET_TEXTURE_RECTANGLE_NV = 0x864C;
	enum OFFSET_TEXTURE_RECTANGLE_SCALE_NV = 0x864D;
	enum DOT_PRODUCT_TEXTURE_RECTANGLE_NV = 0x864E;
	enum RGBA_UNSIGNED_DOT_PRODUCT_MAPPING_NV = 0x86D9;
	enum UNSIGNED_INT_S8_S8_8_8_NV = 0x86DA;
	enum UNSIGNED_INT_8_8_S8_S8_REV_NV = 0x86DB;
	enum DSDT_MAG_INTENSITY_NV = 0x86DC;
	enum SHADER_CONSISTENT_NV = 0x86DD;
	enum TEXTURE_SHADER_NV = 0x86DE;
	enum SHADER_OPERATION_NV = 0x86DF;
	enum CULL_MODES_NV = 0x86E0;
	enum OFFSET_TEXTURE_MATRIX_NV = 0x86E1;
	enum OFFSET_TEXTURE_SCALE_NV = 0x86E2;
	enum OFFSET_TEXTURE_BIAS_NV = 0x86E3;
	enum OFFSET_TEXTURE_2D_MATRIX_NV = 0x86E1;
	enum OFFSET_TEXTURE_2D_SCALE_NV = 0x86E2;
	enum OFFSET_TEXTURE_2D_BIAS_NV = 0x86E3;
	enum PREVIOUS_TEXTURE_INPUT_NV = 0x86E4;
	enum CONST_EYE_NV = 0x86E5;
	enum PASS_THROUGH_NV = 0x86E6;
	enum CULL_FRAGMENT_NV = 0x86E7;
	enum OFFSET_TEXTURE_2D_NV = 0x86E8;
	enum DEPENDENT_AR_TEXTURE_2D_NV = 0x86E9;
	enum DEPENDENT_GB_TEXTURE_2D_NV = 0x86EA;
	enum DOT_PRODUCT_NV = 0x86EC;
	enum DOT_PRODUCT_DEPTH_REPLACE_NV = 0x86ED;
	enum DOT_PRODUCT_TEXTURE_2D_NV = 0x86EE;
	enum DOT_PRODUCT_TEXTURE_CUBE_MAP_NV = 0x86F0;
	enum DOT_PRODUCT_DIFFUSE_CUBE_MAP_NV = 0x86F1;
	enum DOT_PRODUCT_REFLECT_CUBE_MAP_NV = 0x86F2;
	enum DOT_PRODUCT_CONST_EYE_REFLECT_CUBE_MAP_NV = 0x86F3;
	enum HILO_NV = 0x86F4;
	enum DSDT_NV = 0x86F5;
	enum DSDT_MAG_NV = 0x86F6;
	enum DSDT_MAG_VIB_NV = 0x86F7;
	enum HILO16_NV = 0x86F8;
	enum SIGNED_HILO_NV = 0x86F9;
	enum SIGNED_HILO16_NV = 0x86FA;
	enum SIGNED_RGBA_NV = 0x86FB;
	enum SIGNED_RGBA8_NV = 0x86FC;
	enum SIGNED_RGB_NV = 0x86FE;
	enum SIGNED_RGB8_NV = 0x86FF;
	enum SIGNED_LUMINANCE_NV = 0x8701;
	enum SIGNED_LUMINANCE8_NV = 0x8702;
	enum SIGNED_LUMINANCE_ALPHA_NV = 0x8703;
	enum SIGNED_LUMINANCE8_ALPHA8_NV = 0x8704;
	enum SIGNED_ALPHA_NV = 0x8705;
	enum SIGNED_ALPHA8_NV = 0x8706;
	enum SIGNED_INTENSITY_NV = 0x8707;
	enum SIGNED_INTENSITY8_NV = 0x8708;
	enum DSDT8_NV = 0x8709;
	enum DSDT8_MAG8_NV = 0x870A;
	enum DSDT8_MAG8_INTENSITY8_NV = 0x870B;
	enum SIGNED_RGB_UNSIGNED_ALPHA_NV = 0x870C;
	enum SIGNED_RGB8_UNSIGNED_ALPHA8_NV = 0x870D;
	enum HI_SCALE_NV = 0x870E;
	enum LO_SCALE_NV = 0x870F;
	enum DS_SCALE_NV = 0x8710;
	enum DT_SCALE_NV = 0x8711;
	enum MAGNITUDE_SCALE_NV = 0x8712;
	enum VIBRANCE_SCALE_NV = 0x8713;
	enum HI_BIAS_NV = 0x8714;
	enum LO_BIAS_NV = 0x8715;
	enum DS_BIAS_NV = 0x8716;
	enum DT_BIAS_NV = 0x8717;
	enum MAGNITUDE_BIAS_NV = 0x8718;
	enum VIBRANCE_BIAS_NV = 0x8719;
	enum TEXTURE_BORDER_VALUES_NV = 0x871A;
	enum TEXTURE_HI_SIZE_NV = 0x871B;
	enum TEXTURE_LO_SIZE_NV = 0x871C;
	enum TEXTURE_DS_SIZE_NV = 0x871D;
	enum TEXTURE_DT_SIZE_NV = 0x871E;
	enum TEXTURE_MAG_SIZE_NV = 0x871F;

	enum DOT_PRODUCT_TEXTURE_3D_NV = 0x86EF;

	enum OFFSET_PROJECTIVE_TEXTURE_2D_NV = 0x8850;
	enum OFFSET_PROJECTIVE_TEXTURE_2D_SCALE_NV = 0x8851;
	enum OFFSET_PROJECTIVE_TEXTURE_RECTANGLE_NV = 0x8852;
	enum OFFSET_PROJECTIVE_TEXTURE_RECTANGLE_SCALE_NV = 0x8853;
	enum OFFSET_HILO_TEXTURE_2D_NV = 0x8854;
	enum OFFSET_HILO_TEXTURE_RECTANGLE_NV = 0x8855;
	enum OFFSET_HILO_PROJECTIVE_TEXTURE_2D_NV = 0x8856;
	enum OFFSET_HILO_PROJECTIVE_TEXTURE_RECTANGLE_NV = 0x8857;
	enum DEPENDENT_HILO_TEXTURE_2D_NV = 0x8858;
	enum DEPENDENT_RGB_TEXTURE_3D_NV = 0x8859;
	enum DEPENDENT_RGB_TEXTURE_CUBE_MAP_NV = 0x885A;
	enum DOT_PRODUCT_PASS_THROUGH_NV = 0x885B;
	enum DOT_PRODUCT_TEXTURE_1D_NV = 0x885C;
	enum DOT_PRODUCT_AFFINE_DEPTH_REPLACE_NV = 0x885D;
	enum HILO8_NV = 0x885E;
	enum SIGNED_HILO8_NV = 0x885F;
	enum FORCE_BLUE_TO_ONE_NV = 0x8860;

	enum BACK_PRIMARY_COLOR_NV = 0x8C77;
	enum BACK_SECONDARY_COLOR_NV = 0x8C78;
	enum TEXTURE_COORD_NV = 0x8C79;
	enum CLIP_DISTANCE_NV = 0x8C7A;
	enum VERTEX_ID_NV = 0x8C7B;
	enum PRIMITIVE_ID_NV = 0x8C7C;
	enum GENERIC_ATTRIB_NV = 0x8C7D;
	enum TRANSFORM_FEEDBACK_ATTRIBS_NV = 0x8C7E;
	enum TRANSFORM_FEEDBACK_BUFFER_MODE_NV = 0x8C7F;
	enum MAX_TRANSFORM_FEEDBACK_SEPARATE_COMPONENTS_NV = 0x8C80;
	enum ACTIVE_VARYINGS_NV = 0x8C81;
	enum ACTIVE_VARYING_MAX_LENGTH_NV = 0x8C82;
	enum TRANSFORM_FEEDBACK_VARYINGS_NV = 0x8C83;
	enum TRANSFORM_FEEDBACK_BUFFER_START_NV = 0x8C84;
	enum TRANSFORM_FEEDBACK_BUFFER_SIZE_NV = 0x8C85;
	enum TRANSFORM_FEEDBACK_RECORD_NV = 0x8C86;
	enum PRIMITIVES_GENERATED_NV = 0x8C87;
	enum TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN_NV = 0x8C88;
	enum RASTERIZER_DISCARD_NV = 0x8C89;
	enum MAX_TRANSFORM_FEEDBACK_INTERLEAVED_COMPONENTS_NV = 0x8C8A;
	enum MAX_TRANSFORM_FEEDBACK_SEPARATE_ATTRIBS_NV = 0x8C8B;
	enum INTERLEAVED_ATTRIBS_NV = 0x8C8C;
	enum SEPARATE_ATTRIBS_NV = 0x8C8D;
	enum TRANSFORM_FEEDBACK_BUFFER_NV = 0x8C8E;
	enum TRANSFORM_FEEDBACK_BUFFER_BINDING_NV = 0x8C8F;
	enum LAYER_NV = 0x8DAA;
	enum NEXT_BUFFER_NV = -2;
	enum SKIP_COMPONENTS4_NV = -3;
	enum SKIP_COMPONENTS3_NV = -4;
	enum SKIP_COMPONENTS2_NV = -5;
	enum SKIP_COMPONENTS1_NV = -6;
	void beginTransformFeedbackNV(Enum primitiveMode);
	void endTransformFeedbackNV();
	void transformFeedbackAttribsNV(Sizei count, const(Int)* attribs, Enum bufferMode);
	void bindBufferRangeNV(Enum target, UInt index, UInt buffer,
			Intptr offset, Sizeiptr size);
	void bindBufferOffsetNV(Enum target, UInt index, UInt buffer, Intptr offset);
	void bindBufferBaseNV(Enum target, UInt index, UInt buffer);
	void transformFeedbackVaryingsNV(UInt program, Sizei count,
			const(Int)* locations, Enum bufferMode);
	void activeVaryingNV(UInt program, const(Char)* name);
	Int getVaryingLocationNV(UInt program, const(Char)* name);
	void getActiveVaryingNV(UInt program, UInt index, Sizei bufSize,
			Sizei* length, Sizei* size, Enum* type, Char* name);
	void getTransformFeedbackVaryingNV(UInt program, UInt index, Int* location);
	void transformFeedbackStreamAttribsNV(Sizei count, const(Int)* attribs,
			Sizei nbuffers, const(Int)* bufstreams, Enum bufferMode);

	enum TRANSFORM_FEEDBACK_NV = 0x8E22;
	enum TRANSFORM_FEEDBACK_BUFFER_PAUSED_NV = 0x8E23;
	enum TRANSFORM_FEEDBACK_BUFFER_ACTIVE_NV = 0x8E24;
	enum TRANSFORM_FEEDBACK_BINDING_NV = 0x8E25;
	void bindTransformFeedbackNV(Enum target, UInt id);
	void deleteTransformFeedbacksNV(Sizei n, const(UInt)* ids);
	void genTransformFeedbacksNV(Sizei n, UInt* ids);
	Boolean isTransformFeedbackNV(UInt id);
	void pauseTransformFeedbackNV();
	void resumeTransformFeedbackNV();
	void drawTransformFeedbackNV(Enum mode, UInt id);

	enum UNIFORM_BUFFER_UNIFIED_NV = 0x936E;
	enum UNIFORM_BUFFER_ADDRESS_NV = 0x936F;
	enum UNIFORM_BUFFER_LENGTH_NV = 0x9370;

	alias GLvdpauSurfaceNV = c_long;
	enum SURFACE_STATE_NV = 0x86EB;
	enum SURFACE_REGISTERED_NV = 0x86FD;
	enum SURFACE_MAPPED_NV = 0x8700;
	enum WRITE_DISCARD_NV = 0x88BE;
	@BindingName("glVDPAUInitNV")
	void vdpauInitNV(const(void)* vdpDevice, const(void)* getProcAddress);
	@BindingName("glVDPAUFiniNV")
	void vdpauFiniNV();
	@BindingName("glVDPAURegisterVideoSurfaceNV")
	GLvdpauSurfaceNV vdpauRegisterVideoSurfaceNV(const(void)* vdpSurface,
			Enum target, Sizei numTextureNames, const(UInt)* textureNames);
	@BindingName("glVDPAURegisterOutputSurfaceNV")
	GLvdpauSurfaceNV vdpauRegisterOutputSurfaceNV(const(void)* vdpSurface,
			Enum target, Sizei numTextureNames, const(UInt)* textureNames);
	@BindingName("glVDPAUIsSurfaceNV")
	Boolean vdpauIsSurfaceNV(GLvdpauSurfaceNV surface);
	@BindingName("glVDPAUUnregisterSurfaceNV")
	void vdpauUnregisterSurfaceNV(GLvdpauSurfaceNV surface);
	@BindingName("glVDPAUGetSurfaceivNV")
	void vdpauGetSurfaceivNV(GLvdpauSurfaceNV surface, Enum pname,
			Sizei bufSize, Sizei* length, Int* values);
	@BindingName("glVDPAUSurfaceAccessNV")
	void vdpauSurfaceAccessNV(GLvdpauSurfaceNV surface, Enum access);
	@BindingName("glVDPAUMapSurfacesNV")
	void vdpauMapSurfacesNV(Sizei numSurfaces, const(GLvdpauSurfaceNV)* surfaces);
	@BindingName("glVDPAUUnmapSurfacesNV")
	void vdpauUnmapSurfacesNV(Sizei numSurface, const(GLvdpauSurfaceNV)* surfaces);

	@BindingName("glVDPAURegisterVideoSurfaceWithPictureStructureNV")
	GLvdpauSurfaceNV vdpauRegisterVideoSurfaceWithPictureStructureNV(const(void)* vdpSurface, Enum target,
			Sizei numTextureNames, const(UInt)* textureNames, Boolean isFrameStructure);

	enum VERTEX_ARRAY_RANGE_NV = 0x851D;
	enum VERTEX_ARRAY_RANGE_LENGTH_NV = 0x851E;
	enum VERTEX_ARRAY_RANGE_VALID_NV = 0x851F;
	enum MAX_VERTEX_ARRAY_RANGE_ELEMENT_NV = 0x8520;
	enum VERTEX_ARRAY_RANGE_POINTER_NV = 0x8521;
	void flushVertexArrayRangeNV();
	void vertexArrayRangeNV(Sizei length, const(void)* pointer);

	enum VERTEX_ARRAY_RANGE_WITHOUT_FLUSH_NV = 0x8533;

	void vertexAttribL1i64NV(UInt index, GLint64EXT x);
	void vertexAttribL2i64NV(UInt index, GLint64EXT x, GLint64EXT y);
	void vertexAttribL3i64NV(UInt index, GLint64EXT x, GLint64EXT y, GLint64EXT z);
	void vertexAttribL4i64NV(UInt index, GLint64EXT x, GLint64EXT y, GLint64EXT z, GLint64EXT w);
	void vertexAttribL1i64vNV(UInt index, const(GLint64EXT)* v);
	void vertexAttribL2i64vNV(UInt index, const(GLint64EXT)* v);
	void vertexAttribL3i64vNV(UInt index, const(GLint64EXT)* v);
	void vertexAttribL4i64vNV(UInt index, const(GLint64EXT)* v);
	void vertexAttribL1Ui64NV(UInt index, GLuint64EXT x);
	void vertexAttribL2Ui64NV(UInt index, GLuint64EXT x, GLuint64EXT y);
	void vertexAttribL3Ui64NV(UInt index, GLuint64EXT x, GLuint64EXT y, GLuint64EXT z);
	void vertexAttribL4Ui64NV(UInt index, GLuint64EXT x, GLuint64EXT y,
			GLuint64EXT z, GLuint64EXT w);
	void vertexAttribL1Ui64vNV(UInt index, const(GLuint64EXT)* v);
	void vertexAttribL2Ui64vNV(UInt index, const(GLuint64EXT)* v);
	void vertexAttribL3Ui64vNV(UInt index, const(GLuint64EXT)* v);
	void vertexAttribL4Ui64vNV(UInt index, const(GLuint64EXT)* v);
	void getVertexAttribLi64vNV(UInt index, Enum pname, GLint64EXT* params);
	void getVertexAttribLui64vNV(UInt index, Enum pname, GLuint64EXT* params);
	void vertexAttribLFormatNV(UInt index, Int size, Enum type, Sizei stride);

	enum VERTEX_ATTRIB_ARRAY_UNIFIED_NV = 0x8F1E;
	enum ELEMENT_ARRAY_UNIFIED_NV = 0x8F1F;
	enum VERTEX_ATTRIB_ARRAY_ADDRESS_NV = 0x8F20;
	enum VERTEX_ARRAY_ADDRESS_NV = 0x8F21;
	enum NORMAL_ARRAY_ADDRESS_NV = 0x8F22;
	enum COLOR_ARRAY_ADDRESS_NV = 0x8F23;
	enum INDEX_ARRAY_ADDRESS_NV = 0x8F24;
	enum TEXTURE_COORD_ARRAY_ADDRESS_NV = 0x8F25;
	enum EDGE_FLAG_ARRAY_ADDRESS_NV = 0x8F26;
	enum SECONDARY_COLOR_ARRAY_ADDRESS_NV = 0x8F27;
	enum FOG_COORD_ARRAY_ADDRESS_NV = 0x8F28;
	enum ELEMENT_ARRAY_ADDRESS_NV = 0x8F29;
	enum VERTEX_ATTRIB_ARRAY_LENGTH_NV = 0x8F2A;
	enum VERTEX_ARRAY_LENGTH_NV = 0x8F2B;
	enum NORMAL_ARRAY_LENGTH_NV = 0x8F2C;
	enum COLOR_ARRAY_LENGTH_NV = 0x8F2D;
	enum INDEX_ARRAY_LENGTH_NV = 0x8F2E;
	enum TEXTURE_COORD_ARRAY_LENGTH_NV = 0x8F2F;
	enum EDGE_FLAG_ARRAY_LENGTH_NV = 0x8F30;
	enum SECONDARY_COLOR_ARRAY_LENGTH_NV = 0x8F31;
	enum FOG_COORD_ARRAY_LENGTH_NV = 0x8F32;
	enum ELEMENT_ARRAY_LENGTH_NV = 0x8F33;
	enum DRAW_INDIRECT_UNIFIED_NV = 0x8F40;
	enum DRAW_INDIRECT_ADDRESS_NV = 0x8F41;
	enum DRAW_INDIRECT_LENGTH_NV = 0x8F42;
	void bufferAddressRangeNV(Enum pname, UInt index, GLuint64EXT address, Sizeiptr length);
	void vertexFormatNV(Int size, Enum type, Sizei stride);
	void normalFormatNV(Enum type, Sizei stride);
	void colorFormatNV(Int size, Enum type, Sizei stride);
	void indexFormatNV(Enum type, Sizei stride);
	void texCoordFormatNV(Int size, Enum type, Sizei stride);
	void edgeFlagFormatNV(Sizei stride);
	void secondaryColorFormatNV(Int size, Enum type, Sizei stride);
	void fogCoordFormatNV(Enum type, Sizei stride);
	void vertexAttribFormatNV(UInt index, Int size, Enum type,
			Boolean normalized, Sizei stride);
	void vertexAttribIFormatNV(UInt index, Int size, Enum type, Sizei stride);
	void getIntegerui64i_vNV(Enum value, UInt index, GLuint64EXT* result);

	enum VERTEX_PROGRAM_NV = 0x8620;
	enum VERTEX_STATE_PROGRAM_NV = 0x8621;
	enum ATTRIB_ARRAY_SIZE_NV = 0x8623;
	enum ATTRIB_ARRAY_STRIDE_NV = 0x8624;
	enum ATTRIB_ARRAY_TYPE_NV = 0x8625;
	enum CURRENT_ATTRIB_NV = 0x8626;
	enum PROGRAM_LENGTH_NV = 0x8627;
	enum PROGRAM_STRING_NV = 0x8628;
	enum MODELVIEW_PROJECTION_NV = 0x8629;
	enum IDENTITY_NV = 0x862A;
	enum INVERSE_NV = 0x862B;
	enum TRANSPOSE_NV = 0x862C;
	enum INVERSE_TRANSPOSE_NV = 0x862D;
	enum MAX_TRACK_MATRIX_STACK_DEPTH_NV = 0x862E;
	enum MAX_TRACK_MATRICES_NV = 0x862F;
	enum MATRIX0_NV = 0x8630;
	enum MATRIX1_NV = 0x8631;
	enum MATRIX2_NV = 0x8632;
	enum MATRIX3_NV = 0x8633;
	enum MATRIX4_NV = 0x8634;
	enum MATRIX5_NV = 0x8635;
	enum MATRIX6_NV = 0x8636;
	enum MATRIX7_NV = 0x8637;
	enum CURRENT_MATRIX_STACK_DEPTH_NV = 0x8640;
	enum CURRENT_MATRIX_NV = 0x8641;
	enum VERTEX_PROGRAM_POINT_SIZE_NV = 0x8642;
	enum VERTEX_PROGRAM_TWO_SIDE_NV = 0x8643;
	enum PROGRAM_PARAMETER_NV = 0x8644;
	enum ATTRIB_ARRAY_POINTER_NV = 0x8645;
	enum PROGRAM_TARGET_NV = 0x8646;
	enum PROGRAM_RESIDENT_NV = 0x8647;
	enum TRACK_MATRIX_NV = 0x8648;
	enum TRACK_MATRIX_TRANSFORM_NV = 0x8649;
	enum VERTEX_PROGRAM_BINDING_NV = 0x864A;
	enum PROGRAM_ERROR_POSITION_NV = 0x864B;
	enum VERTEX_ATTRIB_ARRAY0_NV = 0x8650;
	enum VERTEX_ATTRIB_ARRAY1_NV = 0x8651;
	enum VERTEX_ATTRIB_ARRAY2_NV = 0x8652;
	enum VERTEX_ATTRIB_ARRAY3_NV = 0x8653;
	enum VERTEX_ATTRIB_ARRAY4_NV = 0x8654;
	enum VERTEX_ATTRIB_ARRAY5_NV = 0x8655;
	enum VERTEX_ATTRIB_ARRAY6_NV = 0x8656;
	enum VERTEX_ATTRIB_ARRAY7_NV = 0x8657;
	enum VERTEX_ATTRIB_ARRAY8_NV = 0x8658;
	enum VERTEX_ATTRIB_ARRAY9_NV = 0x8659;
	enum VERTEX_ATTRIB_ARRAY10_NV = 0x865A;
	enum VERTEX_ATTRIB_ARRAY11_NV = 0x865B;
	enum VERTEX_ATTRIB_ARRAY12_NV = 0x865C;
	enum VERTEX_ATTRIB_ARRAY13_NV = 0x865D;
	enum VERTEX_ATTRIB_ARRAY14_NV = 0x865E;
	enum VERTEX_ATTRIB_ARRAY15_NV = 0x865F;
	enum MAP1_VERTEX_ATTRIB0_4_NV = 0x8660;
	enum MAP1_VERTEX_ATTRIB1_4_NV = 0x8661;
	enum MAP1_VERTEX_ATTRIB2_4_NV = 0x8662;
	enum MAP1_VERTEX_ATTRIB3_4_NV = 0x8663;
	enum MAP1_VERTEX_ATTRIB4_4_NV = 0x8664;
	enum MAP1_VERTEX_ATTRIB5_4_NV = 0x8665;
	enum MAP1_VERTEX_ATTRIB6_4_NV = 0x8666;
	enum MAP1_VERTEX_ATTRIB7_4_NV = 0x8667;
	enum MAP1_VERTEX_ATTRIB8_4_NV = 0x8668;
	enum MAP1_VERTEX_ATTRIB9_4_NV = 0x8669;
	enum MAP1_VERTEX_ATTRIB10_4_NV = 0x866A;
	enum MAP1_VERTEX_ATTRIB11_4_NV = 0x866B;
	enum MAP1_VERTEX_ATTRIB12_4_NV = 0x866C;
	enum MAP1_VERTEX_ATTRIB13_4_NV = 0x866D;
	enum MAP1_VERTEX_ATTRIB14_4_NV = 0x866E;
	enum MAP1_VERTEX_ATTRIB15_4_NV = 0x866F;
	enum MAP2_VERTEX_ATTRIB0_4_NV = 0x8670;
	enum MAP2_VERTEX_ATTRIB1_4_NV = 0x8671;
	enum MAP2_VERTEX_ATTRIB2_4_NV = 0x8672;
	enum MAP2_VERTEX_ATTRIB3_4_NV = 0x8673;
	enum MAP2_VERTEX_ATTRIB4_4_NV = 0x8674;
	enum MAP2_VERTEX_ATTRIB5_4_NV = 0x8675;
	enum MAP2_VERTEX_ATTRIB6_4_NV = 0x8676;
	enum MAP2_VERTEX_ATTRIB7_4_NV = 0x8677;
	enum MAP2_VERTEX_ATTRIB8_4_NV = 0x8678;
	enum MAP2_VERTEX_ATTRIB9_4_NV = 0x8679;
	enum MAP2_VERTEX_ATTRIB10_4_NV = 0x867A;
	enum MAP2_VERTEX_ATTRIB11_4_NV = 0x867B;
	enum MAP2_VERTEX_ATTRIB12_4_NV = 0x867C;
	enum MAP2_VERTEX_ATTRIB13_4_NV = 0x867D;
	enum MAP2_VERTEX_ATTRIB14_4_NV = 0x867E;
	enum MAP2_VERTEX_ATTRIB15_4_NV = 0x867F;
	Boolean areProgramsResidentNV(Sizei n, const(UInt)* programs, Boolean* residences);
	void bindProgramNV(Enum target, UInt id);
	void deleteProgramsNV(Sizei n, const(UInt)* programs);
	void executeProgramNV(Enum target, UInt id, const(Float)* params);
	void genProgramsNV(Sizei n, UInt* programs);
	void getProgramParameterdvNV(Enum target, UInt index, Enum pname, Double* params);
	void getProgramParameterfvNV(Enum target, UInt index, Enum pname, Float* params);
	void getProgramivNV(UInt id, Enum pname, Int* params);
	void getProgramStringNV(UInt id, Enum pname, UByte* program);
	void getTrackMatrixivNV(Enum target, UInt address, Enum pname, Int* params);
	void getVertexAttribdvNV(UInt index, Enum pname, Double* params);
	void getVertexAttribfvNV(UInt index, Enum pname, Float* params);
	void getVertexAttribivNV(UInt index, Enum pname, Int* params);
	void getVertexAttribPointervNV(UInt index, Enum pname, void** pointer);
	Boolean isProgramNV(UInt id);
	void loadProgramNV(Enum target, UInt id, Sizei len, const(UByte)* program);
	void programParameter4dNV(Enum target, UInt index, Double x, Double y,
			Double z, Double w);
	void programParameter4dvNV(Enum target, UInt index, const(Double)* v);
	void programParameter4fNV(Enum target, UInt index, Float x, Float y, Float z,
			Float w);
	void programParameter4fvNV(Enum target, UInt index, const(Float)* v);
	void programParameters4dvNV(Enum target, UInt index, Sizei count, const(Double)* v);
	void programParameters4fvNV(Enum target, UInt index, Sizei count, const(Float)* v);
	void requestResidentProgramsNV(Sizei n, const(UInt)* programs);
	void trackMatrixNV(Enum target, UInt address, Enum matrix, Enum transform);
	void vertexAttribPointerNV(UInt index, Int fsize, Enum type,
			Sizei stride, const(void)* pointer);
	void vertexAttrib1dNV(UInt index, Double x);
	void vertexAttrib1dvNV(UInt index, const(Double)* v);
	void vertexAttrib1fNV(UInt index, Float x);
	void vertexAttrib1fvNV(UInt index, const(Float)* v);
	void vertexAttrib1sNV(UInt index, Short x);
	void vertexAttrib1svNV(UInt index, const(Short)* v);
	void vertexAttrib2dNV(UInt index, Double x, Double y);
	void vertexAttrib2dvNV(UInt index, const(Double)* v);
	void vertexAttrib2fNV(UInt index, Float x, Float y);
	void vertexAttrib2fvNV(UInt index, const(Float)* v);
	void vertexAttrib2sNV(UInt index, Short x, Short y);
	void vertexAttrib2svNV(UInt index, const(Short)* v);
	void vertexAttrib3dNV(UInt index, Double x, Double y, Double z);
	void vertexAttrib3dvNV(UInt index, const(Double)* v);
	void vertexAttrib3fNV(UInt index, Float x, Float y, Float z);
	void vertexAttrib3fvNV(UInt index, const(Float)* v);
	void vertexAttrib3sNV(UInt index, Short x, Short y, Short z);
	void vertexAttrib3svNV(UInt index, const(Short)* v);
	void vertexAttrib4dNV(UInt index, Double x, Double y, Double z, Double w);
	void vertexAttrib4dvNV(UInt index, const(Double)* v);
	void vertexAttrib4fNV(UInt index, Float x, Float y, Float z, Float w);
	void vertexAttrib4fvNV(UInt index, const(Float)* v);
	void vertexAttrib4sNV(UInt index, Short x, Short y, Short z, Short w);
	void vertexAttrib4svNV(UInt index, const(Short)* v);
	void vertexAttrib4UbNV(UInt index, UByte x, UByte y, UByte z, UByte w);
	void vertexAttrib4UbvNV(UInt index, const(UByte)* v);
	void vertexAttribs1dvNV(UInt index, Sizei count, const(Double)* v);
	void vertexAttribs1fvNV(UInt index, Sizei count, const(Float)* v);
	void vertexAttribs1svNV(UInt index, Sizei count, const(Short)* v);
	void vertexAttribs2dvNV(UInt index, Sizei count, const(Double)* v);
	void vertexAttribs2fvNV(UInt index, Sizei count, const(Float)* v);
	void vertexAttribs2svNV(UInt index, Sizei count, const(Short)* v);
	void vertexAttribs3dvNV(UInt index, Sizei count, const(Double)* v);
	void vertexAttribs3fvNV(UInt index, Sizei count, const(Float)* v);
	void vertexAttribs3svNV(UInt index, Sizei count, const(Short)* v);
	void vertexAttribs4dvNV(UInt index, Sizei count, const(Double)* v);
	void vertexAttribs4fvNV(UInt index, Sizei count, const(Float)* v);
	void vertexAttribs4svNV(UInt index, Sizei count, const(Short)* v);
	void vertexAttribs4UbvNV(UInt index, Sizei count, const(UByte)* v);

	enum VERTEX_ATTRIB_ARRAY_INTEGER_NV = 0x88FD;
	void vertexAttribI1iEXT(UInt index, Int x);
	void vertexAttribI2iEXT(UInt index, Int x, Int y);
	void vertexAttribI3iEXT(UInt index, Int x, Int y, Int z);
	void vertexAttribI4iEXT(UInt index, Int x, Int y, Int z, Int w);
	void vertexAttribI1UiEXT(UInt index, UInt x);
	void vertexAttribI2UiEXT(UInt index, UInt x, UInt y);
	void vertexAttribI3UiEXT(UInt index, UInt x, UInt y, UInt z);
	void vertexAttribI4UiEXT(UInt index, UInt x, UInt y, UInt z, UInt w);
	void vertexAttribI1ivEXT(UInt index, const(Int)* v);
	void vertexAttribI2ivEXT(UInt index, const(Int)* v);
	void vertexAttribI3ivEXT(UInt index, const(Int)* v);
	void vertexAttribI4ivEXT(UInt index, const(Int)* v);
	void vertexAttribI1UivEXT(UInt index, const(UInt)* v);
	void vertexAttribI2UivEXT(UInt index, const(UInt)* v);
	void vertexAttribI3UivEXT(UInt index, const(UInt)* v);
	void vertexAttribI4UivEXT(UInt index, const(UInt)* v);
	void vertexAttribI4bvEXT(UInt index, const(Byte)* v);
	void vertexAttribI4svEXT(UInt index, const(Short)* v);
	void vertexAttribI4UbvEXT(UInt index, const(UByte)* v);
	void vertexAttribI4UsvEXT(UInt index, const(UShort)* v);
	void vertexAttribIPointerEXT(UInt index, Int size, Enum type,
			Sizei stride, const(void)* pointer);
	void getVertexAttribIivEXT(UInt index, Enum pname, Int* params);
	void getVertexAttribIuivEXT(UInt index, Enum pname, UInt* params);

	enum VIDEO_BUFFER_NV = 0x9020;
	enum VIDEO_BUFFER_BINDING_NV = 0x9021;
	enum FIELD_UPPER_NV = 0x9022;
	enum FIELD_LOWER_NV = 0x9023;
	enum NUM_VIDEO_CAPTURE_STREAMS_NV = 0x9024;
	enum NEXT_VIDEO_CAPTURE_BUFFER_STATUS_NV = 0x9025;
	enum VIDEO_CAPTURE_TO_422_SUPPORTED_NV = 0x9026;
	enum LAST_VIDEO_CAPTURE_STATUS_NV = 0x9027;
	enum VIDEO_BUFFER_PITCH_NV = 0x9028;
	enum VIDEO_COLOR_CONVERSION_MATRIX_NV = 0x9029;
	enum VIDEO_COLOR_CONVERSION_MAX_NV = 0x902A;
	enum VIDEO_COLOR_CONVERSION_MIN_NV = 0x902B;
	enum VIDEO_COLOR_CONVERSION_OFFSET_NV = 0x902C;
	enum VIDEO_BUFFER_INTERNAL_FORMAT_NV = 0x902D;
	enum PARTIAL_SUCCESS_NV = 0x902E;
	enum SUCCESS_NV = 0x902F;
	enum FAILURE_NV = 0x9030;
	enum YCBYCR8_422_NV = 0x9031;
	enum YCBAYCR8A_4224_NV = 0x9032;
	enum Z6Y10Z6CB10Z6Y10Z6CR10_422_NV = 0x9033;
	enum Z6Y10Z6CB10Z6A10Z6Y10Z6CR10Z6A10_4224_NV = 0x9034;
	enum Z4Y12Z4CB12Z4Y12Z4CR12_422_NV = 0x9035;
	enum Z4Y12Z4CB12Z4A12Z4Y12Z4CR12Z4A12_4224_NV = 0x9036;
	enum Z4Y12Z4CB12Z4CR12_444_NV = 0x9037;
	enum VIDEO_CAPTURE_FRAME_WIDTH_NV = 0x9038;
	enum VIDEO_CAPTURE_FRAME_HEIGHT_NV = 0x9039;
	enum VIDEO_CAPTURE_FIELD_UPPER_HEIGHT_NV = 0x903A;
	enum VIDEO_CAPTURE_FIELD_LOWER_HEIGHT_NV = 0x903B;
	enum VIDEO_CAPTURE_SURFACE_ORIGIN_NV = 0x903C;
	void beginVideoCaptureNV(UInt video_capture_slot);
	void bindVideoCaptureStreamBufferNV(UInt video_capture_slot, UInt stream,
			Enum frame_region, GLintptrARB offset);
	void bindVideoCaptureStreamTextureNV(UInt video_capture_slot,
			UInt stream, Enum frame_region, Enum target, UInt texture);
	void endVideoCaptureNV(UInt video_capture_slot);
	void getVideoCaptureivNV(UInt video_capture_slot, Enum pname, Int* params);
	void getVideoCaptureStreamivNV(UInt video_capture_slot, UInt stream,
			Enum pname, Int* params);
	void getVideoCaptureStreamfvNV(UInt video_capture_slot, UInt stream,
			Enum pname, Float* params);
	void getVideoCaptureStreamdvNV(UInt video_capture_slot, UInt stream,
			Enum pname, Double* params);
	Enum videoCaptureNV(UInt video_capture_slot, UInt* sequence_num,
			GLuint64EXT* capture_time);
	void videoCaptureStreamParameterivNV(UInt video_capture_slot,
			UInt stream, Enum pname, const(Int)* params);
	void videoCaptureStreamParameterfvNV(UInt video_capture_slot,
			UInt stream, Enum pname, const(Float)* params);
	void videoCaptureStreamParameterdvNV(UInt video_capture_slot,
			UInt stream, Enum pname, const(Double)* params);

	enum VIEWPORT_SWIZZLE_POSITIVE_X_NV = 0x9350;
	enum VIEWPORT_SWIZZLE_NEGATIVE_X_NV = 0x9351;
	enum VIEWPORT_SWIZZLE_POSITIVE_Y_NV = 0x9352;
	enum VIEWPORT_SWIZZLE_NEGATIVE_Y_NV = 0x9353;
	enum VIEWPORT_SWIZZLE_POSITIVE_Z_NV = 0x9354;
	enum VIEWPORT_SWIZZLE_NEGATIVE_Z_NV = 0x9355;
	enum VIEWPORT_SWIZZLE_POSITIVE_W_NV = 0x9356;
	enum VIEWPORT_SWIZZLE_NEGATIVE_W_NV = 0x9357;
	enum VIEWPORT_SWIZZLE_X_NV = 0x9358;
	enum VIEWPORT_SWIZZLE_Y_NV = 0x9359;
	enum VIEWPORT_SWIZZLE_Z_NV = 0x935A;
	enum VIEWPORT_SWIZZLE_W_NV = 0x935B;
	void viewportSwizzleNV(UInt index, Enum swizzlex, Enum swizzley,
			Enum swizzlez, Enum swizzlew);

	enum INTERLACE_OML = 0x8980;
	enum INTERLACE_READ_OML = 0x8981;

	enum PACK_RESAMPLE_OML = 0x8984;
	enum UNPACK_RESAMPLE_OML = 0x8985;
	enum RESAMPLE_REPLICATE_OML = 0x8986;
	enum RESAMPLE_ZERO_FILL_OML = 0x8987;
	enum RESAMPLE_AVERAGE_OML = 0x8988;
	enum RESAMPLE_DECIMATE_OML = 0x8989;

	enum FORMAT_SUBSAMPLE_24_24_OML = 0x8982;
	enum FORMAT_SUBSAMPLE_244_244_OML = 0x8983;

	enum FRAMEBUFFER_ATTACHMENT_TEXTURE_NUM_VIEWS_OVR = 0x9630;
	enum FRAMEBUFFER_ATTACHMENT_TEXTURE_BASE_VIEW_INDEX_OVR = 0x9632;
	enum MAX_VIEWS_OVR = 0x9631;
	enum FRAMEBUFFER_INCOMPLETE_VIEW_TARGETS_OVR = 0x9633;
	void framebufferTextureMultiviewOVR(Enum target, Enum attachment,
			UInt texture, Int level, Int baseViewIndex, Sizei numViews);

	enum PREFER_DOUBLEBUFFER_HINT_PGI = 0x1A1F8;
	enum CONSERVE_MEMORY_HINT_PGI = 0x1A1FD;
	enum RECLAIM_MEMORY_HINT_PGI = 0x1A1FE;
	enum NATIVE_GRAPHICS_HANDLE_PGI = 0x1A202;
	enum NATIVE_GRAPHICS_BEGIN_HINT_PGI = 0x1A203;
	enum NATIVE_GRAPHICS_END_HINT_PGI = 0x1A204;
	enum ALWAYS_FAST_HINT_PGI = 0x1A20C;
	enum ALWAYS_SOFT_HINT_PGI = 0x1A20D;
	enum ALLOW_DRAW_OBJ_HINT_PGI = 0x1A20E;
	enum ALLOW_DRAW_WIN_HINT_PGI = 0x1A20F;
	enum ALLOW_DRAW_FRG_HINT_PGI = 0x1A210;
	enum ALLOW_DRAW_MEM_HINT_PGI = 0x1A211;
	enum STRICT_DEPTHFUNC_HINT_PGI = 0x1A216;
	enum STRICT_LIGHTING_HINT_PGI = 0x1A217;
	enum STRICT_SCISSOR_HINT_PGI = 0x1A218;
	enum FULL_STIPPLE_HINT_PGI = 0x1A219;
	enum CLIP_NEAR_HINT_PGI = 0x1A220;
	enum CLIP_FAR_HINT_PGI = 0x1A221;
	enum WIDE_LINE_HINT_PGI = 0x1A222;
	enum BACK_NORMALS_HINT_PGI = 0x1A223;
	void hintPGI(Enum target, Int mode);

	enum VERTEX_DATA_HINT_PGI = 0x1A22A;
	enum VERTEX_CONSISTENT_HINT_PGI = 0x1A22B;
	enum MATERIAL_SIDE_HINT_PGI = 0x1A22C;
	enum MAX_VERTEX_HINT_PGI = 0x1A22D;
	enum COLOR3_BIT_PGI = 0x00010000;
	enum COLOR4_BIT_PGI = 0x00020000;
	enum EDGEFLAG_BIT_PGI = 0x00040000;
	enum INDEX_BIT_PGI = 0x00080000;
	enum MAT_AMBIENT_BIT_PGI = 0x00100000;
	enum MAT_AMBIENT_AND_DIFFUSE_BIT_PGI = 0x00200000;
	enum MAT_DIFFUSE_BIT_PGI = 0x00400000;
	enum MAT_EMISSION_BIT_PGI = 0x00800000;
	enum MAT_COLOR_INDEXES_BIT_PGI = 0x01000000;
	enum MAT_SHININESS_BIT_PGI = 0x02000000;
	enum MAT_SPECULAR_BIT_PGI = 0x04000000;
	enum NORMAL_BIT_PGI = 0x08000000;
	enum TEXCOORD1_BIT_PGI = 0x10000000;
	enum TEXCOORD2_BIT_PGI = 0x20000000;
	enum TEXCOORD3_BIT_PGI = 0x40000000;
	enum TEXCOORD4_BIT_PGI = 0x80000000;
	enum VERTEX23_BIT_PGI = 0x00000004;
	enum VERTEX4_BIT_PGI = 0x00000008;

	enum SCREEN_COORDINATES_REND = 0x8490;
	enum INVERTED_SCREEN_W_REND = 0x8491;

	enum RGB_S3TC = 0x83A0;
	enum RGB4_S3TC = 0x83A1;
	enum RGBA_S3TC = 0x83A2;
	enum RGBA4_S3TC = 0x83A3;
	enum RGBA_DXT5_S3TC = 0x83A4;
	enum RGBA4_DXT5_S3TC = 0x83A5;

	enum DETAIL_TEXTURE_2D_SGIS = 0x8095;
	enum DETAIL_TEXTURE_2D_BINDING_SGIS = 0x8096;
	enum LINEAR_DETAIL_SGIS = 0x8097;
	enum LINEAR_DETAIL_ALPHA_SGIS = 0x8098;
	enum LINEAR_DETAIL_COLOR_SGIS = 0x8099;
	enum DETAIL_TEXTURE_LEVEL_SGIS = 0x809A;
	enum DETAIL_TEXTURE_MODE_SGIS = 0x809B;
	enum DETAIL_TEXTURE_FUNC_POINTS_SGIS = 0x809C;
	void detailTexFuncSGIS(Enum target, Sizei n, const(Float)* points);
	void getDetailTexFuncSGIS(Enum target, Float* points);

	enum FOG_FUNC_SGIS = 0x812A;
	enum FOG_FUNC_POINTS_SGIS = 0x812B;
	enum MAX_FOG_FUNC_POINTS_SGIS = 0x812C;
	void fogFuncSGIS(Sizei n, const(Float)* points);
	void getFogFuncSGIS(Float* points);

	enum GENERATE_MIPMAP_SGIS = 0x8191;
	enum GENERATE_MIPMAP_HINT_SGIS = 0x8192;

	enum MULTISAMPLE_SGIS = 0x809D;
	enum SAMPLE_ALPHA_TO_MASK_SGIS = 0x809E;
	enum SAMPLE_ALPHA_TO_ONE_SGIS = 0x809F;
	enum SAMPLE_MASK_SGIS = 0x80A0;
	enum GL_1PASS_SGIS = 0x80A1;
	enum GL_2PASS_0_SGIS = 0x80A2;
	enum GL_2PASS_1_SGIS = 0x80A3;
	enum GL_4PASS_0_SGIS = 0x80A4;
	enum GL_4PASS_1_SGIS = 0x80A5;
	enum GL_4PASS_2_SGIS = 0x80A6;
	enum GL_4PASS_3_SGIS = 0x80A7;
	enum SAMPLE_BUFFERS_SGIS = 0x80A8;
	enum SAMPLES_SGIS = 0x80A9;
	enum SAMPLE_MASK_VALUE_SGIS = 0x80AA;
	enum SAMPLE_MASK_INVERT_SGIS = 0x80AB;
	enum SAMPLE_PATTERN_SGIS = 0x80AC;
	void sampleMaskSGIS(Clampf value, Boolean invert);
	void samplePatternSGIS(Enum pattern);

	enum PIXEL_TEXTURE_SGIS = 0x8353;
	enum PIXEL_FRAGMENT_RGB_SOURCE_SGIS = 0x8354;
	enum PIXEL_FRAGMENT_ALPHA_SOURCE_SGIS = 0x8355;
	enum PIXEL_GROUP_COLOR_SGIS = 0x8356;
	void pixelTexGenParameteriSGIS(Enum pname, Int param);
	void pixelTexGenParameterivSGIS(Enum pname, const(Int)* params);
	void pixelTexGenParameterfSGIS(Enum pname, Float param);
	void pixelTexGenParameterfvSGIS(Enum pname, const(Float)* params);
	void getPixelTexGenParameterivSGIS(Enum pname, Int* params);
	void getPixelTexGenParameterfvSGIS(Enum pname, Float* params);

	enum EYE_DISTANCE_TO_POINT_SGIS = 0x81F0;
	enum OBJECT_DISTANCE_TO_POINT_SGIS = 0x81F1;
	enum EYE_DISTANCE_TO_LINE_SGIS = 0x81F2;
	enum OBJECT_DISTANCE_TO_LINE_SGIS = 0x81F3;
	enum EYE_POINT_SGIS = 0x81F4;
	enum OBJECT_POINT_SGIS = 0x81F5;
	enum EYE_LINE_SGIS = 0x81F6;
	enum OBJECT_LINE_SGIS = 0x81F7;

	enum POINT_SIZE_MIN_SGIS = 0x8126;
	enum POINT_SIZE_MAX_SGIS = 0x8127;
	enum POINT_FADE_THRESHOLD_SIZE_SGIS = 0x8128;
	enum DISTANCE_ATTENUATION_SGIS = 0x8129;
	void pointParameterfSGIS(Enum pname, Float param);
	void pointParameterfvSGIS(Enum pname, const(Float)* params);

	enum LINEAR_SHARPEN_SGIS = 0x80AD;
	enum LINEAR_SHARPEN_ALPHA_SGIS = 0x80AE;
	enum LINEAR_SHARPEN_COLOR_SGIS = 0x80AF;
	enum SHARPEN_TEXTURE_FUNC_POINTS_SGIS = 0x80B0;
	void sharpenTexFuncSGIS(Enum target, Sizei n, const(Float)* points);
	void getSharpenTexFuncSGIS(Enum target, Float* points);

	enum PACK_SKIP_VOLUMES_SGIS = 0x8130;
	enum PACK_IMAGE_DEPTH_SGIS = 0x8131;
	enum UNPACK_SKIP_VOLUMES_SGIS = 0x8132;
	enum UNPACK_IMAGE_DEPTH_SGIS = 0x8133;
	enum TEXTURE_4D_SGIS = 0x8134;
	enum PROXY_TEXTURE_4D_SGIS = 0x8135;
	enum TEXTURE_4DSIZE_SGIS = 0x8136;
	enum TEXTURE_WRAP_Q_SGIS = 0x8137;
	enum MAX_4D_TEXTURE_SIZE_SGIS = 0x8138;
	enum TEXTURE_4D_BINDING_SGIS = 0x814F;
	void texImage4DSGIS(Enum target, Int level, Enum internalformat, Sizei width, Sizei height,
			Sizei depth, Sizei size4d, Int border, Enum format,
			Enum type, const(void)* pixels);
	void texSubImage4DSGIS(Enum target, Int level, Int xoffset, Int yoffset, Int zoffset,
			Int woffset, Sizei width, Sizei height, Sizei depth,
			Sizei size4d, Enum format, Enum type, const(void)* pixels);

	enum CLAMP_TO_BORDER_SGIS = 0x812D;

	enum TEXTURE_COLOR_WRITEMASK_SGIS = 0x81EF;
	void textureColorMaskSGIS(Boolean red, Boolean green, Boolean blue, Boolean alpha);

	enum CLAMP_TO_EDGE_SGIS = 0x812F;

	enum FILTER4_SGIS = 0x8146;
	enum TEXTURE_FILTER4_SIZE_SGIS = 0x8147;
	void getTexFilterFuncSGIS(Enum target, Enum filter, Float* weights);
	void texFilterFuncSGIS(Enum target, Enum filter, Sizei n, const(Float)* weights);

	enum TEXTURE_MIN_LOD_SGIS = 0x813A;
	enum TEXTURE_MAX_LOD_SGIS = 0x813B;
	enum TEXTURE_BASE_LEVEL_SGIS = 0x813C;
	enum TEXTURE_MAX_LEVEL_SGIS = 0x813D;

	enum DUAL_ALPHA4_SGIS = 0x8110;
	enum DUAL_ALPHA8_SGIS = 0x8111;
	enum DUAL_ALPHA12_SGIS = 0x8112;
	enum DUAL_ALPHA16_SGIS = 0x8113;
	enum DUAL_LUMINANCE4_SGIS = 0x8114;
	enum DUAL_LUMINANCE8_SGIS = 0x8115;
	enum DUAL_LUMINANCE12_SGIS = 0x8116;
	enum DUAL_LUMINANCE16_SGIS = 0x8117;
	enum DUAL_INTENSITY4_SGIS = 0x8118;
	enum DUAL_INTENSITY8_SGIS = 0x8119;
	enum DUAL_INTENSITY12_SGIS = 0x811A;
	enum DUAL_INTENSITY16_SGIS = 0x811B;
	enum DUAL_LUMINANCE_ALPHA4_SGIS = 0x811C;
	enum DUAL_LUMINANCE_ALPHA8_SGIS = 0x811D;
	enum QUAD_ALPHA4_SGIS = 0x811E;
	enum QUAD_ALPHA8_SGIS = 0x811F;
	enum QUAD_LUMINANCE4_SGIS = 0x8120;
	enum QUAD_LUMINANCE8_SGIS = 0x8121;
	enum QUAD_INTENSITY4_SGIS = 0x8122;
	enum QUAD_INTENSITY8_SGIS = 0x8123;
	enum DUAL_TEXTURE_SELECT_SGIS = 0x8124;
	enum QUAD_TEXTURE_SELECT_SGIS = 0x8125;

	enum ASYNC_MARKER_SGIX = 0x8329;
	void asyncMarkerSGIX(UInt marker);
	Int finishAsyncSGIX(UInt* markerp);
	Int pollAsyncSGIX(UInt* markerp);
	UInt genAsyncMarkersSGIX(Sizei range);
	void deleteAsyncMarkersSGIX(UInt marker, Sizei range);
	Boolean isAsyncMarkerSGIX(UInt marker);

	enum ASYNC_HISTOGRAM_SGIX = 0x832C;
	enum MAX_ASYNC_HISTOGRAM_SGIX = 0x832D;

	enum ASYNC_TEX_IMAGE_SGIX = 0x835C;
	enum ASYNC_DRAW_PIXELS_SGIX = 0x835D;
	enum ASYNC_READ_PIXELS_SGIX = 0x835E;
	enum MAX_ASYNC_TEX_IMAGE_SGIX = 0x835F;
	enum MAX_ASYNC_DRAW_PIXELS_SGIX = 0x8360;
	enum MAX_ASYNC_READ_PIXELS_SGIX = 0x8361;

	enum ALPHA_MIN_SGIX = 0x8320;
	enum ALPHA_MAX_SGIX = 0x8321;

	enum CALLIGRAPHIC_FRAGMENT_SGIX = 0x8183;

	enum LINEAR_CLIPMAP_LINEAR_SGIX = 0x8170;
	enum TEXTURE_CLIPMAP_CENTER_SGIX = 0x8171;
	enum TEXTURE_CLIPMAP_FRAME_SGIX = 0x8172;
	enum TEXTURE_CLIPMAP_OFFSET_SGIX = 0x8173;
	enum TEXTURE_CLIPMAP_VIRTUAL_DEPTH_SGIX = 0x8174;
	enum TEXTURE_CLIPMAP_LOD_OFFSET_SGIX = 0x8175;
	enum TEXTURE_CLIPMAP_DEPTH_SGIX = 0x8176;
	enum MAX_CLIPMAP_DEPTH_SGIX = 0x8177;
	enum MAX_CLIPMAP_VIRTUAL_DEPTH_SGIX = 0x8178;
	enum NEAREST_CLIPMAP_NEAREST_SGIX = 0x844D;
	enum NEAREST_CLIPMAP_LINEAR_SGIX = 0x844E;
	enum LINEAR_CLIPMAP_NEAREST_SGIX = 0x844F;

	enum CONVOLUTION_HINT_SGIX = 0x8316;

	enum DEPTH_COMPONENT16_SGIX = 0x81A5;
	enum DEPTH_COMPONENT24_SGIX = 0x81A6;
	enum DEPTH_COMPONENT32_SGIX = 0x81A7;

	void flushRasterSGIX();

	enum FOG_OFFSET_SGIX = 0x8198;
	enum FOG_OFFSET_VALUE_SGIX = 0x8199;

	enum FRAGMENT_LIGHTING_SGIX = 0x8400;
	enum FRAGMENT_COLOR_MATERIAL_SGIX = 0x8401;
	enum FRAGMENT_COLOR_MATERIAL_FACE_SGIX = 0x8402;
	enum FRAGMENT_COLOR_MATERIAL_PARAMETER_SGIX = 0x8403;
	enum MAX_FRAGMENT_LIGHTS_SGIX = 0x8404;
	enum MAX_ACTIVE_LIGHTS_SGIX = 0x8405;
	enum CURRENT_RASTER_NORMAL_SGIX = 0x8406;
	enum LIGHT_ENV_MODE_SGIX = 0x8407;
	enum FRAGMENT_LIGHT_MODEL_LOCAL_VIEWER_SGIX = 0x8408;
	enum FRAGMENT_LIGHT_MODEL_TWO_SIDE_SGIX = 0x8409;
	enum FRAGMENT_LIGHT_MODEL_AMBIENT_SGIX = 0x840A;
	enum FRAGMENT_LIGHT_MODEL_NORMAL_INTERPOLATION_SGIX = 0x840B;
	enum FRAGMENT_LIGHT0_SGIX = 0x840C;
	enum FRAGMENT_LIGHT1_SGIX = 0x840D;
	enum FRAGMENT_LIGHT2_SGIX = 0x840E;
	enum FRAGMENT_LIGHT3_SGIX = 0x840F;
	enum FRAGMENT_LIGHT4_SGIX = 0x8410;
	enum FRAGMENT_LIGHT5_SGIX = 0x8411;
	enum FRAGMENT_LIGHT6_SGIX = 0x8412;
	enum FRAGMENT_LIGHT7_SGIX = 0x8413;
	void fragmentColorMaterialSGIX(Enum face, Enum mode);
	void fragmentLightfSGIX(Enum light, Enum pname, Float param);
	void fragmentLightfvSGIX(Enum light, Enum pname, const(Float)* params);
	void fragmentLightiSGIX(Enum light, Enum pname, Int param);
	void fragmentLightivSGIX(Enum light, Enum pname, const(Int)* params);
	void fragmentLightModelfSGIX(Enum pname, Float param);
	void fragmentLightModelfvSGIX(Enum pname, const(Float)* params);
	void fragmentLightModeliSGIX(Enum pname, Int param);
	void fragmentLightModelivSGIX(Enum pname, const(Int)* params);
	void fragmentMaterialfSGIX(Enum face, Enum pname, Float param);
	void fragmentMaterialfvSGIX(Enum face, Enum pname, const(Float)* params);
	void fragmentMaterialiSGIX(Enum face, Enum pname, Int param);
	void fragmentMaterialivSGIX(Enum face, Enum pname, const(Int)* params);
	void getFragmentLightfvSGIX(Enum light, Enum pname, Float* params);
	void getFragmentLightivSGIX(Enum light, Enum pname, Int* params);
	void getFragmentMaterialfvSGIX(Enum face, Enum pname, Float* params);
	void getFragmentMaterialivSGIX(Enum face, Enum pname, Int* params);
	void lightEnviSGIX(Enum pname, Int param);

	enum FRAMEZOOM_SGIX = 0x818B;
	enum FRAMEZOOM_FACTOR_SGIX = 0x818C;
	enum MAX_FRAMEZOOM_FACTOR_SGIX = 0x818D;
	void frameZoomSGIX(Int factor);

	void iglooInterfaceSGIX(Enum pname, const(void)* params);

	enum INSTRUMENT_BUFFER_POINTER_SGIX = 0x8180;
	enum INSTRUMENT_MEASUREMENTS_SGIX = 0x8181;
	Int getInstrumentsSGIX();
	void instrumentsBufferSGIX(Sizei size, Int* buffer);
	Int pollInstrumentsSGIX(Int* marker_p);
	void readInstrumentsSGIX(Int marker);
	void startInstrumentsSGIX();
	void stopInstrumentsSGIX(Int marker);

	enum INTERLACE_SGIX = 0x8094;

	enum IR_INSTRUMENT1_SGIX = 0x817F;

	enum LIST_PRIORITY_SGIX = 0x8182;
	void getListParameterfvSGIX(UInt list, Enum pname, Float* params);
	void getListParameterivSGIX(UInt list, Enum pname, Int* params);
	void listParameterfSGIX(UInt list, Enum pname, Float param);
	void listParameterfvSGIX(UInt list, Enum pname, const(Float)* params);
	void listParameteriSGIX(UInt list, Enum pname, Int param);
	void listParameterivSGIX(UInt list, Enum pname, const(Int)* params);

	enum PIXEL_TEX_GEN_SGIX = 0x8139;
	enum PIXEL_TEX_GEN_MODE_SGIX = 0x832B;
	void pixelTexGenSGIX(Enum mode);

	enum PIXEL_TILE_BEST_ALIGNMENT_SGIX = 0x813E;
	enum PIXEL_TILE_CACHE_INCREMENT_SGIX = 0x813F;
	enum PIXEL_TILE_WIDTH_SGIX = 0x8140;
	enum PIXEL_TILE_HEIGHT_SGIX = 0x8141;
	enum PIXEL_TILE_GRID_WIDTH_SGIX = 0x8142;
	enum PIXEL_TILE_GRID_HEIGHT_SGIX = 0x8143;
	enum PIXEL_TILE_GRID_DEPTH_SGIX = 0x8144;
	enum PIXEL_TILE_CACHE_SIZE_SGIX = 0x8145;

	enum TEXTURE_DEFORMATION_BIT_SGIX = 0x00000001;
	enum GEOMETRY_DEFORMATION_BIT_SGIX = 0x00000002;
	enum GEOMETRY_DEFORMATION_SGIX = 0x8194;
	enum TEXTURE_DEFORMATION_SGIX = 0x8195;
	enum DEFORMATIONS_MASK_SGIX = 0x8196;
	enum MAX_DEFORMATION_ORDER_SGIX = 0x8197;
	void deformationMap3dSGIX(Enum target, Double u1, Double u2, Int ustride,
			Int uorder, Double v1, Double v2, Int vstride, Int vorder, Double w1,
			Double w2, Int wstride, Int worder, const(Double)* points);
	void deformationMap3fSGIX(Enum target, Float u1, Float u2, Int ustride,
			Int uorder, Float v1, Float v2, Int vstride, Int vorder, Float w1,
			Float w2, Int wstride, Int worder, const(Float)* points);
	void deformSGIX(Bitfield mask);
	void loadIdentityDeformationMapSGIX(Bitfield mask);

	enum REFERENCE_PLANE_SGIX = 0x817D;
	enum REFERENCE_PLANE_EQUATION_SGIX = 0x817E;
	void referencePlaneSGIX(const(Double)* equation);

	enum PACK_RESAMPLE_SGIX = 0x842E;
	enum UNPACK_RESAMPLE_SGIX = 0x842F;
	enum RESAMPLE_REPLICATE_SGIX = 0x8433;
	enum RESAMPLE_ZERO_FILL_SGIX = 0x8434;
	enum RESAMPLE_DECIMATE_SGIX = 0x8430;

	enum SCALEBIAS_HINT_SGIX = 0x8322;

	enum TEXTURE_COMPARE_SGIX = 0x819A;
	enum TEXTURE_COMPARE_OPERATOR_SGIX = 0x819B;
	enum TEXTURE_LEQUAL_R_SGIX = 0x819C;
	enum TEXTURE_GEQUAL_R_SGIX = 0x819D;

	enum SHADOW_AMBIENT_SGIX = 0x80BF;

	enum SPRITE_SGIX = 0x8148;
	enum SPRITE_MODE_SGIX = 0x8149;
	enum SPRITE_AXIS_SGIX = 0x814A;
	enum SPRITE_TRANSLATION_SGIX = 0x814B;
	enum SPRITE_AXIAL_SGIX = 0x814C;
	enum SPRITE_OBJECT_ALIGNED_SGIX = 0x814D;
	enum SPRITE_EYE_ALIGNED_SGIX = 0x814E;
	void spriteParameterfSGIX(Enum pname, Float param);
	void spriteParameterfvSGIX(Enum pname, const(Float)* params);
	void spriteParameteriSGIX(Enum pname, Int param);
	void spriteParameterivSGIX(Enum pname, const(Int)* params);

	enum PACK_SUBSAMPLE_RATE_SGIX = 0x85A0;
	enum UNPACK_SUBSAMPLE_RATE_SGIX = 0x85A1;
	enum PIXEL_SUBSAMPLE_4444_SGIX = 0x85A2;
	enum PIXEL_SUBSAMPLE_2424_SGIX = 0x85A3;
	enum PIXEL_SUBSAMPLE_4242_SGIX = 0x85A4;

	void tagSampleBufferSGIX();

	enum TEXTURE_ENV_BIAS_SGIX = 0x80BE;

	enum TEXTURE_MAX_CLAMP_S_SGIX = 0x8369;
	enum TEXTURE_MAX_CLAMP_T_SGIX = 0x836A;
	enum TEXTURE_MAX_CLAMP_R_SGIX = 0x836B;

	enum TEXTURE_LOD_BIAS_S_SGIX = 0x818E;
	enum TEXTURE_LOD_BIAS_T_SGIX = 0x818F;
	enum TEXTURE_LOD_BIAS_R_SGIX = 0x8190;

	enum TEXTURE_MULTI_BUFFER_HINT_SGIX = 0x812E;

	enum POST_TEXTURE_FILTER_BIAS_SGIX = 0x8179;
	enum POST_TEXTURE_FILTER_SCALE_SGIX = 0x817A;
	enum POST_TEXTURE_FILTER_BIAS_RANGE_SGIX = 0x817B;
	enum POST_TEXTURE_FILTER_SCALE_RANGE_SGIX = 0x817C;

	enum VERTEX_PRECLIP_SGIX = 0x83EE;
	enum VERTEX_PRECLIP_HINT_SGIX = 0x83EF;

	enum YCRCB_422_SGIX = 0x81BB;
	enum YCRCB_444_SGIX = 0x81BC;

	enum YCRCB_SGIX = 0x8318;
	enum YCRCBA_SGIX = 0x8319;

	enum COLOR_MATRIX_SGI = 0x80B1;
	enum COLOR_MATRIX_STACK_DEPTH_SGI = 0x80B2;
	enum MAX_COLOR_MATRIX_STACK_DEPTH_SGI = 0x80B3;
	enum POST_COLOR_MATRIX_RED_SCALE_SGI = 0x80B4;
	enum POST_COLOR_MATRIX_GREEN_SCALE_SGI = 0x80B5;
	enum POST_COLOR_MATRIX_BLUE_SCALE_SGI = 0x80B6;
	enum POST_COLOR_MATRIX_ALPHA_SCALE_SGI = 0x80B7;
	enum POST_COLOR_MATRIX_RED_BIAS_SGI = 0x80B8;
	enum POST_COLOR_MATRIX_GREEN_BIAS_SGI = 0x80B9;
	enum POST_COLOR_MATRIX_BLUE_BIAS_SGI = 0x80BA;
	enum POST_COLOR_MATRIX_ALPHA_BIAS_SGI = 0x80BB;

	enum COLOR_TABLE_SGI = 0x80D0;
	enum POST_CONVOLUTION_COLOR_TABLE_SGI = 0x80D1;
	enum POST_COLOR_MATRIX_COLOR_TABLE_SGI = 0x80D2;
	enum PROXY_COLOR_TABLE_SGI = 0x80D3;
	enum PROXY_POST_CONVOLUTION_COLOR_TABLE_SGI = 0x80D4;
	enum PROXY_POST_COLOR_MATRIX_COLOR_TABLE_SGI = 0x80D5;
	enum COLOR_TABLE_SCALE_SGI = 0x80D6;
	enum COLOR_TABLE_BIAS_SGI = 0x80D7;
	enum COLOR_TABLE_FORMAT_SGI = 0x80D8;
	enum COLOR_TABLE_WIDTH_SGI = 0x80D9;
	enum COLOR_TABLE_RED_SIZE_SGI = 0x80DA;
	enum COLOR_TABLE_GREEN_SIZE_SGI = 0x80DB;
	enum COLOR_TABLE_BLUE_SIZE_SGI = 0x80DC;
	enum COLOR_TABLE_ALPHA_SIZE_SGI = 0x80DD;
	enum COLOR_TABLE_LUMINANCE_SIZE_SGI = 0x80DE;
	enum COLOR_TABLE_INTENSITY_SIZE_SGI = 0x80DF;
	void colorTableSGI(Enum target, Enum internalformat, Sizei width,
			Enum format, Enum type, const(void)* table);
	void colorTableParameterfvSGI(Enum target, Enum pname, const(Float)* params);
	void colorTableParameterivSGI(Enum target, Enum pname, const(Int)* params);
	void copyColorTableSGI(Enum target, Enum internalformat, Int x, Int y, Sizei width);
	void getColorTableSGI(Enum target, Enum format, Enum type, void* table);
	void getColorTableParameterfvSGI(Enum target, Enum pname, Float* params);
	void getColorTableParameterivSGI(Enum target, Enum pname, Int* params);

	enum TEXTURE_COLOR_TABLE_SGI = 0x80BC;
	enum PROXY_TEXTURE_COLOR_TABLE_SGI = 0x80BD;

	enum UNPACK_CONSTANT_DATA_SUNX = 0x81D5;
	enum TEXTURE_CONSTANT_DATA_SUNX = 0x81D6;
	void finishTextureSUNX();

	enum WRAP_BORDER_SUN = 0x81D4;

	enum GLOBAL_ALPHA_SUN = 0x81D9;
	enum GLOBAL_ALPHA_FACTOR_SUN = 0x81DA;
	void globalAlphaFactorbSUN(Byte factor);
	void globalAlphaFactorsSUN(Short factor);
	void globalAlphaFactoriSUN(Int factor);
	void globalAlphaFactorfSUN(Float factor);
	void globalAlphaFactordSUN(Double factor);
	void globalAlphaFactorubSUN(UByte factor);
	void globalAlphaFactorusSUN(UShort factor);
	void globalAlphaFactoruiSUN(UInt factor);

	enum QUAD_MESH_SUN = 0x8614;
	enum TRIANGLE_MESH_SUN = 0x8615;
	void drawMeshArraysSUN(Enum mode, Int first, Sizei count, Sizei width);

	enum SLICE_ACCUM_SUN = 0x85CC;

	enum RESTART_SUN = 0x0001;
	enum REPLACE_MIDDLE_SUN = 0x0002;
	enum REPLACE_OLDEST_SUN = 0x0003;
	enum TRIANGLE_LIST_SUN = 0x81D7;
	enum REPLACEMENT_CODE_SUN = 0x81D8;
	enum REPLACEMENT_CODE_ARRAY_SUN = 0x85C0;
	enum REPLACEMENT_CODE_ARRAY_TYPE_SUN = 0x85C1;
	enum REPLACEMENT_CODE_ARRAY_STRIDE_SUN = 0x85C2;
	enum REPLACEMENT_CODE_ARRAY_POINTER_SUN = 0x85C3;
	enum R1UI_V3F_SUN = 0x85C4;
	enum R1UI_C4UB_V3F_SUN = 0x85C5;
	enum R1UI_C3F_V3F_SUN = 0x85C6;
	enum R1UI_N3F_V3F_SUN = 0x85C7;
	enum R1UI_C4F_N3F_V3F_SUN = 0x85C8;
	enum R1UI_T2F_V3F_SUN = 0x85C9;
	enum R1UI_T2F_N3F_V3F_SUN = 0x85CA;
	enum R1UI_T2F_C4F_N3F_V3F_SUN = 0x85CB;
	void replacementCodeuiSUN(UInt code);
	void replacementCodeusSUN(UShort code);
	void replacementCodeubSUN(UByte code);
	void replacementCodeuivSUN(const(UInt)* code);
	void replacementCodeusvSUN(const(UShort)* code);
	void replacementCodeubvSUN(const(UByte)* code);
	void replacementCodePointerSUN(Enum type, Sizei stride, const(void*)* pointer);

	void color4UbVertex2fSUN(UByte r, UByte g, UByte b, UByte a, Float x, Float y);
	void color4UbVertex2fvSUN(const(UByte)* c, const(Float)* v);
	void color4UbVertex3fSUN(UByte r, UByte g, UByte b, UByte a,
			Float x, Float y, Float z);
	void color4UbVertex3fvSUN(const(UByte)* c, const(Float)* v);
	void color3fVertex3fSUN(Float r, Float g, Float b, Float x, Float y, Float z);
	void color3fVertex3fvSUN(const(Float)* c, const(Float)* v);
	void normal3fVertex3fSUN(Float nx, Float ny, Float nz, Float x, Float y, Float z);
	void normal3fVertex3fvSUN(const(Float)* n, const(Float)* v);
	void color4fNormal3fVertex3fSUN(Float r, Float g, Float b, Float a,
			Float nx, Float ny, Float nz, Float x, Float y, Float z);
	void color4fNormal3fVertex3fvSUN(const(Float)* c, const(Float)* n, const(Float)* v);
	void texCoord2fVertex3fSUN(Float s, Float t, Float x, Float y, Float z);
	void texCoord2fVertex3fvSUN(const(Float)* tc, const(Float)* v);
	void texCoord4fVertex4fSUN(Float s, Float t, Float p, Float q,
			Float x, Float y, Float z, Float w);
	void texCoord4fVertex4fvSUN(const(Float)* tc, const(Float)* v);
	void texCoord2fColor4UbVertex3fSUN(Float s, Float t, UByte r, UByte g,
			UByte b, UByte a, Float x, Float y, Float z);
	void texCoord2fColor4UbVertex3fvSUN(const(Float)* tc, const(UByte)* c, const(Float)* v);
	void texCoord2fColor3fVertex3fSUN(Float s, Float t, Float r, Float g,
			Float b, Float x, Float y, Float z);
	void texCoord2fColor3fVertex3fvSUN(const(Float)* tc, const(Float)* c, const(Float)* v);
	void texCoord2fNormal3fVertex3fSUN(Float s, Float t, Float nx,
			Float ny, Float nz, Float x, Float y, Float z);
	void texCoord2fNormal3fVertex3fvSUN(const(Float)* tc, const(Float)* n, const(Float)* v);
	void texCoord2fColor4fNormal3fVertex3fSUN(Float s, Float t, Float r, Float g,
			Float b, Float a, Float nx, Float ny, Float nz, Float x, Float y,
			Float z);
	void texCoord2fColor4fNormal3fVertex3fvSUN(const(Float)* tc,
			const(Float)* c, const(Float)* n, const(Float)* v);
	void texCoord4fColor4fNormal3fVertex4fSUN(Float s, Float t, Float p, Float q,
			Float r, Float g, Float b, Float a, Float nx, Float ny,
			Float nz, Float x, Float y, Float z, Float w);
	void texCoord4fColor4fNormal3fVertex4fvSUN(const(Float)* tc,
			const(Float)* c, const(Float)* n, const(Float)* v);
	void replacementCodeuiVertex3fSUN(UInt rc, Float x, Float y, Float z);
	void replacementCodeuiVertex3fvSUN(const(UInt)* rc, const(Float)* v);
	void replacementCodeuiColor4UbVertex3fSUN(UInt rc, UByte r, UByte g,
			UByte b, UByte a, Float x, Float y, Float z);
	void replacementCodeuiColor4UbVertex3fvSUN(const(UInt)* rc,
			const(UByte)* c, const(Float)* v);
	void replacementCodeuiColor3fVertex3fSUN(UInt rc, Float r, Float g,
			Float b, Float x, Float y, Float z);
	void replacementCodeuiColor3fVertex3fvSUN(const(UInt)* rc,
			const(Float)* c, const(Float)* v);
	void replacementCodeuiNormal3fVertex3fSUN(UInt rc, Float nx, Float ny,
			Float nz, Float x, Float y, Float z);
	void replacementCodeuiNormal3fVertex3fvSUN(const(UInt)* rc,
			const(Float)* n, const(Float)* v);
	void replacementCodeuiColor4fNormal3fVertex3fSUN(UInt rc, Float r, Float g,
			Float b, Float a, Float nx, Float ny, Float nz, Float x, Float y,
			Float z);
	void replacementCodeuiColor4fNormal3fVertex3fvSUN(const(UInt)* rc,
			const(Float)* c, const(Float)* n, const(Float)* v);
	void replacementCodeuiTexCoord2fVertex3fSUN(UInt rc, Float s, Float t,
			Float x, Float y, Float z);
	void replacementCodeuiTexCoord2fVertex3fvSUN(const(UInt)* rc,
			const(Float)* tc, const(Float)* v);
	void replacementCodeuiTexCoord2fNormal3fVertex3fSUN(UInt rc, Float s,
			Float t, Float nx, Float ny, Float nz, Float x, Float y, Float z);
	void replacementCodeuiTexCoord2fNormal3fVertex3fvSUN(const(UInt)* rc,
			const(Float)* tc, const(Float)* n, const(Float)* v);
	void replacementCodeuiTexCoord2fColor4fNormal3fVertex3fSUN(UInt rc, Float s, Float t,
			Float r, Float g, Float b, Float a, Float nx, Float ny,
			Float nz, Float x, Float y, Float z);
	void replacementCodeuiTexCoord2fColor4fNormal3fVertex3fvSUN(const(UInt)* rc,
			const(Float)* tc, const(Float)* c, const(Float)* n, const(Float)* v);

	enum PHONG_WIN = 0x80EA;
	enum PHONG_HINT_WIN = 0x80EB;

	enum FOG_SPECULAR_TEXTURE_WIN = 0x80EC;
}
