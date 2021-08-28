#ifndef SOA1_H
#define SOA1_H

#include <stdlib.h>
#include <stdint.h>
#include <math.h>

#include "basic.h"
#include "alignas.h"
#include "intrinsics.h"
#include "basic_intrinsics.h"
#include "rgb_t.h"

uint64_t soa1(rgb_t init_pixel);

void init_soa1();

#endif // SOA1_H
