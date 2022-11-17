BASEDIR=$(dirname $0)
LUA_PATH="$BASEDIR/../share/lua/5.1/?.lua;$BASEDIR/../share/lua/5.1/?/init.lua;$LUA_PATH"
LUA_CPATH="$BASEDIR/../lib/lua/5.1/?.so;$BASEDIR/../lib/lua/5.1/loadall.so;$LUA_CPATH"
LUAROCKS_SYSCONFDIR="$BASEDIR/../share/lua"
exec "$BASEDIR/luajit" "$BASEDIR/../share/lua/bin/luarocks.lua" config --scope system home_tree "$BASEDIR/.." > /dev/null
exec "$BASEDIR/luajit" "$BASEDIR/../share/lua/bin/luarocks.lua" "$@"
