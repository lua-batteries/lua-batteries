project(
  'luasocket',
  'c',
  version: '3.1.0',
  license: 'MIT',
  meson_version: '>=0.63.0'
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

lua_dep = get_option('luajit-mod') ? subproject('luajit').get_variable('luajit_dep') : subproject('lua').get_variable('lua_dep')
lua_ver = get_option('luajit-mod') ? '5.1' : '5.4'
project_deps = [lua_dep]

# -------------------------------------------------
# LUA MODULE
# -------------------------------------------------

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

  shared_module(
    'unix',
    [
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
    ],
    c_args: luasocket_defines,
    include_directories: luasocket_include,
    dependencies: project_deps,
    name_prefix: '',
    name_suffix: module_suffix,
    install: true,
    install_dir: get_option('libdir') / 'lua' / lua_ver / 'socket'
  )

  shared_module(
    'serial',
    [
      'luasocket/src/buffer.c',
      'luasocket/src/compat.c',
      'luasocket/src/auxiliar.c',
      'luasocket/src/options.c',
      'luasocket/src/timeout.c',
      'luasocket/src/io.c',
      'luasocket/src/usocket.c',
      'luasocket/src/serial.c'
    ],
    c_args: luasocket_defines,
    include_directories: luasocket_include,
    dependencies: project_deps,
    name_prefix: '',
    name_suffix: module_suffix,
    install: true,
    install_dir: get_option('libdir') / 'lua' / lua_ver / 'socket'
  )
endif

shared_module(
  'mime',
  ['luasocket/src/mime.c', 'luasocket/src/compat.c'],
  c_args: luasocket_defines,
  include_directories: luasocket_include,
  dependencies: project_deps,
  name_prefix: '',
  name_suffix: module_suffix,
  install: true,
  install_dir: get_option('libdir') / 'lua' / lua_ver
)

shared_module(
  'socket',
  luasocket_socket_sources,
  c_args: luasocket_defines,
  include_directories: luasocket_include,
  dependencies: project_deps,
  name_prefix: '',
  name_suffix: module_suffix,
  install: true,
  install_dir: get_option('libdir') / 'lua' / lua_ver
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
  install_dir: get_option('datadir') / 'lua' / lua_ver / 'luasocket'
)

# -------------------------------------------------
# EXTRA DATA
# -------------------------------------------------

data_dir = get_option('libdir') / 'luarocks/rocks-' + lua_ver / 'luasocket/3.1.0-1'

install_data(
  'luasocket/rockspecs/luasocket-3.1.0-1.rockspec',
  install_dir: data_dir
)

install_subdir(
  'luasocket/docs',
  install_dir: data_dir / 'docs'
)

install_subdir(
  'luasocket/samples',
  install_dir: data_dir / 'samples'
)

install_subdir(
  'luasocket/etc',
  install_dir: data_dir / 'etc'
)

install_subdir(
  'luasocket/test',
  install_dir: data_dir / 'test'
)