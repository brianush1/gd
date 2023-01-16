module gd.container.fenwick;
import std.exception;

final class FenwickTree(T) {
	const(size_t) length;
	private T[] data;

	this(size_t length) {
		this.length = length;
		data = new T[length];
	}

	void update(size_t index, T value) {
		if (index >= length) return;
		data[index] += value;
		update(index + (index + 1 & -index - 1), value);
	}

	void set(size_t index, T value) {
		// TODO: make this faster
		update(index, value - get(index));
	}

	T sum(size_t index) {
		return data[index] + sum(index - (index + 1 & -index - 1));
	}

	T get(size_t index) {
		if (index == 0) return sum(0);
		else return sum(index) - sum(index - 1);
	}
}

final class FenwickRing(T) {

	private FenwickTree!T data;
	private size_t length;
	private size_t startIndex, endIndex;

	this() {
		data = new FenwickTree!T(8);
	}

	private void grow() {
		FenwickTree!T newData = new FenwickTree!T(data.length * 2);

		size_t i = startIndex;
		do {
			// TODO: avoid using .get(i) here in favor of .sum(i)
			newData.update(i, data.get(i));
			i = (i + 1 & data.length - 1);
		}
		while (i != endIndex);

		data = newData;
		startIndex = 0;
		endIndex = length;
	}

	T insertBack(T value) {
		if (endIndex == startIndex && length != 0) {
			grow();
		}

		data.update(endIndex, value);
		endIndex = (endIndex + 1) & data.length - 1;
		length += 1;
		return value;
	}

	T insertFront() {
		if (endIndex == startIndex && length != 0) {
			grow();
		}

		startIndex = (startIndex - 1) & data.length - 1;
		data.update(startIndex, value);
		length += 1;
		return value;
	}

	T popBack() {
		enforce(length != 0, "cannot pop out of empty container");

		T result = data.get(endIndex);
		endIndex = (endIndex - 1) & data.length - 1;
		data.update(endIndex, -result);
		length -= 1;
		return result;
	}

	T popFront() {
		enforce(length != 0, "cannot pop out of empty container");

		T result = data.get(endIndex);
		data.update(startIndex, -result);
		startIndex = (startIndex + 1) & data.length - 1;
		length -= 1;
		return result;
	}

	void update(size_t index, T value) {
		enforce(index < length, "out of bounds");

		data.update((startIndex + index) & data.length - 1, value);
	}

	void set(size_t index, T value) {
		enforce(index < length, "out of bounds");

		data.set((startIndex + index) & data.length - 1, value);
	}

	T get(size_t index) {
		enforce(index < length, "out of bounds");

		return data.get((startIndex + index) & data.length - 1);
	}

	T sum(size_t start, size_t length) {
		start += startIndex;

		if (start + length <= data.length) {
			T result = data.sum(start + length - 1);

			if (start > 0) {
				result -= data.sum(start - 1);
			}

			return result;
		}
		else {
			T result = data.sum(data.length - 1);

			if (start > 0) {
				result -= data.sum(start - 1);
			}

			result += data.sum((start + length & data.length - 1) - 1);

			return result;
		}
	}

}
