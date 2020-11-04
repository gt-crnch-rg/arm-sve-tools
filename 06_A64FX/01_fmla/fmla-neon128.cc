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
	fmla v0.2d, v30.2d, v31.2d
	fmla v1.2d, v30.2d, v31.2d
	fmla v2.2d, v30.2d, v31.2d
	fmla v3.2d, v30.2d, v31.2d
	fmla v4.2d, v30.2d, v31.2d
	fmla v5.2d, v30.2d, v31.2d
	fmla v6.2d, v30.2d, v31.2d
	fmla v7.2d, v30.2d, v31.2d
	fmla v8.2d, v30.2d, v31.2d
	fmla v9.2d, v30.2d, v31.2d
	fmla v10.2d, v30.2d, v31.2d
	fmla v11.2d, v30.2d, v31.2d
	fmla v12.2d, v30.2d, v31.2d
	fmla v13.2d, v30.2d, v31.2d
	fmla v14.2d, v30.2d, v31.2d
	fmla v15.2d, v30.2d, v31.2d
	add x20, x20, 1
	fmla v0.2d, v30.2d, v31.2d
	fmla v1.2d, v30.2d, v31.2d
	fmla v2.2d, v30.2d, v31.2d
	fmla v3.2d, v30.2d, v31.2d
	fmla v4.2d, v30.2d, v31.2d
	fmla v5.2d, v30.2d, v31.2d
	fmla v6.2d, v30.2d, v31.2d
	fmla v7.2d, v30.2d, v31.2d
	fmla v8.2d, v30.2d, v31.2d
	fmla v9.2d, v30.2d, v31.2d
	fmla v10.2d, v30.2d, v31.2d
	fmla v11.2d, v30.2d, v31.2d
	fmla v12.2d, v30.2d, v31.2d
	fmla v13.2d, v30.2d, v31.2d
	fmla v14.2d, v30.2d, v31.2d
	fmla v15.2d, v30.2d, v31.2d
	cmp x0, x20
	fmla v0.2d, v30.2d, v31.2d
	fmla v1.2d, v30.2d, v31.2d
	fmla v2.2d, v30.2d, v31.2d
	fmla v3.2d, v30.2d, v31.2d
	fmla v4.2d, v30.2d, v31.2d
	fmla v5.2d, v30.2d, v31.2d
	fmla v6.2d, v30.2d, v31.2d
	fmla v7.2d, v30.2d, v31.2d
	fmla v8.2d, v30.2d, v31.2d
	fmla v9.2d, v30.2d, v31.2d
	fmla v10.2d, v30.2d, v31.2d
	fmla v11.2d, v30.2d, v31.2d
	fmla v12.2d, v30.2d, v31.2d
	fmla v13.2d, v30.2d, v31.2d
	fmla v14.2d, v30.2d, v31.2d
	fmla v15.2d, v30.2d, v31.2d
	fmla v0.2d, v30.2d, v31.2d
	fmla v1.2d, v30.2d, v31.2d
	fmla v2.2d, v30.2d, v31.2d
	fmla v3.2d, v30.2d, v31.2d
	fmla v4.2d, v30.2d, v31.2d
	fmla v5.2d, v30.2d, v31.2d
	fmla v6.2d, v30.2d, v31.2d
	fmla v7.2d, v30.2d, v31.2d
	fmla v8.2d, v30.2d, v31.2d
	fmla v9.2d, v30.2d, v31.2d
	fmla v10.2d, v30.2d, v31.2d
	fmla v11.2d, v30.2d, v31.2d
	fmla v12.2d, v30.2d, v31.2d
	fmla v13.2d, v30.2d, v31.2d
	fmla v14.2d, v30.2d, v31.2d
	fmla v15.2d, v30.2d, v31.2d
	bne loop
end:
	ret
)");

int main(int argc, char ** argv) 
{
    using namespace std;

    const uint64_t iters = 1000000ul;

    const uint64_t lanes = 16 / sizeof(double);
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
