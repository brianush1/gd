module gd.bindings.xi2;
import gd.bindings.x11;
import gd.bindings.xfixes;
import gd.bindings.loader;
import gd.resource;
import core.stdc.config;
import core.stdc.stddef;

private static XI2Library m_XI2;
XI2Library XI2() @property { // @suppress(dscanner.confusing.function_attributes)
	if (m_XI2 is null) {
		m_XI2 = loadXI2;
		registerLibraryResource(m_XI2);
	}

	return m_XI2;
}

XI2Library loadXI2() {
	string[] libraries;

	version (Posix) {
		libraries = ["libXi.so.6", "libXi.so"];
	}
	else {
		static assert(0, "unsupported platform");
	}

	return loadSharedLibrary!(XI2Library, delegate(string name) {
		return "XI" ~ cast(char)(name[0] + 'A' - 'a') ~ name[1 .. $];
	})(libraries);
}

abstract class XI2Library : Resource {
extern (System) @nogc nothrow:
	// file '/usr/include/X11/extensions/XInput2.h'

	import core.stdc.config;

	struct XIAddMasterInfo {
		int type;
		char* name;
		int send_core;
		int enable;
	}

	struct XIRemoveMasterInfo {
		int type;
		int deviceid;
		int return_mode;
		int return_pointer;
		int return_keyboard;
	}

	struct XIAttachSlaveInfo {
		int type;
		int deviceid;
		int new_master;
	}

	struct XIDetachSlaveInfo {
		int type;
		int deviceid;
	}

	union XIAnyHierarchyChangeInfo {
		int type;
		XIAddMasterInfo add;
		XIRemoveMasterInfo remove;
		XIAttachSlaveInfo attach;
		XIDetachSlaveInfo detach;
	}

	struct XIModifierState {
		int base;
		int latched;
		int locked;
		int effective;
	}

	alias XIGroupState = XIModifierState;

	struct XIButtonState {
		int mask_len;
		ubyte* mask;
	}

	struct XIValuatorState {
		int mask_len;
		ubyte* mask;
		double* values;
	}

	struct XIEventMask {
		int deviceid;
		int mask_len;
		ubyte* mask;
	}

	struct XIAnyClassInfo {
		int type;
		int sourceid;
	}

	struct XIButtonClassInfo {
		int type;
		int sourceid;
		int num_buttons;
		X11.Atom* labels;
		XIButtonState state;
	}

	struct XIKeyClassInfo {
		int type;
		int sourceid;
		int num_keycodes;
		int* keycodes;
	}

	struct XIValuatorClassInfo {
		int type;
		int sourceid;
		int number;
		X11.Atom label;
		double min;
		double max;
		double value;
		int resolution;
		int mode;
	}

	struct XIScrollClassInfo {
		int type;
		int sourceid;
		int number;
		int scroll_type;
		double increment;
		int flags;
	}

	struct XITouchClassInfo {
		int type;
		int sourceid;
		int mode;
		int num_touches;
	}

	struct XIDeviceInfo {
		int deviceid;
		char* name;
		int use;
		int attachment;
		int enabled;
		int num_classes;
		XIAnyClassInfo** classes;
	}

	struct XIGrabModifiers {
		int modifiers;
		int status;
	}

	alias BarrierEventID = uint;

	struct XIBarrierReleasePointerInfo {
		int deviceid;
		XFixes.PointerBarrier barrier;
		BarrierEventID eventid;
	}

	struct XIEvent {
		int type;
		c_ulong serial;
		int send_event;
		X11.Display* display;
		int extension;
		int evtype;
		X11.Time time;
	}

	struct XIHierarchyInfo {
		int deviceid;
		int attachment;
		int use;
		int enabled;
		int flags;
	}

	struct XIHierarchyEvent {
		int type;
		c_ulong serial;
		int send_event;
		X11.Display* display;
		int extension;
		int evtype;
		X11.Time time;
		int flags;
		int num_info;
		XIHierarchyInfo* info;
	}

