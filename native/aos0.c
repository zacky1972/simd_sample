#include "aos0.h"
#include "basic.h"
#include <math.h>

uint64_t aos0(rgb_t init_pixel)
{
    _Alignas(64) rgb_t pixel[SIZE];

    for(uint_fast16_t i = 0; i < SIZE; i++) {
        pixel[i].r = init_pixel.r;
        pixel[i].g = init_pixel.g;
        pixel[i].b = init_pixel.b;
    }
    // In monochrome
    for(uint_fast32_t k = 0; k < LOOP; k++) {
        for(uint_fast16_t i = 0; i < SIZE; i++) {
            uint8_t p = (uint8_t)round(0.299 * pixel[i].r + 0.587 * pixel[i].g + 0.114 * pixel[i].b);
            pixel[i].r = p;
            pixel[i].g = p;
            pixel[i].b = p;
        }
    }
    // Sum up
    uint64_t sum = 0;
    for(uint_fast16_t i = 0; i < SIZE; i++) {
        sum += pixel[i].r + pixel[i].g + pixel[i].b;
    }
    return sum;
}
