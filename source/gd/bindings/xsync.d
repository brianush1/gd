module gd.bindings.xsync;
import gd.bindings.x11;
import gd.bindings.loader;
import gd.resource;
import core.stdc.config;
import core.stdc.stddef;

private static XSyncLibrary m_XSync;
XSyncLibrary XSync() @property { // @suppress(dscanner.confusing.function_attributes)
	if (m_XSync is null) {
		m_XSync = loadXSync;
		registerLibraryResource(m_XSync);
	}

	return m_XSync;
}

XSyncLibrary loadXSync() {
	string[] libraries;

	version (Posix) {
		libraries = ["libXext.so.6", "libXext.so"];
	}
	else {
		static assert(0, "unsupported platform");
	}

	return loadSharedLibrary!(XSyncLibrary, delegate(string name) {
		return "XSync" ~ cast(char)(name[0] + 'A' - 'a') ~ name[1 .. $];
	})(libraries);
}

abstract class XSyncLibrary : Resource {
extern (System) @nogc nothrow:
	// file '/usr/include/X11/extensions/syncconst.h'

	import core.stdc.config;

	enum SYNC_NAME = "SYNC";

	enum SYNC_MAJOR_VERSION = 3;
	enum SYNC_MINOR_VERSION = 1;

	enum XSyncCounterNotify = 0;
	enum XSyncAlarmNotify = 1;
	enum XSyncAlarmNotifyMask = 1L << XSyncAlarmNotify;

	enum XSyncNumberEvents = 2L;

	enum XSyncBadCounter = 0L;
	enum XSyncBadAlarm = 1L;
	enum XSyncBadFence = 2L;
	enum XSyncNumberErrors = XSyncBadFence + 1;

	enum XSyncCACounter = 1L << 0;
	enum XSyncCAValueType = 1L << 1;
	enum XSyncCAValue = 1L << 2;
	enum XSyncCATestType = 1L << 3;
	enum XSyncCADelta = 1L << 4;
	enum XSyncCAEvents = 1L << 5;

	static extern (D) auto _XSyncValueGreaterThan(T0, T1)(auto ref T0 a, auto ref T1 b) {
		return a.hi > b.hi || (a.hi == b.hi && a.lo > b.lo);
	}

	static extern (D) auto _XSyncValueLessThan(T0, T1)(auto ref T0 a, auto ref T1 b) {
		return a.hi < b.hi || (a.hi == b.hi && a.lo < b.lo);
	}

	static extern (D) auto _XSyncValueGreaterOrEqual(T0, T1)(auto ref T0 a, auto ref T1 b) {
		return a.hi > b.hi || (a.hi == b.hi && a.lo >= b.lo);
	}

	static extern (D) auto _XSyncValueLessOrEqual(T0, T1)(auto ref T0 a, auto ref T1 b) {
		return a.hi < b.hi || (a.hi == b.hi && a.lo <= b.lo);
	}

	static extern (D) auto _XSyncValueEqual(T0, T1)(auto ref T0 a, auto ref T1 b) {
		return a.lo == b.lo && a.hi == b.hi;
	}

	static extern (D) int _XSyncValueIsNegative(T)(auto ref T v) {
		return (v.hi & 0x80000000) ? 1 : 0;
	}

	static extern (D) auto _XSyncValueIsZero(T)(auto ref T a) {
		return a.lo == 0 && a.hi == 0;
	}

	static extern (D) int _XSyncValueIsPositive(T)(auto ref T v) {
		return (v.hi & 0x80000000) ? 0 : 1;
	}

	static extern (D) auto _XSyncValueLow32(T)(auto ref T v) {
		return v.lo;
	}

	static extern (D) auto _XSyncValueHigh32(T)(auto ref T v) {
		return v.hi;
	}

	enum XSyncValueType {
		XSyncAbsolute = 0,
		XSyncRelative = 1
	}

	enum XSyncTestType {
		XSyncPositiveTransition = 0,
		XSyncNegativeTransition = 1,
		XSyncPositiveComparison = 2,
		XSyncNegativeComparison = 3
	}

	enum XSyncAlarmState {
		XSyncAlarmActive = 0,
		XSyncAlarmInactive = 1,
		XSyncAlarmDestroyed = 2
	}

