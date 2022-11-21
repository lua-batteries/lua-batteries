<h1 align="center">lua-batteries</h1>

<p align="center">
  <a href="https://github.com/clitic/lua-batteries/blob/main/LICENSE">
    <img src="https://img.shields.io/github/license/clitic/lua-batteries?style=flat-square">
  </a>
  <a href="https://github.com/clitic/lua-batteries">
    <img src="https://img.shields.io/github/repo-size/clitic/lua-batteries?logo=github&style=flat-square">
  </a>
</p>

`lua-batteries` is a batteries included lua installation more 
specifically it is set of meson build scripts to build [Lua](https://www.lua.org), [LuaJIT](https://luajit.org), [luarocks](https://github.com/luarocks/luarocks) and many useful libraries and modules. These scripts were initially based on franko's [lua](https://github.com/franko/lua) and [luajit](https://github.com/franko/luajit) meson build scripts but now they are extended to next level.

## Libraries And Modules

List of included libraries and modules provided by lua-batteries:

- comman tasks:
  - [argparse](https://github.com/luarocks/argparse)
  - [date](https://github.com/Tieske/date)
  - [inpsect](https://github.com/kikito/inspect.lua)
  - [luafilesystem](https://github.com/lunarmodules/luafilesystem)
  - [luautf8](https://github.com/starwing/luautf8)
  - [penlight](https://github.com/lunarmodules/Penlight)
  - [uuid](https://github.com/Tieske/uuid)
- data serialization:
  - [binser](https://github.com/bakpakin/binser)
  - [lua-cjson](https://github.com/openresty/lua-cjson)
  - [lyaml](https://github.com/gvvaughan/lyaml)
  - [toml](https://github.com/LebJe/toml.lua)
  - [xml2lua](https://github.com/manoelcampos/xml2lua)
- networking:
  - [luasocket](https://github.com/lunarmodules/luasocket)
  - [luasec](https://github.com/brunoos/luasec)
- accessing operating system APIs:
  - [winapi](https://github.com/stevedonovan/winapi)
  - [luaposix](https://github.com/luaposix/luaposix)
- creating user interfaces:
  - [lua-sdl2](https://github.com/Tangent128/luasdl2)
  - [lui](https://github.com/zhaozg/lui)
  - [ltui](https://github.com/tboox/ltui)
- [cffi-lua](https://github.com/q66/cffi-lua) for accessing foreign functions from lua and luajit both.
- [lanes](https://github.com/LuaLanes/lanes) for multi-threading.
- [lrexlib-pcre2](https://github.com/rrthomas/lrexlib) for using regular expressions.
- [lua-openssl](https://github.com/zhaozg/lua-openssl) for cryptography related tasks.
- [lua-zlib](https://github.com/brimworks/lua-zlib) for compressing and decompressing data.
- [luasql-sqlite3](https://github.com/lunarmodules/luasql) for using sqlite databases.
- [luv](https://github.com/luvit/luv) for asynchronous programming.

## Installations

Visit [releases](https://github.com/clitic/lua-batteries/releases) for prebuilt binaries. You just need to extract archive and add `bin` directory to any path specified in your `PATH` environment variable. Also, see [INSTALL.md](https://github.com/clitic/lua-batteries/blob/main/INSTALL.md) for installation instructions through meson. 

These prebuilt binaries includes **Lua 5.4.4** and **LuaJIT 2.0.5**

- [Windows](https://github.com/clitic/lua-batteries/releases/download/v0.2.0/lua-batteries-v0.2.0-x86_64-pc-windows-msvc.zip) (64-bit)
- [Linux](https://github.com/clitic/lua-batteries/releases/download/v0.2.0/lua-batteries-v0.2.0-x86_64-unknown-linux-gnu.zip) (64-bit)
