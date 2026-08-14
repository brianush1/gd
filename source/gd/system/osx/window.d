module gd.system.osx.window;
import gd.system.osx.bindings;
import gd.system.osx.display;
import gd.system.display;
import gd.system.window;
import gd.resource;
import gd.keycode;
import gd.cursor;
import gd.math;
import gd.bindings.vulkan : VkAllocationCallbacks, VkInstance, VkSurfaceKHR;
import std.algorithm : min, max;
import std.exception;

version (gd_OSX):

import core.attribute : selector;

class OSXPointer : Pointer {
	private OSXWindow window;
	private OSXCursor m_cursor;
	private bool cursorHidden;
	private bool lockedInPlace;

	private this(OSXWindow window) {
		scope (failure) dispose();
		addDependency(window);
		this.window = window;
		m_flags = PointerFlags.CanSetPosition
			| PointerFlags.HasScreenPosition
			| PointerFlags.RelativeMotion
			| PointerFlags.CanConstrain;
	}

	protected override void disposeImpl() {
		removeConstraint();
		showCursor();
	}

	private PointerFlags m_flags;
	override PointerFlags flags() const @property => m_flags;

	override Vec2 position() const @property {
		NSPoint point = NSEvent.mouseLocation();
		point = (cast() window).native.convertPointFromScreen(point);
		point = (cast() window).view.convertPoint(point, null);
		return (cast() window).fromViewPoint(point);
	}

	override void position(Vec2 value) @property {
		NSPoint point = window.toViewPoint(value);
		point = window.native.convertPointToScreen(point);
		NSRect mainScreenFrame = NSScreen.mainScreen().frame;
		point.y = mainScreenFrame.origin.y + mainScreenFrame.size.height - point.y;
		CGWarpMouseCursorPosition(point);
		onPositionChange.emit(value);
	}

	override double pressure() const @property => 1;
	override Vec2 tilt() const @property => Vec2(0, 0);

	private void showCursor() {
		if (cursorHidden) {
			NSCursor.unhide();
			cursorHidden = false;
		}
	}

	override void cursor(Cursor value) @property {
		OSXCursor osxCursor = cast(OSXCursor) value;
		enforce(osxCursor, "expected macOS cursor");
		m_cursor = osxCursor;
		if (osxCursor.native) {
			showCursor();
			osxCursor.native.set();
		}
		else if (!cursorHidden) {
			NSCursor.hide();
			cursorHidden = true;
		}
	}

	override void cursor(Cursors value) @property {
		if (value !in window.display.systemCursorMap)
			value = Cursors.Arrow;
		cursor = window.display.systemCursorMap[value];
	}

	override void lockInPlace() {
		if (lockedInPlace)
			return;
		lockedInPlace = true;
		CGAssociateMouseAndMouseCursorPosition(false);
	}

	override void removeConstraint() {
		if (!lockedInPlace)
			return;
		lockedInPlace = false;
		CGAssociateMouseAndMouseCursorPosition(true);
		if (m_cursor && m_cursor.native) {
			showCursor();
			m_cursor.native.set();
		}
	}

	package void handleMotion(NSEvent event) {
		Vec2 delta = Vec2(event.deltaX, event.deltaY);
		if (delta != Vec2(0, 0))
			onMotion.emit(delta);

		if (!lockedInPlace) {
			Vec2 newPosition = window.fromViewPoint(event.locationInWindow);
			onPositionChange.emit(newPosition);
		}
	}

	package void handleScroll(NSEvent event) {
		Vec2 delta = Vec2(event.scrollingDeltaX, -event.scrollingDeltaY);
		if (event.hasPreciseScrollingDeltas)
			delta /= 10.0;
		onScroll.emit(ScrollEvent(delta, event.momentumPhase != NSEventPhase.None));
	}
}

class OSXWindow : Window {
	private OSXDisplay m_display;
	inout(OSXDisplay) display() inout @property => m_display;
	private GraphicsBackend m_graphicsBackend;
	override GraphicsBackend graphicsBackend() const @property => m_graphicsBackend;

	package NSWindow native;
	package OSXView view;
	private NSOpenGLContext context;
	private NSOpenGLPixelFormat pixelFormat;
	private OSXWindowDelegate windowDelegate;
	private NSTrackingArea trackingArea;
	private OSXPointer primaryPointer;
	private bool isModal;
	private bool hasIMEFocus;
	private string imeText;
	private int imeSelectionStart;
	private int imeSelectionEnd;
	private IVec2 imeCursorPosition;
	private NSInteger attentionRequest;

