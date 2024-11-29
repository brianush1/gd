import std.stdio;
import std.file;
import std.net.curl;
import std.process;
import std.path;
import std.json;
import std.uni : toLower;
import std.string : replace;
import std.conv;
import std.exception : assumeUnique;

void setupAndroidTools() {
	mkdir(".gd-android");
	scope (failure) {
		rmdirRecurse(".gd-android");
	}

	File gitignore = File(".gd-android/.gitignore", "w");
	gitignore.writeln("/*");
	gitignore.close();

	writeln("Downloading Android CLI tools...");

	download("https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip", ".gd-android/cli.zip");
	auto unzip = executeShell("unzip cli.zip", null, Config.none, size_t.max, ".gd-android");
	if (unzip.status != 0) {
		writeln("Output: ", unzip.output);
		throw new Exception("Failed to unzip CLI tools");
	}

	std.file.remove(".gd-android/cli.zip");

	mkdir(".gd-android/sdk");

	writeln("Installing SDK...");

	auto sdk = executeShell(
		"yes | .gd-android/cmdline-tools/bin/sdkmanager --sdk_root=.gd-android/sdk"
		~ " --install 'platforms;android-34' 'ndk;21.0.6113669'",
	);
	if (sdk.status != 0) {
		writeln("Output: ", unzip.output);
		throw new Exception("Failed to install SDK");
	}

	writeln("Downloading LDC...");

	download("https://github.com/ldc-developers/ldc/releases/download/v1.39.0/ldc2-1.39.0-android-aarch64.tar.xz", ".gd-android/ldc2-aarch64.tar.xz");
	unzip = executeShell("tar -xJf ldc2-aarch64.tar.xz", null, Config.none, size_t.max, ".gd-android");
	if (unzip.status != 0) {
		writeln("Output: ", unzip.output);
		throw new Exception("Failed to extract LDC");
	}

	std.file.remove(".gd-android/ldc2-aarch64.tar.xz");

	download("https://github.com/ldc-developers/ldc/releases/download/v1.39.0/ldc2-1.39.0-linux-x86_64.tar.xz", ".gd-android/ldc2-x86_64.tar.xz");
	unzip = executeShell("tar -xJf ldc2-x86_64.tar.xz", null, Config.none, size_t.max, ".gd-android");
	if (unzip.status != 0) {
		writeln("Output: ", unzip.output);
		throw new Exception("Failed to extract LDC");
	}

	std.file.remove(".gd-android/ldc2-x86_64.tar.xz");

	rmdirRecurse(".gd-android/ldc2-1.39.0-linux-x86_64/lib");
	std.file.rename(".gd-android/ldc2-1.39.0-android-aarch64/lib-x86_64", ".gd-android/ldc2-1.39.0-linux-x86_64/lib");

	string conf = `
"x86_64-.*-linux-android":
{
	switches = [
		"-defaultlib=phobos2-ldc,druntime-ldc",
		"-link-defaultlib-shared=false",
		"-gcc=%%ldcbinarypath%%/../../sdk/ndk/21.0.6113669/toolchains/llvm/prebuilt/linux-x86_64/bin/x86_64-linux-android29-clang",
		"-linker=%%ldcbinarypath%%/../../sdk/ndk/21.0.6113669/toolchains/llvm/prebuilt/linux-x86_64/bin/x86_64-linux-android-ld.bfd",
		"-L=-L%%ldcbinarypath%%/../../sdk/ndk/21.0.6113669/toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/lib/x86_64-linux-android/29"
	];
	lib-dirs = [
		"%%ldcbinarypath%%/../../ldc2-1.39.0-linux-x86_64/lib",
	];
	rpath = "";
};

"aarch64-.*-linux-android":
{
	switches = [
		"-defaultlib=phobos2-ldc,druntime-ldc",
		"-link-defaultlib-shared=false",
		"-gcc=%%ldcbinarypath%%/../../sdk/ndk/21.0.6113669/toolchains/llvm/prebuilt/linux-x86_64/bin/aarch64-linux-android29-clang",
		"-linker=%%ldcbinarypath%%/../../sdk/ndk/21.0.6113669/toolchains/llvm/prebuilt/linux-x86_64/bin/aarch64-linux-android-ld.bfd",
		"-L=-L%%ldcbinarypath%%/../../sdk/ndk/21.0.6113669/toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/lib/aarch64-linux-android/29"
	];
	lib-dirs = [
		"%%ldcbinarypath%%/../../ldc2-1.39.0-android-aarch64/lib",
	];
	rpath = "";
};`;

	File ldc2Conf = File(".gd-android/ldc2-1.39.0-linux-x86_64/etc/ldc2.conf", "a");
	ldc2Conf.writeln(conf);
	ldc2Conf.close();
}

void copyTemplateRecursive(
	string path,
	string destination,
	scope immutable(ubyte)[] delegate(immutable(ubyte)[]) patch,
	scope string delegate(string) patchPath,
) {
	mkdirRecurse(destination);

	foreach (DirEntry e; dirEntries(path, SpanMode.breadth)) {
		string relPath = asRelativePath(e.name, path).to!string;
		string newPath = buildNormalizedPath(destination, patchPath(relPath));

		if (e.isDir) {
			mkdirRecurse(newPath);
		}
		else {
			File oldFile = File(e.name, "r");
			oldFile.seek(0, SEEK_END);
			ulong len = oldFile.tell();
			oldFile.seek(0, SEEK_SET);
			ubyte[] buf = new ubyte[len];
			oldFile.rawRead(buf);
			oldFile.close();

			File file = File(newPath, "w");
			file.rawWrite(patch(buf.assumeUnique));
			file.close();
		}

		version (Posix) {
			setAttributes(newPath, getAttributes(e.name));
		}
	}
}

