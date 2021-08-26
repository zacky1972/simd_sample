#include "mm256_unsigned_extend_epi8_to_epi32.h"

#if __x86_64__ 
#if defined(HAVE_AVX_INSTRUCTIONS) && defined(HAVE_AVX2_INSTRUCTIONS)

static _Alignas(64) __m256i shuffle_epi8_m256[2];
static _Alignas(64) __m256i permutevar8x32_epi32_m256[1];


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

__m256i mm256_unsigned_extend_epi8_to_epi32(__m256i a)
{
    __m256i shuffled_lower_256[2];
    shuffled_lower_256[0] = _mm256_shuffle_epi8(a, shuffle_epi8_m256[0]);
    shuffled_lower_256[1] = _mm256_shuffle_epi8(a, shuffle_epi8_m256[1]);
    shuffled_lower_256[1] = _mm256_permutevar8x32_epi32(shuffled_lower_256[1], permutevar8x32_epi32_m256[0]);
    return _mm256_max_epi32(shuffled_lower_256[0], shuffled_lower_256[1]);
}

void init_shuffle_epi8()
{
    uint8_t shuffle_epi8_u8[] = {
        0x00, 0x80, 0x80, 0x80, 0x01, 0x80, 0x80, 0x80,
        0x02, 0x80, 0x80, 0x80, 0x03, 0x80, 0x80, 0x80,
        0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80,
        0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80,
    
        0x04, 0x80, 0x80, 0x80, 0x05, 0x80, 0x80, 0x80,
        0x06, 0x80, 0x80, 0x80, 0x07, 0x80, 0x80, 0x80,
        0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80,
        0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80,
    };

    shuffle_epi8_m256[0] = _mm256_loadu_si256((__m256i *)&shuffle_epi8_u8[0]);
    shuffle_epi8_m256[1] = _mm256_loadu_si256((__m256i *)&shuffle_epi8_u8[32]);
}

void init_permute_var8x32_epi32()
{
    uint8_t permutevar8x32_epi32_u8[] = {
        0x04, 0x00, 0x00, 0x00, 0x05, 0x00, 0x00, 0x00,
        0x06, 0x00, 0x00, 0x00, 0x07, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00,
        0x02, 0x00, 0x00, 0x00, 0x03, 0x00, 0x00, 0x00,
    };

    permutevar8x32_epi32_m256[0] = _mm256_loadu_si256((__m256i *)&permutevar8x32_epi32_u8[0]);
}

void init_mm256_unsigned_extend_epi8_to_epi32()
{
    init_shuffle_epi8();
    init_permute_var8x32_epi32();
}

#endif
#endif
