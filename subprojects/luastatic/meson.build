project(
  'luastatic',
  license: 'CC0',
  meson_version: '>=0.64.0'
)

# -------------------------------------------------
# BASE SETUP
# -------------------------------------------------

lua_ver = get_option('luajit') ? '5.1' : '5.4'

# -------------------------------------------------
# EXTRA DATA
# -------------------------------------------------

data_dir = get_option('libdir') / 'luarocks/rocks-' + lua_ver / 'luastatic/scm-1'
install_data('luarocks/rock_manifest', install_dir: data_dir)

install_data(
  'luarocks/luastatic-scm-1.rockspec',
  install_dir: data_dir
)

install_data(
  'luastatic/readme.md',
  install_dir: data_dir / 'docs'
)

# -------------------------------------------------
# LUA BIN SCRIPTS
# -------------------------------------------------

install_data(
  'luastatic/luastatic.lua',
  install_dir: data_dir / 'bin'
)

install_data(
  configure_file(
    input: 'scripts/luastatic' + (host_machine.system() == 'windows' ? '.bat' : '.sh'),
    output: 'luastatic' + (host_machine.system() == 'windows' ? '.bat' : ''),
    configuration: {
      'BIN': get_option('luajit') ? 'luajit' : 'lua',
      'LUA_VER': lua_ver,
      'ROCKSPEC_VER': 'scm-1'
    }
  ),
  install_mode: 'rwxr-xr-x',
  install_dir: get_option('bindir')
)
