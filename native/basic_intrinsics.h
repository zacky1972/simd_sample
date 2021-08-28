#ifndef BASIC_INTRINSICS_H
#define BASIC_INTRINSICS_H

#include "mm256_unsigned_extend_epi64_to_m256.h"
#include "mm256_unsigned_extend_epi8_to_epi32.h"
#include "mm256_round_cvtps_epi32.h"

void init_basic_intrinsics();


#if __x86_64__ 
#if defined(HAVE_AVX_INSTRUCTIONS) && defined(HAVE_AVX2_INSTRUCTIONS)

/*

    result[index][7:0]     = value[index][7:0]
    result[index][31:8]    = 0
    result[index][39:32]   = value[index][15:8]
    result[index][63:40]   = 0
    result[index][71:64]   = value[index][23:16]
    result[index][95:72]   = 0
    result[index][103:96]  = value[index][31:24]
    result[index][127:104] = 0
    result[index][135:128] = value[index][39:32]
    result[index][159:136] = 0
    result[index][167:160] = value[index][47:40]
    result[index][191:168] = 0
    result[index][199:192] = value[index][55:48]
    result[index][223:200] = 0
    result[index][231:224] = value[index][63:56]
    result[index][MAX:232] = 0

*/

inline void mm256_epi32_extract_epi8x(int index, __m256i *value, __m256i *result)
{
    _mm256_storeu_si256(&result[index], mm256_unsigned_extend_epi8_to_epi32(value[index]));
}

#endif
#endif

#endif // BASIC_INTRINSICS_H
