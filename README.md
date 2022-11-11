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

## Building

Install [meson](https://mesonbuild.com/SimpleStart.html) build system. On windows download and install [msvc](https://visualstudio.microsoft.com) or [mingw](https://www.mingw-w64.org/downloads) or [clang](https://github.com/llvm/llvm-project) c compiler.

```bash
$ git clone https://github.com/clitic/lua-meson --recursive --depth 1
$ meson setup build --prefix=d:/lua
$ meson install -C build
```

See more information about building from meson's quick [guide](https://mesonbuild.com/Quick-guide.html).

## Usage

Once you have installed lua using `meson install` command then you need to add `PREFIX/bin` in your `PATH` environment variable. The you can use `luarocks` command to install rocks for lua installation and `luarocks-jit` command to install rocks for luajit installation. On windows rocks are installed in `PREFIX/share/lua` and `PREFIX/lib/lua` directories. On other operating systems you might need to manually configure luarocks for `home_tree` path.

```bash
$ luarocks install luasocket
$ luarocks-jit install inspect
```

> For building `c` modules with msvc you need to open developer command prompt on windows and then run luarocks or luarocks-jit.
