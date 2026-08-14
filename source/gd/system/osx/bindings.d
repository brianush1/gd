module gd.system.osx.bindings;

version (gd_OSX):

import core.attribute : selector, optional;

extern (Objective-C) {
	alias NSUInteger = size_t;
	alias NSInteger = ptrdiff_t;
	alias CGFloat = double;
	alias NSTimeInterval = double;
	alias NSid = void*;
	enum NSNotFound = cast(NSUInteger) NSInteger.max;
	struct SELStorage;
	alias SEL = SELStorage*;

	struct NSPoint {
		CGFloat x;
		CGFloat y;
	}

	struct NSSize {
		CGFloat width;
		CGFloat height;
	}

	struct NSRect {
		NSPoint origin;
		NSSize size;
	}

	struct NSRange {
		NSUInteger location;
		NSUInteger length;
	}

	extern class NSObject {
		static NSObject alloc() @selector("alloc");
		NSObject init() @selector("init");
		void retain() @selector("retain");
		void release() @selector("release");
		bool respondsToSelector(SEL selector) @selector("respondsToSelector:");
	}

	extern class NSString : NSObject {
		override static NSString alloc() @selector("alloc");
		NSString initWithBytes(const(ubyte)* bytes, NSUInteger length, NSStringEncoding encoding)
			@selector("initWithBytes:length:encoding:");
		const(char)* UTF8String() @selector("UTF8String");
	}

	extern class NSBundle : NSObject {
		static NSBundle mainBundle() @selector("mainBundle");
		NSid objectForInfoDictionaryKey(NSString key) @selector("objectForInfoDictionaryKey:");
	}

	extern class NSProcessInfo : NSObject {
		static NSProcessInfo processInfo() @selector("processInfo");
		NSString processName() @selector("processName");
	}

	extern class NSAttributedString : NSObject {
		NSString string() @selector("string");
	}

	extern class NSArray : NSObject {
		static NSArray array() @selector("array");
		static NSArray arrayWithObject(NSid object) @selector("arrayWithObject:");
		NSUInteger count() @selector("count");
		NSid objectAtIndex(NSUInteger index) @selector("objectAtIndex:");
		bool containsObject(NSid object) @selector("containsObject:");
	}

	extern class NSAutoreleasePool : NSObject {
		override static NSAutoreleasePool alloc() @selector("alloc");
		override NSAutoreleasePool init() @selector("init");
		void drain() @selector("drain");
	}

	enum NSStringEncoding : NSUInteger {
		UTF8 = 4,
	}

	extern class NSDate : NSObject {
		static NSDate distantFuture() @selector("distantFuture");
		static NSDate distantPast() @selector("distantPast");
		static NSDate dateWithTimeIntervalSinceNow(NSTimeInterval interval)
			@selector("dateWithTimeIntervalSinceNow:");
	}

	extern class NSRunLoop : NSObject {
		static NSRunLoop currentRunLoop() @selector("currentRunLoop");
		bool runMode(NSString mode, NSDate limitDate) @selector("runMode:beforeDate:");
	}

	extern class NSEvent : NSObject {
		static NSEventModifierFlags currentModifierFlags() @selector("modifierFlags");
		static NSPoint mouseLocation() @selector("mouseLocation");
		static NSUInteger pressedMouseButtons() @selector("pressedMouseButtons");
		NSEventModifierFlags eventModifierFlags() @selector("modifierFlags");
		NSPoint locationInWindow() @selector("locationInWindow");
		CGFloat deltaX() @selector("deltaX");
		CGFloat deltaY() @selector("deltaY");
		CGFloat scrollingDeltaX() @selector("scrollingDeltaX");
		CGFloat scrollingDeltaY() @selector("scrollingDeltaY");
		bool hasPreciseScrollingDeltas() @selector("hasPreciseScrollingDeltas");
		NSEventPhase momentumPhase() @selector("momentumPhase");
		NSInteger buttonNumber() @selector("buttonNumber");
		ushort keyCode() @selector("keyCode");
		NSString characters() @selector("characters");
		NSString charactersIgnoringModifiers() @selector("charactersIgnoringModifiers");
	}

	enum NSEventPhase : NSUInteger {
		None = 0,
		Began = 1 << 0,
		Stationary = 1 << 1,
		Changed = 1 << 2,
		Ended = 1 << 3,
		Cancelled = 1 << 4,
		MayBegin = 1 << 5,
	}

	enum NSEventModifierFlags : NSUInteger {
		CapsLock = 1 << 16,
		Shift = 1 << 17,
		Control = 1 << 18,
		Option = 1 << 19,
		Command = 1 << 20,
	}

	extern class NSResponder : NSObject {
		void keyDown(NSEvent event) @selector("keyDown:");
		void keyUp(NSEvent event) @selector("keyUp:");
		void mouseDown(NSEvent event) @selector("mouseDown:");
		void mouseDragged(NSEvent event) @selector("mouseDragged:");
		void mouseUp(NSEvent event) @selector("mouseUp:");
		void mouseMoved(NSEvent event) @selector("mouseMoved:");
		void mouseEntered(NSEvent event) @selector("mouseEntered:");
		void mouseExited(NSEvent event) @selector("mouseExited:");
		void rightMouseDown(NSEvent event) @selector("rightMouseDown:");
		void rightMouseDragged(NSEvent event) @selector("rightMouseDragged:");
		void rightMouseUp(NSEvent event) @selector("rightMouseUp:");
		void otherMouseDown(NSEvent event) @selector("otherMouseDown:");
		void otherMouseDragged(NSEvent event) @selector("otherMouseDragged:");
		void otherMouseUp(NSEvent event) @selector("otherMouseUp:");
		void scrollWheel(NSEvent event) @selector("scrollWheel:");
		void flagsChanged(NSEvent event) @selector("flagsChanged:");
	}

	extern class NSApplication : NSResponder {
		static NSApplication sharedApplication() @selector("sharedApplication");
		bool setActivationPolicy(NSApplicationActivationPolicy policy) @selector("setActivationPolicy:");
		void activateIgnoringOtherApps(bool flag) @selector("activateIgnoringOtherApps:");
		void finishLaunching() @selector("finishLaunching");
		void sendEvent(NSEvent event) @selector("sendEvent:");
		void updateWindows() @selector("updateWindows");
		void setDelegate(NSApplicationDelegate applicationDelegate) @selector("setDelegate:");
		void setMainMenu(NSMenu menu) @selector("setMainMenu:");
		void setWindowsMenu(NSMenu menu) @selector("setWindowsMenu:");
		NSInteger requestUserAttention(NSRequestUserAttentionType requestType)
			@selector("requestUserAttention:");
		void cancelUserAttentionRequest(NSInteger request) @selector("cancelUserAttentionRequest:");
		void setApplicationIconImage(NSImage image) @selector("setApplicationIconImage:");
		NSEvent nextEventMatchingMask(
			NSEventMask mask,
			NSDate untilDate,
			NSString mode,
			bool dequeue,
		) @selector("nextEventMatchingMask:untilDate:inMode:dequeue:");
	}

	enum NSApplicationActivationPolicy : NSInteger {
		Regular = 0,
	}

	enum NSApplicationTerminateReply : NSUInteger {
		Cancel = 0,
		Now = 1,
		Later = 2,
	}

	extern interface NSApplicationDelegate {
		@optional:
		NSApplicationTerminateReply applicationShouldTerminate(NSApplication sender)
			@selector("applicationShouldTerminate:");
		bool applicationShouldTerminateAfterLastWindowClosed(NSApplication sender)
			@selector("applicationShouldTerminateAfterLastWindowClosed:");
	}

	enum NSRequestUserAttentionType : NSUInteger {
		Critical = 0,
		Informational = 10,
	}

	enum NSEventMask : ulong {
		Any = ulong.max,
	}

	extern __gshared NSString NSDefaultRunLoopMode;

	extern class NSMenu : NSObject {
		override static NSMenu alloc() @selector("alloc");
		NSMenu initWithTitle(NSString title) @selector("initWithTitle:");
		void addItem(NSMenuItem item) @selector("addItem:");
	}

	extern class NSMenuItem : NSObject {
		override static NSMenuItem alloc() @selector("alloc");
		NSMenuItem initWithTitle(NSString title, SEL action, NSString keyEquivalent)
			@selector("initWithTitle:action:keyEquivalent:");
		static NSMenuItem separatorItem() @selector("separatorItem");
		void setSubmenu(NSMenu menu) @selector("setSubmenu:");
	}

	extern class NSNotification : NSObject {
		NSid object() @selector("object");
	}

	extern interface NSWindowDelegate {
		@optional:
		void windowDidResize(NSNotification notification) @selector("windowDidResize:");
		void windowDidChangeBackingProperties(NSNotification notification)
			@selector("windowDidChangeBackingProperties:");
		bool windowShouldClose(NSid sender) @selector("windowShouldClose:");
		void windowDidBecomeKey(NSNotification notification) @selector("windowDidBecomeKey:");
		void windowDidResignKey(NSNotification notification) @selector("windowDidResignKey:");
		void windowDidMiniaturize(NSNotification notification) @selector("windowDidMiniaturize:");
		void windowDidDeminiaturize(NSNotification notification) @selector("windowDidDeminiaturize:");
		void windowDidEnterFullScreen(NSNotification notification) @selector("windowDidEnterFullScreen:");
		void windowDidExitFullScreen(NSNotification notification) @selector("windowDidExitFullScreen:");
	}

	enum NSWindowStyleMask : NSUInteger {
		Borderless = 0,
		Titled = 1 << 0,
		Closable = 1 << 1,
		Miniaturizable = 1 << 2,
		Resizable = 1 << 3,
		FullScreen = 1 << 14,
	}

	enum NSBackingStoreType : NSUInteger {
		Buffered = 2,
	}

	extern class NSWindow : NSObject {
		override static NSWindow alloc() @selector("alloc");
		NSWindow initWithContentRect(
			NSRect contentRect,
			NSWindowStyleMask style,
			NSBackingStoreType bufferingType,
			bool deferCreation,
		) @selector("initWithContentRect:styleMask:backing:defer:");
		void setTitle(NSString title) @selector("setTitle:");
		void setContentView(NSView view) @selector("setContentView:");
		void setDelegate(NSWindowDelegate windowDelegate) @selector("setDelegate:");
		void setReleasedWhenClosed(bool value) @selector("setReleasedWhenClosed:");
		void center() @selector("center");
		void makeKeyAndOrderFront(NSid sender) @selector("makeKeyAndOrderFront:");
		void orderOut(NSid sender) @selector("orderOut:");
		void close() @selector("close");
		void zoom(NSid sender) @selector("zoom:");
		void miniaturize(NSid sender) @selector("miniaturize:");
		void deminiaturize(NSid sender) @selector("deminiaturize:");
		void toggleFullScreen(NSid sender) @selector("toggleFullScreen:");
		void setContentSize(NSSize size) @selector("setContentSize:");
		void setMovable(bool value) @selector("setMovable:");
		void setLevel(NSInteger level) @selector("setLevel:");
		void setStyleMask(NSWindowStyleMask style) @selector("setStyleMask:");
		NSWindowStyleMask styleMask() @selector("styleMask");
		void setAcceptsMouseMovedEvents(bool value) @selector("setAcceptsMouseMovedEvents:");
		CGFloat backingScaleFactor() const @selector("backingScaleFactor");
		NSPoint convertPointToScreen(NSPoint point) @selector("convertPointToScreen:");
		NSPoint convertPointFromScreen(NSPoint point) @selector("convertPointFromScreen:");
		bool isZoomed() @selector("isZoomed");
		bool isMiniaturized() @selector("isMiniaturized");
		bool isVisible() @selector("isVisible");
		void addChildWindow(NSWindow child, NSWindowOrderingMode mode) @selector("addChildWindow:ordered:");
	}

	enum NSWindowOrderingMode : NSInteger {
		Below = -1,
		Out = 0,
		Above = 1,
	}

	extern class NSView : NSResponder {
		override static NSView alloc() @selector("alloc");
		NSView initWithFrame(NSRect frame) @selector("initWithFrame:");
		NSRect bounds() const @selector("bounds");
		NSRect convertRectToBacking(NSRect rect) @selector("convertRectToBacking:");
		bool acceptsFirstResponder() @selector("acceptsFirstResponder");
		bool becomeFirstResponder() @selector("becomeFirstResponder");
		void setNeedsDisplay(bool value) @selector("setNeedsDisplay:");
		void interpretKeyEvents(NSArray events) @selector("interpretKeyEvents:");
		NSPoint convertPoint(NSPoint point, NSView source) @selector("convertPoint:fromView:");
		void addTrackingArea(NSTrackingArea trackingArea) @selector("addTrackingArea:");
		void removeTrackingArea(NSTrackingArea trackingArea) @selector("removeTrackingArea:");
		NSWindow window() @selector("window");
	}

	extern class NSScreen : NSObject {
		static NSScreen mainScreen() @selector("mainScreen");
		NSRect frame() const @selector("frame");
		CGFloat backingScaleFactor() const @selector("backingScaleFactor");
	}

	enum NSTrackingAreaOptions : NSUInteger {
		MouseEnteredAndExited = 0x01,
		MouseMoved = 0x02,
		ActiveAlways = 0x80,
		InVisibleRect = 0x200,
	}

	extern class NSTrackingArea : NSObject {
		override static NSTrackingArea alloc() @selector("alloc");
		NSTrackingArea initWithRect(
			NSRect rect,
			NSTrackingAreaOptions options,
			NSid owner,
			NSid userInfo,
		) @selector("initWithRect:options:owner:userInfo:");
	}

	enum NSOpenGLPixelFormatAttribute : uint {
		DoubleBuffer = 5,
		ColorSize = 8,
		AlphaSize = 11,
		DepthSize = 12,
		StencilSize = 13,
		Accelerated = 73,
		OpenGLProfile = 99,
		ProfileVersion3_2Core = 0x3200,
		ProfileVersion4_1Core = 0x4100,
	}

	enum NSOpenGLContextParameter : NSInteger {
		SwapInterval = 222,
	}

	extern class NSOpenGLPixelFormat : NSObject {
		override static NSOpenGLPixelFormat alloc() @selector("alloc");
		NSOpenGLPixelFormat initWithAttributes(const(NSOpenGLPixelFormatAttribute)* attributes)
			@selector("initWithAttributes:");
	}

	extern class NSOpenGLContext : NSObject {
		override static NSOpenGLContext alloc() @selector("alloc");
		NSOpenGLContext initWithFormat(NSOpenGLPixelFormat format, NSOpenGLContext share)
			@selector("initWithFormat:shareContext:");
		void makeCurrentContext() @selector("makeCurrentContext");
		void clearDrawable() @selector("clearDrawable");
		void flushBuffer() @selector("flushBuffer");
		void update() @selector("update");
		void setView(NSView view) @selector("setView:");
		void setValues(const(int)* values, NSOpenGLContextParameter parameter)
			@selector("setValues:forParameter:");
	}

	extern class NSOpenGLView : NSView {
		override static NSOpenGLView alloc() @selector("alloc");
		NSOpenGLView initWithFrame(NSRect frame, NSOpenGLPixelFormat format)
			@selector("initWithFrame:pixelFormat:");
		void setOpenGLContext(NSOpenGLContext context) @selector("setOpenGLContext:");
	}

	extern class NSTimer : NSObject {
		static NSTimer scheduledTimer(
			NSTimeInterval interval,
			NSid target,
			SEL selector,
			NSid userInfo,
			bool repeats,
		) @selector("scheduledTimerWithTimeInterval:target:selector:userInfo:repeats:");
		void invalidate() @selector("invalidate");
	}

	extern interface NSTextInputClient {
		void insertText(NSid text, NSRange replacementRange) @selector("insertText:replacementRange:");
		void doCommandBySelector(SEL selector) @selector("doCommandBySelector:");
		void setMarkedText(NSid text, NSRange selectedRange, NSRange replacementRange)
			@selector("setMarkedText:selectedRange:replacementRange:");
		void unmarkText() @selector("unmarkText");
		NSRange selectedRange() @selector("selectedRange");
		NSRange markedRange() @selector("markedRange");
		bool hasMarkedText() @selector("hasMarkedText");
		NSAttributedString attributedSubstringForProposedRange(NSRange range, NSRange* actualRange)
			@selector("attributedSubstringForProposedRange:actualRange:");
		NSArray validAttributesForMarkedText() @selector("validAttributesForMarkedText");
		NSRect firstRectForCharacterRange(NSRange range, NSRange* actualRange)
			@selector("firstRectForCharacterRange:actualRange:");
		NSUInteger characterIndexForPoint(NSPoint point) @selector("characterIndexForPoint:");
	}

	extern class NSImageRep : NSObject {}

	extern class NSBitmapImageRep : NSImageRep {
		override static NSBitmapImageRep alloc() @selector("alloc");
		NSBitmapImageRep initWithBitmapDataPlanes(
			ubyte** planes,
			NSInteger width,
			NSInteger height,
			NSInteger bitsPerSample,
			NSInteger samplesPerPixel,
			bool hasAlpha,
			bool isPlanar,
			NSString colorSpaceName,
			NSInteger bytesPerRow,
			NSInteger bitsPerPixel,
		) @selector("initWithBitmapDataPlanes:pixelsWide:pixelsHigh:bitsPerSample:samplesPerPixel:hasAlpha:isPlanar:colorSpaceName:bytesPerRow:bitsPerPixel:");
		ubyte* bitmapData() @selector("bitmapData");
	}

	extern __gshared NSString NSDeviceRGBColorSpace;

	enum NSCompositingOperation : NSUInteger {
		Copy = 1,
	}

	extern class NSImage : NSObject {
		override static NSImage alloc() @selector("alloc");
		NSImage initWithSize(NSSize size) @selector("initWithSize:");
		NSImage initWithCGImage(CGImage image, NSSize size) @selector("initWithCGImage:size:");
		void addRepresentation(NSImageRep representation) @selector("addRepresentation:");
		void drawInRect(
			NSRect destination,
			NSRect source,
			NSCompositingOperation operation,
			CGFloat fraction,
			bool respectFlipped,
			NSid hints,
		) @selector("drawInRect:fromRect:operation:fraction:respectFlipped:hints:");
	}

	extern class NSCursor : NSObject {
		override static NSCursor alloc() @selector("alloc");
		NSCursor initWithImage(NSImage image, NSPoint hotspot) @selector("initWithImage:hotSpot:");
		static NSCursor arrowCursor() @selector("arrowCursor");
		static NSCursor crosshairCursor() @selector("crosshairCursor");
		static NSCursor operationNotAllowedCursor() @selector("operationNotAllowedCursor");
		static NSCursor dragLinkCursor() @selector("dragLinkCursor");
		static NSCursor dragCopyCursor() @selector("dragCopyCursor");
		static NSCursor contextualMenuCursor() @selector("contextualMenuCursor");
		static NSCursor pointingHandCursor() @selector("pointingHandCursor");
		static NSCursor closedHandCursor() @selector("closedHandCursor");
		static NSCursor openHandCursor() @selector("openHandCursor");
		static NSCursor IBeamCursor() @selector("IBeamCursor");
		static NSCursor IBeamCursorForVerticalLayout() @selector("IBeamCursorForVerticalLayout");
		static NSCursor resizeLeftRightCursor() @selector("resizeLeftRightCursor");
		static NSCursor resizeUpDownCursor() @selector("resizeUpDownCursor");
		static void hide() @selector("hide");
		static void unhide() @selector("unhide");
		void set() @selector("set");
	}

	extern class NSPasteboard : NSObject {
		static NSPasteboard generalPasteboard() @selector("generalPasteboard");
		NSInteger clearContents() @selector("clearContents");
		bool setString(NSString value, NSString dataType) @selector("setString:forType:");
		NSString stringForType(NSString dataType) @selector("stringForType:");
		NSArray types() @selector("types");
	}

	extern __gshared NSString NSPasteboardTypeString;
}