	struct XIDeviceChangedEvent {
		int type;
		c_ulong serial;
		int send_event;
		X11.Display* display;
		int extension;
		int evtype;
		X11.Time time;
		int deviceid;
		int sourceid;
		int reason;
		int num_classes;
		XIAnyClassInfo** classes;
	}

	struct XIDeviceEvent {
		int type;
		c_ulong serial;
		int send_event;
		X11.Display* display;
		int extension;
		int evtype;
		X11.Time time;
		int deviceid;
		int sourceid;
		int detail;
		X11.Window root;
		X11.Window event;
		X11.Window child;
		double root_x;
		double root_y;
		double event_x;
		double event_y;
		int flags;
		XIButtonState buttons;
		XIValuatorState valuators;
		XIModifierState mods;
		XIGroupState group;
	}

	struct XIRawEvent {
		int type;
		c_ulong serial;
		int send_event;
		X11.Display* display;
		int extension;
		int evtype;
		X11.Time time;
		int deviceid;
		int sourceid;
		int detail;
		int flags;
		XIValuatorState valuators;
		double* raw_values;
	}

	struct XIEnterEvent {
		int type;
		c_ulong serial;
		int send_event;
		X11.Display* display;
		int extension;
		int evtype;
		X11.Time time;
		int deviceid;
		int sourceid;
		int detail;
		X11.Window root;
		X11.Window event;
		X11.Window child;
		double root_x;
		double root_y;
		double event_x;
		double event_y;
		int mode;
		int focus;
		int same_screen;
		XIButtonState buttons;
		XIModifierState mods;
		XIGroupState group;
	}

	alias XILeaveEvent = XIEnterEvent;
	alias XIFocusInEvent = XIEnterEvent;
	alias XIFocusOutEvent = XIEnterEvent;

	struct XIPropertyEvent {
		int type;
		c_ulong serial;
		int send_event;
		X11.Display* display;
		int extension;
		int evtype;
		X11.Time time;
		int deviceid;
		X11.Atom property;
		int what;
	}

	struct XITouchOwnershipEvent {
		int type;
		c_ulong serial;
		int send_event;
		X11.Display* display;
		int extension;
		int evtype;
		X11.Time time;
		int deviceid;
		int sourceid;
		uint touchid;
		X11.Window root;
		X11.Window event;
		X11.Window child;
		int flags;
	}

	struct XIBarrierEvent {
		int type;
		c_ulong serial;
		int send_event;
		X11.Display* display;
		int extension;
		int evtype;
		X11.Time time;
		int deviceid;
		int sourceid;
		X11.Window event;
		X11.Window root;
		double root_x;
		double root_y;
		double dx;
		double dy;
		int dtime;
		int flags;
		XFixes.PointerBarrier barrier;
		BarrierEventID eventid;
	}

	int queryPointer(X11.Display* display, int deviceid, X11.Window win,
			X11.Window* root, X11.Window* child, double* root_x, double* root_y,
			double* win_x, double* win_y, XIButtonState* buttons,
			XIModifierState* mods, XIGroupState* group);

	int warpPointer(X11.Display* display, int deviceid, X11.Window src_win,
			X11.Window dst_win, double src_x, double src_y, uint src_width,
			uint src_height, double dst_x, double dst_y);

	int defineCursor(X11.Display* display, int deviceid, X11.Window win, X11.Cursor cursor);

	int undefineCursor(X11.Display* display, int deviceid, X11.Window win);

	int changeHierarchy(X11.Display* display, XIAnyHierarchyChangeInfo* changes, int num_changes);

	int setClientPointer(X11.Display* dpy, X11.Window win, int deviceid);

	int getClientPointer(X11.Display* dpy, X11.Window win, int* deviceid);

	int selectEvents(X11.Display* dpy, X11.Window win, XIEventMask* masks, int num_masks);

	XIEventMask* getSelectedEvents(X11.Display* dpy, X11.Window win, int* num_masks_return);

	int queryVersion(X11.Display* dpy, int* major_version_inout, int* minor_version_inout);

	XIDeviceInfo* queryDevice(X11.Display* dpy, int deviceid, int* ndevices_return);

	int setFocus(X11.Display* dpy, int deviceid, X11.Window focus, X11.Time time);

