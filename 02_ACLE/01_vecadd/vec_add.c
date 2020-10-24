#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

const size_t SIZE = 1024*1024;


void vec_add(float out[SIZE], float a[SIZE], float b[SIZE])
{
  for (size_t i=0; i<SIZE; ++i) {
    out[i] = a[i] + b[i];
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

  vec_add(x, a, b);

  for (size_t i=0; i<SIZE; ++i) {
    if (x[i] != 3) {
      printf("ERROR: x[%zd] = %g\n", i, x[i]);
      return 1;
    }
  }
  printf("OK\n");

  return EXIT_SUCCESS;
}

