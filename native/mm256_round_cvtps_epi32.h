#ifndef MM256_ROUND_CVTPS_EPI32_H
#define MM256_ROUND_CVTPS_EPI32_H

#include "intrinsics.h"

#if __x86_64__ 
#if defined(HAVE_AVX_INSTRUCTIONS) && defined(HAVE_AVX2_INSTRUCTIONS)

__m256i mm256_round_cvtps_epi32(__m256 value);

void init_mm256_round_cvtps_epi32();

#endif
#endif

#endif // MM256_ROUND_CVTPS_EPI32_H
