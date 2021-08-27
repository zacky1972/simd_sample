#include <stdlib.h>
#include <stdint.h>
#include <math.h>
#include <erl_nif.h>

#include "basic.h"
#include "aos0.h"
#include "soa0.h"

#include "alignas.h"
#include "intrinsics.h"
#include "basic_intrinsics.h"

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

extern inline void mm256_epi32_extract_epi8x(int index, __m256i *value, __m256i *result);

inline void mm256_epi32_extract_epi8x(int index, __m256i *value, __m256i *result)
{
    _mm256_storeu_si256(&result[index], mm256_unsigned_extend_epi8_to_epi32(value[index]));
}

static _Alignas(64) __m256 mono_r_256, mono_g_256, mono_b_256;

void init_mono_256()
{
    _Alignas(64) float const mono_cons_r[] = {
        0.299, 0.299, 0.299, 0.299,
        0.299, 0.299, 0.299, 0.299,
    };
    _Alignas(64) float const mono_cons_g[] = {
        0.587, 0.587, 0.587, 0.587,
        0.587, 0.587, 0.587, 0.587,
    };
    _Alignas(64) float const mono_cons_b[] = {
        0.114, 0.114, 0.114, 0.114,
        0.114, 0.114, 0.114, 0.114
    };

    mono_r_256 = _mm256_load_ps(mono_cons_r);
    mono_g_256 = _mm256_load_ps(mono_cons_g);
    mono_b_256 = _mm256_load_ps(mono_cons_b);
}

#elif defined(HAVE_SSE_INSTRUCTIONS) && defined(HAVE_SSE3_INSTRUCTIONS) && defined(HAVE_SSE4_2_INSTRUCTIONS)
_Alignas(64) __m128 mono_r_128, mono_g_128, mono_b_128;
_Alignas(64) __m64 shuffle_higher_64, shuffle_lower_64;
_Alignas(64) __m128 sign_mask_128, half_mask_128;
#else
#endif
#else // x86_64
#endif

int load(ErlNifEnv *caller_env, void **priv_data, ERL_NIF_TERM load_info)
{
#if __x86_64__ 
#if defined(HAVE_AVX_INSTRUCTIONS)
    init_mono_256();
    init_basic_intrinsics();
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
#else // x86_64
#endif

    return 0;
}

int upgrade(ErlNifEnv *caller_env, void **priv_data, void **old_priv_data, ERL_NIF_TERM load_info)
{
    return load(caller_env, priv_data, load_info);
}

#if __arm__
static float mono_r_16[] = {
    0.299, 0.299, 0.299, 0.299, 
    0.299, 0.299, 0.299, 0.299, 
    0.299, 0.299, 0.299, 0.299, 
    0.299, 0.299, 0.299, 0.299, 
};
static float mono_g_16[] = {
    0.587, 0.587, 0.587, 0.587,
    0.587, 0.587, 0.587, 0.587,
    0.587, 0.587, 0.587, 0.587,
    0.587, 0.587, 0.587, 0.587,
};
static float mono_b_16[] = {
    0.114, 0.114, 0.114, 0.114,
    0.114, 0.114, 0.114, 0.114,
    0.114, 0.114, 0.114, 0.114,
    0.114, 0.114, 0.114, 0.114,
};
#endif

