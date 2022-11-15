project(
  'lua-batteries',
  version: '0.2.0',
  license: 'MIT',
  default_options: [
    'buildtype=release',
    'default_library=both'
  ],
  meson_version: '>=0.64.0'
)

modules = get_option('modules')
config = {'apps': get_option('apps')}

if get_option('luajit')
  subproject('luajit')
  config += {'luajit': '2.0.5'}
else
  subproject('lua')
  config += {'lua': '5.4.4'}
endif

if get_option('luarocks')
  subproject('luarocks')
  config += {'luarocks': '3.9.1'}
endif

if 'all' in modules or 'cffi-lua' in modules
  subproject('cffi-lua')
  config += {'modules/cffi-lua': '0.2.2'}
endif

if 'all' in modules or 'lua-cjson' in modules
  subproject('lua-cjson')
  config += {'modules/lua-cjson': '2.1.0.9'}
endif

if 'all' in modules or 'lua-openssl' in modules
  subproject('lua-openssl')
  config += {'modules/lua-openssl': '0.8.2'}
endif

if 'all' in modules or 'luafilesystem' in modules
  subproject('luafilesystem')
  config += {'modules/luafilesystem': '1.8.0'}
endif

if 'all' in modules or 'luasec' in modules
  subproject('luasec')
  config += {'modules/luasec': '1.2.0'}
endif

if 'all' in modules or 'luasocket' in modules
  subproject('luasocket')
  config += {'modules/luasocket': '3.1.0'}
endif

if 'all' in modules or 'luasql-sqlite3' in modules
  subproject('luasql-sqlite3')
  config += {'modules/luasql-sqlite3': '2.6.0'}
endif

if 'all' in modules or 'luautf8' in modules
  subproject('luautf8')
  config += {'modules/luautf8': '0.1.4'}
endif

if 'all' in modules or 'luv' in modules
  subproject('luv')
  config += {'modules/luv': '1.44.2'}
endif

summary(
  config,
  bool_yn: true,
  section: 'Configuration'
)
