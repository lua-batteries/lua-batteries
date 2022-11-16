project(
  'xml2lua',
  version: '1.5',
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
  ['xml2lua/xml2lua.lua', 'xml2lua/XmlParser.lua'],
  install_dir: get_option('datadir') / 'lua' / lua_ver
)

install_data(
  [
    'xml2lua/xmlhandler/tree.lua',
    'xml2lua/xmlhandler/print.lua',
    'xml2lua/xmlhandler/dom.lua'
  ],
  install_dir: get_option('datadir') / 'lua' / lua_ver / 'xmlhandler'
)

# -------------------------------------------------
# EXTRA DATA
# -------------------------------------------------

data_dir = get_option('libdir') / 'luarocks/rocks-' + lua_ver / 'xml2lua/1.5-2'

install_data(
  'xml2lua/xml2lua-1.5-2.rockspec',
  install_dir: data_dir
)

install_data(
  'xml2lua/README.adoc',
  install_dir: data_dir
)

install_data(
  [
    'xml2lua/example1.lua',
    'xml2lua/example2.lua',
    'xml2lua/example3.lua',
    'xml2lua/example4-table2xml.lua',
  ],
  install_dir: data_dir / 'examples'
)
