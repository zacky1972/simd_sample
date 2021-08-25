#include <stdlib.h>
#include <stdint.h>
#include <math.h>
#include <erl_nif.h>

#include "alignas.h"
#include "intrinsics.h"

typedef struct rgb_s {
    uint8_t r;
    uint8_t g;
    uint8_t b;
} rgb_t;

uint64_t aos0(rgb_t init_pixel)
{
    _Alignas(64) rgb_t pixel[256];
    for(uint_fast16_t i = 0; i < 256; i++) {
        pixel[i].r = init_pixel.r;
        pixel[i].g = init_pixel.g;
        pixel[i].b = init_pixel.b;
    }
    // In monochrome
    for(uint_fast16_t i = 0; i < 256; i++) {
        uint8_t p = (uint8_t)round(0.299 * pixel[i].r + 0.587 * pixel[i].g + 0.114 * pixel[i].b);
        pixel[i].r = p;
        pixel[i].g = p;
        pixel[i].b = p;
    }
    // Sum up
    uint64_t sum = 0;
    for(uint_fast16_t i = 0; i < 256; i++) {
        sum += pixel[i].r + pixel[i].g + pixel[i].b;
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
    for(uint_fast32_t i = 0; i < 1000; i++) {
        r = aos0(init_pixel);
    }

    return enif_make_tuple2(env, enif_make_atom(env, "ok"), enif_make_uint64(env, r));
}

static ErlNifFunc nif_funcs[] =
{
    {"aos0_test", 0, aos0_test}
};

ERL_NIF_INIT(Elixir.SimdSample, nif_funcs, NULL, NULL, NULL, NULL)
