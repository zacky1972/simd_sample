#include "basic_intrinsics.h"

void init_basic_intrinsics()
{
#if __x86_64__ 
#if defined(HAVE_AVX_INSTRUCTIONS) && defined(HAVE_AVX2_INSTRUCTIONS)
    init_mm256_unsigned_extend_epi8_to_epi32();
    init_mm256_round_cvtps_epi32();

#endif
#endif
}

#if __x86_64__ 
#if defined(HAVE_AVX_INSTRUCTIONS) && defined(HAVE_AVX2_INSTRUCTIONS)

extern inline void mm256_epi32_extract_epi8x(int index, __m256i *value, __m256i *result);

#endif
#endif
