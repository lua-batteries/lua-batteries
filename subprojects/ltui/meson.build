project(
  'ltui',
  'c', 'cpp',
  version: '2.6',
  license: 'APACHE-2.0',
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

ltui_sources = [
  'ltui/src/core/lcurses/lcurses.c'
]
ltui_includes = [
  include_directories('ltui/src/core/lcurses')
]
ltui_defines = []
# ltui_defines = [
#   '-D_GNU_SOURCE=1',
#   '-D_FILE_OFFSET_BITS=64',
#   '-D_LARGEFILE_SOURCE'
# ]

if system == 'windows'
  ltui_sources += [
    'ltui/src/core/pdcurses/pdcurses/addch.c',
    'ltui/src/core/pdcurses/pdcurses/addchstr.c',
    'ltui/src/core/pdcurses/pdcurses/addstr.c',
    'ltui/src/core/pdcurses/pdcurses/attr.c',
    'ltui/src/core/pdcurses/pdcurses/beep.c',
    'ltui/src/core/pdcurses/pdcurses/bkgd.c',
    'ltui/src/core/pdcurses/pdcurses/border.c',
    'ltui/src/core/pdcurses/pdcurses/clear.c',
    'ltui/src/core/pdcurses/pdcurses/color.c',
    'ltui/src/core/pdcurses/pdcurses/debug.c',
    'ltui/src/core/pdcurses/pdcurses/delch.c',
    'ltui/src/core/pdcurses/pdcurses/deleteln.c',
    'ltui/src/core/pdcurses/pdcurses/deprec.c',
    'ltui/src/core/pdcurses/pdcurses/getch.c',
    'ltui/src/core/pdcurses/pdcurses/getstr.c',
    'ltui/src/core/pdcurses/pdcurses/getyx.c',
    'ltui/src/core/pdcurses/pdcurses/inch.c',
    'ltui/src/core/pdcurses/pdcurses/inchstr.c',
    'ltui/src/core/pdcurses/pdcurses/initscr.c',
    'ltui/src/core/pdcurses/pdcurses/inopts.c',
    'ltui/src/core/pdcurses/pdcurses/insch.c',
    'ltui/src/core/pdcurses/pdcurses/insstr.c',
    'ltui/src/core/pdcurses/pdcurses/instr.c',
    'ltui/src/core/pdcurses/pdcurses/kernel.c',
    'ltui/src/core/pdcurses/pdcurses/keyname.c',
    'ltui/src/core/pdcurses/pdcurses/mouse.c',
    'ltui/src/core/pdcurses/pdcurses/move.c',
    'ltui/src/core/pdcurses/pdcurses/outopts.c',
    'ltui/src/core/pdcurses/pdcurses/overlay.c',
    'ltui/src/core/pdcurses/pdcurses/pad.c',
    'ltui/src/core/pdcurses/pdcurses/panel.c',
    'ltui/src/core/pdcurses/pdcurses/printw.c',
    'ltui/src/core/pdcurses/pdcurses/refresh.c',
    'ltui/src/core/pdcurses/pdcurses/scanw.c',
    'ltui/src/core/pdcurses/pdcurses/scroll.c',
    'ltui/src/core/pdcurses/pdcurses/scr_dump.c',
    'ltui/src/core/pdcurses/pdcurses/slk.c',
    'ltui/src/core/pdcurses/pdcurses/termattr.c',
    'ltui/src/core/pdcurses/pdcurses/terminfo.c',
    'ltui/src/core/pdcurses/pdcurses/touch.c',
    'ltui/src/core/pdcurses/pdcurses/util.c',
    'ltui/src/core/pdcurses/pdcurses/window.c',
    'ltui/src/core/pdcurses/win32/pdcclip.c',
    'ltui/src/core/pdcurses/win32/pdcdisp.c',
    'ltui/src/core/pdcurses/win32/pdcgetsc.c',
    'ltui/src/core/pdcurses/win32/pdckbd.c',
    'ltui/src/core/pdcurses/win32/pdcscrn.c',
    'ltui/src/core/pdcurses/win32/pdcsetsc.c',
    'ltui/src/core/pdcurses/win32/pdcutil.c'
  ]
  ltui_defines += ['-DPDCURSES', '-DPDC_WIDE']
  ltui_includes += include_directories('ltui/src/core/pdcurses')
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

static_library(
  'ltui',
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
  'ltui/src/ltui.lua',
  install_dir: get_option('datadir') / 'lua' / lua_ver
)

install_subdir(
  'ltui/src/ltui',
  install_dir: get_option('datadir') / 'lua' / lua_ver
)

# -------------------------------------------------
# EXTRA DATA
# -------------------------------------------------

data_dir = get_option('libdir') / 'luarocks/rocks-' + lua_ver / 'ltui/2.6-1'

install_data(
  'ltui/rockspec/ltui-2.6-1.rockspec',
  install_dir: data_dir
)

install_subdir(
  'ltui/tests',
  install_dir: data_dir
)
