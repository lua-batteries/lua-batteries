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
   LD = "link",
   LIBFLAG = "/nologo /dll",
   MAKE = "nmake",
   OBJ_EXTENSION = "obj",
}
