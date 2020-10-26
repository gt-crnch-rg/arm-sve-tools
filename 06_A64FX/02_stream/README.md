# Measuring bandwith with STREAM

The STREAM benchmark is a defacto standard for measuring memory bandwidth.
The benchmark includes four kernels: COPY, SCALE, ADD, and TRIAD. The kernels
are executed in sequence in a loop.  Two parameters configure STREAM:
 * `STREAM_ARRAY_SIZE`: The number of double-precision elements in each array.
   It is critical to select a sufficiently large STREAM_ARRAY_SIZE when measuring 
   bandwidth to/from main memory.
 * `NTIMES`: The number of iterations of the test loop.

This example is structured to demonstrate the performance benefits of OpenMP,
effective use of NUMA, and features of the Arm architecture.  It uses a version of
stream that has been modified to enable dynamic memory allocation and to separate 
the kernel implementation from the benchmark driver.  This makes it the code easier
to read and faciliatates the use of external tools to measure the performance in 
each kernel.

## 01_stream_vanilla

This is a basic, untuned, out-of-box, "vanilla" implementation of STREAM. 
Performance will most likely be very poor since it uses only a single core and 
does not consider NUMA or any architectural features.

## 02_stream_openmp

A moderately tuned version of STREAM that uses OpenMP to span multiple threads 
and numactl to improve memory/thread locality.  On many systems, this implementation 
of STREAM will be close to 80% of the theoretical peak bandwidth.

## 03_stream_triad

A cut-down version of STREAM that only invokes the TRIAD kernel.  This version 
is useful for viewing particular performance counters and iterating over optimization 
strategies for a target platform.

## 04_stream_zfill

An optimized version of STREAM that uses Arm's `DC ZVA` instruction to zero-fill
cache lines.  `DC ZVA` isn't a prefetch instruction, but rather a way to map cache 
lines to virtual memory without having to read main memory.  Many architectures 
(not just Arm's) load a whole cache line from main memory when any address in the 
line is written to.  This is so that when the cache line is flushed the addresses 
adjacent to the written address retain their values.  On Arm, if you know for certain 
that the entire cache line will be written before it is flushed (or you you want to 
write zeros to main memory in any case), you can use the "DC ZVA" instruction to map 
the cache line to the appropriate virtual address without first reading main memory.  
All values in the cache line will be set to zero.  

This optimization can dramatically improve the performance of systems with wide L2 
cache lines and/or very little available L3 cache.  The Fujitsu A64FX has no L3, and 
each L2 cache is 256 bytes, so a "useless" load of the destination array from main 
memory has a much higher penalty on A64FX.

## 05_stream_zfill_acle

Further optimization of the 04_stream_zfill vesion that uses SVE intrinsics via the 
Arm C Language Extensions (ACLE).  The memory bandwidth performance of this version 
does not improve, but the number of front-end bound cyles is reduced due to more 
effective vectorization of the inner loop.  Since STREAM is backend-bound on main
memory, there is no gain.


