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

lua_cflags = ['-DLUA_COMPAT_5_3']
lua_cflags_shared = []
lua_deps = [cc.find_library('m', required : false)]

if system == 'windows'
  lua_cflags_shared  += '-DLUA_BUILD_AS_DLL'
elif system == 'darwin'
  lua_cflags += '-DLUA_USE_MACOSX'
elif system in ['openbsd', 'netbsd', 'dragonfly']
  lua_cflags += ['-DLUA_USE_POSIX', '-DLUA_USE_DLOPEN']
elif system == 'sunos'
  lua_cflags += ['-DLUA_USE_POSIX', '-DLUA_USE_DLOPEN', '-D_REENTRANT']
endif

if system in ['linux', 'freebsd', 'openbsd', 'netbsd']
  lua_cflags += '-DLUA_USE_LINUX'
endif

if system in ['linux', 'darwin', 'freebsd', 'openbsd', 'netbsd']
  readline = cc.find_library(
    system in ['linux', 'darwin'] ? 'readline' : 'edit',
    required: false
  )

  if readline.found() and get_option('readline')
    lua_cflags += '-DLUA_USE_READLINE'
    lua_deps += readline
  endif
endif

if system in ['linux', 'sunos']
  lua_deps += cc.find_library('dl')
endif

lua_lib = library(
  'lua54',
  [
    'lua-5.4.4/src/lapi.c',
    'lua-5.4.4/src/lcode.c',
    'lua-5.4.4/src/lctype.c',
    'lua-5.4.4/src/ldebug.c',
    'lua-5.4.4/src/ldo.c',
    'lua-5.4.4/src/ldump.c',
    'lua-5.4.4/src/lfunc.c',
    'lua-5.4.4/src/lgc.c',
    'lua-5.4.4/src/llex.c',
    'lua-5.4.4/src/lmem.c',
    'lua-5.4.4/src/lobject.c',
    'lua-5.4.4/src/lopcodes.c',
    'lua-5.4.4/src/lparser.c',
    'lua-5.4.4/src/lstate.c',
    'lua-5.4.4/src/lstring.c',
    'lua-5.4.4/src/ltable.c',
    'lua-5.4.4/src/ltm.c',
    'lua-5.4.4/src/lundump.c',
    'lua-5.4.4/src/lvm.c',
    'lua-5.4.4/src/lzio.c',
    'lua-5.4.4/src/lauxlib.c',
    'lua-5.4.4/src/lbaselib.c',
    'lua-5.4.4/src/lcorolib.c',
    'lua-5.4.4/src/ldblib.c',
    'lua-5.4.4/src/liolib.c',
    'lua-5.4.4/src/lmathlib.c',
    'lua-5.4.4/src/loadlib.c',
    'lua-5.4.4/src/loslib.c',
    'lua-5.4.4/src/lstrlib.c',
    'lua-5.4.4/src/ltablib.c',
    'lua-5.4.4/src/lutf8lib.c',
    'lua-5.4.4/src/linit.c'
  ],
  c_args: lua_cflags + (get_option('default_library') == 'static' ? [] : lua_cflags_shared),
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
    ['lua-5.4.4/src/lua.c'] + res,
    c_args: lua_cflags,
    link_with: lua_lib,
    dependencies: lua_deps,
    install: true
  )

  if get_option('default_library') == 'shared'
    warning('luac won\'t build if default library is set to shared')
  else
    luac = executable(
      'luac',
      ['lua-5.4.4/src/luac.c'] + res,
      c_args: lua_cflags,
      link_with: get_option('default_library') == 'both' ? lua_lib.get_static_lib() : lua_lib,
      dependencies: lua_deps,
      install: true
    )
  endif
endif

install_headers([
    'lua-5.4.4/src/lua.h',
    'lua-5.4.4/src/luaconf.h',
    'lua-5.4.4/src/lualib.h',
    'lua-5.4.4/src/lauxlib.h',
    'lua-5.4.4/src/lua.hpp'
  ],
  subdir: 'lua54'
)
install_man([
  'lua-5.4.4/doc/lua.1',
  'lua-5.4.4/doc/luac.1'
])

lua_dep = declare_dependency(
  dependencies: lua_deps,
  include_directories: include_directories('lua-5.4.4/src'),
  link_with: lua_lib,
)

import('pkgconfig').generate(
  lua_lib,
  filebase: 'lua54',
  name: 'lua54',
  subdirs: 'lua54',
  description: 'Lua 5.4 library'
)
