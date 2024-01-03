module gd.bindings.fc;
import gd.bindings.loader;
import gd.resource;
import core.stdc.config;
import core.stdc.stddef;

version (gd_X11Impl):

private static FCLibrary m_FC;
FCLibrary FC() @property { // @suppress(dscanner.confusing.function_attributes)
	if (m_FC is null) {
		m_FC = loadFC;
		registerLibraryResource(m_FC);
	}

	return m_FC;
}

FCLibrary loadFC() {
	string[] libraries;

	version (Posix) {
		libraries = ["libfontconfig.so.1", "libfontconfig.so"];
	}
	else {
		static assert(0, "unsupported platform");
	}

	return loadSharedLibrary!(FCLibrary, delegate(string name) {
		return "Fc" ~ cast(char)(name[0] + 'A' - 'a') ~ name[1 .. $];
	})(libraries);
}

abstract class FCLibrary : Resource {
extern (System) @nogc nothrow:
	// file '/usr/include/fontconfig/fontconfig.h'

	import core.stdc.limits;
	import core.stdc.stdarg;
	import core.sys.posix.sys.stat;

	alias Char8 = ubyte;
	alias Char16 = ushort;
	alias Char32 = uint;
	alias Bool = int;

	enum MAJOR = 2;
	enum MINOR = 14;
	enum REVISION = 1;

	enum VERSION = (MAJOR * 10_000) + (MINOR * 100) + REVISION;

	enum CACHE_VERSION_NUMBER = 8;

	enum False = 0;
	enum True = 1;
	enum DontCare = 2;

	enum FAMILY = "family";
	enum STYLE = "style";
	enum SLANT = "slant";
	enum WEIGHT = "weight";
	enum SIZE = "size";
	enum ASPECT = "aspect";
	enum PIXEL_SIZE = "pixelsize";
	enum SPACING = "spacing";
	enum FOUNDRY = "foundry";
	enum ANTIALIAS = "antialias";
	enum HINTING = "hinting";
	enum HINT_STYLE = "hintstyle";
	enum VERTICAL_LAYOUT = "verticallayout";
	enum AUTOHINT = "autohint";

	enum GLOBAL_ADVANCE = "globaladvance";
	enum WIDTH = "width";
	enum FILE = "file";
	enum INDEX = "index";
	enum FT_FACE = "ftface";
	enum RASTERIZER = "rasterizer";
	enum OUTLINE = "outline";
	enum SCALABLE = "scalable";
	enum COLOR = "color";
	enum VARIABLE = "variable";
	enum SCALE = "scale";
	enum SYMBOL = "symbol";
	enum DPI = "dpi";
	enum RGBA = "rgba";
	enum MINSPACE = "minspace";
	enum SOURCE = "source";
	enum CHARSET = "charset";
	enum LANG = "lang";
	enum FONTVERSION = "fontversion";
	enum FULLNAME = "fullname";
	enum FAMILYLANG = "familylang";
	enum STYLELANG = "stylelang";
	enum FULLNAMELANG = "fullnamelang";
	enum CAPABILITY = "capability";
	enum FONTFORMAT = "fontformat";
	enum EMBOLDEN = "embolden";
	enum EMBEDDED_BITMAP = "embeddedbitmap";
	enum DECORATIVE = "decorative";
	enum LCD_FILTER = "lcdfilter";
	enum FONT_FEATURES = "fontfeatures";
	enum FONT_VARIATIONS = "fontvariations";
	enum NAMELANG = "namelang";
	enum PRGNAME = "prgname";
	enum HASH = "hash";
	enum POSTSCRIPT_NAME = "postscriptname";
	enum FONT_HAS_HINT = "fonthashint";
	enum ORDER = "order";

	enum CHARWIDTH = "charwidth";
	enum CHAR_WIDTH = CHARWIDTH;
	enum CHAR_HEIGHT = "charheight";
	enum MATRIX = "matrix";

