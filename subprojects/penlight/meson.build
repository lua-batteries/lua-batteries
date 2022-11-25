project(
  'penlight',
  version: '1.13.1',
  license: 'MIT',
  meson_version: '>=0.64.0'
)

# -------------------------------------------------
# BASE SETUP
# -------------------------------------------------

lua_ver = get_option('luajit') ? '5.1' : '5.4'

# -------------------------------------------------
# LUA SCRIPTS
# -------------------------------------------------

install_subdir(
  'Penlight/lua/pl',
  install_dir: get_option('datadir') / 'lua' / lua_ver
)

# -------------------------------------------------
# EXTRA DATA
# -------------------------------------------------

data_dir = get_option('libdir') / 'luarocks/rocks-' + lua_ver / 'penlight/1.13.1-1'
install_data('luarocks/rock_manifest', install_dir: data_dir)

install_data(
  'Penlight/rockspecs/penlight-1.13.1-1.rockspec',
  install_dir: data_dir
)

install_subdir(
  'Penlight/docs',
  install_dir: data_dir
)
