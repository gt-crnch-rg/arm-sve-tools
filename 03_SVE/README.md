# SVE Programming Examples

This directory contains examples of hand-coded SVE and SVE2 code, either
in Assembly or in C with the Arm C Language Extensions (SVE intrinsics).
A corresponding C reference code is provided for functional correctness.

These examples were taken from https://developer.arm.com/documentation/dai0548/latest
and updated to separate SVE from SVE2 and better support native compilation
on CPUs that implement SVE or SVE2.

## SVE vs SVE2

SVE is the first generation of Arm's Scalable Vector Extension.  It introduces
Arm's vector lenght agnostic programming approach and provides many powerful
features to facilitate vectorization in complex codes.  Some of these features
are reduction instructions for a number of arithmetic operations, extensive 
load/store instruction support, predicate and loop control support, and logical 
and bitwise instructions support. The SVE instruction set also provides thorough 
floating-point arithmetic support, and basic integer arithmetic support.

SVE2, the Scalable Vector Extension v2, is a superset of the Armv8-A SVE with 
expanded functionality. The SVE2 instruction set adds thorough fixed-point 
arithmetic support and features that benefit media processing workloads.

Because SVE2 is a superset of SVE, CPUs that implement SVE2 can run SVE binaries
without any modifications.  However, CPUs that only implement SVE (such as the
Fujitsu A64FX) will not be able to run SVE2 binaries.  Attempting to run an SVE2
binary on such a CPU will generate an Illegal Instruction error.  

Use the Arm Instruction Emulator (ArmIE) to get started with SVE2 ahead of hardware 
availability.

## Usage

Each example includes a makefile to compile and run the code. Run the 
command `make` in each of the example directories to create an executable 
in the `build` subdirectory.  Type `make run` to compile and run the code. 
Run `make clean` to remove build products.  For example:

```bash
cd 06_matmul_f64
make 
make run
make clean
```


The list of software examples:

1.  Histogram computation.
    Vector length agnostic implementation.
    Location: software/histogram_vla/

2.  Histogram computation.
    Vector length specific 512-bit implementation.
    Location: software/histogram_vls512/

3.  Vector dot-product computation.
    Complex single-precision floating-point vector length agnostic
    implementation.
    Location: software/vecdot_cf32/

4.  Vector dot-product computation.
    Half-precision floating-point vector length agnostic
    implementation.
    Location: software/vecdot_f16/

5.  Vector dot-product computation.
    Complex signed 16-bit fixed-point vector length agnostic
    implementation.
    Location: software/vecdot_cs16/

6.  Vector multiply computation.
    Complex signed 16-bit fixed-point vector length agnostic
    implementation.
    Location: software/vecmul/

7.  Vector maximum element computation.
    Signed 16-bit fixed-point vector length agnostic implementation.
    Location: software/vecmax/

8.  Finite Impulse Response (FIR) filter computation.
    Single-precision floating-point vector length agnostic
    implementation.
    Location: software/fir_f32/

9.  Finite Impulse Response (FIR) filter computation.
    Signed 16-bit fixed-point vector length agnostic implementation.
    Location: software/fir_s16/

10. Skip white space string processing.
    Vector length agnostic implementation.
    Location: software/skipwhitespace/

11. Skip word string processing.
    Vector length agnostic implementation.
    Location: software/skipword/

12. String comparison processing.
    Vector length agnostic implementation.
    Location: software/strcmp/

13. Integral image computation.
    Single-precision floating-point vector length agnostic
    implementation.
    Location: software/integral_image_vla/

14. Integral image computation.
    Single-precision floating-point vector length specific 128-bit
    implementation.
    Location: software/integral_image_vls128/

15. Sobel filter computation.
    Single-precision floating-point vector length agnostic
    implementation.
    Location: software/sobel/

16. Matrix multiplication computation.
    Half-precision floating-point vector length agnostic
    implementation.
    Location: software/matmul_f16/

17. Matrix multiplication computation.
    Double-precision floating-point vector length agnostic
    implementation.
    Location: software/matmul_f64/

18. Matrix multiplication computation.
    Unsigned 8-bit fixed-point vector length agnostic implementation.
    Location: software/matmul_u8/
