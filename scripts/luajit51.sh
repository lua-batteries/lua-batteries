BASEDIR=$(dirname $0)
export LUA_PATH="$BASEDIR/../share/luajit-2.0.5/?.lua;$BASEDIR/../share/lua/5.1/?.lua;$BASEDIR/../share/lua/5.1/?/init.lua;$LUA_PATH"
export LUA_CPATH="$BASEDIR/../lib/lua/5.1/?.so;$BASEDIR/../lib/lua/5.1/loadall.so;$LUA_CPATH"
exec "$BASEDIR/luajit" "$@"
