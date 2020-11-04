#include <iostream>
#include <cstdint>
#include <chrono>
#include <cstdlib>

extern "C" void kernel(std::uint64_t);

// unroll 4x
asm(R"(
	.global kernel
kernel:
	mov x20, xzr
  
loop:
	fmla z0.d, p0/m, z30.d, z31.d
	fmla z1.d, p0/m, z30.d, z31.d
	fmla z2.d, p0/m, z30.d, z31.d
	fmla z3.d, p0/m, z30.d, z31.d
	fmla z4.d, p0/m, z30.d, z31.d
	fmla z5.d, p0/m, z30.d, z31.d
	fmla z6.d, p0/m, z30.d, z31.d
	fmla z7.d, p0/m, z30.d, z31.d
	fmla z8.d, p0/m, z30.d, z31.d
	fmla z9.d, p0/m, z30.d, z31.d
	fmla z10.d, p0/m, z30.d, z31.d
	fmla z11.d, p0/m, z30.d, z31.d
	fmla z12.d, p0/m, z30.d, z31.d
	fmla z13.d, p0/m, z30.d, z31.d
	fmla z14.d, p0/m, z30.d, z31.d
	fmla z15.d, p0/m, z30.d, z31.d
	add x20, x20, 1
	fmla z0.d, p0/m, z30.d, z31.d
	fmla z1.d, p0/m, z30.d, z31.d
	fmla z2.d, p0/m, z30.d, z31.d
	fmla z3.d, p0/m, z30.d, z31.d
	fmla z4.d, p0/m, z30.d, z31.d
	fmla z5.d, p0/m, z30.d, z31.d
	fmla z6.d, p0/m, z30.d, z31.d
	fmla z7.d, p0/m, z30.d, z31.d
	fmla z8.d, p0/m, z30.d, z31.d
	fmla z9.d, p0/m, z30.d, z31.d
	fmla z10.d, p0/m, z30.d, z31.d
	fmla z11.d, p0/m, z30.d, z31.d
	fmla z12.d, p0/m, z30.d, z31.d
	fmla z13.d, p0/m, z30.d, z31.d
	fmla z14.d, p0/m, z30.d, z31.d
	fmla z15.d, p0/m, z30.d, z31.d
	cmp x0, x20
	fmla z0.d, p0/m, z30.d, z31.d
	fmla z1.d, p0/m, z30.d, z31.d
	fmla z2.d, p0/m, z30.d, z31.d
	fmla z3.d, p0/m, z30.d, z31.d
	fmla z4.d, p0/m, z30.d, z31.d
	fmla z5.d, p0/m, z30.d, z31.d
	fmla z6.d, p0/m, z30.d, z31.d
	fmla z7.d, p0/m, z30.d, z31.d
	fmla z8.d, p0/m, z30.d, z31.d
	fmla z9.d, p0/m, z30.d, z31.d
	fmla z10.d, p0/m, z30.d, z31.d
	fmla z11.d, p0/m, z30.d, z31.d
	fmla z12.d, p0/m, z30.d, z31.d
	fmla z13.d, p0/m, z30.d, z31.d
	fmla z14.d, p0/m, z30.d, z31.d
	fmla z15.d, p0/m, z30.d, z31.d
	fmla z0.d, p0/m, z30.d, z31.d
	fmla z1.d, p0/m, z30.d, z31.d
	fmla z2.d, p0/m, z30.d, z31.d
	fmla z3.d, p0/m, z30.d, z31.d
	fmla z4.d, p0/m, z30.d, z31.d
	fmla z5.d, p0/m, z30.d, z31.d
	fmla z6.d, p0/m, z30.d, z31.d
	fmla z7.d, p0/m, z30.d, z31.d
	fmla z8.d, p0/m, z30.d, z31.d
	fmla z9.d, p0/m, z30.d, z31.d
	fmla z10.d, p0/m, z30.d, z31.d
	fmla z11.d, p0/m, z30.d, z31.d
	fmla z12.d, p0/m, z30.d, z31.d
	fmla z13.d, p0/m, z30.d, z31.d
	fmla z14.d, p0/m, z30.d, z31.d
	fmla z15.d, p0/m, z30.d, z31.d
	bne loop

end:
	ret
)");

int main(int argc, char ** argv) 
{
    using namespace std;

    const uint64_t iters = 1000000ul;

    const uint64_t lanes = 64 / sizeof(double);
    const uint64_t flops = 32; // 16 fmla = 32 flops
    const uint64_t unroll = 4; // match kernel asm
    const uint64_t kernel_flops = lanes * flops * unroll * iters;

    auto start = chrono::steady_clock::now();
    kernel(iters);
    auto end = chrono::steady_clock::now();
    double seconds=chrono::duration_cast<chrono::microseconds>(end-start).count();
    seconds = seconds * 1e-6;
    double gflops = kernel_flops / (seconds * 1e9);

    cout << kernel_flops << " Flops in " << seconds << " seconds" << endl;
    cout << gflops << " GFlops" << endl;

    return 0;
}
