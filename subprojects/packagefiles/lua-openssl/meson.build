project(
  'lua-openssl',
  'c',
  version: '0.8.3',
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

lua_openssl_sources = [
  'deps/auxiliar/auxiliar.c',
  'deps/auxiliar/subsidiar.c',
  'src/asn1.c',
  'src/bio.c',
  'src/callback.c',
  'src/cipher.c',
  'src/cms.c',
  'src/compat.c',
  'src/crl.c',
  'src/csr.c',
  'src/dh.c',
  'src/digest.c',
  'src/dsa.c',
  'src/ec.c',
  'src/engine.c',
  'src/hmac.c',
  'src/lbn.c',
  'src/lhash.c',
  'src/misc.c',
  'src/ocsp.c',
  'src/openssl.c',
  'src/ots.c',
  'src/pkcs7.c',
  'src/pkcs12.c',
  'src/pkey.c',
  'src/rsa.c',
  'src/srp.c',
  'src/ssl.c',
  'src/th-lock.c',
  'src/util.c',
  'src/x509.c',
  'src/xalgor.c',
  'src/xattrs.c',
  'src/xexts.c',
  'src/xname.c',
  'src/xstore.c'
]
lua_openssl_include = [
  include_directories('deps/auxiliar'),
  include_directories('deps/lua-compat/c-api')
]
lua_openssl_defines = []

if system == 'windows'
  lua_openssl_defines += ['-DLUA_BUILD_AS_DLL', '-DLUA_LIB', '-DWIN32_LEAN_AND_MEAN']
  project_deps += cc.find_library('ws2_32')
  project_deps += cc.find_library('kernel32')
  project_deps += cc.find_library('user32')
  project_deps += cc.find_library('gdi32')
  project_deps += cc.find_library('advapi32')
endif

openssl_dep = dependency('openssl', required: false)

if get_option('standalone') or not openssl_dep.found()
  openssl = subproject('openssl', default_options: ['default_library=static'])
  project_deps += openssl.get_variable('openssl_dep')
else
  project_deps += openssl_dep
endif

shared_module(
  'openssl',
  lua_openssl_sources,
  c_args: lua_openssl_defines,
  include_directories: lua_openssl_include,
  dependencies: project_deps,
  name_prefix: '',
  name_suffix: module_suffix,
  install: true,
  install_dir: get_option('libdir') / 'lua' / lua_ver
)

lua_openssl = static_library(
  'lua.openssl',
  lua_openssl_sources,
  c_args: lua_openssl_defines,
  include_directories: lua_openssl_include,
  dependencies: project_deps,
  pic: true,
  install: true,
  install_dir: get_option('libdir') / 'lua' / lua_ver + '-static'
)

# -------------------------------------------------
# EXTRA DATA
# -------------------------------------------------

data_dir = get_option('libdir') / 'luarocks/rocks-' + lua_ver / 'openssl/0.8.3-1'
install_data('luarocks/rock_manifest', install_dir: data_dir)

install_data(
  'luarocks/openssl-0.8.3-1.rockspec',
  install_dir: data_dir
)

install_data(
  'README.md',
  install_dir: data_dir / 'docs'
)

# -------------------------------------------------
# PKG CONFIG
# -------------------------------------------------

import('pkgconfig').generate(
  description: 'Openssl binding for Lua',
  install_dir: get_option('libdir') / 'lua' / lua_ver + '-static/pkgconfig',
  filebase: meson.project_name(),
  libraries: lua_openssl,
  name: meson.project_name(),
  url: 'https://github.com/zhaozg/lua-openssl',
)
