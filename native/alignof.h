#ifndef ALIGNOF_H
#define ALIGNOF_H

#if defined(__cplusplus) && __cplusplus < 201103L
#  ifdef _MSC_VER
#    define alignof(n) __alignof(n)
#  else
#    define alignof(n) __alignof__(n)
#  endif
#elif !defined(__GNUC__) && !defined(__STDC_VERSION__) || __STDC_VERSION__ < 201102L
#  ifdef _MSC_VER
#    define alignof(n) __alignof(n)
#  else
#    define alignof(n) __alignof__(n)
#  endif
#endif

#endif // ALIGNOF_H
