external_deps_patterns = {
   lib = {
      "?.lib",
      "?.dll",
      "lib?.dll"
   }
}

makefile = "Makefile.win"
obj_extension = "obj"

static_lib_extension = "lib"

variables = {
   AR = "lib",
   CC = "cl",
   CFLAGS = "/nologo /MD /O2",
   CP = "coreutils cp",
   LD = "link",
   LIBFLAG = "/nologo /dll",
   LS = "coreutils ls",
   MAKE = "nmake",
   MD5SUM = "coreutils md5sum",
   OBJ_EXTENSION = "obj",
   FIND = "fd",
   SEVENZ = "7za",
}
