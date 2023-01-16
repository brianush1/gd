module gd.bindings.glx;
import gd.bindings.x11;
import gd.bindings.gl;
import gd.bindings.loader;
import gd.resource;
import core.stdc.config;
import core.stdc.stddef;

private static GLXLibrary m_GLX;
GLXLibrary GLX() @property { // @suppress(dscanner.confusing.function_attributes)
	if (m_GLX is null) {
		m_GLX = loadGLX;
		registerLibraryResource(m_GLX);
	}

	return m_GLX;
}

GLXLibrary loadGLX() {
	string[] libraries;

	version (Posix) {
		libraries = ["libGL.so.1", "libGL.so"];
	}
	else {
		static assert(0, "unsupported platform");
	}

	return loadSharedLibrary!(GLXLibrary, delegate(string name) {
		return "glX" ~ cast(char)(name[0] + 'A' - 'a') ~ name[1 .. $];
	})(libraries);
}

abstract class GLXLibrary : Resource {
extern (System) @nogc nothrow:
	// file '/usr/include/GL/glx.h'

	import core.stdc.config;

	enum GLX_VERSION_1_1 = 1;
	enum GLX_VERSION_1_2 = 1;
	enum GLX_VERSION_1_3 = 1;
	enum GLX_VERSION_1_4 = 1;

	enum EXTENSION_NAME = "GLX";

	enum USE_GL = 1;
	enum BUFFER_SIZE = 2;
	enum LEVEL = 3;
	enum RGBA = 4;
	enum DOUBLEBUFFER = 5;
	enum STEREO = 6;
	enum AUX_BUFFERS = 7;
	enum RED_SIZE = 8;
	enum GREEN_SIZE = 9;
	enum BLUE_SIZE = 10;
	enum ALPHA_SIZE = 11;
	enum DEPTH_SIZE = 12;
	enum STENCIL_SIZE = 13;
	enum ACCUM_RED_SIZE = 14;
	enum ACCUM_GREEN_SIZE = 15;
	enum ACCUM_BLUE_SIZE = 16;
	enum ACCUM_ALPHA_SIZE = 17;

	enum BAD_SCREEN = 1;
	enum BAD_ATTRIBUTE = 2;
	enum NO_EXTENSION = 3;
	enum BAD_VISUAL = 4;
	enum BAD_CONTEXT = 5;
	enum BAD_VALUE = 6;
	enum BAD_ENUM = 7;

	enum VENDOR = 1;
	enum VERSION = 2;
	enum EXTENSIONS = 3;

	enum CONFIG_CAVEAT = 0x20;
	enum DONT_CARE = 0xFFFFFFFF;
	enum X_VISUAL_TYPE = 0x22;
	enum TRANSPARENT_TYPE = 0x23;
	enum TRANSPARENT_INDEX_VALUE = 0x24;
	enum TRANSPARENT_RED_VALUE = 0x25;
	enum TRANSPARENT_GREEN_VALUE = 0x26;
	enum TRANSPARENT_BLUE_VALUE = 0x27;
	enum TRANSPARENT_ALPHA_VALUE = 0x28;
	enum WINDOW_BIT = 0x00000001;
	enum PIXMAP_BIT = 0x00000002;
	enum PBUFFER_BIT = 0x00000004;
	enum AUX_BUFFERS_BIT = 0x00000010;
	enum FRONT_LEFT_BUFFER_BIT = 0x00000001;
	enum FRONT_RIGHT_BUFFER_BIT = 0x00000002;
	enum BACK_LEFT_BUFFER_BIT = 0x00000004;
	enum BACK_RIGHT_BUFFER_BIT = 0x00000008;
	enum DEPTH_BUFFER_BIT = 0x00000020;
	enum STENCIL_BUFFER_BIT = 0x00000040;
	enum ACCUM_BUFFER_BIT = 0x00000080;
	enum NONE = 0x8000;
	enum SLOW_CONFIG = 0x8001;
	enum TRUE_COLOR = 0x8002;
	enum DIRECT_COLOR = 0x8003;
	enum PSEUDO_COLOR = 0x8004;
	enum STATIC_COLOR = 0x8005;
	enum GRAY_SCALE = 0x8006;
	enum STATIC_GRAY = 0x8007;
	enum TRANSPARENT_RGB = 0x8008;
	enum TRANSPARENT_INDEX = 0x8009;
	enum VISUAL_ID = 0x800B;
	enum SCREEN = 0x800C;
	enum NON_CONFORMANT_CONFIG = 0x800D;
	enum DRAWABLE_TYPE = 0x8010;
	enum RENDER_TYPE = 0x8011;
	enum X_RENDERABLE = 0x8012;
	enum FBCONFIG_ID = 0x8013;
	enum RGBA_TYPE = 0x8014;
	enum COLOR_INDEX_TYPE = 0x8015;
	enum MAX_PBUFFER_WIDTH = 0x8016;
	enum MAX_PBUFFER_HEIGHT = 0x8017;
	enum MAX_PBUFFER_PIXELS = 0x8018;
	enum PRESERVED_CONTENTS = 0x801B;
	enum LARGEST_PBUFFER = 0x801C;
	enum WIDTH = 0x801D;
	enum HEIGHT = 0x801E;
	enum EVENT_MASK = 0x801F;
	enum DAMAGED = 0x8020;
	enum SAVED = 0x8021;
	enum WINDOW = 0x8022;
	enum PBUFFER = 0x8023;
	enum PBUFFER_HEIGHT = 0x8040;
	enum PBUFFER_WIDTH = 0x8041;
	enum RGBA_BIT = 0x00000001;
	enum COLOR_INDEX_BIT = 0x00000002;
	enum PBUFFER_CLOBBER_MASK = 0x08000000;

