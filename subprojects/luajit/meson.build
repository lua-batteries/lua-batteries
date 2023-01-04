project(
  'luajit',
  'c',
  version: '2.1.0-beta3',
  license: 'MIT',
  meson_version: '>=0.64.0'
)

cc = meson.get_compiler('c')
cc_id = cc.get_id()
system = host_machine.system()
system_ps3 = false
system_ios = get_option('ios')

luajit_source_dir = include_directories('LuaJIT/src')
libm = cc.find_library('m', required: false) # required on linux and darwin
luajit_dependencies = [
  libm,
  cc.find_library('dl', required: false) # required on linux
]

jitlib_install_dir = get_option('datadir') / 'luajit-' + meson.project_version() / 'jit'

lj_defines = [
  '-D_FILE_OFFSET_BITS=64',
  '-D_LARGEFILE_SOURCE',
  '-U_FORTIFY_SOURCE',
  '-DLUA_MULTILIB="lib"',
  '-DLUA_ROOT="' + get_option('prefix') + '"'
]

if system == 'darwin' and not system_ios
  lj_defines += '-mmacosx-version-min=10.11'
endif

minilua = executable(
  'minilua',
  'LuaJIT/src/host/minilua.c',
  dependencies: libm,
  native: true
)

target_ljarch = ''
buildvm_defines = []

lj_arch_test = '''#include "lj_arch.h"
int main() {
  #if @0@
    return 0;
  #else
    do not compile
  #endif
}'''

if cc.compiles(lj_arch_test.format('defined(LJ_TARGET_X64)'), include_directories: luajit_source_dir)
  target_ljarch = 'x64'
elif cc.compiles(lj_arch_test.format('defined(LJ_TARGET_X86)'), include_directories: luajit_source_dir)
  target_ljarch = 'x86'
elif cc.compiles(lj_arch_test.format('defined(LJ_TARGET_ARM)'), include_directories: luajit_source_dir)
  target_ljarch = 'arm'
elif cc.compiles(lj_arch_test.format('defined(LJ_TARGET_ARM64)'), include_directories: luajit_source_dir)
  if cc.compiles(lj_arch_test.format('defined(__AARCH64EB__)'), include_directories: luajit_source_dir)
    buildvm_defines += '-D__AARCH64EB__=1'
  endif

  target_ljarch = 'arm64'
elif cc.compiles(lj_arch_test.format('defined(LJ_TARGET_PPC)'), include_directories: luajit_source_dir)
  if cc.compiles(lj_arch_test.format('defined(LJ_LE)'), include_directories: luajit_source_dir)
    buildvm_defines += '-DLJ_ARCH_ENDIAN=LUAJIT_LE'
  else
    buildvm_defines += '-DLJ_ARCH_ENDIAN=LUAJIT_BE'
  endif
  
  target_ljarch = 'ppc'
elif cc.compiles(lj_arch_test.format('defined(LJ_TARGET_MIPS)'), include_directories: luajit_source_dir)
  if cc.compiles(lj_arch_test.format('defined(__MIPSEL__)'), include_directories: luajit_source_dir)
    buildvm_defines += '-D__MIPSEL__=1'
  endif

  if cc.compiles(lj_arch_test.format('defined(LJ_TARGET_MIPS64)'), include_directories: luajit_source_dir)
    target_ljarch = 'mips64'
  else
    target_ljarch = 'mips'
  endif
else
  error('Unsupported target architecture')
endif

if cc.compiles(lj_arch_test.format('LJ_TARGET_PS3 == 1'), include_directories: luajit_source_dir)
  system_ps3 = true
  buildvm_defines += '-D__CELLOS_LV2__'
  lj_defines += '-DLUAJIT_USE_SYSMALLOC'
  luajit_dependencies += depedency('threads')
endif

buildvm_defines += '-DLUAJIT_TARGET=LUAJIT_ARCH_@0@'.format(target_ljarch)

