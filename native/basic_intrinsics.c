#include "basic_intrinsics.h"

void init_basic_intrinsics()
{
    init_mm256_unsigned_extend_epi8_to_epi32();
    init_mm256_round_cvtps_epi32();
}