	package this(OSXDisplay display, WindowInitOptions options) {
		scope (failure) dispose();
		addDependency(display);
		m_display = display;
		m_graphicsBackend = options.graphicsBackend;
		isModal = options.modalFor !is null;
		enforce(graphicsBackend != GraphicsBackend.Vulkan,
			"Vulkan windows are not supported on macOS");

		NSWindowStyleMask style = NSWindowStyleMask.Titled
			| NSWindowStyleMask.Closable
			| NSWindowStyleMask.Miniaturizable;
		if (!(options.initialState & WindowState.FixedSize))
			style |= NSWindowStyleMask.Resizable;

		NSScreen screen = NSScreen.mainScreen();
		double initialScale = screen ? screen.backingScaleFactor() : 1;
		NSRect contentRect = NSRect(
			NSPoint(0, 0),
			NSSize(options.size.x / initialScale, options.size.y / initialScale),
		);
		native = NSWindow.alloc.initWithContentRect(
			contentRect,
			style,
			NSBackingStoreType.Buffered,
			false,
		);
		enforce(native, "failed to create NSWindow");
		native.setReleasedWhenClosed(false);
		native.setAcceptsMouseMovedEvents(true);

		windowDelegate = OSXWindowDelegate.alloc.init;
		windowDelegate.owner = this;
		native.setDelegate(windowDelegate);

		view = OSXView.alloc.initWithFrame(contentRect);
		enforce(view, "failed to create macOS view");
		view.owner = this;
		native.setContentView(view);
		view.becomeFirstResponder();

		if (graphicsBackend == GraphicsBackend.OpenGL) {
			enforce(options.glVersionMajor < 4
				|| (options.glVersionMajor == 4 && options.glVersionMinor <= 1),
				"macOS OpenGL supports core profiles through version 4.1");
			NSOpenGLPixelFormatAttribute profile = options.glVersionMajor > 3
				|| (options.glVersionMajor == 3 && options.glVersionMinor > 2)
				? NSOpenGLPixelFormatAttribute.ProfileVersion4_1Core
				: NSOpenGLPixelFormatAttribute.ProfileVersion3_2Core;
			NSOpenGLPixelFormatAttribute[13] attributes = [
				NSOpenGLPixelFormatAttribute.OpenGLProfile,
				profile,
				NSOpenGLPixelFormatAttribute.DoubleBuffer,
				NSOpenGLPixelFormatAttribute.ColorSize, cast(NSOpenGLPixelFormatAttribute) 24,
				NSOpenGLPixelFormatAttribute.AlphaSize, cast(NSOpenGLPixelFormatAttribute) 8,
				NSOpenGLPixelFormatAttribute.DepthSize, cast(NSOpenGLPixelFormatAttribute) options.depthSize,
				NSOpenGLPixelFormatAttribute.StencilSize, cast(NSOpenGLPixelFormatAttribute) 8,
				NSOpenGLPixelFormatAttribute.Accelerated,
				cast(NSOpenGLPixelFormatAttribute) 0,
			];
			pixelFormat = NSOpenGLPixelFormat.alloc.initWithAttributes(attributes.ptr);
			enforce(pixelFormat, "failed to create macOS OpenGL pixel format");

			NSOpenGLContext shareContext;
			if (options.shareContext) {
				OSXWindow shareWindow = cast(OSXWindow) options.shareContext;
				enforce(shareWindow, "expected macOS window as shared OpenGL context");
				enforce(shareWindow.graphicsBackend == GraphicsBackend.OpenGL,
					"shareContext must refer to an OpenGL window");
				shareContext = shareWindow.context;
			}
			context = NSOpenGLContext.alloc.initWithFormat(pixelFormat, shareContext);
			enforce(context, "failed to create macOS OpenGL context");
			context.setView(view);
		}
		else {
			enforce(options.shareContext is null,
				"shareContext is only valid for OpenGL windows");
		}

		trackingArea = NSTrackingArea.alloc.initWithRect(
			contentRect,
			NSTrackingAreaOptions.MouseEnteredAndExited
				| NSTrackingAreaOptions.MouseMoved
				| NSTrackingAreaOptions.ActiveAlways
				| NSTrackingAreaOptions.InVisibleRect,
			cast(NSid) view,
			null,
		);
		view.addTrackingArea(trackingArea);

		title = options.title;
		native.center();
		if (options.modalFor) {
			OSXWindow parent = cast(OSXWindow) options.modalFor;
			enforce(parent, "expected macOS modal parent");
			parent.native.addChildWindow(native, NSWindowOrderingMode.Above);
		}

		primaryPointer = new OSXPointer(this);
		primaryPointer.cursor = Cursors.Arrow;
		updateSize();
		if (graphicsBackend == GraphicsBackend.OpenGL)
			makeContextCurrent();

		assert(!(options.initialState & WindowState.Visible),
			"window cannot be visible on creation, since a paint handler ought to be set when the window is first shown");
		state = options.initialState;
	}

