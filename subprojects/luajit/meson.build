project(
  'luajit',
  'c',
  version: '2.0.5',
  license: 'MIT',
  default_options: [
    'default_library=both'
  ],
  meson_version: '>=0.63.0'
)

cc = meson.get_compiler('c')
cc_id = cc.get_id()
system = host_machine.system()

run_command('git', 'apply', 'lua-meson-updated-lua-search-path-on-windows.patch', check: true)

luajit_source_dir = include_directories('LuaJIT/src')
libm = cc.find_library('m', required: false)
luajit_dependencies = [
  libm,
  cc.find_library('dl', required: false)
]

jitlib_install_dir = get_option('portable') ? (get_option('bindir') / 'lua' / 'jit') : ('share' / ( 'luajit-' + meson.project_version() ) / 'jit')

minilua = executable(
  'minilua',
  'LuaJIT/src/host/minilua.c',
  dependencies: libm,
  native: true
)

lj_arch_run = cc.run(files('lj_arch_test.c'), include_directories: luajit_source_dir)

if not lj_arch_run.compiled() or lj_arch_run.returncode() != 0
  error('error running luajit arch testing program: ' + lj_arch_run.stderr())
endif

lj_arch_list = lj_arch_run.stdout().split(':')

foreach line: lj_arch_list
  message(line)
endforeach

dasm_arch = lj_arch_list[1]
buildvm_defines = lj_arch_list[2].split(',')

buildvm_arch_h = custom_target(
  'buildvm_arch.h',
  input: 'LuaJIT/src/vm_' + dasm_arch + '.dasc',
  output: 'buildvm_arch.h',
  command: [
    minilua,
    files('LuaJIT/dynasm/dynasm.lua'),
    lj_arch_list[3].split(','),
    '-o', '@OUTPUT@', '@INPUT@'
  ]
)

buildvm = executable('buildvm',
  [
    'LuaJIT/src/host/buildvm.c',
    'LuaJIT/src/host/buildvm_asm.c',
    'LuaJIT/src/host/buildvm_peobj.c',
    'LuaJIT/src/host/buildvm_lib.c',
    'LuaJIT/src/host/buildvm_fold.c',
    buildvm_arch_h
  ],
  include_directories: luajit_source_dir,
  c_args: buildvm_defines,
  dependencies: libm,
  native: true
)

