project(
  'date',
  version: '2.2',
  license: 'MIT',
  meson_version: '>=1.0.0'
)

# -------------------------------------------------
# BASE SETUP
# -------------------------------------------------

lua_ver = get_option('luajit') ? '5.1' : '5.4'

# -------------------------------------------------
# LUA SCRIPTS
# -------------------------------------------------

install_data(
  'src/date.lua',
  install_dir: get_option('datadir') / 'lua' / lua_ver
)

# -------------------------------------------------
# EXTRA DATA
# -------------------------------------------------

data_dir = get_option('libdir') / 'luarocks/rocks-' + lua_ver / 'date/2.2-2'
install_data('luarocks/rock_manifest', install_dir: data_dir)

install_data(
  'luarocks/date-2.2-2.rockspec',
  install_dir: data_dir
)

install_subdir(
  'docs',
  install_dir: data_dir
)
