#include "mm256_round_cvtps_epi32.h"

#if __x86_64__ 
#if defined(HAVE_AVX_INSTRUCTIONS) && defined(HAVE_AVX2_INSTRUCTIONS)

static _Alignas(64) __m256 sign_mask_256;

static _Alignas(64) __m256 half_mask_256;

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

__m256i mm256_round_cvtps_epi32(__m256 value)
{
    __m256 sign_floatx8, half_floatx8, result;
    sign_floatx8 = _mm256_and_ps(value, sign_mask_256);
    half_floatx8 = _mm256_or_ps(sign_floatx8, half_mask_256);
    result = _mm256_round_ps(_mm256_add_ps(value, half_floatx8), _MM_FROUND_TO_ZERO | _MM_FROUND_NO_EXC);
    return _mm256_cvtps_epi32(result);
}

static void init_sign_mask()
{
    uint32_t const sign_mask_u8[] = {
        0x80000000, 0x80000000, 0x80000000, 0x80000000,
        0x80000000, 0x80000000, 0x80000000, 0x80000000,
    };
    sign_mask_256 = *((__m256 *)sign_mask_u8);
}

static void init_half_mask()
{
    float const half_f[] = {
        0.5, 0.5, 0.5, 0.5,
        0.5, 0.5, 0.5, 0.5
    };
    half_mask_256 = _mm256_load_ps(half_f);
}

void init_mm256_round_cvtps_epi32()
{
    init_sign_mask();
    init_half_mask();
}

#endif
#endif
