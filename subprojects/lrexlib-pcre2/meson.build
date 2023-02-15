project(
  'lrexlib-pcre2',
  'c',
  version: '2.9.1',
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

lua_dep = get_option('luajit') ? subproject('luajit').get_variable('luajit_dep') : subproject('lua').get_variable('lua_dep')
lua_ver = get_option('luajit') ? '5.1' : '5.4'
project_deps = [lua_dep]

# -------------------------------------------------
# LUA MODULE
# -------------------------------------------------

lrexlib_pcre2_sources = [
  'lrexlib/src/common.c',
  'lrexlib/src/pcre2/lpcre2.c',
  'lrexlib/src/pcre2/lpcre2_f.c',
]
lrexlib_pcre2_defines = ['-DVERSION="2.9.1"', '-DPCRE2_CODE_UNIT_WIDTH=8']
lrexlib_pcre2_link_args = []

if system == 'windows' and cc_id in ['msvc', 'clang', 'clang-cl']
  lrexlib_pcre2_link_args += '-export:luaopen_rex_pcre2'
endif

pcre2_8_dep = dependency('pcre2_8', required: false)

if get_option('standalone') or not pcre2_8_dep.found()
  pcre2 = subproject('pcre2', default_options: ['default_library=static'])
  project_deps += pcre2.get_variable('libpcre2_8')
else
  project_deps += pcre2_8_dep
endif

shared_module(
  'rex_pcre2',
  lrexlib_pcre2_sources,
  c_args: lrexlib_pcre2_defines,
  link_args: lrexlib_pcre2_link_args,
  dependencies: project_deps,
  name_prefix: '',
  name_suffix: module_suffix,
  install: true,
  install_dir: get_option('libdir') / 'lua' / lua_ver
)

lua_rex_pcre2 = static_library(
  'lua.rex_pcre2',
  lrexlib_pcre2_sources,
  c_args: lrexlib_pcre2_defines,
  link_args: lrexlib_pcre2_link_args,
  dependencies: project_deps,
  pic: true,
  install: true,
  install_dir: get_option('libdir') / 'lua' / lua_ver + '-static'
)

# -------------------------------------------------
# EXTRA DATA
# -------------------------------------------------

data_dir = get_option('libdir') / 'luarocks/rocks-' + lua_ver / 'lrexlib-pcre2/2.9.1-1'
install_data('luarocks/rock_manifest', install_dir: data_dir)

install_data(
  'luarocks/lrexlib-pcre2-2.9.1-1.rockspec',
  install_dir: data_dir
)

install_subdir(
  'lrexlib/doc',
  install_dir: data_dir
)

# -------------------------------------------------
# PKG CONFIG
# -------------------------------------------------

import('pkgconfig').generate(
  description: 'Regular expression library binding (PCRE2 flavour)',
  install_dir: get_option('libdir') / 'lua' / lua_ver + '-static/pkgconfig',
  filebase: meson.project_name(),
  libraries: lua_rex_pcre2,
  name: meson.project_name(),
  url: 'https://github.com/rrthomas/lrexlib',
)
