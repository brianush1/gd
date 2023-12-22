module gd.threading;
import core.thread.fiber;

private {
	// TODO: maybe use a weakset to store the fiber pool and just let the GC clean it up?
	// not sure if fibers are counted properly in the GC pressure calculations tho
	enum MAX_POOL_SIZE = 64;

	TaskFiber[] fiberPool;

	class TaskFiber : Fiber {
		void delegate() task;

		this() {
			super({
				while (true) {
					Exception ex;
					bool thrown = false;

					try {
						task();
					}
					catch (Exception ex2) {
						ex = ex2;
						thrown = true;
					}

					if (fiberPool.length >= MAX_POOL_SIZE) {
						// let ourselves die if we reach this point
						if (thrown) {
							throw ex;
						}
						else {
							return;
						}
					}

					fiberPool.assumeSafeAppend ~= this;
					if (thrown)
						yieldAndThrow(ex);
					else
						yield();
				}
			}, cast(size_t) 8 * 1024 * 1024);
		}
	}
}

void spawnTask(void delegate() fn) {
	TaskFiber fiber;

	if (fiberPool.length == 0) {
		fiber = new TaskFiber();
	}
	else {
		fiber = fiberPool[$ - 1];
		fiberPool = fiberPool[0 .. $ - 1];
	}

	fiber.task = fn;
	fiber.call();
}
