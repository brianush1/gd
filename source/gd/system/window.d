module gd.system.window;
import gd.resource;
import gd.keycode;
import gd.signal;
import gd.graphics.color;
import gd.cursor;
import gd.math;

struct WindowInitOptions {
	int depthSize = 16;
	int glVersionMajor = 3;
	int glVersionMinor = 0;

	string title = "Window";
	string className = "window";
	string applicationName = "Application";
	IVec2 size = IVec2(800, 600);
	WindowState initialState = WindowState.None;
}

enum PointerFlags {
	None              = 0x0000,
	CanSetPosition    = 0x0001,
	HasPressure       = 0x0002,
	HasScreenPosition = 0x0004,
	RelativeMotion    = 0x0008,
	CanConstrain      = 0x0010,
	HasTilt           = 0x0020,
}

abstract class Pointer : Resource {

	abstract PointerFlags flags() const @property;

	Signal!Vec2 onPositionChange;
	abstract Vec2 position() const @property;
	abstract void position(Vec2 newPosition) @property;

	Signal!double onPressureChange;
	abstract double pressure() const @property;

	Signal!Vec2 onTiltChange;
	abstract Vec2 tilt() const @property;

	abstract void cursor(Cursors value) @property;

	/++ raw relative motion event; see also onPositionChange +/
	Signal!Vec2 onMotion;
	Signal!Vec2 onScroll;
	Signal!() onEnter;
	Signal!() onLeave;
	Signal!() onRemove;

	Signal!MouseButton onButtonPress;
	Signal!MouseButton onButtonRelease;

	abstract void lockInPlace();
	abstract void removeConstraint();

}

enum WindowState : uint {
	None       = 0x0000,
	Minimized  = 0x0001,
	Maximized  = 0x0002,
	Fullscreen = 0x0004,
	Visible    = 0x0008,
	Attention  = 0x0010,
	Topmost    = 0x0020,
}

alias PaintHandler = void delegate();

struct KeyInfo {
	Modifiers mods;
	KeyCode physical;
	KeyCode logical;
}

abstract class Window : Resource {

	/++ Fired when the user requests to close the window, for example by clicking the close button +/
	Signal!() onCloseRequest;
	/++

	Fired when a pointer is added to the window.

	+/
	Signal!Pointer onPointerAdd;
	Signal!KeyInfo onKeyPress;
	Signal!KeyInfo onKeyRelease;
	Signal!() onFocusEnter;
	Signal!() onFocusLeave;
	Signal!(uint, Vec2) onTouchStart;
	Signal!(uint, Vec2) onTouchMove;
	Signal!(uint) onTouchEnd;

	Signal!IVec2 onSizeChange;
	Signal!WindowState onStateChange;

	Slot handlePointer(Handler!Pointer handler) {
		Slot result = onPointerAdd.connect(handler);

		foreach (pointer; pointers) {
			handler(pointer);
		}

		return result;
	}

	abstract inout(Pointer)[] pointers() inout @property;

	inout(Pointer) primaryPointer() inout @property {
		return pointers[0];
	}

	abstract void setIcon(IVec2 size, const(uint)[] data);
	abstract void setPaintHandler(PaintHandler handler);
	abstract void invalidate(IRect region);

	abstract void makeContextCurrent();

	abstract string title() const @property;
	abstract void title(string value) @property;

	abstract IVec2 size() const @property;
	abstract void size(IVec2 value) @property;

	abstract WindowState state() const @property;
	abstract void state(WindowState value) @property;

}
