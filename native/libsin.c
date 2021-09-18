#include <stdint.h>
#include <erl_nif.h>

int load(ErlNifEnv *caller_env, void **priv_data, ERL_NIF_TERM load_info)
{
    return 0;
}

int upgrade(ErlNifEnv *caller_env, void **priv_data, void **old_priv_data, ERL_NIF_TERM load_info)
{
    return load(caller_env, priv_data, load_info);
}

ERL_NIF_TERM sin_nif(ErlNifEnv *env, int argc, const ERL_NIF_TERM argv[])
{
    return enif_make_atom(env, "not_implemented");
}

static ErlNifFunc nif_funcs[] =
{
    {"sin_nif", 1, sin_nif}
};

ERL_NIF_INIT(Elixir.SimdSample.Sin, nif_funcs, &load, NULL, &upgrade, NULL)