void buildAndroid() {
	if (!exists(".gd-android")) {
		setupAndroidTools();
	}

	enum TEMPLATE_DOMAIN = "com.example";
	enum TEMPLATE_APP_NAME = "TemplateApplication";
	enum TEMPLATE_APP_TITLE = "Template Application";
	enum TEMPLATE_TARGET_NAME = "template-library-name";

	string[string] archs = [
		"aarch64": "arm64-v8a",
		"x86_64": "x86_64",
	];

	writeln("Reading dub.json");
	JSONValue recipe = parseJSON(readText("dub.json"));
	if ("subConfigurations" !in recipe) {
		recipe["subConfigurations"] = JSONValue.emptyObject;
	}
	recipe["subConfigurations"]["gd"] = "gd_Android";
	recipe["targetType"] = "dynamicLibrary";
	string targetName = "targetName" in recipe
		? recipe["targetName"].get!string : recipe["name"].get!string;
	targetName = "app-" ~ targetName;
	recipe["targetName"] = targetName;

	File newRecipeFile = File(".gd-android/dub.json", "w");
	newRecipeFile.writeln(recipe.toPrettyString());
	newRecipeFile.close();

	scope (exit) {
		std.file.remove(".gd-android/dub.json");
	}

	writeln("Reading app.json");

	JSONValue appData = exists("app.json") ? parseJSON(readText("app.json")) : JSONValue.emptyObject;

	string domain = "domain" in appData ? appData["domain"].get!string : TEMPLATE_DOMAIN;
	string appName = recipe["name"].get!string;
	string appTitle = "title" in appData ? appData["title"].get!string : appName;

	if (exists(".gd-android/app")) {
		rmdirRecurse(".gd-android/app");
	}

	copyTemplateRecursive(
		buildNormalizedPath(thisExePath, "../templates/TemplateApplication"),
		".gd-android/app",
		(immutable(ubyte)[] s) {
			return s
				.replace(cast(immutable(ubyte)[]) TEMPLATE_DOMAIN, cast(immutable(ubyte)[]) domain)
				.replace(cast(immutable(ubyte)[]) TEMPLATE_APP_NAME, cast(immutable(ubyte)[]) appName)
				.replace(cast(immutable(ubyte)[]) TEMPLATE_APP_NAME.toLower, cast(immutable(ubyte)[]) appName.toLower)
				.replace(cast(immutable(ubyte)[]) TEMPLATE_APP_TITLE, cast(immutable(ubyte)[]) appTitle)
				.replace(cast(immutable(ubyte)[]) TEMPLATE_TARGET_NAME, cast(immutable(ubyte)[]) targetName)
				;
		},
		(string s) {
			return s
				.replace(TEMPLATE_DOMAIN.replace(".", "/"), domain.replace(".", "/"))
				.replace(TEMPLATE_APP_NAME, appName)
				.replace(TEMPLATE_APP_NAME.toLower, appName.toLower)
				;
		},
	);

	File localProperties = File(".gd-android/app/local.properties", "w");
	localProperties.writeln("sdk.dir=" ~ asAbsolutePath(".gd-android/sdk").to!string);
	localProperties.close();

	foreach (arch; archs.byKey) {
		writeln("Building ", arch, " binary");

		string mtriple = "-mtriple=" ~ arch ~ "--linux-android";
		Pid pid = spawnProcess(
			[
				"dub",
				"build",
				"--recipe=.gd-android/dub.json",
			],
			stdin, stdout, stderr,
			[
				"DFLAGS": environment.get("DFLAGS", "")
					~ " " ~ mtriple,
				"DC": absolutePath(".gd-android/ldc2-1.39.0-linux-x86_64/bin/ldc2"),
			],
		);

		int status = wait(pid);
		if (status != 0) {
			throw new Exception("Failed to build " ~ arch ~ " binary");
		}

		string libName = "lib" ~ targetName ~ ".so";
		string jniPath = ".gd-android/app/app/src/main/jniLibs/" ~ archs[arch];
		mkdirRecurse(jniPath);
		rename(libName, jniPath ~ "/" ~ libName);
	}

	writeln("Building .apk with gradle");

	Pid pid = spawnProcess(
		[
			"./gradlew",
			"build",
		],
		stdin, stdout, stderr,
		null, Config.none, ".gd-android/app",
	);

	int status = wait(pid);
	if (status != 0) {
		throw new Exception("Failed to package .apk");
	}

	rename(".gd-android/app/app/build/outputs/apk/debug/app-debug.apk", targetName ~ ".apk");
}

int main(string[] args) {
	if (args.length < 2) {
		writeln("Please specify the target platform with 'dub run gd:build -- PLATFORM_NAME'");
		writeln("The following platforms are available:");
		writeln("  - android");
		return 1;
	}

	string targetPlatform = args[1];

	if (targetPlatform == "android") {
		buildAndroid();
		return 0;
	}
	else {
		writeln("Unrecognized platform '", targetPlatform, "'");
		return 1;
	}
}
