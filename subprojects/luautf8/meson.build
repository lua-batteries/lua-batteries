project(
  'luautf8',
  'c',
  version: '0.1.4',
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

luautf8_link_args = []

if system == 'windows' and cc_id in ['msvc', 'clang', 'clang-cl']
  import('fs').copyfile('exports.def', 'exports.def')
  luautf8_link_args += '-def:subprojects/luautf8/exports.def'
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

static_library(
  'lua-utf8.core',
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

data_dir = get_option('libdir') / 'luarocks/rocks-' + lua_ver / 'luautf8/0.1.4-1'

install_data(
  'luautf8/rockspecs/luautf8-0.1.4-1.rockspec',
  install_dir: data_dir
)
