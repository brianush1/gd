module gd.bindings.loader;
import gd.resource;
import gd.logging;

struct BindingName {
	string name;
}

interface SharedLibrary {
extern (System) @nogc nothrow:
	void* getProcAddress(const(char)* name);
}

LibraryType loadSharedLibrary(LibraryType, string delegate(string) toLibraryName, string extraMixin = "")(string[] libraries)
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

	final class ResultType : LibraryType, SharedLibrary {
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

			void* getProcAddress(const(char)* name) {
				version (Posix) {
					foreach (dl; dls) {
						dlerror();

						void* sym = dlsym(dl, name);
						if (dlerror()) {
							continue;
						}

						return sym;
					}
				}
				else version (Windows) {
					foreach (dl; dls) {
						void* sym = GetProcAddress(dl, name);
						if (!sym) {
							continue;
						}

						return sym;
					}
				}
				else {
					static assert(0);
				}

				"~extraMixin~"

				return null;
			}

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
					alias ReturnType = imported!"std.traits".ReturnType!(__traits(getMember, LibraryType, member));
					static if (imported!"std.traits".isSomeFunction!ReturnType)
						enum isVariadic = imported!"std.traits".variadicFunctionStyle!ReturnType
							== imported!"std.traits".Variadic.c;
					else
						enum isVariadic = false;
					write("static if (is(typeof(LibraryType.");
					write(member);
					write(") P");
					write(member);
					write(" == function) && is(typeof(LibraryType.");
					write(member);
					write(") R");
					write(member);
					write(" == return)) {
						private ");
					static if (isVariadic) {
						write("R");
						write(member);
					}
					else {
						write("R");
						write(member);
						write(" function(P");
						write(member);
						write(") nothrow");
					}
					write(" _impl");
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
							alias bindingNameTuple = __traits(getAttributes, __traits(getOverloads, LibraryType, \"");
					write(member);
					write("\")[0]);
							static if (bindingNameTuple.length > 0) {
								enum string libraryName = bindingNameTuple[0].name;
							}
							else {
								enum string libraryName = toLibraryName(\"");
					write(member);
					write("\");
							}

							*cast(void**)&fun = getProcAddress(libraryName);
						}

						if (fun is null) {
							logger.handleMissingBinding(LibraryType.stringof, \"");
					write(member);
					write("\");

							static if (is(typeof(return) == void))
								return;
							else
								return typeof(return).init;
						}
						");
					static if (isVariadic) {
						write("return fun;");
					}
					else {
						write("return fun(args);");
					}
					write("}}");
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

LibraryType loadStaticLibrary(LibraryType, string delegate(string) toLibraryName)()
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

	enum code = {
		char[] result = new char[(Members.length + 1) * 1024];

		size_t index = 0;
		void write(string str) {
			result[index .. (index += str.length)] = str[];
		}

		write("extern (System) @nogc nothrow:

		");

		static foreach (member; Members) {{
			static if (
				is(typeof(__traits(getMember, LibraryType, member)) == function)
			) {
				alias bindingNameTuple = __traits(getAttributes, __traits(getOverloads, LibraryType, member)[0]);
				static if (bindingNameTuple.length > 0) {
					string libraryName = bindingNameTuple[0].name;
				}
				else {
					string libraryName = toLibraryName(member);
				}
				write("static if (is(typeof(LibraryType.");
				write(member);
				write(") P");
				write(member);
				write(" == function) && is(typeof(LibraryType.");
				write(member);
				write(") R");
				write(member);
				write(" == return)) {
					override R");
				write(member);
				write(" ");
				write(member);
				write("(P");
				write(member);
				write(" args) {
					pragma(mangle, \"");
				write(libraryName);
				write("\")
					static extern (C) R");
				write(member);
				write(" fun(P");
				write(member);
				write(" p) @nogc nothrow;
					return fun(args);
				}}");
			}
		}}

		return result[0 .. index];
	}();

	final class ResultType : LibraryType {
		protected override void disposeImpl() {}

		mixin(code);
	}

	static ResultType result;

	if (result !is null) {
		return result;
	}

	result = new ResultType;

	return result;
}