if cc.compiles(lj_arch_test.format('LUAJIT_OS == LUAJIT_OS_WINDOWS'), include_directories: luajit_source_dir)
  buildvm_defines += '-DLUAJIT_OS=LUAJIT_OS_WINDOWS'
elif cc.compiles(lj_arch_test.format('LUAJIT_OS == LUAJIT_OS_LINUX'), include_directories: luajit_source_dir)
  buildvm_defines += '-DLUAJIT_OS=LUAJIT_OS_LINUX'
elif cc.compiles(lj_arch_test.format('LUAJIT_OS == LUAJIT_OS_OSX'), include_directories: luajit_source_dir) or system == 'darwin'
  buildvm_defines += '-DLUAJIT_OS=LUAJIT_OS_OSX'
else
  buildvm_defines += '-DLUAJIT_OS=LUAJIT_OS_OTHER'
endif

dasm_arch = target_ljarch
dasm_flags = []

if cc.compiles(lj_arch_test.format('LJ_LE == 1'), include_directories: luajit_source_dir)
  dasm_flags += ['-D', 'ENDIAN_LE']
else
  dasm_flags += ['-D', 'ENDIAN_BE']
endif

if cc.compiles(lj_arch_test.format('LJ_ARCH_BITS == 64'), include_directories: luajit_source_dir)
  dasm_flags += ['-D', 'P64']
elif cc.compiles(lj_arch_test.format('LJ_HASJIT == 1'), include_directories: luajit_source_dir)
  dasm_flags += ['-D', 'JIT']
elif cc.compiles(lj_arch_test.format('LJ_HASFFI == 1'), include_directories: luajit_source_dir)
  dasm_flags += ['-D', 'FFI']
elif cc.compiles(lj_arch_test.format('LJ_DUALNUM == 1'), include_directories: luajit_source_dir)
  dasm_flags += ['-D', 'DUALNUM']
endif

if cc.compiles(lj_arch_test.format('LJ_ABI_SOFTFP == 1'), include_directories: luajit_source_dir)
  dasm_flags += ['-D', 'HFABI']
  buildvm_defines += '-DLJ_ABI_SOFTFP=0'
else
  buildvm_defines += '-DLJ_ABI_SOFTFP=1'
endif

if cc.compiles(lj_arch_test.format('LJ_ARCH_HASFPU == 1'), include_directories: luajit_source_dir)
  dasm_flags += ['-D', 'FPU']
  buildvm_defines += '-DLJ_ARCH_HASFPU=1'
else
  buildvm_defines += '-DLJ_ARCH_HASFPU=0'
endif

if cc.compiles(lj_arch_test.format('LJ_NO_UNWIND == 1'), include_directories: luajit_source_dir)
  dasm_flags += ['-D', 'NO_UNWIND']
  buildvm_defines += '-DLUAJIT_NO_UNWIND'
endif

if cc.compiles(lj_arch_test.format('defined(LJ_ARCH_VERSION)'), include_directories: luajit_source_dir)
  if cc.compiles(lj_arch_test.format('LJ_ARCH_VERSION == 80'), include_directories: luajit_source_dir)
    dasm_flags += ['-D', 'VER=80']
  elif cc.compiles(lj_arch_test.format('LJ_ARCH_VERSION == 70'), include_directories: luajit_source_dir)
    dasm_flags += ['-D', 'VER=70']
  elif cc.compiles(lj_arch_test.format('LJ_ARCH_VERSION == 61'), include_directories: luajit_source_dir)
    dasm_flags += ['-D', 'VER=61']
  elif cc.compiles(lj_arch_test.format('LJ_ARCH_VERSION == 60'), include_directories: luajit_source_dir)
    dasm_flags += ['-D', 'VER=60']
  elif cc.compiles(lj_arch_test.format('LJ_ARCH_VERSION == 50'), include_directories: luajit_source_dir)
    dasm_flags += ['-D', 'VER=50']
  elif cc.compiles(lj_arch_test.format('LJ_ARCH_VERSION == 40'), include_directories: luajit_source_dir)
    dasm_flags += ['-D', 'VER=40']
  elif cc.compiles(lj_arch_test.format('LJ_ARCH_VERSION == 20'), include_directories: luajit_source_dir)
    dasm_flags += ['-D', 'VER=20']
  elif cc.compiles(lj_arch_test.format('LJ_ARCH_VERSION == 10'), include_directories: luajit_source_dir)
    dasm_flags += ['-D', 'VER=10']
  elif cc.compiles(lj_arch_test.format('LJ_ARCH_VERSION == 0'), include_directories: luajit_source_dir)
    dasm_flags += ['-D', 'VER=0']
  else
    dasm_flags += ['-D', 'VER=']
  endif