alias CGColorSpace = void*;
alias CGDataProvider = void*;
alias CGImage = void*;
alias CGDataProviderReleaseDataCallback = extern (C) void function(
	void*, const(void)*, size_t,
) nothrow @nogc;

extern (C) {
	CGColorSpace CGColorSpaceCreateDeviceRGB();
	void CGColorSpaceRelease(CGColorSpace colorSpace);
	CGDataProvider CGDataProviderCreateWithData(
		void* info,
		const(void)* data,
		size_t size,
		CGDataProviderReleaseDataCallback releaseData,
	);
	void CGDataProviderRelease(CGDataProvider provider);
	CGImage CGImageCreate(
		size_t width,
		size_t height,
		size_t bitsPerComponent,
		size_t bitsPerPixel,
		size_t bytesPerRow,
		CGColorSpace colorSpace,
		uint bitmapInfo,
		CGDataProvider provider,
		const(CGFloat)* decode,
		bool shouldInterpolate,
		int renderingIntent,
	);
	void CGImageRelease(CGImage image);
}

extern (C) {
	SEL sel_registerName(const(char)* name);
	int CGAssociateMouseAndMouseCursorPosition(bool connected);
	int CGWarpMouseCursorPosition(NSPoint position);
}

struct OSXString {
	private NSString value;