	int getFocus(X11.Display* dpy, int deviceid, X11.Window* focus_return);

	int grabDevice(X11.Display* dpy, int deviceid, X11.Window grab_window,
			X11.Time time, X11.Cursor cursor, int grab_mode,
			int paired_device_mode, int owner_events, XIEventMask* mask);

	int ungrabDevice(X11.Display* dpy, int deviceid, X11.Time time);

	int allowEvents(X11.Display* display, int deviceid, int event_mode, X11.Time time);

	int allowTouchEvents(X11.Display* display, int deviceid, uint touchid,
			X11.Window grab_window, int event_mode);

	int grabButton(X11.Display* display, int deviceid, int button, X11.Window grab_window,
			X11.Cursor cursor, int grab_mode, int paired_device_mode, int owner_events,
			XIEventMask* mask, int num_modifiers, XIGrabModifiers* modifiers_inout);

	int grabKeycode(X11.Display* display, int deviceid, int keycode, X11.Window grab_window,
			int grab_mode, int paired_device_mode, int owner_events,
			XIEventMask* mask, int num_modifiers, XIGrabModifiers* modifiers_inout);

	int grabEnter(X11.Display* display, int deviceid, X11.Window grab_window, X11.Cursor cursor,
			int grab_mode, int paired_device_mode, int owner_events,
			XIEventMask* mask, int num_modifiers, XIGrabModifiers* modifiers_inout);

	int grabFocusIn(X11.Display* display, int deviceid, X11.Window grab_window, int grab_mode,
			int paired_device_mode, int owner_events, XIEventMask* mask,
			int num_modifiers, XIGrabModifiers* modifiers_inout);

	int grabTouchBegin(X11.Display* display, int deviceid, X11.Window grab_window,
			int owner_events, XIEventMask* mask, int num_modifiers,
			XIGrabModifiers* modifiers_inout);

	int ungrabButton(X11.Display* display, int deviceid, int button,
			X11.Window grab_window, int num_modifiers, XIGrabModifiers* modifiers);

	int ungrabKeycode(X11.Display* display, int deviceid, int keycode,
			X11.Window grab_window, int num_modifiers, XIGrabModifiers* modifiers);

	int ungrabEnter(X11.Display* display, int deviceid, X11.Window grab_window,
			int num_modifiers, XIGrabModifiers* modifiers);

	int ungrabFocusIn(X11.Display* display, int deviceid, X11.Window grab_window,
			int num_modifiers, XIGrabModifiers* modifiers);

	int ungrabTouchBegin(X11.Display* display, int deviceid,
			X11.Window grab_window, int num_modifiers, XIGrabModifiers* modifiers);

	X11.Atom* listProperties(X11.Display* display, int deviceid, int* num_props_return);

	void changeProperty(X11.Display* display, int deviceid, X11.Atom property,
			X11.Atom type, int format, int mode, ubyte* data, int num_items);

	void deleteProperty(X11.Display* display, int deviceid, X11.Atom property);

	int getProperty(X11.Display* display, int deviceid, X11.Atom property,
			c_long offset, c_long length, int delete_property, X11.Atom type, X11.Atom* type_return,
			int* format_return, c_ulong* num_items_return,
			c_ulong* bytes_after_return, ubyte** data);

	void barrierReleasePointers(X11.Display* display,
			XIBarrierReleasePointerInfo* barriers, int num_barriers);

	void barrierReleasePointer(X11.Display* display, int deviceid,
			XFixes.PointerBarrier barrier, BarrierEventID eventid);

	void freeDeviceInfo(XIDeviceInfo* info);

	// file '/usr/include/X11/extensions/XI2.h'

	enum XInput_2_0 = 7;

	enum XI_2_Major = 2;
	enum XI_2_Minor = 4;

	enum XIPropertyDeleted = 0;
	enum XIPropertyCreated = 1;
	enum XIPropertyModified = 2;

	enum XIPropModeReplace = 0;
	enum XIPropModePrepend = 1;
	enum XIPropModeAppend = 2;

