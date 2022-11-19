package = "lui"
version = "scm-0"

description = {
   summary = "Lua binding for libui";
   detailed = [[Lua binding for libui: https://github.com/andlabs/libui]];
   homepage = "https://github.com/zhaozg/lui";
}

source = {
   url = "git+https://github.com/zhaozg/lui.git";
}

dependencies = {
   "lua >= 5.1, < 5.5"
}

external_dependencies = {
   UI = {
      header = "ui.h";
      library = "ui";
   };
}

build = {
   type = "builtin",
   modules = {
      lui = {
         sources = "libuilua.c";
         libraries = "ui";
         incdirs = {
            "$(UI_INCDIR)";
         };
         libdirs = {
            "$(UI_LIBDIR)";
         };
      };
   };
}
