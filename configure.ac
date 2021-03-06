dnl Process this file with autoconf to produce a configure script

AC_INIT([priv/.libs/libnif.so], [1.0])
AC_CONFIG_MACRO_DIRS([m4])
AM_INIT_AUTOMAKE([-Wall -Werror foreign])

AC_ARG_VAR([ELXIR], [Elixir])
AC_ARG_VAR([ERL_EI_INCLUDE_DIR], [ERL_EI_INCLUDE_DIR])
AC_ARG_VAR([ERL_EI_LIBDIR], [ERL_EI_LIBDIR])
AC_ARG_VAR([CROSSCOMPILE], [CROSSCOMPILE])
AC_ARG_VAR([ERL_CFLAGS], [ERL_CFLAGS])
AC_ARG_VAR([ERL_LDFLAGS], [ERL_LDFLAGS])

AC_PROG_CC
AM_PROG_AR
AM_PROG_AS

AC_PATH_PROG(ELIXIR, $ELIXIR, elixir)

AC_CANONICAL_HOST

AC_MSG_CHECKING([setting CROSSCOMPILE])
if test "x$CROSSCOMPILE" = "x"; then
    AC_MSG_RESULT([no])
    AC_MSG_CHECKING([setting host_cpu])
    AC_MSG_RESULT([$host_cpu])
    AS_CASE([$host_cpu],
        [aarch64], 
            [AC_DEFINE(__arm__, 1)],
        AS_CASE([$host_cpu],
            [x86_64], 
                [AX_CHECK_X86_FEATURES()]
        )
    )
else
    AC_MSG_RESULT([yes])
    AS_CASE([$host_cpu],
        [aarch64], [AC_DEFINE(__arm__, 1)]
    )
fi

AM_CONDITIONAL(X86_64, [test x$host_cpu = xx86_64])
AM_CONDITIONAL(ARM, [test x$host_cpu = xaarch64])

AC_MSG_CHECKING([setting ERL_EI_INCLUDE_DIR])
if test "x$ERL_EI_INCLUDE_DIR" = "x"; then
    AC_SUBST([ERL_EI_INCLUDE_DIR], [$(LC_ALL=en_US.UTF-8 $ELIXIR --eval ':code.root_dir |> to_string() |> Kernel.<>("/usr/include") |> IO.puts')])
fi
AC_MSG_RESULT([$ERL_EI_INCLUDE_DIR])

AC_MSG_CHECKING([setting ERL_EI_LIBDIR])
if test "x$ERL_EI_LIBDIR" = "x"; then
    AC_SUBST([ERL_EI_LIBDIR], [$(LC_ALL=en_US.UTF-8 $ELIXIR --eval ':code.root_dir |> to_string() |> Kernel.<>("/usr/lib") |> IO.puts')])
fi
AC_MSG_RESULT([$ERL_EI_LIBDIR])

AC_MSG_CHECKING([setting ERL_CFLAGS])
if test "x$ERL_CFLAGS" = "x"; then
    AC_SUBST([ERL_CFLAGS], [$(LC_ALL=en_US.UTF-8 $ELIXIR --eval '"-I#{System.get_env("ERL_EI_INCLUDE_DIR", "#{to_string(:code.root_dir)}/usr/include")}" |> IO.puts')])
fi
AC_MSG_RESULT([$ERL_CFLAGS])

AC_MSG_CHECKING([setting ERL_LDFLAGS])
if test "x$ERL_LDFLAGS" = "x"; then
    AC_SUBST([ERL_LDFLAGS], [$(LC_ALL=en_US.UTF-8 $ELIXIR --eval '"-L#{System.get_env("ERL_EI_LIBDIR", "#{to_string(:code.root_dir)}/usr/lib")}" |> IO.puts')])
fi
AC_MSG_RESULT([$ERL_LDFLAGS])

AC_MSG_CHECKING([check sketch files])
if test "x$cross_compiling" != "xyes"; then
    AC_CHECK_FILES([sketch/sketch.c], AM_CONDITIONAL(SKETCH_C, test true = true), AM_CONDITIONAL(SKETCH_C, test false = true))
else
    AS_IF([test -e "sketch/sketch.c"], [
            AM_CONDITIONAL(SKETCH_C, test true = true)
            AC_DEFINE([HAVE_SKETCH_SKETCH_C], 1)
            AC_MSG_RESULT(["yes"])
        ], [ 
            AM_CONDITIONAL(SKETCH_C, test false = true)
            AC_MSG_RESULT(["no"])
        ]
    )
fi

LT_INIT()
AC_CONFIG_FILES([Makefile])
AC_OUTPUT
