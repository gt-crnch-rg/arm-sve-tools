# SVE Programming Examples

This directory contains several examples of hand-coded SVE and SVE2
code (in Assembly or in C with SVE intrinsics) and the corresponding C
reference code, and performs a comparison between the two as a test
for functional correctness.


Run the command 'make' in each of the example directories
software/<example>/ in order to compile the code and create an
executable in the software/<example>/build/ directory. Run 'make
clean' to clear the directory.

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
