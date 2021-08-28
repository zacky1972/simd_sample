#ifndef __x86_64__
#error
#endif

#include "../alignas.h"
#include "../intrinsics.h"
#include "../basic_intrinsics.h"
#include "../monochrome_filter_1.h"
#include "../basic.h"

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

extern inline void mm256_epi32_extract_epi8x(int index, __m256i *value, __m256i *result);

static _Alignas(64) __m256 mono_r_256, mono_g_256, mono_b_256;

void init_mono_256()
{
    _Alignas(64) float const mono_cons_r[] = {
        0.299,
        0.299,
        0.299,
        0.299,
        0.299,
        0.299,
        0.299,
        0.299,
    };
    _Alignas(64) float const mono_cons_g[] = {
        0.587,
        0.587,
        0.587,
        0.587,
        0.587,
        0.587,
        0.587,
        0.587,
    };
    _Alignas(64) float const mono_cons_b[] = {
        0.114, 0.114, 0.114, 0.114,
        0.114, 0.114, 0.114, 0.114};

    mono_r_256 = _mm256_load_ps(mono_cons_r);
    mono_g_256 = _mm256_load_ps(mono_cons_g);
    mono_b_256 = _mm256_load_ps(mono_cons_b);
}

#elif defined(HAVE_SSE_INSTRUCTIONS) && defined(HAVE_SSE3_INSTRUCTIONS) && defined(HAVE_SSE4_2_INSTRUCTIONS)
static _Alignas(64) __m128 mono_r_128, mono_g_128, mono_b_128;
static _Alignas(64) __m64 shuffle_higher_64, shuffle_lower_64;
static _Alignas(64) __m128 sign_mask_128, half_mask_128;
#else
#endif

