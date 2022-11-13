project(
  'lua-meson',
  'c',
  version: '0.1.0',
  license: 'MIT',
  default_options: [
    'buildtype=release'
  ],
  meson_version: '>=0.63.0'
)

cc = meson.get_compiler('c')
cc_id = cc.get_id()
system = host_machine.system()
module_suffix = 'so'

if system == 'windows'
  module_suffix = 'dll'
endif

lua = subproject('lua')
config = {'lua': '5.4.4', 'apps': get_option('apps')}

lua_dep = lua.get_variable('lua_dep')

if get_option('luasocket')
  subdir('modules/luasocket')
endif

if get_option('luajit')
  subproject('luajit')
  config += {'luajit': '2.0.5'}
endif

if get_option('luarocks')
  subproject('luarocks')
  config += {'luarocks': '3.9.1'}
endif

summary(
  config,
  bool_yn: true,
  section: 'Configuration'
)
