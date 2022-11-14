project(
  'luasql-sqlite3',
  'c',
  version: '2.6.0',
  license: 'MIT',
  meson_version: '>=0.63.0'
)

# -------------------------------------------------
# BASE SETUP
# -------------------------------------------------

cc = meson.get_compiler('c')
system = host_machine.system()
module_suffix = 'so'

if system == 'windows'
  module_suffix = 'dll'
endif

lua_dep = get_option('luajit-mod') ? subproject('luajit').get_variable('luajit_dep') : subproject('lua').get_variable('lua_dep')
lua_ver = get_option('luajit-mod') ? '5.1' : '5.4'
project_deps = [lua_dep]

# -------------------------------------------------
# LUA MODULE
# -------------------------------------------------

sqlite3_dep = dependency('sqlite3', required: false)

if get_option('standalone') or not sqlite3_dep.found()
  sqlite3 = subproject('sqlite3', default_options: ['default_library=static'])
  project_deps += sqlite3.get_variable('sqlite3_dep')
else
  project_deps += sqlite3_dep
endif

shared_module(
  'sqlite3',
  ['luasql/src/luasql.c', 'luasql/src/ls_sqlite3.c'],
  dependencies: project_deps,
  name_prefix: '',
  name_suffix: module_suffix,
  install: true,
  install_dir: get_option('libdir') / 'lua' / lua_ver / 'luasql'
)

# -------------------------------------------------
# EXTRA DATA
# -------------------------------------------------

data_dir = get_option('libdir') / 'luarocks/rocks-' + lua_ver / 'luasql-sqlite3/2.6.0-1'

install_data(
  'luasql/rockspec/luasql-sqlite3-2.6.0-1.rockspec',
  install_dir: data_dir
)

install_subdir(
  'luasql/docs',
  install_dir: data_dir / 'docs'
)
