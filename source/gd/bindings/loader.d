module gd.bindings.loader;
import gd.resource;

struct BindingName {
	string name;
}

LibraryType loadSharedLibrary(LibraryType, string delegate(string) toLibraryName)(string[] libraries)
		if (is(LibraryType : Resource)) {
	enum Members = {
		string[] members = [__traits(allMembers, LibraryType)];
		for (size_t i = members.length - 1; i >= 0; i--) {
			// WARNING: this depends on the ordering of allMembers
			if (members[i] == "__ctor") {
				return members[0 .. i];
			}
		}

		assert(0);
	}();

	final class ResultType : LibraryType {
		protected override void disposeImpl() {
			timesOpened -= 1;
			if (timesOpened > 0) {
				return;
			}

			version (Posix) {
				import core.sys.posix.dlfcn : dlclose;

				foreach (dl; dls) {
					dlclose(dl);
				}

				dls = null;
			}
			else version (Windows) {
				import core.sys.windows.winbase : FreeLibrary;

				foreach (dl; dls) {
					FreeLibrary(dl);
				}

				dls = null;
			}
			else {
				static assert(0);
			}
		}

		private int timesOpened;
		private void*[] dls;

		private enum code = {
			char[] result = new char[(Members.length + 1) * 1024];

			size_t index = 0;
			void write(string str) {
				result[index .. (index += str.length)] = str[];
			}

			write("extern (System) @nogc nothrow:

			version (Posix) {
				import core.sys.posix.dlfcn : dlerror, dlsym;
			}
			else version (Windows) {
				import core.sys.windows.winbase : GetProcAddress;
			}
			else {
				static assert(0, \"unsupported platform\");
			}

			import std.string : toStringz;

			");

			static foreach (member; Members) {{
				static if (
					is(typeof(__traits(getMember, LibraryType, member)) == function)
				) {
					write("static if (is(typeof(LibraryType.");
					write(member);
					write(") P");
					write(member);
					write(" == function) && is(typeof(LibraryType.");
					write(member);
					write(") R");
					write(member);
					write(" == return)) {
						private R");
					write(member);
					write(" function(P");
					write(member);
					write(") nothrow _impl");
					write(member);
					write(";
					override R");
					write(member);
					write(" ");
					write(member);
					write("(P");
					write(member);
					write(" args) {
						alias fun = _impl");
					write(member);
					write(";
						assert(dls, \"library closed\");
						if (fun is null) {
							alias bindingNameTuple = __traits(getAttributes, LibraryType.");
				write(member);
				write(");
							static if (bindingNameTuple.length > 0) {
								enum string libraryName = bindingNameTuple[0].name;
							}
							else {
								enum string libraryName = toLibraryName(\"");
				write(member);
				write("\");
							}

							version (Posix) {
								foreach (dl; dls) {
									dlerror();

									void* sym = dlsym(dl, libraryName);
									if (dlerror()) {
										continue;
									}

									*cast(void**)&fun = sym;
								}
							}
							else version (Windows) {
								foreach (dl; dls) {
									void* sym = GetProcAddress(dl, libraryName);
									if (!sym) {
										continue;
									}

									*cast(void**)&fun = sym;
								}
							}
							else {
								static assert(0);
							}
						}

						assert(fun !is null, \"error when loading member ");
					write(member);
					write("\");
						return fun(args);
					}
					}");
				}
			}}

			return result[0 .. index];
		}();

		mixin(code);
	}

	static ResultType result;

	if (result !is null) {
		result.timesOpened += 1;
		return result;
	}

	result = new ResultType;
	result.timesOpened = 1;

	version (Posix) {
		import core.sys.posix.dlfcn : dlopen, RTLD_NOW;
		import std.string : toStringz;

		foreach (library; libraries) {
			void* dl = dlopen(library.toStringz, RTLD_NOW);
			if (dl) {
				result.dls ~= dl;
			}
		}
	}
	else version (Windows) {
		import core.sys.windows.winbase : LoadLibraryW;
		import std.conv : to;

		foreach (library; libraries) {
			void* dl = LoadLibraryW((library.to!wstring ~ cast(wchar) 0).ptr);
			if (dl) {
				result.dls ~= dl;
			}
		}
	}
	else {
		static assert(0);
	}

	return result;
}
