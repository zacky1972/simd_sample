#include "mm256_extract_epi64_set_to_m256.h"

#if __x86_64__ 
#if defined(HAVE_AVX_INSTRUCTIONS) && defined(HAVE_AVX2_INSTRUCTIONS)

extern inline void mm256_extract_epi64_set_to_m256(__m256i value, __m256i *results)
;

#endif
#endif
