project(
  'luafilesystem',
  'c',
  version: '1.8.0',
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

luafilesystem_link_args = []

if system == 'windows' and cc_id in ['msvc', 'clang', 'clang-cl']
  luafilesystem_link_args += '-export:luaopen_lfs'
endif

shared_module(
  'lfs',
  'src/lfs.c',
  link_args: luafilesystem_link_args,
  dependencies: project_deps,
  name_prefix: '',
  name_suffix: module_suffix,
  install: true,
  install_dir: get_option('libdir') / 'lua' / lua_ver
)

lua_lfs = static_library(
  'lua.lfs',
  'src/lfs.c',
  link_args: luafilesystem_link_args,
  dependencies: project_deps,
  pic: true,
  install: true,
  install_dir: get_option('libdir') / 'lua' / lua_ver + '-static'
)

# -------------------------------------------------
# EXTRA DATA
# -------------------------------------------------

data_dir = get_option('libdir') / 'luarocks/rocks-' + lua_ver / 'luafilesystem/1.8.0-1'
install_data('luarocks/rock_manifest', install_dir: data_dir)

install_data(
  'luarocks/luafilesystem-1.8.0-1.rockspec',
  install_dir: data_dir
)

install_subdir(
  'doc',
  install_dir: data_dir
)

# -------------------------------------------------
# PKG CONFIG
# -------------------------------------------------

import('pkgconfig').generate(
  description: 'File System Library for the Lua Programming Language',
  install_dir: get_option('libdir') / 'lua' / lua_ver + '-static/pkgconfig',
  filebase: meson.project_name(),
  libraries: lua_lfs,
  name: meson.project_name(),
  url: 'https://github.com/lunarmodules/luafilesystem',
)