	protected override void disposeImpl() {
		if (attentionRequest)
			NSApplication.sharedApplication().cancelUserAttentionRequest(attentionRequest);
		if (trackingArea && view)
			view.removeTrackingArea(trackingArea);
		if (trackingArea)
			trackingArea.release();
		if (context)
			context.clearDrawable();
		if (native)
			native.close();
		if (windowDelegate) {
			windowDelegate.owner = null;
			windowDelegate.release();
		}
		if (view) {
			view.owner = null;
			view.release();
		}
		if (context)
			context.release();
		if (pixelFormat)
			pixelFormat.release();
		if (native)
			native.release();
		trackingArea = null;
		windowDelegate = null;
		view = null;
		context = null;
		pixelFormat = null;
		native = null;
	}

	override inout(Pointer)[] pointers() inout @property => [primaryPointer];
	override double devicePixelRatio() const @property => native ? native.backingScaleFactor() : 1;

	override void setIcon(IVec2 size, const(uint)[] data) {
		// macOS app-icon artwork occupies roughly 80% of its canvas. The engine's
		// cross-platform icon fills its source image, so supply that safe area here.
		IVec2 canvasSize = (size * 5 + IVec2(3)) / 4;
		IVec2 offset = (canvasSize - size) / 2;
		uint[] canvas = new uint[canvasSize.x * cast(size_t) canvasSize.y];
		foreach (y; 0 .. size.y) {
			size_t sourceStart = y * cast(size_t) size.x;
			size_t targetStart = (y + offset.y) * cast(size_t) canvasSize.x + offset.x;
			canvas[targetStart .. targetStart + size.x] = data[sourceStart .. sourceStart + size.x];
		}

		NSImage image = createImage(NSSize(canvasSize.x, canvasSize.y), canvas);
		NSApplication.sharedApplication().setApplicationIconImage(image);
		image.release();
	}

	private PaintHandler paintHandler;
	override void setPaintHandler(PaintHandler handler) { paintHandler = handler; }

	private PaintHandler postPaintHandler;
	override void setPostPaintHandler(PaintHandler handler) { postPaintHandler = handler; }

	override void invalidate(IRect region) {
		if (IRect* queued = this in display.invalidationQueue)
			*queued = queued.minimalUnion(region);
		else
			display.invalidationQueue[this] = region;
	}

	package void updateRegion(IRect region) {
		if (!disposed)
			view.setNeedsDisplay(true);
	}

	override void setIMEFocus(bool focus) {
		hasIMEFocus = focus;
		if (focus) {
			view.becomeFirstResponder();
		}
		else {
			view.unmarkText();
		}
	}

	override void setIMECursorPosition(IVec2 position) {
		imeCursorPosition = position;
	}

	override void setIMETextState(string text, int selectionStart, int selectionEnd) {
		imeText = text;
		imeSelectionStart = selectionStart;
		imeSelectionEnd = selectionEnd;
	}

	package TextInputEvent textInputEvent(string text, NSRange replacementRange) {
		int start;
		int end;
		if (replacementRange.location == NSNotFound) {
			start = min(imeSelectionStart, imeSelectionEnd);
			end = max(imeSelectionStart, imeSelectionEnd);
		}
		else {
			start = utf16ToCodePoint(imeText, replacementRange.location);
			end = utf16ToCodePoint(
				imeText,
				replacementRange.location + replacementRange.length,
			);
		}
		return TextInputEvent(text, start, end - start);
	}

	package NSRange imeSelectedRange() {
		NSUInteger start = codePointToUTF16(imeText, min(imeSelectionStart, imeSelectionEnd));
		NSUInteger end = codePointToUTF16(imeText, max(imeSelectionStart, imeSelectionEnd));
		return NSRange(start, end - start);
	}

	package NSRect imeCursorRect() {
		double scale = devicePixelRatio;
		NSPoint point = NSPoint(imeCursorPosition.x / scale, view.bounds.size.height - imeCursorPosition.y / scale);
		point = native.convertPointToScreen(point);
		return NSRect(point, NSSize(1, 18));
	}

	override void setSwapInterval(bool vsync) {
		enforce(graphicsBackend == GraphicsBackend.OpenGL,
			"setSwapInterval is only valid for OpenGL windows");
		int value = vsync ? 1 : 0;
		context.setValues(&value, NSOpenGLContextParameter.SwapInterval);
	}

