BASEDIR=$(dirname $0)
LUAROCKS_SYSCONFDIR="$BASEDIR/../share/lua"
exec lua "$BASEDIR/../share/lua/bin/luarocks.lua" "$@"
