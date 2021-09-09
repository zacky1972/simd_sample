AUTOMAKE_OPTIONS = subdir-objects
ACLOCAL_AMFLAGS = -I m4

lib_LTLIBRARIES = build/libnif.la

AM_SRC = native/libnif.c native/aos0.c native/soa0.c native/soa1.c native/basic_intrinsics.c

if ARM
    AM_SRC += native/arm/monochrome_filter_1.c
endif

if X86_64
if HAVE_AVX2_INSTRUCTIONS 
AM_SRC += native/x86_64/avx2/monochrome_filter_1.s native/mm256_unsigned_extend_epi64_to_m256.c native/mm256_unsigned_extend_epi8_to_epi32.c native/mm256_round_cvtps_epi32.c
else
if HAVE_SSE_INSTRUCTIONS
AM_SRC += native/x86_64/monochrome_filter_1.c native/mm256_unsigned_extend_epi64_to_m256.c native/mm256_unsigned_extend_epi8_to_epi32.c native/mm256_round_cvtps_epi32.c
endif
endif
endif

if SKETCH_C
build_libnif_la_SOURCES = $(AM_SRC) sketch/sketch.c
else
build_libnif_la_SOURCES = $(AM_SRC)
endif

build_libnif_la_CFLAGS = $(CFLAGS) $(ERL_CFLAGS) -std=c11

build_libnif_la_LDFLAGS = $(LDFLAGS) $(ERL_LDFLAGS) -shared -module -avoid-version -export-dynamic


