BASEDIR=$(dirname $0)
exec "$BASEDIR/lua" "$BASEDIR/../lib/luarocks/rocks-5.4/lua-cjson/2.1.0.10-1/bin/json2lua.lua" "$@"
