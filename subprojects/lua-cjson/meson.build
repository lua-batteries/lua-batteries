project(
  'lua-cjson',
  'c',
  version: '2.1.0.10',
  license: 'MIT',
  meson_version: '>=1.0.0'
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
    lua_cjson_link_args += [
      '-export:luaopen_cjson',
      '-export:luaopen_cjson_safe'
    ]
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

lua_cjson = static_library(
  'lua.cjson',
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

# -------------------------------------------------
# EXTRA DATA
# -------------------------------------------------

data_dir = get_option('libdir') / 'luarocks/rocks-' + lua_ver / 'lua-cjson/2.1.0.10-1'
install_data('luarocks/rock_manifest', install_dir: data_dir)

install_data(
  'lua-cjson/lua-cjson-2.1.0.10-1.rockspec',
  install_dir: data_dir
)

# -------------------------------------------------
# LUA BIN SCRIPTS
# -------------------------------------------------

install_data(
  ['lua-cjson/lua/json2lua.lua', 'lua-cjson/lua/lua2json.lua'],
  install_dir: data_dir / 'bin'
)

scripts_conf = configuration_data({
  'BIN': get_option('luajit') ? 'luajit' : 'lua',
  'LUA_VER': lua_ver,
  'ROCKSPEC_VER': '2.1.0.10-1'
})

install_data(
  configure_file(
    input: 'scripts/json2lua' + (system == 'windows' ? '.bat' : '.sh'),
    output: 'json2lua' + (system == 'windows' ? '.bat' : ''),
    configuration: scripts_conf
  ),
  install_mode: 'rwxr-xr-x',
  install_dir: get_option('bindir')
)

install_data(
  configure_file(
    input: 'scripts/lua2json' + (system == 'windows' ? '.bat' : '.sh'),
    output: 'lua2json' + (system == 'windows' ? '.bat' : ''),
    configuration: scripts_conf
  ),
  install_mode: 'rwxr-xr-x',
  install_dir: get_option('bindir')
)

# -------------------------------------------------
# PKG CONFIG
# -------------------------------------------------

import('pkgconfig').generate(
  description: 'A fast JSON encoding/parsing module',
  install_dir: get_option('libdir') / 'lua' / lua_ver + '-static/pkgconfig',
  filebase: meson.project_name(),
  libraries: lua_cjson,
  name: meson.project_name(),
  url: 'https://github.com/openresty/lua-cjson',
)