	enum SAMPLE_BUFFERS = 0x186a0;
	enum SAMPLES = 0x186a1;

	struct Private_GLXcontextRec;
	alias GLXContext = Private_GLXcontextRec*;
	alias GLXPixmap = c_ulong;
	alias GLXDrawable = c_ulong;

	alias GLXFBConfig = Private_GLXFBConfigRec*;
	alias GLXFBConfigID = c_ulong;
	alias GLXContextID = c_ulong;
	alias GLXWindow = c_ulong;
	alias GLXPbuffer = c_ulong;

	enum GLX_PbufferClobber = 0;
	enum GLX_BufferSwapComplete = 1;

	enum __GLX_NUMBER_EVENTS = 17;

	X11.XVisualInfo* chooseVisual(X11.Display* dpy, int screen, int* attribList);

	GLXContext createContext(X11.Display* dpy, X11.XVisualInfo* vis,
			GLXContext shareList, int direct);

	void destroyContext(X11.Display* dpy, GLXContext ctx);

	int makeCurrent(X11.Display* dpy, GLXDrawable drawable, GLXContext ctx);

	void copyContext(X11.Display* dpy, GLXContext src, GLXContext dst, c_ulong mask);

	void swapBuffers(X11.Display* dpy, GLXDrawable drawable);

	GLXPixmap createGLXPixmap(X11.Display* dpy, X11.XVisualInfo* visual, X11.Pixmap pixmap);

	void destroyGLXPixmap(X11.Display* dpy, GLXPixmap pixmap);

	int queryExtension(X11.Display* dpy, int* errorb, int* event);

	int queryVersion(X11.Display* dpy, int* maj, int* min);

	int isDirect(X11.Display* dpy, GLXContext ctx);

	int getConfig(X11.Display* dpy, X11.XVisualInfo* visual, int attrib, int* value);

	GLXContext getCurrentContext();

	GLXDrawable getCurrentDrawable();

	void waitGL();

	void waitX();

	void useXFont(X11.Font font, int first, int count, int list);

	const(char)* queryExtensionsString(X11.Display* dpy, int screen);

	const(char)* queryServerString(X11.Display* dpy, int screen, int name);

	const(char)* getClientString(X11.Display* dpy, int name);

	X11.Display* getCurrentDisplay();

	GLXFBConfig* chooseFBConfig(X11.Display* dpy, int screen, const(int)* attribList, int* nitems);

	int getFBConfigAttrib(X11.Display* dpy, GLXFBConfig config, int attribute, int* value);

	GLXFBConfig* getFBConfigs(X11.Display* dpy, int screen, int* nelements);

	X11.XVisualInfo* getVisualFromFBConfig(X11.Display* dpy, GLXFBConfig config);

	GLXWindow createWindow(X11.Display* dpy, GLXFBConfig config, X11.Window win,
			const(int)* attribList);

	void destroyWindow(X11.Display* dpy, GLXWindow window);

	GLXPixmap createPixmap(X11.Display* dpy, GLXFBConfig config,
			X11.Pixmap pixmap, const(int)* attribList);

	void destroyPixmap(X11.Display* dpy, GLXPixmap pixmap);

	GLXPbuffer createPbuffer(X11.Display* dpy, GLXFBConfig config, const(int)* attribList);

	void destroyPbuffer(X11.Display* dpy, GLXPbuffer pbuf);

	void queryDrawable(X11.Display* dpy, GLXDrawable draw, int attribute, uint* value);

	GLXContext createNewContext(X11.Display* dpy, GLXFBConfig config,
			int renderType, GLXContext shareList, int direct);

	int makeContextCurrent(X11.Display* dpy, GLXDrawable draw, GLXDrawable read, GLXContext ctx);

	GLXDrawable getCurrentReadDrawable();

	int queryContext(X11.Display* dpy, GLXContext ctx, int attribute, int* value);

	void selectEvent(X11.Display* dpy, GLXDrawable drawable, c_ulong mask);

	void getSelectedEvent(X11.Display* dpy, GLXDrawable drawable, c_ulong* mask);

	enum GLX_ARB_get_proc_address = 1;

	alias __GLXextFuncPtr = void function();
	__GLXextFuncPtr getProcAddressARB(const(GL.UByte)*);

	void function(const(GL.UByte)* procname) getProcAddress(const(GL.UByte)* procname);

