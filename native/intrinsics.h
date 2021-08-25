#ifndef INTRINSICS_H
#define INTRINSICS_H

#ifdef __arm__
#  include <arm_neon.h>
#elif __x86_64__
#  ifdef _MSC_VER
#    include <intrin.h>
#  else
#    include <x86intrin.h>
#  endif // _MSC_VER
#endif

#endif // INTRINSICS_H