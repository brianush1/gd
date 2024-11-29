module gd.bindings.xfixes;
import gd.bindings.x11;
import gd.bindings.loader;
import gd.resource;
import core.stdc.config;
import core.stdc.stddef;

version (gd_X11Impl):

private static XFixesLibrary m_XFixes;
XFixesLibrary XFixes() @property { // @suppress(dscanner.confusing.function_attributes)
	if (m_XFixes is null) {
		m_XFixes = loadXFixes;
		registerLibraryResource(m_XFixes);
	}

	return m_XFixes;
}

XFixesLibrary loadXFixes() {
	string[] libraries;

	version (Posix) {
		libraries = ["libXfixes.so.3", "libXfixes.so"];
	}
	else {
		assert(0, "unsupported platform");
	}

	return loadSharedLibrary!(XFixesLibrary, delegate(string name) {
		return "XFixes" ~ cast(char)(name[0] + 'A' - 'a') ~ name[1 .. $];
	})(libraries);
}

abstract class XFixesLibrary : Resource {
extern (System) @nogc nothrow:
	// file '/usr/include/X11/extensions/Xfixes.h'

	import core.stdc.config;

	enum XFIXES_REVISION = 1;
	enum XFIXES_VERSION = (XFIXES_MAJOR * 10_000) + (XFIXES_MINOR * 100) + XFIXES_REVISION;

	struct XFixesSelectionNotifyEvent {
		int type;
		c_ulong serial;
		int send_event;
		X11.Display* display;
		X11.Window window;
		int subtype;
		X11.Window owner;
		X11.Atom selection;
		X11.Time timestamp;
		X11.Time selection_timestamp;
	}

	struct XFixesCursorNotifyEvent {
		int type;
		c_ulong serial;
		int send_event;
		X11.Display* display;
		X11.Window window;
		int subtype;
		c_ulong cursor_serial;
		X11.Time timestamp;
		X11.Atom cursor_name;
	}

	struct XFixesCursorImage {
		short x;
		short y;
		ushort width;
		ushort height;
		ushort xhot;
		ushort yhot;
		c_ulong cursor_serial;
		c_ulong* pixels;

		X11.Atom atom;
		const(char)* name;
	}

	alias XserverRegion = c_ulong;

	struct XFixesCursorImageAndName {
		short x;
		short y;
		ushort width;
		ushort height;
		ushort xhot;
		ushort yhot;
		c_ulong cursor_serial;
		c_ulong* pixels;
		X11.Atom atom;
		const(char)* name;
	}

	int queryExtension(X11.Display* dpy, int* event_base_return, int* error_base_return);
	int queryVersion(X11.Display* dpy, int* major_version_return, int* minor_version_return);

	@BindingName("XFixesVersion")
	int version_();

	void changeSaveSet(X11.Display* dpy, X11.Window win, int mode, int target, int map);

	void selectSelectionInput(X11.Display* dpy, X11.Window win,
			X11.Atom selection, c_ulong eventMask);

	void selectCursorInput(X11.Display* dpy, X11.Window win, c_ulong eventMask);

	XFixesCursorImage* getCursorImage(X11.Display* dpy);

	XserverRegion createRegion(X11.Display* dpy, X11.XRectangle* rectangles, int nrectangles);

	XserverRegion createRegionFromBitmap(X11.Display* dpy, X11.Pixmap bitmap);

	XserverRegion createRegionFromWindow(X11.Display* dpy, X11.Window window, int kind);

	XserverRegion createRegionFromGC(X11.Display* dpy, X11.GC gc);

	XserverRegion createRegionFromPicture(X11.Display* dpy, X11.XID picture);

	void destroyRegion(X11.Display* dpy, XserverRegion region);

	void setRegion(X11.Display* dpy, XserverRegion region,
			X11.XRectangle* rectangles, int nrectangles);

	void copyRegion(X11.Display* dpy, XserverRegion dst, XserverRegion src);

	void unionRegion(X11.Display* dpy, XserverRegion dst, XserverRegion src1, XserverRegion src2);

	void intersectRegion(X11.Display* dpy, XserverRegion dst, XserverRegion src1, XserverRegion src2);

	void subtractRegion(X11.Display* dpy, XserverRegion dst, XserverRegion src1, XserverRegion src2);

	void invertRegion(X11.Display* dpy, XserverRegion dst, X11.XRectangle* rect, XserverRegion src);

	void translateRegion(X11.Display* dpy, XserverRegion region, int dx, int dy);

	void regionExtents(X11.Display* dpy, XserverRegion dst, XserverRegion src);

	X11.XRectangle* fetchRegion(X11.Display* dpy, XserverRegion region, int* nrectanglesRet);

	X11.XRectangle* fetchRegionAndBounds(X11.Display* dpy, XserverRegion region,
			int* nrectanglesRet, X11.XRectangle* bounds);

	void setGCClipRegion(X11.Display* dpy, X11.GC gc, int clip_x_origin,
			int clip_y_origin, XserverRegion region);

