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

#ifdef HAVE_SKETCH_SKETCH_C
ERL_NIF_TERM sketch(ErlNifEnv *env, int argc, const ERL_NIF_TERM argv[]);
#else
ERL_NIF_TERM sketch(ErlNifEnv *env, int argc, const ERL_NIF_TERM argv[])
{
    return enif_make_atom(env, "not_implemented");
}
#endif

static ErlNifFunc nif_funcs[] =
{
    {"sketch", 1, sketch}
};

ERL_NIF_INIT(Elixir.SimdSample, nif_funcs, &load, NULL, &upgrade, NULL)
