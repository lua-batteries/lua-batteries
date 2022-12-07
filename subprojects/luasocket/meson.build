project(
  'luasocket',
  'c',
  version: '3.1.0',
  license: 'MIT',
  meson_version: '>=0.64.0'
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

pkg_config_libs = []
luasocket_socket_sources = [
  'luasocket/src/luasocket.c',
  'luasocket/src/timeout.c',
  'luasocket/src/buffer.c',
  'luasocket/src/io.c',
  'luasocket/src/auxiliar.c',
  'luasocket/src/options.c',
  'luasocket/src/inet.c',
  'luasocket/src/except.c',
  'luasocket/src/select.c',
  'luasocket/src/tcp.c',
  'luasocket/src/udp.c',
  'luasocket/src/compat.c'
]
luasocket_include = include_directories('luasocket/src')
luasocket_defines = []

if system == 'windows'
  luasocket_defines += '-DLUASOCKET_DEBUG'

  if cc_id == 'gcc'
    luasocket_defines += '-DWINVER=0x0501'
  else
    luasocket_defines += '-DNDEBUG'
  endif
elif system == 'darwin'
  luasocket_defines += ['-DLUASOCKET_DEBUG', '-DUNIX_HAS_SUN_LEN']
elif system == 'linux'
  luasocket_defines += ['-DLUASOCKET_DEBUG']
endif

if system == 'windows'
  luasocket_socket_sources += 'luasocket/src/wsocket.c'
  project_deps += cc.find_library('ws2_32')
else
  luasocket_socket_sources += 'luasocket/src/usocket.c'

  if system == 'haiku'
    project_deps += cc.find_library('network')
  endif

  unix_sources = [
    'luasocket/src/buffer.c',
    'luasocket/src/compat.c',
    'luasocket/src/auxiliar.c',
    'luasocket/src/options.c',
    'luasocket/src/timeout.c',
    'luasocket/src/io.c',
    'luasocket/src/usocket.c',
    'luasocket/src/unix.c',
    'luasocket/src/unixdgram.c',
    'luasocket/src/unixstream.c'
  ]

  shared_module(
    'unix',
    unix_sources,
    c_args: luasocket_defines,
    include_directories: luasocket_include,
    dependencies: project_deps,
    name_prefix: '',
    name_suffix: module_suffix,
    install: true,
    install_dir: get_option('libdir') / 'lua' / lua_ver / 'socket'
  )

  pkg_config_libs += static_library(
    'socket.unix',
    unix_sources,
    c_args: luasocket_defines,
    include_directories: luasocket_include,
    dependencies: project_deps,
    pic: true,
    install: true,
    install_dir: get_option('libdir') / 'lua' / lua_ver + '-static'
  )

  serial_sources = [
    'luasocket/src/buffer.c',
    'luasocket/src/compat.c',
    'luasocket/src/auxiliar.c',
    'luasocket/src/options.c',
    'luasocket/src/timeout.c',
    'luasocket/src/io.c',
    'luasocket/src/usocket.c',
    'luasocket/src/serial.c'
  ]

  shared_module(
    'serial',
    serial_sources,
    c_args: luasocket_defines,
    include_directories: luasocket_include,
    dependencies: project_deps,
    name_prefix: '',
    name_suffix: module_suffix,
    install: true,
    install_dir: get_option('libdir') / 'lua' / lua_ver / 'socket'
  )

  pkg_config_libs += static_library(
    'socket.serial',
    serial_sources,
    c_args: luasocket_defines,
    include_directories: luasocket_include,
    dependencies: project_deps,
    pic: true,
    install: true,
    install_dir: get_option('libdir') / 'lua' / lua_ver + '-static'
  )
endif

# mime.core
shared_module(
  '_core',
  ['luasocket/src/mime.c', 'luasocket/src/compat.c'],
  c_args: luasocket_defines,
  include_directories: luasocket_include,
  dependencies: project_deps,
  name_prefix: '',
  name_suffix: module_suffix,
  install: true,
  install_dir: get_option('libdir') / 'lua' / lua_ver / 'mime'
)

pkg_config_libs += static_library(
  'mime.core',
  ['luasocket/src/mime.c', 'luasocket/src/compat.c'],
  c_args: luasocket_defines,
  include_directories: luasocket_include,
  dependencies: project_deps,
  pic: true,
  install: true,
  install_dir: get_option('libdir') / 'lua' / lua_ver + '-static'
)

# socket.core
shared_module(
  'core',
  luasocket_socket_sources,
  c_args: luasocket_defines,
  include_directories: luasocket_include,
  dependencies: project_deps,
  name_prefix: '',
  name_suffix: module_suffix,
  install: true,
  install_dir: get_option('libdir') / 'lua' / lua_ver / 'socket'
)

pkg_config_libs += static_library(
  'socket.core',
  luasocket_socket_sources,
  c_args: luasocket_defines,
  include_directories: luasocket_include,
  dependencies: project_deps,
  pic: true,
  install: true,
  install_dir: get_option('libdir') / 'lua' / lua_ver + '-static'
)

# -------------------------------------------------
# LUA SCRIPTS
# -------------------------------------------------

install_data(
  [
    'luasocket/src/ltn12.lua',
    'luasocket/src/mime.lua',
    'luasocket/src/socket.lua'
  ],
  install_dir: get_option('datadir') / 'lua' / lua_ver
)

install_data(
  [
    'luasocket/src/ftp.lua',
    'luasocket/src/headers.lua',
    'luasocket/src/http.lua',
    'luasocket/src/smtp.lua',
    'luasocket/src/tp.lua',
    'luasocket/src/url.lua'
  ],
  install_dir: get_option('datadir') / 'lua' / lua_ver / 'socket'
)

# -------------------------------------------------
# EXTRA DATA
# -------------------------------------------------

data_dir = get_option('libdir') / 'luarocks/rocks-' + lua_ver / 'luasocket/3.1.0-1'
install_data('luarocks/rock_manifest', install_dir: data_dir)

install_data(
  'luasocket/rockspecs/luasocket-3.1.0-1.rockspec',
  install_dir: data_dir
)

install_subdir(
  'luasocket/docs',
  install_dir: data_dir
)

install_subdir(
  'luasocket/samples',
  install_dir: data_dir
)

install_subdir(
  'luasocket/etc',
  install_dir: data_dir
)

install_subdir(
  'luasocket/test',
  install_dir: data_dir
)

# -------------------------------------------------
# PKG CONFIG
# -------------------------------------------------

import('pkgconfig').generate(
  description: 'Network support for the Lua language',
  install_dir: get_option('libdir') / 'lua' / lua_ver + '-static/pkgconfig',
  filebase: meson.project_name(),
  libraries: pkg_config_libs,
  name: meson.project_name(),
  url: 'https://github.com/lunarmodules/luasocket',
)
