BASEDIR=$(dirname $0)
LUA_PATH="$BASEDIR/../share/lua/5.4/?.lua;$BASEDIR/../share/lua/5.4/?/init.lua;$LUA_PATH"
LUA_CPATH="$BASEDIR/../lib/lua/5.4/?.so;$BASEDIR/../lib/lua/5.4/loadall.so;$LUA_CPATH"
exec "$BASEDIR/lua" "$@"
