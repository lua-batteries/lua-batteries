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
   LD = "clang",
   LIBFLAG = "-shared",
   OBJ_EXTENSION = "obj",
}
