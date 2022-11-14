project(
  'lua-meson',
  version: '0.2.0',
  license: 'MIT',
  default_options: [
    'buildtype=release',
    'default_library=both'
  ],
  meson_version: '>=0.63.0'
)

subproject('lua')
config = {'lua': '5.4.4', 'apps': get_option('apps')}
modules = get_option('modules')
module_options = ['luajit-mod=' + get_option('luajit-mod')]

if get_option('luajit')
  subproject('luajit')
  config += {'luajit': '2.0.5'}
endif

if get_option('luarocks')
  subproject('luarocks')
  config += {'luarocks': '3.9.1'}
endif

if 'all' in modules or 'cffi-lua' in modules
  subproject('cffi-lua', default_options: module_options)
  config += {'modules/cffi-lua': '0.2.2'}
endif

if 'all' in modules or 'luasec' in modules
  subproject('luasec', default_options: module_options)
  config += {'modules/luasec': '1.2.0'}
endif

if 'all' in modules or 'luasocket' in modules
  subproject('luasocket', default_options: module_options)
  config += {'modules/luasocket': '3.1.0'}
endif

summary(
  config,
  bool_yn: true,
  section: 'Configuration'
)
