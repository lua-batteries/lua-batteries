project(
  'cffi-lua',
  'cpp',
  version: '0.2.2',
  default_options: [
    'b_ndebug=if-release',
    'cpp_std=c++14',
    'warning_level=3',
    'cpp_rtti=false',
    'cpp_eh=none'
  ],
  meson_version: '>=0.50'
)

# -------------------------------------------------
# BASE SETUP
# -------------------------------------------------

cxx = meson.get_compiler('cpp')
cxx_id = cc.get_id()
system = host_machine.system()
module_suffix = 'so'

if system == 'windows'
  module_suffix = 'dll'
endif

lua_dep = subproject('lua').get_variable('lua_dep')
project_deps = [lua_dep]

# -------------------------------------------------
# LUA MODULE
# -------------------------------------------------

cffi_defines = []
# cffi_defines += '-DHAVE_LIBFFI_DLLIMPORT'

if host_machine.endian() == 'big'
  cffi_defines += '-DFFI_BIG_ENDIAN'
else
  cffi_defines += '-DFFI_LITTLE_ENDIAN'
endif

if get_option('buildtype') != 'plain'
  if cxx.has_argument('-Wshadow')
    cffi_defines += '-Wshadow'
  endif
  if cxx.has_argument('-Wold-style-cast')
    cffi_defines += '-Wold-style-cast'
  endif
endif

ffi_dep = dependency('ffi', required: false)

if not ffi_dep.found()
  libffi = subproject('libffi', default_options: ['default_library=static'])
  project_deps += libffi.get_variable('ffi_dep')
else
  project_deps += ffi_dep
endif

if system != 'windows'
  project_deps += cxx.find_library('dl', required: false)
endif

shared_module(
  'cffi',
  [
    'cffi-lua/src/util.cc',
    'cffi-lua/src/ffilib.cc',
    'cffi-lua/src/parser.cc',
    'cffi-lua/src/ast.cc',
    'cffi-lua/src/lib.cc',
    'cffi-lua/src/ffi.cc',
    'cffi-lua/src/main.cc'
  ],
  cpp_args: cffi_defines + ['-DCFFI_LUA_DLL'],
  include_directories: include_directories('cffi-lua/src'),
  dependencies: project_deps,
  name_prefix: '',
  name_suffix: module_suffix,
  install: true,
  install_dir: get_option('libdir') / 'lua/5.4'
)

# -------------------------------------------------
# EXTRA DATA
# -------------------------------------------------

data_dir = get_option('libdir') / 'luarocks/rocks-5.4/cffi/0.2.2-1'

install_data(
  'cffi-lua/cffi-lua-0.2.2-1.rockspec',
  install_dir: data_dir
)

install_subdir(
  'cffi-lua/docs',
  install_dir: data_dir / 'docs'
)