	override void makeContextCurrent() {
		enforce(graphicsBackend == GraphicsBackend.OpenGL,
			"makeContextCurrent is only valid for OpenGL windows");
		context.makeCurrentContext();
	}

	override VkSurfaceKHR createVulkanSurface(
		VkInstance instance, const(VkAllocationCallbacks)* allocator = null
	) {
		throw new Exception("Vulkan windows are not supported on macOS");
	}

	package void repaintImmediately() {
		if (!paintHandler)
			return;
		if (graphicsBackend == GraphicsBackend.OpenGL)
			makeContextCurrent();
		paintHandler();
		if (graphicsBackend == GraphicsBackend.OpenGL) {
			context.flushBuffer();
		}
		else {
			NSImage image = createImage(NSSize(size.x, size.y), framebuffer, false);
			scope (exit) image.release();
			image.drawInRect(view.bounds, NSRect.init,
				NSCompositingOperation.Copy, 1, true, null);
		}
		if (postPaintHandler)
			postPaintHandler();
	}

	private string m_title;
	override string title() const @property => m_title;
	override void title(string value) @property {
		m_title = value;
		OSXString nativeTitle = OSXString(value);
		native.setTitle(nativeTitle.borrow);
	}

	private IVec2 m_size;
	override IVec2 size() const @property => m_size;
	override void size(IVec2 value) @property {
		double scale = devicePixelRatio;
		native.setContentSize(NSSize(value.x / scale, value.y / scale));
		updateSize();
	}

	package void updateSize() {
		NSRect backing = view.convertRectToBacking(view.bounds);
		IVec2 value = IVec2(
			cast(int) backing.size.width,
			cast(int) backing.size.height,
		);
		if (value.x < 1) value.x = 1;
		if (value.y < 1) value.y = 1;
		if (context)
			context.update();
		if (value != m_size) {
			m_size = value;
			onSizeChange.emit(m_size);
		}
	}

	private WindowState m_state;
	override WindowState state() const @property => m_state;
	override void state(WindowState value) @property {
		if (value == m_state)
			return;

		WindowState previous = m_state;
		WindowState add = value & ~previous;
		WindowState remove = previous & ~value;
		m_state = value;

		if (add & WindowState.Visible)
			native.makeKeyAndOrderFront(null);
		else if (remove & WindowState.Visible)
			native.orderOut(null);

		if (add & WindowState.Minimized)
			native.miniaturize(null);
		else if (remove & WindowState.Minimized)
			native.deminiaturize(null);

		if ((add | remove) & WindowState.Maximized) {
			bool shouldZoom = (value & WindowState.Maximized) != 0;
			if (native.isZoomed() != shouldZoom)
				native.zoom(null);
		}

		if ((add | remove) & WindowState.Fullscreen)
			native.toggleFullScreen(null);

		if (add & WindowState.Attention)
			attentionRequest = NSApplication.sharedApplication().requestUserAttention(NSRequestUserAttentionType.Informational);
		else if ((remove & WindowState.Attention) && attentionRequest) {
			NSApplication.sharedApplication().cancelUserAttentionRequest(attentionRequest);
			attentionRequest = 0;
		}

		if ((add | remove) & WindowState.Topmost)
			native.setLevel(value & WindowState.Topmost ? 3 : 0);

		if ((add | remove) & WindowState.FixedSize) {
			NSWindowStyleMask style = native.styleMask();
			if (value & WindowState.FixedSize)
				style &= ~NSWindowStyleMask.Resizable;
			else
				style |= NSWindowStyleMask.Resizable;
			native.setStyleMask(style);
		}

		onStateChange.emit(m_state);
	}

	package void syncState(WindowState flag, bool enabled) {
		WindowState value = enabled ? m_state | flag : m_state & ~flag;
		if (value != m_state) {
			m_state = value;
			onStateChange.emit(m_state);
		}
	}

	override bool isClipboardAvailable(Clipboard clipboard) {
		final switch (clipboard) {
		case Clipboard.Selection:
			return false;
		case Clipboard.Clipboard:
			return NSPasteboard.generalPasteboard().types().containsObject(cast(NSid) NSPasteboardTypeString);
		}
	}

	override void[] getClipboardData(Clipboard clipboard, string mimeType) {
		if (!isClipboardAvailable(clipboard))
			return null;
		assert(mimeType == "text/plain");
		return cast(void[]) toDString(NSPasteboard.generalPasteboard().stringForType(NSPasteboardTypeString)).dup;
	}

