package = "luastatic"
version = "scm-0"
source =
{
  url = "git://github.com/lua-batteries/luastatic.git",
  branch = "master"
}
description =
{
  summary = "Build a standalone executable from a Lua program.",
  detailed = [[
    See http://lua.space/tools/build-a-standalone-executable for more information.
  ]],
  homepage = "https://github.com/lua-batteries/luastatic",
  license = "CC0",
  maintainer = "clitic <clitic21@gmail.com>"
}
dependencies = { "lua >= 5.1" }
build =
{
  type = "builtin",
  modules = {},
  install = {
    bin = {
      ["luastatic"] = "luastatic.lua",
    }
  }
}
