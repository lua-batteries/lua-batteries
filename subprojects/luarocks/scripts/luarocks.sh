BASEDIR=$(dirname $0)
export LUA_PATH="$BASEDIR/../share/lua/5.4/?.lua;$BASEDIR/../share/lua/5.4/?/init.lua;$LUA_PATH"
export LUA_CPATH="$BASEDIR/../lib/lua/5.4/?.so;$BASEDIR/../lib/lua/5.4/loadall.so;$LUA_CPATH"
export LUAROCKS_SYSCONFDIR="$BASEDIR/../share/lua"
# exec "$BASEDIR/lua" "$BASEDIR/../share/lua/bin/luarocks.lua" config --scope system home_tree "$BASEDIR/.." > /dev/null
exec "$BASEDIR/lua" "$BASEDIR/../share/lua/bin/luarocks.lua" "$@"
