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

## Building (with Lua 5.4.4)

1. Install [meson](https://mesonbuild.com/SimpleStart.html) build system. Then install any one of these c++ compiler: [msvc](https://visualstudio.microsoft.com), [gcc](https://gcc.gnu.org), [mingw](https://www.mingw-w64.org/downloads) or [clang](https://github.com/llvm/llvm-project).

2. Now recursively clone lua-batteries repository. lua-batteries has many submodules which have sub-submodules so it may take few minutes to clone full repository.

```bash
git clone https://github.com/clitic/lua-batteries --recursive --depth 1
cd lua-batteries
```

3. Now setup lua-batteries using meson. Use `--prefix` flag to specify installation directory. When you are targeting linux machines then add `-Dlibdir=PREFIX` flag otherwise libs and modules will be installed in incorrect directories which is set to `/usr/local/lib/ARCH_TRIPLE` by default. On windows `--default-library` should be set to `both` or `shared` it can be set to `static` but then you will need to configure luarocks manually. You can also specify `-Dextra-modules=all` option to build some extra modules like `luasdl2`.

```bash
meson setup build --default-library both --prefix c:/lua
```

4. Now install lua-batteries using meson. The skipped subprojects are not needed at runtime if you still want to keep them, then remove `--skip-subprojects` flag.

```bash
meson install -C build --skip-subprojects "freetype2,libffi,libjpeg-turbo,libpng,libtiff,libuv,ogg,openssl,pcre2,sqlite3,vorbis,zlib"
```

5. Now lua-batteries should be installed in your prefix directory. Now add `PREFIX/bin` in your `PATH` environment variable. On linux you need need to set `LUA_PATH` and `LUA_CPATH` environment variables or you can use `lua54` shell script.

6. You can further read more information about meson from meson's quick [guide](https://mesonbuild.com/Quick-guide.html). You can also see [meson_options.txt](https://github.com/clitic/lua-batteries/blob/main/meson_options.txt) for customizing your installation.

## Building (with LuaJIT 2.0.5)

Follow same steps as above but first apply some patches and run `meson setup` command with `-Dluajit=true` flag. You can use same prefix used for lua installation. Use `--wipe` flag if you have already built without luajit option.

```bash
cd subprojects/luajit/LuaJIT
git apply ../patches/lua-batteries-updated-lua-search-path-on-windows.patch
```

## Setting Up LuaRocks

Once you have installed lua-batteries using `meson install` command then you need to add `PREFIX/bin` in your `PATH` environment variable. Now you need to update the manifest file so that luarocks can see the installed rocks.
Use `luarocks-admin` and `luarocks-admin-jit` command to do so.

```bash
luarocks-admin make-manifest --local-tree
```

Now you can use `luarocks` and `luarocks-jit` command to install rocks. Rocks are installed in `PREFIX/share/lua/LUA_VER` and `PREFIX/lib/lua/LUA_VER` directories. This can be changed by updating luarocks scripts in bin directory.

- Install rocks for lua installation

```bash
luarocks install busted
```

- Install rocks for luajit installation

```bash
luarocks-jit install busted
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
$ meson setup build -Dstandalone=true --default-library both --cross-file cross/x86_64-w64-mingw32.ini --prefix $HOME/lua-mingw 
$ meson install -C build --skip-subprojects "freetype2,libffi,libjpeg-turbo,libpng,libtiff,libuv,ogg,openssl,pcre2,sqlite3,vorbis,zlib"
$ meson setup build -Dstandalone=true -Dluajit=true --default-library both --cross-file cross/x86_64-w64-mingw32.ini --prefix $HOME/lua-mingw --wipe
$ meson install -C build --skip-subprojects "freetype2,libffi,libjpeg-turbo,libpng,libtiff,libuv,ogg,openssl,pcre2,sqlite3,vorbis,zlib"
```

Now pack generated lua-batteries installation directory. 

```bash
$ cd $HOME/lua-mingw
$ zip -r ../lua-batteries-v0.2.0-x86_64-pc-windows-gnu.zip *
```
