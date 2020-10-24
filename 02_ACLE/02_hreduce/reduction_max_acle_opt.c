#include <stdlib.h>
#include <stdio.h>
#include <arm_sve.h>

// the code below assumes 32 elements for simplicity
const uint32_t SIZE = 32;

uint64_t max(uint64_t array[SIZE])
{
    // initialize max vector with zeros
    svuint64_t max = svdup_u64(0);

    // get number of 64-bit elements in vector
    uint64_t vl = svcntd();

    // all true mask - assuming no partial vector mask needed for simplicity
    svbool_t p64_all = svptrue_b64();

    for (int i=0; i<SIZE; i+=vl) {
        // load array elements from memory
        svuint64_t vec = svld1(p64_all, &array[i]);
        // get max between loaded vector to max
        max = svmax_m(p64_all, max, vec);
    }

    // return max across values within the vector
    return svmaxv(p64_all, max);
}

int main()
{
    uint64_t array[SIZE] = { 130,   4,   9,  23,1899, 543,  31, 256,
                               0,  93,   3,   2,  11,   1,   5,  18,
                            1024, 999,  46,   4,  99,  63,   9,  12,
                            1714,  19,  26,  44,  41, 111,  27,  34};

    uint64_t result = max(array);

    printf("Max: %lu\n", result);
    
    return 0;
}
