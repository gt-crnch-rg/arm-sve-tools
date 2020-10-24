# Compiler Comparison with Blocked Matrix Multiplication

For this example we improve on the native matrix multiplication code
by implementing a simple cache blocking scheme.  The block size is
passed on the command line. To compile the code, simply type:

> `make`

By default, this will use the GNU c++ compiler (g++) to build three versions
of the executable:
 * *_def.exe: Compilation without any optimizing compiler flags.
 * *_opt.exe: Compilation with a high level of optimization.
 * *_novec.exe: Compilation with a high level of optimization, but with automatic vectorization disabled.

To run all three versions, type:

> `make run`

It's a good idea to clean between builds and runs.  Use the _clean_ make target
to remove build products:

> `make clean`

Try building with different compilers and notice the relative performance of 
each compiler. All compilers *should* show a significant performance gain in
comparison to the native version.


