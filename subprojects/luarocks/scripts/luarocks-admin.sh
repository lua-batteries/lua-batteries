BASEDIR=$(dirname $0)
export LUA_PATH="$BASEDIR/../share/lua/@LUA_VER@/?.lua;$BASEDIR/../share/lua/@LUA_VER@/?/init.lua;$LUA_PATH"
export LUA_CPATH="$BASEDIR/../lib/lua/@LUA_VER@/?.so;$BASEDIR/../lib/lua/@LUA_VER@/loadall.so;$LUA_CPATH"
export LUAROCKS_SYSCONFDIR="$BASEDIR/../lib/luarocks/rocks-@LUA_VER@"
"$BASEDIR/@BIN@" "$BASEDIR/../lib/luarocks/rocks-@LUA_VER@/luarocks/@LUAROCKS_VER@-1/bin/luarocks.lua" config --scope system home_tree "$BASEDIR/.." > /dev/null
exec "$BASEDIR/@BIN@" "$BASEDIR/../lib/luarocks/rocks-@LUA_VER@/luarocks/@LUAROCKS_VER@-1/bin/luarocks-admin.lua" "$@"