	void* allocateMemoryNV(GL.Sizei size, GL.Float readfreq, GL.Float writefreq, GL.Float priority);
	void freeMemoryNV(GL.Void* pointer);

	enum GLX_ARB_render_texture = 1;

	int bindTexImageARB(X11.Display* dpy, GLXPbuffer pbuffer, int buffer);
	int releaseTexImageARB(X11.Display* dpy, GLXPbuffer pbuffer, int buffer);
	int drawableAttribARB(X11.Display* dpy, GLXDrawable draw, const(int)* attribList);

	enum GLX_MESA_swap_frame_usage = 1;

	int getFrameUsageMESA(X11.Display* dpy, GLXDrawable drawable, float* usage);
	int beginFrameTrackingMESA(X11.Display* dpy, GLXDrawable drawable);
	int endFrameTrackingMESA(X11.Display* dpy, GLXDrawable drawable);
	int queryFrameTrackingMESA(X11.Display* dpy, GLXDrawable drawable,
			long* swapCount, long* missedFrames, float* lastMissedUsage);

	struct GLXPbufferClobberEvent {
		int event_type;
		int draw_type;
		c_ulong serial;
		int send_event;
		X11.Display* display;
		GLXDrawable drawable;
		uint buffer_mask;
		uint aux_buffer;
		int x;
		int y;
		int width;
		int height;
		int count;
	}

	struct GLXBufferSwapComplete {
		int type;
		c_ulong serial;
		int send_event;
		X11.Display* display;
		GLXDrawable drawable;
		int event_type;
		long ust;
		long msc;
		long sbc;
	}

	union __GLXEvent {
		GLXPbufferClobberEvent glxpbufferclobber;
		GLXBufferSwapComplete glxbufferswapcomplete;
		c_long[24] pad;
	}

	alias GLXEvent = __GLXEvent;
	// file '/usr/include/GL/glxext.h'

	import core.stdc.config;

	enum __glx_glxext_h_ = 1;

	enum GLXEXT_VERSION = 20_190_728;

	enum GLX_ARB_context_flush_control = 1;
	enum CONTEXT_RELEASE_BEHAVIOR_ARB = 0x2097;
	enum CONTEXT_RELEASE_BEHAVIOR_NONE_ARB = 0;
	enum CONTEXT_RELEASE_BEHAVIOR_FLUSH_ARB = 0x2098;

	enum GLX_ARB_create_context = 1;
	enum CONTEXT_DEBUG_BIT_ARB = 0x00000001;
	enum CONTEXT_FORWARD_COMPATIBLE_BIT_ARB = 0x00000002;
	enum CONTEXT_MAJOR_VERSION_ARB = 0x2091;
	enum CONTEXT_MINOR_VERSION_ARB = 0x2092;
	enum CONTEXT_FLAGS_ARB = 0x2094;
	GLXContext createContextAttribsARB(X11.Display* dpy, GLXFBConfig config,
			GLXContext share_context, int direct, const(int)* attrib_list);

	enum GLX_ARB_create_context_no_error = 1;
	enum CONTEXT_OPENGL_NO_ERROR_ARB = 0x31B3;

	enum GLX_ARB_create_context_profile = 1;
	enum CONTEXT_CORE_PROFILE_BIT_ARB = 0x00000001;
	enum CONTEXT_COMPATIBILITY_PROFILE_BIT_ARB = 0x00000002;
	enum CONTEXT_PROFILE_MASK_ARB = 0x9126;

	enum GLX_ARB_create_context_robustness = 1;
	enum CONTEXT_ROBUST_ACCESS_BIT_ARB = 0x00000004;
	enum LOSE_CONTEXT_ON_RESET_ARB = 0x8252;
	enum CONTEXT_RESET_NOTIFICATION_STRATEGY_ARB = 0x8256;
	enum NO_RESET_NOTIFICATION_ARB = 0x8261;

	enum GLX_ARB_fbconfig_float = 1;
	enum RGBA_FLOAT_TYPE_ARB = 0x20B9;
	enum RGBA_FLOAT_BIT_ARB = 0x00000004;

	enum GLX_ARB_framebuffer_sRGB = 1;
	enum FRAMEBUFFER_SRGB_CAPABLE_ARB = 0x20B2;

	enum GLX_ARB_multisample = 1;
	enum SAMPLE_BUFFERS_ARB = 100_000;
	enum SAMPLES_ARB = 100_001;

	enum GLX_ARB_robustness_application_isolation = 1;
	enum CONTEXT_RESET_ISOLATION_BIT_ARB = 0x00000008;

	enum GLX_ARB_robustness_share_group_isolation = 1;

	enum GLX_ARB_vertex_buffer_object = 1;
	enum CONTEXT_ALLOW_BUFFER_BYTE_ORDER_MISMATCH_ARB = 0x2095;

	enum GLX_3DFX_multisample = 1;
	enum GLX_SAMPLE_BUFFERS_3DFX = 0x8050;
	enum GLX_SAMPLES_3DFX = 0x8051;

