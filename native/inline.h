#ifndef INLINE_H
#define INLINE_H

#ifndef __cplusplus
#  if defined(_MSC_VER)
#    define inline      __inline
#    define __inline__  __inline
#  elif !defined(__GNUC__) && !defined(__STD_VERSION__) || __STD_VERSION__ < 199901L
#    define inline
#    define __inline
#  endif
#endif

#endif // INLINE_H
