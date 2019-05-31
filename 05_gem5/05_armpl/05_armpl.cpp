#include <cstdlib>
#include <cstdio>
#include <ctime>
#include <chrono>
#include <armpl.h>

#ifndef BLOCKSIZE
#define BLOCKSIZE 16
#endif

using timer_clock= std::chrono::high_resolution_clock;

inline unsigned int min(unsigned int a, unsigned int b)
{
    return (a < b) ? a : b;
}



int main(int argc, char** argv)
{
    double *dataA= NULL;
    double **matA= NULL;
    double *dataB= NULL;
    double **matB= NULL;
    double *dataC= NULL;
    double **matC= NULL;
    double *dataBP= NULL;
    double **matBP= NULL;

    // Assume that the matrix dimensions have been passed in as n, m and l, where
    // A = n x m matrix
    // B = m x l matrix
    // C = n x l matrix
    
    unsigned int n, m, l;

    unsigned int i, j, k;

    if (argc < 4){
        printf("Usage: %s n m l\n", argv[0]);
        return 1;
    }

    n= (unsigned int)atoi(argv[1]);
    m= (unsigned int)atoi(argv[2]);
    l= (unsigned int)atoi(argv[3]);

    printf("Solving matmult for blocksize of %d\n", BLOCKSIZE);

    if((m%BLOCKSIZE) != 0 || (l%BLOCKSIZE) != 0){
       printf("Non-multiple blocksize (%d) for matrix (%u x %u)\n", BLOCKSIZE, m, l);
       exit(1);
    }

    // Assign memory
    dataA= (double*)malloc(n*m*sizeof(double));
    matA= (double**)malloc(n*sizeof(double*));
    dataB= (double*)malloc(m*l*sizeof(double));
    matB= (double**)malloc(m*sizeof(double*));
    dataC= (double*)malloc(n*l*sizeof(double));
    matC= (double**)malloc(n*sizeof(double*));
    // New B' - representing the transpose
    dataBP= (double*)malloc(m*l*sizeof(double));
    matBP= (double**)malloc(l*sizeof(double*));

    timer_clock::time_point t1= timer_clock::now();
    // Set up the matrices in row major format
    for(i= 0; i < n; ++i){
        matA[i]= dataA + i*m;
        matC[i]= dataC + i*l;
    }

    for(i= 0; i < m; ++i){
        matB[i]= dataB + i*l;
    }

    for(i= 0; i < l; ++i){
        matBP[i]= dataBP + i*m;
    }

    // Initialise matrices. Matrices A and B get random data. Results matrix C
    // is initialised to zero
    srand(time(NULL));
    for (i= 0; i < n; ++i){
        for (j= 0; j < m; ++j){
#ifdef DEBUG
            matA[i][j]= (double)j*i*1;
#else
            matA[i][j]= ((double)rand()) / RAND_MAX;
#endif
        }

        for (j= 0; j < l; ++j){
            matC[i][j]= 0.0;
        }
    }

    for (i= 0; i < m; ++i){
        for (j= 0; j < l; ++j){
#ifdef DEBUG
            matB[i][j]= (double)j*i*1;
#else
            matB[i][j]= ((double)rand()) / RAND_MAX;
#endif
        }
    }

    timer_clock::time_point t2= timer_clock::now();
    std::chrono::duration<double> time_span= std::chrono::duration_cast<std::chrono::duration<double>>(t2 - t1);
    printf("Initialisation of matrices took: %.3lf seconds\n", time_span.count());

    // Perform the matrix-matrix multiplication naively
    printf("Performing naive multiply\n");
    

    t1= timer_clock::now();
    cblas_dgemm(CblasRowMajor, CblasNoTrans, CblasNoTrans, n, m, l, 1, dataA,
            m, dataB, l, 1, dataC, m);

    t2= timer_clock::now();
    time_span= std::chrono::duration_cast<std::chrono::duration<double>>(t2 - t1);
    printf("Naive multiply took: %.3lf seconds\n", time_span.count());

#ifdef DEBUG
    double total = 0;
    for (i= 0; i < n; ++i){
        for (j= 0; j < l; ++j){
            total += matC[i][j];
        }
    }
    printf("Final result: %f\n", total);
#endif

    // Free memory
    free(matA);
    free(dataA);
    free(matB);
    free(dataB);
    free(matC);
    free(dataC);
    free(matBP);
    free(dataBP);
}