	enum GLX_AMD_gpu_association = 1;
	enum GPU_VENDOR_AMD = 0x1F00;
	enum GPU_RENDERER_STRING_AMD = 0x1F01;
	enum GPU_OPENGL_VERSION_STRING_AMD = 0x1F02;
	enum GPU_FASTEST_TARGET_GPUS_AMD = 0x21A2;
	enum GPU_RAM_AMD = 0x21A3;
	enum GPU_CLOCK_AMD = 0x21A4;
	enum GPU_NUM_PIPES_AMD = 0x21A5;
	enum GPU_NUM_SIMD_AMD = 0x21A6;
	enum GPU_NUM_RB_AMD = 0x21A7;
	enum GPU_NUM_SPI_AMD = 0x21A8;
	uint getGPUIDsAMD(uint maxCount, uint* ids);
	int getGPUInfoAMD(uint id, int property, GL.Enum dataType, uint size, void* data);
	uint getContextGPUIDAMD(GLXContext ctx);
	GLXContext createAssociatedContextAMD(uint id, GLXContext share_list);
	GLXContext createAssociatedContextAttribsAMD(uint id,
			GLXContext share_context, const(int)* attribList);
	int deleteAssociatedContextAMD(GLXContext ctx);
	int makeAssociatedContextCurrentAMD(GLXContext ctx);
	GLXContext getCurrentAssociatedContextAMD();
	void blitContextFramebufferAMD(GLXContext dstCtx, GL.Int srcX0, GL.Int srcY0, GL.Int srcX1,
			GL.Int srcY1, GL.Int dstX0, GL.Int dstY0, GL.Int dstX1, GL.Int dstY1,
			GL.Bitfield mask, GL.Enum filter);

	enum GLX_EXT_buffer_age = 1;
	enum BACK_BUFFER_AGE_EXT = 0x20F4;

	enum GLX_EXT_context_priority = 1;
	enum CONTEXT_PRIORITY_LEVEL_EXT = 0x3100;
	enum CONTEXT_PRIORITY_HIGH_EXT = 0x3101;
	enum CONTEXT_PRIORITY_MEDIUM_EXT = 0x3102;
	enum CONTEXT_PRIORITY_LOW_EXT = 0x3103;

	enum GLX_EXT_create_context_es2_profile = 1;
	enum GLX_CONTEXT_ES2_PROFILE_BIT_EXT = 0x00000004;

	enum GLX_EXT_create_context_es_profile = 1;
	enum CONTEXT_ES_PROFILE_BIT_EXT = 0x00000004;

	enum GLX_EXT_fbconfig_packed_float = 1;
	enum RGBA_UNSIGNED_FLOAT_TYPE_EXT = 0x20B1;
	enum RGBA_UNSIGNED_FLOAT_BIT_EXT = 0x00000008;

	enum GLX_EXT_framebuffer_sRGB = 1;
	enum FRAMEBUFFER_SRGB_CAPABLE_EXT = 0x20B2;

	enum GLX_EXT_import_context = 1;
	enum SHARE_CONTEXT_EXT = 0x800A;
	enum VISUAL_ID_EXT = 0x800B;
	enum SCREEN_EXT = 0x800C;
	X11.Display* getCurrentDisplayEXT();
	int queryContextInfoEXT(X11.Display* dpy, GLXContext context, int attribute, int* value);
	GLXContextID getContextIDEXT(const GLXContext context);
	GLXContext importContextEXT(X11.Display* dpy, GLXContextID contextID);
	void freeContextEXT(X11.Display* dpy, GLXContext context);

	enum GLX_EXT_libglvnd = 1;
	enum VENDOR_NAMES_EXT = 0x20F6;

	enum GLX_EXT_no_config_context = 1;

	enum GLX_EXT_stereo_tree = 1;

	struct GLXStereoNotifyEventEXT {
		int type;
		c_ulong serial;
		int send_event;
		X11.Display* display;
		int extension;
		int evtype;
		GLXDrawable window;
		int stereo_tree;
	}

	enum STEREO_TREE_EXT = 0x20F5;
	enum STEREO_NOTIFY_MASK_EXT = 0x00000001;
	enum STEREO_NOTIFY_EXT = 0x00000000;

	enum GLX_EXT_swap_control = 1;
	enum SWAP_INTERVAL_EXT = 0x20F1;
	enum MAX_SWAP_INTERVAL_EXT = 0x20F2;
	void swapIntervalEXT(X11.Display* dpy, GLXDrawable drawable, int interval);

	enum GLX_EXT_swap_control_tear = 1;
	enum LATE_SWAPS_TEAR_EXT = 0x20F3;

