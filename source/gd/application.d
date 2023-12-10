module gd.application;

void quitApp(int exitCode = 0) {
	import gd.system.application : application;

	application.exitCode = exitCode;
	application.deactivate();
}

void runApp() {
	import gd.system.application : application;

	application.startEventLoop();
}
