module gd.system.display;
import gd.system.window;
import gd.resource;
import gd.keycode;
import gd.math;

abstract class Cursor : Resource {}

abstract class Display : Resource {

	/++

	Creates a new $(REF Window) with the given options. The window starts hidden by default.

	+/
	abstract Window createWindow(WindowInitOptions options);

	// TODO: animated cursors
	abstract Cursor createCursor(IVec2 size, const(uint)[] data, IVec2 hotspot);
	abstract Cursor createXorCursor(IVec2 size, const(uint)[] data, IVec2 hotspot);

	abstract Modifiers getCurrentModifiers();

	abstract bool isActive();
	abstract void deactivate();
	abstract void processEvents();

}
