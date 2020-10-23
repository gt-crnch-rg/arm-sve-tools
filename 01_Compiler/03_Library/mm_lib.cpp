#include <cstdlib>
#include <cstdio>
#include <ctime>
#include <chrono>

#if defined(USE_ARMPL)

#include <armpl.h>
#define LIBRARY_NAME "ArmPL"

#elif defined(USE_SSL2)

#include <cssl.h>
#define LIBRARY_NAME "SSL2"

#elif defined(USE_CBLAS)

#include <cblas.h>
#define LIBRARY_NAME "CBLAS"

#else
#error Unsupported library
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

    // Assume that the matrix dimensions have been passed in as n, m and l, where
    // A = n x m matrix
    // B = m x l matrix
    // C = n x l matrix
    
    unsigned int n, m, l;

    unsigned int i, j;

    if (argc < 4){
        printf("Usage: %s n m l\n", argv[0]);
        return 1;
    }

    n= (unsigned int)atoi(argv[1]);
    m= (unsigned int)atoi(argv[2]);
    l= (unsigned int)atoi(argv[3]);

    // Assign memory
    dataA= (double*)malloc(n*m*sizeof(double));
    matA= (double**)malloc(n*sizeof(double*));
    dataB= (double*)malloc(m*l*sizeof(double));
    matB= (double**)malloc(m*sizeof(double*));
    dataC= (double*)malloc(n*l*sizeof(double));
    matC= (double**)malloc(n*sizeof(double*));

    timer_clock::time_point t1= timer_clock::now();

    // Set up the matrices in row major format
    for(i= 0; i < n; ++i){
        matA[i]= dataA + i*m;
        matC[i]= dataC + i*l;
    }

    for(i= 0; i < m; ++i){
        matB[i]= dataB + i*l;
    }

    srand(time(NULL));
    for (i= 0; i < n; ++i){
        for (j= 0; j < m; ++j){
            matA[i][j]= ((double)rand()) / RAND_MAX;
        }

        for (j= 0; j < l; ++j){
            matC[i][j]= 0.0;
        }
    }

    for (i= 0; i < m; ++i){
        for (j= 0; j < l; ++j){
            matB[i][j]= ((double)rand()) / RAND_MAX;
        }
    }

    timer_clock::time_point t2= timer_clock::now();
    std::chrono::duration<double> time_span= std::chrono::duration_cast<std::chrono::duration<double>>(t2 - t1);
    printf("Set up of matrices took: %.3lf seconds\n", time_span.count());

    // Perform the matrix-matrix multiplication with the library
    t1= timer_clock::now();
    printf("Using BLAS routine from %s library\n", LIBRARY_NAME);
#if defined(USE_ARMPL) || defined(USE_CBLAS)
    cblas_dgemm(CblasRowMajor, CblasNoTrans, CblasNoTrans, n, m, l, 1, dataA,
            m, dataB, l, 1, dataC, m);
#elif defined(USE_SSL2)
    int icon, ierr;
    ierr = c_dvmggm(dataA, m, dataB, l, dataC, l, n, m, l, &icon);
#endif
    t2= timer_clock::now();
    time_span= std::chrono::duration_cast<std::chrono::duration<double>>(t2 - t1);
    printf("%s library took: %.3lf seconds\n", LIBRARY_NAME, time_span.count());

    // Free memory
    free(matA);
    free(dataA);
    free(matB);
    free(dataB);
    free(matC);
    free(dataC);
}
