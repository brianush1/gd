module scripts.genbindings;

import std.stdio;
import std.file;
import std.file : write, remove;
import std.regex;
import std.process;
import std.string;
import std.array;
import std.range;
import std.algorithm;
import std.conv;

immutable(string[]) KEYWORDS = [
	"abstract", "alias", "align", "asm", "assert", "auto",
	"body", "bool", "break", "byte",
	"case", "cast", "catch", "cdouble", "cent", "cfloat", "char", "class", "const", "continue", "creal",
	"dchar", "debug", "default", "delegate", "delete", "deprecated", "do", "double",
	"else", "enum", "export", "extern",
	"false", "final", "finally", "float", "for", "foreach", "foreach_reverse", "function",
	"goto",
	"idouble", "if", "ifloat", "immutable", "import", "in", "inout", "int", "interface", "invariant", "ireal", "is",
	"lazy", "long",
	"macro", "mixin", "module",
	"new", "nothrow", "null",
	"out", "override",
	"package", "pragma", "private", "protected", "public", "pure",
	"real", "ref", "return",
	"scope", "shared", "short", "static", "struct", "super", "switch", "synchronized",
	"template", "this", "throw", "true", "try", "typeid", "typeof",
	"ubyte", "ucent", "uint", "ulong", "union", "unittest", "ushort",
	"version", "void",
	"wchar", "while", "with",
	"__FILE__", "__FILE_FULL_PATH__", "__MODULE__", "__LINE__", "__FUNCTION__", "__PRETTY_FUNCTION__",
	"__gshared", "__traits", "__vector", "__parameters",
];

enum DSTEP_OPTS = "--comments=false"
	~ " --space-after-function-name=false"
	~ " --single-line-function-signatures=true";

struct DStep {
	string file;
	string[] exclude;
	string cmdlineOpts;
	string[string] renames;
	string contents;
}

struct Library {
	string name;
	string className;
	string prefix;
	DStep[] files;
	string[] dimports;

	string[] posix;
	string delegate(string) transform;
}

int tempCounter = 0;

string dstep(DStep opts) {
	string cmd = "dstep " ~ DSTEP_OPTS;

	foreach (exclusion; opts.exclude) {
		cmd ~= " --skip " ~ exclusion;
	}

	if (opts.contents == "") {
		opts.contents = readText(opts.file);
	}

	string tempfile = "temp" ~ (tempCounter++).to!string ~ ".h";
	scope (exit) remove(tempfile);
	write(tempfile, opts.contents);

	cmd ~= " " ~ tempfile;
	cmd ~= " -o /dev/stdout";
	cmd ~= " " ~ opts.cmdlineOpts;

	std.stdio.write(cmd, "...");
	auto res = executeShell(cmd);
	assert(res.status == 0, "(" ~ cmd ~ ") " ~ res.output);
	writeln("done");

	string output = res.output;

	foreach (original, rename; opts.renames) {
		output = output.replaceAll(regex(r"\b" ~ original ~ r"\b"), rename);
	}

	output = output.replaceFirst(regex(r"extern\s*\(C\):\n+"), "");

	output = output.replaceAll!((Captures!string m) {
		string res;
		foreach (i; 0 .. m.hit.length / 4) {
			res ~= "\t";
		}
		return "\n" ~ res;
	})(regex(r"\n(    )+"));

	output = output.replaceAll!((Captures!string m) {
		return "\n" ~ m[1] ~ m[2] ~ " {";
	})(regex(r"\n(\t*)(.*?)\n\1\{"));

	return output;
}

string indent(string str) {
	return str.splitter("\n").map!(x => x == "" ? x : "\t" ~ x).joiner("\n").to!string;
}

