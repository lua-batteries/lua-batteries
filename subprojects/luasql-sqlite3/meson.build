project(
  'luasql-sqlite3',
  'c',
  version: '2.6.0',
  license: 'MIT',
  meson_version: '>=0.64.0'
)

# -------------------------------------------------
# BASE SETUP
# -------------------------------------------------

cc = meson.get_compiler('c')
cc_id = cc.get_id()
system = host_machine.system()
module_suffix = 'so'

if system == 'windows'
  module_suffix = 'dll'
endif

lua_dep = get_option('luajit') ? subproject('luajit').get_variable('luajit_dep') : subproject('lua').get_variable('lua_dep')
lua_ver = get_option('luajit') ? '5.1' : '5.4'
project_deps = [lua_dep]

# -------------------------------------------------
# LUA MODULE
# -------------------------------------------------

luasql_sqlite3_link_args = []

if system == 'windows' and cc_id in ['msvc', 'clang', 'clang-cl']
  luasql_sqlite3_link_args += '-export:luaopen_luasql_sqlite3'
endif

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
  link_args: luasql_sqlite3_link_args,
  dependencies: project_deps,
  name_prefix: '',
  name_suffix: module_suffix,
  install: true,
  install_dir: get_option('libdir') / 'lua' / lua_ver / 'luasql'
)

lua_luasql_sqlite3 = static_library(
  'lua.luasql.sqlite3',
  ['luasql/src/luasql.c', 'luasql/src/ls_sqlite3.c'],
  link_args: luasql_sqlite3_link_args,
  dependencies: project_deps,
  pic: true,
  install: true,
  install_dir: get_option('libdir') / 'lua' / lua_ver + '-static'
)

# -------------------------------------------------
# EXTRA DATA
# -------------------------------------------------

data_dir = get_option('libdir') / 'luarocks/rocks-' + lua_ver / 'luasql-sqlite3/2.6.0-1'
install_data('luarocks/rock_manifest', install_dir: data_dir)

install_data(
  'luasql/rockspec/luasql-sqlite3-2.6.0-1.rockspec',
  install_dir: data_dir
)

install_subdir(
  'luasql/doc',
  install_dir: data_dir
)

# -------------------------------------------------
# PKG CONFIG
# -------------------------------------------------

import('pkgconfig').generate(
  description: 'Database connectivity for Lua (SQLite3 driver)',
  install_dir: get_option('libdir') / 'lua' / lua_ver + '-static/pkgconfig',
  filebase: meson.project_name(),
  libraries: lua_luasql_sqlite3,
  name: meson.project_name(),
  url: 'https://github.com/lunarmodules/luasql',
)
