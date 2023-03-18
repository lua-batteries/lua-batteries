project(
  'toml',
  'cpp',
  version: '0.3.0',
  license: 'MIT',
  default_options: ['cpp_std=c++17'],
  meson_version: '>=1.0.0'
)

# -------------------------------------------------
# BASE SETUP
# -------------------------------------------------

cxx = meson.get_compiler('cpp')
cxx_id = cxx.get_id()
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

toml_lua_sources = [
  'src/toml.cpp',
  'src/decoding/decoding.cpp',
  'src/encoding/encoding.cpp',
  'src/DataTypes/DateAndTime/dateAndTime.cpp',
  'src/DataTypes/TOMLInt/TOMLInt.cpp',
  'src/utilities/utilities.cpp'
]
toml_lua_defines = []
toml_lua_link_args = []

if system == 'windows'
  toml_lua_defines += ['-DMAGIC_ENUM_NO_CHECK_SUPPORT']

  if cxx_id in ['msvc', 'clang', 'clang-cl']
    toml_lua_link_args += '-export:luaopen_toml'
  endif
endif

project_deps += dependency('sol2')
project_deps += dependency('magic_enum')
project_deps += dependency('tomlplusplus')

shared_module(
  'toml',
  toml_lua_sources,
  c_args: toml_lua_defines,
  link_args: toml_lua_link_args,
  include_directories: include_directories('src'),
  dependencies: project_deps,
  name_prefix: '',
  name_suffix: module_suffix,
  install: true,
  install_dir: get_option('libdir') / 'lua' / lua_ver
)

lua_toml = static_library(
  'lua.toml',
  toml_lua_sources,
  c_args: toml_lua_defines,
  link_args: toml_lua_link_args,
  include_directories: include_directories('src'),
  dependencies: project_deps,
  pic: true,
  install: true,
  install_dir: get_option('libdir') / 'lua' / lua_ver + '-static'
)

# -------------------------------------------------
# EXTRA DATA
# -------------------------------------------------

data_dir = get_option('libdir') / 'luarocks/rocks-' + lua_ver / 'toml/0.3.0-0'
install_data('luarocks/rock_manifest', install_dir: data_dir)

install_data(
  'toml-0.3.0-0.rockspec',
  install_dir: data_dir
)

install_data(
  'README.md',
  install_dir: data_dir / 'docs'
)

install_subdir(
  'examples',
  install_dir: data_dir
)

# -------------------------------------------------
# PKG CONFIG
# -------------------------------------------------

import('pkgconfig').generate(
  description: 'TOML v1.0.0 parser and serializer for Lua. Powered by toml++.',
  install_dir: get_option('libdir') / 'lua' / lua_ver + '-static/pkgconfig',
  filebase: meson.project_name(),
  libraries: lua_toml,
  name: meson.project_name(),
  url: 'https://github.com/LebJe/toml.lua',
)
