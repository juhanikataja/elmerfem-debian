/* config.h.  Generated from config.h.in by configure.  */
/* config.h.in.  Generated from configure.in by autoheader.  */

/* Detected platform. */
/* #undef AIX */

/* Couldn't determine. sticking with 32 bits. */
#define ARCH_32_BITS 0

/* 64 bit arch. */
/* #undef ARCH_64_BITS */

/* Detected platform. */
/* #undef BASTARDS */

/* Detected platform. */
/* #undef BSD */

/* Detected platform. */
/* #undef CYGWIN */

/* Standard windows call declaration */
#define C_DLLEXPORT 

/* Detected platform. */
/* #undef DARWIN */

/* Detected platform. */
/* #undef DEC_ALPHA */

/* "Mangling: lower case */
#define ELMER_LINKTYP 1

/* Elmer solver default install directory */
#define ELMER_SOLVER_HOME "/wrk/jpr/ff/share/elmersolver"

/* Define if using dynamic linking */
#define ENABLE_DYNAMIC_LINKING 1

/* Define to dummy `main' function (if any) required to link to the Fortran
   libraries. */
/* #undef F77_DUMMY_MAIN */

/* Define to a macro mangling the given C identifier (in lower and upper
   case), which must not contain underscores, for linking with Fortran. */
#define F77_FUNC(name,NAME) name ## _

/* As F77_FUNC, but for C identifiers containing underscores. */
#define F77_FUNC_(name,NAME) name ## _

/* Char pointer mangling */
#define FC_CHAR_PTR(P,L) char *P

/* Define to dummy `main' function (if any) required to link to the Fortran
   libraries. */
/* #undef FC_DUMMY_MAIN */

/* Define if F77 and FC dummy `main' functions are identical. */
/* #undef FC_DUMMY_MAIN_EQ_F77 */

/* Define to a macro mangling the given C identifier (in lower and upper
   case), which must not contain underscores, for linking with Fortran. */
#define FC_FUNC(name,NAME) name ## _

/* As FC_FUNC, but for C identifiers containing underscores. */
#define FC_FUNC_(name,NAME) name ## _

/* Define if you have a ARPACK library. */
#define HAVE_ARPACK 1

/* Define if you have a BLAS library. */
#define HAVE_BLAS 1

/* Define to 1 if you have the `dlclose' function. */
#define HAVE_DLCLOSE 1

/* Define to 1 if you have the `dlerror' function. */
#define HAVE_DLERROR 1

/* Define to 1 if you have the `dlopen' function. */
#define HAVE_DLOPEN 1

/* Define if your system has dlopen, dlsym, dlerror, and dlclose for dynamic
   linking */
#define HAVE_DLOPEN_API 1

/* Define to 1 if you have the `dlsym' function. */
#define HAVE_DLSYM 1

/* Define if your system has dyld for dynamic linking */
/* #undef HAVE_DYLD_API */

/* Define if you have a EIOF library. */
#define HAVE_EIOF 1

/* Define to 1 if you have the `fseeko' function. */
#define HAVE_FSEEKO 1

/* Define to 1 if you have the `ftello' function. */
#define HAVE_FTELLO 1

/* Does the fortran environment implement etime */
#define HAVE_F_ETIME 1

/* Does the fortran environment implement flush */
#define HAVE_F_FLUSH 1

/* Define if you have a HUTI library. */
#define HAVE_HUTI 1

/* Define if you have a HYPRE library. */
/* #undef HAVE_HYPRE */

/* Define to 1 if you have the <inttypes.h> header file. */
#define HAVE_INTTYPES_H 1

/* Define if you have LAPACK library. */
#define HAVE_LAPACK 1

/* Define to 1 if you have the `dl' library (-ldl). */
#define HAVE_LIBDL 1

/* Define to 1 if you have the `dld' library (-ldld). */
/* #undef HAVE_LIBDLD */

/* Define if your system has LoadLibrary for dynamic linking */
/* #undef HAVE_LOADLIBRARY_API */

/* Define if you have a MATC library. */
#define HAVE_MATC 1

/* Define to 1 if you have the <memory.h> header file. */
#define HAVE_MEMORY_H 1

/* ... */
/* #undef HAVE_MPI */

/* Define if you have a MUMPS library. */
/* #undef HAVE_MUMPS */

/* Define if you have a PARPACK library. */
/* #undef HAVE_PARPACK */

/* Define to 1 if you have the `shl_findsym' function. */
/* #undef HAVE_SHL_FINDSYM */

/* Define to 1 if you have the `shl_load' function. */
/* #undef HAVE_SHL_LOAD */

/* Define if your system has shl_load and shl_findsym for dynamic linking */
/* #undef HAVE_SHL_LOAD_API */

/* Define to 1 if you have the <stdint.h> header file. */
#define HAVE_STDINT_H 1

/* Define to 1 if you have the <stdlib.h> header file. */
#define HAVE_STDLIB_H 1

/* Define to 1 if you have the <strings.h> header file. */
#define HAVE_STRINGS_H 1

/* Define to 1 if you have the <string.h> header file. */
#define HAVE_STRING_H 1

/* Define to 1 if you have the <sys/stat.h> header file. */
#define HAVE_SYS_STAT_H 1

/* Define to 1 if you have the <sys/types.h> header file. */
#define HAVE_SYS_TYPES_H 1

/* Define if you have a UMFPACK library. */
#define HAVE_UMFPACK 1

/* Define to 1 if you have the <unistd.h> header file. */
#define HAVE_UNISTD_H 1

/* Detected platform. */
/* #undef HPUX */

/* Detected platform. */
#define LINUX 1

/* Detected platform. */
/* #undef MINGW32 */

/* Name of package */
#define PACKAGE "fem"

/* Define to the address where bug reports for this package should be sent. */
#define PACKAGE_BUGREPORT ""

/* Define to the full name of this package. */
#define PACKAGE_NAME ""

/* Define to the full name and version of this package. */
#define PACKAGE_STRING ""

/* Define to the one symbol short name of this package. */
#define PACKAGE_TARNAME ""

/* Define to the version of this package. */
#define PACKAGE_VERSION ""

/* svn revision */
#define REVISION "5860M"

/* Detected platform. */
/* #undef SGI */

/* Shared lib filename extension */
#define SHL_EXTENSION ".so"

/* The size of `long', as computed by sizeof. */
/* #undef SIZEOF_LONG */

/* The size of `off_t', as computed by sizeof. */
#define SIZEOF_OFF_T 8

/* The size of `void*', as computed by sizeof. */
#define SIZEOF_VOIDP 0

/* Detected platform. */
/* #undef SOLARIS */

/* Standard windows call declaration */
#define STDCALLBULL 

/* Define to 1 if you have the ANSI C header files. */
#define STDC_HEADERS 1

/* Detected platform. */
/* #undef SUNOS */

/* Version number of package */
#define VERSION "7.0"

/* Detected platform2. */
/* #undef WIN32 */

/* Number of bits in a file offset, on hosts where this is settable. */
#define _FILE_OFFSET_BITS 64

/* Define for large files, on AIX-style hosts. */
/* #undef _LARGE_FILES */
