#ifndef MM256_ROUND_CVTPS_EPI32_H
#define MM256_ROUND_CVTPS_EPI32_H

#include "intrinsics.h"

#if __x86_64__ 
#if defined(HAVE_AVX_INSTRUCTIONS) && defined(HAVE_AVX2_INSTRUCTIONS)

/*

Description
    Round packed single-precision (32-bit) floating-point elements in value, convert them to packed 32-bit integers,
    and store the results in dst.

Operation
    FOR j := 0 to 7
        i := 32 * j
        dst[i+31:i] := Convert_FP32_To_Int32(round(value[i+31:i]))
    ENDFOR
    dst[MAX:256] := 0

*/

__m256i mm256_round_cvtps_epi32(__m256 value);

void init_mm256_round_cvtps_epi32();

#endif
#endif

#endif // MM256_ROUND_CVTPS_EPI32_H
