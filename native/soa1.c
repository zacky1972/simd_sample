#include "soa1.h"
#include "monochrome_filter_1.h"

#include <stdlib.h>
#include <math.h>

#include "basic.h"
#include "alignas.h"
#include "intrinsics.h"
#include "basic_intrinsics.h"


uint64_t soa1(rgb_t init_pixel)
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
    for(uint_fast32_t k = 0; k < LOOP; k++) {
        monochrome_filter_1(SIZE, pixel_r, pixel_g, pixel_b);
    }
    // Sum up
    uint64_t sum = 0;
    for(uint_fast16_t i = 0; i < SIZE; i++) {
        sum += pixel_r[i] + pixel_g[i] + pixel_b[i];
    }
    return sum;
}

void init_soa1()
{
    init_monochrome_filter_1();
}
