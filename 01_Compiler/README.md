Arm SVE Compilers Tutorial
==========================

In this tutorial, we will work with various compilers to explore 
how each compiler works and how to get the most out of it. We will 
use a simple matrix-matrix multiplication code since it is a common 
motif that presents opportunities to show the relative performance 
of different compiler flags and scientific computing libraries.

We begin with a naive implementation of the kernel and show how compiler
flags and optimized math libraries can be used to dramatically improve
the kernel's runtime performance.  Each step of this tutorial improves
on the performance of the previous step, so it's a good idea to take
them in order.

Different compilers optimize different loops differently.