	override void setClipboardData(Clipboard clipboard, string mimeType, const(void)[] data) {
		if (clipboard == Clipboard.Selection)
			return;
		assert(mimeType == "text/plain");
		OSXString value = OSXString(cast(const(char)[]) data);
		NSPasteboard pasteboard = NSPasteboard.generalPasteboard();
		pasteboard.clearContents();
		pasteboard.setString(value.borrow, NSPasteboardTypeString);
	}

	package Vec2 fromViewPoint(NSPoint point) const {
		double scale = devicePixelRatio;
		return Vec2(point.x * scale, (view.bounds.size.height - point.y) * scale);
	}

	package NSPoint toViewPoint(Vec2 point) const {
		double scale = devicePixelRatio;
		return NSPoint(point.x / scale, view.bounds.size.height - point.y / scale);
	}

	package void handleMouseMove(NSEvent event) {
		primaryPointer.handleMotion(event);
	}

	package void handleMouseButton(NSEvent event, bool pressed) {
		primaryPointer.handleMotion(event);
		MouseButton button;
		switch (event.buttonNumber) {
		case 0: button = MouseButton.Left; break;
		case 1: button = MouseButton.Right; break;
		case 2: button = MouseButton.Middle; break;
		case 3: button = MouseButton.X1; break;
		case 4: button = MouseButton.X2; break;
		default: button = MouseButton.Unknown; break;
		}
		if (pressed)
			primaryPointer.onButtonPress.emit(button);
		else
			primaryPointer.onButtonRelease.emit(button);
	}

	package void handleKey(NSEvent event, bool pressed) {
		KeyInfo info;
		info.mods = convertModifiers(event.eventModifierFlags);
		info.physical = physicalKeyCode(event.keyCode);
		info.logical = logicalKeyCode(event.charactersIgnoringModifiers, info.physical);
		emitKey(info, pressed);
	}

	package void handleModifierKey(KeyCode code, Modifiers modifiers, bool pressed) {
		KeyInfo info;
		info.mods = modifiers;
		info.physical = code;
		info.logical = code;
		emitKey(info, pressed);
	}

	private void emitKey(KeyInfo info, bool pressed) {
		if (pressed)
			onKeyPress.emit(info);
		else
			onKeyRelease.emit(info);
	}
}

extern (Objective-C) class OSXWindowDelegate : NSObject, NSWindowDelegate {
	override static OSXWindowDelegate alloc() @selector("alloc");
	override OSXWindowDelegate init() @selector("init");

	OSXWindow owner;

	override void windowDidResize(NSNotification notification) @selector("windowDidResize:") {
		if (owner) owner.updateSize();
	}

	override void windowDidChangeBackingProperties(NSNotification notification)
			@selector("windowDidChangeBackingProperties:") {
		if (owner) {
			owner.updateSize();
			owner.onDevicePixelRatioChange.emit(owner.devicePixelRatio);
		}
	}

	override bool windowShouldClose(NSid sender) @selector("windowShouldClose:") {
		if (owner) owner.onCloseRequest.emit();
		return false;
	}

	override void windowDidBecomeKey(NSNotification notification) @selector("windowDidBecomeKey:") {
		if (owner) owner.onFocusEnter.emit();
	}

	override void windowDidResignKey(NSNotification notification) @selector("windowDidResignKey:") {
		if (owner) owner.onFocusLeave.emit();
	}

	override void windowDidMiniaturize(NSNotification notification) @selector("windowDidMiniaturize:") {
		if (owner) owner.syncState(WindowState.Minimized, true);
	}

	override void windowDidDeminiaturize(NSNotification notification) @selector("windowDidDeminiaturize:") {
		if (owner) owner.syncState(WindowState.Minimized, false);
	}

	override void windowDidEnterFullScreen(NSNotification notification) @selector("windowDidEnterFullScreen:") {
		if (owner) owner.syncState(WindowState.Fullscreen, true);
	}

	override void windowDidExitFullScreen(NSNotification notification) @selector("windowDidExitFullScreen:") {
		if (owner) owner.syncState(WindowState.Fullscreen, false);
	}
}

