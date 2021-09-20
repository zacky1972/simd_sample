#include <stdbool.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <stdio.h>
#include <math.h>
#include <erl_nif.h>

int load(ErlNifEnv *caller_env, void **priv_data, ERL_NIF_TERM load_info)
{
    return 0;
}

int upgrade(ErlNifEnv *caller_env, void **priv_data, void **old_priv_data, ERL_NIF_TERM load_info)
{
    return load(caller_env, priv_data, load_info);
}

void simd_gamma32(uint64_t size, uint8_t *array, double gamma)
{
    double n = 1 / gamma;
    for(uint64_t i = 0; i < size; i++) {
        array[i] = (uint8_t) round(255 * pow((float)array[i] / 255, n) + 0.5);
    }
}

ERL_NIF_TERM gamma32_nif(ErlNifEnv *env, int argc, const ERL_NIF_TERM argv[])
{
    if(__builtin_expect(argc != 3, false)) {
        return enif_make_badarg(env);
    }
    ErlNifUInt64 vec_size;
    if(__builtin_expect(!enif_get_uint64(env, argv[0], &vec_size), false)) {
        return enif_make_badarg(env);
    }

    ERL_NIF_TERM binary_term = argv[1];
    ErlNifBinary binary_data;
    if(__builtin_expect(!enif_term_to_binary(env, binary_term, &binary_data), false)) {
        return enif_make_badarg(env);
    }

    double gamma;
    if(__builtin_expect(!enif_get_double(env, argv[2], &gamma), false)) {
        return enif_make_badarg(env);
    }

    // calculate simd_gamma32
    uint8_t *array = (uint8_t *)(&binary_data.data[6]);
    simd_gamma32(vec_size, array, gamma);

    if(__builtin_expect(enif_binary_to_term(env, binary_data.data, binary_data.size, &binary_term, 0) == 0, false)) {
        return enif_make_badarg(env);
    }
    return binary_term;
}

static ErlNifFunc nif_funcs[] =
{
    {"gamma32_nif", 3, gamma32_nif},
};

ERL_NIF_INIT(Elixir.SimdSample.Gamma, nif_funcs, &load, NULL, &upgrade, NULL)
