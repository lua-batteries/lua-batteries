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

## Prebuilt Packages

- [lua-batteries-v0.1.0-x86_64-pc-windows-msvc.zip](https://github.com/clitic/lua-batteries/releases/download/v0.1.0/lua-batteries-v0.1.0-x86_64-pc-windows-msvc.zip) (Lua 5.4.4 + LuaJIT 2.0.5)

## Building (Lua 5.4.4)

1. Install [meson](https://mesonbuild.com/SimpleStart.html) build system. Then install any one of these c++ compiler: [msvc](https://visualstudio.microsoft.com), [gcc](https://gcc.gnu.org), [mingw](https://www.mingw-w64.org/downloads) or [clang](https://github.com/llvm/llvm-project).

2. Now recursively clone lua-batteries repository. lua-batteries has many submodules which have sub-submodules so it may take few seconds to clone full repository.

```bash
git clone https://github.com/clitic/lua-batteries --recursive --depth 1
cd lua-batteries
```

3. Now setup lua-batteries using meson. Use `--prefix` flag to specify installation directory. When you are targeting linux machines then add `-Dlibdir=PREFIX` flag otherwise libs and modules will be installed in incorrect directories. Default value of libdir on linux is set to `/usr/local/lib/ARCH_TRIPLE`.

```bash
meson setup build --prefix=c:/lua
```

4. Now install lua-batteries using meson. The skipped subprojects are not needed at runtime if you still want to keep them, then remove `--skip-subprojects` flag.

```bash
meson install -C build --skip-subprojects libffi,libuv,openssl,sqlite3,zlib
```

5. Now lua-batteries should be installed in your prefix directory. Now add `PREFIX/bin` in your `PATH` environment variable. On linux you need need to set `LUA_PATH=PREFIX/../share/lua/5.4/?.lua` and `LUA_CPATH=PREFIX/../lib/lua/5.4/?.so` environment variable too.

6. You can further read more information about meson from meson's quick [guide](https://mesonbuild.com/Quick-guide.html). You can also see [meson_options.txt](https://github.com/clitic/lua-batteries/blob/main/meson_options.txt) for customizing your installation.

## Building (LuaJIT 2.0.5)

Follow same steps as above but first apply some patches and run `meson setup` command with `-Dluajit=true` flag. You can use same prefix used for lua installation. Use `meson configure` command if you have already built without luajit meson option.

```bash
cd subprojects/luajit/LuaJIT
git apply ../patches/lua-batteries-updated-lua-search-path-on-windows.patch
```

## Using LuaRocks

Once you have installed lua-batteries using `meson install` command then you need to add `PREFIX/bin` in your `PATH` environment variable. The you can use `luarocks` command to install rocks for lua installation and `luarocks-jit` command to install rocks for luajit installation. On windows rocks are installed in `PREFIX/share/lua` and `PREFIX/lib/lua` directories. On other operating systems you might need to manually configure luarocks for `home_tree` path.

```bash
$ luarocks install luasocket
$ luarocks-jit install inspect
```

## Cross Compilation

See meson [cross compilation](https://mesonbuild.com/Cross-compilation.html) documentation. This example shows how to cross compile from ubuntu to windows using mingw.

First install mingw toolchain and wine64.

```bash
apt install mingw-w64 wine64
```

> Note: wine64 is only needed if you want to build luajit which is disabled by default.

Now clone lua-batteries repository and apply luajit patches.

```bash
$ git clone https://github.com/clitic/lua-batteries --recursive --depth 1
$ cd lua-batteries/subprojects/luajit/LuaJIT
$ git apply ../patches/lua-batteries-updated-lua-search-path-on-windows.patch
```

Now change directory to project root and build project using meson.

```bash
$ meson setup build -Dstandalone=true --cross-file=cross/x86_64-w64-mingw32.ini --prefix=$HOME/lua-mingw 
$ meson install -C build --skip-subprojects libffi,libuv,openssl,sqlite3
$ meson configure build -Dstandalone=true -Dluajit=true --cross-file=cross/x86_64-w64-mingw32.ini --prefix=$HOME/lua-mingw
$ meson install -C build --skip-subprojects libffi,libuv,openssl,sqlite3,zlib
```

Now pack generated lua-batteries installation directory. 

```bash
$ cd $HOME/lua-mingw
$ zip -r ../lua-batteries-v0.2.0-x86_64-pc-windows-gnu.zip *
```
