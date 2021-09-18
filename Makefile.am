AUTOMAKE_OPTIONS = subdir-objects
ACLOCAL_AMFLAGS = -I m4

lib_LTLIBRARIES = build/libnif.la build/libmonochrome_filter.la

AM_LIBNIF_SRC = native/libnif.c
AM_LIBMONOCHROME_FILTER_SRC = native/libmonochrome_filter.c native/aos0.c native/soa0.c native/soa1.c native/basic_intrinsics.c

if ARM
    AM_LIBMONOCHROME_FILTER_SRC += native/arm/monochrome_filter_1.s
endif

if X86_64
    AM_LIBMONOCHROME_FILTER_SRC += native/x86_64/monochrome_filter_1.c native/mm256_unsigned_extend_epi64_to_m256.c native/mm256_unsigned_extend_epi8_to_epi32.c native/mm256_round_cvtps_epi32.c
endif

if SKETCH_C
build_libnif_la_SOURCES = $(AM_LIBNIF_SRC) sketch/sketch.c
else
build_libnif_la_SOURCES = $(AM_LIBNIF_SRC)
endif

build_libmonochrome_filter_la_SOURCES = $(AM_LIBMONOCHROME_FILTER_SRC)

build_libnif_la_CFLAGS = $(CFLAGS) $(ERL_CFLAGS) -std=c11

build_libmonochrome_filter_la_CFLAGS = $(CFLAGS) $(ERL_CFLAGS) -std=c11

build_libnif_la_LDFLAGS = $(LDFLAGS) $(ERL_LDFLAGS) -shared -module -avoid-version -export-dynamic

build_libmonochrome_filter_la_LDFLAGS = $(LDFLAGS) $(ERL_LDFLAGS) -shared -module -avoid-version -export-dynamic

