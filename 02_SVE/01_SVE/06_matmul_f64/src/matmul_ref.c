//------------------------------------------------------------------------------------
// Copyright (C) Arm Limited, 2019-2020 All rights reserved.
//
// The example code is provided to you as an aid to learning when working
// with Arm-based technology, including but not limited to programming tutorials.
//
// Arm hereby grants to you, subject to the terms and conditions of this Licence,
// a non-exclusive, non-transferable, non-sub-licensable, free-of-charge copyright
// licence, to use, copy and modify the Software solely for the purpose of internal
// demonstration and evaluation.
//
// You accept that the Software has not been tested by Arm therefore the Software
// is provided "as is", without warranty of any kind, express or implied. In no
// event shall the authors or copyright holders be liable for any claim, damages
// or other liability, whether in action or contract, tort or otherwise, arising
// from, out of or in connection with the Software or the use of Software.
//------------------------------------------------------------------------------------

#include "matmul.h"

void calc_matmul_ref(uint64_t M, uint64_t K, uint64_t N, float64_t* input_left, float64_t* input_right, float64_t* output)
{
    for(uint64_t x = 0; x < M; ++x)
    {
        for(uint64_t y = 0; y < N; ++y)
        {
            float64_t acc = 0.0;

            for(uint64_t z = 0; z < K; ++z)
            {
                acc += input_left[(x*K)+z] * input_right[(z*N)+y];
            }

            output[(x*N)+y] = acc;
        }
    }
}
