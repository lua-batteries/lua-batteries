project(
  'luv',
  'c',
  version: '1.44.2',
  license: 'Apache-2.0',
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

luv_link_args = []

if system == 'windows' and cc_id in ['msvc', 'clang', 'clang-cl']
  luv_link_args += '-export:luaopen_luv'
endif

libuv_dep = dependency('uv', required: false)

if get_option('standalone') or not libuv_dep.found()
  libuv = subproject(
    'libuv',
    default_options: ['default_library=static', 'build_tests=false', 'build_benchmarks=false']
  )
  project_deps += libuv.get_variable('libuv_dep')
else
  project_deps += uv_dep
endif

shared_module(
  'luv',
  'luv/src/luv.c',
  link_args: luv_link_args,
  include_directories: include_directories('luv/deps/lua-compat-5.3/c-api'),
  dependencies: project_deps,
  name_prefix: '',
  name_suffix: module_suffix,
  install: true,
  install_dir: get_option('libdir') / 'lua' / lua_ver
)

lua_luv = static_library(
  'lua.luv',
  'luv/src/luv.c',
  link_args: luv_link_args,
  include_directories: include_directories('luv/deps/lua-compat-5.3/c-api'),
  dependencies: project_deps,
  pic: true,
  install: true,
  install_dir: get_option('libdir') / 'lua' / lua_ver + '-static'
)

# -------------------------------------------------
# EXTRA DATA
# -------------------------------------------------

data_dir = get_option('libdir') / 'luarocks/rocks-' + lua_ver / 'luv/1.44.2-1'
install_data('luarocks/rock_manifest', install_dir: data_dir)

install_data(
  'luarocks/luv-1.44.2-1.rockspec',
  install_dir: data_dir
)

install_data(
  'luv/docs.md',
  install_dir: data_dir / 'docs'
)

install_subdir(
  'luv/examples',
  install_dir: data_dir
)

# -------------------------------------------------
# PKG CONFIG
# -------------------------------------------------

import('pkgconfig').generate(
  description: 'Bare libuv bindings for lua',
  install_dir: get_option('libdir') / 'lua' / lua_ver + '-static/pkgconfig',
  filebase: meson.project_name(),
  libraries: lua_luv,
  name: meson.project_name(),
  url: 'https://github.com/luvit/luv',
)
