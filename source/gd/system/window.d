module gd.system.window;
import gd.resource;
import gd.keycode;
import gd.signal;
import gd.graphics;
import gd.math;

struct GLOptions {
	int versionMajor = 3;
	int versionMinor = 0;
	int depthSize = 16;
}

struct WindowInitOptions {
	GLOptions gl;
	bool oversizeBuffer = true;

	string title = "Window";
	IVec2 size = IVec2(800, 600);
	WindowState initialState = WindowState.none;
	Color backgroundColor = Color.fromHex("#fff");
}

enum PointerType {
	mouse,
	touch,
}

enum PointerFlags {
	none              = 0x0000,
	canSetPosition    = 0x0001,
	hasPressure       = 0x0002,
	hasScreenPosition = 0x0004,
}

abstract class Pointer : Resource {

	abstract PointerType type() const @property;
	abstract PointerFlags flags() const @property;

	Signal!Vec2 onPositionChange;
	abstract Vec2 position() const @property;
	abstract void position(Vec2 newPosition) @property;

	Signal!double onPressureChange;
	abstract double pressure() const @property;

	/++ relative motion event; see also onPositionChange +/
	Signal!Vec2 onMovement;
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
	none       = 0x0000,
	minimized  = 0x0001,
	maximized  = 0x0002,
	fullscreen = 0x0004,
	visible    = 0x0008,
	attention  = 0x0010,
	topmost    = 0x0020,
}

alias PaintHandler = IRect delegate(IRect, IVec2);

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

	// TODO: this can be handled commonly
	// void enableInputEmulation(InputEmulation emulation) {}
	// void disableInputEmulation(InputEmulation emulation) {}

	abstract void setPaintHandler(PaintHandler handler);
	abstract void invalidate(IRect region);

	abstract string title() const @property;
	abstract void title(string value) @property;

	abstract IVec2 size() const @property;
	abstract void size(IVec2 value) @property;

	abstract WindowState state() const @property;
	abstract void state(WindowState value) @property;

	abstract Color backgroundColor() const @property;
	abstract void backgroundColor(Color value) @property;

}
