project(
  'lpeg',
  'c',
  version: '1.0.2',
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

lua_dep = get_option('luajit') ? dependency('luajit') : dependency('lua')
lua_ver = get_option('luajit') ? '5.1' : '5.4'
project_deps = [lua_dep]

# -------------------------------------------------
# LUA MODULE
# -------------------------------------------------

lpeg_sources = ['lpcap.c', 'lpcode.c', 'lpprint.c', 'lptree.c', 'lpvm.c']
lpeg_link_args = []

if system == 'windows' and cc_id in ['msvc', 'clang', 'clang-cl']
  lpeg_link_args += '-export:luaopen_lpeg'
endif

shared_module(
  'lpeg',
  lpeg_sources,
  link_args: lpeg_link_args,
  dependencies: project_deps,
  name_prefix: '',
  name_suffix: module_suffix,
  install: true,
  install_dir: get_option('libdir') / 'lua' / lua_ver
)

lua_lpeg = static_library(
  'lua.lpeg',
  lpeg_sources,
  link_args: lpeg_link_args,
  dependencies: project_deps,
  pic: true,
  install: true,
  install_dir: get_option('libdir') / 'lua' / lua_ver + '-static'
)

# -------------------------------------------------
# LUA SCRIPTS
# -------------------------------------------------

install_data(
  're.lua',
  install_dir: get_option('datadir') / 'lua' / lua_ver
)

# -------------------------------------------------
# EXTRA DATA
# -------------------------------------------------

data_dir = get_option('libdir') / 'luarocks/rocks-' + lua_ver / 'lpeg/1.0.2-1'
install_data('luarocks/rock_manifest', install_dir: data_dir)

install_data(
  'luarocks/lpeg-1.0.2-1.rockspec',
  install_dir: data_dir
)

install_data(
  ['lpeg.html', 're.html'],
  install_dir: data_dir / 'docs'
)

# -------------------------------------------------
# PKG CONFIG
# -------------------------------------------------

import('pkgconfig').generate(
  description: 'Parsing Expression Grammars For Lua',
  install_dir: get_option('libdir') / 'lua' / lua_ver + '-static/pkgconfig',
  filebase: meson.project_name(),
  libraries: lua_lpeg,
  name: meson.project_name(),
  url: 'http://www.inf.puc-rio.br/~roberto/lpeg.html',
)
