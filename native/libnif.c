#include <stdlib.h>
#include <erl_nif.h>

static ERL_NIF_TERM test(ErlNifEnv *env, int argc, const ERL_NIF_TERM argv[])
{
    return enif_make_atom(env, "ok");
}

static ErlNifFunc nif_funcs[] =
{
    {"test", 0, test}
};

ERL_NIF_INIT(Elixir.SimdSample, nif_funcs, NULL, NULL, NULL, NULL)
