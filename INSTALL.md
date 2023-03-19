## INSTALL.md

## Libraries And Modules

Since lua-batteries is a batteries included installation it is better to understand about how libraries and modules are built and how their dependencies are resolved. Dependencies are first searched in your system if they are found they are linked dynamically to lua module else dependency is built and linked statically to lua module. If you want to force static linking without depending on system libs to be present, then use `-Dstandalone=true` meson option. Libraries and modules are further classified in three different categories:

1. [modules](https://github.com/lua-batteries/lua-batteries/blob/main/meson_options.txt#L1-L30): The libraries and modules whose dependencies can be built from their sources and they can link statically to main module. By default all available modules are built.

2. [extra-modules](https://github.com/lua-batteries/lua-batteries/blob/main/meson_options.txt#L32-L43): The libraries and modules whose dependencies can or cannot built from their sources and they might link dynamically to main module. By default no modules are built. On windows these modules can be built from there sources there is no need to resolve their dependencies. On ubuntu modules dependencies can be resolved by installing these packages:

```bash
# lua-sdl2
sudo apt install \
  libsdl2-2.0-0 libsdl2-dev \
  libsdl2-image-2.0-0 libsdl2-image-dev \
  libsdl2-mixer-2.0-0 libsdl2-mixer-dev \
  libsdl2-net-2.0-0 libsdl2-net-dev \
  libsdl2-ttf-2.0-0 libsdl2-ttf-dev
# ltui
sudo apt install libncurses5 libncurses5-dev
# lui
sudo apt install libgtk-3-0 libgtk-3-dev
```

3. [os-modules](https://github.com/lua-batteries/lua-batteries/blob/main/meson_options.txt#L45-L50): The libraries which are specific to operating system and platform. It is [winapi](https://github.com/stevedonovan/winapi) on windows and [luaposix](https://github.com/luaposix/luaposix) on posix platforms. This option is turned on by default.

## Building (with Lua)

1. Install [meson](https://mesonbuild.com/SimpleStart.html) build system. Then install any one of these c++ compiler: [msvc](https://visualstudio.microsoft.com), [gcc](https://gcc.gnu.org)>=9, [mingw](https://www.mingw-w64.org/downloads) or [clang](https://github.com/llvm/llvm-project).

2. Now clone lua-batteries repository. You can also use released tarball.

```bash
git clone https://github.com/lua-batteries/lua-batteries
cd lua-batteries
```

3. Now setup lua-batteries using meson. Use `--prefix` flag to specify installation directory. Also add `--libdir $PREFIX/lib` flag if you are targeting non windows platforms otherwise libs and modules will be installed in incorrect directories which is `$PREFIX/ARCH_TRIPLE/lib`. On windows `--default-library` should be set to `both` or `shared` it can be set to `static` but then you will need to configure luarocks manually. You can also specify `-Dextra-modules=all` option to build some extra modules like `lua-sdl2`. For more meson options see [meson_options.txt](https://github.com/lua-batteries/lua-batteries/blob/main/meson_options.txt).

```bash
meson setup build --warnlevel 0 --prefix $HOME/lua-batteries --libdir $HOME/lua-batteries/lib
```

4. Now install lua-batteries using meson. The skipped subprojects are not needed at runtime if you still want to keep them, then remove `--skip-subprojects` flag.

```bash
meson install -C build --skip-subprojects "freetype2,libffi,libjpeg-turbo,libpng,libtiff,libui,libuv,libyaml,libzip,ogg,openssl,pcre2,sqlite3,vorbis,zlib"
```

5. Also remove `_` from `_` prefixed modules. This is not renamed by default because meson only accepts unique target names.

```bash
mv $PREFIX/lib/lua/5.4/mime/_core.so $PREFIX/lib/lua/5.4/mime/core.so
mv $PREFIX/lib/lua/5.4/posix/_time.so $PREFIX/lib/lua/5.4/posix/time.so
```

6. Now lua-batteries should be installed in your prefix directory. Now add `$PREFIX/bin` in your `PATH` environment variable. On linux you need need to set `LUA_PATH` and `LUA_CPATH` environment variables if `$PREFIX` is not `/usr/local` or you can use `lua54` shell script.

7. You can further read more information about building through meson from meson's quick [guide](https://mesonbuild.com/Quick-guide.html).

## Building (with LuaJIT)

Follow same steps as above but, run `meson setup` command with `-Dluajit=true` flag. You can use same prefix used for lua installation. Delete build directory if you have already built without luajit option.

## Setting Up LuaRocks

Once you have installed lua-batteries using `meson install` command then you need to add `$PREFIX/bin` in your `PATH` environment variable. Now you need to update the manifest file so that luarocks can see the installed rocks.
Use `luarocks-admin` and `luarocks-admin-jit` command to do so.

```bash
luarocks-admin make-manifest --local-tree
```

Now you can use `luarocks` and `luarocks-jit` command to install rocks. Rocks are installed in `$PREFIX/share/lua/LUA_VER` and `$PREFIX/lib/lua/LUA_VER` directories. This can be changed by updating luarocks scripts in bin directory.

- Install rocks for lua installation

```bash
luarocks install tl
```

- Install rocks for luajit installation

```bash
luarocks-jit install tl
```

## Cross Compilation

See meson [cross compilation](https://mesonbuild.com/Cross-compilation.html) documentation. This example shows how to cross compile from ubuntu to windows using mingw.

```bash
apt install mingw-w64
```

Now clone lua-batteries repository.

```bash
$ git clone https://github.com/lua-batteries/lua-batteries
```

Now change directory to project root and build project using meson.

```bash
$ meson setup build --warnlevel 0 --default-library both --cross-file cross/x86_64-w64-mingw32.ini --prefix $HOME/lua-batteries -Dstandalone=true
$ meson install -C build --skip-subprojects "freetype2,libffi,libjpeg-turbo,libpng,libtiff,libui,libuv,libyaml,libzip,ogg,openssl,pcre2,sqlite3,vorbis,zlib"
$ rm -rf build
$ meson setup build --warnlevel 0 --default-library both --cross-file cross/x86_64-w64-mingw32.ini --prefix $HOME/lua-batteries -Dstandalone=true -Dluajit=true
$ meson install -C build --skip-subprojects "freetype2,libffi,libjpeg-turbo,libpng,libtiff,libui,libuv,libyaml,libzip,ogg,openssl,pcre2,sqlite3,vorbis,zlib"
```

Now pack generated lua-batteries installation directory. 

```bash
$ cd $HOME/lua-batteries
$ zip -r ../lua-batteries-x86_64-w64-mingw32.zip *
```
