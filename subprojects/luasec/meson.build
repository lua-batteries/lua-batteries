project(
  'luasec',
  'c',
  version: '1.2.0',
  license: 'MIT',
  meson_version: '>=1.0.0'
)

# -------------------------------------------------
# BASE SETUP
# -------------------------------------------------

cc = meson.get_compiler('c')
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

luasec_sources = [
  'luasec/src/options.c',
  'luasec/src/config.c',
  'luasec/src/ec.c', 
  'luasec/src/x509.c',
  'luasec/src/context.c',
  'luasec/src/ssl.c', 
  'luasec/src/luasocket/buffer.c',
  'luasec/src/luasocket/io.c',
  'luasec/src/luasocket/timeout.c'
]
luasec_include = [
  include_directories('luasec/src'),
  include_directories('luasec/src/luasocket')
]
luasec_defines = []

if system == 'windows'
  luasec_defines += [
    '-DWIN32', '-DNDEBUG', '-D_WINDOWS', '-D_USRDLL', '-DLSEC_EXPORTS', '-DBUFFER_DEBUG',
    '-DLSEC_API=__declspec(dllexport)', '-DWITH_LUASOCKET', '-DLUASOCKET_DEBUG', '-DLUASEC_INET_NTOP', 
    '-DWINVER=0x0501', '-D_WIN32_WINNT=0x0501', '-DNTDDI_VERSION=0x05010300'
  ]
  luasec_sources += 'luasec/src/luasocket/wsocket.c'
  project_deps += cc.find_library('ws2_32')
else
  luasec_defines += ['-DWITH_LUASOCKET', '-DLUASOCKET_DEBUG']
  luasec_sources += 'luasec/src/luasocket/usocket.c'
endif

openssl_dep = dependency('openssl', required: false)

if get_option('standalone') or not openssl_dep.found()
  openssl = subproject('openssl', default_options: ['default_library=static'])
  project_deps += openssl.get_variable('openssl_dep')
else
  project_deps += openssl_dep
endif

shared_module(
  'ssl',
  luasec_sources,
  c_args: luasec_defines,
  include_directories: luasec_include,
  dependencies: project_deps,
  name_prefix: '',
  name_suffix: module_suffix,
  install: true,
  install_dir: get_option('libdir') / 'lua' / lua_ver
)

lua_ssl = static_library(
  'lua.ssl',
  luasec_sources,
  c_args: luasec_defines,
  include_directories: luasec_include,
  dependencies: project_deps,
  pic: true,
  install: true,
  install_dir: get_option('libdir') / 'lua' / lua_ver + '-static'
)

# -------------------------------------------------
# LUA SCRIPTS
# -------------------------------------------------

install_data(
  'luasec/src/ssl.lua',
  install_dir: get_option('datadir') / 'lua' / lua_ver
)

install_data(
  'luasec/src/https.lua',
  install_dir: get_option('datadir') / 'lua' / lua_ver / 'ssl'
)

# -------------------------------------------------
# EXTRA DATA
# -------------------------------------------------

data_dir = get_option('libdir') / 'luarocks/rocks-' + lua_ver / 'luasec/1.2.0-1'
install_data('luarocks/rock_manifest', install_dir: data_dir)

install_data(
  'luasec/luasec-1.2.0-1.rockspec',
  install_dir: data_dir
)

install_subdir(
  'luasec/samples',
  install_dir: data_dir
)

# -------------------------------------------------
# PKG CONFIG
# -------------------------------------------------

import('pkgconfig').generate(
  description: 'A binding for OpenSSL library to provide TLS/SSL communication over LuaSocket',
  install_dir: get_option('libdir') / 'lua' / lua_ver + '-static/pkgconfig',
  filebase: meson.project_name(),
  libraries: lua_ssl,
  name: meson.project_name(),
  url: 'https://github.com/brunoos/luasec',
)
