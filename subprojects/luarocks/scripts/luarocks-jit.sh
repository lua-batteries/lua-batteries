BASEDIR=$(dirname $0)
LUA_VER="5.1"
LUAROCKS_BIN_DIR="$BASEDIR/../lib/luarocks/rocks-$LUA_VER/luarocks/3.9.1-1/bin"
export LUA_PATH="$BASEDIR/../share/lua/$LUA_VER/?.lua;$BASEDIR/../share/lua/$LUA_VER/?/init.lua;$LUA_PATH"
export LUA_CPATH="$BASEDIR/../lib/lua/$LUA_VER/?.so;$BASEDIR/../lib/lua/$LUA_VER/loadall.so;$LUA_CPATH"
export LUAROCKS_SYSCONFDIR="$BASEDIR/../lib/luarocks/rocks-$LUA_VER"
"$BASEDIR/luajit" "$LUAROCKS_BIN_DIR/luarocks.lua" config --scope system home_tree "$BASEDIR/.." > /dev/null
exec "$BASEDIR/luajit" "$LUAROCKS_BIN_DIR/luarocks.lua" "$@"
