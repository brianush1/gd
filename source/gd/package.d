module gd;
public import gd.graphics;
public import gd.gui;
public import gd.math;
public import gd.timer;
public import gd.signal;

void quitApp() {
	import gd.system.application : application;

	application.deactivate();
}

void runApp() {
	import gd.system.application : application;

	application.startEventLoop();
}
