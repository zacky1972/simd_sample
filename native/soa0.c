#include "soa0.h"
#include "basic.h"
#include <math.h>

uint64_t soa0(rgb_t init_pixel)
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
        for(uint_fast16_t i = 0; i < SIZE; i++) {
            uint8_t p = (uint8_t)round(0.299 * pixel_r[i] + 0.587 * pixel_g[i] + 0.114 * pixel_b[i]);
            pixel_r[i] = p;
            pixel_g[i] = p;
            pixel_b[i] = p;
        }
    }
    // Sum up
    uint64_t sum = 0;
    for(uint_fast16_t i = 0; i < SIZE; i++) {
        sum += pixel_r[i] + pixel_g[i] + pixel_b[i];
    }
    return sum;
}
