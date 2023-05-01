module gd.application;

void quitApp(int exitCode = 0) {
	import gd.internal.application : application;

	application.exitCode = exitCode;
	application.deactivate();
}

void runApp() {
	import gd.internal.application : application;

	application.startEventLoop();
}
