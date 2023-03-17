project(
  'luaposix',
  'c',
  version: '36.1',
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

pkg_config_libs = []
luaposix_defines = [
  '-DPACKAGE="@0@"'.format(meson.project_name()),
  '-DVERSION="@0@"'.format(meson.project_version()),
  '-DNDEBUG'
]

if system == 'aix'
  luaposix_defines += '-D_ALL_SOURCE'
elif system == 'netbsd' or system == 'openbsd'
  luaposix_defines += '-D_BSD_SOURCE'
elif system == 'freebsd'
  luaposix_defines += '-D__BSD_VISIBLE'
elif system == 'linux' or system == 'android'
  luaposix_defines += ['-D_BSD_SOURCE', '-D_DEFAULT_SOURCE']
elif system == 'darwin'
  luaposix_defines += '-D_DARWIN_C_SOURCE'
elif system == 'qnx'
  luaposix_defines += '-D_POSIX_C_SOURCE'
endif

if system not in ['cygwin', 'haiku', 'windows']
  luaposix_defines += ['-D_POSIX_C_SOURCE=200809L', '-D_XOPEN_SOURCE=700']
else
  luaposix_defines += '-D_POSIX_C_SOURCE=200809L'
endif

luaposix_includes = [
  include_directories('ext/include')
]
luaposix_shared_dir = get_option('libdir') / 'lua' / lua_ver / 'posix'
luaposix_shared_sys_dir = get_option('libdir') / 'lua' / lua_ver / 'posix/sys'
luaposix_static_dir = get_option('libdir') / 'lua' / lua_ver + '-static'

posix_fcntl_defines = []

if cc.has_function('posix_fadvise')
  posix_fcntl_defines += '-DHAVE_POSIX_FADVISE'
endif

posix_sched_defines = []

if cc.has_header('sched.h')
  posix_sched_defines += '-DHAVE_SCHED_H'
endif

if cc.has_function('sched_getscheduler')
  posix_sched_defines += '-DHAVE_SCHED_GETSCHEDULER'
endif

if cc.has_function('sched_setscheduler')
  posix_sched_defines += '-DHAVE_SCHED_SETSCHEDULER'
endif

posix_sys_msg_defines = []

if cc.has_header('sys/msg.h')
  posix_sys_msg_defines += '-DHAVE_SYS_MSG_H'
endif

if cc.has_function('msgrcv')
  posix_sys_msg_defines += '-DHAVE_MSGRCV'
endif

if cc.has_function('msgsnd')
  posix_sys_msg_defines += '-DHAVE_MSGSND'
endif

posix_sys_socket_defines = []

if cc.has_header('net/if.h')
  posix_sys_socket_defines += '-DHAVE_NET_IF_H'
endif

if cc.has_header('linux/netlink.h')
  posix_sys_socket_defines += '-DHAVE_LINUX_NETLINK_H'
endif

if cc.has_header('linux/if_packet.h')
  posix_sys_socket_defines += '-DHAVE_LINUX_IF_PACKET_H'
endif

posix_sys_socket_dep = cc.find_library('socket', required: false) # checksymbol='socket'
posix_sys_statvfs_defines = []

if cc.has_function('statvfs')
  posix_sys_statvfs_defines += '-DHAVE_STATVFS'
endif

posix_time_defines = []

if cc.has_member('struct tm', 'tm_gmtoff', prefix: '#include <time.h>')
  posix_time_defines += '-DHAVE_TM_GMTOFF'
endif

if cc.has_member('struct tm', 'tm_zone', prefix: '#include <time.h>')
  posix_time_defines += '-DHAVE_TM_ZONE'
endif

posix_time_dep = []

if cc.has_header_symbol('unistd.h', '_POSIX_TIMERS') and (cc.has_function('clock_gettime', prefix: '#include <time.h>') or cc.has_header_symbol('time.h', 'clock_gettime'))
  posix_time_dep += cc.find_library('rt', required: false)
endif

posix_unistd_defines = []

if cc.has_function('crypt')
  posix_unistd_defines += '-DHAVE_CRYPT'
endif

if cc.has_header('crypt.h')
  posix_unistd_defines += '-DHAVE_CRYPT_H'

  if (cc.has_function('crypt', prefix: '#include <crypt.h>') or cc.has_header_symbol('crypt.h', 'crypt')) and '-DHAVE_CRYPT' not in posix_unistd_defines
    posix_unistd_defines += '-DHAVE_CRYPT'
  endif
endif

if cc.has_function('fdatasync', prefix: '#include <unistd.h>') or cc.has_header_symbol('unistd.h', 'fdatasync')
  posix_unistd_defines += '-DHAVE_DECL_FDATASYNC'
  posix_unistd_defines += '-DHAVE_FDATASYNC'
endif

if cc.has_function('gethostid')
  posix_unistd_defines += '-DHAVE_GETHOSTID'
endif

posix_unistd_dep = cc.find_library('crypt', required: false) # checksymbol='crypt'

shared_module(
  'ctype',
  'ext/posix/ctype.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  name_prefix: '',
  name_suffix: module_suffix,
  install: true,
  install_dir: luaposix_shared_dir
)

pkg_config_libs += static_library(
  'lua.posix.ctype',
  'ext/posix/ctype.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  pic: true,
  install: true,
  install_dir: luaposix_static_dir
)

shared_module(
  'dirent',
  'ext/posix/dirent.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  name_prefix: '',
  name_suffix: module_suffix,
  install: true,
  install_dir: luaposix_shared_dir
)

pkg_config_libs += static_library(
  'lua.posix.dirent',
  'ext/posix/dirent.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  pic: true,
  install: true,
  install_dir: luaposix_static_dir
)

shared_module(
  'errno',
  'ext/posix/errno.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  name_prefix: '',
  name_suffix: module_suffix,
  install: true,
  install_dir: luaposix_shared_dir
)

pkg_config_libs += static_library(
  'lua.posix.errno',
  'ext/posix/errno.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  pic: true,
  install: true,
  install_dir: luaposix_static_dir
)

shared_module(
  'fcntl',
  'ext/posix/fcntl.c',
  c_args: luaposix_defines + posix_fcntl_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  name_prefix: '',
  name_suffix: module_suffix,
  install: true,
  install_dir: luaposix_shared_dir
)

pkg_config_libs += static_library(
  'lua.posix.fcntl',
  'ext/posix/fcntl.c',
  c_args: luaposix_defines + posix_fcntl_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  pic: true,
  install: true,
  install_dir: luaposix_static_dir
)

shared_module(
  'fnmatch',
  'ext/posix/fnmatch.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  name_prefix: '',
  name_suffix: module_suffix,
  install: true,
  install_dir: luaposix_shared_dir
)

pkg_config_libs += static_library(
  'lua.posix.fnmatch',
  'ext/posix/fnmatch.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  pic: true,
  install: true,
  install_dir: luaposix_static_dir
)

shared_module(
  'glob',
  'ext/posix/glob.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  name_prefix: '',
  name_suffix: module_suffix,
  install: true,
  install_dir: luaposix_shared_dir
)

pkg_config_libs += static_library(
  'lua.posix.glob',
  'ext/posix/glob.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  pic: true,
  install: true,
  install_dir: luaposix_static_dir
)

shared_module(
  'grp',
  'ext/posix/grp.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  name_prefix: '',
  name_suffix: module_suffix,
  install: true,
  install_dir: luaposix_shared_dir
)

pkg_config_libs += static_library(
  'lua.posix.grp',
  'ext/posix/grp.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  pic: true,
  install: true,
  install_dir: luaposix_static_dir
)

shared_module(
  'libgen',
  'ext/posix/libgen.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  name_prefix: '',
  name_suffix: module_suffix,
  install: true,
  install_dir: luaposix_shared_dir
)

pkg_config_libs += static_library(
  'lua.posix.libgen',
  'ext/posix/libgen.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  pic: true,
  install: true,
  install_dir: luaposix_static_dir
)

shared_module(
  'poll',
  'ext/posix/poll.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  name_prefix: '',
  name_suffix: module_suffix,
  install: true,
  install_dir: luaposix_shared_dir
)

pkg_config_libs += static_library(
  'lua.posix.poll',
  'ext/posix/poll.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  pic: true,
  install: true,
  install_dir: luaposix_static_dir
)

shared_module(
  'pwd',
  'ext/posix/pwd.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  name_prefix: '',
  name_suffix: module_suffix,
  install: true,
  install_dir: luaposix_shared_dir
)

pkg_config_libs += static_library(
  'lua.posix.pwd',
  'ext/posix/pwd.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  pic: true,
  install: true,
  install_dir: luaposix_static_dir
)

shared_module(
  'sched',
  'ext/posix/sched.c',
  c_args: luaposix_defines + posix_sched_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  name_prefix: '',
  name_suffix: module_suffix,
  install: true,
  install_dir: luaposix_shared_dir
)

pkg_config_libs += static_library(
  'lua.posix.sched',
  'ext/posix/sched.c',
  c_args: luaposix_defines + posix_sched_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  pic: true,
  install: true,
  install_dir: luaposix_static_dir
)

shared_module(
  'signal',
  'ext/posix/signal.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  name_prefix: '',
  name_suffix: module_suffix,
  install: true,
  install_dir: luaposix_shared_dir
)

pkg_config_libs += static_library(
  'lua.posix.signal',
  'ext/posix/signal.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  pic: true,
  install: true,
  install_dir: luaposix_static_dir
)

shared_module(
  'stdio',
  'ext/posix/stdio.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  name_prefix: '',
  name_suffix: module_suffix,
  install: true,
  install_dir: luaposix_shared_dir
)

pkg_config_libs += static_library(
  'lua.posix.stdio',
  'ext/posix/stdio.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  pic: true,
  install: true,
  install_dir: luaposix_static_dir
)

shared_module(
  'stdlib',
  'ext/posix/stdlib.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  name_prefix: '',
  name_suffix: module_suffix,
  install: true,
  install_dir: luaposix_shared_dir
)

pkg_config_libs += static_library(
  'lua.posix.stdlib',
  'ext/posix/stdlib.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  pic: true,
  install: true,
  install_dir: luaposix_static_dir
)

shared_module(
  'msg',
  'ext/posix/sys/msg.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  name_prefix: '',
  name_suffix: module_suffix,
  install: true,
  install_dir: luaposix_shared_sys_dir
)

pkg_config_libs += static_library(
  'lua.posix.sys.msg',
  'ext/posix/sys/msg.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  pic: true,
  install: true,
  install_dir: luaposix_static_dir
)

shared_module(
  'resource',
  'ext/posix/sys/resource.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  name_prefix: '',
  name_suffix: module_suffix,
  install: true,
  install_dir: luaposix_shared_sys_dir
)

pkg_config_libs += static_library(
  'lua.posix.sys.resource',
  'ext/posix/sys/resource.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  pic: true,
  install: true,
  install_dir: luaposix_static_dir
)

shared_module(
  'socket',
  'ext/posix/sys/socket.c',
  c_args: luaposix_defines + posix_sys_socket_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps + posix_sys_socket_dep,
  name_prefix: '',
  name_suffix: module_suffix,
  install: true,
  install_dir: luaposix_shared_sys_dir
)

pkg_config_libs += static_library(
  'lua.posix.sys.socket',
  'ext/posix/sys/socket.c',
  c_args: luaposix_defines + posix_sys_socket_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps + posix_sys_socket_dep,
  pic: true,
  install: true,
  install_dir: luaposix_static_dir
)

shared_module(
  'stat',
  'ext/posix/sys/stat.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  name_prefix: '',
  name_suffix: module_suffix,
  install: true,
  install_dir: luaposix_shared_sys_dir
)

pkg_config_libs += static_library(
  'lua.posix.sys.stat',
  'ext/posix/sys/stat.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  pic: true,
  install: true,
  install_dir: luaposix_static_dir
)

shared_module(
  'statvfs',
  'ext/posix/sys/statvfs.c',
  c_args: luaposix_defines + posix_sys_statvfs_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  name_prefix: '',
  name_suffix: module_suffix,
  install: true,
  install_dir: luaposix_shared_sys_dir
)

pkg_config_libs += static_library(
  'lua.posix.sys.statvfs',
  'ext/posix/sys/statvfs.c',
  c_args: luaposix_defines + posix_sys_statvfs_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  pic: true,
  install: true,
  install_dir: luaposix_static_dir
)

shared_module(
  'time',
  'ext/posix/sys/time.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  name_prefix: '',
  name_suffix: module_suffix,
  install: true,
  install_dir: luaposix_shared_sys_dir
)

pkg_config_libs += static_library(
  'lua.posix.sys.time',
  'ext/posix/sys/time.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  pic: true,
  install: true,
  install_dir: luaposix_static_dir
)

shared_module(
  'times',
  'ext/posix/sys/stat.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  name_prefix: '',
  name_suffix: module_suffix,
  install: true,
  install_dir: luaposix_shared_sys_dir
)

pkg_config_libs += static_library(
  'lua.posix.sys.times',
  'ext/posix/sys/times.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  pic: true,
  install: true,
  install_dir: luaposix_static_dir
)

shared_module(
  'utsname',
  'ext/posix/sys/utsname.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  name_prefix: '',
  name_suffix: module_suffix,
  install: true,
  install_dir: luaposix_shared_sys_dir
)

pkg_config_libs += static_library(
  'lua.posix.sys.utsname',
  'ext/posix/sys/utsname.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  pic: true,
  install: true,
  install_dir: luaposix_static_dir
)

shared_module(
  'wait',
  'ext/posix/sys/wait.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  name_prefix: '',
  name_suffix: module_suffix,
  install: true,
  install_dir: luaposix_shared_sys_dir
)

pkg_config_libs += static_library(
  'lua.posix.sys.wait',
  'ext/posix/sys/wait.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  pic: true,
  install: true,
  install_dir: luaposix_static_dir
)

shared_module(
  'syslog',
  'ext/posix/syslog.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  name_prefix: '',
  name_suffix: module_suffix,
  install: true,
  install_dir: luaposix_shared_dir
)

pkg_config_libs += static_library(
  'lua.posix.syslog',
  'ext/posix/syslog.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  pic: true,
  install: true,
  install_dir: luaposix_static_dir
)

shared_module(
  'termio',
  'ext/posix/termio.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  name_prefix: '',
  name_suffix: module_suffix,
  install: true,
  install_dir: luaposix_shared_dir
)

pkg_config_libs += static_library(
  'lua.posix.termio',
  'ext/posix/termio.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  pic: true,
  install: true,
  install_dir: luaposix_static_dir
)

# rename this to time on install
shared_module(
  '_time',
  'ext/posix/time.c',
  c_args: luaposix_defines + posix_time_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps + posix_time_dep,
  name_prefix: '',
  name_suffix: module_suffix,
  install: true,
  install_dir: luaposix_shared_dir
)

pkg_config_libs += static_library(
  'lua.posix.time',
  'ext/posix/time.c',
  c_args: luaposix_defines + posix_time_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps + posix_time_dep,
  pic: true,
  install: true,
  install_dir: luaposix_static_dir
)

shared_module(
  'unistd',
  'ext/posix/unistd.c',
  c_args: luaposix_defines + posix_unistd_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps + posix_unistd_dep,
  name_prefix: '',
  name_suffix: module_suffix,
  install: true,
  install_dir: luaposix_shared_dir
)

pkg_config_libs += static_library(
  'lua.posix.unistd',
  'ext/posix/unistd.c',
  c_args: luaposix_defines + posix_unistd_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps + posix_unistd_dep,
  pic: true,
  install: true,
  install_dir: luaposix_static_dir
)

shared_module(
  'utime',
  'ext/posix/utime.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  name_prefix: '',
  name_suffix: module_suffix,
  install: true,
  install_dir: luaposix_shared_dir
)

pkg_config_libs += static_library(
  'lua.posix.utime',
  'ext/posix/utime.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  pic: true,
  install: true,
  install_dir: luaposix_static_dir
)

# -------------------------------------------------
# LUA SCRIPTS
# -------------------------------------------------

install_subdir(
  'lib/posix',
  install_dir: get_option('datadir') / 'lua' / lua_ver
)

# -------------------------------------------------
# EXTRA DATA
# -------------------------------------------------

data_dir = get_option('libdir') / 'luarocks/rocks-' + lua_ver / 'luaposix/36.1-1'
install_data('luarocks/rock_manifest', install_dir: data_dir)

install_data(
  'luarocks/luaposix-36.1-1.rockspec',
  install_dir: data_dir
)

install_subdir(
  'doc',
  install_dir: data_dir
)

# -------------------------------------------------
# PKG CONFIG
# -------------------------------------------------

import('pkgconfig').generate(
  description: 'Lua bindings for POSIX',
  install_dir: get_option('libdir') / 'lua' / lua_ver + '-static/pkgconfig',
  filebase: meson.project_name(),
  libraries: pkg_config_libs,
  name: meson.project_name(),
  url: 'https://github.com/luaposix/luaposix',
)