	enum XIAnyPropertyType = 0L;

	enum XINotifyNormal = 0;
	enum XINotifyGrab = 1;
	enum XINotifyUngrab = 2;
	enum XINotifyWhileGrabbed = 3;
	enum XINotifyPassiveGrab = 4;
	enum XINotifyPassiveUngrab = 5;

	enum XINotifyAncestor = 0;
	enum XINotifyVirtual = 1;
	enum XINotifyInferior = 2;
	enum XINotifyNonlinear = 3;
	enum XINotifyNonlinearVirtual = 4;
	enum XINotifyPointer = 5;
	enum XINotifyPointerRoot = 6;
	enum XINotifyDetailNone = 7;

	enum XIGrabModeSync = 0;
	enum XIGrabModeAsync = 1;
	enum XIGrabModeTouch = 2;

	enum XIGrabSuccess = 0;
	enum XIAlreadyGrabbed = 1;
	enum XIGrabInvalidTime = 2;
	enum XIGrabNotViewable = 3;
	enum XIGrabFrozen = 4;

	enum XIOwnerEvents = X11.True;
	enum XINoOwnerEvents = X11.False;

	enum XIGrabtypeButton = 0;
	enum XIGrabtypeKeycode = 1;
	enum XIGrabtypeEnter = 2;
	enum XIGrabtypeFocusIn = 3;
	enum XIGrabtypeTouchBegin = 4;
	enum XIGrabtypeGesturePinchBegin = 5;
	enum XIGrabtypeGestureSwipeBegin = 6;

	enum XIAnyModifier = 1U << 31;
	enum XIAnyButton = 0;
	enum XIAnyKeycode = 0;

	enum XIAsyncDevice = 0;
	enum XISyncDevice = 1;
	enum XIReplayDevice = 2;
	enum XIAsyncPairedDevice = 3;
	enum XIAsyncPair = 4;
	enum XISyncPair = 5;
	enum XIAcceptTouch = 6;
	enum XIRejectTouch = 7;

	enum XISlaveSwitch = 1;
	enum XIDeviceChange = 2;

	enum XIMasterAdded = 1 << 0;
	enum XIMasterRemoved = 1 << 1;
	enum XISlaveAdded = 1 << 2;
	enum XISlaveRemoved = 1 << 3;
	enum XISlaveAttached = 1 << 4;
	enum XISlaveDetached = 1 << 5;
	enum XIDeviceEnabled = 1 << 6;
	enum XIDeviceDisabled = 1 << 7;

	enum XIAddMaster = 1;
	enum XIRemoveMaster = 2;
	enum XIAttachSlave = 3;
	enum XIDetachSlave = 4;

	enum XIAttachToMaster = 1;
	enum XIFloating = 2;

	enum XIModeRelative = 0;
	enum XIModeAbsolute = 1;

	enum XIMasterPointer = 1;
	enum XIMasterKeyboard = 2;
	enum XISlavePointer = 3;
	enum XISlaveKeyboard = 4;
	enum XIFloatingSlave = 5;

	enum XIKeyClass = 0;
	enum XIButtonClass = 1;
	enum XIValuatorClass = 2;
	enum XIScrollClass = 3;
	enum XITouchClass = 8;
	enum XIGestureClass = 9;

	enum XIScrollTypeVertical = 1;
	enum XIScrollTypeHorizontal = 2;

	enum XIScrollFlagNoEmulation = 1 << 0;
	enum XIScrollFlagPreferred = 1 << 1;

	enum XIKeyRepeat = 1 << 16;

	enum XIPointerEmulated = 1 << 16;

	enum XITouchPendingEnd = 1 << 16;
	enum XITouchEmulatingPointer = 1 << 17;

	enum XIBarrierPointerReleased = 1 << 0;
	enum XIBarrierDeviceIsGrabbed = 1 << 1;

	enum XIGesturePinchEventCancelled = 1 << 0;

	enum XIGestureSwipeEventCancelled = 1 << 0;

	enum XIDirectTouch = 1;
	enum XIDependentTouch = 2;