	enum GLX_EXT_visual_info = 1;
	enum X_VISUAL_TYPE_EXT = 0x22;
	enum TRANSPARENT_TYPE_EXT = 0x23;
	enum TRANSPARENT_INDEX_VALUE_EXT = 0x24;
	enum TRANSPARENT_RED_VALUE_EXT = 0x25;
	enum TRANSPARENT_GREEN_VALUE_EXT = 0x26;
	enum TRANSPARENT_BLUE_VALUE_EXT = 0x27;
	enum TRANSPARENT_ALPHA_VALUE_EXT = 0x28;
	enum NONE_EXT = 0x8000;
	enum TRUE_COLOR_EXT = 0x8002;
	enum DIRECT_COLOR_EXT = 0x8003;
	enum PSEUDO_COLOR_EXT = 0x8004;
	enum STATIC_COLOR_EXT = 0x8005;
	enum GRAY_SCALE_EXT = 0x8006;
	enum STATIC_GRAY_EXT = 0x8007;
	enum TRANSPARENT_RGB_EXT = 0x8008;
	enum TRANSPARENT_INDEX_EXT = 0x8009;

	enum GLX_EXT_visual_rating = 1;
	enum VISUAL_CAVEAT_EXT = 0x20;
	enum SLOW_VISUAL_EXT = 0x8001;
	enum NON_CONFORMANT_VISUAL_EXT = 0x800D;

	enum GLX_INTEL_swap_event = 1;
	enum BUFFER_SWAP_COMPLETE_INTEL_MASK = 0x04000000;
	enum EXCHANGE_COMPLETE_INTEL = 0x8180;
	enum COPY_COMPLETE_INTEL = 0x8181;
	enum FLIP_COMPLETE_INTEL = 0x8182;

	enum GLX_MESA_agp_offset = 1;
	uint getAGPOffsetMESA(const(void)* pointer);

	enum GLX_MESA_copy_sub_buffer = 1;
	void copySubBufferMESA(X11.Display* dpy, GLXDrawable drawable, int x,
			int y, int width, int height);

	enum GLX_MESA_pixmap_colormap = 1;
	GLXPixmap createGLXPixmapMESA(X11.Display* dpy, X11.XVisualInfo* visual,
			X11.Pixmap pixmap, X11.Colormap cmap);

	enum GLX_MESA_query_renderer = 1;
	enum RENDERER_VENDOR_ID_MESA = 0x8183;
	enum RENDERER_DEVICE_ID_MESA = 0x8184;
	enum RENDERER_VERSION_MESA = 0x8185;
	enum RENDERER_ACCELERATED_MESA = 0x8186;
	enum RENDERER_VIDEO_MEMORY_MESA = 0x8187;
	enum RENDERER_UNIFIED_MEMORY_ARCHITECTURE_MESA = 0x8188;
	enum RENDERER_PREFERRED_PROFILE_MESA = 0x8189;
	enum RENDERER_OPENGL_CORE_PROFILE_VERSION_MESA = 0x818A;
	enum RENDERER_OPENGL_COMPATIBILITY_PROFILE_VERSION_MESA = 0x818B;
	enum RENDERER_OPENGL_ES_PROFILE_VERSION_MESA = 0x818C;
	enum GLX_RENDERER_OPENGL_ES2_PROFILE_VERSION_MESA = 0x818D;
	int queryCurrentRendererIntegerMESA(int attribute, uint* value);
	const(char)* queryCurrentRendererStringMESA(int attribute);
	int queryRendererIntegerMESA(X11.Display* dpy, int screen, int renderer,
			int attribute, uint* value);
	const(char)* queryRendererStringMESA(X11.Display* dpy, int screen, int renderer, int attribute);

	enum GLX_MESA_release_buffers = 1;
	int releaseBuffersMESA(X11.Display* dpy, GLXDrawable drawable);

	enum GLX_MESA_set_3dfx_mode = 1;
	enum GLX_3DFX_WINDOW_MODE_MESA = 0x1;
	enum GLX_3DFX_FULLSCREEN_MODE_MESA = 0x2;
	GL.Boolean set3DfxModeMESA(GL.Int mode);

	enum GLX_NV_copy_buffer = 1;
	void copyBufferSubDataNV(X11.Display* dpy, GLXContext readCtx, GLXContext writeCtx, GL.Enum readTarget,
			GL.Enum writeTarget, GL.Intptr readOffset, GL.Intptr writeOffset, GL.Sizeiptr size);
	void namedCopyBufferSubDataNV(X11.Display* dpy, GLXContext readCtx, GLXContext writeCtx, GL.UInt readBuffer,
			GL.UInt writeBuffer, GL.Intptr readOffset, GL.Intptr writeOffset, GL.Sizeiptr size);

	enum GLX_NV_copy_image = 1;
	void copyImageSubDataNV(X11.Display* dpy, GLXContext srcCtx, GL.UInt srcName, GL.Enum srcTarget,
			GL.Int srcLevel, GL.Int srcX, GL.Int srcY, GL.Int srcZ, GLXContext dstCtx, GL.UInt dstName,
			GL.Enum dstTarget, GL.Int dstLevel, GL.Int dstX, GL.Int dstY, GL.Int dstZ,
			GL.Sizei width, GL.Sizei height, GL.Sizei depth);

	enum GLX_NV_delay_before_swap = 1;
	int delayBeforeSwapNV(X11.Display* dpy, GLXDrawable drawable, GL.Float seconds);