extern (Objective-C) class OSXView : NSView, NSTextInputClient {
	override static OSXView alloc() @selector("alloc");
	override OSXView initWithFrame(NSRect frame) @selector("initWithFrame:");

	OSXWindow owner;
	private string markedText;
	private int markedReplacementStart = -1;
	private int markedReplacementLength;
	private NSRange markedSelection;

	override bool acceptsFirstResponder() @selector("acceptsFirstResponder") => true;

	void drawRect(NSRect rect) @selector("drawRect:") {
		if (owner) owner.repaintImmediately();
	}

	void reshape() @selector("reshape") {
		if (owner) owner.updateSize();
	}

	override void mouseDown(NSEvent event) @selector("mouseDown:") { if (owner) owner.handleMouseButton(event, true); }
	override void mouseDragged(NSEvent event) @selector("mouseDragged:") { if (owner) owner.handleMouseMove(event); }
	override void mouseUp(NSEvent event) @selector("mouseUp:") { if (owner) owner.handleMouseButton(event, false); }
	override void rightMouseDown(NSEvent event) @selector("rightMouseDown:") { if (owner) owner.handleMouseButton(event, true); }
	override void rightMouseDragged(NSEvent event) @selector("rightMouseDragged:") { if (owner) owner.handleMouseMove(event); }
	override void rightMouseUp(NSEvent event) @selector("rightMouseUp:") { if (owner) owner.handleMouseButton(event, false); }
	override void otherMouseDown(NSEvent event) @selector("otherMouseDown:") { if (owner) owner.handleMouseButton(event, true); }
	override void otherMouseDragged(NSEvent event) @selector("otherMouseDragged:") { if (owner) owner.handleMouseMove(event); }
	override void otherMouseUp(NSEvent event) @selector("otherMouseUp:") { if (owner) owner.handleMouseButton(event, false); }
	override void mouseMoved(NSEvent event) @selector("mouseMoved:") { if (owner) owner.handleMouseMove(event); }
	override void mouseEntered(NSEvent event) @selector("mouseEntered:") { if (owner) owner.primaryPointer.onEnter.emit(); }
	override void mouseExited(NSEvent event) @selector("mouseExited:") { if (owner) owner.primaryPointer.onLeave.emit(); }
	override void scrollWheel(NSEvent event) @selector("scrollWheel:") { if (owner) owner.primaryPointer.handleScroll(event); }

	override void keyDown(NSEvent event) @selector("keyDown:") {
		if (!owner) return;
		owner.handleKey(event, true);
		if (owner.hasIMEFocus)
			interpretKeyEvents(NSArray.arrayWithObject(cast(NSid) event));
	}

	override void keyUp(NSEvent event) @selector("keyUp:") {
		if (owner) owner.handleKey(event, false);
	}

	override void flagsChanged(NSEvent event) @selector("flagsChanged:") {
		if (!owner) return;
		KeyCode code = physicalKeyCode(event.keyCode);
		Modifiers modifiers = convertModifiers(event.eventModifierFlags);
		if (!isModifierKey(code))
			return;
		owner.handleModifierKey(
			code,
			modifiers,
			modifierKeyPressed(code, event.eventModifierFlags),
		);
	}

	extern(D) private NSString textString(NSid value) {
		NSObject object = cast(NSObject) value;
		if (object.respondsToSelector(sel_registerName("string")))
			return (cast(NSAttributedString) value).string();
		return cast(NSString) value;
	}

	override void insertText(NSid text, NSRange replacementRange) @selector("insertText:replacementRange:") {
		if (!owner || !owner.hasIMEFocus) return;
		string value = toDString(textString(text));
		TextInputEvent input = markedText.length
			? TextInputEvent(value, markedReplacementStart, markedReplacementLength)
			: owner.textInputEvent(value, replacementRange);
		if (markedText.length) {
			markedText = null;
			markedReplacementStart = -1;
			owner.onCompositionEnd.emit();
		}
		owner.onTextInput.emit(input);
	}

	override void doCommandBySelector(SEL selector) @selector("doCommandBySelector:") {}

	override void setMarkedText(NSid text, NSRange selectedRange, NSRange replacementRange)
			@selector("setMarkedText:selectedRange:replacementRange:") {
		if (!owner || !owner.hasIMEFocus) return;
		if (!markedText.length) {
			owner.onCompositionStart.emit();
			TextInputEvent input = owner.textInputEvent("", replacementRange);
			markedReplacementStart = input.replacementStart;
			markedReplacementLength = input.replacementLength;
		}
		markedText = toDString(textString(text));
		markedSelection = selectedRange;
		owner.onCompositionUpdate.emit(markedText);
	}

	override void unmarkText() @selector("unmarkText") {
		if (owner && markedText.length) {
			owner.onTextInput.emit(TextInputEvent(
				markedText,
				markedReplacementStart,
				markedReplacementLength,
			));
			owner.onCompositionEnd.emit();
		}
		markedText = null;
		markedReplacementStart = -1;
	}

	override NSRange selectedRange() @selector("selectedRange") {
		if (!owner)
			return NSRange(NSNotFound, 0);
		if (markedText.length) {
			NSUInteger start = codePointToUTF16(owner.imeText, markedReplacementStart);
			return NSRange(start + markedSelection.location, markedSelection.length);
		}
		return owner.imeSelectedRange();
	}
	override NSRange markedRange() @selector("markedRange") {
		if (!owner || !markedText.length)
			return NSRange(NSNotFound, 0);
		return NSRange(
			codePointToUTF16(owner.imeText, markedReplacementStart),
			utf16Length(markedText),
		);
	}
	override bool hasMarkedText() @selector("hasMarkedText") => markedText.length != 0;
	override NSAttributedString attributedSubstringForProposedRange(NSRange range, NSRange* actualRange)
			@selector("attributedSubstringForProposedRange:actualRange:") => null;
	override NSArray validAttributesForMarkedText() @selector("validAttributesForMarkedText") => NSArray.array();
	override NSRect firstRectForCharacterRange(NSRange range, NSRange* actualRange)
			@selector("firstRectForCharacterRange:actualRange:") {
		if (actualRange) *actualRange = range;
		return owner ? owner.imeCursorRect() : NSRect.init;
	}
	override NSUInteger characterIndexForPoint(NSPoint point) @selector("characterIndexForPoint:") => 0;
}