void monochrome_filter_1(size_t size, uint8_t *pixel_r, uint8_t *pixel_g, uint8_t *pixel_b)
{
#if defined(HAVE_AVX_INSTRUCTIONS) && defined(HAVE_AVX2_INSTRUCTIONS)
    for (uint_fast16_t i = 0; i < size; i += 32)
    {
        __m256i pur_256, pug_256, pub_256;
        pur_256 = _mm256_loadu_si256((__m256i *)&pixel_r[i]);
        pug_256 = _mm256_loadu_si256((__m256i *)&pixel_g[i]);
        pub_256 = _mm256_loadu_si256((__m256i *)&pixel_b[i]);

        __m256i extracted_pur64[4], extracted_pug64[4], extracted_pub64[4];
        mm256_unsigned_extend_epi64_to_m256(pur_256, extracted_pur64);
        mm256_unsigned_extend_epi64_to_m256(pug_256, extracted_pug64);
        mm256_unsigned_extend_epi64_to_m256(pub_256, extracted_pub64);

        __m256i epi32_pixel_r[4], epi32_pixel_g[4], epi32_pixel_b[4];
        mm256_epi32_extract_epi8x(0, extracted_pur64, epi32_pixel_r);
        mm256_epi32_extract_epi8x(1, extracted_pur64, epi32_pixel_r);
        mm256_epi32_extract_epi8x(2, extracted_pur64, epi32_pixel_r);
        mm256_epi32_extract_epi8x(3, extracted_pur64, epi32_pixel_r);
        mm256_epi32_extract_epi8x(0, extracted_pug64, epi32_pixel_g);
        mm256_epi32_extract_epi8x(1, extracted_pug64, epi32_pixel_g);
        mm256_epi32_extract_epi8x(2, extracted_pug64, epi32_pixel_g);
        mm256_epi32_extract_epi8x(3, extracted_pug64, epi32_pixel_g);
        mm256_epi32_extract_epi8x(0, extracted_pub64, epi32_pixel_b);
        mm256_epi32_extract_epi8x(1, extracted_pub64, epi32_pixel_b);
        mm256_epi32_extract_epi8x(2, extracted_pub64, epi32_pixel_b);
        mm256_epi32_extract_epi8x(3, extracted_pub64, epi32_pixel_b);

        __m256 floatx8_pixel_r[4], floatx8_pixel_g[4], floatx8_pixel_b[4];
        floatx8_pixel_r[0] = _mm256_cvtepi32_ps(epi32_pixel_r[0]);
        floatx8_pixel_r[1] = _mm256_cvtepi32_ps(epi32_pixel_r[1]);
        floatx8_pixel_r[2] = _mm256_cvtepi32_ps(epi32_pixel_r[2]);
        floatx8_pixel_r[3] = _mm256_cvtepi32_ps(epi32_pixel_r[3]);
        floatx8_pixel_g[0] = _mm256_cvtepi32_ps(epi32_pixel_g[0]);
        floatx8_pixel_g[1] = _mm256_cvtepi32_ps(epi32_pixel_g[1]);
        floatx8_pixel_g[2] = _mm256_cvtepi32_ps(epi32_pixel_g[2]);
        floatx8_pixel_g[3] = _mm256_cvtepi32_ps(epi32_pixel_g[3]);
        floatx8_pixel_b[0] = _mm256_cvtepi32_ps(epi32_pixel_b[0]);
        floatx8_pixel_b[1] = _mm256_cvtepi32_ps(epi32_pixel_b[1]);
        floatx8_pixel_b[2] = _mm256_cvtepi32_ps(epi32_pixel_b[2]);
        floatx8_pixel_b[3] = _mm256_cvtepi32_ps(epi32_pixel_b[3]);

        floatx8_pixel_r[0] = _mm256_mul_ps(floatx8_pixel_r[0], mono_r_256);
        floatx8_pixel_r[1] = _mm256_mul_ps(floatx8_pixel_r[1], mono_r_256);
        floatx8_pixel_r[2] = _mm256_mul_ps(floatx8_pixel_r[2], mono_r_256);
        floatx8_pixel_r[3] = _mm256_mul_ps(floatx8_pixel_r[3], mono_r_256);
        floatx8_pixel_g[0] = _mm256_mul_ps(floatx8_pixel_g[0], mono_g_256);
        floatx8_pixel_g[1] = _mm256_mul_ps(floatx8_pixel_g[1], mono_g_256);
        floatx8_pixel_g[2] = _mm256_mul_ps(floatx8_pixel_g[2], mono_g_256);
        floatx8_pixel_g[3] = _mm256_mul_ps(floatx8_pixel_g[3], mono_g_256);
        floatx8_pixel_b[0] = _mm256_mul_ps(floatx8_pixel_b[0], mono_b_256);
        floatx8_pixel_b[1] = _mm256_mul_ps(floatx8_pixel_b[1], mono_b_256);
        floatx8_pixel_b[2] = _mm256_mul_ps(floatx8_pixel_b[2], mono_b_256);
        floatx8_pixel_b[3] = _mm256_mul_ps(floatx8_pixel_b[3], mono_b_256);

        __m256 mono[4];
        mono[0] = _mm256_add_ps(_mm256_add_ps(floatx8_pixel_r[0], floatx8_pixel_g[0]), floatx8_pixel_b[0]);
        mono[1] = _mm256_add_ps(_mm256_add_ps(floatx8_pixel_r[1], floatx8_pixel_g[1]), floatx8_pixel_b[1]);
        mono[2] = _mm256_add_ps(_mm256_add_ps(floatx8_pixel_r[2], floatx8_pixel_g[2]), floatx8_pixel_b[2]);
        mono[3] = _mm256_add_ps(_mm256_add_ps(floatx8_pixel_r[3], floatx8_pixel_g[3]), floatx8_pixel_b[3]);

        __m256i m[4];
        m[0] = mm256_round_cvtps_epi32(mono[0]);
        m[1] = mm256_round_cvtps_epi32(mono[1]);
        m[2] = mm256_round_cvtps_epi32(mono[2]);
        m[3] = mm256_round_cvtps_epi32(mono[3]);

        char *s = (char *)m;
        __m256i pr = _mm256_set_epi8(
            s[0x7c], s[0x78], s[0x74], s[0x70],
            s[0x6c], s[0x68], s[0x64], s[0x60],
            s[0x5c], s[0x58], s[0x54], s[0x50],
            s[0x4c], s[0x48], s[0x44], s[0x40],
            s[0x3c], s[0x38], s[0x34], s[0x30],
            s[0x2c], s[0x28], s[0x24], s[0x20],
            s[0x1c], s[0x18], s[0x14], s[0x10],
            s[0x0c], s[0x08], s[0x04], s[0x00]);

        _mm256_storeu_si256((__m256i *)&pixel_r[i], pr);
        _mm256_storeu_si256((__m256i *)&pixel_g[i], pr);
        _mm256_storeu_si256((__m256i *)&pixel_b[i], pr);
    }
#elif defined(HAVE_SSE_INSTRUCTIONS) && defined(HAVE_SSE3_INSTRUCTIONS) && defined(HAVE_SSE4_2_INSTRUCTIONS)
    for (uint_fast16_t i = 0; i < size; i += 8)
    {
        uint8_t *ptr_r = &pixel_r[i];
        uint8_t *ptr_g = &pixel_g[i];
        uint8_t *ptr_b = &pixel_b[i];

        __m64 pru = *((__m64 *)ptr_r);
        __m64 pgu = *((__m64 *)ptr_g);
        __m64 pbu = *((__m64 *)ptr_b);

        __m128 prf_l = _mm_cvtpu8_ps(pru);
        __m128 prf_h = _mm_cvtpu8_ps(_mm_shuffle_pi8(pru, shuffle_higher_64));
        prf_l = _mm_mul_ps(prf_l, mono_r_128);
        prf_h = _mm_mul_ps(prf_h, mono_r_128);

        __m128 pgf_l = _mm_cvtpu8_ps(pgu);
        __m128 pgf_h = _mm_cvtpu8_ps(_mm_shuffle_pi8(pgu, shuffle_higher_64));
        pgf_l = _mm_mul_ps(pgf_l, mono_g_128);
        pgf_h = _mm_mul_ps(pgf_h, mono_g_128);

        __m128 pbf_l = _mm_cvtpu8_ps(pbu);
        __m128 pbf_h = _mm_cvtpu8_ps(_mm_shuffle_pi8(pbu, shuffle_higher_64));
        pbf_l = _mm_mul_ps(pbf_l, mono_b_128);
        pbf_h = _mm_mul_ps(pbf_h, mono_b_128);

        __m128 pfl = _mm_add_ps(_mm_add_ps(prf_l, pgf_l), pbf_l);
        __m128 pfh = _mm_add_ps(_mm_add_ps(prf_h, pgf_h), pbf_h);

        __m128 sign_pfl = _mm_and_ps(pfl, sign_mask_128);
        __m128 sign_pfh = _mm_and_ps(pfh, sign_mask_128);
        __m128 half_pfl = _mm_or_ps(sign_pfl, half_mask_128);
        __m128 half_pfh = _mm_or_ps(sign_pfh, half_mask_128);

        pfl = _mm_round_ps(_mm_add_ps(pfl, half_pfl), _MM_FROUND_TO_ZERO | _MM_FROUND_NO_EXC);
        pfh = _mm_round_ps(_mm_add_ps(pfh, half_pfh), _MM_FROUND_TO_ZERO | _MM_FROUND_NO_EXC);

        __m64 pul = _mm_cvtps_pi8(pfl);
        __m64 puh = _mm_shuffle_pi8(_mm_cvtps_pi8(pfh), shuffle_lower_64);
        __m64 pu = _mm_max_pu8(pul, puh);

        _mm_stream_pi((__m64 *)ptr_r, pu);
        _mm_stream_pi((__m64 *)ptr_g, pu);
        _mm_stream_pi((__m64 *)ptr_b, pu);
    }
#else
#error
#endif
}

