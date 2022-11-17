project(
  'luasdl2',
  'c',
  version: '2.0.5',
  license: 'ISC',
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

luasdl2_comman_sources = [
  'luasdl2/common/array.c',
  'luasdl2/common/common.c',
  'luasdl2/common/rwops.c',
  'luasdl2/common/surface.c',
  'luasdl2/common/table.c',
  'luasdl2/common/variant.c',
  'luasdl2/common/video.c'
]
luasdl2_sdl2_sources = [
  'luasdl2/src/audio.c',
  'luasdl2/src/channel.c',
  'luasdl2/src/clipboard.c',
  'luasdl2/src/cpu.c',
  'luasdl2/src/display.c',
  'luasdl2/src/events.c',
  'luasdl2/src/filesystem.c',
  'luasdl2/src/gamecontroller.c',
  'luasdl2/src/gl.c',
  'luasdl2/src/haptic.c',
  'luasdl2/src/joystick.c',
  'luasdl2/src/keyboard.c',
  'luasdl2/src/logging.c',
  'luasdl2/src/mouse.c',
  'luasdl2/src/platform.c',
  'luasdl2/src/power.c',
  'luasdl2/src/rectangle.c',
  'luasdl2/src/renderer.c',
  'luasdl2/src/SDL.c',
  'luasdl2/src/texture.c',
  'luasdl2/src/thread.c',
  'luasdl2/src/timer.c',
  'luasdl2/src/window.c'
] + luasdl2_comman_sources

luasdl2_sdl2_image_sources = luasdl2_comman_sources + 'luasdl2/sdl-image/src/image.c'
luasdl2_sdl2_mixer_sources = luasdl2_comman_sources + 'luasdl2/sdl-mixer/src/mixer.c'
luasdl2_sdl2_net_sources = luasdl2_comman_sources + 'luasdl2/sdl-net/src/net.c'
luasdl2_sdl2_ttf_sources = luasdl2_comman_sources + 'luasdl2/sdl-ttf/src/ttf.c'

luasdl2_include = [
  include_directories('luasdl2'),
  include_directories('luasdl2/src'),
  include_directories('luasdl2/extern/queue'),
  include_directories('luasdl2/rocks')
]

sdl2_dep = dependency('SDL2', required: false)
sdl2_image_dep = dependency('SDL2_image', required: false)
sdl2_mixer_dep = dependency('SDL2_mixer', required: false)
sdl2_net_dep = dependency('SDL2_net', required: false)
sdl2_ttf_dep = dependency('SDL2_ttf', required: false)

if get_option('standalone') or not sdl2_dep.found() or not sdl2_image_dep.found() or not sdl2_mixer_dep.found() or not sdl2_net_dep.found() or not sdl2_ttf_dep.found()
  subproject('zlib', default_options: ['default_library=static'])
  sdl2 = subproject('sdl2', default_options: ['default_library=static'])

  subproject('libpng', default_options: ['default_library=static'])
  subproject('libjpeg-turbo', default_options: ['default_library=static'])
  subproject('libtiff', default_options: ['default_library=static'])
  sdl2_image = subproject('sdl2_image', default_options: ['default_library=static'])
  
  subproject('ogg', default_options: ['default_library=static'])
  subproject('vorbis', default_options: ['default_library=static'])
  sdl2_mixer = subproject('sdl2_mixer', default_options: ['default_library=static'])

  sdl2_net = subproject('sdl2_net', default_options: ['default_library=static'])

  subproject('freetype2', default_options: ['default_library=static'])
  sdl2_ttf = subproject('sdl2_ttf', default_options: ['default_library=static'])

  project_deps += sdl2.get_variable('sdl2_dep')
  sdl2_image_dep = sdl2_image.get_variable('sdl2_image_dep')
  sdl2_mixer_dep = sdl2_mixer.get_variable('sdl2_mixer_dep')
  sdl2_net_dep = sdl2_net.get_variable('sdl2_net_dep')
  sdl2_ttf_dep = sdl2_ttf.get_variable('sdl2_ttf_dep')
else
  project_deps += sdl2_dep
endif

shared_module(
  'SDL',
  luasdl2_sdl2_sources,
  include_directories: luasdl2_include,
  dependencies: project_deps,
  name_prefix: '',
  name_suffix: module_suffix,
  install: true,
  install_dir: get_option('libdir') / 'lua' / lua_ver
)

static_library(
  'SDL',
  luasdl2_sdl2_sources,
  include_directories: luasdl2_include,
  dependencies: project_deps,
  pic: true,
  install: true,
  install_dir: get_option('libdir') / 'lua' / lua_ver + '-static'
)

shared_module(
  'image',
  luasdl2_sdl2_image_sources,
  include_directories: luasdl2_include,
  dependencies: project_deps + sdl2_image_dep,
  name_prefix: '',
  name_suffix: module_suffix,
  install: true,
  install_dir: get_option('libdir') / 'lua' / lua_ver / 'SDL'
)

static_library(
  'SDL.image',
  luasdl2_sdl2_image_sources,
  include_directories: luasdl2_include,
  dependencies: project_deps + sdl2_image_dep,
  pic: true,
  install: true,
  install_dir: get_option('libdir') / 'lua' / lua_ver + '-static'
)

shared_module(
  'mixer',
  luasdl2_sdl2_mixer_sources,
  include_directories: luasdl2_include,
  dependencies: project_deps + sdl2_mixer_dep,
  name_prefix: '',
  name_suffix: module_suffix,
  install: true,
  install_dir: get_option('libdir') / 'lua' / lua_ver / 'SDL'
)

static_library(
  'SDL.mixer',
  luasdl2_sdl2_mixer_sources,
  include_directories: luasdl2_include,
  dependencies: project_deps + sdl2_mixer_dep,
  pic: true,
  install: true,
  install_dir: get_option('libdir') / 'lua' / lua_ver + '-static'
)

shared_module(
  'net',
  luasdl2_sdl2_net_sources,
  include_directories: luasdl2_include,
  dependencies: project_deps + sdl2_net_dep,
  name_prefix: '',
  name_suffix: module_suffix,
  install: true,
  install_dir: get_option('libdir') / 'lua' / lua_ver / 'SDL'
)

static_library(
  'SDL.net',
  luasdl2_sdl2_net_sources,
  include_directories: luasdl2_include,
  dependencies: project_deps + sdl2_net_dep,
  pic: true,
  install: true,
  install_dir: get_option('libdir') / 'lua' / lua_ver + '-static'
)

shared_module(
  'ttf',
  luasdl2_sdl2_ttf_sources,
  include_directories: luasdl2_include,
  dependencies: project_deps + sdl2_ttf_dep,
  name_prefix: '',
  name_suffix: module_suffix,
  install: true,
  install_dir: get_option('libdir') / 'lua' / lua_ver / 'SDL'
)

static_library(
  'SDL.ttf',
  luasdl2_sdl2_ttf_sources,
  include_directories: luasdl2_include,
  dependencies: project_deps + sdl2_ttf_dep,
  pic: true,
  install: true,
  install_dir: get_option('libdir') / 'lua' / lua_ver + '-static'
)

# -------------------------------------------------
# EXTRA DATA
# -------------------------------------------------

data_dir = get_option('libdir') / 'luarocks/rocks-' + lua_ver / 'luasdl2/2.0.5-3'

install_data(
  'luasdl2/lua-sdl2-scm-3.rockspec',
  rename: 'lua-sdl2-2.0.5-3.rockspec',
  install_dir: data_dir
)

install_subdir(
  'luasdl2/examples',
  install_dir: data_dir
)

install_subdir(
  'luasdl2/tutorials',
  install_dir: data_dir
)
