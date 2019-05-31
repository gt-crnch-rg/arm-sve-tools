#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <arm_sve.h>

const size_t SIZE = 1024*1024;


void vec_svadd_m(float c[SIZE], float a[SIZE], float b[SIZE])
{
  // Stride by the number of words in the vector
  for (size_t i=0; i<SIZE; i+=svcntw()) {
    // Operate on vector lanes where i < SIZE
    svbool_t pred = svwhilelt_b32(i, SIZE);
    // Load a vector of a
    svfloat32_t sva = svld1(pred, a+i);
    // Load a vector of b
    svfloat32_t svb = svld1(pred, b+i);
    // Add a to b
    svfloat32_t svc = svadd_m(pred, sva, svb);
    // Store a+b 
    svst1(pred, c+i, svc);
  }
}

int main(int argc, char * argv[])
{
  float * x = (float*)malloc(SIZE*sizeof(float)); 
  float * a = (float*)malloc(SIZE*sizeof(float)); 
  float * b = (float*)malloc(SIZE*sizeof(float)); 

  for (size_t i=0; i<SIZE; ++i) {
    x[i] = 0;
    a[i] = 1;
    b[i] = 2;
  }

  vec_svadd_m(x, a, b);

  for (size_t i=0; i<SIZE; ++i) {
    if (x[i] != 3) {
      printf("ERROR: x[%zd] = %g\n", i, x[i]);
      return 1;
    }
  }
  printf("OK\n");

  return EXIT_SUCCESS;
}

