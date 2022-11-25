BASEDIR=$(dirname $0)
exec "$BASEDIR/luajit" -e "json=require('cjson');util=require('cjson.util');json_text=util.file_load(arg[1]);t=json.decode(json_text);print(util.serialise_value(t));" "$@"
