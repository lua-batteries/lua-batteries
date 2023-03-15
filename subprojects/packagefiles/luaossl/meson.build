project(
  'luaossl',
  'c',
  version: '20220711',
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

# diff_files = luaossl/config.h.diff

luaossl_sources = [
  'luaossl-rel-20220711/src/openssl.c',
  'luaossl-rel-20220711/vendor/compat53/c-api/compat-5.3.c'
]
luaossl_defines = [
  '-D_REENTRANT',
  '-D_THREAD_SAFE',
  '-DCOMPAT53_PREFIX=luaossl'
]

if system == 'windows'
  luaossl_defines += '-DHAVE_SYS_PARAM_H=0'
  luaossl_defines += '-DHAVE_DLFCN_H=0'
  luaossl_defines += '-D_WIN32_WINNT=0x0600'
  project_deps += cc.find_library('ws2_32')
  project_deps += cc.find_library('advapi32')
  project_deps += cc.find_library('kernel32')
elif system in ['linux', 'android']
  project_deps += cc.find_library('dl')
else # unix
  luaossl_defines += '-D_GNU_SOURCE'
  project_deps += dependency('threads')
  project_deps += cc.find_library('m')
endif

openssl_dep = dependency('openssl', required: false)

if get_option('standalone') or not openssl_dep.found()
  openssl = subproject('openssl', default_options: ['default_library=static'])
  project_deps += openssl.get_variable('openssl_dep')
else
  project_deps += openssl_dep
endif

shared_module(
  '_openssl',
  luaossl_sources,
  c_args: luaossl_defines,
  dependencies: project_deps,
  name_prefix: '',
  name_suffix: module_suffix,
  install: true,
  install_dir: get_option('libdir') / 'lua' / lua_ver
)

lua__openssl = static_library(
  'lua._openssl',
  luaossl_sources,
  c_args: luaossl_defines,
  dependencies: project_deps,
  pic: true,
  install: true,
  install_dir: get_option('libdir') / 'lua' / lua_ver + '-static'
)

# -------------------------------------------------
# LUA SCRIPTS
# -------------------------------------------------

install_data(
  'luaossl-rel-20220711/src/openssl.lua',
  install_dir: get_option('datadir') / 'lua' / lua_ver
)

install_data(
  [
    'luaossl-rel-20220711/src/openssl.auxlib.lua',
    'luaossl-rel-20220711/src/openssl.bignum.lua',
    'luaossl-rel-20220711/src/openssl.cipher.lua',
    'luaossl-rel-20220711/src/openssl.des.lua',
    'luaossl-rel-20220711/src/openssl.digest.lua',
    'luaossl-rel-20220711/src/openssl.hmac.lua',
    'luaossl-rel-20220711/src/openssl.kdf.lua',
    'luaossl-rel-20220711/src/openssl.pkcs12.lua',
    'luaossl-rel-20220711/src/openssl.pkey.lua',
    'luaossl-rel-20220711/src/openssl.pubkey.lua',
    'luaossl-rel-20220711/src/openssl.rand.lua',
    'luaossl-rel-20220711/src/openssl.ssl.lua',
    'luaossl-rel-20220711/src/openssl.x509.lua'
  ],
  rename: [
    'auxlib.lua',
    'bignum.lua',
    'cipher.lua',
    'des.lua',
    'digest.lua',
    'hmac.lua',
    'kdf.lua',
    'pkcs12.lua',
    'pkey.lua',
    'pubkey.lua',
    'rand.lua',
    'ssl.lua',
    'x509.lua'
  ],
  install_dir: get_option('datadir') / 'lua' / lua_ver / 'openssl'
)

install_data(
  [
    'luaossl-rel-20220711/src/openssl.ocsp.basic.lua',
    'luaossl-rel-20220711/src/openssl.ocsp.response.lua'
  ],
  rename: [
    'basic.lua',
    'response.lua'
  ],
  install_dir: get_option('datadir') / 'lua' / lua_ver / 'openssl/ocsp'
)

install_data(
  'luaossl-rel-20220711/src/openssl.ssl.context.lua',
  rename: 'context.lua',
  install_dir: get_option('datadir') / 'lua' / lua_ver / 'openssl/ssl'
)

install_data(
  [
    'luaossl-rel-20220711/src/openssl.x509.altname.lua',
    'luaossl-rel-20220711/src/openssl.x509.chain.lua',
    'luaossl-rel-20220711/src/openssl.x509.crl.lua',
    'luaossl-rel-20220711/src/openssl.x509.csr.lua',
    'luaossl-rel-20220711/src/openssl.x509.extension.lua',
    'luaossl-rel-20220711/src/openssl.x509.name.lua',
    'luaossl-rel-20220711/src/openssl.x509.store.lua',
    'luaossl-rel-20220711/src/openssl.x509.verify_param.lua'
  ],
  rename: [
    'altname.lua',
    'chain.lua',
    'crl.lua',
    'csr.lua',
    'extension.lua',
    'name.lua',
    'store.lua',
    'verify_param.lua'
  ],
  install_dir: get_option('datadir') / 'lua' / lua_ver / 'openssl/x509'
)

# -------------------------------------------------
# EXTRA DATA
# -------------------------------------------------

data_dir = get_option('libdir') / 'luarocks/rocks-' + lua_ver / 'luaossl/20220711-0'
install_data('luarocks/rock_manifest', install_dir: data_dir)

install_data(
  'luarocks/luaossl-20220711-0.rockspec',
  install_dir: data_dir
)

install_subdir(
  'luaossl-rel-20220711/doc',
  install_dir: data_dir
)

install_subdir(
  'luaossl-rel-20220711/examples',
  install_dir: data_dir
)

# -------------------------------------------------
# PKG CONFIG
# -------------------------------------------------

import('pkgconfig').generate(
  description: 'Most comprehensive OpenSSL module in the Lua universe.',
  install_dir: get_option('libdir') / 'lua' / lua_ver + '-static/pkgconfig',
  filebase: meson.project_name(),
  libraries: lua__openssl,
  name: meson.project_name(),
  url: 'https://github.com/wahern/luaossl',
)
