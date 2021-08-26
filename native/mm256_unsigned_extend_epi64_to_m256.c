#include "mm256_unsigned_extend_epi64_to_m256.h"

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

extern inline void mm256_unsigned_extend_epi64_to_m256(__m256i value, __m256i *results)
;

#endif
#endif