private NSUInteger utf16Length(string value) {
	NSUInteger result;
	foreach (dchar ch; value)
		result += ch > 0xffff ? 2 : 1;
	return result;
}

private NSUInteger codePointToUTF16(string value, int index) {
	NSUInteger result;
	int current;
	foreach (dchar ch; value) {
		if (current >= index)
			break;
		result += ch > 0xffff ? 2 : 1;
		current += 1;
	}
	return result;
}

private int utf16ToCodePoint(string value, NSUInteger index) {
	NSUInteger offset;
	int result;
	foreach (dchar ch; value) {
		if (offset >= index)
			break;
		offset += ch > 0xffff ? 2 : 1;
		result += 1;
	}
	return result;
}

private bool isModifierKey(KeyCode code) {
	switch (code) {
	case KeyCode.LeftShift: case KeyCode.RightShift:
	case KeyCode.LeftCtrl: case KeyCode.RightCtrl:
	case KeyCode.LeftAlt: case KeyCode.RightAlt:
	case KeyCode.LeftSuper: case KeyCode.RightSuper:
	case KeyCode.CapsLock:
		return true;
	default:
		return false;
	}
}

private bool modifierKeyPressed(KeyCode code, NSEventModifierFlags flags) {
	NSUInteger rawFlags = cast(NSUInteger) flags;
	switch (code) {
	case KeyCode.LeftCtrl: return (rawFlags & 0x0001) != 0;
	case KeyCode.LeftShift: return (rawFlags & 0x0002) != 0;
	case KeyCode.RightShift: return (rawFlags & 0x0004) != 0;
	case KeyCode.LeftSuper: return (rawFlags & 0x0008) != 0;
	case KeyCode.RightSuper: return (rawFlags & 0x0010) != 0;
	case KeyCode.LeftAlt: return (rawFlags & 0x0020) != 0;
	case KeyCode.RightAlt: return (rawFlags & 0x0040) != 0;
	case KeyCode.RightCtrl: return (rawFlags & 0x2000) != 0;
	case KeyCode.CapsLock: return (flags & NSEventModifierFlags.CapsLock) != 0;
	default: return false;
	}
}

@("macOS distinguishes left and right modifier flags") unittest {
	assert(modifierKeyPressed(KeyCode.LeftSuper, cast(NSEventModifierFlags) 0x100108));
	assert(!modifierKeyPressed(KeyCode.RightSuper, cast(NSEventModifierFlags) 0x100108));
	assert(modifierKeyPressed(KeyCode.RightCtrl, cast(NSEventModifierFlags) 0x42000));
}

