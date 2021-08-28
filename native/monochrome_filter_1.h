#ifndef MONOCHROME_FILTER_1_H
#define MONOCHROME_FILTER_1_H

#include <stdlib.h>
#include <stdint.h>

void monochrome_filter_1(size_t size, uint8_t *pixel_r, uint8_t *pixel_g, uint8_t *pixel_b);

void init_monochrome_filter_1();

#endif // MONOCHROME_FILTER_1_H