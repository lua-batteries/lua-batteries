project(
  'luarocks',
  version: '3.9.1',
  license: 'MIT',
  meson_version: '>=0.64.0'
)

cc = meson.get_compiler('c')
cc_id = cc.get_id()
system = host_machine.system()
lua_ver = get_option('luajit') ? '5.1' : '5.4'

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
  install_dir: get_option('datadir') / 'lua/bin'
)

if system == 'windows'
  scripts = ['scripts/luarocks.bat', 'scripts/luarocks-admin.bat']

  if get_option('luajit')
    scripts += ['scripts/luarocks-jit.bat', 'scripts/luarocks-admin-jit.bat']
  endif

  install_data(scripts, install_dir: get_option('bindir'))

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
else
  scripts = ['scripts/luarocks.sh', 'scripts/luarocks-admin.sh']
  scripts_renamed = ['luarocks', 'luarocks-admin']

  if get_option('luajit')
    scripts += ['scripts/luarocks-jit.sh', 'scripts/luarocks-admin-jit.sh']
    scripts_renamed += ['luarocks-jit', 'luarocks-admin-jit']
  endif

  install_data(
    scripts,
    rename: scripts_renamed,
    install_mode: 'rwxr-xr-x',
    install_dir: get_option('bindir')
  )
endif

luarocks_config = ''

if cc_id == 'msvc'
  luarocks_config = 'config/config-windows-msvc.lua'
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
  if get_option('luajit')
    install_data(
      luarocks_config,
      rename: 'config-5.1.lua',
      install_dir: get_option('datadir') / 'lua'
    )
  else
    install_data(
      luarocks_config,
      rename: 'config-5.4.lua',
      install_dir: get_option('datadir') / 'lua'
    )
  endif
endif

# -------------------------------------------------
# EXTRA DATA
# -------------------------------------------------

install_data(
  'config/manifest',
  install_dir: get_option('libdir') / 'luarocks/rocks-' + lua_ver
)

install_data(
  ['luarocks/luarocks-3.9.1-1.rockspec', 'config/rock_manifest'],
  install_dir: get_option('libdir') / 'luarocks/rocks-5.4/luarocks/3.9.1-1'
)

install_data(
  [
    'luarocks/CHANGELOG.md',
    'luarocks/CODE_OF_CONDUCT.md',
    'luarocks/win32/COPYING',
    'luarocks/README.md',
  ],
  install_dir: get_option('libdir') / 'luarocks/rocks-' + lua_ver / 'luarocks/3.9.1-1/doc'
)
