#include <stdlib.h>
#include <erl_nif.h>

#include "alignas.h"
#include "alignof.h"

#ifdef __arm__
#include <arm_neon.h>
#elif __x86_64__
#ifdef _MSC_VER
#include <intrin.h>
#else
#include <x86intrin.h>
#endif // _MSC_VER
#endif

_Alignas(alignof(unsigned int)) unsigned int c[256];

static ERL_NIF_TERM test(ErlNifEnv *env, int argc, const ERL_NIF_TERM argv[])
{
    return enif_make_atom(env, "ok");
}

static ErlNifFunc nif_funcs[] =
{
    {"test", 0, test}
};

ERL_NIF_INIT(Elixir.SimdSample, nif_funcs, NULL, NULL, NULL, NULL)
