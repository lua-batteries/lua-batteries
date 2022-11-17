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

# if system == 'windows'
#   project_deps += cc.find_library('User32')
#   project_deps += cc.find_library('psapi')
#   project_deps += cc.find_library('iphlpapi')
#   project_deps += cc.find_library('userenv')
#   project_deps += cc.find_library('ws2_32')
#   project_deps += cc.find_library('advapi32')
# elif system == 'freebsd'
#   project_deps += dependency('threads')
#   project_deps += cc.find_library('kvm')
# else
#   project_deps += dependency('threads')
#   project_deps += cc.find_library('rt')
#   project_deps += cc.find_library('dl')
# endif

luv_link_args = []

if system == 'windows' and cc_id in ['msvc', 'clang', 'clang-cl']
  import('fs').copyfile('exports.def', 'exports.def')
  luv_link_args += '-def:subprojects/luv/exports.def'
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

static_library(
  'luv',
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

install_data(
  'luv/rockspecs/luv-scm-0.rockspec',
  install_dir: data_dir
)

install_subdir(
  'luv/docs.md',
  install_dir: data_dir
)

install_subdir(
  'luv/examples',
  install_dir: data_dir
)