	enum GLX_NV_multisample_coverage = 1;
	enum COVERAGE_SAMPLES_NV = 100_001;
	enum COLOR_SAMPLES_NV = 0x20B3;

	enum GLX_NV_present_video = 1;
	enum NUM_VIDEO_SLOTS_NV = 0x20F0;
	uint* enumerateVideoDevicesNV(X11.Display* dpy, int screen, int* nelements);
	int bindVideoDeviceNV(X11.Display* dpy, uint video_slot, uint video_device,
			const(int)* attrib_list);

	enum GLX_NV_robustness_video_memory_purge = 1;
	enum GENERATE_RESET_ON_VIDEO_MEMORY_PURGE_NV = 0x20F7;

	enum GLX_NV_swap_group = 1;
	int joinSwapGroupNV(X11.Display* dpy, GLXDrawable drawable, GL.UInt group);
	int bindSwapBarrierNV(X11.Display* dpy, GL.UInt group, GL.UInt barrier);
	int querySwapGroupNV(X11.Display* dpy, GLXDrawable drawable, GL.UInt* group, GL.UInt* barrier);
	int queryMaxSwapGroupsNV(X11.Display* dpy, int screen, GL.UInt* maxGroups, GL.UInt* maxBarriers);
	int queryFrameCountNV(X11.Display* dpy, int screen, GL.UInt* count);
	int resetFrameCountNV(X11.Display* dpy, int screen);

	enum GLX_NV_video_capture = 1;
	alias GLXVideoCaptureDeviceNV = c_ulong;
	enum DEVICE_ID_NV = 0x20CD;
	enum UNIQUE_ID_NV = 0x20CE;
	enum NUM_VIDEO_CAPTURE_SLOTS_NV = 0x20CF;
	int bindVideoCaptureDeviceNV(X11.Display* dpy, uint video_capture_slot,
			GLXVideoCaptureDeviceNV device);
	GLXVideoCaptureDeviceNV* enumerateVideoCaptureDevicesNV(X11.Display* dpy,
			int screen, int* nelements);
	void lockVideoCaptureDeviceNV(X11.Display* dpy, GLXVideoCaptureDeviceNV device);
	int queryVideoCaptureDeviceNV(X11.Display* dpy,
			GLXVideoCaptureDeviceNV device, int attribute, int* value);
	void releaseVideoCaptureDeviceNV(X11.Display* dpy, GLXVideoCaptureDeviceNV device);

	enum GLX_NV_video_out = 1;
	alias GLXVideoDeviceNV = uint;
	enum VIDEO_OUT_COLOR_NV = 0x20C3;
	enum VIDEO_OUT_ALPHA_NV = 0x20C4;
	enum VIDEO_OUT_DEPTH_NV = 0x20C5;
	enum VIDEO_OUT_COLOR_AND_ALPHA_NV = 0x20C6;
	enum VIDEO_OUT_COLOR_AND_DEPTH_NV = 0x20C7;
	enum VIDEO_OUT_FRAME_NV = 0x20C8;
	enum GLX_VIDEO_OUT_FIELD_1_NV = 0x20C9;
	enum GLX_VIDEO_OUT_FIELD_2_NV = 0x20CA;
	enum GLX_VIDEO_OUT_STACKED_FIELDS_1_2_NV = 0x20CB;
	enum GLX_VIDEO_OUT_STACKED_FIELDS_2_1_NV = 0x20CC;
	int getVideoDeviceNV(X11.Display* dpy, int screen, int numVideoDevices,
			GLXVideoDeviceNV* pVideoDevice);
	int releaseVideoDeviceNV(X11.Display* dpy, int screen, GLXVideoDeviceNV VideoDevice);
	int bindVideoImageNV(X11.Display* dpy, GLXVideoDeviceNV VideoDevice,
			GLXPbuffer pbuf, int iVideoBuffer);
	int releaseVideoImageNV(X11.Display* dpy, GLXPbuffer pbuf);
	int sendPbufferToVideoNV(X11.Display* dpy, GLXPbuffer pbuf, int iBufferType,
			c_ulong* pulCounterPbuffer, GL.Boolean bBlock);
	int getVideoInfoNV(X11.Display* dpy, int screen, GLXVideoDeviceNV VideoDevice,
			c_ulong* pulCounterOutputPbuffer, c_ulong* pulCounterOutputVideo);

	enum GLX_OML_swap_method = 1;
	enum SWAP_METHOD_OML = 0x8060;
	enum SWAP_EXCHANGE_OML = 0x8061;
	enum SWAP_COPY_OML = 0x8062;
	enum SWAP_UNDEFINED_OML = 0x8063;

	enum GLX_OML_sync_control = 1;

	int getSyncValuesOML(X11.Display* dpy, GLXDrawable drawable, long* ust, long* msc, long* sbc);
	int getMscRateOML(X11.Display* dpy, GLXDrawable drawable, int* numerator, int* denominator);
	long swapBuffersMscOML(X11.Display* dpy, GLXDrawable drawable,
			long target_msc, long divisor, long remainder);
	int waitForMscOML(X11.Display* dpy, GLXDrawable drawable, long target_msc,
			long divisor, long remainder, long* ust, long* msc, long* sbc);
	int waitForSbcOML(X11.Display* dpy, GLXDrawable drawable, long target_sbc,
			long* ust, long* msc, long* sbc);

