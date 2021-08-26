AUTOMAKE_OPTIONS = subdir-objects
ACLOCAL_AMFLAGS = -I m4

lib_LTLIBRARIES = build/libnif.la
build_libnif_la_SOURCES = native/libnif.c native/aos0.c native/soa0.c

build_libnif_la_CFLAGS = $(CFLAGS) $(ERL_CFLAGS) -std=c11 -save-temps 

build_libnif_la_LDFLAGS = $(LDFLAGS) $(ERL_LDFLAGS) -shared -module -avoid-version -export-dynamic


