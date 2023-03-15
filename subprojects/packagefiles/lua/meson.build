project(
  'lua',
  'c',
  version: '5.4.4',
  license: 'MIT',
  default_options: ['c_std=gnu99'],
  meson_version: '>=0.64.0'
)

cc = meson.get_compiler('c')
cc_id = cc.get_id()
system = host_machine.system()

lua_defines = ['-DLUA_COMPAT_5_3']
lua_defines_shared = []
lua_deps = [cc.find_library('m', required: false)]

if system == 'aix'
  lua_defines += ['-DLUA_USE_POSIX', '-DLUA_USE_DLOPEN']
  lua_deps += cc.find_library('dl')
elif system in ['freebsd', 'openbsd', 'netbsd']
  lua_defines += '-DLUA_USE_LINUX'
elif system in ['android', 'linux']
  lua_defines += '-DLUA_USE_LINUX'
  lua_deps += cc.find_library('dl')
elif system == 'darwin'
  lua_defines += '-DLUA_USE_MACOSX'
elif system == 'windows' and get_option('default_library') != 'static'
  lua_defines  += '-DLUA_BUILD_AS_DLL'
elif system == 'sunos'
  lua_defines += ['-DLUA_USE_POSIX', '-DLUA_USE_DLOPEN', '-D_REENTRANT']
  lua_deps += cc.find_library('dl')
else
  lua_defines += '-DLUA_USE_POSIX'
endif

if system in ['freebsd', 'openbsd', 'netbsd']
  edit = cc.find_library('edit', required: false)

  if edit.found()
    lua_defines += '-DLUA_USE_READLINE'
    lua_deps += edit
  endif
elif system in ['android', 'linux', 'darwin']
  readline = cc.find_library('readline', required: false)

  if readline.found()
    lua_defines += '-DLUA_USE_READLINE'
    lua_deps += readline
  endif
endif

lua_lib = library(
  'lua54',
  [
    'src/lapi.c',
    'src/lauxlib.c',
    'src/lbaselib.c',
    'src/lcode.c',
    'src/lcorolib.c',
    'src/lctype.c',
    'src/ldblib.c',
    'src/ldebug.c',
    'src/ldo.c',
    'src/ldump.c',
    'src/lfunc.c',
    'src/lgc.c',
    'src/linit.c',
    'src/liolib.c',
    'src/llex.c',
    'src/lmathlib.c',
    'src/lmem.c',
    'src/loadlib.c',
    'src/lobject.c',
    'src/lopcodes.c',
    'src/loslib.c',
    'src/lparser.c',
    'src/lstate.c',
    'src/lstring.c',
    'src/lstrlib.c',
    'src/ltable.c',
    'src/ltablib.c',
    'src/ltm.c',
    'src/lundump.c',
    'src/lutf8lib.c',
    'src/lvm.c',
    'src/lzio.c'
  ],
  c_args: lua_defines,
  dependencies: lua_deps,
  pic: true,
  install: true
)

if get_option('apps')
  res = []
  
  if system == 'windows' and get_option('icons') and cc_id not in ['clang', 'clang-cl']
    res += import('windows').compile_resources(
      'lua.rc',
      depend_files: 'lua.ico'
    )
  endif

  lua = executable(
    'lua',
    ['src/lua.c'] + res,
    c_args: lua_defines,
    link_with: lua_lib,
    dependencies: lua_deps,
    install: true
  )

  if get_option('default_library') == 'shared'
    warning('luac won\'t build if default library is set to shared')
  else
    luac = executable(
      'luac',
      ['src/luac.c'] + res,
      c_args: lua_defines,
      link_with: get_option('default_library') == 'both' ? lua_lib.get_static_lib() : lua_lib,
      dependencies: lua_deps,
      install: true
    )
  endif
endif

install_headers([
    'src/lua.h',
    'src/luaconf.h',
    'src/lualib.h',
    'src/lauxlib.h',
    'src/lua.hpp'
  ],
  subdir: 'lua54'
)
install_man([
  'doc/lua.1',
  'doc/luac.1'
])

lua_dep = declare_dependency(
  dependencies: lua_deps,
  include_directories: include_directories('src'),
  link_with: lua_lib,
)

import('pkgconfig').generate(
  lua_lib,
  filebase: 'lua54',
  name: 'lua54',
  subdirs: 'lua54',
  description: 'Lua 5.4 library'
)