	enum GLX_SGIS_blended_overlay = 1;
	enum BLENDED_RGBA_SGIS = 0x8025;

	enum GLX_SGIS_multisample = 1;
	enum SAMPLE_BUFFERS_SGIS = 100_000;
	enum SAMPLES_SGIS = 100_001;

	enum GLX_SGIS_shared_multisample = 1;
	enum MULTISAMPLE_SUB_RECT_WIDTH_SGIS = 0x8026;
	enum MULTISAMPLE_SUB_RECT_HEIGHT_SGIS = 0x8027;

	enum GLX_SGIX_dmbuffer = 1;
	alias GLXPbufferSGIX = c_ulong;

	enum GLX_SGIX_fbconfig = 1;
	struct Private_GLXFBConfigRec;
	alias GLXFBConfigSGIX = Private_GLXFBConfigRec*;
	enum WINDOW_BIT_SGIX = 0x00000001;
	enum PIXMAP_BIT_SGIX = 0x00000002;
	enum RGBA_BIT_SGIX = 0x00000001;
	enum COLOR_INDEX_BIT_SGIX = 0x00000002;
	enum DRAWABLE_TYPE_SGIX = 0x8010;
	enum RENDER_TYPE_SGIX = 0x8011;
	enum X_RENDERABLE_SGIX = 0x8012;
	enum FBCONFIG_ID_SGIX = 0x8013;
	enum RGBA_TYPE_SGIX = 0x8014;
	enum COLOR_INDEX_TYPE_SGIX = 0x8015;
	int getFBConfigAttribSGIX(X11.Display* dpy, GLXFBConfigSGIX config, int attribute, int* value);
	GLXFBConfigSGIX* chooseFBConfigSGIX(X11.Display* dpy, int screen,
			int* attrib_list, int* nelements);
	GLXPixmap createGLXPixmapWithConfigSGIX(X11.Display* dpy,
			GLXFBConfigSGIX config, X11.Pixmap pixmap);
	GLXContext createContextWithConfigSGIX(X11.Display* dpy,
			GLXFBConfigSGIX config, int render_type, GLXContext share_list, int direct);
	X11.XVisualInfo* getVisualFromFBConfigSGIX(X11.Display* dpy, GLXFBConfigSGIX config);
	GLXFBConfigSGIX getFBConfigFromVisualSGIX(X11.Display* dpy, X11.XVisualInfo* vis);

	enum GLX_SGIX_hyperpipe = 1;

	struct GLXHyperpipeNetworkSGIX {
		char[80] pipeName;
		int networkId;
	}

	struct GLXHyperpipeConfigSGIX {
		char[80] pipeName;
		int channel;
		uint participationType;
		int timeSlice;
	}

	struct GLXPipeRect {
		char[80] pipeName;
		int srcXOrigin;
		int srcYOrigin;
		int srcWidth;
		int srcHeight;
		int destXOrigin;
		int destYOrigin;
		int destWidth;
		int destHeight;
	}

	struct GLXPipeRectLimits {
		char[80] pipeName;
		int XOrigin;
		int YOrigin;
		int maxHeight;
		int maxWidth;
	}

	enum HYPERPIPE_PIPE_NAME_LENGTH_SGIX = 80;
	enum BAD_HYPERPIPE_CONFIG_SGIX = 91;
	enum BAD_HYPERPIPE_SGIX = 92;
	enum HYPERPIPE_DISPLAY_PIPE_SGIX = 0x00000001;
	enum HYPERPIPE_RENDER_PIPE_SGIX = 0x00000002;
	enum PIPE_RECT_SGIX = 0x00000001;
	enum PIPE_RECT_LIMITS_SGIX = 0x00000002;
	enum HYPERPIPE_STEREO_SGIX = 0x00000003;
	enum HYPERPIPE_PIXEL_AVERAGE_SGIX = 0x00000004;
	enum HYPERPIPE_ID_SGIX = 0x8030;
	GLXHyperpipeNetworkSGIX* queryHyperpipeNetworkSGIX(X11.Display* dpy, int* npipes);
	int hyperpipeConfigSGIX(X11.Display* dpy, int networkId, int npipes,
			GLXHyperpipeConfigSGIX* cfg, int* hpId);
	GLXHyperpipeConfigSGIX* queryHyperpipeConfigSGIX(X11.Display* dpy, int hpId, int* npipes);
	int destroyHyperpipeConfigSGIX(X11.Display* dpy, int hpId);
	int bindHyperpipeSGIX(X11.Display* dpy, int hpId);
	int queryHyperpipeBestAttribSGIX(X11.Display* dpy, int timeSlice, int attrib,
			int size, void* attribList, void* returnAttribList);
	int hyperpipeAttribSGIX(X11.Display* dpy, int timeSlice, int attrib, int size, void* attribList);
	int queryHyperpipeAttribSGIX(X11.Display* dpy, int timeSlice, int attrib,
			int size, void* returnAttribList);

