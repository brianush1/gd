module gd.system.display;
import gd.system.window;
import gd.resource;

abstract class Display : Resource {

	/++

	Creates a new $(REF Window) with the given options. The window starts hidden by default.

	+/
	abstract Window createWindow(WindowInitOptions options);

	abstract bool isActive();
	abstract void deactivate();
	abstract void processEvents();

}