void init_monochrome_filter_1()
{
#if defined(HAVE_AVX_INSTRUCTIONS)
    init_mono_256();
#elif defined(HAVE_SSE_INSTRUCTIONS) && defined(HAVE_SSE3_INSTRUCTIONS) && defined(HAVE_SSE4_2_INSTRUCTIONS)
    _Alignas(64) float const mono_cons_r[] = {0.299, 0.299, 0.299, 0.299};
    _Alignas(64) float const mono_cons_g[] = {0.587, 0.587, 0.587, 0.587};
    _Alignas(64) float const mono_cons_b[] = {0.114, 0.114, 0.114, 0.114};

    mono_r_128 = _mm_load_ps(mono_cons_r);
    mono_g_128 = _mm_load_ps(mono_cons_g);
    mono_b_128 = _mm_load_ps(mono_cons_b);

    _Alignas(64) uint8_t const shuffle_higher_cons[] = {0x04, 0x05, 0x06, 0x07, 0x80, 0x80, 0x80, 0x80};
    _Alignas(64) uint8_t shuffle_lower_cons[] = {0x80, 0x80, 0x80, 0x80, 0x00, 0x01, 0x02, 0x03};
    shuffle_higher_64 = *((__m64 *)shuffle_higher_cons);
    shuffle_lower_64 = *((__m64 *)shuffle_lower_cons);

    _Alignas(64) uint32_t const sign_mask_u8[] = {0x80000000, 0x80000000, 0x80000000, 0x80000000};
    sign_mask_128 = *((__m128 *)sign_mask_u8);

    _Alignas(64) float const half_f[] = {0.5, 0.5, 0.5, 0.5};
    half_mask_128 = _mm_load_ps(half_f);
#else
#endif
}