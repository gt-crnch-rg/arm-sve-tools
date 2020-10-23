#include <stdlib.h>
#include <stdio.h>
#include <arm_sve.h>

const uint32_t SIZE = 16;

uint32_t max_scalar(uint32_t array[SIZE])
{
    uint32_t max = 0.0;

    uint32_t vl = svcntw();
    svbool_t p32_all = svptrue_b32();

    for (int i=0; i<SIZE; i+=vl) {
        // load array elements from memory
        svuint32_t vec = svld1(p32_all, &array[i]);
        // get max within vector
        uint32_t vecmax = svmaxv(p32_all, vec);
        if (vecmax > max) {
            max = vecmax;
        }
    }

    return max;
}


int main()
{
    uint32_t array[SIZE] = {130,4,9,23,1899,543,31,256,0,93,3,2,11,1,5,18};
    
    uint32_t result = max_scalar(array);

    printf("Max: %u\n", result);
    
    return 0;
}
