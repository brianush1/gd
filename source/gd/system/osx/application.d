module gd.system.osx.application;
import gd.system.osx.display;
import gd.system.osx.timer;
import gd.system.osx.socket;
import gd.system.osx.ssl;
import gd.system.osx.bindings;
import gd.system.application;

version (gd_OSX):

import core.attribute : selector;

class OSXApplication : Application {
	private NSApplication native;
	private NSAutoreleasePool lifetimePool;
	private OSXApplicationDelegate applicationDelegate;

	package(gd.system) this() {
		scope (failure) dispose();

		lifetimePool = NSAutoreleasePool.alloc.init;
		native = NSApplication.sharedApplication();
		native.setActivationPolicy(NSApplicationActivationPolicy.Regular);
		applicationDelegate = OSXApplicationDelegate.alloc.init;
		applicationDelegate.owner = this;
		native.setDelegate(applicationDelegate);
		configureMainMenu();
		native.finishLaunching();
		native.activateIgnoringOtherApps(false);
	}

	private void configureMainMenu() {
		OSXString bundleNameKey = OSXString("CFBundleName");
		string applicationName = toDString(cast(NSString)
			NSBundle.mainBundle().objectForInfoDictionaryKey(bundleNameKey.borrow));
		if (!applicationName.length)
			applicationName = toDString(NSProcessInfo.processInfo().processName());

		NSMenu createMenu(string title) {
			OSXString nativeTitle = OSXString(title);
			return NSMenu.alloc.initWithTitle(nativeTitle.borrow);
		}

		void addItem(NSMenu menu, string title, const(char)* action, string keyEquivalent = null) {
			OSXString nativeTitle = OSXString(title);
			OSXString nativeKey = OSXString(keyEquivalent);
			NSMenuItem item = NSMenuItem.alloc.initWithTitle(
				nativeTitle.borrow,
				action ? sel_registerName(action) : null,
				nativeKey.borrow,
			);
			menu.addItem(item);
			item.release();
		}

		NSMenu mainMenu = createMenu("");

		NSMenu applicationMenu = createMenu(applicationName);
		addItem(applicationMenu, "About " ~ applicationName, "orderFrontStandardAboutPanel:");
		applicationMenu.addItem(NSMenuItem.separatorItem());
		addItem(applicationMenu, "Hide " ~ applicationName, "hide:", "h");
		applicationMenu.addItem(NSMenuItem.separatorItem());
		addItem(applicationMenu, "Quit " ~ applicationName, "terminate:", "q");

		OSXString applicationTitle = OSXString(applicationName);
		OSXString emptyKey = OSXString("");
		NSMenuItem applicationItem = NSMenuItem.alloc.initWithTitle(
			applicationTitle.borrow,
			null,
			emptyKey.borrow,
		);
		applicationItem.setSubmenu(applicationMenu);
		mainMenu.addItem(applicationItem);

		NSMenu windowMenu = createMenu("Window");
		addItem(windowMenu, "Minimize", "performMiniaturize:", "m");
		addItem(windowMenu, "Zoom", "performZoom:");
		windowMenu.addItem(NSMenuItem.separatorItem());
		addItem(windowMenu, "Toggle Full Screen", "toggleFullScreen:");

		OSXString windowTitle = OSXString("Window");
		NSMenuItem windowItem = NSMenuItem.alloc.initWithTitle(windowTitle.borrow, null, emptyKey.borrow);
		windowItem.setSubmenu(windowMenu);
		mainMenu.addItem(windowItem);

		native.setMainMenu(mainMenu);
		native.setWindowsMenu(windowMenu);

		windowItem.release();
		windowMenu.release();
		applicationItem.release();
		applicationMenu.release();
		mainMenu.release();
	}

	protected override void disposeImpl() {
		if (applicationDelegate) {
			native.setDelegate(null);
			applicationDelegate.owner = null;
			applicationDelegate.release();
			applicationDelegate = null;
		}
		if (lifetimePool) {
			lifetimePool.drain();
			lifetimePool = null;
		}
	}

	package void requestQuit() {
		if (!m_display) {
			deactivate();
			return;
		}

		import std.array : array;

		foreach (window; m_display.activeWindows.byKey.array)
			window.onCloseRequest.emit();
	}

	private OSXDisplay m_display;
	override inout(OSXDisplay) display() inout @property {
		if (!m_display)
			(cast() this).m_display = new OSXDisplay(cast() this);
		return m_display;
	}

	private OSXTimer m_timer;
	override inout(OSXTimer) timer() inout @property {
		if (!m_timer)
			(cast() this).m_timer = new OSXTimer(cast() this);
		return m_timer;
	}

	private OSXSocketManager m_socketManager;
	override inout(OSXSocketManager) socketManager() inout @property {
		if (!m_socketManager)
			(cast() this).m_socketManager = new OSXSocketManager(cast() this);
		return m_socketManager;
	}

	private OSXSSLManager m_sslManager;
	override inout(OSXSSLManager) sslManager() inout @property {
		if (!m_sslManager)
			(cast() this).m_sslManager = new OSXSSLManager(cast() this);
		return m_sslManager;
	}

	private bool deactivated;
	override bool isActive() {
		if (deactivated)
			return false;
		if (m_display && m_display.isActive)
			return true;
		if (m_timer && m_timer.isActive)
			return true;
		if (m_socketManager && m_socketManager.isActive)
			return true;
		return false;
	}

	override void deactivate() {
		if (m_display)
			m_display.deactivate();
		if (m_timer)
			m_timer.deactivate();
		if (m_socketManager)
			m_socketManager.deactivate();
		deactivated = true;
	}

	private void dispatchPendingEvents() {
		NSEvent event = native.nextEventMatchingMask(
			NSEventMask.Any,
			NSDate.distantPast(),
			NSDefaultRunLoopMode,
			true,
		);
		while (event) {
			native.sendEvent(event);
			event = native.nextEventMatchingMask(
				NSEventMask.Any,
				NSDate.distantPast(),
				NSDefaultRunLoopMode,
				true,
			);
		}
	}

	override void processEvents(bool wait = true) {
		NSAutoreleasePool pool = NSAutoreleasePool.alloc.init;
		scope (exit) pool.drain();

		if (m_display)
			m_display.processEvents();

		dispatchPendingEvents();
		if (wait)
			NSRunLoop.currentRunLoop().runMode(
				NSDefaultRunLoopMode,
				NSDate.dateWithTimeIntervalSinceNow(0.01),
			);
		dispatchPendingEvents();

		native.updateWindows();
		if (m_display)
			m_display.processEvents();
		if (m_timer)
			m_timer.processEvents();
		if (m_socketManager)
			m_socketManager.processEvents();
	}
}

extern (Objective-C) class OSXApplicationDelegate : NSObject, NSApplicationDelegate {
	override static OSXApplicationDelegate alloc() @selector("alloc");
	override OSXApplicationDelegate init() @selector("init");

	OSXApplication owner;

	override NSApplicationTerminateReply applicationShouldTerminate(NSApplication sender)
			@selector("applicationShouldTerminate:") {
		if (owner)
			owner.requestQuit();
		return NSApplicationTerminateReply.Cancel;
	}

	override bool applicationShouldTerminateAfterLastWindowClosed(NSApplication sender)
			@selector("applicationShouldTerminateAfterLastWindowClosed:") => false;
}