string generate(Library lib) {
	string output;

	foreach (opts; lib.files) {
		output ~= "// file '" ~ opts.file ~ "'\n\n";
		output ~= dstep(opts);
	}

	writeln("output ", output.length, " chars long");

	std.stdio.write("rename structs...");

	string[] renamedStructs;

	output = output.replaceAll!((Captures!string m) {
		renamedStructs ~= m[2];
		return m[1] ~ " " ~ m[2] ~ m[3];
	})(regex(r"(union|struct) _(.*)( \{(.|\n)*?\})\n*alias \2 = _\2;"));

	foreach (name; renamedStructs) {
		output = output.replaceAll(regex(r"\b_" ~ name ~ r"\b"), name);
	}

	foreach (m; output.matchAll(regex(r"\bstruct _(.*)\b"))) {
		output = output.replaceAll(regex(r"\b_" ~ m[1] ~ r"\b"), "Private" ~ m[1]);
	}

	writeln("done");

	writeln("rename functions and macros...");

	string[] renameFunctions, renameMacros;

	foreach (name; output.matchAll(regex(r"\n.*? " ~ lib.prefix ~ r"([A-Za-z][A-Za-z0-9_]+)\("))) {
		renameFunctions ~= name[1];
	}

	foreach (name; output.matchAll(regex(r"\bauto ([A-Z][A-Za-z0-9_]+)\b"))) {
		renameMacros ~= name[1];
	}

	writeln("rename functions...");

	foreach (index, name; renameFunctions) {
		if (index % 10 == 0 || index + 1 == renameFunctions.length) {
			writeln(index + 1, "/", renameFunctions.length);
		}

		string replacement;
		size_t countCaps = 0;
		foreach (ch; name) {
			if (ch >= 'A' && ch <= 'Z') {
				countCaps += 1;
			}
			else {
				break;
			}
		}

		bool notDefaultReplacement;

		if (countCaps == 1) {
			replacement = cast(char)(name[0] - 'A' + 'a') ~ name[1 .. $];

			if (KEYWORDS.canFind(replacement)) {
				replacement ~= "_";
				notDefaultReplacement = true;
			}
		}
		else if (countCaps == 0) {
			replacement = name;
			notDefaultReplacement = true;
		}
		else {
			replacement = name[0 .. countCaps - 1].map!toLower.to!string ~ name[countCaps - 1 .. $];
			notDefaultReplacement = true;
		}

		if (notDefaultReplacement) {
			output = output.replaceAll(regex(r"(\n[a-zA-Z]+\** )" ~ lib.prefix ~ name ~ r"\("),
				"\n@BindingName(\"" ~ lib.prefix ~ name ~ "\")$1" ~ replacement ~ "(");
		}

		output = output.replaceAll(regex("\\b(?<!\")" ~ lib.prefix ~ name ~ r"\b"), replacement);
	}

	writeln("rename macros...");

	foreach (index, name; renameMacros) {
		if (index % 10 == 0 || index + 1 == renameMacros.length) {
			writeln(index + 1, "/", renameMacros.length);
		}
		output = output.replaceAll(regex(r"\b" ~ name ~ r"\b"),
			cast(char)(name[0] - 'A' + 'a') ~ name[1 .. $]
		);
	}

	writeln("done");

	std.stdio.write("misc...");

	output = output.replaceAll(regex(r"(extern \(D\) auto \w+)\(\)"), "$1()()");
	output = output.replaceAll(regex(r"(extern \(D\))"), "static $1");

	output = output.replaceAll!((Captures!string m) {
		string str = m[1].retro.to!string;
		for (size_t i = 3; i < str.length; i += 4) {
			str = str[0 .. i] ~ "_" ~ str[i .. $];
		}
		return str.retro.to!string;
	})(regex(r"\b(\d{5,})\b"));

	output = output.replaceAll(regex(r"(0x[0-9a-fA-F]+|\d+)(u|U)(l|L)(l|L)"), "$1UL");
	output = output.replaceAll(regex(r"(0x[0-9a-fA-F]+|\d+)(u|U)(l|L)"), "$1UL");
	output = output.replaceAll(regex(r"(0x[0-9a-fA-F]+|\d+)(u|U)"), "$1U");
	output = output.replaceAll(regex(r"(0x[0-9a-fA-F]+|\d+)(l|L)"), "$1L");

	// TODO: figure out how to do varargs in the loader
	// for now, we just comment them out
	output = output.replaceAll(regex(r"\n(.*?)\.\.\.\);\n"), "\n// $1...);\n");

	writeln("done");

	struct EnumDef {
		size_t loc;
		string str;
	}

	std.stdio.write("comment enums...");

	EnumDef[string] enumDefs;
	EnumDef[] toComment;
	foreach (Captures!string m; output.matchAll(regex(r"enum (\w+) = .*?;\n"))) {
		string name = m[1];
		if (name in enumDefs) {
			toComment ~= EnumDef(m.pre.length, m.hit);
		}
		else {
			enumDefs[name] = EnumDef(m.pre.length, m.hit);
		}
	}
	foreach_reverse (e; toComment) {
		output = output[0 .. e.loc] ~ "// " ~ output[e.loc .. $];
	}

	writeln("done");

	output = `module gd.bindings.` ~ lib.name ~ `;` ~ lib.dimports.map!(x => "\nimport gd.bindings." ~ x ~ ";")
		.joiner().to!string ~ `
import gd.bindings.loader;
import gd.resource;
import core.stdc.config;
import core.stdc.stddef;

private static ` ~ lib.className ~ `Library m_` ~ lib.className ~ `;
` ~ lib.className ~ `Library ` ~ lib.className ~ `() @property { // @suppress(dscanner.confusing.function_attributes)
	if (m_` ~ lib.className ~ ` is null) {
		m_` ~ lib.className ~ ` = load` ~ lib.className ~ `;
		registerLibraryResource(m_` ~ lib.className ~ `);
	}

	return m_` ~ lib.className ~ `;
}

` ~ lib.className ~ `Library load` ~ lib.className ~ `() {
	string[] libraries;

	version (Posix) {
		libraries = [` ~ lib.posix.map!(x => `"` ~ x ~ `"`).joiner(", ").to!string ~ `];
	}
	else {
		static assert(0, "unsupported platform");
	}

	return loadSharedLibrary!(` ~ lib.className ~ `Library, delegate(string name) {
		return "` ~ lib.prefix ~ `" ~ cast(char)(name[0] + 'A' - 'a') ~ name[1 .. $];
	})(libraries);
}

abstract class ` ~ lib.className ~ `Library : Resource {
	extern (System) @nogc nothrow:
` ~ output.strip.indent ~ "\n}\n";

	if (lib.transform !is null) {
		output = lib.transform(output);
	}

	string tempfile = "temp" ~ (tempCounter++).to!string ~ ".d";
	write(tempfile, output);

	scope (exit) {
		remove(tempfile);
	}

	std.stdio.write("formatting...");
	stdout.flush();

	auto dfmtOutput = executeShell("yes | dub run dfmt --build=release --"
		~ " --brace_style=stroustrup"
		~ " --end_of_line=lf"
		~ " --indent_style=tab"
		~ " --tab_width=4"
		~ " --max_line_length=120"
		~ " --inplace"
		~ " " ~ tempfile
	);
	assert(dfmtOutput.status == 0, dfmtOutput.output);

	writeln("done");

	return readText(tempfile);
}

