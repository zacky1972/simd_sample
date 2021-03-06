#include <stdint.h>
#include <erl_nif.h>

#include "basic.h"
#include "aos0.h"
#include "soa0.h"
#include "soa1.h"

#include "basic_intrinsics.h"

int load(ErlNifEnv *caller_env, void **priv_data, ERL_NIF_TERM load_info)
{
    init_basic_intrinsics();
    init_soa1();

    return 0;
}

int upgrade(ErlNifEnv *caller_env, void **priv_data, void **old_priv_data, ERL_NIF_TERM load_info)
{
    return load(caller_env, priv_data, load_info);
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

ERL_NIF_INIT(Elixir.SimdSample.MonochromeFilter, nif_funcs, &load, NULL, &upgrade, NULL)