	enum WEIGHT_THIN = 0;
	enum WEIGHT_EXTRALIGHT = 40;
	enum WEIGHT_ULTRALIGHT = WEIGHT_EXTRALIGHT;
	enum WEIGHT_LIGHT = 50;
	enum WEIGHT_DEMILIGHT = 55;
	enum WEIGHT_SEMILIGHT = WEIGHT_DEMILIGHT;
	enum WEIGHT_BOOK = 75;
	enum WEIGHT_REGULAR = 80;
	enum WEIGHT_NORMAL = WEIGHT_REGULAR;
	enum WEIGHT_MEDIUM = 100;
	enum WEIGHT_DEMIBOLD = 180;
	enum WEIGHT_SEMIBOLD = WEIGHT_DEMIBOLD;
	enum WEIGHT_BOLD = 200;
	enum WEIGHT_EXTRABOLD = 205;
	enum WEIGHT_ULTRABOLD = WEIGHT_EXTRABOLD;
	enum WEIGHT_BLACK = 210;
	enum WEIGHT_HEAVY = WEIGHT_BLACK;
	enum WEIGHT_EXTRABLACK = 215;
	enum WEIGHT_ULTRABLACK = WEIGHT_EXTRABLACK;

	enum SLANT_ROMAN = 0;
	enum SLANT_ITALIC = 100;
	enum SLANT_OBLIQUE = 110;

	enum WIDTH_ULTRACONDENSED = 50;
	enum WIDTH_EXTRACONDENSED = 63;
	enum WIDTH_CONDENSED = 75;
	enum WIDTH_SEMICONDENSED = 87;
	enum WIDTH_NORMAL = 100;
	enum WIDTH_SEMIEXPANDED = 113;
	enum WIDTH_EXPANDED = 125;
	enum WIDTH_EXTRAEXPANDED = 150;
	enum WIDTH_ULTRAEXPANDED = 200;

	enum PROPORTIONAL = 0;
	enum DUAL = 90;
	enum MONO = 100;
	enum CHARCELL = 110;

	enum RGBA_UNKNOWN = 0;
	enum RGBA_RGB = 1;
	enum RGBA_BGR = 2;
	enum RGBA_VRGB = 3;
	enum RGBA_VBGR = 4;
	enum RGBA_NONE = 5;

	enum HINT_NONE = 0;
	enum HINT_SLIGHT = 1;
	enum HINT_MEDIUM = 2;
	enum HINT_FULL = 3;

	enum LCD_NONE = 0;
	enum LCD_DEFAULT = 1;
	enum LCD_LIGHT = 2;
	enum LCD_LEGACY = 3;

	enum _FcType {
		FcTypeUnknown = -1,
		FcTypeVoid = 0,
		FcTypeInteger = 1,
		FcTypeDouble = 2,
		FcTypeString = 3,
		FcTypeBool = 4,
		FcTypeMatrix = 5,
		FcTypeCharSet = 6,
		FcTypeFTFace = 7,
		FcTypeLangSet = 8,
		FcTypeRange = 9
	}

	alias FcType = _FcType;

	struct FcMatrix {
		double xx;
		double xy;
		double yx;
		double yy;
	}

	struct PrivateFcCharSet;
	alias FcCharSet = PrivateFcCharSet;

	struct FcObjectType {
		char* object;
		FcType type;
	}

	struct FcConstant {
		const(Char8)* name;
		const(char)* object;
		int value;
	}

	enum _FcResult {
		FcResultMatch = 0,
		FcResultNoMatch = 1,
		FcResultTypeMismatch = 2,
		FcResultNoId = 3,
		FcResultOutOfMemory = 4
	}

	alias FcResult = _FcResult;

	enum _FcValueBinding {
		FcValueBindingWeak = 0,
		FcValueBindingStrong = 1,
		FcValueBindingSame = 2,

		FcValueBindingEnd = INT_MAX
	}

	alias FcValueBinding = _FcValueBinding;

	struct PrivateFcPattern;
	alias FcPattern = PrivateFcPattern;

	struct FcPatternIter {
		void* dummy1;
		void* dummy2;
	}

	struct PrivateFcLangSet;
	alias FcLangSet = PrivateFcLangSet;

