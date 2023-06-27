module gd.geom.path;
import gd.math;
import std.sumtype;

alias Path = TPath!double;
alias IPath = TPath!int;
alias FPath = TPath!float;
alias RPath = TPath!real;

enum CommandType : ubyte {
	Move,
	Line,
	BezierQuad,
	BezierCubic,
	Arc,
	Close,
}

struct TPath(T) {

	struct Command {
		CommandType type;
		union {
			Move move;
			Line line;
			BezierQuad bezierQuad;
			BezierCubic bezierCubic;
			Arc arc;
			Close close;
		}

		this(Move value) { type = CommandType.Move; move = value; }
		this(Line value) { type = CommandType.Line; line = value; }
		this(BezierQuad value) { type = CommandType.BezierQuad; bezierQuad = value; }
		this(BezierCubic value) { type = CommandType.BezierCubic; bezierCubic = value; }
		this(Arc value) { type = CommandType.Arc; arc = value; }
		this(Close value) { type = CommandType.Close; close = value; }
	}

	struct Move        { TVec2!T point; }
	struct Line        { TVec2!T end; }
	struct BezierQuad  { TVec2!T c1, end; }
	struct BezierCubic { TVec2!T c1, c2, end; }
	struct Arc         { TVec2!T point; }
	struct Close       { }

	private immutable(ubyte)[] data;

	this(const(Command)[] commands) {
		foreach (cmd; commands) {
			this ~= cmd;
		}
	}

	private static size_t sizeOfCommand(CommandType type) {
		final switch (type) {
			case CommandType.Move: return Command.move.offsetof + Move.sizeof;
			case CommandType.Line: return Command.line.offsetof + Line.sizeof;
			case CommandType.BezierQuad: return Command.bezierQuad.offsetof + BezierQuad.sizeof;
			case CommandType.BezierCubic: return Command.bezierCubic.offsetof + BezierCubic.sizeof;
			case CommandType.Arc: return Command.arc.offsetof + Arc.sizeof;
			case CommandType.Close: return Command.close.offsetof + Close.sizeof;
		}
	}

	int opApply(scope int delegate(ref immutable(Command)) dg) const {
		foreach (ref cmd; this[]) {
			int result = dg(cmd);
			if (result) { return result; }
		}
		return 0;
	}

	auto opSlice() const {
		struct PathRange {
			void popFront() { index += sizeOfCommand(front.type); }
			ref front() { return *cast(immutable(Command)*) &data[index]; }
			bool empty() { return index >= data.length; }
		private:
			size_t index;
			immutable(ubyte)[] data;
		}

		return PathRange(0, data);
	}

	TPath!T opBinary(string op, R)(const(R) rhs) const if (op == "~") {
		TPath!T result = this;
		result ~= rhs;
		return result;
	}

	ref TPath!T opOpAssign(string op)(const(Command) value) if (op == "~") {
		size_t index = data.length;
		data.length += sizeOfCommand(value.type);

		// this might not produce correct behavior if T behaves differently
		// when immutable and mutable, but usually T is a POD anyway so we
		// don't worry about that

		// also the standard library Rebindable has the same issue so we're
		// probably fine

		Command* cmd = cast(Command*)&data[index];
		cmd.type = value.type;
		final switch (value.type) {
			case CommandType.Move: cmd.move = value.move; break;
			case CommandType.Line: cmd.line = value.line; break;
			case CommandType.BezierQuad: cmd.bezierQuad = value.bezierQuad; break;
			case CommandType.BezierCubic: cmd.bezierCubic = value.bezierCubic; break;
			case CommandType.Arc: cmd.arc = value.arc; break;
			case CommandType.Close: cmd.close = value.close; break;
		}

		return this;
	}

	ref TPath!T opOpAssign(string op, R)(const(R) value)
		if (op == "~" && !is(R : Command))
		{ return this ~= Command(value); }

	ref TPath!T moveTo(TVec2!T point) { return this ~= Move(point); }
	ref TPath!T lineTo(TVec2!T end) { return this ~= Line(end); }
	ref TPath!T quadTo(TVec2!T c1, TVec2!T end) { return this ~= BezierQuad(c1, end); }
	ref TPath!T cubicTo(TVec2!T c1, TVec2!T c2, TVec2!T end) { return this ~= BezierCubic(c1, c2, end); }
	ref TPath!T close() { return this ~= Close(); }

}
