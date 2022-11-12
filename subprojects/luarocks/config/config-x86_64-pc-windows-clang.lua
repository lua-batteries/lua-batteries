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
   AR = "llvm-ar",
   CC = "clang",
   CFLAGS = "-O3",
   CP = "coreutils cp",
   LD = "clang",
   LIBFLAG = "-shared",
   LS = "coreutils ls",
   OBJ_EXTENSION = "obj",
   MD5SUM = "coreutils md5sum",
   FIND = "fd",
   SEVENZ = "7za",
}
