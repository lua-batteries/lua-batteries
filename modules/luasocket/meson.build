# project(
#   'luasocket',
#   'c',
#   version: '3.1.0',
#   license: 'MIT',
#   meson_version: '>=0.63.0'
# )

luasocket_include = include_directories('luasocket/src')
luasocket_defines = []
luasocket_deps = [lua_dep]
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
  luasocket_deps += cc.find_library('ws2_32')
else
  luasocket_socket_sources += 'luasocket/src/usocket.c'

  if system == 'haiku'
    luasocket_deps += cc.find_library('network')
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
    dependencies: luasocket_deps,
    name_prefix: '',
    name_suffix: module_suffix,
    install: true,
    install_dir: get_option('libdir') / 'lua/5.4/socket',
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
    dependencies: luasocket_deps,
    name_prefix: '',
    name_suffix: module_suffix,
    install: true,
    install_dir: get_option('libdir') / 'lua/5.4/socket',
  )
endif

shared_module(
  'mime',
  ['luasocket/src/mime.c', 'luasocket/src/compat.c'],
  c_args: luasocket_defines,
  include_directories: luasocket_include,
  dependencies: luasocket_deps,
  name_prefix: '',
  name_suffix: module_suffix,
  install: true,
  install_dir: get_option('libdir') / 'lua/5.4',
)

shared_module(
  'socket',
  luasocket_socket_sources,
  c_args: luasocket_defines,
  include_directories: luasocket_include,
  dependencies: luasocket_deps,
  name_prefix: '',
  name_suffix: module_suffix,
  install: true,
  install_dir: get_option('libdir') / 'lua/5.4',
)

install_data(
  [
    'luasocket/src/ltn12.lua',
    'luasocket/src/mime.lua',
    'luasocket/src/socket.lua'
  ],
  install_dir: get_option('datadir') / 'lua/5.4'
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
  install_dir: get_option('datadir') / 'lua/5.4/luasocket'
)

# Extra

luarocks_luasocket_dir = get_option('libdir') / 'luarocks/rocks-5.4/luasocket/3.1.0-1'

install_data(
  'luasocket/rockspecs/luasocket-3.1.0-1.rockspec',
  install_dir: luarocks_luasocket_dir
)

install_subdir(
  'luasocket/docs',
  install_dir: luarocks_luasocket_dir / 'docs'
)

install_subdir(
  'luasocket/samples',
  install_dir: luarocks_luasocket_dir / 'samples'
)

install_subdir(
  'luasocket/etc',
  install_dir: luarocks_luasocket_dir / 'etc'
)

install_subdir(
  'luasocket/test',
  install_dir: luarocks_luasocket_dir / 'test'
)