bool[string] toSet(string[] arr) {
	bool[string] result;

	foreach (str; arr) {
		result[str] = true;
	}

	return result;
}

void main(string[] args) {
	if (args.canFind("x11")) {
		std.stdio.write("Generating X11 bindings...    ");
		stdout.flush();

		Library x11 = {
			name: "x11",
			className: "X11",
			prefix: "X",
			files: [
				DStep("/usr/include/X11/keysymdef.h", [], [
					"XK_MISCELLANY", "XK_XKB_KEYS", "XK_LATIN1", "XK_LATIN2", "XK_LATIN3",
					"XK_LATIN4", "XK_LATIN8", "XK_LATIN9", "XK_CAUCASUS", "XK_GREEK",
					"XK_KATAKANA", "XK_ARABIC", "XK_CYRILLIC", "XK_HEBREW", "XK_THAI",
					"XK_KOREAN", "XK_ARMENIAN", "XK_GEORGIAN", "XK_VIETNAMESE",
					"XK_CURRENCY", "XK_MATHEMATICAL", "XK_BRAILLE", "XK_SINHALA",
				].map!(x => "-D" ~ x).joiner(" ").to!string),
				DStep("/usr/include/X11/X.h"),
				DStep("/usr/include/X11/Xutil.h"),
				DStep("/usr/include/X11/extensions/XKBstr.h", [], "", null,
					"#include \"/usr/include/X11/Xlib.h\"\n"
					~ readText("/usr/include/X11/extensions/XKBstr.h")),
				DStep("/usr/include/X11/extensions/XKB.h"),
				DStep("/usr/include/X11/XKBlib.h"),
				DStep("/usr/include/X11/cursorfont.h"),
				// DStep("/usr/include/X11/extensions/XInput2.h"),
				// DStep("/usr/include/X11/extensions/Xfixes.h", [], "", null,
				// 	"#include \"/usr/include/X11/Xlib.h\"\n"
				// 	~ readText("/usr/include/X11/extensions/Xfixes.h")),
				// DStep("/usr/include/X11/extensions/xfixeswire.h", [], "", null,
				// 	"#include \"/usr/include/X11/Xlib.h\"\n"
				// 	~ readText("/usr/include/X11/extensions/xfixeswire.h")),
				// DStep("/usr/include/X11/extensions/XI2.h", [], "", null,
				// 	"#include \"/usr/include/X11/Xlib.h\"\n"
				// 	~ readText("/usr/include/X11/extensions/XI2.h")),
				DStep("/usr/include/X11/Xlib.h", [
					"_Xmblen",
					"_Xdebug",
					"_Xmbtowc",
					"_Xwctomb",
				], "", [
					"funcs": "Funcs",
				]),
			],

			posix: ["libX11.so.6","libX11.so"],
		};

		write("../bindings/source/gd/bindings/x11.d", generate(x11));

		writeln("done");
	}

	if (args.canFind("xfixes")) {
		std.stdio.write("Generating XFixes bindings...    ");
		stdout.flush();

		Library xfixes = {
			name: "xfixes",
			className: "XFixes",
			prefix: "XFixes",
			files: [
				DStep("/usr/include/X11/extensions/Xfixes.h", [], "", null,
					"#include \"/usr/include/X11/Xlib.h\"\n"
					~ readText("/usr/include/X11/extensions/Xfixes.h")),
				DStep("/usr/include/X11/extensions/xfixeswire.h", [], "", null,
					"#include \"/usr/include/X11/Xlib.h\"\n"
					~ readText("/usr/include/X11/extensions/xfixeswire.h")),
			],

			posix: ["libXfixes.so.3","libXfixes.so"],
			dimports: ["x11"],
			transform: (string src) {
				foreach (symbol; ["Display", "Window", "Atom", "Time",
						"XRectangle", "GC", "XID", "Cursor", "Pixmap"]) {
					src = src.replaceAll(regex(r"\b" ~ symbol ~ r"\b"), "X11." ~ symbol);
				}
				return src;
			},
		};

		write("../bindings/source/gd/bindings/xfixes.d", generate(xfixes));

		writeln("done");
	}

	if (args.canFind("xcursor")) {
		std.stdio.write("Generating XCursor bindings...    ");
		stdout.flush();

		Library xcursor = {
			name: "xcursor",
			className: "XCursor",
			prefix: "Xcursor",
			files: [
				DStep("/usr/include/X11/Xcursor/Xcursor.h", [], "", null,
					"#include \"/usr/include/X11/Xlib.h\"\n"
					~ readText("/usr/include/X11/Xcursor/Xcursor.h")),
			],

			posix: ["libXcursor.so.1","libXcursor.so"],
			dimports: ["x11"],
			transform: (string src) {
				foreach (symbol; ["Display", "Cursor", "Font", "XColor",
						"Pixmap", "Drawable", "XImage"]) {
					src = src.replaceAll(regex(r"\b" ~ symbol ~ r"\b"), "X11." ~ symbol);
				}
				return src;
			},
		};

		write("../bindings/source/gd/bindings/xcursor.d", generate(xcursor));

		writeln("done");
	}

	if (args.canFind("xi2")) {
		std.stdio.write("Generating XI2 bindings...    ");
		stdout.flush();

		Library xi2 = {
			name: "xi2",
			className: "XI2",
			prefix: "XI",
			files: [
				DStep("/usr/include/X11/extensions/XInput2.h"),
				DStep("/usr/include/X11/extensions/XI2.h", [], "", null,
					"#include \"/usr/include/X11/Xlib.h\"\n"
					~ readText("/usr/include/X11/extensions/XI2.h")),
			],

			posix: ["libXi.so.6", "libXi.so"],
			dimports: ["x11", "xfixes"],
			transform: (string src) {
				foreach (symbol; ["Window", "Atom", "Time",
						"Display", "Cursor", "True", "False"]) {
					src = src.replaceAll(regex(r"\b" ~ symbol ~ r"\b"), "X11." ~ symbol);
				}
				foreach (symbol; ["PointerBarrier"]) {
					src = src.replaceAll(regex(r"\b" ~ symbol ~ r"\b"), "XFixes." ~ symbol);
				}
				return src;
			},
		};

		write("../bindings/source/gd/bindings/xi2.d", generate(xi2));

		writeln("done");

		writeln("Add in this code above 'maskIsSet':");
		writeln(q"[
	static extern (D) auto setMask(T0, T1)(auto ref T0 ptr, auto ref T1 event) {
		return (cast(ubyte*) ptr)[event >> 3] |= (1 << (event & 7));
	}
]");
		writeln("I don't know why it doesn't get generated by dstep");
	}

	if (args.canFind("xsync")) {
		std.stdio.write("Generating XSync bindings...    ");
		stdout.flush();

		Library xsync = {
			name: "xsync",
			className: "XSync",
			prefix: "XSync",
			files: [
				DStep("/usr/include/X11/extensions/syncconst.h", [
					"XSyncIntToValue",
					"XSyncIntsToValue",
					"XSyncValueGreaterThan",
					"XSyncValueLessThan",
					"XSyncValueGreaterOrEqual",
					"XSyncValueLessOrEqual",
					"XSyncValueEqual",
					"XSyncValueIsNegative",
					"XSyncValueIsZero",
					"XSyncValueIsPositive",
					"XSyncValueLow32",
					"XSyncValueHigh32",
					"XSyncValueAdd",
					"XSyncValueSubtract",
					"XSyncMaxValue",
					"XSyncMinValue",
				], "", null,
					"#include \"/usr/include/X11/Xlib.h\"\n"
					~ readText("/usr/include/X11/extensions/syncconst.h")),
				DStep("/usr/include/X11/extensions/sync.h", [], "", null,
					"#include \"/usr/include/X11/Xlib.h\"\n"
					~ readText("/usr/include/X11/extensions/sync.h")),
			],

			posix: ["libXext.so.6", "libXext.so"],
			dimports: ["x11"],
			transform: (string src) {
				foreach (x11symbol; ["Display", "Time", "XID", "Drawable"]) {
					src = src.replaceAll(regex(r"\b" ~ x11symbol ~ r"\b"), "X11." ~ x11symbol);
				}
				return src;
			},
		};

		write("../bindings/source/gd/bindings/xsync.d", generate(xsync));

		writeln("done");
	}

	if (args.canFind("gl")) {
		std.stdio.write("Generating GL bindings... ");
		stdout.flush();

		string[] excludeGL = [
			"APIENTRY",
			"GL_VERSION_1_1",
		];

		bool[string] potentials = (readText("/usr/include/GL/gl.h")
				~ "\n" ~ readText("/usr/include/GL/glext.h"))
			.matchAll(regex(r"#ifndef\s+(\w+)"))
			.map!(x => x[1]).array.toSet;

		foreach (potential; potentials.byKey) {
			if (!excludeGL.canFind(potential)) {
				excludeGL ~= potential;
			}
		}

		Library gl = {
			name: "gl",
			className: "GL",
			prefix: "gl",
			files: [
				DStep("/usr/include/GL/gl.h", excludeGL ~ [
					"glBlendColor", // these are also defined in glext.h; prefer those instead
					"glBlendEquation",
				], "-DGL_GLEXT_PROTOTYPES"),
				DStep("/usr/include/GL/glext.h", excludeGL, "-DGL_GLEXT_PROTOTYPES", null,
					"#define __gl_glext_h_\n#include \"/usr/include/GL/gl.h\"\n#undef __gl_glext_h_\n"
					~ readText("/usr/include/GL/glext.h")),
			],

			posix: ["libGL.so.1", "libGL.so"],
			transform: (string src) {
				src = src.replaceAll(regex(r"(?!\n).*?alias PFN.*?\n"), "");
				return src;
			},
		};

		write("../bindings/source/gd/bindings/gl.d", generate(gl)
			.replaceAll(regex(r"\bGL_([A-Z_][A-Z0-9_]*)\b"), "$1")
			.replaceAll!((Captures!string m) {
				if (m[1][0] == 'u') {
					return "U" ~ cast(char) m[1][1].toUpper ~ m[1][2 .. $]; // GLubyte -> UByte
				}
				else {
					return cast(char) m[1][0].toUpper ~ m[1][1 .. $]; // GLfloat -> Float
				}
			})(regex(r"\bGL([a-z]+)\b"))
		);

		writeln("done");
	}

	if (args.canFind("glx")) {
		std.stdio.write("Generating GLX bindings... ");
		stdout.flush();

		Library glx = {
			name: "glx",
			className: "GLX",
			prefix: "glX",
			files: [
				DStep("/usr/include/GL/glx.h"),
				DStep("/usr/include/GL/glxext.h", [], "-DGLX_GLXEXT_PROTOTYPES -DGLX_GLXEXT_LEGACY", null,
					"#include \"/usr/include/X11/Xlib.h\"\n"
					~ "#include \"/usr/include/X11/Xutil.h\"\n"
					~ "#include \"/usr/include/GL/gl.h\"\n"
					~ "#include \"/usr/include/GL/glx.h\"\n"
					~ readText("/usr/include/GL/glxext.h")),
			],

			posix: ["libGL.so.1", "libGL.so"],
			dimports: ["x11", "gl"],
			transform: (string src) {
				src = src.replaceAll(regex(r"(?!\n).*?alias PFN.*?\n"), "");
				foreach (x11symbol; ["Window", "XVisualInfo", "Display", "Pixmap", "Colormap", "Font"]) {
					src = src.replaceAll(regex(r"\b" ~ x11symbol ~ r"\b"), "X11." ~ x11symbol);
				}
				src = src.replaceAll(regex(r"\b_XDisplay\b"), "X11.Display");

				// for some reason, there are two of these; just remove the first one to remove the conflict
				src = src.replaceFirst(regex(r"(?!\n).*?struct Private_GLXFBConfigRec;.*?\n"), "");

				return src;
			},
		};

		write("../bindings/source/gd/bindings/glx.d", generate(glx)
			.replaceAll(regex(r"\bGLX_([A-Z_]+)\b"), "$1")
			.replaceAll!((Captures!string m) {
				if (m[1][0] == 'u') {
					return "GL.U" ~ cast(char) m[1][1].toUpper ~ m[1][2 .. $]; // GLubyte -> GL.UByte
				}
				else {
					return "GL." ~ cast(char) m[1][0].toUpper ~ m[1][1 .. $]; // GLfloat -> GL.Float
				}
			})(regex(r"\bGL([a-z]+)\b"))
		);

		writeln("done");
	}
}
