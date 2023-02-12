module gd.system.x11.device;
import gd.system.x11.display;
import gd.system.x11.window;
import gd.resource;
import gd.signal;
import gd.math;

version (gd_X11Impl):

import gd.bindings.x11;
import gd.bindings.xfixes;
import gd.bindings.xi2;

package:

enum DeviceUse {
	keyboard,
	pointer,
}

class X11DeviceManager : Resource {
private:
	X11Display m_display;
	public inout(X11Display) display() inout @property { return m_display; }

	int xi2Opcode;
	bool xi2Supported;

	X11Device[int] devices;

	package this(X11Display display) {
		scope (failure) dispose();

		m_display = display;

		addDependency(display);

		int firstEventReturn, firstErrorReturn;
		if (X11.queryExtension(display.native, "XInputExtension",
				&xi2Opcode, &firstEventReturn, &firstErrorReturn)) {
			xi2Supported = true;

			int screen = X11.defaultScreen(display.native);
			X11.Window root = X11.rootWindow(display.native, screen);

			enum maskLen = typeof(XI2).maskLen(typeof(XI2).XI_LASTEVENT);
			XI2.XIEventMask mask = {
				deviceid: XI2.XIAllDevices,
				mask_len: maskLen,
				mask: new ubyte[maskLen].ptr,
			};
			XI2.setMask(mask.mask, XI2.XI_HierarchyChanged);
			XI2.setMask(mask.mask, XI2.XI_DeviceChanged);
			XI2.selectEvents(display.native, root, &mask, 1);
			X11.sync(display.native, X11.False);

			addDevices();
		}
		else {
			xi2Supported = false;
		}
	}

	protected override void disposeImpl() {}

	void addDevices() {
		int deviceCount;

		XI2.XIDeviceInfo* di = XI2.queryDevice(display.native, XI2.XIAllMasterDevices, &deviceCount);
		foreach (i; 0 .. deviceCount) {
			import std.string : fromStringz;

			XI2.XIDeviceInfo* deviceInfo = &di[i];

			int deviceId = deviceInfo.deviceid;

			if (deviceId in devices) {
				continue;
			}

			X11Device device = new X11Device(this);
			devices[deviceId] = device;

			device.m_id = deviceId;
			device.m_name = deviceInfo.name.fromStringz.idup;

			if (deviceInfo.use == XI2.XIMasterPointer) {
				device.m_role = DeviceRole.pointer;
			}
			else if (deviceInfo.use == XI2.XIMasterKeyboard) {
				device.m_role = DeviceRole.keyboard;
			}

			XI2.XIAnyClassInfo*[] classInfos = deviceInfo.classes[0 .. deviceInfo.num_classes];
			device.update(classInfos);

			onDeviceAdd.emit(device);
		}

		XI2.freeDeviceInfo(di);
	}

	void processXI2Event(X11.XGenericEventCookie* cookie) {
		import std.stdio : writefln;

		switch (cookie.evtype) {
		case XI2.XI_HierarchyChanged:
			XI2.XIHierarchyEvent* ev = cast(XI2.XIHierarchyEvent*) cookie.data;

			if (ev.flags & XI2.XIMasterRemoved) {
				foreach (info; ev.info[0 .. ev.num_info]) {
					if ((info.flags & XI2.XIMasterRemoved) && info.deviceid in devices) {
						onDeviceRemove.emit(devices[info.deviceid]);

						devices[info.deviceid].dispose();
						devices.remove(info.deviceid);
					}
				}
			}

			if (ev.flags & XI2.XIMasterAdded) {
				addDevices();
			}

			break;
		case XI2.XI_DeviceChanged:
			XI2.XIDeviceChangedEvent* ev = cast(XI2.XIDeviceChangedEvent*) cookie.data;

			// if (ev.reason == XI2.XISlaveSwitch) {
				// writefln!"Slave Switch %d %d"(ev.deviceid, ev.sourceid);

			XI2.XIAnyClassInfo*[] classInfos = ev.classes[0 .. ev.num_classes];

			if (ev.deviceid in devices) {
				devices[ev.deviceid].update(classInfos);
			}

			// }
			// else if (ev.reason == XI2.XIDeviceChange) {
			// 	// do nothing right now
			// }

			break;
		case XI2.XI_Enter:
		case XI2.XI_Leave:
			XI2.XIEnterEvent* ev = cast(XI2.XIEnterEvent*) cookie.data;

			if (ev.deviceid in devices) {
				int deviceCount;

				// between the time when we start querying the device and receive a response,
				// the master device can switch to a different slave

				// so we query the slave directly and check if it's attached to the master,
				// and if so we update the master

				XI2.XIDeviceInfo* deviceInfo = XI2.queryDevice(display.native, ev.sourceid, &deviceCount);

				if (deviceInfo.attachment == ev.deviceid) {
					devices[ev.deviceid].update(deviceInfo.classes[0 .. deviceInfo.num_classes]);
				}

				XI2.freeDeviceInfo(deviceInfo);
			}

			if (X11Window* window = ev.event in display.windowMap) window.processXI2Event(ev);

			break;
		case XI2.XI_TouchBegin:
		case XI2.XI_TouchUpdate:
		case XI2.XI_TouchEnd:
		case XI2.XI_ButtonPress:
		case XI2.XI_ButtonRelease:
		case XI2.XI_KeyPress:
		case XI2.XI_KeyRelease:
		case XI2.XI_Motion:
			XI2.XIDeviceEvent* ev = cast(XI2.XIDeviceEvent*) cookie.data;

			if (cookie.evtype == XI2.XI_Motion && ev.deviceid in devices) {
				double[int] valuators;

				int valuatorIndex = 0;
				foreach (i; 0 .. ev.valuators.mask_len) {
					ubyte mask = ev.valuators.mask[i];
					foreach (j; 0 .. 8) {
						if ((mask & cast(ubyte)(1 << j)) != 0) {
							valuators[8 * i + j] = ev.valuators.values[valuatorIndex];
							valuatorIndex += 1;
						}
					}
				}

				X11Device master = devices[ev.deviceid];
				foreach (valuator; master.valuators) {
					valuator.m_lastValue = valuator.m_value;

					if (valuator.number in valuators) {
						valuator.m_value = valuators[valuator.number];
					}
				}
			}

			if (X11Window* window = ev.event in display.windowMap) window.processXI2Event(ev);

			break;
		default:
			break;
		}
	}

public:

	Signal!X11Device onDeviceAdd;
	Signal!X11Device onDeviceRemove;

	Slot handleDevice(Handler!X11Device handler) {
		Slot result = onDeviceAdd.connect(handler);

		foreach (device; devices.byValue) {
			handler(device);
		}

		return result;
	}

	bool processEvent(ref X11.XEvent ev) {
		if (!xi2Supported) {
			return false;
		}

		X11.XGenericEventCookie* cookie = &ev.xcookie;

		if (ev.type == X11.GenericEvent
				&& cookie.extension == xi2Opcode
				&& X11.getEventData(display.native, cookie)) {
			scope (exit) {
				X11.freeEventData(display.native, cookie);
			}

			processXI2Event(cookie);

			return true;
		}
		else {
			return false;
		}
	}

}

enum ValuatorRole {
	unknown,
	scrollHorizontal,
	scrollVertical,
	pressure,
}

final class Valuator {

	private {
		string m_label;
		int m_number;
		double m_lastValue;
		double m_value;
		double m_min;
		double m_max;

		ValuatorRole m_role;
		double m_increment;

		this() {}
	}

	string label() const @property { return m_label; }
	int number() const @property { return m_number; }

	/++ Returns the previous value of the valuator. Only valid in XI_Motion events +/
	double lastValue() const @property { return m_lastValue; }

	double value() const @property { return m_value; }
	double min() const @property { return m_min; }
	double max() const @property { return m_max; }

	ValuatorRole role() const @property { return m_role; }
	double increment() const @property { return m_increment; }

}

enum DeviceRole {
	pointer,
	keyboard,
}

enum DeviceMode {
	relative,
	absolute,
}

class X11Device : Resource {

	private int m_id;
	int id() const @property { return m_id; }

	private DeviceRole m_role;
	DeviceRole role() const @property { return m_role; }

	private DeviceMode m_mode;
	DeviceMode mode() const @property { return m_mode; }

	private string m_name;
	string name() const @property { return m_name; }

	private X11DeviceManager m_manager;
	inout(X11DeviceManager) manager() inout @property { return m_manager; }

	inout(X11Display) display() inout @property { return manager.display; }

	this(X11DeviceManager manager) {
		scope (failure) dispose();

		m_manager = manager;
		addDependency(manager);
	}

	protected override void disposeImpl() {}

	Signal!() onValuatorsChange;

	private Valuator[] m_valuators;
	inout(Valuator)[] valuators() inout @property {
		inout(Valuator)[] result;
		result ~= m_valuators;
		return result;
	}

	inout(Valuator) getValuatorByRole(ValuatorRole role) inout {
		foreach (valuator; valuators) {
			if (valuator.role == role) {
				return valuator;
			}
		}

		return null;
	}

	inout(Valuator) getValuatorByLabel(string label) inout {
		foreach (valuator; valuators) {
			if (valuator.label == label) {
				return valuator;
			}
		}

		return null;
	}

	inout(Valuator) getValuatorByNumber(int number) inout {
		foreach (valuator; valuators) {
			if (valuator.number == number) {
				return valuator;
			}
		}

		return null;
	}

	private void update(XI2.XIAnyClassInfo*[] classInfos) {
		m_valuators = [];

		foreach (classInfo; classInfos) {
			if (classInfo.type == XI2.XIValuatorClass) {
				import std.string : fromStringz;

				XI2.XIValuatorClassInfo* valuatorInfo = cast(XI2.XIValuatorClassInfo*) classInfo;

				if (valuatorInfo.mode == XI2.XIModeRelative) {
					m_mode = DeviceMode.relative;
				}
				else if (valuatorInfo.mode == XI2.XIModeAbsolute) {
					m_mode = DeviceMode.absolute;
				}

				Valuator valuator = new Valuator();
				valuator.m_label = X11.getAtomName(display.native, valuatorInfo.label).fromStringz.idup;
				valuator.m_number = valuatorInfo.number;
				valuator.m_lastValue = valuator.m_value = valuatorInfo.value;
				valuator.m_min = valuatorInfo.min;
				valuator.m_max = valuatorInfo.max;

				if (valuator.label == "Abs Pressure") {
					valuator.m_role = ValuatorRole.pressure;
				}

				m_valuators ~= valuator;
			}
		}

		foreach (classInfo; classInfos) {
			if (classInfo.type == XI2.XIScrollClass) {
				XI2.XIScrollClassInfo* scroll = cast(XI2.XIScrollClassInfo*) classInfo;

				Valuator valuator = getValuatorByNumber(scroll.number);
				valuator.m_increment = scroll.increment;

				if (scroll.scroll_type == XI2.XIScrollTypeHorizontal) {
					valuator.m_role = ValuatorRole.scrollHorizontal;
				}

				if (scroll.scroll_type == XI2.XIScrollTypeVertical) {
					valuator.m_role = ValuatorRole.scrollVertical;
				}
			}
		}

		onValuatorsChange.emit();
	}

}