	enum GLX_SGIX_pbuffer = 1;
	enum PBUFFER_BIT_SGIX = 0x00000004;
	enum BUFFER_CLOBBER_MASK_SGIX = 0x08000000;
	enum FRONT_LEFT_BUFFER_BIT_SGIX = 0x00000001;
	enum FRONT_RIGHT_BUFFER_BIT_SGIX = 0x00000002;
	enum BACK_LEFT_BUFFER_BIT_SGIX = 0x00000004;
	enum BACK_RIGHT_BUFFER_BIT_SGIX = 0x00000008;
	enum AUX_BUFFERS_BIT_SGIX = 0x00000010;
	enum DEPTH_BUFFER_BIT_SGIX = 0x00000020;
	enum STENCIL_BUFFER_BIT_SGIX = 0x00000040;
	enum ACCUM_BUFFER_BIT_SGIX = 0x00000080;
	enum SAMPLE_BUFFERS_BIT_SGIX = 0x00000100;
	enum MAX_PBUFFER_WIDTH_SGIX = 0x8016;
	enum MAX_PBUFFER_HEIGHT_SGIX = 0x8017;
	enum MAX_PBUFFER_PIXELS_SGIX = 0x8018;
	enum OPTIMAL_PBUFFER_WIDTH_SGIX = 0x8019;
	enum OPTIMAL_PBUFFER_HEIGHT_SGIX = 0x801A;
	enum PRESERVED_CONTENTS_SGIX = 0x801B;
	enum LARGEST_PBUFFER_SGIX = 0x801C;
	enum WIDTH_SGIX = 0x801D;
	enum HEIGHT_SGIX = 0x801E;
	enum EVENT_MASK_SGIX = 0x801F;
	enum DAMAGED_SGIX = 0x8020;
	enum SAVED_SGIX = 0x8021;
	enum WINDOW_SGIX = 0x8022;
	enum PBUFFER_SGIX = 0x8023;
	GLXPbufferSGIX createGLXPbufferSGIX(X11.Display* dpy,
			GLXFBConfigSGIX config, uint width, uint height, int* attrib_list);
	void destroyGLXPbufferSGIX(X11.Display* dpy, GLXPbufferSGIX pbuf);
	void queryGLXPbufferSGIX(X11.Display* dpy, GLXPbufferSGIX pbuf, int attribute, uint* value);
	void selectEventSGIX(X11.Display* dpy, GLXDrawable drawable, c_ulong mask);
	void getSelectedEventSGIX(X11.Display* dpy, GLXDrawable drawable, c_ulong* mask);

	enum GLX_SGIX_swap_barrier = 1;
	void bindSwapBarrierSGIX(X11.Display* dpy, GLXDrawable drawable, int barrier);
	int queryMaxSwapBarriersSGIX(X11.Display* dpy, int screen, int* max);

	enum GLX_SGIX_swap_group = 1;
	void joinSwapGroupSGIX(X11.Display* dpy, GLXDrawable drawable, GLXDrawable member);

	enum GLX_SGIX_video_resize = 1;
	enum SYNC_FRAME_SGIX = 0x00000000;
	enum SYNC_SWAP_SGIX = 0x00000001;
	int bindChannelToWindowSGIX(X11.Display* display, int screen, int channel, X11.Window window);
	int channelRectSGIX(X11.Display* display, int screen, int channel, int x, int y, int w, int h);
	int queryChannelRectSGIX(X11.Display* display, int screen, int channel,
			int* dx, int* dy, int* dw, int* dh);
	int queryChannelDeltasSGIX(X11.Display* display, int screen, int channel,
			int* x, int* y, int* w, int* h);
	int channelRectSyncSGIX(X11.Display* display, int screen, int channel, GL.Enum synctype);

	enum GLX_SGIX_video_source = 1;
	alias GLXVideoSourceSGIX = c_ulong;

	enum GLX_SGIX_visual_select_group = 1;
	enum VISUAL_SELECT_GROUP_SGIX = 0x8028;

	enum GLX_SGI_cushion = 1;
	void cushionSGI(X11.Display* dpy, X11.Window window, float cushion);

	enum GLX_SGI_make_current_read = 1;
	int makeCurrentReadSGI(X11.Display* dpy, GLXDrawable draw, GLXDrawable read, GLXContext ctx);
	GLXDrawable getCurrentReadDrawableSGI();

	enum GLX_SGI_swap_control = 1;
	int swapIntervalSGI(int interval);

	enum GLX_SGI_video_sync = 1;
	int getVideoSyncSGI(uint* count);
	int waitVideoSyncSGI(int divisor, int remainder, uint* count);

	enum GLX_SUN_get_transparent_index = 1;
	int getTransparentIndexSUN(X11.Display* dpy, X11.Window overlay,
			X11.Window underlay, c_ulong* pTransparentIndex);
}
