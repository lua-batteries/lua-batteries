project(
  'inspect',
  version: '3.1.3',
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
  'inspect.lua/inspect.lua',
  install_dir: get_option('datadir') / 'lua' / lua_ver
)

# -------------------------------------------------
# EXTRA DATA
# -------------------------------------------------

data_dir = get_option('libdir') / 'luarocks/rocks-' + lua_ver / 'inspect/3.1.3-0'
install_data('luarocks/rock_manifest', install_dir: data_dir)

install_data(
  'luarocks/inspect-3.1.3-0.rockspec',
  install_dir: data_dir
)

install_data(
  'inspect.lua/README.md',
  install_dir: data_dir
)
