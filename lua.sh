BASEDIR=$(dirname $0)
export LUA_PATH="@JIT@$BASEDIR/../share/lua/@LUA_VER@/?.lua;$BASEDIR/../share/lua/@LUA_VER@/?/init.lua;$LUA_PATH"
export LUA_CPATH="$BASEDIR/../lib/lua/@LUA_VER@/?.so;$BASEDIR/../lib/lua/@LUA_VER@/loadall.so;$LUA_CPATH"
exec "$BASEDIR/@BIN@" "$@"
