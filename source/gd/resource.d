module gd.resource;
import std.typecons;
import core.atomic;

private shared(size_t) resourceCount = 0;
private shared(size_t) resourceIdCounter = 0;

debug (resourceLeaks) {
	import core.sync.mutex;
	private __gshared Mutex resourceSetMutex;
	private __gshared bool[Resource] resourceSet;

	shared static this() {
		resourceSetMutex = new Mutex;
	}
}

private Resource[] libraries;

shared static ~this() {
	foreach (library; libraries) {
		library.dispose();
	}

	if (resourceCount != 0) {
		import std.stdio : stderr;

		stderr.writefln!"WARNING: %d resources leaked"(resourceCount);
		debug (resourceLeaks) {
			int[string] frequencyMap;

			foreach (resource; resourceSet.byKey) {
				import std.string : splitLines, join, format;
				import std.algorithm : canFind;

				string[] trace = resource.stackTrace.splitLines;

				string[] cleanTrace;

				int stage = 0;
				foreach (line; trace) {
					if (line.canFind("gd/resource.d:")) {
						if (stage <= 1) {
							stage = 1;
							continue;
						}
					}

					if (stage >= 1) {
						stage = 2;
						cleanTrace ~= line;
					}
				}

				string res = format!"- %s$resourceUseCount\n%s\n"(resource, cleanTrace.join("\n"));
				if (res !in frequencyMap)
					frequencyMap[res] = 0;

				frequencyMap[res] += 1;
			}

			foreach (displayString, frequency; frequencyMap) {
				import std.string : replace;
				import std.conv : text;

				stderr.writeln(displayString.replace("$resourceUseCount", text(" (", frequency, ")")));
			}
		}
	}
}

void registerLibraryResource(Resource resource) {
	libraries.assumeSafeAppend ~= resource;
}

debug (resourceLeaks) {
	void dumpResourceGraph() {
		import std.stdio : stderr;

		synchronized (resourceSetMutex) {
			bool[Resource] visited;

			void dump(Resource resource, string indent) {
				visited[resource] = true;
				stderr.writefln!"%s%d %s"(indent, resource.resourceId, resource);
				foreach (child; resource.m_children.byKey) {
					dump(child, indent ~ "    ");
				}
			}

			foreach (resource; resourceSet.byKey) {
				if (resource.parents.length == 0) {
					dump(resource, "");
				}
			}

			foreach (resource; resourceSet.byKey) {
				assert(resource in visited);
			}
		}
	}
}

debug (resourceLeaks) {
	// source: http://arsdnet.net/dcode/stacktrace.d
	private string getStackTrace() {
		import core.runtime : defaultTraceHandler, defaultTraceDeallocator;

		// on some systems, druntime cuts out the first few functions on the trace as
		// they are internal so we'll make some dummy functions here so our actual
		// info doesn't get cut
		Throwable.TraceInfo f5() { return defaultTraceHandler(); }
		Throwable.TraceInfo f4() { return f5(); }
		Throwable.TraceInfo f3() { return f4(); }
		Throwable.TraceInfo f2() { return f3(); }

		Throwable.TraceInfo info = f2();
		string res = info.toString();
		defaultTraceDeallocator(info);
		return res;
	}
}

abstract class Resource {

	private bool[Resource] m_children;
	private bool[Resource] parents;
	private size_t m_id;

	debug (resourceLeaks) {
		private string stackTrace;
	}

	this() {
		resourceCount.atomicOp!"+="(1);
		m_id = resourceIdCounter.atomicOp!"+="(1);

		debug (resourceLeaks) {
			stackTrace = getStackTrace();

			synchronized (resourceSetMutex) {
				resourceSet[this] = true;
			}
		}
	}

	size_t resourceId() const @property {
		return m_id;
	}

	auto children() { return m_children.byKey; }

	/++ adds a dependent child to this resource +/
	private Resource addChild(Resource child) {
		if (child is null) {
			return null;
		}

		m_children[child] = true;
		child.parents[this] = true;
		return child;
	}

	void addDependency(Resource dependency) {
		dependency.addChild(this);
	}

	private bool m_disposed = false;
	bool disposed() const @property { return m_disposed; }

	void dispose() {
		import std.array : array;

		if (!m_disposed) {
			m_disposed = true;

			foreach (child; children.array) {
				child.dispose();
			}

			try {
				disposeImpl();
			}
			finally {
				resourceCount.atomicOp!"-="(1);

				debug (resourceLeaks) synchronized (resourceSetMutex) {
					resourceSet.remove(this);
				}

				foreach (parent; parents.byKey.array) {
					parent.m_children.remove(this);
				}
			}
		}
	}

	protected abstract void disposeImpl();

}
