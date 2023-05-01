module gd.internal.display;
import gd.internal.window;
import gd.graphics;
import gd.resource;

abstract class Display : Resource {

	abstract inout(GraphicsContext) headlessGraphicsContext() inout @property;

	/++

	Creates a new $(REF Window) with the given options. The window starts hidden by default.

	+/
	abstract Window createWindow(WindowInitOptions options);

	abstract bool isActive();
	abstract void deactivate();
	abstract void processEvents();

}