	alias XSyncCounter = c_ulong;
	alias XSyncAlarm = c_ulong;
	alias XSyncFence = c_ulong;

	struct XSyncValue {
		int hi;
		uint lo;
	}
	// file '/usr/include/X11/extensions/sync.h'

	import core.stdc.config;

	void intToValue(XSyncValue*, int);

	void intsToValue(XSyncValue*, uint, int);

	int valueGreaterThan(XSyncValue, XSyncValue);

	int valueLessThan(XSyncValue, XSyncValue);

	int valueGreaterOrEqual(XSyncValue, XSyncValue);

	int valueLessOrEqual(XSyncValue, XSyncValue);

	int valueEqual(XSyncValue, XSyncValue);

	int valueIsNegative(XSyncValue);

	int valueIsZero(XSyncValue);

	int valueIsPositive(XSyncValue);

	uint valueLow32(XSyncValue);

	int valueHigh32(XSyncValue);

	void valueAdd(XSyncValue*, XSyncValue, XSyncValue, int*);

	void valueSubtract(XSyncValue*, XSyncValue, XSyncValue, int*);

	void maxValue(XSyncValue*);

	void minValue(XSyncValue*);

	struct XSyncSystemCounter {
		char* name;
		XSyncCounter counter;
		XSyncValue resolution;
	}

	struct XSyncTrigger {
		XSyncCounter counter;
		XSyncValueType value_type;
		XSyncValue wait_value;
		XSyncTestType test_type;
	}

	struct XSyncWaitCondition {
		XSyncTrigger trigger;
		XSyncValue event_threshold;
	}

	struct XSyncAlarmAttributes {
		XSyncTrigger trigger;
		XSyncValue delta;
		int events;
		XSyncAlarmState state;
	}

	struct XSyncCounterNotifyEvent {
		int type;
		c_ulong serial;
		int send_event;
		X11.Display* display;
		XSyncCounter counter;
		XSyncValue wait_value;
		XSyncValue counter_value;
		X11.Time time;
		int count;
		int destroyed;
	}

	struct XSyncAlarmNotifyEvent {
		int type;
		c_ulong serial;
		int send_event;
		X11.Display* display;
		XSyncAlarm alarm;
		XSyncValue counter_value;
		XSyncValue alarm_value;
		X11.Time time;
		XSyncAlarmState state;
	}

	struct XSyncAlarmError {
		int type;
		X11.Display* display;
		XSyncAlarm alarm;
		c_ulong serial;
		ubyte error_code;
		ubyte request_code;
		ubyte minor_code;
	}

	struct XSyncCounterError {
		int type;
		X11.Display* display;
		XSyncCounter counter;
		c_ulong serial;
		ubyte error_code;
		ubyte request_code;
		ubyte minor_code;
	}

	int queryExtension(X11.Display*, int*, int*);

	int initialize(X11.Display*, int*, int*);

	XSyncSystemCounter* listSystemCounters(X11.Display*, int*);

	void freeSystemCounterList(XSyncSystemCounter*);

	XSyncCounter createCounter(X11.Display*, XSyncValue);

	int setCounter(X11.Display*, XSyncCounter, XSyncValue);

	int changeCounter(X11.Display*, XSyncCounter, XSyncValue);

	int destroyCounter(X11.Display*, XSyncCounter);

	int queryCounter(X11.Display*, XSyncCounter, XSyncValue*);

	int await(X11.Display*, XSyncWaitCondition*, int);

	XSyncAlarm createAlarm(X11.Display*, c_ulong, XSyncAlarmAttributes*);

	int destroyAlarm(X11.Display*, XSyncAlarm);

	int queryAlarm(X11.Display*, XSyncAlarm, XSyncAlarmAttributes*);

	int changeAlarm(X11.Display*, XSyncAlarm, c_ulong, XSyncAlarmAttributes*);

	int setPriority(X11.Display*, X11.XID, int);

	int getPriority(X11.Display*, X11.XID, int*);

	XSyncFence createFence(X11.Display*, X11.Drawable, int);

	int triggerFence(X11.Display*, XSyncFence);

	int resetFence(X11.Display*, XSyncFence);

	int destroyFence(X11.Display*, XSyncFence);

	int queryFence(X11.Display*, XSyncFence, int*);

	int awaitFence(X11.Display*, const(XSyncFence)*, int);
}
