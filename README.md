<h1 align="center">lua-batteries</h1>

<p align="center">
  <a href="https://github.com/clitic/lua-batteries">
    <img src="https://img.shields.io/github/downloads/clitic/lua-batteries/total?style=flat-square">
  </a>
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

- [argparse](https://github.com/luarocks/argparse)
- [cffi-lua](https://github.com/q66/cffi-lua)
- [date](https://github.com/Tieske/date)
- [inpsect](https://github.com/kikito/inspect.lua)
- [lanes](https://github.com/LuaLanes/lanes)
- [lrexlib-pcre2](https://github.com/rrthomas/lrexlib)
- [luafilesystem](https://github.com/lunarmodules/luafilesystem)
- [lua-openssl](https://github.com/zhaozg/lua-openssl)
- [luasql-sqlite3](https://github.com/lunarmodules/luasql)
- [luautf8](https://github.com/starwing/luautf8)
- [lua-zlib](https://github.com/brimworks/lua-zlib)
- [luv](https://github.com/luvit/luv)
- [penlight](https://github.com/lunarmodules/Penlight)
- [uuid](https://github.com/Tieske/uuid)
- data serialization:
  - [lua-cjson](https://github.com/openresty/lua-cjson)
  - [lua-protobuf](https://github.com/starwing/lua-protobuf)
  - [lyaml](https://github.com/gvvaughan/lyaml)
  - [toml](https://github.com/LebJe/toml.lua)
  - [xml2lua](https://github.com/manoelcampos/xml2lua)
- networking:
  - [luasec](https://github.com/brunoos/luasec)
  - [luasocket](https://github.com/lunarmodules/luasocket)
- operating system APIs:
  - [luaposix](https://github.com/luaposix/luaposix)
  - [winapi](https://github.com/stevedonovan/winapi)
- user interfaces:
  - [lua-sdl2](https://github.com/Tangent128/luasdl2)
  - [ltui](https://github.com/tboox/ltui)
  - [lui](https://github.com/zhaozg/lui)

## Installation

Visit [releases](https://github.com/clitic/lua-batteries/releases) for prebuilt binaries. You just need to extract archive and add `bin` directory in your `PATH` environment variable. Also, see [INSTALL.md](https://github.com/clitic/lua-batteries/blob/main/INSTALL.md) for installation instructions through meson. 

These prebuilt binaries includes **Lua 5.4.4** and **LuaJIT 2.0.5**

- Windows 64-bit ([MSVC](https://visualstudio.microsoft.com)) - [.7z (self extracting archive)](https://github.com/clitic/lua-batteries/releases/download/v0.3.0/lua-batteries-v0.3.0-x86_64-pc-windows-msvc.exe) | [.7z](https://github.com/clitic/lua-batteries/releases/download/v0.3.0/lua-batteries-v0.3.0-x86_64-pc-windows-msvc.7z)
<!-- - Windows 64-bit ([MinGW-W64](https://github.com/brechtsanders/winlibs_mingw/releases/download/12.2.0-14.0.6-10.0.0-ucrt-r2/winlibs-x86_64-posix-seh-gcc-12.2.0-mingw-w64ucrt-10.0.0-r2.7z)) - [.7z (self extracting archive)](https://github.com/clitic/lua-batteries/releases/download/v0.3.0/lua-batteries-v0.3.0-x86_64-w64-mingw32.exe) | [.7z](https://github.com/clitic/lua-batteries/releases/download/v0.3.0/lua-batteries-v0.3.0-x86_64-w64-mingw32.7z) -->
- Linux 64-bit - [.tar.gz](https://github.com/clitic/lua-batteries/releases/download/v0.3.0/lua-batteries-v0.3.0-x86_64-unknown-linux-gnu.tar.gz)
