project(
  'lua-protobuf',
  'c',
  version: '0.4.0',
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

lua_protobuf_link_args = []

if system == 'windows' and cc_id in ['msvc', 'clang', 'clang-cl']
  lua_protobuf_link_args += [
    '-export:luaopen_pb_io',
    '-export:luaopen_pb_conv',
    '-export:luaopen_pb_buffer',
    '-export:luaopen_pb_slice',
    '-export:luaopen_pb',
    '-export:luaopen_pb_unsafe',
  ]
endif

shared_module(
  'pb',
  'lua-protobuf/pb.c',
  link_args: lua_protobuf_link_args,
  dependencies: project_deps,
  name_prefix: '',
  name_suffix: module_suffix,
  install: true,
  install_dir: get_option('libdir') / 'lua' / lua_ver
)

lua_pb = static_library(
  'lua.pb',
  'lua-protobuf/pb.c',
  link_args: lua_protobuf_link_args,
  dependencies: project_deps,
  pic: true,
  install: true,
  install_dir: get_option('libdir') / 'lua' / lua_ver + '-static'
)

# -------------------------------------------------
# LUA SCRIPTS
# -------------------------------------------------

install_data(
  'lua-protobuf/protoc.lua',
  install_dir: get_option('datadir') / 'lua' / lua_ver
)

# -------------------------------------------------
# EXTRA DATA
# -------------------------------------------------

data_dir = get_option('libdir') / 'luarocks/rocks-' + lua_ver / 'lua-protobuf/0.4.0-1'
install_data('luarocks/rock_manifest', install_dir: data_dir)

install_data(
  'lua-protobuf/rockspecs/lua-protobuf-0.4.0-1.rockspec',
  install_dir: data_dir
)

install_data(
  ['lua-protobuf/README.md', 'lua-protobuf/README.zh.md'],
  install_dir: data_dir / 'docs'
)

# -------------------------------------------------
# PKG CONFIG
# -------------------------------------------------

import('pkgconfig').generate(
  description: 'protobuf data support for Lua',
  install_dir: get_option('libdir') / 'lua' / lua_ver + '-static/pkgconfig',
  filebase: meson.project_name(),
  libraries: lua_pb,
  name: meson.project_name(),
  url: 'https://github.com/starwing/lua-protobuf',
)
