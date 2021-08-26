#ifndef MM256_UNSIGNED_EXTEND_EPI64_TO_M256_H
#define MM256_UNSIGNED_EXTEND_EPI64_TO_M256_H

#include "intrinsics.h"

#if __x86_64__ 
#if defined(HAVE_AVX_INSTRUCTIONS) && defined(HAVE_AVX2_INSTRUCTIONS)

/*

Description
    Unsigned extend packed 64-bit integers in value to packed 256-bit integers,
    and store the results consist of four 256-bit integers.


Operation
    results[0][63:0] := value[63:0]
    results[0][MAX:64] := 0
    results[1][63:0] := (value[255:0] >> 64)[63:0]
    results[1][MAX:64] := 0
    results[2][63:0] := (value[255:0] >> 128)[63:0]
    results[2][MAX:64] := 0
    results[3][63:0] := (value[255:0] >> 192)[63:0]
    results[3][MAX:64] := 0

*/

inline void mm256_unsigned_extend_epi64_to_m256(__m256i value, __m256i *results)
{
    results[0] = _mm256_setr_epi64x(_mm256_extract_epi64(value, 0), 0, 0, 0);
    results[1] = _mm256_setr_epi64x(_mm256_extract_epi64(value, 1), 0, 0, 0);
    results[2] = _mm256_setr_epi64x(_mm256_extract_epi64(value, 2), 0, 0, 0);
    results[3] = _mm256_setr_epi64x(_mm256_extract_epi64(value, 3), 0, 0, 0);
}

#endif
#endif

#endif // MM256_UNSIGNED_EXTEND_EPI64_TO_M256_H
