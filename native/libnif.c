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
    for(uint_fast16_t i = 0; i < SIZE; i++) {
        uint8_t p = (uint8_t)round(0.299 * pixel[i].r + 0.587 * pixel[i].g + 0.114 * pixel[i].b);
        pixel[i].r = p;
        pixel[i].g = p;
        pixel[i].b = p;
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
    for(uint_fast16_t i = 0; i < SIZE; i++) {
        uint8_t p = (uint8_t)round(0.299 * pixel_r[i] + 0.587 * pixel_g[i] + 0.114 * pixel_b[i]);
        pixel_r[i] = p;
        pixel_g[i] = p;
        pixel_b[i] = p;
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
    init_pixel.r = 0xff;
    init_pixel.g = 0xff;
    init_pixel.b = 0xff;
    uint64_t r;
    for(uint_fast32_t i = 0; i < LOOP; i++) {
        r = aos0(init_pixel);
    }

    return enif_make_tuple2(env, enif_make_atom(env, "ok"), enif_make_uint64(env, r));
}

static ERL_NIF_TERM soa0_test(ErlNifEnv *env, int argc, const ERL_NIF_TERM argv[])
{
    rgb_t init_pixel;
    init_pixel.r = 0xff;
    init_pixel.g = 0xff;
    init_pixel.b = 0xff;
    uint64_t r;
    for(uint_fast32_t i = 0; i < LOOP; i++) {
        r = soa0(init_pixel);
    }

    return enif_make_tuple2(env, enif_make_atom(env, "ok"), enif_make_uint64(env, r));
}

static ErlNifFunc nif_funcs[] =
{
    {"aos0_test", 0, aos0_test},
    {"soa0_test", 0, soa0_test}
};

ERL_NIF_INIT(Elixir.SimdSample, nif_funcs, NULL, NULL, NULL, NULL)
