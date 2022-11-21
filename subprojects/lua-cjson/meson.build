project(
  'lua-cjson',
  'c',
  version: '2.1.0.10',
  license: 'MIT',
  meson_version: '>=0.64.0'
)

# -------------------------------------------------
# BASE SETUP
# -------------------------------------------------

cc = meson.get_compiler('c')
cc_id = cc.get_id()
system = host_machine.system()
module_suffix = 'so'

if system == 'windows'
  module_suffix = 'dll'
endif

lua_dep = get_option('luajit') ? subproject('luajit').get_variable('luajit_dep') : subproject('lua').get_variable('lua_dep')
lua_ver = get_option('luajit') ? '5.1' : '5.4'
project_deps = [lua_dep]

# -------------------------------------------------
# LUA MODULE
# -------------------------------------------------

lua_cjson_sources = [
  'lua-cjson/lua_cjson.c',
  'lua-cjson/strbuf.c',
  'lua-cjson/fpconv.c'
]
lua_cjson_defines = []
lua_cjson_link_args = []

if system == 'windows'
  lua_cjson_defines += ['-DDISABLE_INVALID_NUMBERS', '-DUSE_INTERNAL_ISINF']

  if cc_id in ['msvc', 'clang', 'clang-cl']
    lua_cjson_link_args += '-export:luaopen_cjson'
  endif
elif system == 'sunos'
  lua_cjson_defines += '-DUSE_INTERNAL_ISINF'
endif

shared_module(
  'cjson',
  lua_cjson_sources,
  c_args: lua_cjson_defines,
  link_args: lua_cjson_link_args,
  dependencies: project_deps,
  name_prefix: '',
  name_suffix: module_suffix,
  install: true,
  install_dir: get_option('libdir') / 'lua' / lua_ver
)

static_library(
  'cjson',
  lua_cjson_sources,
  c_args: lua_cjson_defines,
  link_args: lua_cjson_link_args,
  dependencies: project_deps,
  pic: true,
  install: true,
  install_dir: get_option('libdir') / 'lua' / lua_ver + '-static'
)

# -------------------------------------------------
# LUA SCRIPTS
# -------------------------------------------------

install_data(
  'lua-cjson/lua/cjson/util.lua',
  install_dir: get_option('datadir') / 'lua' / lua_ver / 'cjson'
)

install_data(
  system == 'windows' ? [
    'scripts/json2lua.bat', 'scripts/lua2json.bat'
  ] : [
    'scripts/json2lua', 'scripts/lua2json'
  ],
  install_mode: 'rwxr-xr-x',
  install_dir: get_option('bindir')
)

# -------------------------------------------------
# EXTRA DATA
# -------------------------------------------------

data_dir = get_option('libdir') / 'luarocks/rocks-' + lua_ver / 'lua-cjson/2.1.0.10-1'
install_data('luarocks/rock_manifest', install_dir: data_dir)

install_data(
  'lua-cjson/lua-cjson-2.1.0.10-1.rockspec',
  install_dir: data_dir
)
