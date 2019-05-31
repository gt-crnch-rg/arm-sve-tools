#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>

const uint64_t SIZE = 32;

uint64_t max(uint64_t array[SIZE])
{
    uint64_t max = 0;

    for (int i=0; i<SIZE; i++) {
        if (array[i] > max) {
            max = array[i];
        }
    }

    return max;
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