else
  dasm_flags += ['-D', 'VER=']
endif

if system == 'windows'
  dasm_flags += ['-D', 'WIN']
endif

if target_ljarch == 'x64'
  if cc.compiles(lj_arch_test.format('LJ_FR2 == 1'), include_directories: luajit_source_dir)
    dasm_arch = 'x86'
  else
    buildvm_defines += '-DLUAJIT_ENABLE_GC64'
    lj_defines += '-DLUAJIT_ENABLE_GC64'
  endif
elif system_ios
  dasm_arch = ['-D', 'IOS']
elif target_ljarch == 'ppc'
  if cc.compiles(lj_arch_test.format('LJ_ARCH_SQRT == 1'), include_directories: luajit_source_dir)
    dasm_flags += ['-D', 'SQRT']
  endif

  if cc.compiles(lj_arch_test.format('LJ_ARCH_ROUND == 1'), include_directories: luajit_source_dir)
    dasm_flags += ['-D', 'ROUND']
  endif

  if cc.compiles(lj_arch_test.format('LJ_ARCH_PPC32ON64 == 1'), include_directories: luajit_source_dir)
    dasm_flags += ['-D', 'GPR64']
  endif

  if system_ps3
    dasm_flags += ['-D', 'PPE', '-D', 'TOC']
  endif

  if cc.compiles(lj_arch_test.format('defined(LJ_ARCH_PPC64)'), include_directories: luajit_source_dir)
    # dasm_arch = 'ppc64'
    warning('Using 32-bit mode on 64-bit PowerPC')
  endif
endif

message('Target luajit arch: ' + target_ljarch)
message('Target dasm arch: vm_' + dasm_arch + '.dasc')
message('Creating "buildvm_arch.h" with "@0@"'.format(' '.join(dasm_flags)))

buildvm_arch_h = custom_target(
  'buildvm_arch.h',
  input: 'LuaJIT/src/vm_' + dasm_arch + '.dasc',
  output: 'buildvm_arch.h',
  command: [
    minilua,
    files('LuaJIT/dynasm/dynasm.lua'),
    dasm_flags,
    '-o', '@OUTPUT@', '@INPUT@'
  ]
)

message('Building "buildvm" with "@0@"'.format(' '.join(buildvm_defines)))

buildvm = executable('buildvm',
  [
    'LuaJIT/src/host/buildvm.c',
    'LuaJIT/src/host/buildvm_asm.c',
    'LuaJIT/src/host/buildvm_fold.c',
    'LuaJIT/src/host/buildvm_lib.c',
    'LuaJIT/src/host/buildvm_peobj.c',
    buildvm_arch_h
  ],
  include_directories: luajit_source_dir,
  c_args: buildvm_defines,
  dependencies: libm,
  native: true
)

ljlib_sources = [
  'LuaJIT/src/lib_base.c',
  'LuaJIT/src/lib_bit.c',
  'LuaJIT/src/lib_debug.c',
  'LuaJIT/src/lib_ffi.c',
  'LuaJIT/src/lib_io.c',
  'LuaJIT/src/lib_jit.c',
  'LuaJIT/src/lib_math.c',
  'LuaJIT/src/lib_os.c',
  'LuaJIT/src/lib_package.c',
  'LuaJIT/src/lib_string.c',
  'LuaJIT/src/lib_table.c'
]

