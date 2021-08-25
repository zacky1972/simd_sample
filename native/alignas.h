#ifndef ALIGNAS_H
#define ALIGNAS_H

#if defined(__STDC_VERSION__) && __STDC_VERSION__ < 201102L
#  ifdef _MSC_VER
#    define _Alignas(n) __declspec(align(n))
#  else
#    define _Alignas(n) __attribute__((aligned(n)))
#  endif
#else
#  define _Alignas(n) 
#endif

#endif // ALIGNAS_H
