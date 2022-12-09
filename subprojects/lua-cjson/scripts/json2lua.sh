BASEDIR=$(dirname $0)
exec "$BASEDIR/@BIN@" "$BASEDIR/../lib/luarocks/rocks-@LUA_VER@/lua-cjson/@ROCKSPEC_VER@/bin/json2lua.lua" "$@"
