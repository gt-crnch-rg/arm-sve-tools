Compiler Comparison with Naive Matrix Multiplication
====================================================

This version of the code has a naive implementation of a 
matrix-matrix multiplication.

The binary is run with three command line options, which 
represent the three dimensions of the matrices n, m, l. 
This then represents the following matrix operation:

C[n][l] = A[n][m] * B[m][l]

To compile run the code, simply type:

`make`

By default, this will use the GNU c++ compiler (g++) to build three versions
of the executable:
 * *_def.exe: Compilation without any optimizing compiler flags.
 * *_opt.exe: Compilation with a high level of optimization.
 * *_novec.exe: Compilation with a high level of optimization, but with automatic vectorization disabled.

To run all three versions, type:

`make run`

It's a good idea to clean between builds and runs.  Use the _clean_ make target
to remove build products:

`make clean`


Comparing Compiler Performance
==============================

Different compilers optimize different code differently, so there will never
be one compiler to rule them all.  You may need to try several compilers to
find the one compiler that works best for your code.  To easily compare the
performance of different compiers, add *COMPILER=_COMPILER_NAME_* to the make
command line.  For example, to compile with Arm compilers:

 `make all COMPILER=arm`

COMPILER can be one of:
 * gnu: GNU Compiler
 * arm: Arm Compiler for Linux
 * fujitsu: Fujitsu Compiler
 * cray: Cray Compiler

Next Steps
==========

Try building with various compilers.  Notice the relative performance of each
compiler.  Remember that **this is a naive, unoptimized code.** In the next 
steps, we will explore how to improve on performace by modifying the source.