	struct PrivateFcRange;
	alias FcRange = PrivateFcRange;

	struct FcValue {
		FcType type;

		union _Anonymous_0 {
			const(Char8)* s;
			int i;
			Bool b;
			double d;
			const(FcMatrix)* m;
			const(FcCharSet)* c;
			void* f;
			const(FcLangSet)* l;
			const(FcRange)* r;
		}

		_Anonymous_0 u;
	}

	struct FcFontSet {
		int nfont;
		int sfont;
		FcPattern** fonts;
	}

	struct FcObjectSet {
		int nobject;
		int sobject;
		const(char*)* objects;
	}

	enum _FcMatchKind {
		FcMatchPattern = 0,
		FcMatchFont = 1,
		FcMatchScan = 2,
		FcMatchKindEnd = 3,
		FcMatchKindBegin = FcMatchPattern
	}

	alias FcMatchKind = _FcMatchKind;

	enum _FcLangResult {
		FcLangEqual = 0,
		FcLangDifferentCountry = 1,
		FcLangDifferentTerritory = 1,
		FcLangDifferentLang = 2
	}

	alias FcLangResult = _FcLangResult;

	enum _FcSetName {
		FcSetSystem = 0,
		FcSetApplication = 1
	}

	alias FcSetName = _FcSetName;

	struct FcConfigFileInfoIter {
		void* dummy1;
		void* dummy2;
		void* dummy3;
	}

	struct PrivateFcAtomic;
	alias FcAtomic = PrivateFcAtomic;

	enum FcEndian {
		FcEndianBig = 0,
		FcEndianLittle = 1
	}

	struct PrivateFcConfig;
	alias FcConfig = PrivateFcConfig;

	struct PrivateFcGlobalCache;
	alias FcFileCache = PrivateFcGlobalCache;

	struct PrivateFcBlanks;
	alias FcBlanks = PrivateFcBlanks;

	struct PrivateFcStrList;
	alias FcStrList = PrivateFcStrList;

	struct PrivateFcStrSet;
	alias FcStrSet = PrivateFcStrSet;

	struct PrivateFcCache;
	alias FcCache = PrivateFcCache;

	FcBlanks* blanksCreate();

	void blanksDestroy(FcBlanks* b);

	Bool blanksAdd(FcBlanks* b, Char32 ucs4);

	Bool blanksIsMember(FcBlanks* b, Char32 ucs4);

	const(Char8)* cacheDir(const(FcCache)* c);

	FcFontSet* cacheCopySet(const(FcCache)* c);

	const(Char8)* cacheSubdir(const(FcCache)* c, int i);

	int cacheNumSubdir(const(FcCache)* c);

	int cacheNumFont(const(FcCache)* c);

	Bool dirCacheUnlink(const(Char8)* dir, FcConfig* config);

	Bool dirCacheValid(const(Char8)* cache_file);

	Bool dirCacheClean(const(Char8)* cache_dir, Bool verbose);

	void cacheCreateTagFile(FcConfig* config);

	Bool dirCacheCreateUUID(Char8* dir, Bool force, FcConfig* config);

	Bool dirCacheDeleteUUID(const(Char8)* dir, FcConfig* config);

	Char8* configHome();

	Bool configEnableHome(Bool enable);

	Char8* configGetFilename(FcConfig* config, const(Char8)* url);

	Char8* configFilename(const(Char8)* url);

	FcConfig* configCreate();

	FcConfig* configReference(FcConfig* config);

	void configDestroy(FcConfig* config);

	Bool configSetCurrent(FcConfig* config);

	FcConfig* configGetCurrent();

	Bool configUptoDate(FcConfig* config);

	Bool configBuildFonts(FcConfig* config);

	FcStrList* configGetFontDirs(FcConfig* config);

	FcStrList* configGetConfigDirs(FcConfig* config);

	FcStrList* configGetConfigFiles(FcConfig* config);

	Char8* configGetCache(FcConfig* config);

	FcBlanks* configGetBlanks(FcConfig* config);

