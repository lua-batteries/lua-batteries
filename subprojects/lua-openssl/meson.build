project(
  'lua-openssl',
  'c',
  version: '0.8.2',
  license: 'MIT',
  meson_version: '>=0.64.0'
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

lua_openssl_sources = [
  'lua-openssl/deps/auxiliar/auxiliar.c',
  'lua-openssl/deps/auxiliar/subsidiar.c',
  'lua-openssl/src/asn1.c',
  'lua-openssl/src/bio.c',
  'lua-openssl/src/callback.c',
  'lua-openssl/src/cipher.c',
  'lua-openssl/src/cms.c',
  'lua-openssl/src/compat.c',
  'lua-openssl/src/crl.c',
  'lua-openssl/src/csr.c',
  'lua-openssl/src/dh.c',
  'lua-openssl/src/digest.c',
  'lua-openssl/src/dsa.c',
  'lua-openssl/src/ec.c',
  'lua-openssl/src/engine.c',
  'lua-openssl/src/hmac.c',
  'lua-openssl/src/lbn.c',
  'lua-openssl/src/lhash.c',
  'lua-openssl/src/misc.c',
  'lua-openssl/src/ocsp.c',
  'lua-openssl/src/openssl.c',
  'lua-openssl/src/ots.c',
  'lua-openssl/src/pkcs7.c',
  'lua-openssl/src/pkcs12.c',
  'lua-openssl/src/pkey.c',
  'lua-openssl/src/rsa.c',
  'lua-openssl/src/srp.c',
  'lua-openssl/src/ssl.c',
  'lua-openssl/src/th-lock.c',
  'lua-openssl/src/util.c',
  'lua-openssl/src/x509.c',
  'lua-openssl/src/xalgor.c',
  'lua-openssl/src/xattrs.c',
  'lua-openssl/src/xexts.c',
  'lua-openssl/src/xname.c',
  'lua-openssl/src/xstore.c'
]
lua_openssl_include = [
  include_directories('lua-openssl/deps/auxiliar'),
  include_directories('lua-openssl/deps/lua-compat/c-api')
]
lua_openssl_defines = []

if system == 'windows'
  lua_openssl_defines += ['-DLUA_BUILD_AS_DLL', '-DLUA_LIB', '-DWIN32_LEAN_AND_MEAN']
  project_deps += cc.find_library('ws2_32')
  project_deps += cc.find_library('kernel32')
  project_deps += cc.find_library('user32')
  project_deps += cc.find_library('gdi32')
  project_deps += cc.find_library('advapi32')
else
  lua_openssl_defines += ['-DPTHREADS']
endif

ssl_dep = dependency('ssl', required: false)
crypto_dep = dependency('crypto', required: false)

if get_option('standalone') or not ssl_dep.found() or not crypto_dep.found()
  openssl = subproject('openssl', default_options: ['default_library=static'])
  project_deps += openssl.get_variable('libssl_dep')
  project_deps += openssl.get_variable('libcrypto_dep')
else
  project_deps += ssl_dep
  project_deps += crypto_dep
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

static_library(
  'openssl.core',
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

data_dir = get_option('libdir') / 'luarocks/rocks-' + lua_ver / 'lua-openssl/0.8.2-1'

install_data(
  'lua-openssl/openssl-scm-0.rockspec',
  install_dir: data_dir
)
