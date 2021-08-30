#ifndef SOA1_H
#define SOA1_H

#include <stdint.h>
#include "rgb_t.h"

uint64_t soa1(rgb_t init_pixel);

#ifdef __arm__
uint64_t soa1_16(rgb_t init_pixel);
#endif // __arm__

void init_soa1();

#endif // SOA1_H