uint64_t soa1(rgb_t init_pixel)
{
    _Alignas(64) uint8_t pixel_r[SIZE];
    _Alignas(64) uint8_t pixel_g[SIZE];
    _Alignas(64) uint8_t pixel_b[SIZE];

    for(uint_fast16_t i = 0; i < SIZE; i++) {
        pixel_r[i] = init_pixel.r;
        pixel_g[i] = init_pixel.g;
        pixel_b[i] = init_pixel.b;
    }
    // In monochrome
    for(uint_fast32_t k = 0; k < LOOP; k++) {
#if __arm__
        float32x4_t f32x4_mono_r = vld1q_f32(mono_r_16);
        float32x4_t f32x4_mono_g = vld1q_f32(mono_g_16);
        float32x4_t f32x4_mono_b = vld1q_f32(mono_b_16);

        for(uint_fast16_t i = 0; i < SIZE; i += 16) {
            /*
            uint8_t p = (uint8_t)round(0.299 * pixel_r[i] + 0.587 * pixel_g[i] + 0.114 * pixel_b[i]);
            pixel_r[i] = p;
            pixel_g[i] = p;
            pixel_b[i] = p;
            */

            uint8x16_t u8x16_pixel_r = vld1q_u8(&pixel_r[i]);
            uint8x16_t u8x16_pixel_g = vld1q_u8(&pixel_g[i]);

            uint16x8_t u16x8_pixel_r_low  = vmovl_u8(vget_low_u8(u8x16_pixel_r));
            uint16x8_t u16x8_pixel_r_high = vmovl_high_u8(u8x16_pixel_r);

            uint16x8_t u16x8_pixel_g_low  = vmovl_u8(vget_low_u8(u8x16_pixel_g));
            uint16x8_t u16x8_pixel_g_high = vmovl_high_u8(u8x16_pixel_g);

            uint32x4_t u32x4_pixel_r_low_low  = vmovl_u16(vget_low_u16(u16x8_pixel_r_low));
            uint32x4_t u32x4_pixel_r_low_high = vmovl_high_u16(u16x8_pixel_r_low);

            uint32x4_t u32x4_pixel_g_low_low  = vmovl_u16(vget_low_u16(u16x8_pixel_g_low));
            uint32x4_t u32x4_pixel_g_low_high = vmovl_high_u16(u16x8_pixel_g_low);

            uint8x16_t u8x16_pixel_b = vld1q_u8(&pixel_b[i]);

            float32x4_t f32x4_pixel_r_low_low = vcvtq_f32_u32(u32x4_pixel_r_low_low);
            float32x4_t f32x4_pixel_g_low_low = vcvtq_f32_u32(u32x4_pixel_g_low_low);
            float32x4_t f32x4_pixel_m_low_low = vmulq_f32(f32x4_pixel_r_low_low, f32x4_mono_r);

            uint16x8_t u16x8_pixel_b_low  = vmovl_u8(vget_low_u8(u8x16_pixel_b));
            uint16x8_t u16x8_pixel_b_high = vmovl_high_u8(u8x16_pixel_b);

            f32x4_pixel_m_low_low = vmlaq_f32(f32x4_pixel_m_low_low, f32x4_pixel_g_low_low, f32x4_mono_g);

            uint32x4_t u32x4_pixel_b_low_low  = vmovl_u16(vget_low_u16(u16x8_pixel_b_low));
            uint32x4_t u32x4_pixel_b_low_high = vmovl_high_u16(u16x8_pixel_b_low);
            float32x4_t f32x4_pixel_b_low_low = vcvtq_f32_u32(u32x4_pixel_b_low_low);

            f32x4_pixel_m_low_low = vmlaq_f32(f32x4_pixel_m_low_low, f32x4_pixel_b_low_low, f32x4_mono_b);

            float32x4_t f32x4_pixel_r_low_high = vcvtq_f32_u32(u32x4_pixel_r_low_high);
            float32x4_t f32x4_pixel_g_low_high = vcvtq_f32_u32(u32x4_pixel_g_low_high);
            float32x4_t f32x4_pixel_m_low_high = vmulq_f32(f32x4_pixel_r_low_high, f32x4_mono_r);

            f32x4_pixel_m_low_high = vmlaq_f32(f32x4_pixel_m_low_high, f32x4_pixel_g_low_high, f32x4_mono_g);
            float32x4_t f32x4_pixel_b_low_high = vcvtq_f32_u32(u32x4_pixel_b_low_high);
            f32x4_pixel_m_low_high = vmlaq_f32(f32x4_pixel_m_low_high, f32x4_pixel_b_low_high, f32x4_mono_b);

            uint16x8_t u16x8_pixel_m_low = vcombine_u16(
                vmovn_u32(vcvtnq_u32_f32(f32x4_pixel_m_low_low)),
                vmovn_u32(vcvtnq_u32_f32(f32x4_pixel_m_low_high))
            );

            uint32x4_t u32x4_pixel_r_high_low  = vmovl_u16(vget_low_u16(u16x8_pixel_r_high));
            uint32x4_t u32x4_pixel_r_high_high = vmovl_high_u16(u16x8_pixel_r_high);

            uint32x4_t u32x4_pixel_g_high_low  = vmovl_u16(vget_low_u16(u16x8_pixel_g_high));
            uint32x4_t u32x4_pixel_g_high_high = vmovl_high_u16(u16x8_pixel_g_high);

            float32x4_t f32x4_pixel_r_high_low = vcvtq_f32_u32(u32x4_pixel_r_high_low);
            float32x4_t f32x4_pixel_g_high_low = vcvtq_f32_u32(u32x4_pixel_g_high_low);
            float32x4_t f32x4_pixel_m_high_low = vmulq_f32(f32x4_pixel_r_high_low, f32x4_mono_r);

            f32x4_pixel_m_high_low = vmlaq_f32(f32x4_pixel_m_high_low, f32x4_pixel_g_high_low, f32x4_mono_g);

            uint32x4_t u32x4_pixel_b_high_low  = vmovl_u16(vget_low_u16(u16x8_pixel_b_high));
            uint32x4_t u32x4_pixel_b_high_high = vmovl_high_u16(u16x8_pixel_b_high);
            float32x4_t f32x4_pixel_b_high_low = vcvtq_f32_u32(u32x4_pixel_b_high_low);

            f32x4_pixel_m_high_low = vmlaq_f32(f32x4_pixel_m_high_low, f32x4_pixel_b_high_low, f32x4_mono_b);

            float32x4_t f32x4_pixel_r_high_high = vcvtq_f32_u32(u32x4_pixel_r_high_high);
            float32x4_t f32x4_pixel_g_high_high = vcvtq_f32_u32(u32x4_pixel_g_high_high);
            float32x4_t f32x4_pixel_m_high_high = vmulq_f32(f32x4_pixel_r_high_high, f32x4_mono_r);

            f32x4_pixel_m_high_high = vmlaq_f32(f32x4_pixel_m_high_high, f32x4_pixel_g_high_high, f32x4_mono_g);
            float32x4_t f32x4_pixel_b_high_high = vcvtq_f32_u32(u32x4_pixel_b_high_high);
            f32x4_pixel_m_high_high = vmlaq_f32(f32x4_pixel_m_high_high, f32x4_pixel_b_high_high, f32x4_mono_b);

            uint16x8_t u16x8_pixel_m_high = vcombine_u16(
                vmovn_u32(vcvtnq_u32_f32(f32x4_pixel_m_high_low)),
                vmovn_u32(vcvtnq_u32_f32(f32x4_pixel_m_high_high))
            );

            uint8x16_t u8x16_pixel_m = vcombine_u8(
                vmovn_u16(u16x8_pixel_m_low),
                vmovn_u16(u16x8_pixel_m_high)
            );

            vst1q_u8(&pixel_r[i], u8x16_pixel_m);
            vst1q_u8(&pixel_g[i], u8x16_pixel_m);
            vst1q_u8(&pixel_b[i], u8x16_pixel_m);
        }
#elif __x86_64__ 
#if defined(HAVE_AVX_INSTRUCTIONS) && defined(HAVE_AVX2_INSTRUCTIONS)
        for(uint_fast16_t i = 0; i < SIZE; i += 32) {
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
                s[0x0c], s[0x08], s[0x04], s[0x00]
            );

            _mm256_storeu_si256((__m256i *)&pixel_r[i], pr);
            _mm256_storeu_si256((__m256i *)&pixel_g[i], pr);
            _mm256_storeu_si256((__m256i *)&pixel_b[i], pr);
        }
#elif defined(HAVE_SSE_INSTRUCTIONS) && defined(HAVE_SSE3_INSTRUCTIONS) && defined(HAVE_SSE4_2_INSTRUCTIONS)
        for(uint_fast16_t i = 0; i < SIZE; i += 8) {
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
        for(uint_fast16_t i = 0; i < SIZE; i++) {
            uint8_t p = (uint8_t)round(0.299 * pixel_r[i] + 0.587 * pixel_g[i] + 0.114 * pixel_b[i]);
            pixel_r[i] = p;
            pixel_g[i] = p;
            pixel_b[i] = p;
        }
#else // x86_64
        for(uint_fast16_t i = 0; i < SIZE; i++) {
            uint8_t p = (uint8_t)round(0.299 * pixel_r[i] + 0.587 * pixel_g[i] + 0.114 * pixel_b[i]);
            pixel_r[i] = p;
            pixel_g[i] = p;
            pixel_b[i] = p;
        }
#endif
    }
    // Sum up
    uint64_t sum = 0;
    for(uint_fast16_t i = 0; i < SIZE; i++) {
        sum += pixel_r[i] + pixel_g[i] + pixel_b[i];
    }
    return sum;
}

