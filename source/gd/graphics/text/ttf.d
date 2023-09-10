// TODO: replace with custom TrueType decoder
module gd.graphics.text.ttf;

int STBTT_ifloor(T)(in T x) pure {
	pragma(inline, true);
	import std.math : floor;
	return cast(int) floor(x);
}
int STBTT_iceil(T)(in T x) pure {
	pragma(inline, true);
	import std.math : ceil;
	return cast(int) ceil(x);
}
T STBTT_sqrt(T)(in T x) pure {
	pragma(inline, true);
	import std.math : sqrt;
	return sqrt(x);
}
T STBTT_fabs(T)(in T x) pure {
	pragma(inline, true);
	import std.math : abs;
	return abs(x);
}
void* STBTT_malloc(uint size, const(void)* uptr) {
	pragma(inline, true);
	import core.stdc.stdlib : malloc;
	return malloc(size);
}
uint STBTT_strlen(const(void)* p) {
	pragma(inline, true);
	import core.stdc.string : strlen;
	return (p !is null ? cast(uint) strlen(cast(const(char)*) p) : 0);
}
void STBTT_memcpy(void* d, const(void)* s, uint count) {
	pragma(inline, true);
	import core.stdc.string : memcpy;
	if (count > 0)
		memcpy(d, s, count);
}
void STBTT_memset(void* d, uint v, uint count) {
	pragma(inline, true);
	import core.stdc.string : memset;
	if (count > 0)
		memset(d, v, count);
}
struct stbtt__buf {
	ubyte* data;
	int cursor;
	int size;
}
struct stbtt_fontinfo {
	void* userdata;
	ubyte* data;
	int fontstart;
	int numGlyphs;
	int loca, head, glyf, hhea, hmtx, kern, gpos;
	int index_map;
	int indexToLocFormat;
	stbtt__buf cff;
	stbtt__buf charstrings;
	stbtt__buf gsubrs;
	stbtt__buf subrs;
	stbtt__buf fontdicts;
	stbtt__buf fdselect;
}
enum {
	STBTT_vmove = 1,
	STBTT_vline,
	STBTT_vcurve,
	STBTT_vcubic
}
alias stbtt_vertex_type = short;
struct stbtt_vertex {
	stbtt_vertex_type x, y, cx, cy, cx1, cy1;
	ubyte type, padding;
}
enum {
	STBTT_MACSTYLE_DONTCARE = 0,
	STBTT_MACSTYLE_BOLD = 1,
	STBTT_MACSTYLE_ITALIC = 2,
	STBTT_MACSTYLE_UNDERSCORE = 4,
	STBTT_MACSTYLE_NONE = 8,
}
enum {
	STBTT_PLATFORM_ID_UNICODE = 0,
	STBTT_PLATFORM_ID_MAC = 1,
	STBTT_PLATFORM_ID_ISO = 2,
	STBTT_PLATFORM_ID_MICROSOFT = 3
}
enum {
	STBTT_UNICODE_EID_UNICODE_1_0 = 0,
	STBTT_UNICODE_EID_UNICODE_1_1 = 1,
	STBTT_UNICODE_EID_ISO_10646 = 2,
	STBTT_UNICODE_EID_UNICODE_2_0_BMP = 3,
	STBTT_UNICODE_EID_UNICODE_2_0_FULL = 4
}
enum {
	STBTT_MS_EID_SYMBOL = 0,
	STBTT_MS_EID_UNICODE_BMP = 1,
	STBTT_MS_EID_SHIFTJIS = 2,
	STBTT_MS_EID_UNICODE_FULL = 10
}
enum {
	STBTT_MAC_EID_ROMAN = 0,
	STBTT_MAC_EID_ARABIC = 4,
	STBTT_MAC_EID_JAPANESE = 1,
	STBTT_MAC_EID_HEBREW = 5,
	STBTT_MAC_EID_CHINESE_TRAD = 2,
	STBTT_MAC_EID_GREEK = 6,
	STBTT_MAC_EID_KOREAN = 3,
	STBTT_MAC_EID_RUSSIAN = 7
}
enum {
	STBTT_MS_LANG_ENGLISH = 0x0409,
	STBTT_MS_LANG_ITALIAN = 0x0410,
	STBTT_MS_LANG_CHINESE = 0x0804,
	STBTT_MS_LANG_JAPANESE = 0x0411,
	STBTT_MS_LANG_DUTCH = 0x0413,
	STBTT_MS_LANG_KOREAN = 0x0412,
	STBTT_MS_LANG_FRENCH = 0x040c,
	STBTT_MS_LANG_RUSSIAN = 0x0419,
	STBTT_MS_LANG_GERMAN = 0x0407,
	STBTT_MS_LANG_SPANISH = 0x0409,
	STBTT_MS_LANG_HEBREW = 0x040d,
	STBTT_MS_LANG_SWEDISH = 0x041D
}
enum {
	STBTT_MAC_LANG_ENGLISH = 0,
	STBTT_MAC_LANG_JAPANESE = 11,
	STBTT_MAC_LANG_ARABIC = 12,
	STBTT_MAC_LANG_KOREAN = 23,
	STBTT_MAC_LANG_DUTCH = 4,
	STBTT_MAC_LANG_RUSSIAN = 32,
	STBTT_MAC_LANG_FRENCH = 1,
	STBTT_MAC_LANG_SPANISH = 6,
	STBTT_MAC_LANG_GERMAN = 2,
	STBTT_MAC_LANG_SWEDISH = 5,
	STBTT_MAC_LANG_HEBREW = 10,
	STBTT_MAC_LANG_CHINESE_SIMPLIFIED = 33,
	STBTT_MAC_LANG_ITALIAN = 3,
	STBTT_MAC_LANG_CHINESE_TRAD = 19
}
private:
enum STBTT_MAX_OVERSAMPLE = 8;
static assert(STBTT_MAX_OVERSAMPLE > 0 && STBTT_MAX_OVERSAMPLE <= 255, "STBTT_MAX_OVERSAMPLE cannot be > 255");
ubyte stbtt__buf_get8(stbtt__buf* b) {
	if (b.cursor >= b.size)
		return 0;
	return b.data[b.cursor++];
}
ubyte stbtt__buf_peek8(stbtt__buf* b) {
	if (b.cursor >= b.size)
		return 0;
	return b.data[b.cursor];
}
void stbtt__buf_seek(stbtt__buf* b, int o) {
	assert(!(o > b.size || o < 0));
	b.cursor = (o > b.size || o < 0) ? b.size : o;
}
void stbtt__buf_skip(stbtt__buf* b, int o) {
	stbtt__buf_seek(b, b.cursor + o);
}
uint stbtt__buf_get(stbtt__buf* b, int n) {
	uint v = 0;
	int i;
	assert(n >= 1 && n <= 4);
	for (i = 0; i < n; i++)
		v = (v << 8) | stbtt__buf_get8(b);
	return v;
}
stbtt__buf stbtt__new_buf(const(void)* p, size_t size) {
	stbtt__buf r;
	assert(size < 0x40000000);
	r.data = cast(ubyte*) p;
	r.size = cast(int) size;
	r.cursor = 0;
	return r;
}
ushort stbtt__buf_get16(stbtt__buf* b) {
	pragma(inline, true);
	return cast(ushort) stbtt__buf_get(b, 2);
}
uint stbtt__buf_get32(stbtt__buf* b) {
	pragma(inline, true);
	return cast(uint) stbtt__buf_get(b, 4);
}
stbtt__buf stbtt__buf_range(const(stbtt__buf)* b, int o, int s) {
	stbtt__buf r = stbtt__new_buf(null, 0);
	if (o < 0 || s < 0 || o > b.size || s > b.size - o)
		return r;
	r.data = cast(ubyte*) b.data + o;
	r.size = s;
	return r;
}
stbtt__buf stbtt__cff_get_index(stbtt__buf* b) {
	int count, start, offsize;
	start = b.cursor;
	count = stbtt__buf_get16(b);
	if (count) {
		offsize = stbtt__buf_get8(b);
		assert(offsize >= 1 && offsize <= 4);
		stbtt__buf_skip(b, offsize * count);
		stbtt__buf_skip(b, stbtt__buf_get(b, offsize) - 1);
	}
	return stbtt__buf_range(b, start, b.cursor - start);
}
uint stbtt__cff_int(stbtt__buf* b) {
	int b0 = stbtt__buf_get8(b);
	if (b0 >= 32 && b0 <= 246)
		return b0 - 139;
	else if (b0 >= 247 && b0 <= 250)
		return (b0 - 247) * 256 + stbtt__buf_get8(b) + 108;
	else if (b0 >= 251 && b0 <= 254)
		return -(b0 - 251) * 256 - stbtt__buf_get8(b) - 108;
	else if (b0 == 28)
		return stbtt__buf_get16(b);
	else if (b0 == 29)
		return stbtt__buf_get32(b);
	assert(0);
}
void stbtt__cff_skip_operand(stbtt__buf* b) {
	int v, b0 = stbtt__buf_peek8(b);
	assert(b0 >= 28);
	if (b0 == 30) {
		stbtt__buf_skip(b, 1);
		while (b.cursor < b.size) {
			v = stbtt__buf_get8(b);
			if ((v & 0xF) == 0xF || (v >> 4) == 0xF)
				break;
		}
	}
	else {
		stbtt__cff_int(b);
	}
}
stbtt__buf stbtt__dict_get(stbtt__buf* b, int key) {
	stbtt__buf_seek(b, 0);
	while (b.cursor < b.size) {
		int start = b.cursor, end, op;
		while (stbtt__buf_peek8(b) >= 28)
			stbtt__cff_skip_operand(b);
		end = b.cursor;
		op = stbtt__buf_get8(b);
		if (op == 12)
			op = stbtt__buf_get8(b) | 0x100;
		if (op == key)
			return stbtt__buf_range(b, start, end - start);
	}
	return stbtt__buf_range(b, 0, 0);
}
void stbtt__dict_get_ints(stbtt__buf* b, int key, int outcount, uint* outstb) {
	int i;
	stbtt__buf operands = stbtt__dict_get(b, key);
	for (i = 0; i < outcount && operands.cursor < operands.size; i++)
		outstb[i] = stbtt__cff_int(&operands);
}
int stbtt__cff_index_count(stbtt__buf* b) {
	stbtt__buf_seek(b, 0);
	return stbtt__buf_get16(b);
}
stbtt__buf stbtt__cff_index_get(stbtt__buf b, int i) {
	int count, offsize, start, end;
	stbtt__buf_seek(&b, 0);
	count = stbtt__buf_get16(&b);
	offsize = stbtt__buf_get8(&b);
	assert(i >= 0 && i < count);
	assert(offsize >= 1 && offsize <= 4);
	stbtt__buf_skip(&b, i * offsize);
	start = stbtt__buf_get(&b, offsize);
	end = stbtt__buf_get(&b, offsize);
	return stbtt__buf_range(&b, 2 + (count + 1) * offsize + start, end - start);
}
ubyte ttBYTE(const(void)* p) pure {
	pragma(inline, true);
	return *cast(const(ubyte)*) p;
}
byte ttCHAR(const(void)* p) pure {
	pragma(inline, true);
	return *cast(const(byte)*) p;
}
ushort ttUSHORT(const(ubyte)* p) {
	return p[0] * 256 + p[1];
}
short ttSHORT(const(ubyte)* p) {
	return cast(short)(p[0] * 256 + p[1]);
}
uint ttULONG(const(ubyte)* p) {
	return (p[0] << 24) + (p[1] << 16) + (p[2] << 8) + p[3];
}
int ttLONG(const(ubyte)* p) {
	return (p[0] << 24) + (p[1] << 16) + (p[2] << 8) + p[3];
}
bool stbtt_tag4(const(void)* p, ubyte c0, ubyte c1, ubyte c2, ubyte c3) pure {
	return (cast(const(ubyte)*) p)[0] == c0 &&
		(cast(const(ubyte)*) p)[1] == c1 &&
		(cast(const(ubyte)*) p)[2] == c2 &&
		(cast(const(ubyte)*) p)[3] == c3;
}
bool stbtt_tag(const(void)* p, const(void)* str) {
	import core.stdc.string : memcmp;
	return (memcmp(p, str, 4) == 0);
}
int stbtt__isfont(ubyte* font) {
	if (stbtt_tag4(font, '1', 0, 0, 0))
		return 1;
	if (stbtt_tag(font, "typ1".ptr))
		return 1;
	if (stbtt_tag(font, "OTTO".ptr))
		return 1;
	if (stbtt_tag4(font, 0, 1, 0, 0))
		return 1;
	if (stbtt_tag(font, "true".ptr))
		return 1;
	return 0;
}
uint stbtt__find_table(ubyte* data, uint fontstart, const(char)* tag) {
	int num_tables = ttUSHORT(data + fontstart + 4);
	uint tabledir = fontstart + 12;
	int i;
	for (i = 0; i < num_tables; ++i) {
		uint loc = tabledir + 16 * i;
		if (stbtt_tag(data + loc + 0, tag))
			return ttULONG(data + loc + 8);
	}
	return 0;
}
public int stbtt_GetFontOffsetForIndex(ubyte* font_collection, int index) {
	if (stbtt__isfont(font_collection))
		return index == 0 ? 0 : -1;
	if (stbtt_tag(font_collection, "ttcf".ptr)) {
		if (ttULONG(font_collection + 4) == 0x00010000 || ttULONG(font_collection + 4) == 0x00020000) {
			int n = ttLONG(font_collection + 8);
			if (index >= n)
				return -1;
			return ttULONG(font_collection + 12 + index * 4);
		}
	}
	return -1;
}
public int stbtt_GetNumberOfFonts(ubyte* font_collection) {
	if (stbtt__isfont(font_collection))
		return 1;
	if (stbtt_tag(font_collection, "ttcf".ptr)) {
		if (ttULONG(font_collection + 4) == 0x00010000 || ttULONG(font_collection + 4) == 0x00020000) {
			return ttLONG(font_collection + 8);
		}
	}
	return 0;
}
stbtt__buf stbtt__get_subrs(stbtt__buf cff, stbtt__buf fontdict) {
	uint subrsoff = 0;
	uint[2] private_loc = 0;
	stbtt__buf pdict;
	stbtt__dict_get_ints(&fontdict, 18, 2, private_loc.ptr);
	if (!private_loc[1] || !private_loc[0])
		return stbtt__new_buf(null, 0);
	pdict = stbtt__buf_range(&cff, private_loc[1], private_loc[0]);
	stbtt__dict_get_ints(&pdict, 19, 1, &subrsoff);
	if (!subrsoff)
		return stbtt__new_buf(null, 0);
	stbtt__buf_seek(&cff, private_loc[1] + subrsoff);
	return stbtt__cff_get_index(&cff);
}
public int stbtt_InitFont(stbtt_fontinfo* info, ubyte* data, int fontstart) {
	uint cmap, t;
	int i, numTables;
	info.data = data;
	info.fontstart = fontstart;
	info.cff = stbtt__new_buf(null, 0);
	cmap = stbtt__find_table(data, fontstart, "cmap");
	info.loca = stbtt__find_table(data, fontstart, "loca");
	info.head = stbtt__find_table(data, fontstart, "head");
	info.glyf = stbtt__find_table(data, fontstart, "glyf");
	info.hhea = stbtt__find_table(data, fontstart, "hhea");
	info.hmtx = stbtt__find_table(data, fontstart, "hmtx");
	info.kern = stbtt__find_table(data, fontstart, "kern");
	info.gpos = stbtt__find_table(data, fontstart, "GPOS");
	if (!cmap || !info.head || !info.hhea || !info.hmtx)
		return 0;
	if (info.glyf) {
		if (!info.loca)
			return 0;
	}
	else {
		stbtt__buf b, topdict, topdictidx;
		uint cstype = 2, charstrings = 0, fdarrayoff = 0, fdselectoff = 0;
		uint cff;
		cff = stbtt__find_table(data, fontstart, "CFF ");
		if (!cff)
			return 0;
		info.fontdicts = stbtt__new_buf(null, 0);
		info.fdselect = stbtt__new_buf(null, 0);
		info.cff = stbtt__new_buf(data + cff, 512 * 1024 * 1024);
		b = info.cff;
		stbtt__buf_skip(&b, 2);
		stbtt__buf_seek(&b, stbtt__buf_get8(&b));
		stbtt__cff_get_index(&b);
		topdictidx = stbtt__cff_get_index(&b);
		topdict = stbtt__cff_index_get(topdictidx, 0);
		stbtt__cff_get_index(&b);
		info.gsubrs = stbtt__cff_get_index(&b);
		stbtt__dict_get_ints(&topdict, 17, 1, &charstrings);
		stbtt__dict_get_ints(&topdict, 0x100 | 6, 1, &cstype);
		stbtt__dict_get_ints(&topdict, 0x100 | 36, 1, &fdarrayoff);
		stbtt__dict_get_ints(&topdict, 0x100 | 37, 1, &fdselectoff);
		info.subrs = stbtt__get_subrs(b, topdict);
		if (cstype != 2)
			return 0;
		if (charstrings == 0)
			return 0;
		if (fdarrayoff) {
			if (!fdselectoff)
				return 0;
			stbtt__buf_seek(&b, fdarrayoff);
			info.fontdicts = stbtt__cff_get_index(&b);
			info.fdselect = stbtt__buf_range(&b, fdselectoff, b.size - fdselectoff);
		}
		stbtt__buf_seek(&b, charstrings);
		info.charstrings = stbtt__cff_get_index(&b);
	}
	t = stbtt__find_table(data, fontstart, "maxp");
	if (t)
		info.numGlyphs = ttUSHORT(data + t + 4);
	else
		info.numGlyphs = 0xffff;
	numTables = ttUSHORT(data + cmap + 2);
	info.index_map = 0;
	for (i = 0; i < numTables; ++i) {
		uint encoding_record = cmap + 4 + 8 * i;
		switch (ttUSHORT(data + encoding_record)) {
		case STBTT_PLATFORM_ID_MICROSOFT:
			switch (ttUSHORT(data + encoding_record + 2)) {
			case STBTT_MS_EID_UNICODE_BMP:
			case STBTT_MS_EID_UNICODE_FULL:
				info.index_map = cmap + ttULONG(data + encoding_record + 4);
				break;
			default:
			}
			break;
		case STBTT_PLATFORM_ID_UNICODE:
			info.index_map = cmap + ttULONG(data + encoding_record + 4);
			break;
		default:
		}
	}
	if (info.index_map == 0)
		return 0;
	info.indexToLocFormat = ttUSHORT(data + info.head + 50);
	return 1;
}
public int stbtt_FindGlyphIndex(const(stbtt_fontinfo)* info, int unicode_codepoint) {
	ubyte* data = cast(ubyte*) info.data;
	uint index_map = info.index_map;
	ushort format = ttUSHORT(data + index_map + 0);
	if (format == 0) {
		int bytes = ttUSHORT(data + index_map + 2);
		if (unicode_codepoint < bytes - 6)
			return ttBYTE(data + index_map + 6 + unicode_codepoint);
		return 0;
	}
	else if (format == 6) {
		uint first = ttUSHORT(data + index_map + 6);
		uint count = ttUSHORT(data + index_map + 8);
		if (cast(uint) unicode_codepoint >= first && cast(uint) unicode_codepoint < first + count)
			return ttUSHORT(data + index_map + 10 + (unicode_codepoint - first) * 2);
		return 0;
	}
	else if (format == 2) {
		assert(0);
	}
	else if (format == 4) {
		ushort segcount = ttUSHORT(data + index_map + 6) >> 1;
		ushort searchRange = ttUSHORT(data + index_map + 8) >> 1;
		ushort entrySelector = ttUSHORT(data + index_map + 10);
		ushort rangeShift = ttUSHORT(data + index_map + 12) >> 1;
		uint endCount = index_map + 14;
		uint search = endCount;
		if (unicode_codepoint > 0xffff)
			return 0;
		if (unicode_codepoint >= ttUSHORT(data + search + rangeShift * 2))
			search += rangeShift * 2;
		search -= 2;
		while (entrySelector) {
			ushort end;
			searchRange >>= 1;
			end = ttUSHORT(data + search + searchRange * 2);
			if (unicode_codepoint > end)
				search += searchRange * 2;
			--entrySelector;
		}
		search += 2;
		{
			ushort offset, start;
			ushort item = cast(ushort)((search - endCount) >> 1);
			assert(unicode_codepoint <= ttUSHORT(data + endCount + 2 * item));
			start = ttUSHORT(data + index_map + 14 + segcount * 2 + 2 + 2 * item);
			if (unicode_codepoint < start)
				return 0;
			offset = ttUSHORT(data + index_map + 14 + segcount * 6 + 2 + 2 * item);
			if (offset == 0)
				return cast(ushort)(unicode_codepoint + ttSHORT(data + index_map + 14 + segcount * 4 + 2 + 2 * item));
			return ttUSHORT(data + offset + (unicode_codepoint - start) * 2 + index_map + 14 + segcount * 6 + 2 + 2 * item);
		}
	}
	else if (format == 12 || format == 13) {
		uint ngroups = ttULONG(data + index_map + 12);
		int low, high;
		low = 0;
		high = cast(int) ngroups;
		while (low < high) {
			int mid = low + ((high - low) >> 1);
			uint start_char = ttULONG(data + index_map + 16 + mid * 12);
			uint end_char = ttULONG(data + index_map + 16 + mid * 12 + 4);
			if (cast(uint) unicode_codepoint < start_char)
				high = mid;
			else if (cast(uint) unicode_codepoint > end_char)
				low = mid + 1;
			else {
				uint start_glyph = ttULONG(data + index_map + 16 + mid * 12 + 8);
				if (format == 12)
					return start_glyph + unicode_codepoint - start_char;
				else
					return start_glyph;
			}
		}
		return 0;
	}
	import std.conv : to;
	assert(0, "unknown format " ~ format.to!string);
}
public int stbtt_GetCodepointShape(stbtt_fontinfo* info, int unicode_codepoint, stbtt_vertex** vertices) {
	return stbtt_GetGlyphShape(info, stbtt_FindGlyphIndex(info, unicode_codepoint), vertices);
}
void stbtt_setvertex(stbtt_vertex* v, ubyte type, int x, int y, int cx, int cy) {
	v.type = type;
	v.x = cast(short) x;
	v.y = cast(short) y;
	v.cx = cast(short) cx;
	v.cy = cast(short) cy;
}
int stbtt__GetGlyfOffset(const(stbtt_fontinfo)* info, int glyph_index) {
	int g1, g2;
	assert(!info.cff.size);
	if (glyph_index >= info.numGlyphs)
		return -1;
	if (info.indexToLocFormat >= 2)
		return -1;
	if (info.indexToLocFormat == 0) {
		g1 = info.glyf + ttUSHORT(info.data + info.loca + glyph_index * 2) * 2;
		g2 = info.glyf + ttUSHORT(info.data + info.loca + glyph_index * 2 + 2) * 2;
	}
	else {
		g1 = info.glyf + ttULONG(info.data + info.loca + glyph_index * 4);
		g2 = info.glyf + ttULONG(info.data + info.loca + glyph_index * 4 + 4);
	}
	return g1 == g2 ? -1 : g1;
}
public int stbtt_GetGlyphBox(stbtt_fontinfo* info, int glyph_index, int* x0, int* y0, int* x1, int* y1) {
	if (info.cff.size) {
		stbtt__GetGlyphInfoT2(info, glyph_index, x0, y0, x1, y1);
	}
	else {
		int g = stbtt__GetGlyfOffset(info, glyph_index);
		if (g < 0)
			return 0;
		if (x0)
			*x0 = ttSHORT(info.data + g + 2);
		if (y0)
			*y0 = ttSHORT(info.data + g + 4);
		if (x1)
			*x1 = ttSHORT(info.data + g + 6);
		if (y1)
			*y1 = ttSHORT(info.data + g + 8);
	}
	return 1;
}
public int stbtt_GetCodepointBox(stbtt_fontinfo* info, int codepoint, int* x0, int* y0, int* x1, int* y1) {
	return stbtt_GetGlyphBox(info, stbtt_FindGlyphIndex(info, codepoint), x0, y0, x1, y1);
}
public int stbtt_IsGlyphEmpty(stbtt_fontinfo* info, int glyph_index) {
	short numberOfContours;
	int g;
	if (info.cff.size)
		return stbtt__GetGlyphInfoT2(info, glyph_index, null, null, null, null) == 0;
	g = stbtt__GetGlyfOffset(info, glyph_index);
	if (g < 0)
		return 1;
	numberOfContours = ttSHORT(info.data + g);
	return numberOfContours == 0;
}
int stbtt__close_shape(stbtt_vertex* vertices, int num_vertices, int was_off, int start_off,
	int sx, int sy, int scx, int scy, int cx, int cy) {
	if (start_off) {
		if (was_off)
			stbtt_setvertex(&vertices[num_vertices++], STBTT_vcurve, (cx + scx) >> 1, (cy + scy) >> 1, cx, cy);
		stbtt_setvertex(&vertices[num_vertices++], STBTT_vcurve, sx, sy, scx, scy);
	}
	else {
		if (was_off)
			stbtt_setvertex(&vertices[num_vertices++], STBTT_vcurve, sx, sy, cx, cy);
		else
			stbtt_setvertex(&vertices[num_vertices++], STBTT_vline, sx, sy, 0, 0);
	}
	return num_vertices;
}
int stbtt__GetGlyphShapeTT(stbtt_fontinfo* info, int glyph_index, stbtt_vertex** pvertices) {
	short numberOfContours;
	ubyte* endPtsOfContours;
	ubyte* data = cast(ubyte*) info.data;
	stbtt_vertex* vertices = null;
	int num_vertices = 0;
	int g = stbtt__GetGlyfOffset(info, glyph_index);
	*pvertices = null;
	if (g < 0)
		return 0;
	numberOfContours = ttSHORT(data + g);
	if (numberOfContours > 0) {
		ubyte flags = 0, flagcount;
		int ins, i, j = 0, m, n, next_move, was_off = 0, off, start_off = 0;
		int x, y, cx, cy, sx, sy, scx, scy;
		ubyte* points;
		endPtsOfContours = (data + g + 10);
		ins = ttUSHORT(data + g + 10 + numberOfContours * 2);
		points = data + g + 10 + numberOfContours * 2 + 2 + ins;
		n = 1 + ttUSHORT(endPtsOfContours + numberOfContours * 2 - 2);
		m = n + 2 * numberOfContours;
		vertices = cast(stbtt_vertex*) STBTT_malloc(m * cast(uint) vertices[0].sizeof, info.userdata);
		if (vertices is null)
			return 0;
		next_move = 0;
		flagcount = 0;
		off = m - n;
		for (i = 0; i < n; ++i) {
			if (flagcount == 0) {
				flags = *points++;
				if (flags & 8)
					flagcount = *points++;
			}
			else
				--flagcount;
			vertices[off + i].type = flags;
		}
		x = 0;
		for (i = 0; i < n; ++i) {
			flags = vertices[off + i].type;
			if (flags & 2) {
				short dx = *points++;
				x += (flags & 16) ? cast(int) dx : -cast(int) dx;
			}
			else {
				if (!(flags & 16)) {
					x = x + cast(short)(points[0] * 256 + points[1]);
					points += 2;
				}
			}
			vertices[off + i].x = cast(short) x;
		}
		y = 0;
		for (i = 0; i < n; ++i) {
			flags = vertices[off + i].type;
			if (flags & 4) {
				short dy = *points++;
				y += (flags & 32) ? cast(int) dy : -cast(int) dy;
			}
			else {
				if (!(flags & 32)) {
					y = y + cast(short)(points[0] * 256 + points[1]);
					points += 2;
				}
			}
			vertices[off + i].y = cast(short) y;
		}
		num_vertices = 0;
		sx = sy = cx = cy = scx = scy = 0;
		for (i = 0; i < n; ++i) {
			flags = vertices[off + i].type;
			x = cast(short) vertices[off + i].x;
			y = cast(short) vertices[off + i].y;
			if (next_move == i) {
				if (i != 0)
					num_vertices = stbtt__close_shape(vertices, num_vertices, was_off, start_off, sx, sy, scx, scy, cx, cy);
				start_off = !(flags & 1);
				if (start_off) {
					scx = x;
					scy = y;
					if (!(vertices[off + i + 1].type & 1)) {
						sx = (x + cast(int) vertices[off + i + 1].x) >> 1;
						sy = (y + cast(int) vertices[off + i + 1].y) >> 1;
					}
					else {
						sx = cast(int) vertices[off + i + 1].x;
						sy = cast(int) vertices[off + i + 1].y;
						++i;
					}
				}
				else {
					sx = x;
					sy = y;
				}
				stbtt_setvertex(&vertices[num_vertices++], STBTT_vmove, sx, sy, 0, 0);
				was_off = 0;
				next_move = 1 + ttUSHORT(endPtsOfContours + j * 2);
				++j;
			}
			else {
				if (!(flags & 1)) {
					if (was_off)
						stbtt_setvertex(&vertices[num_vertices++], STBTT_vcurve, (cx + x) >> 1, (cy + y) >> 1, cx, cy);
					cx = x;
					cy = y;
					was_off = 1;
				}
				else {
					if (was_off)
						stbtt_setvertex(&vertices[num_vertices++], STBTT_vcurve, x, y, cx, cy);
					else
						stbtt_setvertex(&vertices[num_vertices++], STBTT_vline, x, y, 0, 0);
					was_off = 0;
				}
			}
		}
		num_vertices = stbtt__close_shape(vertices, num_vertices, was_off, start_off, sx, sy, scx, scy, cx, cy);
	}
	else if (numberOfContours == -1) {
		int more = 1;
		ubyte* comp = data + g + 10;
		num_vertices = 0;
		vertices = null;
		while (more) {
			ushort flags, gidx;
			int comp_num_verts = 0, i;
			stbtt_vertex* comp_verts = null, tmp = null;
			float[6] mtx = [1, 0, 0, 1, 0, 0];
			float m, n;
			flags = ttSHORT(comp);
			comp += 2;
			gidx = ttSHORT(comp);
			comp += 2;
			if (flags & 2) {
				if (flags & 1) {
					mtx[4] = ttSHORT(comp);
					comp += 2;
					mtx[5] = ttSHORT(comp);
					comp += 2;
				}
				else {
					mtx[4] = ttCHAR(comp);
					comp += 1;
					mtx[5] = ttCHAR(comp);
					comp += 1;
				}
			}
			else {
				assert(0);
			}
			if (flags & (1 << 3)) {
				mtx[0] = mtx[3] = ttSHORT(comp) / 16_384f;
				comp += 2;
				mtx[1] = mtx[2] = 0;
			}
			else if (flags & (1 << 6)) {
				mtx[0] = ttSHORT(comp) / 16_384f;
				comp += 2;
				mtx[1] = mtx[2] = 0;
				mtx[3] = ttSHORT(comp) / 16_384f;
				comp += 2;
			}
			else if (flags & (1 << 7)) {
				mtx[0] = ttSHORT(comp) / 16_384f;
				comp += 2;
				mtx[1] = ttSHORT(comp) / 16_384f;
				comp += 2;
				mtx[2] = ttSHORT(comp) / 16_384f;
				comp += 2;
				mtx[3] = ttSHORT(comp) / 16_384f;
				comp += 2;
			}
			m = cast(float) STBTT_sqrt(mtx[0] * mtx[0] + mtx[1] * mtx[1]);
			n = cast(float) STBTT_sqrt(mtx[2] * mtx[2] + mtx[3] * mtx[3]);
			comp_num_verts = stbtt_GetGlyphShape(info, gidx, &comp_verts);
			if (comp_num_verts > 0) {
				for (i = 0; i < comp_num_verts; ++i) {
					stbtt_vertex* v = &comp_verts[i];
					stbtt_vertex_type x, y;
					x = v.x;
					y = v.y;
					v.x = cast(stbtt_vertex_type)(m * (mtx[0] * x + mtx[2] * y + mtx[4]));
					v.y = cast(stbtt_vertex_type)(n * (mtx[1] * x + mtx[3] * y + mtx[5]));
					x = v.cx;
					y = v.cy;
					v.cx = cast(stbtt_vertex_type)(m * (mtx[0] * x + mtx[2] * y + mtx[4]));
					v.cy = cast(stbtt_vertex_type)(n * (mtx[1] * x + mtx[3] * y + mtx[5]));
				}
				tmp = cast(stbtt_vertex*) STBTT_malloc((num_vertices + comp_num_verts) * cast(uint) stbtt_vertex.sizeof, info
						.userdata);
				if (!tmp) {
					return 0;
				}
				if (num_vertices > 0)
					STBTT_memcpy(tmp, vertices, num_vertices * cast(uint) stbtt_vertex.sizeof);
				STBTT_memcpy(tmp + num_vertices, comp_verts, comp_num_verts * cast(uint) stbtt_vertex.sizeof);
				vertices = tmp;
				num_vertices += comp_num_verts;
			}
			more = flags & (1 << 5);
		}
	}
	else if (numberOfContours < 0) {
		assert(0);
	}
	else {
	}
	*pvertices = vertices;
	return num_vertices;
}
struct stbtt__csctx {
	int bounds;
	int started;
	float first_x, first_y;
	float x, y;
	int min_x, max_x, min_y, max_y;
	stbtt_vertex* pvertices;
	int num_vertices;
}
void stbtt__track_vertex(stbtt__csctx* c, int x, int y) {
	if (x > c.max_x || !c.started)
		c.max_x = x;
	if (y > c.max_y || !c.started)
		c.max_y = y;
	if (x < c.min_x || !c.started)
		c.min_x = x;
	if (y < c.min_y || !c.started)
		c.min_y = y;
	c.started = 1;
}
void stbtt__csctx_v(stbtt__csctx* c, ubyte type, int x, int y, int cx, int cy, int cx1, int cy1) {
	if (c.bounds) {
		stbtt__track_vertex(c, x, y);
		if (type == STBTT_vcubic) {
			stbtt__track_vertex(c, cx, cy);
			stbtt__track_vertex(c, cx1, cy1);
		}
	}
	else {
		stbtt_setvertex(&c.pvertices[c.num_vertices], type, x, y, cx, cy);
		c.pvertices[c.num_vertices].cx1 = cast(short) cx1;
		c.pvertices[c.num_vertices].cy1 = cast(short) cy1;
	}
	c.num_vertices++;
}
void stbtt__csctx_close_shape(stbtt__csctx* ctx) {
	if (ctx.first_x != ctx.x || ctx.first_y != ctx.y)
		stbtt__csctx_v(ctx, STBTT_vline, cast(int) ctx.first_x, cast(int) ctx.first_y, 0, 0, 0, 0);
}
void stbtt__csctx_rmove_to(stbtt__csctx* ctx, float dx, float dy) {
	stbtt__csctx_close_shape(ctx);
	ctx.first_x = ctx.x = ctx.x + dx;
	ctx.first_y = ctx.y = ctx.y + dy;
	stbtt__csctx_v(ctx, STBTT_vmove, cast(int) ctx.x, cast(int) ctx.y, 0, 0, 0, 0);
}
void stbtt__csctx_rline_to(stbtt__csctx* ctx, float dx, float dy) {
	ctx.x += dx;
	ctx.y += dy;
	stbtt__csctx_v(ctx, STBTT_vline, cast(int) ctx.x, cast(int) ctx.y, 0, 0, 0, 0);
}
void stbtt__csctx_rccurve_to(stbtt__csctx* ctx, float dx1, float dy1, float dx2, float dy2, float dx3, float dy3) {
	float cx1 = ctx.x + dx1;
	float cy1 = ctx.y + dy1;
	float cx2 = cx1 + dx2;
	float cy2 = cy1 + dy2;
	ctx.x = cx2 + dx3;
	ctx.y = cy2 + dy3;
	stbtt__csctx_v(ctx, STBTT_vcubic, cast(int) ctx.x, cast(int) ctx.y, cast(int) cx1, cast(int) cy1, cast(int) cx2, cast(
			int) cy2);
}
stbtt__buf stbtt__get_subr(stbtt__buf idx, int n) {
	int count = stbtt__cff_index_count(&idx);
	int bias = 107;
	if (count >= 33900)
		bias = 32768;
	else if (count >= 1240)
		bias = 1131;
	n += bias;
	if (n < 0 || n >= count)
		return stbtt__new_buf(null, 0);
	return stbtt__cff_index_get(idx, n);
}
stbtt__buf stbtt__cid_get_glyph_subrs(stbtt_fontinfo* info, int glyph_index) {
	stbtt__buf fdselect = info.fdselect;
	int nranges, start, end, v, fmt, fdselector = -1, i;
	stbtt__buf_seek(&fdselect, 0);
	fmt = stbtt__buf_get8(&fdselect);
	if (fmt == 0) {
		stbtt__buf_skip(&fdselect, glyph_index);
		fdselector = stbtt__buf_get8(&fdselect);
	}
	else if (fmt == 3) {
		nranges = stbtt__buf_get16(&fdselect);
		start = stbtt__buf_get16(&fdselect);
		for (i = 0; i < nranges; i++) {
			v = stbtt__buf_get8(&fdselect);
			end = stbtt__buf_get16(&fdselect);
			if (glyph_index >= start && glyph_index < end) {
				fdselector = v;
				break;
			}
			start = end;
		}
	}
	if (fdselector == -1)
		stbtt__new_buf(null, 0);
	return stbtt__get_subrs(info.cff, stbtt__cff_index_get(info.fontdicts, fdselector));
}
int stbtt__run_charstring(stbtt_fontinfo* info, int glyph_index, stbtt__csctx* c) {
	int in_header = 1, maskbits = 0, subr_stack_height = 0, sp = 0, v, i, b0;
	int has_subrs = 0, clear_stack;
	float[48] s = void;
	stbtt__buf[10] subr_stack = void;
	stbtt__buf subrs = info.subrs, b;
	float f;
	static int STBTT__CSERR(string s) {
		pragma(inline, true);
		return 0;
	}
	b = stbtt__cff_index_get(info.charstrings, glyph_index);
	while (b.cursor < b.size) {
		i = 0;
		clear_stack = 1;
		b0 = stbtt__buf_get8(&b);
		switch (b0) {
		case 0x13:
		case 0x14:
			if (in_header)
				maskbits += (sp / 2);
			in_header = 0;
			stbtt__buf_skip(&b, (maskbits + 7) / 8);
			break;
		case 0x01:
		case 0x03:
		case 0x12:
		case 0x17:
			maskbits += (sp / 2);
			break;
		case 0x15:
			in_header = 0;
			if (sp < 2)
				return STBTT__CSERR("rmoveto stack");
			stbtt__csctx_rmove_to(c, s[sp - 2], s[sp - 1]);
			break;
		case 0x04:
			in_header = 0;
			if (sp < 1)
				return STBTT__CSERR("vmoveto stack");
			stbtt__csctx_rmove_to(c, 0, s[sp - 1]);
			break;
		case 0x16:
			in_header = 0;
			if (sp < 1)
				return STBTT__CSERR("hmoveto stack");
			stbtt__csctx_rmove_to(c, s[sp - 1], 0);
			break;
		case 0x05:
			if (sp < 2)
				return STBTT__CSERR("rlineto stack");
			for (; i + 1 < sp; i += 2)
				stbtt__csctx_rline_to(c, s[i], s[i + 1]);
			break;
		case 0x07:
			if (sp < 1)
				return STBTT__CSERR("vlineto stack");
			goto vlineto;
		case 0x06:
			if (sp < 1)
				return STBTT__CSERR("hlineto stack");
			for (;;) {
				if (i >= sp)
					break;
				stbtt__csctx_rline_to(c, s[i], 0);
				i++;
		vlineto:
				if (i >= sp)
					break;
				stbtt__csctx_rline_to(c, 0, s[i]);
				i++;
			}
			break;
		case 0x1F:
			if (sp < 4)
				return STBTT__CSERR("hvcurveto stack");
			goto hvcurveto;
		case 0x1E:
			if (sp < 4)
				return STBTT__CSERR("vhcurveto stack");
			for (;;) {
				if (i + 3 >= sp)
					break;
				stbtt__csctx_rccurve_to(c, 0, s[i], s[i + 1], s[i + 2], s[i + 3], (sp - i == 5) ? s[i + 4] : 0.0f);
				i += 4;
		hvcurveto:
				if (i + 3 >= sp)
					break;
				stbtt__csctx_rccurve_to(c, s[i], 0, s[i + 1], s[i + 2], (sp - i == 5) ? s[i + 4] : 0.0f, s[i + 3]);
				i += 4;
			}
			break;
		case 0x08:
			if (sp < 6)
				return STBTT__CSERR("rcurveline stack");
			for (; i + 5 < sp; i += 6)
				stbtt__csctx_rccurve_to(c, s[i], s[i + 1], s[i + 2], s[i + 3], s[i + 4], s[i + 5]);
			break;
		case 0x18:
			if (sp < 8)
				return STBTT__CSERR("rcurveline stack");
			for (; i + 5 < sp - 2; i += 6)
				stbtt__csctx_rccurve_to(c, s[i], s[i + 1], s[i + 2], s[i + 3], s[i + 4], s[i + 5]);
			if (i + 1 >= sp)
				return STBTT__CSERR("rcurveline stack");
			stbtt__csctx_rline_to(c, s[i], s[i + 1]);
			break;
		case 0x19:
			if (sp < 8)
				return STBTT__CSERR("rlinecurve stack");
			for (; i + 1 < sp - 6; i += 2)
				stbtt__csctx_rline_to(c, s[i], s[i + 1]);
			if (i + 5 >= sp)
				return STBTT__CSERR("rlinecurve stack");
			stbtt__csctx_rccurve_to(c, s[i], s[i + 1], s[i + 2], s[i + 3], s[i + 4], s[i + 5]);
			break;
		case 0x1A:
		case 0x1B:
			if (sp < 4)
				return STBTT__CSERR("(vv|hh)curveto stack");
			f = 0.0;
			if (sp & 1) {
				f = s[i];
				i++;
			}
			for (; i + 3 < sp; i += 4) {
				if (b0 == 0x1B)
					stbtt__csctx_rccurve_to(c, s[i], f, s[i + 1], s[i + 2], s[i + 3], 0.0);
				else
					stbtt__csctx_rccurve_to(c, f, s[i], s[i + 1], s[i + 2], 0.0, s[i + 3]);
				f = 0.0;
			}
			break;
		case 0x0A:
			if (!has_subrs) {
				if (info.fdselect.size)
					subrs = stbtt__cid_get_glyph_subrs(info, glyph_index);
				has_subrs = 1;
			}
			goto case;
		case 0x1D:
			if (sp < 1)
				return STBTT__CSERR("call(g|)subr stack");
			v = cast(int) s[--sp];
			if (subr_stack_height >= 10)
				return STBTT__CSERR("recursion limit");
			subr_stack[subr_stack_height++] = b;
			b = stbtt__get_subr(b0 == 0x0A ? subrs : info.gsubrs, v);
			if (b.size == 0)
				return STBTT__CSERR("subr not found");
			b.cursor = 0;
			clear_stack = 0;
			break;
		case 0x0B:
			if (subr_stack_height <= 0)
				return STBTT__CSERR("return outside subr");
			b = subr_stack[--subr_stack_height];
			clear_stack = 0;
			break;
		case 0x0E:
			stbtt__csctx_close_shape(c);
			return 1;
		case 0x0C: {
				float dx1, dx2, dx3, dx4, dx5, dx6, dy1, dy2, dy3, dy4, dy5, dy6;
				float dx, dy;
				int b1 = stbtt__buf_get8(&b);
				switch (b1) {
				case 0x22:
					if (sp < 7)
						return STBTT__CSERR("hflex stack");
					dx1 = s[0];
					dx2 = s[1];
					dy2 = s[2];
					dx3 = s[3];
					dx4 = s[4];
					dx5 = s[5];
					dx6 = s[6];
					stbtt__csctx_rccurve_to(c, dx1, 0, dx2, dy2, dx3, 0);
					stbtt__csctx_rccurve_to(c, dx4, 0, dx5, -dy2, dx6, 0);
					break;
				case 0x23:
					if (sp < 13)
						return STBTT__CSERR("flex stack");
					dx1 = s[0];
					dy1 = s[1];
					dx2 = s[2];
					dy2 = s[3];
					dx3 = s[4];
					dy3 = s[5];
					dx4 = s[6];
					dy4 = s[7];
					dx5 = s[8];
					dy5 = s[9];
					dx6 = s[10];
					dy6 = s[11];
					stbtt__csctx_rccurve_to(c, dx1, dy1, dx2, dy2, dx3, dy3);
					stbtt__csctx_rccurve_to(c, dx4, dy4, dx5, dy5, dx6, dy6);
					break;
				case 0x24:
					if (sp < 9)
						return STBTT__CSERR("hflex1 stack");
					dx1 = s[0];
					dy1 = s[1];
					dx2 = s[2];
					dy2 = s[3];
					dx3 = s[4];
					dx4 = s[5];
					dx5 = s[6];
					dy5 = s[7];
					dx6 = s[8];
					stbtt__csctx_rccurve_to(c, dx1, dy1, dx2, dy2, dx3, 0);
					stbtt__csctx_rccurve_to(c, dx4, 0, dx5, dy5, dx6, -(dy1 + dy2 + dy5));
					break;
				case 0x25:
					if (sp < 11)
						return STBTT__CSERR("flex1 stack");
					dx1 = s[0];
					dy1 = s[1];
					dx2 = s[2];
					dy2 = s[3];
					dx3 = s[4];
					dy3 = s[5];
					dx4 = s[6];
					dy4 = s[7];
					dx5 = s[8];
					dy5 = s[9];
					dx6 = dy6 = s[10];
					dx = dx1 + dx2 + dx3 + dx4 + dx5;
					dy = dy1 + dy2 + dy3 + dy4 + dy5;
					if (STBTT_fabs(dx) > STBTT_fabs(dy))
						dy6 = -dy;
					else
						dx6 = -dx;
					stbtt__csctx_rccurve_to(c, dx1, dy1, dx2, dy2, dx3, dy3);
					stbtt__csctx_rccurve_to(c, dx4, dy4, dx5, dy5, dx6, dy6);
					break;
				default:
					return STBTT__CSERR("unimplemented");
				}
			}
			break;
		default:
			if (b0 != 255 && b0 != 28 && (b0 < 32 || b0 > 254))
				return STBTT__CSERR("reserved operator");
			if (b0 == 255) {
				f = cast(float) cast(int) stbtt__buf_get32(&b) / 0x10000;
			}
			else {
				stbtt__buf_skip(&b, -1);
				f = cast(float) cast(short) stbtt__cff_int(&b);
			}
			if (sp >= 48)
				return STBTT__CSERR("push stack overflow");
			s[sp++] = f;
			clear_stack = 0;
			break;
		}
		if (clear_stack)
			sp = 0;
	}
	return STBTT__CSERR("no endchar");
}
int stbtt__GetGlyphShapeT2(stbtt_fontinfo* info, int glyph_index, stbtt_vertex** pvertices) {
	stbtt__csctx count_ctx = stbtt__csctx(1, 0, 0, 0, 0, 0, 0, 0, 0, 0, null, 0);
	stbtt__csctx output_ctx = stbtt__csctx(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, null, 0);
	if (stbtt__run_charstring(info, glyph_index, &count_ctx)) {
		*pvertices = cast(stbtt_vertex*) STBTT_malloc(count_ctx.num_vertices * cast(uint) stbtt_vertex.sizeof, info
				.userdata);
		output_ctx.pvertices = *pvertices;
		if (stbtt__run_charstring(info, glyph_index, &output_ctx)) {
			assert(output_ctx.num_vertices == count_ctx.num_vertices);
			return output_ctx.num_vertices;
		}
	}
	*pvertices = null;
	return 0;
}
public int stbtt__GetGlyphInfoT2(stbtt_fontinfo* info, int glyph_index, int* x0, int* y0, int* x1, int* y1) {
	stbtt__csctx c = stbtt__csctx(1, 0, 0, 0, 0, 0, 0, 0, 0, 0, null, 0);
	int r = stbtt__run_charstring(info, glyph_index, &c);
	if (x0)
		*x0 = r ? c.min_x : 0;
	if (y0)
		*y0 = r ? c.min_y : 0;
	if (x1)
		*x1 = r ? c.max_x : 0;
	if (y1)
		*y1 = r ? c.max_y : 0;
	return r ? c.num_vertices : 0;
}
public int stbtt_GetGlyphShape(stbtt_fontinfo* info, int glyph_index, stbtt_vertex** pvertices) {
	if (!info.cff.size)
		return stbtt__GetGlyphShapeTT(info, glyph_index, pvertices);
	else
		return stbtt__GetGlyphShapeT2(info, glyph_index, pvertices);
}
public void stbtt_GetGlyphHMetrics(const(stbtt_fontinfo)* info, int glyph_index, int* advanceWidth, int* leftSideBearing) {
	ushort numOfLongHorMetrics = ttUSHORT(info.data + info.hhea + 34);
	if (glyph_index < numOfLongHorMetrics) {
		if (advanceWidth)
			*advanceWidth = ttSHORT(info.data + info.hmtx + 4 * glyph_index);
		if (leftSideBearing)
			*leftSideBearing = ttSHORT(info.data + info.hmtx + 4 * glyph_index + 2);
	}
	else {
		if (advanceWidth)
			*advanceWidth = ttSHORT(info.data + info.hmtx + 4 * (numOfLongHorMetrics - 1));
		if (leftSideBearing)
			*leftSideBearing = ttSHORT(info.data + info.hmtx + 4 * numOfLongHorMetrics + 2 * (glyph_index - numOfLongHorMetrics));
	}
}
int stbtt__GetGlyphKernInfoAdvance(stbtt_fontinfo* info, int glyph1, int glyph2) {
	ubyte* data = info.data + info.kern;
	uint needle, straw;
	int l, r, m;
	if (!info.kern)
		return 0;
	if (ttUSHORT(data + 2) < 1)
		return 0;
	if (ttUSHORT(data + 8) != 1)
		return 0;
	l = 0;
	r = ttUSHORT(data + 10) - 1;
	needle = glyph1 << 16 | glyph2;
	while (l <= r) {
		m = (l + r) >> 1;
		straw = ttULONG(data + 18 + (m * 6));
		if (needle < straw)
			r = m - 1;
		else if (needle > straw)
			l = m + 1;
		else
			return ttSHORT(data + 22 + (m * 6));
	}
	return 0;
}
int stbtt__GetCoverageIndex(ubyte* coverageTable, int glyph) {
	ushort coverageFormat = ttUSHORT(coverageTable);
	switch (coverageFormat) {
	case 1: {
			ushort glyphCount = ttUSHORT(coverageTable + 2);
			int l = 0, r = glyphCount - 1, m;
			int straw, needle = glyph;
			while (l <= r) {
				ubyte* glyphArray = coverageTable + 4;
				ushort glyphID;
				m = (l + r) >> 1;
				glyphID = ttUSHORT(glyphArray + 2 * m);
				straw = glyphID;
				if (needle < straw)
					r = m - 1;
				else if (needle > straw)
					l = m + 1;
				else {
					return m;
				}
			}
		}
		break;
	case 2: {
			ushort rangeCount = ttUSHORT(coverageTable + 2);
			ubyte* rangeArray = coverageTable + 4;
			int l = 0, r = rangeCount - 1, m;
			int strawStart, strawEnd, needle = glyph;
			while (l <= r) {
				ubyte* rangeRecord;
				m = (l + r) >> 1;
				rangeRecord = rangeArray + 6 * m;
				strawStart = ttUSHORT(rangeRecord);
				strawEnd = ttUSHORT(rangeRecord + 2);
				if (needle < strawStart)
					r = m - 1;
				else if (needle > strawEnd)
					l = m + 1;
				else {
					ushort startCoverageIndex = ttUSHORT(rangeRecord + 4);
					return startCoverageIndex + glyph - strawStart;
				}
			}
		}
		break;
	default: {
			assert(0);
		}
	}
	return -1;
}
int stbtt__GetGlyphClass(ubyte* classDefTable, int glyph) {
	ushort classDefFormat = ttUSHORT(classDefTable);
	switch (classDefFormat) {
	case 1: {
			ushort startGlyphID = ttUSHORT(classDefTable + 2);
			ushort glyphCount = ttUSHORT(classDefTable + 4);
			ubyte* classDef1ValueArray = classDefTable + 6;
			if (glyph >= startGlyphID && glyph < startGlyphID + glyphCount)
				return cast(int) ttUSHORT(classDef1ValueArray + 2 * (glyph - startGlyphID));
			classDefTable = classDef1ValueArray + 2 * glyphCount;
		}
		break;
	case 2: {
			ushort classRangeCount = ttUSHORT(classDefTable + 2);
			ubyte* classRangeRecords = classDefTable + 4;
			int l = 0, r = classRangeCount - 1, m;
			int strawStart, strawEnd, needle = glyph;
			while (l <= r) {
				ubyte* classRangeRecord;
				m = (l + r) >> 1;
				classRangeRecord = classRangeRecords + 6 * m;
				strawStart = ttUSHORT(classRangeRecord);
				strawEnd = ttUSHORT(classRangeRecord + 2);
				if (needle < strawStart)
					r = m - 1;
				else if (needle > strawEnd)
					l = m + 1;
				else
					return cast(int) ttUSHORT(classRangeRecord + 4);
			}
			classDefTable = classRangeRecords + 6 * classRangeCount;
		}
		break;
	default: {
			assert(0);
		}
	}
	return -1;
}
int stbtt__GetGlyphGPOSInfoAdvance(stbtt_fontinfo* info, int glyph1, int glyph2) {
	ushort lookupListOffset;
	ubyte* lookupList;
	ushort lookupCount;
	ubyte* data;
	int i;
	if (!info.gpos)
		return 0;
	data = info.data + info.gpos;
	if (ttUSHORT(data + 0) != 1)
		return 0;
	if (ttUSHORT(data + 2) != 0)
		return 0;
	lookupListOffset = ttUSHORT(data + 8);
	lookupList = data + lookupListOffset;
	lookupCount = ttUSHORT(lookupList);
	for (i = 0; i < lookupCount; ++i) {
		ushort lookupOffset = ttUSHORT(lookupList + 2 + 2 * i);
		ubyte* lookupTable = lookupList + lookupOffset;
		ushort lookupType = ttUSHORT(lookupTable);
		ushort subTableCount = ttUSHORT(lookupTable + 4);
		ubyte* subTableOffsets = lookupTable + 6;
		switch (lookupType) {
		case 2: {
				int sti;
				for (sti = 0; sti < subTableCount; sti++) {
					ushort subtableOffset = ttUSHORT(subTableOffsets + 2 * sti);
					ubyte* table = lookupTable + subtableOffset;
					ushort posFormat = ttUSHORT(table);
					ushort coverageOffset = ttUSHORT(table + 2);
					int coverageIndex = stbtt__GetCoverageIndex(table + coverageOffset, glyph1);
					if (coverageIndex == -1)
						continue;
					switch (posFormat) {
					case 1: {
							int l, r, m;
							int straw, needle;
							ushort valueFormat1 = ttUSHORT(table + 4);
							ushort valueFormat2 = ttUSHORT(table + 6);
							int valueRecordPairSizeInBytes = 2;
							ushort pairSetCount = ttUSHORT(table + 8);
							ushort pairPosOffset = ttUSHORT(table + 10 + 2 * coverageIndex);
							ubyte* pairValueTable = table + pairPosOffset;
							ushort pairValueCount = ttUSHORT(pairValueTable);
							ubyte* pairValueArray = pairValueTable + 2;
							if (valueFormat1 != 4)
								return 0;
							if (valueFormat2 != 0)
								return 0;
							assert(coverageIndex < pairSetCount);
							needle = glyph2;
							r = pairValueCount - 1;
							l = 0;
							while (l <= r) {
								ushort secondGlyph;
								ubyte* pairValue;
								m = (l + r) >> 1;
								pairValue = pairValueArray + (2 + valueRecordPairSizeInBytes) * m;
								secondGlyph = ttUSHORT(pairValue);
								straw = secondGlyph;
								if (needle < straw)
									r = m - 1;
								else if (needle > straw)
									l = m + 1;
								else {
									short xAdvance = ttSHORT(pairValue + 2);
									return xAdvance;
								}
							}
						}
						break;
					case 2: {
							ushort valueFormat1 = ttUSHORT(table + 4);
							ushort valueFormat2 = ttUSHORT(table + 6);
							ushort classDef1Offset = ttUSHORT(table + 8);
							ushort classDef2Offset = ttUSHORT(table + 10);
							int glyph1class = stbtt__GetGlyphClass(table + classDef1Offset, glyph1);
							int glyph2class = stbtt__GetGlyphClass(table + classDef2Offset, glyph2);
							ushort class1Count = ttUSHORT(table + 12);
							ushort class2Count = ttUSHORT(table + 14);
							assert(glyph1class < class1Count);
							assert(glyph2class < class2Count);
							if (valueFormat1 != 4)
								return 0;
							if (valueFormat2 != 0)
								return 0;
							if (glyph1class >= 0 && glyph1class < class1Count && glyph2class >= 0 && glyph2class < class2Count) {
								ubyte* class1Records = table + 16;
								ubyte* class2Records = class1Records + 2 * (glyph1class * class2Count);
								short xAdvance = ttSHORT(class2Records + 2 * glyph2class);
								return xAdvance;
							}
						}
						break;
					default: {
							assert(0);
						}
					}
				}
				break;
			}
		default:
			break;
		}
	}
	return 0;
}
public int stbtt_GetGlyphKernAdvance(stbtt_fontinfo* info, int g1, int g2) {
	int xAdvance = 0;
	if (info.gpos)
		xAdvance += stbtt__GetGlyphGPOSInfoAdvance(info, g1, g2);
	if (info.kern)
		xAdvance += stbtt__GetGlyphKernInfoAdvance(info, g1, g2);
	return xAdvance;
}
public int stbtt_GetCodepointKernAdvance(stbtt_fontinfo* info, int ch1, int ch2) {
	if (!info.kern && !info.gpos)
		return 0;
	return stbtt_GetGlyphKernAdvance(info, stbtt_FindGlyphIndex(info, ch1), stbtt_FindGlyphIndex(info, ch2));
}
public void stbtt_GetCodepointHMetrics(const(stbtt_fontinfo)* info, int codepoint, int* advanceWidth, int* leftSideBearing) {
	stbtt_GetGlyphHMetrics(info, stbtt_FindGlyphIndex(info, codepoint), advanceWidth, leftSideBearing);
}
public void stbtt_GetFontVMetrics(const(stbtt_fontinfo)* info, int* ascent, int* descent, int* lineGap) {
	if (ascent)
		*ascent = ttSHORT(info.data + info.hhea + 4);
	if (descent)
		*descent = ttSHORT(info.data + info.hhea + 6);
	if (lineGap)
		*lineGap = ttSHORT(info.data + info.hhea + 8);
}
public int stbtt_GetFontVMetricsOS2(stbtt_fontinfo* info, int* typoAscent, int* typoDescent, int* typoLineGap) {
	int tab = stbtt__find_table(info.data, info.fontstart, "OS/2");
	if (!tab)
		return 0;
	if (typoAscent)
		*typoAscent = ttSHORT(info.data + tab + 68);
	if (typoDescent)
		*typoDescent = ttSHORT(info.data + tab + 70);
	if (typoLineGap)
		*typoLineGap = ttSHORT(info.data + tab + 72);
	return 1;
}
public int stbtt_GetFontXHeight(stbtt_fontinfo* info, int* xHeight) {
	int tab = stbtt__find_table(info.data, info.fontstart, "OS/2");
	if (!tab)
		return 0;
	if (xHeight) {
		auto height = ttSHORT(info.data + tab + 86);
		if (height == 0)
			height = ttSHORT(info.data + tab + 2);
		*xHeight = height;
	}
	return 1;
}
public void stbtt_GetFontBoundingBox(const(stbtt_fontinfo)* info, int* x0, int* y0, int* x1, int* y1) {
	*x0 = ttSHORT(info.data + info.head + 36);
	*y0 = ttSHORT(info.data + info.head + 38);
	*x1 = ttSHORT(info.data + info.head + 40);
	*y1 = ttSHORT(info.data + info.head + 42);
}
public float stbtt_ScaleForPixelHeight(const(stbtt_fontinfo)* info, float height) {
	int fheight = ttSHORT(info.data + info.hhea + 4) - ttSHORT(info.data + info.hhea + 6);
	return cast(float) height / fheight;
}
public float stbtt_ScaleForMappingEmToPixels(const(stbtt_fontinfo)* info, float pixels) {
	int unitsPerEm = ttUSHORT(info.data + info.head + 18);
	return pixels / unitsPerEm;
}
int stbtt__CompareUTF8toUTF16_bigendian_prefix(ubyte* s1, int len1, ubyte* s2, int len2) {
	int i = 0;
	while (len2) {
		ushort ch = s2[0] * 256 + s2[1];
		if (ch < 0x80) {
			if (i >= len1)
				return -1;
			if (s1[i++] != ch)
				return -1;
		}
		else if (ch < 0x800) {
			if (i + 1 >= len1)
				return -1;
			if (s1[i++] != 0xc0 + (ch >> 6))
				return -1;
			if (s1[i++] != 0x80 + (ch & 0x3f))
				return -1;
		}
		else if (ch >= 0xd800 && ch < 0xdc00) {
			uint c;
			ushort ch2 = s2[2] * 256 + s2[3];
			if (i + 3 >= len1)
				return -1;
			c = ((ch - 0xd800) << 10) + (ch2 - 0xdc00) + 0x10000;
			if (s1[i++] != 0xf0 + (c >> 18))
				return -1;
			if (s1[i++] != 0x80 + ((c >> 12) & 0x3f))
				return -1;
			if (s1[i++] != 0x80 + ((c >> 6) & 0x3f))
				return -1;
			if (s1[i++] != 0x80 + ((c) & 0x3f))
				return -1;
			s2 += 2;
			len2 -= 2;
		}
		else if (ch >= 0xdc00 && ch < 0xe000) {
			return -1;
		}
		else {
			if (i + 2 >= len1)
				return -1;
			if (s1[i++] != 0xe0 + (ch >> 12))
				return -1;
			if (s1[i++] != 0x80 + ((ch >> 6) & 0x3f))
				return -1;
			if (s1[i++] != 0x80 + ((ch) & 0x3f))
				return -1;
		}
		s2 += 2;
		len2 -= 2;
	}
	return i;
}
public int stbtt_CompareUTF8toUTF16_bigendian(char* s1, int len1, char* s2, int len2) {
	return len1 == stbtt__CompareUTF8toUTF16_bigendian_prefix(cast(ubyte*) s1, len1, cast(ubyte*) s2, len2);
}
public const(char)* stbtt_GetFontNameString(stbtt_fontinfo* font, int* length, int platformID, int encodingID, int languageID, int nameID) {
	int i, count, stringOffset;
	ubyte* fc = font.data;
	uint offset = font.fontstart;
	uint nm = stbtt__find_table(fc, offset, "name");
	if (!nm)
		return null;
	count = ttUSHORT(fc + nm + 2);
	stringOffset = nm + ttUSHORT(fc + nm + 4);
	for (i = 0; i < count; ++i) {
		uint loc = nm + 6 + 12 * i;
		if (platformID == ttUSHORT(fc + loc + 0) && encodingID == ttUSHORT(fc + loc + 2)
			&& languageID == ttUSHORT(fc + loc + 4) && nameID == ttUSHORT(fc + loc + 6)) {
			*length = ttUSHORT(fc + loc + 8);
			return cast(const(char)*)(fc + stringOffset + ttUSHORT(fc + loc + 10));
		}
	}
	return null;
}
int stbtt__matchpair(ubyte* fc, uint nm, ubyte* name, int nlen, int target_id, int next_id) {
	int i;
	int count = ttUSHORT(fc + nm + 2);
	int stringOffset = nm + ttUSHORT(fc + nm + 4);
	for (i = 0; i < count; ++i) {
		uint loc = nm + 6 + 12 * i;
		int id = ttUSHORT(fc + loc + 6);
		if (id == target_id) {
			int platform = ttUSHORT(fc + loc + 0), encoding = ttUSHORT(fc + loc + 2), language = ttUSHORT(fc + loc + 4);
			if (platform == 0 || (platform == 3 && encoding == 1) || (platform == 3 && encoding == 10)) {
				int slen = ttUSHORT(fc + loc + 8);
				int off = ttUSHORT(fc + loc + 10);
				int matchlen = stbtt__CompareUTF8toUTF16_bigendian_prefix(name, nlen, fc + stringOffset + off, slen);
				if (matchlen >= 0) {
					if (i + 1 < count && ttUSHORT(fc + loc + 12 + 6) == next_id && ttUSHORT(fc + loc + 12) == platform && ttUSHORT(
							fc + loc + 12 + 2) == encoding && ttUSHORT(fc + loc + 12 + 4) == language) {
						slen = ttUSHORT(fc + loc + 12 + 8);
						off = ttUSHORT(fc + loc + 12 + 10);
						if (slen == 0) {
							if (matchlen == nlen)
								return 1;
						}
						else if (matchlen < nlen && name[matchlen] == ' ') {
							++matchlen;
							if (stbtt_CompareUTF8toUTF16_bigendian(cast(char*)(name + matchlen), nlen - matchlen, cast(
									char*)(fc + stringOffset + off), slen))
								return 1;
						}
					}
					else {
						if (matchlen == nlen)
							return 1;
					}
				}
			}
		}
	}
	return 0;
}
int stbtt__matches(ubyte* fc, uint offset, ubyte* name, int flags) {
	int nlen = cast(int) STBTT_strlen(cast(char*) name);
	uint nm, hd;
	if (!stbtt__isfont(fc + offset))
		return 0;
	if (flags) {
		hd = stbtt__find_table(fc, offset, "head");
		if ((ttUSHORT(fc + hd + 44) & 7) != (flags & 7))
			return 0;
	}
	nm = stbtt__find_table(fc, offset, "name");
	if (!nm)
		return 0;
	if (flags) {
		if (stbtt__matchpair(fc, nm, name, nlen, 16, -1))
			return 1;
		if (stbtt__matchpair(fc, nm, name, nlen, 1, -1))
			return 1;
		if (stbtt__matchpair(fc, nm, name, nlen, 3, -1))
			return 1;
	}
	else {
		if (stbtt__matchpair(fc, nm, name, nlen, 16, 17))
			return 1;
		if (stbtt__matchpair(fc, nm, name, nlen, 1, 2))
			return 1;
		if (stbtt__matchpair(fc, nm, name, nlen, 3, -1))
			return 1;
	}
	return 0;
}
public int stbtt_FindMatchingFont(ubyte* font_collection, char* name_utf8, int flags) {
	int i;
	for (i = 0;; ++i) {
		int off = stbtt_GetFontOffsetForIndex(font_collection, i);
		if (off < 0)
			return off;
		if (stbtt__matches(cast(ubyte*) font_collection, off, cast(ubyte*) name_utf8, flags))
			return off;
	}
}
