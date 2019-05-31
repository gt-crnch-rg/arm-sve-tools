#include "stdio.h"
#include "stdlib.h"

int loop( double * restrict a,  double * restrict b,  double * restrict c,  double * restrict d,  double * restrict e, int LEN){
  int i = 0;
  while(i<LEN){
    if(i%2 == 0){
      a[i] = i + b[i] * c[i];
      e[i] = i + d[i] * c[i];
    }
    i++;
  }
  return 0;
}


int main(int argc, char *argv[]){

  int LEN = atoi(argv[1]);
  double *a = (double *) malloc(LEN*sizeof(double));
  double *b = (double *) malloc(LEN*sizeof(double));
  double *c = (double *) malloc(LEN*sizeof(double));
  double *d = (double *) malloc(LEN*sizeof(double));
  double *e = (double *) malloc(LEN*sizeof(double));

  int i;
  for(i = 0; i< LEN; i++){
    a[i] = i*1;
    b[i] = i*2;
    c[i] = i*3;
    d[i] = i*4;
    e[i] = i*5;

  }


  int res = loop(a, b, c, d, e, LEN);

  printf("Total: %d %f - %f\n", res, a[LEN-1], e[LEN-1]);

  return 0;
}