	static extern (D) auto setMask(T0, T1)(auto ref T0 ptr, auto ref T1 event) {
		return (cast(ubyte*) ptr)[event >> 3] |= (1 << (event & 7));
	}

	static extern (D) auto maskIsSet(T0, T1)(auto ref T0 ptr, auto ref T1 event) {
		return (cast(ubyte*) ptr)[event >> 3] & (1 << (event & 7));
	}

	static extern (D) auto maskLen(T)(auto ref T event) {
		return (event >> 3) + 1;
	}

	enum XIAllDevices = 0;
	enum XIAllMasterDevices = 1;

	enum XI_DeviceChanged = 1;
	enum XI_KeyPress = 2;
	enum XI_KeyRelease = 3;
	enum XI_ButtonPress = 4;
	enum XI_ButtonRelease = 5;
	enum XI_Motion = 6;
	enum XI_Enter = 7;
	enum XI_Leave = 8;
	enum XI_FocusIn = 9;
	enum XI_FocusOut = 10;
	enum XI_HierarchyChanged = 11;
	enum XI_PropertyEvent = 12;
	enum XI_RawKeyPress = 13;
	enum XI_RawKeyRelease = 14;
	enum XI_RawButtonPress = 15;
	enum XI_RawButtonRelease = 16;
	enum XI_RawMotion = 17;
	enum XI_TouchBegin = 18;
	enum XI_TouchUpdate = 19;
	enum XI_TouchEnd = 20;
	enum XI_TouchOwnership = 21;
	enum XI_RawTouchBegin = 22;
	enum XI_RawTouchUpdate = 23;
	enum XI_RawTouchEnd = 24;
	enum XI_BarrierHit = 25;
	enum XI_BarrierLeave = 26;
	enum XI_GesturePinchBegin = 27;
	enum XI_GesturePinchUpdate = 28;
	enum XI_GesturePinchEnd = 29;
	enum XI_GestureSwipeBegin = 30;
	enum XI_GestureSwipeUpdate = 31;
	enum XI_GestureSwipeEnd = 32;
	enum XI_LASTEVENT = XI_GestureSwipeEnd;

	enum XI_DeviceChangedMask = 1 << XI_DeviceChanged;
	enum XI_KeyPressMask = 1 << XI_KeyPress;
	enum XI_KeyReleaseMask = 1 << XI_KeyRelease;
	enum XI_ButtonPressMask = 1 << XI_ButtonPress;
	enum XI_ButtonReleaseMask = 1 << XI_ButtonRelease;
	enum XI_MotionMask = 1 << XI_Motion;
	enum XI_EnterMask = 1 << XI_Enter;
	enum XI_LeaveMask = 1 << XI_Leave;
	enum XI_FocusInMask = 1 << XI_FocusIn;
	enum XI_FocusOutMask = 1 << XI_FocusOut;
	enum XI_HierarchyChangedMask = 1 << XI_HierarchyChanged;
	enum XI_PropertyEventMask = 1 << XI_PropertyEvent;
	enum XI_RawKeyPressMask = 1 << XI_RawKeyPress;
	enum XI_RawKeyReleaseMask = 1 << XI_RawKeyRelease;
	enum XI_RawButtonPressMask = 1 << XI_RawButtonPress;
	enum XI_RawButtonReleaseMask = 1 << XI_RawButtonRelease;
	enum XI_RawMotionMask = 1 << XI_RawMotion;
	enum XI_TouchBeginMask = 1 << XI_TouchBegin;
	enum XI_TouchEndMask = 1 << XI_TouchEnd;
	enum XI_TouchOwnershipChangedMask = 1 << XI_TouchOwnership;
	enum XI_TouchUpdateMask = 1 << XI_TouchUpdate;
	enum XI_RawTouchBeginMask = 1 << XI_RawTouchBegin;
	enum XI_RawTouchEndMask = 1 << XI_RawTouchEnd;
	enum XI_RawTouchUpdateMask = 1 << XI_RawTouchUpdate;
	enum XI_BarrierHitMask = 1 << XI_BarrierHit;
	enum XI_BarrierLeaveMask = 1 << XI_BarrierLeave;
}
