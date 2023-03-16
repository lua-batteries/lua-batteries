project(
  'luasocket',
  'c',
  version: '3.1.0',
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

pkg_config_libs = []
luasocket_socket_sources = [
  'src/luasocket.c',
  'src/timeout.c',
  'src/buffer.c',
  'src/io.c',
  'src/auxiliar.c',
  'src/options.c',
  'src/inet.c',
  'src/except.c',
  'src/select.c',
  'src/tcp.c',
  'src/udp.c',
  'src/compat.c'
]
luasocket_include = include_directories('src')
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
  luasocket_socket_sources += 'src/wsocket.c'
  project_deps += cc.find_library('ws2_32')
else
  luasocket_socket_sources += 'src/usocket.c'

  if system == 'haiku'
    project_deps += cc.find_library('network')
  endif

  unix_sources = [
    'src/buffer.c',
    'src/compat.c',
    'src/auxiliar.c',
    'src/options.c',
    'src/timeout.c',
    'src/io.c',
    'src/usocket.c',
    'src/unix.c',
    'src/unixdgram.c',
    'src/unixstream.c'
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
    'lua.socket.unix',
    unix_sources,
    c_args: luasocket_defines,
    include_directories: luasocket_include,
    dependencies: project_deps,
    pic: true,
    install: true,
    install_dir: get_option('libdir') / 'lua' / lua_ver + '-static'
  )

  serial_sources = [
    'src/buffer.c',
    'src/compat.c',
    'src/auxiliar.c',
    'src/options.c',
    'src/timeout.c',
    'src/io.c',
    'src/usocket.c',
    'src/serial.c'
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
    'lua.socket.serial',
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
  ['src/mime.c', 'src/compat.c'],
  c_args: luasocket_defines,
  include_directories: luasocket_include,
  dependencies: project_deps,
  name_prefix: '',
  name_suffix: module_suffix,
  install: true,
  install_dir: get_option('libdir') / 'lua' / lua_ver / 'mime'
)

pkg_config_libs += static_library(
  'lua.mime.core',
  ['src/mime.c', 'src/compat.c'],
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
  'lua.socket.core',
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
    'src/ltn12.lua',
    'src/mime.lua',
    'src/socket.lua'
  ],
  install_dir: get_option('datadir') / 'lua' / lua_ver
)

install_data(
  [
    'src/ftp.lua',
    'src/headers.lua',
    'src/http.lua',
    'src/smtp.lua',
    'src/tp.lua',
    'src/url.lua'
  ],
  install_dir: get_option('datadir') / 'lua' / lua_ver / 'socket'
)

# -------------------------------------------------
# EXTRA DATA
# -------------------------------------------------

data_dir = get_option('libdir') / 'luarocks/rocks-' + lua_ver / 'luasocket/3.1.0-1'
install_data('luarocks/rock_manifest', install_dir: data_dir)

install_data(
  'rockspecs/luasocket-3.1.0-1.rockspec',
  install_dir: data_dir
)

install_subdir(
  'docs',
  install_dir: data_dir
)

install_subdir(
  'samples',
  install_dir: data_dir
)

install_subdir(
  'etc',
  install_dir: data_dir
)

install_subdir(
  'test',
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