	FcStrList* configGetCacheDirs(FcConfig* config);

	int configGetRescanInterval(FcConfig* config);

	Bool configSetRescanInterval(FcConfig* config, int rescanInterval);

	FcFontSet* configGetFonts(FcConfig* config, FcSetName set);

	Bool configAppFontAddFile(FcConfig* config, const(Char8)* file);

	Bool configAppFontAddDir(FcConfig* config, const(Char8)* dir);

	void configAppFontClear(FcConfig* config);

	Bool configSubstituteWithPat(FcConfig* config, FcPattern* p,
			FcPattern* p_pat, FcMatchKind kind);

	Bool configSubstitute(FcConfig* config, FcPattern* p, FcMatchKind kind);

	const(Char8)* configGetSysRoot(const(FcConfig)* config);

	void configSetSysRoot(FcConfig* config, const(Char8)* sysroot);

	void configFileInfoIterInit(FcConfig* config, FcConfigFileInfoIter* iter);

	Bool configFileInfoIterNext(FcConfig* config, FcConfigFileInfoIter* iter);

	Bool configFileInfoIterGet(FcConfig* config, FcConfigFileInfoIter* iter,
			Char8** name, Char8** description, Bool* enabled);

	FcCharSet* charSetCreate();

	FcCharSet* charSetNew();

	void charSetDestroy(FcCharSet* fcs);

	Bool charSetAddChar(FcCharSet* fcs, Char32 ucs4);

	Bool charSetDelChar(FcCharSet* fcs, Char32 ucs4);

	FcCharSet* charSetCopy(FcCharSet* src);

	Bool charSetEqual(const(FcCharSet)* a, const(FcCharSet)* b);

	FcCharSet* charSetIntersect(const(FcCharSet)* a, const(FcCharSet)* b);

	FcCharSet* charSetUnion(const(FcCharSet)* a, const(FcCharSet)* b);

	FcCharSet* charSetSubtract(const(FcCharSet)* a, const(FcCharSet)* b);

	Bool charSetMerge(FcCharSet* a, const(FcCharSet)* b, Bool* changed);

	Bool charSetHasChar(const(FcCharSet)* fcs, Char32 ucs4);

	Char32 charSetCount(const(FcCharSet)* a);

	Char32 charSetIntersectCount(const(FcCharSet)* a, const(FcCharSet)* b);

	Char32 charSetSubtractCount(const(FcCharSet)* a, const(FcCharSet)* b);

	Bool charSetIsSubset(const(FcCharSet)* a, const(FcCharSet)* b);

	enum CHARSET_MAP_SIZE = 256 / 32;
	enum CHARSET_DONE = cast(Char32)-1;

	Char32 charSetFirstPage(const(FcCharSet)* a, ref Char32[8] map, Char32* next);

	Char32 charSetNextPage(const(FcCharSet)* a, ref Char32[8] map, Char32* next);

	Char32 charSetCoverage(const(FcCharSet)* a, Char32 page, Char32* result);

	void valuePrint(const FcValue v);

	void patternPrint(const(FcPattern)* p);

	void fontSetPrint(const(FcFontSet)* s);

	FcStrSet* getDefaultLangs();

	void defaultSubstitute(FcPattern* pattern);

	Bool fileIsDir(const(Char8)* file);

	Bool fileScan(FcFontSet* set, FcStrSet* dirs, FcFileCache* cache,
			FcBlanks* blanks, const(Char8)* file, Bool force);

	Bool dirScan(FcFontSet* set, FcStrSet* dirs, FcFileCache* cache,
			FcBlanks* blanks, const(Char8)* dir, Bool force);

	Bool dirSave(FcFontSet* set, FcStrSet* dirs, const(Char8)* dir);

	FcCache* dirCacheLoad(const(Char8)* dir, FcConfig* config, Char8** cache_file);

	FcCache* dirCacheRescan(const(Char8)* dir, FcConfig* config);

	FcCache* dirCacheRead(const(Char8)* dir, Bool force, FcConfig* config);

	FcCache* dirCacheLoadFile(const(Char8)* cache_file, stat_t* file_stat);

