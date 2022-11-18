project(
  'binser',
  version: '0.0.8',
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

install_data(
  'binser/binser.lua',
  install_dir: get_option('datadir') / 'lua' / lua_ver
)

# -------------------------------------------------
# EXTRA DATA
# -------------------------------------------------

data_dir = get_option('libdir') / 'luarocks/rocks-' + lua_ver / 'binser/0.0-8'
install_data('luarocks/rock_manifest', install_dir: data_dir)

install_data(
  'binser/rockspecs/binser-0.0-8.rockspec',
  install_dir: data_dir
)

install_data(
  'binser/README.md',
  install_dir: data_dir
)
