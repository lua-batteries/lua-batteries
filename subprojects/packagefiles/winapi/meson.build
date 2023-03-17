project(
  'winapi',
  'c',
  version: '1.4.2',
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

winapi_sources = [
  'winapi.c',
  'wutils.c'
]
winapi_defines = ['-DPSAPI_VERSION=1']
winapi_link_args = []

if system == 'windows'
  project_deps += cc.find_library('kernel32')
  project_deps += cc.find_library('user32')
  project_deps += cc.find_library('psapi')
  project_deps += cc.find_library('advapi32')
  project_deps += cc.find_library('shell32')
  project_deps += cc.find_library('Mpr')

  if cc_id in ['msvc', 'clang', 'clang-cl']
    winapi_link_args += '-export:luaopen_winapi'
  # elif cc_id == 'gcc'
  #   project_deps += cc.find_library('psapi')
  #   project_deps += cc.find_library('Mpr')
  endif
endif

shared_module(
  'winapi',
  winapi_sources,
  c_args: winapi_defines,
  link_args: winapi_link_args,
  dependencies: project_deps,
  name_prefix: '',
  name_suffix: module_suffix,
  install: true,
  install_dir: get_option('libdir') / 'lua' / lua_ver
)

lua_winapi = static_library(
  'lua.winapi',
  winapi_sources,
  c_args: winapi_defines,
  link_args: winapi_link_args,
  dependencies: project_deps,
  pic: true,
  install: true,
  install_dir: get_option('libdir') / 'lua' / lua_ver + '-static'
)

# -------------------------------------------------
# EXTRA DATA
# -------------------------------------------------

data_dir = get_option('libdir') / 'luarocks/rocks-' + lua_ver / 'winapi/1.4.2-1'
install_data('luarocks/rock_manifest', install_dir: data_dir)

install_data(
  'luarocks/winapi-1.4.2-1.rockspec',
  install_dir: data_dir
)

install_subdir(
  'examples',
  install_dir: data_dir
)

# -------------------------------------------------
# PKG CONFIG
# -------------------------------------------------

import('pkgconfig').generate(
  description: 'Minimal but useful bindings to Windows API',
  install_dir: get_option('libdir') / 'lua' / lua_ver + '-static/pkgconfig',
  filebase: meson.project_name(),
  libraries: lua_winapi,
  name: meson.project_name(),
  url: 'https://github.com/stevedonovan/winapi',
)