	void setWindowShapeRegion(X11.Display* dpy, X11.Window win, int shape_kind,
			int x_off, int y_off, XserverRegion region);

	void setPictureClipRegion(X11.Display* dpy, X11.XID picture,
			int clip_x_origin, int clip_y_origin, XserverRegion region);

	void setCursorName(X11.Display* dpy, X11.Cursor cursor, const(char)* name);

	const(char)* getCursorName(X11.Display* dpy, X11.Cursor cursor, X11.Atom* atom);

	void changeCursor(X11.Display* dpy, X11.Cursor source, X11.Cursor destination);

	void changeCursorByName(X11.Display* dpy, X11.Cursor source, const(char)* name);

	void expandRegion(X11.Display* dpy, XserverRegion dst, XserverRegion src,
			uint left, uint right, uint top, uint bottom);

	void hideCursor(X11.Display* dpy, X11.Window win);

	void showCursor(X11.Display* dpy, X11.Window win);

	alias PointerBarrier = c_ulong;

	PointerBarrier createPointerBarrier(X11.Display* dpy, X11.Window w, int x1,
			int y1, int x2, int y2, int directions, int num_devices, int* devices);

	void destroyPointerBarrier(X11.Display* dpy, PointerBarrier b);

	void setClientDisconnectMode(X11.Display* dpy, int disconnect_mode);

	int getClientDisconnectMode(X11.Display* dpy);

	// file '/usr/include/X11/extensions/xfixeswire.h'

	enum XFIXES_NAME = "XFIXES";
	enum XFIXES_MAJOR = 6;
	enum XFIXES_MINOR = 0;

	enum X_XFixesQueryVersion = 0;
	enum X_XFixesChangeSaveSet = 1;
	enum X_XFixesSelectSelectionInput = 2;
	enum X_XFixesSelectCursorInput = 3;
	enum X_XFixesGetCursorImage = 4;

	enum X_XFixesCreateRegion = 5;
	enum X_XFixesCreateRegionFromBitmap = 6;
	enum X_XFixesCreateRegionFromWindow = 7;
	enum X_XFixesCreateRegionFromGC = 8;
	enum X_XFixesCreateRegionFromPicture = 9;
	enum X_XFixesDestroyRegion = 10;
	enum X_XFixesSetRegion = 11;
	enum X_XFixesCopyRegion = 12;
	enum X_XFixesUnionRegion = 13;
	enum X_XFixesIntersectRegion = 14;
	enum X_XFixesSubtractRegion = 15;
	enum X_XFixesInvertRegion = 16;
	enum X_XFixesTranslateRegion = 17;
	enum X_XFixesRegionExtents = 18;
	enum X_XFixesFetchRegion = 19;
	enum X_XFixesSetGCClipRegion = 20;
	enum X_XFixesSetWindowShapeRegion = 21;
	enum X_XFixesSetPictureClipRegion = 22;
	enum X_XFixesSetCursorName = 23;
	enum X_XFixesGetCursorName = 24;
	enum X_XFixesGetCursorImageAndName = 25;
	enum X_XFixesChangeCursor = 26;
	enum X_XFixesChangeCursorByName = 27;

	enum X_XFixesExpandRegion = 28;

	enum X_XFixesHideCursor = 29;
	enum X_XFixesShowCursor = 30;

	enum X_XFixesCreatePointerBarrier = 31;
	enum X_XFixesDestroyPointerBarrier = 32;

	enum X_XFixesSetClientDisconnectMode = 33;
	enum X_XFixesGetClientDisconnectMode = 34;

	enum XFixesNumberRequests = X_XFixesGetClientDisconnectMode + 1;

	enum XFixesSelectionNotify = 0;

	enum XFixesSetSelectionOwnerNotify = 0;
	enum XFixesSelectionWindowDestroyNotify = 1;
	enum XFixesSelectionClientCloseNotify = 2;

	enum XFixesSetSelectionOwnerNotifyMask = 1L << 0;
	enum XFixesSelectionWindowDestroyNotifyMask = 1L << 1;
	enum XFixesSelectionClientCloseNotifyMask = 1L << 2;

	enum XFixesCursorNotify = 1;

	enum XFixesDisplayCursorNotify = 0;

	enum XFixesDisplayCursorNotifyMask = 1L << 0;

	enum XFixesNumberEvents = 2;

	enum BadRegion = 0;
	enum BadBarrier = 1;
	enum XFixesNumberErrors = BadBarrier + 1;

	enum SaveSetNearest = 0;
	enum SaveSetRoot = 1;

	enum SaveSetMap = 0;
	enum SaveSetUnmap = 1;

	enum WindowRegionBounding = 0;
	enum WindowRegionClip = 1;

	enum BarrierPositiveX = 1L << 0;
	enum BarrierPositiveY = 1L << 1;
	enum BarrierNegativeX = 1L << 2;
	enum BarrierNegativeY = 1L << 3;

	enum XFixesClientDisconnectFlagDefault = 0;

	enum XFixesClientDisconnectFlagTerminate = 1L << 0;
}
