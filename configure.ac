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

AC_PATH_PROG(ELIXIR, $ELIXIR, elixir)

AC_MSG_CHECKING([setting CROSSCOMPILE])
if test "x$CROSSCOMPILE" = "x"; then
AC_MSG_RESULT([no])
else
AC_MSG_RESULT([yes])
fi

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
    AC_SUBST([ERL_LDFLAGS], [$(LC_ALL=en_US.UTF-8 $ELIXIR --eval '"-I#{System.get_env("ERL_EI_INCLUDE_DIR", "#{to_string(:code.root_dir)}/usr/lib")}" |> IO.puts')])
fi
AC_MSG_RESULT([$ERL_LDFLAGS])

LT_INIT()
AC_CONFIG_FILES([Makefile])
AC_OUTPUT
