project(
  'cffi-lua',
  'cpp',
  version: '0.2.3',
  license: 'MIT',
  default_options: [
    'b_ndebug=if-release',
    'cpp_std=c++14',
    'warning_level=3',
    'cpp_rtti=false',
    'cpp_eh=none'
  ],
  meson_version: '>=0.64.0'
)

# -------------------------------------------------
# BASE SETUP
# -------------------------------------------------

cxx = meson.get_compiler('cpp')
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

cffi_lua_sources = [
  'cffi-lua/src/util.cc',
  'cffi-lua/src/ffilib.cc',
  'cffi-lua/src/parser.cc',
  'cffi-lua/src/ast.cc',
  'cffi-lua/src/lib.cc',
  'cffi-lua/src/ffi.cc',
  'cffi-lua/src/main.cc'
]
cffi_lua_defines = []

if host_machine.endian() == 'big'
  cffi_lua_defines += '-DFFI_BIG_ENDIAN'
else
  cffi_lua_defines += '-DFFI_LITTLE_ENDIAN'
endif

if get_option('buildtype') != 'plain'
  if cxx.has_argument('-Wshadow')
    cffi_lua_defines += '-Wshadow'
  endif
  if cxx.has_argument('-Wold-style-cast')
    cffi_lua_defines += '-Wold-style-cast'
  endif
endif

ffi_dep = dependency('ffi', required: false)
# TODO: If libffi found on windows and it is shared libraray then add defines
# cffi_lua_defines += '-DHAVE_LIBFFI_DLLIMPORT'

if get_option('standalone') or not ffi_dep.found()
  libffi = subproject('libffi', default_options: ['default_library=static', 'tests=false'])
  project_deps += libffi.get_variable('ffi_dep')
else
  project_deps += ffi_dep
endif

if system != 'windows'
  project_deps += cxx.find_library('dl', required: false)
endif

shared_module(
  'cffi',
  cffi_lua_sources,
  cpp_args: cffi_lua_defines + ['-DCFFI_LUA_DLL'],
  include_directories: include_directories('cffi-lua/src'),
  dependencies: project_deps,
  name_prefix: '',
  name_suffix: module_suffix,
  install: true,
  install_dir: get_option('libdir') / 'lua' / lua_ver
)

lua_cffi = static_library(
  'lua.cffi',
  cffi_lua_sources,
  cpp_args: cffi_lua_defines,
  include_directories: include_directories('cffi-lua/src'),
  dependencies: project_deps,
  pic: true,
  install: true,
  install_dir: get_option('libdir') / 'lua' / lua_ver + '-static'
)

# -------------------------------------------------
# EXTRA DATA
# -------------------------------------------------

data_dir = get_option('libdir') / 'luarocks/rocks-' + lua_ver / 'cffi-lua/0.2.3-1'
install_data('luarocks/rock_manifest', install_dir: data_dir)

install_data(
  'cffi-lua/cffi-lua-0.2.3-1.rockspec',
  install_dir: data_dir
)

install_subdir(
  'cffi-lua/docs',
  install_dir: data_dir
)

# -------------------------------------------------
# PKG CONFIG
# -------------------------------------------------

import('pkgconfig').generate(
  description: 'A portable C FFI for Lua 5.1+',
  install_dir: get_option('libdir') / 'lua' / lua_ver + '-static/pkgconfig',
  filebase: meson.project_name(),
  libraries: lua_cffi,
  name: meson.project_name(),
  url: 'https://github.com/q66/cffi-lua',
)
