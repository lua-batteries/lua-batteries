project(
  'lui',
  'c',
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

lui_include = [
  include_directories('lui/deps/auxiliar'),
  include_directories('lui/deps/compat'),
  include_directories('lui/deps/compat/c-api'),
]
lui_defines = []
lui_link_args = []

if system == 'windows' and cc_id in ['msvc', 'clang', 'clang-cl']
  luautf8_link_args += '-export:luaopen_lui'
endif

project_deps += dependency('threads', required: false)
project_deps += subproject('libui').get_variable('libui_dep')

shared_module(
  'lui',
  ['lui/src/lui.c', 'lui/deps/auxiliar/auxiliar.c'],
  c_args: lui_defines,
  link_args: lui_link_args,
  include_directories: lui_include,
  dependencies: project_deps,
  name_prefix: '',
  name_suffix: module_suffix,
  install: true,
  install_dir: get_option('libdir') / 'lua' / lua_ver
)

static_library(
  'lui',
  ['lui/src/lui.c', 'lui/deps/auxiliar/auxiliar.c'],
  c_args: lui_defines,
  link_args: lui_link_args,
  include_directories: lui_include,
  dependencies: project_deps,
  pic: true,
  install: true,
  install_dir: get_option('libdir') / 'lua' / lua_ver + '-static'
)

# -------------------------------------------------
# EXTRA DATA
# -------------------------------------------------

data_dir = get_option('libdir') / 'luarocks/rocks-' + lua_ver / 'lui/scm-0'
install_data('luarocks/rock_manifest', install_dir: data_dir)

install_data(
  'luarocks/lui-scm-0.rockspec',
  install_dir: data_dir
)

install_subdir(
  'lui/examples',
  install_dir: data_dir
)
