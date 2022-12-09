BASEDIR=$(dirname $0)
exec "$BASEDIR/@BIN@" "$BASEDIR/../lib/luarocks/rocks-@LUA_VER@/luastatic/@ROCKSPEC_VER@/bin/luastatic.lua" "$@"
