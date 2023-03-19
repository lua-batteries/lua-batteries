project(
  'compat53_bit32',
  'c',
  version: '0.8+5.3.5',
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
# COMPAT53
# -------------------------------------------------

# -------------------------------------------------
# LUA MODULE
# -------------------------------------------------

compat53_pkg_config_libs = []

shared_module(
  'utf8',
  'lutf8lib.c',
  dependencies: project_deps,
  name_prefix: '',
  name_suffix: module_suffix,
  install: true,
  install_dir: get_option('libdir') / 'lua' / lua_ver / 'compat53'
)

compat53_pkg_config_libs += static_library(
  'lua.compat53.utf8',
  'lutf8lib.c',
  dependencies: project_deps,
  pic: true,
  install: true,
  install_dir: get_option('libdir') / 'lua' / lua_ver + '-static'
)

shared_module(
  'table',
  'ltablib.c',
  dependencies: project_deps,
  name_prefix: '',
  name_suffix: module_suffix,
  install: true,
  install_dir: get_option('libdir') / 'lua' / lua_ver / 'compat53'
)

compat53_pkg_config_libs += static_library(
  'lua.compat53.table',
  'ltablib.c',
  dependencies: project_deps,
  pic: true,
  install: true,
  install_dir: get_option('libdir') / 'lua' / lua_ver + '-static'
)

shared_module(
  'string',
  'lstrlib.c',
  dependencies: project_deps,
  name_prefix: '',
  name_suffix: module_suffix,
  install: true,
  install_dir: get_option('libdir') / 'lua' / lua_ver / 'compat53'
)

compat53_pkg_config_libs += static_library(
  'lua.compat53.string',
  'lstrlib.c',
  dependencies: project_deps,
  pic: true,
  install: true,
  install_dir: get_option('libdir') / 'lua' / lua_ver + '-static'
)

# -------------------------------------------------
# LUA SCRIPTS
# -------------------------------------------------

install_data(
  ['compat53/init.lua', 'compat53/module.lua'],
  install_dir: get_option('datadir') / 'lua' / lua_ver / 'compat53'
)

# -------------------------------------------------
# EXTRA DATA
# -------------------------------------------------

data_dir = get_option('libdir') / 'luarocks/rocks-' + lua_ver / 'compat53/0.8-1'
install_data('luarocks/rock_manifest', install_dir: data_dir)

install_data(
  'rockspecs/compat53-0.8-1.rockspec',
  install_dir: data_dir
)

install_data(
  'README.md',
  install_dir: data_dir
)

# -------------------------------------------------
# PKG CONFIG
# -------------------------------------------------

import('pkgconfig').generate(
  description: 'Compatibility module providing Lua-5.3-style APIs for Lua 5.2 and 5.1',
  install_dir: get_option('libdir') / 'lua' / lua_ver + '-static/pkgconfig',
  filebase: 'compat53',
  libraries: compat53_pkg_config_libs,
  name: 'compat53',
  url: 'https://github.com/lunarmodules/lua-compat-5.3',
)

# -------------------------------------------------
# BIT32
# -------------------------------------------------

# -------------------------------------------------
# LUA MODULE
# -------------------------------------------------

shared_module(
  'bit32',
  'lbitlib.c',
  c_args: ['-DLUA_COMPAT_BITLIB'],
  include_directories: include_directories('c-api'),
  dependencies: project_deps,
  name_prefix: '',
  name_suffix: module_suffix,
  install: true,
  install_dir: get_option('libdir') / 'lua' / lua_ver
)

lua_bit32 = static_library(
  'lua.bit32',
  'lbitlib.c',
  c_args: ['-DLUA_COMPAT_BITLIB'],
  include_directories: include_directories('c-api'),
  dependencies: project_deps,
  pic: true,
  install: true,
  install_dir: get_option('libdir') / 'lua' / lua_ver + '-static'
)

# -------------------------------------------------
# EXTRA DATA
# -------------------------------------------------

data_dir = get_option('libdir') / 'luarocks/rocks-' + lua_ver / 'bit32/5.3.5-1'
install_data('luarocks/rock_manifest', install_dir: data_dir)

install_data(
  'rockspecs/bit32-5.3.5-1.rockspec',
  install_dir: data_dir
)

install_data(
  'README.md',
  install_dir: data_dir
)

# -------------------------------------------------
# PKG CONFIG
# -------------------------------------------------

import('pkgconfig').generate(
  description: 'Lua 5.2 bit manipulation library',
  install_dir: get_option('libdir') / 'lua' / lua_ver + '-static/pkgconfig',
  filebase: 'bit32',
  libraries: lua_bit32,
  name: 'bit32',
  url: 'https://github.com/lunarmodules/lua-compat-5.3',
)