ljlib_sources = [
  'LuaJIT/src/lib_base.c', 
  'LuaJIT/src/lib_math.c', 
  'LuaJIT/src/lib_bit.c', 
  'LuaJIT/src/lib_string.c', 
  'LuaJIT/src/lib_table.c', 
  'LuaJIT/src/lib_io.c', 
  'LuaJIT/src/lib_os.c', 
  'LuaJIT/src/lib_package.c', 
  'LuaJIT/src/lib_debug.c', 
  'LuaJIT/src/lib_jit.c', 
  'LuaJIT/src/lib_ffi.c'
]
ljcore_sources = [
  'LuaJIT/src/lj_gc.c', 
  'LuaJIT/src/lj_err.c', 
  'LuaJIT/src/lj_char.c', 
  'LuaJIT/src/lj_bc.c', 
  'LuaJIT/src/lj_obj.c', 
  'LuaJIT/src/lj_str.c', 
  'LuaJIT/src/lj_tab.c', 
  'LuaJIT/src/lj_func.c', 
  'LuaJIT/src/lj_udata.c', 
  'LuaJIT/src/lj_meta.c', 
  'LuaJIT/src/lj_debug.c', 
  'LuaJIT/src/lj_state.c', 
  'LuaJIT/src/lj_dispatch.c', 
  'LuaJIT/src/lj_vmevent.c', 
  'LuaJIT/src/lj_vmmath.c', 
  'LuaJIT/src/lj_strscan.c', 
  'LuaJIT/src/lj_api.c', 
  'LuaJIT/src/lj_lex.c', 
  'LuaJIT/src/lj_parse.c', 
  'LuaJIT/src/lj_bcread.c', 
  'LuaJIT/src/lj_bcwrite.c', 
  'LuaJIT/src/lj_load.c', 
  'LuaJIT/src/lj_ir.c', 
  'LuaJIT/src/lj_opt_mem.c',
  'LuaJIT/src/lj_opt_fold.c',
  'LuaJIT/src/lj_opt_narrow.c',
  'LuaJIT/src/lj_opt_dce.c',
  'LuaJIT/src/lj_opt_loop.c',
  'LuaJIT/src/lj_opt_split.c',
  'LuaJIT/src/lj_opt_sink.c',
  'LuaJIT/src/lj_mcode.c',
  'LuaJIT/src/lj_snap.c',
  'LuaJIT/src/lj_record.c',
  'LuaJIT/src/lj_crecord.c',
  'LuaJIT/src/lj_ffrecord.c',
  'LuaJIT/src/lj_asm.c',
  'LuaJIT/src/lj_trace.c',
  'LuaJIT/src/lj_gdbjit.c',
  'LuaJIT/src/lj_ctype.c',
  'LuaJIT/src/lj_cdata.c',
  'LuaJIT/src/lj_cconv.c',
  'LuaJIT/src/lj_ccall.c',
  'LuaJIT/src/lj_ccallback.c',
  'LuaJIT/src/lj_carith.c',
  'LuaJIT/src/lj_clib.c',
  'LuaJIT/src/lj_cparse.c',
  'LuaJIT/src/lj_lib.c',
  'LuaJIT/src/lj_alloc.c',
  'LuaJIT/src/lib_aux.c',
  'LuaJIT/src/lib_init.c'
]

buildvm_commands = [
  {'mode': 'ffdef',   'input': ljlib_sources,              'output': 'lj_ffdef.h'},
  {'mode': 'bcdef',   'input': ljlib_sources,              'output': 'lj_bcdef.h'},
  {'mode': 'folddef', 'input': 'LuaJIT/src/lj_opt_fold.c', 'output': 'lj_folddef.h'},
  {'mode': 'recdef',  'input': ljlib_sources,              'output': 'lj_recdef.h'},
  {'mode': 'libdef',  'input': ljlib_sources,              'output': 'lj_libdef.h'}
]

lj_defines = [
  '-D_FILE_OFFSET_BITS=64',
  '-D_LARGEFILE_SOURCE',
  '-U_FORTIFY_SOURCE',
  '-DLUA_MULTILIB="lib"',
  '-DLUA_ROOT="' + get_option('prefix') + '"'
]

if system == 'darwin'
  lj_defines += '-mmacosx-version-min=10.11'
endif

if get_option('portable')
  lj_defines += '-DLUAJIT_PORTABLE_INSTALL'
endif

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
  lj_linkargs += ['-pagezero_size', '10000', '-image_base', '100000000']
else
  ljcore_sources += custom_target(
    'lj_vm.s',
    input : [],
    output : 'lj_vm.s',
    command : [buildvm, '-m', 'elfasm', '-o', '@OUTPUT@']
  )
endif

buildvm_headers = []

foreach target: buildvm_commands
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
  build_by_default : true,
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
  subdir: 'luajit-2.0'
)

if get_option('apps')
  install_data(
    [
      'LuaJIT/src/jit/bc.lua',
      'LuaJIT/src/jit/v.lua',
      'LuaJIT/src/jit/dump.lua',
      'LuaJIT/src/jit/dis_x86.lua',
      'LuaJIT/src/jit/dis_x64.lua',
      'LuaJIT/src/jit/dis_arm.lua',
      'LuaJIT/src/jit/dis_ppc.lua',
      'LuaJIT/src/jit/dis_mips.lua',
      'LuaJIT/src/jit/dis_mipsel.lua',
      'LuaJIT/src/jit/bcsave.lua'
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
  subdirs: 'luajit-2.0'
)
