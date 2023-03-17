project(
  'xml2lua',
  version: '1.6',
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
  ['xml2lua.lua', 'XmlParser.lua'],
  install_dir: get_option('datadir') / 'lua' / lua_ver
)

install_data(
  [
    'xmlhandler/tree.lua',
    'xmlhandler/print.lua',
    'xmlhandler/dom.lua'
  ],
  install_dir: get_option('datadir') / 'lua' / lua_ver / 'xmlhandler'
)

# -------------------------------------------------
# EXTRA DATA
# -------------------------------------------------

data_dir = get_option('libdir') / 'luarocks/rocks-' + lua_ver / 'xml2lua/1.6-1'
install_data('luarocks/rock_manifest', install_dir: data_dir)

install_data(
  'xml2lua-1.6-1.rockspec',
  install_dir: data_dir
)

install_data(
  'README.adoc',
  install_dir: data_dir / 'docs'
)

install_data(
  [
    'example1.lua',
    'example2.lua',
    'example3.lua',
    'example4-table2xml.lua',
  ],
  install_dir: data_dir / 'examples'
)
