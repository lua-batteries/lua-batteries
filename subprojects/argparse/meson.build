project(
  'argparse',
  version: '0.7.1',
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
  'argparse/src/argparse.lua',
  install_dir: get_option('datadir') / 'lua' / lua_ver
)

# -------------------------------------------------
# EXTRA DATA
# -------------------------------------------------

data_dir = get_option('libdir') / 'luarocks/rocks-' + lua_ver / 'argparse/0.7.1-2'

install_data(
  'argparse/argparse-scm-2.rockspec',
  install_dir: data_dir
)

install_subdir(
  'argparse/docsrc',
  install_dir: data_dir
)
