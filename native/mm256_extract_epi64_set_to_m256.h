#ifndef MM256_EXTRACT_EPI64_SET_TO_M256_H
#define MM256_EXTRACT_EPI64_SET_TO_M256_H

#include "intrinsics.h"

#if __x86_64__ 
#if defined(HAVE_AVX_INSTRUCTIONS) && defined(HAVE_AVX2_INSTRUCTIONS)

inline void mm256_extract_epi64_set_to_m256(__m256i value, __m256i *results)
{
    results[0] = _mm256_setr_epi64x(_mm256_extract_epi64(value, 0), 0, 0, 0);
    results[1] = _mm256_setr_epi64x(_mm256_extract_epi64(value, 1), 0, 0, 0);
    results[2] = _mm256_setr_epi64x(_mm256_extract_epi64(value, 2), 0, 0, 0);
    results[3] = _mm256_setr_epi64x(_mm256_extract_epi64(value, 3), 0, 0, 0);
}

#endif
#endif

#endif // MM256_EXTRACT_EPI64_SET_TO_M256_H
