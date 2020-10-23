#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>
#include <arm_sve.h>

const uint32_t SIZE = 1024;

// Dot product
// c += a * b
uint32_t dot_product(uint8_t a[SIZE], uint8_t b[SIZE])
{
    uint32_t vl = svcntb();

    svbool_t p8_all = svptrue_b8();
    svbool_t p32_all = svptrue_b32();

    svuint32_t vc = svdup_u32(0);

    for (int i=0; i<SIZE; i+=vl) {
        svuint8_t va = svld1(p8_all, &a[i]);
        svuint8_t vb = svld1(p8_all, &b[i]);

        vc = svdot(vc, va, vb); 
    }
    return svaddv(p32_all, vc);
}

int main()
{
    uint8_t a[SIZE] = {1,2,2,3,-1,1,2,0,-2,1}; //initializes first 5 numbers
    uint8_t b[SIZE] = {2,2,3,2,1,-2,0,1,2,-3}; //initializes first 5 numbers

    uint32_t res = dot_product(a, b);

    printf("Dotprod = %i\n", res);

    return 0;
}