	void dirCacheUnload(FcCache* cache);

	FcPattern* freeTypeQuery(const(Char8)* file, uint id, FcBlanks* blanks, int* count);

	uint freeTypeQueryAll(const(Char8)* file, uint id, FcBlanks* blanks,
			int* count, FcFontSet* set);

	FcFontSet* fontSetCreate();

	void fontSetDestroy(FcFontSet* s);

	Bool fontSetAdd(FcFontSet* s, FcPattern* font);

	FcConfig* initLoadConfig();

	FcConfig* initLoadConfigAndFonts();

	@BindingName("FcInit")
	Bool init_();

	void fini();

	int getVersion();

	Bool initReinitialize();

	Bool initBringUptoDate();

	FcStrSet* getLangs();

	Char8* langNormalize(const(Char8)* lang);

	const(FcCharSet)* langGetCharSet(const(Char8)* lang);

	FcLangSet* langSetCreate();

	void langSetDestroy(FcLangSet* ls);

	FcLangSet* langSetCopy(const(FcLangSet)* ls);

	Bool langSetAdd(FcLangSet* ls, const(Char8)* lang);

	Bool langSetDel(FcLangSet* ls, const(Char8)* lang);

	FcLangResult langSetHasLang(const(FcLangSet)* ls, const(Char8)* lang);

	FcLangResult langSetCompare(const(FcLangSet)* lsa, const(FcLangSet)* lsb);

	Bool langSetContains(const(FcLangSet)* lsa, const(FcLangSet)* lsb);

	Bool langSetEqual(const(FcLangSet)* lsa, const(FcLangSet)* lsb);

	Char32 langSetHash(const(FcLangSet)* ls);

	FcStrSet* langSetGetLangs(const(FcLangSet)* ls);

	FcLangSet* langSetUnion(const(FcLangSet)* a, const(FcLangSet)* b);

	FcLangSet* langSetSubtract(const(FcLangSet)* a, const(FcLangSet)* b);

	FcObjectSet* objectSetCreate();

	Bool objectSetAdd(FcObjectSet* os, const(char)* object);

	void objectSetDestroy(FcObjectSet* os);

	FcObjectSet* objectSetVaBuild(const(char)* first, va_list va);

	// FcObjectSet* objectSetBuild(const(char)* first, ...);

	FcFontSet* fontSetList(FcConfig* config, FcFontSet** sets, int nsets,
			FcPattern* p, FcObjectSet* os);

	FcFontSet* fontList(FcConfig* config, FcPattern* p, FcObjectSet* os);

	FcAtomic* atomicCreate(const(Char8)* file);

	Bool atomicLock(FcAtomic* atomic);

	Char8* atomicNewFile(FcAtomic* atomic);

	Char8* atomicOrigFile(FcAtomic* atomic);

	Bool atomicReplaceOrig(FcAtomic* atomic);

	void atomicDeleteNew(FcAtomic* atomic);

	void atomicUnlock(FcAtomic* atomic);

	void atomicDestroy(FcAtomic* atomic);

	FcPattern* fontSetMatch(FcConfig* config, FcFontSet** sets, int nsets,
			FcPattern* p, FcResult* result);

	FcPattern* fontMatch(FcConfig* config, FcPattern* p, FcResult* result);

	FcPattern* fontRenderPrepare(FcConfig* config, FcPattern* pat, FcPattern* font);

	FcFontSet* fontSetSort(FcConfig* config, FcFontSet** sets, int nsets,
			FcPattern* p, Bool trim, FcCharSet** csp, FcResult* result);

	FcFontSet* fontSort(FcConfig* config, FcPattern* p, Bool trim,
			FcCharSet** csp, FcResult* result);

	void fontSetSortDestroy(FcFontSet* fs);

	FcMatrix* matrixCopy(const(FcMatrix)* mat);

	Bool matrixEqual(const(FcMatrix)* mat1, const(FcMatrix)* mat2);

	void matrixMultiply(FcMatrix* result, const(FcMatrix)* a, const(FcMatrix)* b);

