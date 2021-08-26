#include <stdlib.h>
#include <stdint.h>
#include <math.h>
#include <erl_nif.h>

#include "alignas.h"
#include "intrinsics.h"

#define SIZE 256
#define LOOP 1000

typedef struct rgb_s {
    uint8_t r;
    uint8_t g;
    uint8_t b;
} rgb_t;

uint64_t aos0(rgb_t init_pixel)
{
    _Alignas(64) rgb_t pixel[SIZE];

    for(uint_fast16_t i = 0; i < SIZE; i++) {
        pixel[i].r = init_pixel.r;
        pixel[i].g = init_pixel.g;
        pixel[i].b = init_pixel.b;
    }
    // In monochrome
    for(uint_fast32_t k = 0; k < LOOP; k++) {
        for(uint_fast16_t i = 0; i < SIZE; i++) {
            uint8_t p = (uint8_t)round(0.299 * pixel[i].r + 0.587 * pixel[i].g + 0.114 * pixel[i].b);
            pixel[i].r = p;
            pixel[i].g = p;
            pixel[i].b = p;
        }
    }
    // Sum up
    uint64_t sum = 0;
    for(uint_fast16_t i = 0; i < SIZE; i++) {
        sum += pixel[i].r + pixel[i].g + pixel[i].b;
    }
    return sum;
}

uint64_t soa0(rgb_t init_pixel)
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
        for(uint_fast16_t i = 0; i < SIZE; i++) {
            uint8_t p = (uint8_t)round(0.299 * pixel_r[i] + 0.587 * pixel_g[i] + 0.114 * pixel_b[i]);
            pixel_r[i] = p;
            pixel_g[i] = p;
            pixel_b[i] = p;
        }
    }
    // Sum up
    uint64_t sum = 0;
    for(uint_fast16_t i = 0; i < SIZE; i++) {
        sum += pixel_r[i] + pixel_g[i] + pixel_b[i];
    }
    return sum;
}

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
#if defined(HAS_SSE_INSTRUCTIONS) && defined(HAS_SSSE3_INSTRUCTIONS) 
        float const mono_cons_r = {0.299, 0.299, 0.299, 0.299};
        float const mono_cons_g = {0.587, 0.587, 0.587, 0.587};
        float const mono_cons_b = {0.114, 0.114, 0.114, 0.114};

        __m128 mono_r = _mm_load_ps(mono_cons_r);
        __m128 mono_g = _mm_load_ps(mono_cons_g);
        __m128 mono_b = _mm_load_ps(mono_cons_b);

        uint8_t const shuffle_higher_cons = {0x04, 0x05, 0x06, 0x07, 0x80, 0x80, 0x80, 0x80};
        __m64 shuffle_higher = *((__m64 *)shuffle_higher_cons);

        for(uint_fast16_t i = 0; i < SIZE; i += 8) {
            uint8_t *ptr_r = &pixel_r[i];
            _m64 pru = *((__m64 *)ptr_r);
            __m128 prf_l = _mm_cvtpu8_ps(pru);
            __m128 prf_h = _mm_cvtpu8_ps(_mm_shuffle_pi8(pru, shuffle_higher));
            prf_l = _mm_mul_ps(prf_l, mono_r);
            prf_h = _mm_mul_ps(prf_h, mono_r);

            uint8_t *ptr_g = &pixel_g[i];
            _m64 pgu = *((__m64 *)ptr_g);
            __m128 pgf_l = _mm_cvtpu8_ps(pgu);
            __m128 pgf_h = _mm_cvtpu8_ps(_mm_shuffle_pi8(pgu, shuffle_higher));
            pgf_l = _mm_mul_ps(pgf_l, mono_g);
            pgf_h = _mm_mul_ps(pgf_h, mono_g);

            uint8_t *ptr_b = &pixel_b[i];
            _m64 pbu = *((__m64 *)ptr_b);
            __m128 pbf_l = _mm_cvtpu8_ps(pbu);
            __m128 pbf_h = _mm_cvtpu8_ps(_mm_shuffle_pi8(pbu, shuffle_higher));
            pbf_l = _mm_mul_ps(pbf_l, mono_b);
            pbf_h = _mm_mul_ps(pbf_h, mono_b);

            pfl = _mm_add_ps(_mm_add_ps(prf_l, pgf_l), pbf_l);
            pfh = _mm_add_ps(_mm_add_ps(prf_h, pgf_h), pbf_h);

            float pfla[4], pfha[4];
            _mm_store_ps(pfla, pfl);
            _mm_store_ps(pfha, pfh);

            uint8_t pl[4], ph[4];

            for(uint_fast8_t j = 0; j < 4; j++) {
                pl[j] = (uint8_t)round(pfla[j]);
                pixel_r[i + j] = pl[j];
                pixel_g[i + j] = pl[j];
                pixel_b[i + j] = pl[j];
            }
            for(uint_fast8_t j = 0; j < 4; j++) {
                ph[j] = (uint8_t)round(pfha[j]);
                pixel_r[i + j + 4] = ph[j];
                pixel_g[i + j + 4] = ph[j];
                pixel_b[i + j + 4] = ph[j];
            }
        }                  
#else
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

static ErlNifFunc nif_funcs[] =
{
    {"aos0_test", 0, aos0_test},
    {"soa0_test", 0, soa0_test},
    {"soa1_test", 0, soa1_test}
};

ERL_NIF_INIT(Elixir.SimdSample, nif_funcs, NULL, NULL, NULL, NULL)
