module gd.bindings.xcursor;
import gd.bindings.x11;
import gd.bindings.loader;
import gd.resource;
import core.stdc.config;
import core.stdc.stddef;

version (gd_X11Impl):

private static XCursorLibrary m_XCursor;
XCursorLibrary XCursor() @property { // @suppress(dscanner.confusing.function_attributes)
	if (m_XCursor is null) {
		m_XCursor = loadXCursor;
		registerLibraryResource(m_XCursor);
	}

	return m_XCursor;
}

XCursorLibrary loadXCursor() {
	string[] libraries;

	version (Posix) {
		libraries = ["libXcursor.so.1", "libXcursor.so"];
	}
	else {
		static assert(0, "unsupported platform");
	}

	return loadSharedLibrary!(XCursorLibrary, delegate(string name) {
		return "Xcursor" ~ cast(char)(name[0] + 'A' - 'a') ~ name[1 .. $];
	})(libraries);
}

abstract class XCursorLibrary : Resource {
extern (System) @nogc nothrow:
	// file '/usr/include/X11/Xcursor/Xcursor.h'

	import core.stdc.config;
	import core.stdc.stdio;

	alias XcursorBool = int;
	alias XcursorUInt = uint;

	alias XcursorDim = uint;
	alias XcursorPixel = uint;

	enum XcursorTrue = 1;
	enum XcursorFalse = 0;

	enum XCURSOR_MAGIC = 0x72756358;

	enum XCURSOR_LIB_MAJOR = 1;
	enum XCURSOR_LIB_MINOR = 2;
	enum XCURSOR_LIB_REVISION = 0;
	enum XCURSOR_LIB_VERSION = (XCURSOR_LIB_MAJOR * 10_000) + (
				XCURSOR_LIB_MINOR * 100) + XCURSOR_LIB_REVISION;

	enum XCURSOR_FILE_MAJOR = 1;
	enum XCURSOR_FILE_MINOR = 0;
	enum XCURSOR_FILE_VERSION = (XCURSOR_FILE_MAJOR << 16) | XCURSOR_FILE_MINOR;
	enum XCURSOR_FILE_HEADER_LEN = 4 * 4;
	enum XCURSOR_FILE_TOC_LEN = 3 * 4;

	struct XcursorFileToc {
		XcursorUInt type;
		XcursorUInt subtype;
		XcursorUInt position;
	}

	struct XcursorFileHeader {
		XcursorUInt magic;
		XcursorUInt header;
		XcursorUInt version_;
		XcursorUInt ntoc;
		XcursorFileToc* tocs;
	}

	enum XCURSOR_CHUNK_HEADER_LEN = 4 * 4;

	struct XcursorChunkHeader {
		XcursorUInt header;
		XcursorUInt type;
		XcursorUInt subtype;
		XcursorUInt version_;
	}

	enum XCURSOR_COMMENT_TYPE = 0xfffe0001;
	enum XCURSOR_COMMENT_VERSION = 1;
	enum XCURSOR_COMMENT_HEADER_LEN = XCURSOR_CHUNK_HEADER_LEN + (1 * 4);
	enum XCURSOR_COMMENT_COPYRIGHT = 1;
	enum XCURSOR_COMMENT_LICENSE = 2;
	enum XCURSOR_COMMENT_OTHER = 3;
	enum XCURSOR_COMMENT_MAX_LEN = 0x100000;

	struct XcursorComment {
		XcursorUInt version_;
		XcursorUInt comment_type;
		char* comment;
	}

	enum XCURSOR_IMAGE_TYPE = 0xfffd0002;
	enum XCURSOR_IMAGE_VERSION = 1;
	enum XCURSOR_IMAGE_HEADER_LEN = XCURSOR_CHUNK_HEADER_LEN + (5 * 4);
	enum XCURSOR_IMAGE_MAX_SIZE = 0x7fff;

	struct XcursorImage {
		XcursorUInt version_;
		XcursorDim size;
		XcursorDim width;
		XcursorDim height;
		XcursorDim xhot;
		XcursorDim yhot;
		XcursorUInt delay;
		XcursorPixel* pixels;
	}

	struct XcursorImages {
		int nimage;
		XcursorImage** images;
		char* name;
	}

	struct XcursorCursors {
		X11.Display* dpy;
		int ref_;
		int ncursor;
		X11.Cursor* cursors;
	}

	struct XcursorAnimate {
		XcursorCursors* cursors;
		int sequence;
	}

	alias XcursorFile = PrivateXcursorFile;

	struct PrivateXcursorFile {
		void* closure;
		int function(XcursorFile* file, ubyte* buf, int len) read;
		int function(XcursorFile* file, ubyte* buf, int len) write;
		int function(XcursorFile* file, c_long offset, int whence) seek;
	}

	struct PrivateXcursorComments {
		int ncomment;
		XcursorComment** comments;
	}

	alias XcursorComments = PrivateXcursorComments;

	enum XCURSOR_CORE_THEME = "core";

