project(
  'luarocks',
  version: '3.9.2',
  license: 'MIT',
  meson_version: '>=0.64.0'
)

cc = meson.get_compiler('c')
cc_id = cc.get_id()
system = host_machine.system()
lua_ver = get_option('luajit') ? '5.1' : '5.4'
luarocks_dir = get_option('libdir') / 'luarocks/rocks-' + lua_ver / 'luarocks/3.9.2-1'

install_subdir(
  'luarocks/src/luarocks',
  install_dir: get_option('datadir') / 'lua' / lua_ver
)

install_data(
  [
    'luarocks/src/bin/luarocks',
    'luarocks/src/bin/luarocks-admin'
  ],
  rename: [
    'luarocks.lua',
    'luarocks-admin.lua'
  ],
  install_dir: luarocks_dir / 'bin'
)

scripts_conf = configuration_data({
  'BIN': get_option('luajit') ? 'luajit' : 'lua',
  'LUA_VER': lua_ver,
  'LUAROCKS_VER': meson.project_version()
})

install_data(
  configure_file(
    input: 'scripts/luarocks' + (system == 'windows' ? '.bat' : '.sh'),
    output: (get_option('luajit') ? 'luarocks-jit' : 'luarocks') + (system == 'windows' ? '.bat' : ''),
    configuration: scripts_conf
  ),
  install_mode: 'rwxr-xr-x',
  install_dir: get_option('bindir')
)

install_data(
  configure_file(
    input: 'scripts/luarocks-admin' + (system == 'windows' ? '.bat' : '.sh'),
    output: (get_option('luajit') ? 'luarocks-admin-jit' : 'luarocks-admin') + (system == 'windows' ? '.bat' : ''),
    configuration: scripts_conf
  ),
  install_mode: 'rwxr-xr-x',
  install_dir: get_option('bindir')
)

if system == 'windows'
  install_data(
    [
      'luarocks/win32/tools/7z.exe',
      'luarocks/win32/tools/7z.dll',
      'luarocks/win32/tools/cp.exe',
      'luarocks/win32/tools/find.exe',
      'luarocks/win32/tools/libiconv2.dll',
      'luarocks/win32/tools/libintl3.dll',
      'luarocks/win32/tools/ls.exe',
      'luarocks/win32/tools/md5sum.exe',
      'luarocks/win32/tools/wget.exe'
    ],
    install_dir: get_option('bindir') / 'tools'
  )
endif

luarocks_config = ''

if cc_id == 'msvc'
  luarocks_config = 'config/config-windows-msvc.lua'
elif system == 'windows' and cc_id == 'gcc'
  luarocks_config = 'config/config-windows-mingw.lua'
elif cc_id == 'clang' or cc_id == 'clang-cl'
  if system == 'windows'
    luarocks_config = 'config/config-windows-clang.lua'
  elif system == 'darwin'
    luarocks_config = 'config/config-darwin-clang.lua'
  else
    luarocks_config = 'config/config-unix-clang.lua'
  endif
endif

if luarocks_config != ''
  install_data(
    luarocks_config,
    rename: get_option('luajit') ? 'config-5.1.lua' : 'config-5.4.lua',
    install_dir: get_option('libdir') / 'luarocks/rocks-' + lua_ver
  )
endif

install_data(
  'config/manifest',
  install_dir: get_option('libdir') / 'luarocks/rocks-' + lua_ver
)

# -------------------------------------------------
# EXTRA DATA
# -------------------------------------------------

install_data(
  ['luarocks/luarocks-3.9.2-1.rockspec', 'config/rock_manifest'],
  install_dir: luarocks_dir
)

install_data(
  [
    'luarocks/CHANGELOG.md',
    'luarocks/CODE_OF_CONDUCT.md',
    'luarocks/win32/COPYING',
    'luarocks/README.md',
    'luarocks/SECURITY.md',
  ],
  install_dir: luarocks_dir / 'doc'
)
