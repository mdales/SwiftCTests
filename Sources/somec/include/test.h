#include <stdint.h>

int64_t someInt(int64_t);
int someIntModify(int64_t*);
int64_t someSumIntArray(unsigned int count, int64_t vals[]);
int64_t someSumIntPointer(unsigned int count, int64_t *vals);
int someIntModifyArray(unsigned int count, int64_t vals[]);
int someIntArrayCalleeOwned(unsigned int *count, const int64_t *vals[]);