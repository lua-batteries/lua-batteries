project(
  'luautf8',
  'c',
  version: '0.1.5',
  license: 'MIT',
  meson_version: '>=1.0.0'
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

luautf8_link_args = []

if system == 'windows' and cc_id in ['msvc', 'clang', 'clang-cl']
  luautf8_link_args += '-export:luaopen_utf8'
endif

shared_module(
  'lua-utf8',
  'luautf8/lutf8lib.c',
  link_args: luautf8_link_args,
  dependencies: project_deps,
  name_prefix: '',
  name_suffix: module_suffix,
  install: true,
  install_dir: get_option('libdir') / 'lua' / lua_ver
)

lua_lua_utf8 = static_library(
  'lua.lua-utf8',
  'luautf8/lutf8lib.c',
  link_args: luautf8_link_args,
  dependencies: project_deps,
  pic: true,
  install: true,
  install_dir: get_option('libdir') / 'lua' / lua_ver + '-static'
)

# -------------------------------------------------
# EXTRA DATA
# -------------------------------------------------

data_dir = get_option('libdir') / 'luarocks/rocks-' + lua_ver / 'luautf8/0.1.5-2'
install_data('luarocks/rock_manifest', install_dir: data_dir)

install_data(
  'luautf8/rockspecs/luautf8-0.1.5-2.rockspec',
  install_dir: data_dir
)

# -------------------------------------------------
# PKG CONFIG
# -------------------------------------------------

import('pkgconfig').generate(
  description: 'A UTF-8 support module for Lua',
  install_dir: get_option('libdir') / 'lua' / lua_ver + '-static/pkgconfig',
  filebase: meson.project_name(),
  libraries: lua_lua_utf8,
  name: meson.project_name(),
  url: 'https://github.com/starwing/luautf8',
)
