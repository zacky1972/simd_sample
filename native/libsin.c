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

void simd_sin32(uint64_t size, float *array)
{
    for(uint64_t i = 0; i < size; i++) {
        array[i] = sin(array[i]);
    }
}

ERL_NIF_TERM sin32_nif(ErlNifEnv *env, int argc, const ERL_NIF_TERM argv[])
{
    if(__builtin_expect(argc != 1, false)) {
        return enif_make_badarg(env);
    }
    ERL_NIF_TERM vector_term = argv[0];

    // check vector_term is struct
    ERL_NIF_TERM struct_atom = enif_make_atom(env, "__struct__");
    ERL_NIF_TERM type;
    if(__builtin_expect(!enif_get_map_value(env, vector_term, struct_atom, &type), false)) {
        return enif_make_badarg(env);
    }

    // check type of vector_term is Elixir.Nx.Tensor
    unsigned type_size;
    if(__builtin_expect(!enif_get_atom_length(env, type, &type_size, ERL_NIF_LATIN1), false)) {
        return enif_make_badarg(env);
    }
    type_size++;
    char *type_name = enif_alloc(type_size);
    type_size = enif_get_atom(env, type, type_name, type_size, ERL_NIF_LATIN1);
    if(__builtin_expect(!type_size, false)) {
        return enif_make_badarg(env);
    }
    if(__builtin_expect(strncmp(type_name, "Elixir.Nx.Tensor", type_size) != 0, false)) {
        return enif_make_badarg(env);
    }

    // get vec_size 
    ErlNifUInt64 vec_size;
    ERL_NIF_TERM vec_shape;
    ERL_NIF_TERM shape_atom = enif_make_atom(env, "shape");
    if(__builtin_expect(!enif_get_map_value(env, vector_term, shape_atom, &vec_shape), false)) {
        return enif_make_badarg(env);
    }
    int arity;
    const ERL_NIF_TERM *tuple;
    if(__builtin_expect(!enif_get_tuple(env, vec_shape, &arity, &tuple), false)) {
        return enif_make_badarg(env);
    }
    if(__builtin_expect(arity != 1, false)) {
        return enif_make_badarg(env);
    }
    if(__builtin_expect(!enif_get_uint64(env, tuple[0], &vec_size), false)) {
        return enif_make_badarg(env);
    }

    // check type of vector is {:f, 32}
    ERL_NIF_TERM vec_type;
    ERL_NIF_TERM type_atom = enif_make_atom(env, "type");
    if(__builtin_expect(!enif_get_map_value(env, vector_term, type_atom, &vec_type), false)) {
        return enif_make_badarg(env);
    }
    if(__builtin_expect(!enif_get_tuple(env, vec_type, &arity, &tuple), false)) {
        return enif_make_badarg(env);
    }
    if(__builtin_expect(arity != 2, false)) {
        return enif_make_badarg(env);
    }
    unsigned vec_type_size;
    if(__builtin_expect(!enif_get_atom_length(env, tuple[0], &vec_type_size, ERL_NIF_LATIN1), false)) {
        return enif_make_badarg(env);
    }
    vec_type_size++;
    char *vec_type_name = enif_alloc(vec_type_size);
    vec_type_size = enif_get_atom(env, tuple[0], vec_type_name, vec_type_size, ERL_NIF_LATIN1);
    if(__builtin_expect(!vec_type_size, false)) {
        return enif_make_badarg(env);
    }
    if(__builtin_expect(strncmp(vec_type_name, "f", vec_type_size) != 0, false)) {
        return enif_make_badarg(env);
    }
    uint32_t vec_type_bit;
    if(__builtin_expect(!enif_get_uint(env, tuple[1], &vec_type_bit), false)) {
        return enif_make_badarg(env);
    }
    if(__builtin_expect(vec_type_bit != 32, false)) {
        return enif_make_badarg(env);
    }

    // get binary_data
    ERL_NIF_TERM data;
    ERL_NIF_TERM data_atom = enif_make_atom(env, "data");
    if(__builtin_expect(!enif_get_map_value(env, vector_term, data_atom, &data), false)) {
        return enif_make_badarg(env);
    }
    ERL_NIF_TERM binary_term;
    ERL_NIF_TERM state_atom = enif_make_atom(env, "state");
    if(__builtin_expect(!enif_get_map_value(env, data, state_atom, &binary_term), false)) {
        return enif_make_badarg(env);
    }
    ErlNifBinary binary_data;
    if(__builtin_expect(!enif_term_to_binary(env, binary_term, &binary_data), false)) {
        return enif_make_badarg(env);
    }

    // calculate simd_sin32
    float *array = (float *)(&binary_data.data[6]);
    simd_sin32(vec_size, array);

    // keep names
    ERL_NIF_TERM names_atom = enif_make_atom(env, "names");
    ERL_NIF_TERM names;
    if(__builtin_expect(!enif_get_map_value(env, vector_term, names_atom, &names), false)) {
        return enif_make_badarg(env);
    }

    // make return value
    if(__builtin_expect(enif_binary_to_term(env, binary_data.data, binary_data.size, &binary_term, 0) == 0, false)) {
        return enif_make_badarg(env);
    }
    if(__builtin_expect(!enif_make_map_from_arrays(env, &state_atom, &binary_term, 1, &data), false)) {
        return enif_make_badarg(env);
    }
    if(__builtin_expect(!enif_make_map_put(env, data, struct_atom, enif_make_atom(env, "Elixir.Nx.BinaryBackend"), &data), false)) {
        return enif_make_badarg(env);
    }
    ERL_NIF_TERM result;
    if(__builtin_expect(!enif_make_map_from_arrays(env, &data_atom, &data, 1, &result), false)) {
        return enif_make_badarg(env);
    }
    if(__builtin_expect(!enif_make_map_put(env, result, struct_atom, enif_make_atom(env, "Elixir.Nx.Tensor"), &result), false)) {
        return enif_make_badarg(env);
    }
    if(__builtin_expect(!enif_make_map_put(env, result, names_atom, names, &result), false)) {
        return enif_make_badarg(env);
    }
    if(__builtin_expect(!enif_make_map_put(env, result, shape_atom, vec_shape, &result), false)) {
        return enif_make_badarg(env);
    }
    if(__builtin_expect(!enif_make_map_put(env, result, type_atom, vec_type, &result), false)) {
        return enif_make_badarg(env);
    }
    return result;
}

static ErlNifFunc nif_funcs[] =
{
    {"sin32_nif", 1, sin32_nif}
};

ERL_NIF_INIT(Elixir.SimdSample.Sin, nif_funcs, &load, NULL, &upgrade, NULL)
