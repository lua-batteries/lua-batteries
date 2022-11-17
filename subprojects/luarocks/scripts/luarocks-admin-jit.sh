BASEDIR=$(dirname $0)
export LUA_PATH="$BASEDIR/../share/lua/5.1/?.lua;$BASEDIR/../share/lua/5.1/?/init.lua;$LUA_PATH"
export LUA_CPATH="$BASEDIR/../lib/lua/5.1/?.so;$BASEDIR/../lib/lua/5.1/loadall.so;$LUA_CPATH"
export LUAROCKS_SYSCONFDIR="$BASEDIR/../share/lua"
"$BASEDIR/luajit" "$BASEDIR/../share/lua/bin/luarocks.lua" config --scope system home_tree "$BASEDIR/.." > /dev/null
exec "$BASEDIR/luajit" "$BASEDIR/../share/lua/bin/luarocks-admin.lua" "$@"
