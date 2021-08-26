#ifndef MM256_UNSIGNED_EXTEND_EPI8_TO_EPI32_H
#define MM256_UNSIGNED_EXTEND_EPI8_TO_EPI32_H

#include "intrinsics.h"

#if __x86_64__ 
#if defined(HAVE_AVX_INSTRUCTIONS) && defined(HAVE_AVX2_INSTRUCTIONS)

/*

Description
    Unsigned extend packed 8bit integers from a to packed 32-bit integers, 
    and store the result in dst.

Operation
    dst[7:0]     = a[7:0]
    dst[31:8]    = 0
    dst[39:32]   = a[15:8]
    dst[63:40]   = 0
    dst[71:64]   = a[23:16]
    dst[95:72]   = 0
    dst[103:96]  = a[31:24]
    dst[127:104] = 0
    dst[135:128] = a[39:32]
    dst[159:136] = 0
    dst[167:160] = a[47:40]
    dst[191:168] = 0
    dst[199:192] = a[55:48]
    dst[223:200] = 0
    dst[231:224] = a[63:56]
    dst[MAX:232] = 0

*/

__m256i mm256_unsigned_extend_epi8_to_epi32(__m256i a);

void init_mm256_unsigned_extend_epi8_to_epi32();

#endif
#endif

#endif // MM256_UNSIGNED_EXTEND_EPI8_TO_EPI32_H
