project(
  'lanes',
  'c',
  version: '3.16.0',
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

lanes_sources = [
  'src/cancel.c',
  'src/compat.c',
  'src/deep.c',
  'src/keeper.c',
  'src/lanes.c',
  'src/linda.c',
  'src/tools.c',
  'src/state.c',
  'src/threading.c',
  'src/universe.c'
]
lanes_include = include_directories('src')
project_deps += dependency('threads', required: false)

shared_module(
  'core',
  lanes_sources,
  include_directories: lanes_include,
  dependencies: project_deps,
  name_prefix: '',
  name_suffix: module_suffix,
  install: true,
  install_dir: get_option('libdir') / 'lua' / lua_ver / 'lanes'
)

lua_lanes = static_library(
  'lua.lanes.core',
  lanes_sources,
  include_directories: lanes_include,
  dependencies: project_deps,
  pic: true,
  install: true,
  install_dir: get_option('libdir') / 'lua' / lua_ver + '-static'
)

# -------------------------------------------------
# LUA SCRIPTS
# -------------------------------------------------

install_data(
  'src/lanes.lua',
  install_dir: get_option('datadir') / 'lua' / lua_ver
)

# -------------------------------------------------
# EXTRA DATA
# -------------------------------------------------

data_dir = get_option('libdir') / 'luarocks/rocks-' + lua_ver / '3.16.0-0'
install_data('luarocks/rock_manifest', install_dir: data_dir)

install_data(
  'lanes-3.16.0-0.rockspec',
  install_dir: data_dir
)

install_subdir(
  'docs',
  install_dir: data_dir
)

# -------------------------------------------------
# PKG CONFIG
# -------------------------------------------------

import('pkgconfig').generate(
  description: 'Multithreading support for Lua',
  install_dir: get_option('libdir') / 'lua' / lua_ver + '-static/pkgconfig',
  filebase: meson.project_name(),
  libraries: lua_lanes,
  name: meson.project_name(),
  url: 'https://github.com/LuaLanes/lanes',
)
