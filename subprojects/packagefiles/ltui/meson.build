project(
  'ltui',
  'c', 'cpp',
  version: '2.7',
  license: 'APACHE-2.0',
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

lua_dep = get_option('luajit') ? dependency('luajit') : dependency('lua')
lua_ver = get_option('luajit') ? '5.1' : '5.4'
project_deps = [lua_dep]

# -------------------------------------------------
# LUA MODULE
# -------------------------------------------------

ltui_sources = [
  'src/core/curses/curses.c'
]
ltui_includes = [
  include_directories('src/core/curses')
]
ltui_defines = []
# ltui_defines = [
#   '-D_GNU_SOURCE=1',
#   '-D_FILE_OFFSET_BITS=64',
#   '-D_LARGEFILE_SOURCE'
# ]

if system == 'windows'
  ltui_sources += [
    'src/core/pdcurses/pdcurses/addch.c',
    'src/core/pdcurses/pdcurses/addchstr.c',
    'src/core/pdcurses/pdcurses/addstr.c',
    'src/core/pdcurses/pdcurses/attr.c',
    'src/core/pdcurses/pdcurses/beep.c',
    'src/core/pdcurses/pdcurses/bkgd.c',
    'src/core/pdcurses/pdcurses/border.c',
    'src/core/pdcurses/pdcurses/clear.c',
    'src/core/pdcurses/pdcurses/color.c',
    'src/core/pdcurses/pdcurses/debug.c',
    'src/core/pdcurses/pdcurses/delch.c',
    'src/core/pdcurses/pdcurses/deleteln.c',
    'src/core/pdcurses/pdcurses/deprec.c',
    'src/core/pdcurses/pdcurses/getch.c',
    'src/core/pdcurses/pdcurses/getstr.c',
    'src/core/pdcurses/pdcurses/getyx.c',
    'src/core/pdcurses/pdcurses/inch.c',
    'src/core/pdcurses/pdcurses/inchstr.c',
    'src/core/pdcurses/pdcurses/initscr.c',
    'src/core/pdcurses/pdcurses/inopts.c',
    'src/core/pdcurses/pdcurses/insch.c',
    'src/core/pdcurses/pdcurses/insstr.c',
    'src/core/pdcurses/pdcurses/instr.c',
    'src/core/pdcurses/pdcurses/kernel.c',
    'src/core/pdcurses/pdcurses/keyname.c',
    'src/core/pdcurses/pdcurses/mouse.c',
    'src/core/pdcurses/pdcurses/move.c',
    'src/core/pdcurses/pdcurses/outopts.c',
    'src/core/pdcurses/pdcurses/overlay.c',
    'src/core/pdcurses/pdcurses/pad.c',
    'src/core/pdcurses/pdcurses/panel.c',
    'src/core/pdcurses/pdcurses/printw.c',
    'src/core/pdcurses/pdcurses/refresh.c',
    'src/core/pdcurses/pdcurses/scanw.c',
    'src/core/pdcurses/pdcurses/scroll.c',
    'src/core/pdcurses/pdcurses/scr_dump.c',
    'src/core/pdcurses/pdcurses/slk.c',
    'src/core/pdcurses/pdcurses/termattr.c',
    'src/core/pdcurses/pdcurses/terminfo.c',
    'src/core/pdcurses/pdcurses/touch.c',
    'src/core/pdcurses/pdcurses/util.c',
    'src/core/pdcurses/pdcurses/window.c',
    'src/core/pdcurses/win32/pdcclip.c',
    'src/core/pdcurses/win32/pdcdisp.c',
    'src/core/pdcurses/win32/pdcgetsc.c',
    'src/core/pdcurses/win32/pdckbd.c',
    'src/core/pdcurses/win32/pdcscrn.c',
    'src/core/pdcurses/win32/pdcsetsc.c',
    'src/core/pdcurses/win32/pdcutil.c'
  ]
  ltui_defines += ['-DPDCURSES', '-DPDC_WIDE']
  ltui_includes += include_directories('src/core/pdcurses')
  project_deps += cc.find_library('kernel32')
  project_deps += cc.find_library('user32')
  project_deps += cc.find_library('gdi32')
  project_deps += cc.find_library('advapi32')
else
  ncurses = cc.find_library('ncurses', required: false)

  if not ncurses.found()
    project_deps += cc.find_library('curses')
  else
    project_deps += ncurses
  endif
endif

shared_module(
  'ltui',
  ltui_sources,
  c_args: ltui_defines,
  include_directories: ltui_includes,
  dependencies: project_deps,
  name_prefix: '',
  name_suffix: module_suffix,
  install: true,
  install_dir: get_option('libdir') / 'lua' / lua_ver
)

lua_ltui = static_library(
  'lua.ltui',
  ltui_sources,
  c_args: ltui_defines,
  include_directories: ltui_includes,
  dependencies: project_deps,
  pic: true,
  install: true,
  install_dir: get_option('libdir') / 'lua' / lua_ver + '-static'
)

# -------------------------------------------------
# LUA SCRIPTS
# -------------------------------------------------

install_data(
  'src/ltui.lua',
  install_dir: get_option('datadir') / 'lua' / lua_ver
)

install_subdir(
  'src/ltui',
  install_dir: get_option('datadir') / 'lua' / lua_ver
)

# -------------------------------------------------
# EXTRA DATA
# -------------------------------------------------

data_dir = get_option('libdir') / 'luarocks/rocks-' + lua_ver / 'ltui/2.7-1'
install_data('luarocks/rock_manifest', install_dir: data_dir)

install_data(
  'rockspec/ltui-2.7-1.rockspec',
  install_dir: data_dir
)

install_subdir(
  'tests',
  install_dir: data_dir
)

# -------------------------------------------------
# PKG CONFIG
# -------------------------------------------------

import('pkgconfig').generate(
  description: 'A cross-platform terminal ui library based on Lua',
  install_dir: get_option('libdir') / 'lua' / lua_ver + '-static/pkgconfig',
  filebase: meson.project_name(),
  libraries: lua_ltui,
  name: meson.project_name(),
  url: 'https://github.com/tboox/ltui',
)