	XcursorImage* imageCreate(int width, int height);

	void imageDestroy(XcursorImage* image);

	XcursorImages* imagesCreate(int size);

	void imagesDestroy(XcursorImages* images);

	void imagesSetName(XcursorImages* images, const(char)* name);

	XcursorCursors* cursorsCreate(X11.Display* dpy, int size);

	void cursorsDestroy(XcursorCursors* cursors);

	XcursorAnimate* animateCreate(XcursorCursors* cursors);

	void animateDestroy(XcursorAnimate* animate);

	X11.Cursor animateNext(XcursorAnimate* animate);

	XcursorComment* commentCreate(XcursorUInt comment_type, int length);

	void commentDestroy(XcursorComment* comment);

	XcursorComments* commentsCreate(int size);

	void commentsDestroy(XcursorComments* comments);

	XcursorImage* xcFileLoadImage(XcursorFile* file, int size);

	XcursorImages* xcFileLoadImages(XcursorFile* file, int size);

	XcursorImages* xcFileLoadAllImages(XcursorFile* file);

	XcursorBool xcFileLoad(XcursorFile* file, XcursorComments** commentsp,
			XcursorImages** imagesp);

	XcursorBool xcFileSave(XcursorFile* file, const(XcursorComments)* comments,
			const(XcursorImages)* images);

	XcursorImage* fileLoadImage(FILE* file, int size);

	XcursorImages* fileLoadImages(FILE* file, int size);

	XcursorImages* fileLoadAllImages(FILE* file);

	XcursorBool fileLoad(FILE* file, XcursorComments** commentsp, XcursorImages** imagesp);

	XcursorBool fileSaveImages(FILE* file, const(XcursorImages)* images);

	XcursorBool fileSave(FILE* file, const(XcursorComments)* comments,
			const(XcursorImages)* images);

	XcursorImage* filenameLoadImage(const(char)* filename, int size);

	XcursorImages* filenameLoadImages(const(char)* filename, int size);

	XcursorImages* filenameLoadAllImages(const(char)* filename);

	XcursorBool filenameLoad(const(char)* file, XcursorComments** commentsp,
			XcursorImages** imagesp);

	XcursorBool filenameSaveImages(const(char)* filename, const(XcursorImages)* images);

	XcursorBool filenameSave(const(char)* file,
			const(XcursorComments)* comments, const(XcursorImages)* images);

	XcursorImage* libraryLoadImage(const(char)* library, const(char)* theme, int size);

	XcursorImages* libraryLoadImages(const(char)* library, const(char)* theme, int size);

	const(char)* libraryPath();

	int libraryShape(const(char)* library);

	X11.Cursor imageLoadCursor(X11.Display* dpy, const(XcursorImage)* image);

	XcursorCursors* imagesLoadCursors(X11.Display* dpy, const(XcursorImages)* images);

	X11.Cursor imagesLoadCursor(X11.Display* dpy, const(XcursorImages)* images);

	X11.Cursor filenameLoadCursor(X11.Display* dpy, const(char)* file);

	XcursorCursors* filenameLoadCursors(X11.Display* dpy, const(char)* file);

	X11.Cursor libraryLoadCursor(X11.Display* dpy, const(char)* file);

	XcursorCursors* libraryLoadCursors(X11.Display* dpy, const(char)* file);

	XcursorImage* shapeLoadImage(uint shape, const(char)* theme, int size);

	XcursorImages* shapeLoadImages(uint shape, const(char)* theme, int size);

	X11.Cursor shapeLoadCursor(X11.Display* dpy, uint shape);

	XcursorCursors* shapeLoadCursors(X11.Display* dpy, uint shape);

	X11.Cursor tryShapeCursor(X11.Display* dpy, X11.Font source_font,
			X11.Font mask_font, uint source_char, uint mask_char,
			const(X11.XColor)* foreground, const(X11.XColor)* background);

	void noticeCreateBitmap(X11.Display* dpy, X11.Pixmap pid, uint width, uint height);

	void noticePutBitmap(X11.Display* dpy, X11.Drawable draw, X11.XImage* image);

	X11.Cursor tryShapeBitmapCursor(X11.Display* dpy, X11.Pixmap source,
			X11.Pixmap mask, X11.XColor* foreground, X11.XColor* background, uint x, uint y);

	enum XCURSOR_BITMAP_HASH_SIZE = 16;

	void imageHash(X11.XImage* image, ref ubyte[XCURSOR_BITMAP_HASH_SIZE] hash);

	XcursorBool supportsARGB(X11.Display* dpy);

	XcursorBool supportsAnim(X11.Display* dpy);

	XcursorBool setDefaultSize(X11.Display* dpy, int size);

	int getDefaultSize(X11.Display* dpy);

	XcursorBool setTheme(X11.Display* dpy, const(char)* theme);

	char* getTheme(X11.Display* dpy);

	XcursorBool getThemeCore(X11.Display* dpy);

	XcursorBool setThemeCore(X11.Display* dpy, XcursorBool theme_core);
}
