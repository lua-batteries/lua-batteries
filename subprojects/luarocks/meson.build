project(
  'luarocks',
  version: '3.9.1',
  license: 'MIT',
  meson_version: '>=0.63.0'
)

cc = meson.get_compiler('c')
system = host_machine.system()

install_subdir(
  'luarocks/src/luarocks',
  install_dir: 'share/lua/5.4'
)

if get_option('luajit')
  install_subdir(
    'luarocks/src/luarocks',
    install_dir: 'share/lua/5.1'
  )
endif

install_data(
  [
    'luarocks/src/bin/luarocks',
    'luarocks/src/bin/luarocks-admin'
  ],
  rename: [
    'luarocks.lua',
    'luarocks-admin.lua'
  ],
  install_dir: 'share/lua/bin'
)

if system == 'windows'
  scripts = ['luarocks.bat', 'luarocks-admin.bat']

  if get_option('luajit')
    scripts += 'luarocks-jit.bat'
  endif

  install_data(scripts, install_dir: get_option('bindir'))
  install_data(
    [
      'luarocks/win32/tools/7z.dll',
      'luarocks/win32/tools/7z.exe',
      'luarocks/win32/tools/cp.exe',
      'luarocks/win32/tools/find.exe',
      'luarocks/win32/tools/libiconv2.dll',
      'luarocks/win32/tools/libintl3.dll',
      'luarocks/win32/tools/ls.exe',
      'luarocks/win32/tools/md5sum.exe',
      'luarocks/win32/tools/mv.exe',
      'luarocks/win32/tools/uname.exe',
      'luarocks/win32/tools/wget.exe'
    ],
    install_dir: get_option('bindir') / 'tools'
  )
else
  scripts = ['luarocks.sh', 'luarocks-admin.sh']
  scripts_renamed = ['luarocks', 'luarocks-admin']

  if get_option('luajit')
    scripts += 'luarocks-jit.sh'
    scripts_renamed += 'luarocks-jit'
  endif

  install_data(
    scripts,
    rename: scripts_renamed,
    install_mode: 'rwxr-xr-x',
    install_dir: get_option('bindir')
  )
endif

if cc.get_id() == 'msvc'
  install_data(
    'config-msvc.lua',
    rename: 'config-5.4.lua',
    install_dir: 'share/lua'
  )

  if get_option('luajit')
    install_data(
      'config-msvc.lua',
      rename: 'config-5.1.lua',
      install_dir: 'share/lua'
    )
  endif
endif
