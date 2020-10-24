#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>

const uint32_t SIZE = 1024;

// Dot product
// c += a * b
uint32_t dot_product(uint8_t a[SIZE], uint8_t b[SIZE])
{
    uint32_t c = 0;

    for (int i=0; i<SIZE; i++) {
        c += a[i] * b[i];
    }
    return c;
}

int main()
{
    uint8_t a[SIZE] = {1,2,2,3,-1,1,2,0,-2,1}; //initializes first 5 numbers
    uint8_t b[SIZE] = {2,2,3,2,1,-2,0,1,2,-3}; //initializes first 5 numbers

    uint32_t res = dot_product(a, b);

    printf("Dotprod = %i\n", res);

    return 0;
}