	void matrixRotate(FcMatrix* m, double c, double s);

	void matrixScale(FcMatrix* m, double sx, double sy);

	void matrixShear(FcMatrix* m, double sh, double sv);

	Bool nameRegisterObjectTypes(const(FcObjectType)* types, int ntype);

	Bool nameUnregisterObjectTypes(const(FcObjectType)* types, int ntype);

	const(FcObjectType)* nameGetObjectType(const(char)* object);

	Bool nameRegisterConstants(const(FcConstant)* consts, int nconsts);

	Bool nameUnregisterConstants(const(FcConstant)* consts, int nconsts);

	const(FcConstant)* nameGetConstant(const(Char8)* string);

	Bool nameConstant(const(Char8)* string, int* result);

	FcPattern* nameParse(const(Char8)* name);

	Char8* nameUnparse(FcPattern* pat);

	FcPattern* patternCreate();

	FcPattern* patternDuplicate(const(FcPattern)* p);

	void patternReference(FcPattern* p);

	FcPattern* patternFilter(FcPattern* p, const(FcObjectSet)* os);

	void valueDestroy(FcValue v);

	Bool valueEqual(FcValue va, FcValue vb);

	FcValue valueSave(FcValue v);

	void patternDestroy(FcPattern* p);

	int patternObjectCount(const(FcPattern)* pat);

	Bool patternEqual(const(FcPattern)* pa, const(FcPattern)* pb);

	Bool patternEqualSubset(const(FcPattern)* pa, const(FcPattern)* pb, const(FcObjectSet)* os);

	Char32 patternHash(const(FcPattern)* p);

	Bool patternAdd(FcPattern* p, const(char)* object, FcValue value, Bool append);

	Bool patternAddWeak(FcPattern* p, const(char)* object, FcValue value, Bool append);

	FcResult patternGet(const(FcPattern)* p, const(char)* object, int id, FcValue* v);

	FcResult patternGetWithBinding(const(FcPattern)* p, const(char)* object,
			int id, FcValue* v, FcValueBinding* b);

	Bool patternDel(FcPattern* p, const(char)* object);

	Bool patternRemove(FcPattern* p, const(char)* object, int id);

	Bool patternAddInteger(FcPattern* p, const(char)* object, int i);

	Bool patternAddDouble(FcPattern* p, const(char)* object, double d);

	Bool patternAddString(FcPattern* p, const(char)* object, const(Char8)* s);

	Bool patternAddMatrix(FcPattern* p, const(char)* object, const(FcMatrix)* s);

	Bool patternAddCharSet(FcPattern* p, const(char)* object, const(FcCharSet)* c);

	Bool patternAddBool(FcPattern* p, const(char)* object, Bool b);

	Bool patternAddLangSet(FcPattern* p, const(char)* object, const(FcLangSet)* ls);

	Bool patternAddRange(FcPattern* p, const(char)* object, const(FcRange)* r);

	FcResult patternGetInteger(const(FcPattern)* p, const(char)* object, int n, int* i);

	FcResult patternGetDouble(const(FcPattern)* p, const(char)* object, int n, double* d);

	FcResult patternGetString(const(FcPattern)* p, const(char)* object, int n, Char8** s);

	FcResult patternGetMatrix(const(FcPattern)* p, const(char)* object, int n, FcMatrix** s);

	FcResult patternGetCharSet(const(FcPattern)* p, const(char)* object, int n, FcCharSet** c);

	FcResult patternGetBool(const(FcPattern)* p, const(char)* object, int n, Bool* b);

	FcResult patternGetLangSet(const(FcPattern)* p, const(char)* object, int n, FcLangSet** ls);

	FcResult patternGetRange(const(FcPattern)* p, const(char)* object, int id, FcRange** r);

	FcPattern* patternVaBuild(FcPattern* p, va_list va);

	// FcPattern* patternBuild(FcPattern* p, ...);

	Char8* patternFormat(FcPattern* pat, const(Char8)* format);

	FcRange* rangeCreateDouble(double begin, double end);