ljcore_sources = [
  'LuaJIT/src/lib_aux.c',
  'LuaJIT/src/lib_init.c',
  'LuaJIT/src/lj_alloc.c',
  'LuaJIT/src/lj_api.c',
  'LuaJIT/src/lj_asm.c',
  'LuaJIT/src/lj_bc.c',
  'LuaJIT/src/lj_bcread.c',
  'LuaJIT/src/lj_bcwrite.c',
  'LuaJIT/src/lj_buf.c',
  'LuaJIT/src/lj_carith.c',
  'LuaJIT/src/lj_ccall.c',
  'LuaJIT/src/lj_ccallback.c',
  'LuaJIT/src/lj_cconv.c',
  'LuaJIT/src/lj_cdata.c',
  'LuaJIT/src/lj_char.c',
  'LuaJIT/src/lj_clib.c',
  'LuaJIT/src/lj_cparse.c',
  'LuaJIT/src/lj_crecord.c',
  'LuaJIT/src/lj_ctype.c',
  'LuaJIT/src/lj_debug.c',
  'LuaJIT/src/lj_dispatch.c',
  'LuaJIT/src/lj_err.c',
  'LuaJIT/src/lj_ffrecord.c',
  'LuaJIT/src/lj_func.c',
  'LuaJIT/src/lj_gc.c',
  'LuaJIT/src/lj_gdbjit.c',
  'LuaJIT/src/lj_ir.c',
  'LuaJIT/src/lj_lex.c',
  'LuaJIT/src/lj_lib.c',
  'LuaJIT/src/lj_load.c',
  'LuaJIT/src/lj_mcode.c',
  'LuaJIT/src/lj_meta.c',
  'LuaJIT/src/lj_obj.c',
  'LuaJIT/src/lj_opt_dce.c',
  'LuaJIT/src/lj_opt_fold.c',
  'LuaJIT/src/lj_opt_loop.c',
  'LuaJIT/src/lj_opt_mem.c',
  'LuaJIT/src/lj_opt_narrow.c',
  'LuaJIT/src/lj_opt_sink.c',
  'LuaJIT/src/lj_opt_split.c',
  'LuaJIT/src/lj_parse.c',
  'LuaJIT/src/lj_profile.c',
  'LuaJIT/src/lj_record.c',
  'LuaJIT/src/lj_snap.c',
  'LuaJIT/src/lj_state.c',
  'LuaJIT/src/lj_str.c',
  'LuaJIT/src/lj_strfmt.c',
  'LuaJIT/src/lj_strfmt_num.c',
  'LuaJIT/src/lj_strscan.c',
  'LuaJIT/src/lj_tab.c',
  'LuaJIT/src/lj_trace.c',
  'LuaJIT/src/lj_udata.c',
  'LuaJIT/src/lj_vmevent.c',
  'LuaJIT/src/lj_vmmath.c'
]

lj_linkargs = []

if system == 'windows'
  ljcore_sources += custom_target(
    'lj_vm.obj',
    input: [],
    output: 'lj_vm.obj',
    command: [buildvm, '-m', 'peobj', '-o', '@OUTPUT@']
  )

  if get_option('default_library') != 'static'
    lj_defines += '-DLUA_BUILD_AS_DLL'
  endif
elif system == 'darwin'
  ljcore_sources += custom_target(
    'lj_vm.s',
    input : [],
    output : 'lj_vm.s',
    command : [buildvm, '-m', 'machasm', '-o', '@OUTPUT@']
  )

  if target_ljarch == 'x64' and not system_ios
    lj_linkargs += ['-pagezero_size', '10000', '-image_base', '100000000']
  endif
else
  ljcore_sources += custom_target(
    'lj_vm.s',
    input : [],
    output : 'lj_vm.s',
    command : [buildvm, '-m', 'elfasm', '-o', '@OUTPUT@']
  )
endif

buildvm_headers = []

