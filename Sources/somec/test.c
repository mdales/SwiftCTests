#include "test.h"

int64_t someInt(int64_t i) {
	return i * 42;
}

int someIntModify(int64_t *i) {
	if (NULL != i) {
		*i = *i * 42;
		return 0;
	}
	return -1;
}

int64_t someSumIntArray(unsigned int count, int64_t vals[]) {
	if (NULL == vals) {
		return 0;
	}
	int64_t total = 0;
	for (uint idx = 0; idx < count; idx++) {
		total += vals[idx];
	}
	return total;
}

int64_t someSumIntPointer(unsigned int count, int64_t *vals) {
	// Same as someSumIntArray, but checking if Swift treats the
	// type signature any differently (it doesn't seem to)

	if (NULL == vals) {
		return 0;
	}
	int64_t total = 0;
	for (uint idx = 0; idx < count; idx++) {
		total += vals[idx];
	}
	return total;
}

int someIntModifyArray(unsigned int count, int64_t vals[]) {
	if (NULL == vals) {
		return -1;
	}
	for (uint idx = 0; idx < count; idx++) {
		vals[idx] = vals[idx] * 42;
	}
	return 0;
}
