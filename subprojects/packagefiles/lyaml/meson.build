project(
  'lyaml',
  'c',
  version: '6.2.8',
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

lyaml_sources = [
  'ext/yaml/yaml.c',
  'ext/yaml/emitter.c',
  'ext/yaml/parser.c',
  'ext/yaml/scanner.c'
]
lyaml_defines = ['-DVERSION="6.2.8"']
lyaml_link_args = []

if system == 'windows' and cc_id in ['msvc', 'clang', 'clang-cl']
  lyaml_link_args += '-export:luaopen_yaml'
endif

libyaml_dep = dependency('yaml', required: false)

if get_option('standalone') or not libyaml_dep.found()
  libyaml = subproject('libyaml', default_options: ['default_library=static'])
  project_deps += libyaml.get_variable('yaml_dep')
  lyaml_defines += '-DYAML_DECLARE_STATIC'
else
  project_deps += libyaml_dep
endif

shared_module(
  'yaml',
  lyaml_sources,
  c_args: lyaml_defines,
  link_args: lyaml_link_args,
  include_directories: include_directories('ext'),
  dependencies: project_deps,
  name_prefix: '',
  name_suffix: module_suffix,
  install: true,
  install_dir: get_option('libdir') / 'lua' / lua_ver
)

lua_yaml = static_library(
  'lua.yaml',
  lyaml_sources,
  c_args: lyaml_defines,
  link_args: lyaml_link_args,
  include_directories: include_directories('ext'),
  dependencies: project_deps,
  pic: true,
  install: true,
  install_dir: get_option('libdir') / 'lua' / lua_ver + '-static'
)

# -------------------------------------------------
# LUA SCRIPTS
# -------------------------------------------------

install_subdir(
  'lib/lyaml',
  install_dir: get_option('datadir') / 'lua' / lua_ver
)

# -------------------------------------------------
# EXTRA DATA
# -------------------------------------------------

data_dir = get_option('libdir') / 'luarocks/rocks-' + lua_ver / 'lyaml/6.2.8-1'
install_data('luarocks/rock_manifest', install_dir: data_dir)

install_data(
  'lyaml-6.2.8-1.rockspec',
  install_dir: data_dir
)

install_subdir(
  'doc',
  install_dir: data_dir
)

# -------------------------------------------------
# PKG CONFIG
# -------------------------------------------------

import('pkgconfig').generate(
  description: 'libYAML binding for Lua',
  install_dir: get_option('libdir') / 'lua' / lua_ver + '-static/pkgconfig',
  filebase: meson.project_name(),
  libraries: lua_yaml,
  name: meson.project_name(),
  url: 'https://github.com/gvvaughan/lyaml',
)
