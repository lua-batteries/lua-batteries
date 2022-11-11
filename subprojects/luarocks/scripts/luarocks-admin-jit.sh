BASEDIR=$(dirname $0)
LUAROCKS_SYSCONFDIR="$BASEDIR/../share/lua"
exec luajit "$BASEDIR/../share/lua/bin/luarocks-admin.lua" "$@"