foreach target: [
    {'mode': 'bcdef',   'input': ljlib_sources,              'output': 'lj_bcdef.h'},
    {'mode': 'ffdef',   'input': ljlib_sources,              'output': 'lj_ffdef.h'},
    {'mode': 'folddef', 'input': 'LuaJIT/src/lj_opt_fold.c', 'output': 'lj_folddef.h'},
    {'mode': 'libdef',  'input': ljlib_sources,              'output': 'lj_libdef.h'},
    {'mode': 'recdef',  'input': ljlib_sources,              'output': 'lj_recdef.h'}
  ]
  buildvm_headers += custom_target(
    target['output'],
    input: target['input'],
    output: target['output'],
    command: [buildvm, '-m', target['mode'], '-o', '@OUTPUT@', '@INPUT@']
  )
endforeach

vmdef = custom_target(
  'vmdef.lua',
  input: ljlib_sources,
  output: 'vmdef.lua',
  build_by_default: true,
  install: true,
  install_dir: jitlib_install_dir,
  command: [buildvm, '-m', 'vmdef', '-o', '@OUTPUT@', '@INPUT@']
)

libluajit = library(
  'luajit-5.1',
  ljlib_sources + ljcore_sources + buildvm_headers,
  c_args: lj_defines,
  include_directories: luajit_source_dir,
  dependencies: luajit_dependencies,
  pic: true,
  install: true
)

if get_option('apps')
  res = []
  
  if system == 'windows' and get_option('icons') and cc_id not in ['clang', 'clang-cl']
    res += import('windows').compile_resources(
      'luajit.rc',
      depend_files: 'luajit.ico'
    )
  endif

  # install_rpath
  luajit = executable(
    'luajit',
    ['LuaJIT/src/luajit.c'] + res,
    c_args: lj_defines,
    include_directories: luajit_source_dir,
    link_args: lj_linkargs,
    link_with: libluajit,
    dependencies: luajit_dependencies,
    install: true
  )
endif

luajit_dep = declare_dependency(
  dependencies: luajit_dependencies,
  include_directories: luajit_source_dir,
  link_with: libluajit,
  link_args: lj_linkargs,
)

install_headers(
  [
    'LuaJIT/src/lua.h',
    'LuaJIT/src/lualib.h',
    'LuaJIT/src/lauxlib.h',
    'LuaJIT/src/luaconf.h',
    'LuaJIT/src/lua.hpp',
    'LuaJIT/src/luajit.h'
  ],
  subdir: 'luajit-2.1'
)

if get_option('apps')
  install_data(
    [
      'LuaJIT/src/jit/bc.lua',
      'LuaJIT/src/jit/bcsave.lua',
      'LuaJIT/src/jit/dis_arm.lua',
      'LuaJIT/src/jit/dis_arm64.lua',
      'LuaJIT/src/jit/dis_arm64be.lua',
      'LuaJIT/src/jit/dis_mips.lua',
      'LuaJIT/src/jit/dis_mips64.lua',
      'LuaJIT/src/jit/dis_mips64el.lua',
      'LuaJIT/src/jit/dis_mipsel.lua',
      'LuaJIT/src/jit/dis_ppc.lua',
      'LuaJIT/src/jit/dis_x64.lua',
      'LuaJIT/src/jit/dis_x86.lua',
      'LuaJIT/src/jit/dump.lua',
      'LuaJIT/src/jit/p.lua',
      'LuaJIT/src/jit/v.lua',
      'LuaJIT/src/jit/zone.lua'
    ],
    install_dir: jitlib_install_dir
  )
endif

install_man('LuaJIT/etc/luajit.1')
install_data(
  'LuaJIT/COPYRIGHT',
  install_dir: jitlib_install_dir / '..'
)

import('pkgconfig').generate(
  libluajit,
  name: 'LuaJIT',
  description: 'Just-in-time compiler for Lua',
  url: 'http://luajit.org',
  filebase: 'luajit',
  subdirs: 'luajit-2.1'
)
