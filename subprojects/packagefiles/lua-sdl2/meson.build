project(
  'lua-sdl2',
  'c',
  version: '2.0.5',
  license: 'ISC',
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

pkg_config_libs = []
luasdl2_comman_sources = [
  'common/array.c',
  'common/common.c',
  'common/rwops.c',
  'common/surface.c',
  'common/table.c',
  'common/variant.c',
  'common/video.c'
]
luasdl2_sdl2_sources = [
  'src/audio.c',
  'src/channel.c',
  'src/clipboard.c',
  'src/cpu.c',
  'src/display.c',
  'src/events.c',
  'src/filesystem.c',
  'src/gamecontroller.c',
  'src/gl.c',
  'src/haptic.c',
  'src/joystick.c',
  'src/keyboard.c',
  'src/logging.c',
  'src/mouse.c',
  'src/platform.c',
  'src/power.c',
  'src/rectangle.c',
  'src/renderer.c',
  'src/SDL.c',
  'src/texture.c',
  'src/thread.c',
  'src/timer.c',
  'src/window.c'
] + luasdl2_comman_sources

luasdl2_sdl2_image_sources = luasdl2_comman_sources + 'sdl-image/src/image.c'
luasdl2_sdl2_mixer_sources = luasdl2_comman_sources + 'sdl-mixer/src/mixer.c'
luasdl2_sdl2_net_sources = luasdl2_comman_sources + 'sdl-net/src/net.c'
luasdl2_sdl2_ttf_sources = luasdl2_comman_sources + 'sdl-ttf/src/ttf.c'

luasdl2_include = [
  include_directories('.'),
  include_directories('src'),
  include_directories('extern/queue'),
  include_directories('rocks')
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

pkg_config_libs += static_library(
  'lua.SDL',
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

pkg_config_libs += static_library(
  'lua.SDL.image',
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

pkg_config_libs += static_library(
  'lua.SDL.mixer',
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

pkg_config_libs += static_library(
  'lua.SDL.net',
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

pkg_config_libs += static_library(
  'lua.SDL.ttf',
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

data_dir = get_option('libdir') / 'luarocks/rocks-' + lua_ver / 'lua-sdl2/2.0.5-6'
install_data('luarocks/rock_manifest', install_dir: data_dir)

install_data(
  'luarocks/lua-sdl2-2.0.5-6.rockspec',
  install_dir: data_dir
)

install_subdir(
  'examples',
  install_dir: data_dir
)

install_subdir(
  'tutorials',
  install_dir: data_dir
)

# -------------------------------------------------
# PKG CONFIG
# -------------------------------------------------

import('pkgconfig').generate(
  description: 'Lua-SDL2 is a pure C binding of SDL 2.0 for Lua 5.1, JIT, 5.2, and 5.3',
  install_dir: get_option('libdir') / 'lua' / lua_ver + '-static/pkgconfig',
  filebase: 'lua-sdl2',
  libraries: pkg_config_libs,
  name: 'lua-sdl2',
  url: 'https://github.com/Tangent128/luasdl2',
)
