project(
  'lua-zlib',
  'c',
  version: '1.2',
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

lua_zlib_link_args = []

if system == 'windows' and cc_id in ['msvc', 'clang', 'clang-cl']
  lua_zlib_link_args += '-export:luaopen_zlib'
endif

zlib_dep = dependency('z', required: false)

if get_option('standalone') or not zlib_dep.found()
  zlib = subproject('zlib', default_options: ['default_library=static'])
  project_deps += zlib.get_variable('zlib_dep')
else
  project_deps += zlib_dep
endif

shared_module(
  'zlib',
  'lua-zlib/lua_zlib.c',
  c_args: ['-DLZLIB_COMPAT'],
  link_args: lua_zlib_link_args,
  dependencies: project_deps,
  name_prefix: '',
  name_suffix: module_suffix,
  install: true,
  install_dir: get_option('libdir') / 'lua' / lua_ver
)

lua_zlib = static_library(
  'lua.zlib',
  'lua-zlib/lua_zlib.c',
  c_args: ['-DLZLIB_COMPAT'],
  link_args: lua_zlib_link_args,
  dependencies: project_deps,
  pic: true,
  install: true,
  install_dir: get_option('libdir') / 'lua' / lua_ver + '-static'
)

# -------------------------------------------------
# EXTRA DATA
# -------------------------------------------------

data_dir = get_option('libdir') / 'luarocks/rocks-' + lua_ver / 'lua-zlib/1.2-2'
install_data('luarocks/rock_manifest', install_dir: data_dir)

install_data(
  'lua-zlib/rockspecs/lua-zlib-1.2-2.rockspec',
  install_dir: data_dir
)

install_data(
  'lua-zlib/README',
  install_dir: data_dir / 'docs'
)

# -------------------------------------------------
# PKG CONFIG
# -------------------------------------------------

import('pkgconfig').generate(
  description: 'Simple streaming interface to zlib for Lua',
  install_dir: get_option('libdir') / 'lua' / lua_ver + '-static/pkgconfig',
  filebase: meson.project_name(),
  libraries: lua_zlib,
  name: meson.project_name(),
  url: 'https://github.com/brimworks/lua-zlib',
)
