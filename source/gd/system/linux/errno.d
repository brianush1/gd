module gd.system.linux.errno;

version (gd_Linux):

import core.stdc.errno;

string errnoToMacroName(int err) {
	enum string[] members = {
		string[] result;
		bool[int] values;
		static foreach (string name; __traits(allMembers, core.stdc.errno)) {{
			alias value = __traits(getMember, core.stdc.errno, name);
			static if (name[0] == 'E' && is(typeof(value) == int)) {
				if (value !in values) {
					values[value] = true;
					result ~= name;
				}
			}
		}}
		return result;
	}();

	switch (err) {
		static foreach (string name; members) {
			case __traits(getMember, core.stdc.errno, name):
				return name;
		}
		default:
			return "<unrecognized error>";
	}
}
