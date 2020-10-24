#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>
#include <arm_sve.h>

const uint32_t SIZE = 1024;

typedef struct {
    float32_t re;
    float32_t im;
} Complex_t;

// Complex dot product
// (a+ib)*(c+id) = (ac - bd) + i(ad + bc)
void complex_dot_product(Complex_t c[SIZE], Complex_t a[SIZE], Complex_t b[SIZE])
{
    uint32_t vl = svcntw();

    svbool_t p32_all = svptrue_b32();

    for (int i=0; i<SIZE; i+=vl) {
        svfloat32x2_t va = svld2(p32_all, (float32_t*)&a[i]);
        svfloat32x2_t vb = svld2(p32_all, (float32_t*)&b[i]);
        svfloat32x2_t vc = svld2(p32_all, (float32_t*)&c[i]);

        vc.v0 = svmla_m(p32_all, vc.v0, va.v0, vb.v0); //c.re += a.re * b.re
        vc.v1 = svmla_m(p32_all, vc.v1, va.v1, vb.v0); //c.im += a.im * b.re
        vc.v0 = svmls_m(p32_all, vc.v0, va.v1, vb.v1); //c.re -= a.im * b.im
        vc.v1 = svmla_m(p32_all, vc.v1, va.v0, vb.v1); //c.im += a.re * b.im

        svst2(p32_all, (float32_t*)&c[i], vc);
    }
}

int main()
{
    Complex_t a[SIZE] = {{1,2}, {2,3}, {-1,1}, {2,0}, {-2,1}}; //initializes first 5 numbers
    Complex_t b[SIZE] = {{2,2}, {3,2}, {1,-2}, {0,1}, {2,-3}}; //initializes first 5 numbers
    Complex_t c[SIZE] = {{0,0}}; //initializes all numbers to 0,0

    complex_dot_product(c, a, b);

    for (int i=0; i<5; i++) {
        printf("(%.1f+i%.1f).(%.1f+i%.1f) = (%.1f+i%.1f)\n", a[i].re, a[i].im, b[i].re, b[i].im, c[i].re, c[i].im);
    }
    return 0;
}