private KeyCode physicalKeyCode(ushort code) {
	switch (code) {
	case 0: return KeyCode.A; case 1: return KeyCode.S; case 2: return KeyCode.D; case 3: return KeyCode.F;
	case 4: return KeyCode.H; case 5: return KeyCode.G; case 6: return KeyCode.Z; case 7: return KeyCode.X;
	case 8: return KeyCode.C; case 9: return KeyCode.V; case 11: return KeyCode.B; case 12: return KeyCode.Q;
	case 13: return KeyCode.W; case 14: return KeyCode.E; case 15: return KeyCode.R; case 16: return KeyCode.Y;
	case 17: return KeyCode.T; case 18: return KeyCode.D1; case 19: return KeyCode.D2; case 20: return KeyCode.D3;
	case 21: return KeyCode.D4; case 22: return KeyCode.D6; case 23: return KeyCode.D5; case 24: return KeyCode.Equals;
	case 25: return KeyCode.D9; case 26: return KeyCode.D7; case 27: return KeyCode.Minus; case 28: return KeyCode.D8;
	case 29: return KeyCode.D0; case 30: return KeyCode.RightSquareBracket; case 31: return KeyCode.O; case 32: return KeyCode.U;
	case 33: return KeyCode.LeftSquareBracket; case 34: return KeyCode.I; case 35: return KeyCode.P; case 36: return KeyCode.Enter;
	case 37: return KeyCode.L; case 38: return KeyCode.J; case 39: return KeyCode.Apostrophe; case 40: return KeyCode.K;
	case 41: return KeyCode.Semicolon; case 42: return KeyCode.Backslash; case 43: return KeyCode.Comma; case 44: return KeyCode.Slash;
	case 45: return KeyCode.N; case 46: return KeyCode.M; case 47: return KeyCode.Period; case 48: return KeyCode.Tab;
	case 49: return KeyCode.Space; case 50: return KeyCode.Backtick; case 51: return KeyCode.Backspace; case 53: return KeyCode.Escape;
	case 55: return KeyCode.LeftSuper; case 56: return KeyCode.LeftShift; case 57: return KeyCode.CapsLock; case 58: return KeyCode.LeftAlt;
	case 59: return KeyCode.LeftCtrl; case 60: return KeyCode.RightShift; case 61: return KeyCode.RightAlt; case 62: return KeyCode.RightCtrl;
	case 65: return KeyCode.KpPeriod; case 67: return KeyCode.KpMultiply; case 69: return KeyCode.KpPlus; case 71: return KeyCode.NumLock;
	case 75: return KeyCode.KpDivide; case 76: return KeyCode.KpEnter; case 78: return KeyCode.KpMinus; case 82: return KeyCode.Kp0;
	case 83: return KeyCode.Kp1; case 84: return KeyCode.Kp2; case 85: return KeyCode.Kp3; case 86: return KeyCode.Kp4;
	case 87: return KeyCode.Kp5; case 88: return KeyCode.Kp6; case 89: return KeyCode.Kp7; case 91: return KeyCode.Kp8;
	case 92: return KeyCode.Kp9; case 96: return KeyCode.F5; case 97: return KeyCode.F6; case 98: return KeyCode.F7;
	case 99: return KeyCode.F3; case 100: return KeyCode.F8; case 101: return KeyCode.F9; case 103: return KeyCode.F11;
	case 109: return KeyCode.F10; case 111: return KeyCode.F12; case 115: return KeyCode.Home; case 116: return KeyCode.PageUp;
	case 117: return KeyCode.Delete; case 118: return KeyCode.F4; case 119: return KeyCode.End; case 120: return KeyCode.F2;
	case 121: return KeyCode.PageDown; case 122: return KeyCode.F1; case 123: return KeyCode.Left; case 124: return KeyCode.Right;
	case 125: return KeyCode.Down; case 126: return KeyCode.Up;
	default: return KeyCode.Unknown;
	}
}

private KeyCode logicalKeyCode(NSString characters, KeyCode fallback) {
	string text = toDString(characters);
	if (!text.length)
		return fallback;
	char value = text[0];
	if (value >= 'a' && value <= 'z')
		return cast(KeyCode)(KeyCode.A + value - 'a');
	if (value >= 'A' && value <= 'Z')
		return cast(KeyCode)(KeyCode.A + value - 'A');
	if (value >= '0' && value <= '9')
		return cast(KeyCode)(KeyCode.D0 + value - '0');
	switch (value) {
	case '`': return KeyCode.Backtick; case '-': return KeyCode.Minus; case '=': return KeyCode.Equals;
	case '[': return KeyCode.LeftSquareBracket; case ']': return KeyCode.RightSquareBracket; case '\\': return KeyCode.Backslash;
	case ';': return KeyCode.Semicolon; case '\'': return KeyCode.Apostrophe; case ',': return KeyCode.Comma;
	case '.': return KeyCode.Period; case '/': return KeyCode.Slash; case ' ': return KeyCode.Space;
	case '~': return KeyCode.Tilde; case '_': return KeyCode.Underscore; case '+': return KeyCode.Plus;
	case '{': return KeyCode.LeftBrace; case '}': return KeyCode.RightBrace; case '|': return KeyCode.Bar;
	case ':': return KeyCode.Colon; case '"': return KeyCode.Quote; case '<': return KeyCode.LesserSign;
	case '>': return KeyCode.GreaterSign; case '?': return KeyCode.QuestionMark;
	default: return fallback;
	}
}