	this(scope const(char)[] text) {
		value = NSString.alloc.initWithBytes(
			cast(const(ubyte)*) text.ptr,
			text.length,
			NSStringEncoding.UTF8,
		);
	}

	@disable this(this);

	~this() {
		if (value)
			value.release();
	}

	NSString borrow() => value;
}

string toDString(NSString value) {
	if (!value)
		return null;

	import std.string : fromStringz;

	return value.UTF8String.fromStringz.idup;
}

NSImage createImage(NSSize size, const(uint)[] data, bool hasAlpha = true) {
	import core.stdc.stdlib : free, malloc;
	import core.stdc.string : memcpy;
	import std.exception : enforce;

	assert(size.width > 0 && size.height > 0);
	assert(data.length == cast(size_t)(size.width * size.height));

	size_t byteLength = data.length * uint.sizeof;
	void* pixels = malloc(byteLength);
	enforce(pixels, "failed to allocate macOS image pixels");
	memcpy(pixels, data.ptr, byteLength);

	CGDataProvider provider = CGDataProviderCreateWithData(
		pixels,
		pixels,
		byteLength,
		&releaseImageData,
	);
	if (!provider) {
		free(pixels);
		enforce(false, "failed to create macOS image data provider");
	}
	scope (exit) CGDataProviderRelease(provider);

	CGColorSpace colorSpace = CGColorSpaceCreateDeviceRGB();
	enforce(colorSpace, "failed to create macOS RGB color space");
	scope (exit) CGColorSpaceRelease(colorSpace);

	// Image colors are stored as RGBA bytes, matching the engine's GL texture uploads.
	enum uint alphaLast = 3;
	enum uint alphaNoneSkipLast = 5;
	CGImage cgImage = CGImageCreate(
		cast(size_t) size.width,
		cast(size_t) size.height,
		8,
		32,
		cast(size_t) size.width * uint.sizeof,
		colorSpace,
		hasAlpha ? alphaLast : alphaNoneSkipLast,
		provider,
		null,
		false,
		0,
	);
	enforce(cgImage, "failed to create macOS image");
	scope (exit) CGImageRelease(cgImage);

	NSImage image = NSImage.alloc.initWithCGImage(cgImage, size);
	enforce(image, "failed to create NSImage");
	return image;
}

private extern (C) void releaseImageData(void* info, const(void)*, size_t) nothrow @nogc {
	import core.stdc.stdlib : free;

	free(info);
}
