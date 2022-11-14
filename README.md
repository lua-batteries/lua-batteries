<h1 align="center">lua-meson</h1>

<p align="center">
  <a href="https://github.com/clitic/lua-meson/blob/main/LICENSE">
    <img src="https://img.shields.io/github/license/clitic/lua-meson?style=flat-square">
  </a>
  <a href="https://github.com/clitic/lua-meson">
    <img src="https://img.shields.io/github/repo-size/clitic/lua-meson?logo=github&style=flat-square">
  </a>
</p>

`lua-meson` is set of meson build scripts to build [Lua](https://www.lua.org), [LuaJIT](https://luajit.org) and [luarocks](https://github.com/luarocks/luarocks) and install them in a single directory. These scripts are based on franko's [lua](https://github.com/franko/lua) and [luajit](https://github.com/franko/luajit) meson build scripts. This project is also similar to [hererocks](https://github.com/mpeterv/hererocks) expect it uses meson instead of make to build lua and luajit and has different install structure. Lua sources are kept untouched only luajit is patched to extend package search path on windows.

## Prebuilt Packages

- [Lua 5.4.4 + LuaJIT 2.0.5](https://github.com/clitic/lua-meson/releases/download/v0.1.0/lua-meson-v0.1.0-x86_64-pc-windows-msvc.zip) (Windows MSVC)

## Building

Install [meson](https://mesonbuild.com/SimpleStart.html) build system. On windows download and install [msvc](https://visualstudio.microsoft.com) or [mingw](https://www.mingw-w64.org/downloads) or [clang](https://github.com/llvm/llvm-project) c compiler.

Now clone lua-meson repository.

```bash
$ git clone https://github.com/clitic/lua-meson --recursive --depth 1
```

Now apply luajit patches for windows.

```bash
$ cd lua-meson/subprojects/luajit/LuaJIT
$ git apply ../patches/lua-meson-updated-lua-search-path-on-windows.patch
```

Now change directory to project root and build project using meson.

```
$ meson setup build --prefix=c:/lua
$ meson install -C build --skip-subprojects libffi,libuv,openssl,sqlite3
```

See more information about building from meson's quick [guide](https://mesonbuild.com/Quick-guide.html).

## Usage

Once you have installed lua using `meson install` command then you need to add `PREFIX/bin` in your `PATH` environment variable. The you can use `luarocks` command to install rocks for lua installation and `luarocks-jit` command to install rocks for luajit installation. On windows rocks are installed in `PREFIX/share/lua` and `PREFIX/lib/lua` directories. On other operating systems you might need to manually configure luarocks for `home_tree` path.

```bash
$ luarocks install luasocket
$ luarocks-jit install inspect
```

## Cross Compilation

See meson [cross compilation](https://mesonbuild.com/Cross-compilation.html) documentation. This example shows how to cross compile from ubuntu to windows using mingw.

First install mingw toolchain and wine64.

```bash
$ apt install mingw-w64 wine64
```

> Note: wine64 is only needed if you want to build luajit which is enabled by default. It can be disabled by using `-Dluajit=false` option.

Now clone lua-meson repository and apply luajit patches.

```bash
$ git clone https://github.com/clitic/lua-meson --recursive --depth 1
$ cd lua-meson/subprojects/luajit/LuaJIT
$ git apply ../patches/lua-meson-updated-lua-search-path-on-windows.patch
```

Now change directory to project root and build project using meson.

```
$ meson setup build -Dstandalone=true --cross-file=cross/x86_64-w64-mingw32.ini --prefix=lua-mingw 
$ meson install -C build --skip-subprojects libffi,libuv,openssl,sqlite3
```

Now pack generated lua-meson installation directory. 

```bash
$ cd lua-mingw
$ zip -r ../lua-v5.4.4-x86_64-mingw.zip *
```

<!-- 
```powershell
meson setup build --prefix=d:/workdesk/public-projects/lua-meson/lua -Dluajit
=false
meson install -C build --skip-subprojects libffi
$env:PATH="d:/workdesk/public-projects/lua-meson/lua/bin;$env:PATH"
``` -->