static ERL_NIF_TERM aos0_test(ErlNifEnv *env, int argc, const ERL_NIF_TERM argv[])
{
    rgb_t init_pixel;

    // light purple
    init_pixel.r = 0x9f;
    init_pixel.g = 0x5a;
    init_pixel.b = 0xae;

    uint64_t r;
    r = aos0(init_pixel);

    return enif_make_tuple2(env, enif_make_atom(env, "ok"), enif_make_uint64(env, r));
}

static ERL_NIF_TERM soa0_test(ErlNifEnv *env, int argc, const ERL_NIF_TERM argv[])
{
    rgb_t init_pixel;

    // light purple
    init_pixel.r = 0x9f;
    init_pixel.g = 0x5a;
    init_pixel.b = 0xae;

    uint64_t r;
    r = soa0(init_pixel);

    return enif_make_tuple2(env, enif_make_atom(env, "ok"), enif_make_uint64(env, r));
}

static ERL_NIF_TERM soa1_test(ErlNifEnv *env, int argc, const ERL_NIF_TERM argv[])
{
    rgb_t init_pixel;

    // light purple
    init_pixel.r = 0x9f;
    init_pixel.g = 0x5a;
    init_pixel.b = 0xae;

    uint64_t r;
    r = soa1(init_pixel);

    return enif_make_tuple2(env, enif_make_atom(env, "ok"), enif_make_uint64(env, r));
}

#ifdef HAVE_SKETCH_SKETCH_C
ERL_NIF_TERM sketch(ErlNifEnv *env, int argc, const ERL_NIF_TERM argv[]);
#else
static ERL_NIF_TERM sketch(ErlNifEnv *env, int argc, const ERL_NIF_TERM argv[])
{
    return enif_make_atom(env, "not_implemented");
}
#endif

static ErlNifFunc nif_funcs[] =
{
    {"aos0_test", 0, aos0_test},
    {"soa0_test", 0, soa0_test},
    {"soa1_test", 0, soa1_test},
    {"sketch", 1, sketch}
};

ERL_NIF_INIT(Elixir.SimdSample, nif_funcs, &load, NULL, &upgrade, NULL)
