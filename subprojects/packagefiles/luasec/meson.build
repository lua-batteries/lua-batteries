project(
  'luasec',
  'c',
  version: '1.3.1',
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

lua_dep = get_option('luajit') ? dependency('luajit') : dependency('lua')
lua_ver = get_option('luajit') ? '5.1' : '5.4'
project_deps = [lua_dep]

# -------------------------------------------------
# LUA MODULE
# -------------------------------------------------

luasec_sources = [
  'src/options.c',
  'src/config.c',
  'src/ec.c', 
  'src/x509.c',
  'src/context.c',
  'src/ssl.c', 
  'src/luasocket/buffer.c',
  'src/luasocket/io.c',
  'src/luasocket/timeout.c'
]
luasec_include = [
  include_directories('src'),
  include_directories('src/luasocket')
]
luasec_defines = []

if system == 'windows'
  luasec_defines += [
    '-DWIN32', '-DNDEBUG', '-D_WINDOWS', '-D_USRDLL', '-DLSEC_EXPORTS', '-DBUFFER_DEBUG',
    '-DLSEC_API=__declspec(dllexport)', '-DWITH_LUASOCKET', '-DLUASOCKET_DEBUG', '-DLUASEC_INET_NTOP', 
    '-DWINVER=0x0501', '-D_WIN32_WINNT=0x0501', '-DNTDDI_VERSION=0x05010300'
  ]
  luasec_sources += 'src/luasocket/wsocket.c'
  project_deps += cc.find_library('ws2_32')
else
  luasec_defines += ['-DWITH_LUASOCKET', '-DLUASOCKET_DEBUG']
  luasec_sources += 'src/luasocket/usocket.c'
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
  'src/ssl.lua',
  install_dir: get_option('datadir') / 'lua' / lua_ver
)

install_data(
  'src/https.lua',
  install_dir: get_option('datadir') / 'lua' / lua_ver / 'ssl'
)

# -------------------------------------------------
# EXTRA DATA
# -------------------------------------------------

data_dir = get_option('libdir') / 'luarocks/rocks-' + lua_ver / 'luasec/1.3.1-1'
install_data('luarocks/rock_manifest', install_dir: data_dir)

install_data(
  'luasec-1.3.1-1.rockspec',
  install_dir: data_dir
)

install_subdir(
  'samples',
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