	FcRange* rangeCreateInteger(Char32 begin, Char32 end);

	void rangeDestroy(FcRange* range);

	FcRange* rangeCopy(const(FcRange)* r);

	Bool rangeGetDouble(const(FcRange)* range, double* begin, double* end);

	void patternIterStart(const(FcPattern)* pat, FcPatternIter* iter);

	Bool patternIterNext(const(FcPattern)* pat, FcPatternIter* iter);

	Bool patternIterEqual(const(FcPattern)* p1, FcPatternIter* i1,
			const(FcPattern)* p2, FcPatternIter* i2);

	Bool patternFindIter(const(FcPattern)* pat, FcPatternIter* iter, const(char)* object);

	Bool patternIterIsValid(const(FcPattern)* pat, FcPatternIter* iter);

	const(char)* patternIterGetObject(const(FcPattern)* pat, FcPatternIter* iter);

	int patternIterValueCount(const(FcPattern)* pat, FcPatternIter* iter);

	FcResult patternIterGetValue(const(FcPattern)* pat, FcPatternIter* iter,
			int id, FcValue* v, FcValueBinding* b);

	int weightFromOpenType(int ot_weight);

	double weightFromOpenTypeDouble(double ot_weight);

	int weightToOpenType(int fc_weight);

	double weightToOpenTypeDouble(double fc_weight);

	Char8* strCopy(const(Char8)* s);

	Char8* strCopyFilename(const(Char8)* s);

	Char8* strPlus(const(Char8)* s1, const(Char8)* s2);

	void strFree(Char8* s);

	static extern (D) auto isUpper(T)(auto ref T c) {
		import std.conv : octal;

		return (octal!101 <= c && c <= octal!132);
	}

	static extern (D) auto isLower(T)(auto ref T c) {
		import std.conv : octal;

		return (octal!141 <= c && c <= octal!172);
	}

	static extern (D) auto toLower(T)(auto ref T c) {
		import std.conv : octal;

		return isUpper(c) ? c - octal!101 + octal!141 : c;
	}

	Char8* strDowncase(const(Char8)* s);

	int strCmpIgnoreCase(const(Char8)* s1, const(Char8)* s2);

	int strCmp(const(Char8)* s1, const(Char8)* s2);

	const(Char8)* strStrIgnoreCase(const(Char8)* s1, const(Char8)* s2);

	const(Char8)* strStr(const(Char8)* s1, const(Char8)* s2);

	int utf8ToUcs4(const(Char8)* src_orig, Char32* dst, int len);

	Bool utf8Len(const(Char8)* string, int len, int* nchar, int* wchar_);

	enum FC_UTF8_MAX_LEN = 6;

	int ucs4ToUtf8(Char32 ucs4, ref Char8[FC_UTF8_MAX_LEN] dest);

	int utf16ToUcs4(const(Char8)* src_orig, FcEndian endian, Char32* dst, int len);

	Bool utf16Len(const(Char8)* string, FcEndian endian, int len, int* nchar, int* wchar_);

	// Char8* strBuildFilename(const(Char8)* path, ...);

	Char8* strDirname(const(Char8)* file);

	Char8* strBasename(const(Char8)* file);

	FcStrSet* strSetCreate();

	Bool strSetMember(FcStrSet* set, const(Char8)* s);

	Bool strSetEqual(FcStrSet* sa, FcStrSet* sb);

	Bool strSetAdd(FcStrSet* set, const(Char8)* s);

	Bool strSetAddFilename(FcStrSet* set, const(Char8)* s);

	Bool strSetDel(FcStrSet* set, const(Char8)* s);

	void strSetDestroy(FcStrSet* set);

	FcStrList* strListCreate(FcStrSet* set);

	void strListFirst(FcStrList* list);

	Char8* strListNext(FcStrList* list);

	void strListDone(FcStrList* list);

	Bool configParseAndLoad(FcConfig* config, const(Char8)* file, Bool complain);

	Bool configParseAndLoadFromMemory(FcConfig* config, const(Char8)* buffer, Bool complain);
}
