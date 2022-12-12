project(
  'lua-zip',
  'c',
  version: '0.2',
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

lua_zip_link_args = []

if system == 'windows' and cc_id in ['msvc', 'clang', 'clang-cl']
  lua_zip_link_args += '-export:luaopen_brimworks_zip'
endif

libzip = subproject('libzip', default_options: ['default_library=static'])
project_deps += libzip.get_variable('libzip_dep')

shared_module(
  'zip',
  'lua-zip/lua_zip.c',
  link_args: lua_zip_link_args,
  dependencies: project_deps,
  name_prefix: '',
  name_suffix: module_suffix,
  install: true,
  install_dir: get_option('libdir') / 'lua' / lua_ver / 'brimworks'
)

lua_zip = static_library(
  'lua.brimworks.zip',
  'lua-zip/lua_zip.c',
  link_args: lua_zip_link_args,
  dependencies: project_deps,
  pic: true,
  install: true,
  install_dir: get_option('libdir') / 'lua' / lua_ver + '-static'
)

# -------------------------------------------------
# EXTRA DATA
# -------------------------------------------------

data_dir = get_option('libdir') / 'luarocks/rocks-' + lua_ver / 'lua-zip/0.2-0'
install_data('luarocks/rock_manifest', install_dir: data_dir)

install_data(
  'lua-zip/rockspecs/lua-zip-0.2-0.rockspec',
  install_dir: data_dir
)

install_data(
  'lua-zip/README.txt',
  install_dir: data_dir / 'docs'
)

# -------------------------------------------------
# PKG CONFIG
# -------------------------------------------------

import('pkgconfig').generate(
  description: 'Lua binding to libzip',
  install_dir: get_option('libdir') / 'lua' / lua_ver + '-static/pkgconfig',
  filebase: meson.project_name(),
  libraries: lua_zip,
  name: meson.project_name(),
  url: 'https://github.com/brimworks/lua-zip',
)
