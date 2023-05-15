<h1 align="center">lua-batteries</h1>

<p align="center">
  <a href="https://github.com/lua-batteries/lua-batteries">
    <img src="https://img.shields.io/github/downloads/lua-batteries/lua-batteries/total?style=flat-square">
  </a>
  <a href="https://github.com/lua-batteries/lua-batteries/blob/main/LICENSE">
    <img src="https://img.shields.io/github/license/lua-batteries/lua-batteries?style=flat-square">
  </a>
  <a href="https://github.com/lua-batteries/lua-batteries">
    <img src="https://img.shields.io/github/repo-size/lua-batteries/lua-batteries?logo=github&style=flat-square">
  </a>
</p>

`lua-batteries` is a batteries included lua installation more specifically it is set of meson build scripts to build [Lua](https://www.lua.org), [LuaJIT](https://luajit.org), [luarocks](https://github.com/luarocks/luarocks) and many useful libraries and modules. These scripts were initially based on franko's [lua](https://github.com/franko/lua) and [luajit](https://github.com/franko/luajit) meson build scripts but now they are extended to next level.

## Libraries And Modules

List of included libraries and modules provided by lua-batteries:

| Package                                                               | Build Version                                                                                            | Upstream Version                                                                               |
|-----------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------|
| [argparse](https://github.com/luarocks/argparse)                      | ![lua-batteries](https://img.shields.io/badge/lua--batteries-v0.7.1--1-brightgreen?style=flat-square)    | ![luarocks](https://img.shields.io/luarocks/v/argparse/argparse?style=flat-square)             |
| [bit32](https://github.com/lunarmodules/lua-compat-5.3)               | ![lua-batteries](https://img.shields.io/badge/lua--batteries-v5.3.5--1-brightgreen?style=flat-square)    | ![luarocks](https://img.shields.io/luarocks/v/siffiejoe/bit32?style=flat-square)               |
| [cffi-lua](https://github.com/q66/cffi-lua)                           | ![lua-batteries](https://img.shields.io/badge/lua--batteries-v0.2.3--1-brightgreen?style=flat-square)    | ![luarocks](https://img.shields.io/luarocks/v/q66/cffi-lua?style=flat-square)                  |
| [compat53](https://github.com/lunarmodules/lua-compat-5.3)            | ![lua-batteries](https://img.shields.io/badge/lua--batteries-v0.8--1-brightgreen?style=flat-square)      | ![luarocks](https://img.shields.io/luarocks/v/siffiejoe/compat53?style=flat-square)            |
| [date](https://github.com/Tieske/date)                                | ![lua-batteries](https://img.shields.io/badge/lua--batteries-v2.2--2-brightgreen?style=flat-square)      | ![luarocks](https://img.shields.io/luarocks/v/tieske/date?style=flat-square)                   |
| [inpsect](https://github.com/kikito/inspect.lua)                      | ![lua-batteries](https://img.shields.io/badge/lua--batteries-v3.1.3--0-brightgreen?style=flat-square)    | ![luarocks](https://img.shields.io/luarocks/v/kikito/inspect?style=flat-square)                |
| [lanes](https://github.com/LuaLanes/lanes)                            | ![lua-batteries](https://img.shields.io/badge/lua--batteries-v3.16.0--0-brightgreen?style=flat-square)   | ![luarocks](https://img.shields.io/luarocks/v/benoitgermain/lanes?style=flat-square)           |
| [lpeg](http://www.inf.puc-rio.br/~roberto/lpeg.html)                  | ![lua-batteries](https://img.shields.io/badge/lua--batteries-v1.0.2--1-brightgreen?style=flat-square)    | ![luarocks](https://img.shields.io/luarocks/v/gvvaughan/lpeg?style=flat-square)                |
| [lrexlib-pcre2](https://github.com/rrthomas/lrexlib)                  | ![lua-batteries](https://img.shields.io/badge/lua--batteries-v2.9.1--1-brightgreen?style=flat-square)    | ![luarocks](https://img.shields.io/luarocks/v/rrt/lrexlib-pcre2?style=flat-square)             |
| [lua-cjson](https://github.com/openresty/lua-cjson)                   | ![lua-batteries](https://img.shields.io/badge/lua--batteries-v2.1.0.12--1-brightgreen?style=flat-square) | ![luarocks](https://img.shields.io/luarocks/v/openresty/lua-cjson?style=flat-square)           |
| [luafilesystem](https://github.com/lunarmodules/luafilesystem)        | ![lua-batteries](https://img.shields.io/badge/lua--batteries-v1.8.0--1-brightgreen?style=flat-square)    | ![luarocks](https://img.shields.io/luarocks/v/hisham/luafilesystem?style=flat-square)          |
| [luaossl](https://github.com/wahern/luaossl)                          | ![lua-batteries](https://img.shields.io/badge/lua--batteries-v20220711--0-brightgreen?style=flat-square) | ![luarocks](https://img.shields.io/luarocks/v/daurnimator/luaossl?style=flat-square)           |
| [luaposix](https://github.com/luaposix/luaposix)                      | ![lua-batteries](https://img.shields.io/badge/lua--batteries-v36.1--1-brightgreen?style=flat-square)     | ![luarocks](https://img.shields.io/luarocks/v/gvvaughan/luaposix?style=flat-square)            |
| [lua-protobuf](https://github.com/starwing/lua-protobuf)              | ![lua-batteries](https://img.shields.io/badge/lua--batteries-v0.5.0--1-brightgreen?style=flat-square)    | ![luarocks](https://img.shields.io/luarocks/v/xavier-wang/lua-protobuf?style=flat-square)      |
| [luasec](https://github.com/brunoos/luasec)                           | ![lua-batteries](https://img.shields.io/badge/lua--batteries-v1.3.1--1-brightgreen?style=flat-square)    | ![luarocks](https://img.shields.io/luarocks/v/brunoos/luasec?style=flat-square)                |
| [luasocket](https://github.com/lunarmodules/luasocket)                | ![lua-batteries](https://img.shields.io/badge/lua--batteries-v3.1.0--1-brightgreen?style=flat-square)    | ![luarocks](https://img.shields.io/luarocks/v/lunarmodules/luasocket?style=flat-square)        |
| [lua-sdl2](https://github.com/Tangent128/luasdl2)                     | ![lua-batteries](https://img.shields.io/badge/lua--batteries-v2.0.5--6-brightgreen?style=flat-square)    | ![luarocks](https://img.shields.io/luarocks/v/tangent128/lua-sdl2?style=flat-square)           |
| [lua-batteries/luastatic](https://github.com/lua-batteries/luastatic) | ![lua-batteries](https://img.shields.io/badge/lua--batteries-scm--0-brightgreen?style=flat-square)       | ![luarocks](https://img.shields.io/luarocks/v/ers35/luastatic?style=flat-square)               |
| [luasql-sqlite3](https://github.com/lunarmodules/luasql)              | ![lua-batteries](https://img.shields.io/badge/lua--batteries-v2.6.0--1-brightgreen?style=flat-square)    | ![luarocks](https://img.shields.io/luarocks/v/tomasguisasola/luasql-sqlite3?style=flat-square) |
| [luautf8](https://github.com/starwing/luautf8)                        | ![lua-batteries](https://img.shields.io/badge/lua--batteries-v0.1.5--2-brightgreen?style=flat-square)    | ![luarocks](https://img.shields.io/luarocks/v/xavier-wang/luautf8?style=flat-square)           |
| [lua-zip](https://github.com/brimworks/lua-zip)                       | ![lua-batteries](https://img.shields.io/badge/lua--batteries-v0.2--0-brightgreen?style=flat-square)      | ![luarocks](https://img.shields.io/luarocks/v/brimworks/lua-zip?style=flat-square)             |
| [lua-zlib](https://github.com/brimworks/lua-zlib)                     | ![lua-batteries](https://img.shields.io/badge/lua--batteries-v1.2--2-brightgreen?style=flat-square)      | ![luarocks](https://img.shields.io/luarocks/v/brimworks/lua-zlib?style=flat-square)            |
| [ltui](https://github.com/tboox/ltui)                                 | ![lua-batteries](https://img.shields.io/badge/lua--batteries-v2.7--1-brightgreen?style=flat-square)      | ![luarocks](https://img.shields.io/luarocks/v/waruqi/ltui?style=flat-square)                   |
| [lui](https://github.com/zhaozg/lui)                                  | ![lua-batteries](https://img.shields.io/badge/lua--batteries-scm--0-brightgreen?style=flat-square)       |                                                                                                |
| [luv](https://github.com/luvit/luv)                                   | ![lua-batteries](https://img.shields.io/badge/lua--batteries-v1.44.2--1-brightgreen?style=flat-square)   | ![luarocks](https://img.shields.io/luarocks/v/creationix/luv?style=flat-square)                |
| [lyaml](https://github.com/gvvaughan/lyaml)                           | ![lua-batteries](https://img.shields.io/badge/lua--batteries-v6.2.8--1-brightgreen?style=flat-square)    | ![luarocks](https://img.shields.io/luarocks/v/gvvaughan/lyaml?style=flat-square)               |
| [openssl](https://github.com/zhaozg/lua-openssl)                      | ![lua-batteries](https://img.shields.io/badge/lua--batteries-v0.8.3--1-brightgreen?style=flat-square)    | ![luarocks](https://img.shields.io/luarocks/v/zhaozg/openssl?style=flat-square)                |
| [penlight](https://github.com/lunarmodules/Penlight)                  | ![lua-batteries](https://img.shields.io/badge/lua--batteries-v1.13.1--1-brightgreen?style=flat-square)   | ![luarocks](https://img.shields.io/luarocks/v/tieske/penlight?style=flat-square)               |
| [toml](https://github.com/LebJe/toml.lua)                             | ![lua-batteries](https://img.shields.io/badge/lua--batteries-v0.3.0--0-brightgreen?style=flat-square)    | ![luarocks](https://img.shields.io/luarocks/v/LebJe/toml?style=flat-square)                    |
| [uuid](https://github.com/Tieske/uuid)                                | ![lua-batteries](https://img.shields.io/badge/lua--batteries-v0.3--1-brightgreen?style=flat-square)      | ![luarocks](https://img.shields.io/luarocks/v/tieske/uuid?style=flat-square)                   |
| [winapi](https://github.com/stevedonovan/winapi)                      | ![lua-batteries](https://img.shields.io/badge/lua--batteries-v1.4.2--1-brightgreen?style=flat-square)    | ![luarocks](https://img.shields.io/luarocks/v/steved/winapi?style=flat-square)                 |
| [xml2lua](https://github.com/manoelcampos/xml2lua)                    | ![lua-batteries](https://img.shields.io/badge/lua--batteries-v1.6--1-brightgreen?style=flat-square)      | ![luarocks](https://img.shields.io/luarocks/v/manoelcampos/xml2lua?style=flat-square)          |

## Installation

Visit [releases](https://github.com/lua-batteries/lua-batteries/releases) for prebuilt binaries. You just need to extract archive and add `bin` directory in your `PATH` environment variable. Also, see [INSTALL.md](https://github.com/lua-batteries/lua-batteries/blob/main/INSTALL.md) for installation instructions through meson. 

These prebuilt binaries includes **Lua 5.4.6**, **LuaJIT 2.1.0-beta3** and **luarocks 3.9.2**

| Host    | Architecture | Compiler                                                                                                                                                                  | Download                                                                                                                                |
|---------|--------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------|
| Linux   | x86_64       | [GCC](https://gcc.gnu.org)                                                                                                                                                | [.tar.gz](https://github.com/lua-batteries/lua-batteries/releases/download/v0.5.15/lua-batteries-v0.5.15-x86_64-unknown-linux-gnu.tar.gz) |
| Windows | x86_64       | [MinGW-W64](https://github.com/brechtsanders/winlibs_mingw/releases/download/13.1.0-16.0.2-11.0.0-ucrt-r1/winlibs-x86_64-mcf-seh-gcc-13.1.0-mingw-w64ucrt-11.0.0-r1.7z) | [.7z](https://github.com/lua-batteries/lua-batteries/releases/download/v0.5.15/lua-batteries-v0.5.15-x86_64-w64-mingw32.7z)               |
| Windows | x86_64       | [MSVC](https://visualstudio.microsoft.com)                                                                                                                                | [.7z](https://github.com/lua-batteries/lua-batteries/releases/download/v0.5.15/lua-batteries-v0.5.15-x86_64-pc-windows-msvc.7z)           |

### On Linux (x86_64)

```bash
$ rm -rf /usr/local/lua-batteries-*
$ mkdir /usr/local/lua-batteries-0.5.15
$ curl -L https://github.com/lua-batteries/lua-batteries/releases/download/v0.5.15/lua-batteries-v0.5.15-x86_64-unknown-linux-gnu.tar.xz | tar xJC /usr/local/lua-batteries-0.5.15
$ printf "\nexport PATH=\"\$PATH:/usr/local/lua-batteries-0.5.15/bin\"\n" >> $HOME/.profile
$ source $HOME/.profile
$ lua -v
```
