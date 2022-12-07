project(
  'lanes',
  'c',
  version: '3.16.0',
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

lanes_sources = [
  'lanes/src/cancel.c',
  'lanes/src/compat.c',
  'lanes/src/deep.c',
  'lanes/src/keeper.c',
  'lanes/src/lanes.c',
  'lanes/src/linda.c',
  'lanes/src/tools.c',
  'lanes/src/state.c',
  'lanes/src/threading.c',
  'lanes/src/universe.c'
]
lanes_include = include_directories('lanes/src')
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

lanes = static_library(
  'lanes.core',
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
  'lanes/src/lanes.lua',
  install_dir: get_option('datadir') / 'lua' / lua_ver
)

# -------------------------------------------------
# EXTRA DATA
# -------------------------------------------------

data_dir = get_option('libdir') / 'luarocks/rocks-' + lua_ver / 'lanes/3.16.0-0'
install_data('luarocks/rock_manifest', install_dir: data_dir)

install_data(
  'lanes/lanes-3.16.0-0.rockspec',
  install_dir: data_dir
)

install_subdir(
  'lanes/docs',
  install_dir: data_dir
)

# -------------------------------------------------
# PKG CONFIG
# -------------------------------------------------

import('pkgconfig').generate(
  description: 'Multithreading support for Lua',
  install_dir: get_option('libdir') / 'lua' / lua_ver + '-static/pkgconfig',
  filebase: meson.project_name(),
  libraries: lanes,
  name: meson.project_name(),
  url: 'https://github.com/LuaLanes/lanes',
)
