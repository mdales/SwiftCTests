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
	int64_t total = 0;
	for (uint idx = 0; idx < count; idx++) {
		total += vals[idx];
	}
	return total;
}
