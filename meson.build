project(
  'lua-batteries',
  version: '0.5.15',
  license: 'MIT',
  default_options: [
    'buildtype=release',
    'default_library=static'
  ],
  meson_version: '>=1.0.0'
)

system = host_machine.system()
modules = get_option('modules')
extra_modules = get_option('extra-modules')
config = {'apps': get_option('apps')}

if get_option('luajit')
  subproject('luajit')
  config += {'luajit': '2.1.0-beta3'}
else
  subproject('lua')
  config += {'lua': '5.4.6'}
endif

if system != 'windows'
  install_data(
    configure_file(
      input: 'lua.sh',
      output: get_option('luajit') ? 'luajit51' : 'lua54',
      configuration: {
        'BIN': get_option('luajit') ? 'luajit' : 'lua',
        'JIT': get_option('luajit') ? '$BASEDIR/../share/luajit-2.1.0-beta3/?.lua;' : '',
        'LUA_VER': get_option('luajit') ? '5.1' : '5.4'
      }
    ),
    install_mode: 'rwxr-xr-x',
    install_dir: get_option('bindir')
  )
endif

if get_option('luarocks')
  subproject('luarocks')
  config += {'luarocks': '3.9.2'}
endif

if 'all' in modules or 'argparse' in modules
  subproject('argparse')
  config += {'modules/argparse': '0.7.1'}
endif

if 'all' in modules or 'cffi-lua' in modules
  subproject('cffi-lua')
  config += {'modules/cffi-lua': '0.2.3'}
endif

if 'all' in modules or 'compat53+bit32' in modules
  subproject('compat53_bit32')
  config += {'modules/compat53': '0.8'}
  config += {'modules/bit32': '5.3.5'}
endif

if 'all' in modules or 'date' in modules
  subproject('date')
  config += {'modules/date': '2.2'}
endif

if 'all' in modules or 'inspect' in modules
  subproject('inspect')
  config += {'modules/inspect': '3.1.3'}
endif

if 'all' in modules or 'lanes' in modules
  subproject('lanes')
  config += {'modules/lanes': '3.16.0'}
endif

if 'all' in modules or 'lpeg' in modules
  subproject('lpeg')
  config += {'modules/lpeg': '1.0.2'}
endif

if 'all' in modules or 'lrexlib-pcre2' in modules
  subproject('lrexlib-pcre2')
  config += {'modules/lrexlib-pcre2': '2.9.1'}
endif

if 'all' in modules or 'lua-cjson' in modules
  subproject('lua-cjson')
  config += {'modules/lua-cjson': '2.1.0.10'}
endif

if 'all' in modules or 'luafilesystem' in modules
  subproject('luafilesystem')
  config += {'modules/luafilesystem': '1.8.0'}
endif

if 'all' in modules or 'luaossl' in modules
  subproject('luaossl')
  config += {'modules/luaossl': '20220711'}
endif

if 'all' in modules or 'lua-protobuf' in modules
  subproject('lua-protobuf')
  config += {'modules/lua-protobuf': '0.5.0'}
endif

if 'all' in modules or 'luasec' in modules
  subproject('luasec')
  config += {'modules/luasec': '1.3.1'}
endif

if 'all' in modules or 'luasocket' in modules
  subproject('luasocket')
  config += {'modules/luasocket': '3.1.0'}
endif

if 'all' in modules or 'luasql-sqlite3' in modules
  subproject('luasql-sqlite3')
  config += {'modules/luasql-sqlite3': '2.6.0'}
endif

if 'all' in modules or 'luastatic' in modules
  subproject('luastatic')
  config += {'modules/luastatic': 'scm'}
endif

if 'all' in modules or 'luautf8' in modules
  subproject('luautf8')
  config += {'modules/luautf8': '0.1.5'}
endif

if 'all' in modules or 'lua-zip' in modules
  subproject('lua-zip')
  config += {'modules/lua-zip': '0.2'}
endif

if 'all' in modules or 'lua-zlib' in modules
  subproject('lua-zlib')
  config += {'modules/lua-zlib': '1.2'}
endif

if 'all' in modules or 'luv' in modules
  subproject('luv')
  config += {'modules/luv': '1.44.2'}
endif

if 'all' in modules or 'lyaml' in modules
  subproject('lyaml')
  config += {'modules/lyaml': '6.2.8'}
endif

if 'all' in modules or 'openssl' in modules
  subproject('lua-openssl')
  config += {'modules/openssl': '0.8.3'}
endif

if 'all' in modules or 'penlight' in modules
  subproject('penlight')
  config += {'modules/penlight': '1.13.1'}
endif

if 'all' in modules or 'toml' in modules
  subproject('toml')
  config += {'modules/toml': '0.3.0'}
endif

if 'all' in modules or 'uuid' in modules
  subproject('uuid')
  config += {'modules/uuid': '0.3'}
endif

if 'all' in modules or 'xml2lua' in modules
  subproject('xml2lua')
  config += {'modules/xml2lua': '1.5'}
endif

if 'all' in extra_modules or 'lua-sdl2' in extra_modules
  subproject('lua-sdl2')
  config += {'extra-modules/lua-sdl2': '2.0.5'}
endif

if 'all' in extra_modules or 'ltui' in extra_modules
  subproject('ltui')
  config += {'extra-modules/ltui': '2.7'}
endif

if 'all' in extra_modules or 'lui' in extra_modules
  subproject('lui')
  config += {'extra-modules/lui': 'scm'}
endif

if get_option('os-modules')
  if system == 'windows'
    subproject('winapi')
    config += {'os-modules/winapi': '1.4.2'}
  else
    subproject('luaposix')
    config += {'os-modules/luaposix': '36.1'}
  endif
endif

summary(
  config,
  bool_yn: true,
  section: 'Configuration'
)
