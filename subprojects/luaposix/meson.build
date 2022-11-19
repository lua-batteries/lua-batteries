project(
  'luaposix',
  'c',
  version: '35.1',
  license: 'MIT',
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

luaposix_defines = ['-DVERSION="35.1"']
luaposix_includes = [
  include_directories('luaposix/ext/include')
]
luaposix_shared_dir = get_option('libdir') / 'lua' / lua_ver / 'posix'
luaposix_shared_sys_dir = get_option('libdir') / 'lua' / lua_ver / 'posix/sys'
luaposix_static_dir = get_option('libdir') / 'lua' / lua_ver + '-static'

posix_fcntl_defines = [
  '-DHAVE_POSIX_FADVISE=' + cc.has_function('posix_fadvise').to_int().to_string()
]
posix_sched_defines = [
  '-DHAVE_SCHED_H=' + cc.has_header('sched.h').to_int().to_string(),
  '-DHAVE_SCHED_GETSCHEDULER=' + cc.has_function('sched_getscheduler').to_int().to_string(),
  '-DHAVE_SCHED_SETSCHEDULER=' + cc.has_function('sched_setscheduler').to_int().to_string()
]
posix_sys_msg_defines = [
  '-DHAVE_SYS_MSG_H=' + cc.has_header('sys/msg.h').to_int().to_string(),
  '-DHAVE_MSGRCV=' + cc.has_function('msgrcv').to_int().to_string(),
  '-DHAVE_MSGSND=' + cc.has_function('msgsnd').to_int().to_string()
]
posix_sys_socket_defines = [
  '-DHAVE_NET_IF_H=' + cc.has_header('net/if.h', include_directories: 'sys').to_int().to_string(),
  '-DHAVE_LINUX_NETLINK_H=' + cc.has_header('linux/netlink.h', include_directories: 'sys').to_int().to_string(),
  '-DHAVE_LINUX_IF_PACKET_H=' + cc.has_header('linux/if_packet.h', include_directories: 'sys').to_int().to_string()
]
posix_sys_socket_dep = cc.find_library('socket')
posix_sys_statvfs_defines = [
  '-DHAVE_STATVFS=' + cc.has_function('statvfs').to_int().to_string()
]
posix_time_dep = cc.has_header_symbol('_POSIX_TIMERS') ? cc.find_library('rt') : []
posix_unistd_defines = [
  '-DHAVE_CRYPT=' + cc.has_function('crypt').to_int().to_string(),
  '-DHAVE_CRYPT_H=' + cc.has_header('crypt.h').to_int().to_string(),
  '-DHAVE_DECL_FDATASYNC=' + cc.has_function('fdatasync').to_int().to_string(),
  '-DHAVE_FDATASYNC=' + cc.has_function('fdatasync').to_int().to_string(),
  '-DHAVE_GETHOSTID=' + cc.has_function('gethostid').to_int().to_string()
]
posix_unistd_dep = cc.find_library('crypt')

shared_module(
  'ctype',
  'luaposix/ext/posix/ctype.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  name_prefix: '',
  name_suffix: module_suffix,
  install: true,
  install_dir: luaposix_shared_dir
)

static_library(
  'posix.ctype',
  'luaposix/ext/posix/ctype.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  pic: true,
  install: true,
  install_dir: luaposix_static_dir
)

shared_module(
  'dirent',
  'luaposix/ext/posix/dirent.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  name_prefix: '',
  name_suffix: module_suffix,
  install: true,
  install_dir: luaposix_shared_dir
)

static_library(
  'posix.dirent',
  'luaposix/ext/posix/dirent.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  pic: true,
  install: true,
  install_dir: luaposix_static_dir
)

shared_module(
  'errno',
  'luaposix/ext/posix/errno.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  name_prefix: '',
  name_suffix: module_suffix,
  install: true,
  install_dir: luaposix_shared_dir
)

static_library(
  'posix.errno',
  'luaposix/ext/posix/errno.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  pic: true,
  install: true,
  install_dir: luaposix_static_dir
)

shared_module(
  'fcntl',
  'luaposix/ext/posix/fcntl.c',
  c_args: luaposix_defines + posix_fcntl_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  name_prefix: '',
  name_suffix: module_suffix,
  install: true,
  install_dir: luaposix_shared_dir
)

static_library(
  'posix.fcntl',
  'luaposix/ext/posix/fcntl.c',
  c_args: luaposix_defines + posix_fcntl_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  pic: true,
  install: true,
  install_dir: luaposix_static_dir
)

shared_module(
  'fnmatch',
  'luarocks/ext/posix/fnmatch.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  name_prefix: '',
  name_suffix: module_suffix,
  install: true,
  install_dir: luaposix_shared_dir
)

static_library(
  'posix.fnmatch',
  'luarocks/ext/posix/fnmatch.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  pic: true,
  install: true,
  install_dir: luaposix_static_dir
)

shared_module(
  'glob',
  'luarocks/ext/posix/glob.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  name_prefix: '',
  name_suffix: module_suffix,
  install: true,
  install_dir: luaposix_shared_dir
)

static_library(
  'posix.glob',
  'luarocks/ext/posix/glob.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  pic: true,
  install: true,
  install_dir: luaposix_static_dir
)

shared_module(
  'grp',
  'luarocks/ext/posix/grp.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  name_prefix: '',
  name_suffix: module_suffix,
  install: true,
  install_dir: luaposix_shared_dir
)

static_library(
  'posix.grp',
  'luarocks/ext/posix/grp.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  pic: true,
  install: true,
  install_dir: luaposix_static_dir
)

shared_module(
  'libgen',
  'luarocks/ext/posix/libgen.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  name_prefix: '',
  name_suffix: module_suffix,
  install: true,
  install_dir: luaposix_shared_dir
)

static_library(
  'posix.libgen',
  'luarocks/ext/posix/libgen.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  pic: true,
  install: true,
  install_dir: luaposix_static_dir
)

shared_module(
  'poll',
  'luarocks/ext/posix/poll.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  name_prefix: '',
  name_suffix: module_suffix,
  install: true,
  install_dir: luaposix_shared_dir
)

static_library(
  'posix.poll',
  'luarocks/ext/posix/poll.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  pic: true,
  install: true,
  install_dir: luaposix_static_dir
)

shared_module(
  'pwd',
  'luarocks/ext/posix/pwd.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  name_prefix: '',
  name_suffix: module_suffix,
  install: true,
  install_dir: luaposix_shared_dir
)

static_library(
  'posix.pwd',
  'luarocks/ext/posix/pwd.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  pic: true,
  install: true,
  install_dir: luaposix_static_dir
)

shared_module(
  'sched',
  'luarocks/ext/posix/sched.c',
  c_args: luaposix_defines + posix_sched_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  name_prefix: '',
  name_suffix: module_suffix,
  install: true,
  install_dir: luaposix_shared_dir
)

static_library(
  'posix.sched',
  'luarocks/ext/posix/sched.c',
  c_args: luaposix_defines + posix_sched_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  pic: true,
  install: true,
  install_dir: luaposix_static_dir
)

shared_module(
  'signal',
  'luarocks/ext/posix/signal.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  name_prefix: '',
  name_suffix: module_suffix,
  install: true,
  install_dir: luaposix_shared_dir
)

static_library(
  'posix.signal',
  'luarocks/ext/posix/signal.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  pic: true,
  install: true,
  install_dir: luaposix_static_dir
)

shared_module(
  'stdio',
  'luarocks/ext/posix/stdio.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  name_prefix: '',
  name_suffix: module_suffix,
  install: true,
  install_dir: luaposix_shared_dir
)

static_library(
  'posix.stdio',
  'luarocks/ext/posix/stdio.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  pic: true,
  install: true,
  install_dir: luaposix_static_dir
)

shared_module(
  'stdlib',
  'luarocks/ext/posix/stdlib.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  name_prefix: '',
  name_suffix: module_suffix,
  install: true,
  install_dir: luaposix_shared_dir
)

static_library(
  'posix.stdlib',
  'luarocks/ext/posix/stdlib.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  pic: true,
  install: true,
  install_dir: luaposix_static_dir
)

shared_module(
  'msg',
  'luarocks/ext/posix/sys/msg.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  name_prefix: '',
  name_suffix: module_suffix,
  install: true,
  install_dir: luaposix_shared_sys_dir
)

static_library(
  'posix.sys.msg',
  'luarocks/ext/posix/sys/msg.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  pic: true,
  install: true,
  install_dir: luaposix_static_dir
)

shared_module(
  'resource',
  'luarocks/ext/posix/sys/resource.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  name_prefix: '',
  name_suffix: module_suffix,
  install: true,
  install_dir: luaposix_shared_sys_dir
)

static_library(
  'posix.sys.resource',
  'luarocks/ext/posix/sys/resource.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  pic: true,
  install: true,
  install_dir: luaposix_static_dir
)

shared_module(
  'socket',
  'luarocks/ext/posix/sys/socket.c',
  c_args: luaposix_defines + posix_sys_socket_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps + posix_sys_socket_dep,
  name_prefix: '',
  name_suffix: module_suffix,
  install: true,
  install_dir: luaposix_shared_sys_dir
)

static_library(
  'posix.sys.socket',
  'luarocks/ext/posix/sys/socket.c',
  c_args: luaposix_defines + posix_sys_socket_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps + posix_sys_socket_dep,
  pic: true,
  install: true,
  install_dir: luaposix_static_dir
)

shared_module(
  'stat',
  'luarocks/ext/posix/sys/stat.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  name_prefix: '',
  name_suffix: module_suffix,
  install: true,
  install_dir: luaposix_shared_sys_dir
)

static_library(
  'posix.sys.stat',
  'luarocks/ext/posix/sys/stat.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  pic: true,
  install: true,
  install_dir: luaposix_static_dir
)

shared_module(
  'statvfs',
  'luarocks/ext/posix/sys/statvfs.c',
  c_args: luaposix_defines + posix_sys_statvfs_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  name_prefix: '',
  name_suffix: module_suffix,
  install: true,
  install_dir: luaposix_shared_sys_dir
)

static_library(
  'posix.sys.statvfs',
  'luarocks/ext/posix/sys/statvfs.c',
  c_args: luaposix_defines + posix_sys_statvfs_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  pic: true,
  install: true,
  install_dir: luaposix_static_dir
)

shared_module(
  'time',
  'luarocks/ext/posix/sys/time.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  name_prefix: '',
  name_suffix: module_suffix,
  install: true,
  install_dir: luaposix_shared_sys_dir
)

static_library(
  'posix.sys.time',
  'luarocks/ext/posix/sys/time.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  pic: true,
  install: true,
  install_dir: luaposix_static_dir
)

shared_module(
  'times',
  'luarocks/ext/posix/sys/stat.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  name_prefix: '',
  name_suffix: module_suffix,
  install: true,
  install_dir: luaposix_shared_sys_dir
)

static_library(
  'posix.sys.times',
  'luarocks/ext/posix/sys/times.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  pic: true,
  install: true,
  install_dir: luaposix_static_dir
)

shared_module(
  'utsname',
  'luarocks/ext/posix/sys/utsname.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  name_prefix: '',
  name_suffix: module_suffix,
  install: true,
  install_dir: luaposix_shared_sys_dir
)

static_library(
  'posix.sys.utsname',
  'luarocks/ext/posix/sys/utsname.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  pic: true,
  install: true,
  install_dir: luaposix_static_dir
)

shared_module(
  'wait',
  'luarocks/ext/posix/sys/wait.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  name_prefix: '',
  name_suffix: module_suffix,
  install: true,
  install_dir: luaposix_shared_sys_dir
)

static_library(
  'posix.sys.wait',
  'luarocks/ext/posix/sys/wait.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  pic: true,
  install: true,
  install_dir: luaposix_static_dir
)

shared_module(
  'syslog',
  'luarocks/ext/posix/syslog.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  name_prefix: '',
  name_suffix: module_suffix,
  install: true,
  install_dir: luaposix_shared_dir
)

static_library(
  'posix.syslog',
  'luarocks/ext/posix/syslog.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  pic: true,
  install: true,
  install_dir: luaposix_static_dir
)

shared_module(
  'termio',
  'luarocks/ext/posix/termio.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  name_prefix: '',
  name_suffix: module_suffix,
  install: true,
  install_dir: luaposix_shared_dir
)

static_library(
  'posix.termio',
  'luarocks/ext/posix/termio.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  pic: true,
  install: true,
  install_dir: luaposix_static_dir
)

# BUG
shared_module(
  'time',
  'luarocks/ext/posix/time.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps + posix_time_dep,
  name_prefix: '',
  name_suffix: module_suffix,
  install: true,
  install_dir: luaposix_shared_dir
)

static_library(
  'posix.time',
  'luarocks/ext/posix/time.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps + posix_time_dep,
  pic: true,
  install: true,
  install_dir: luaposix_static_dir
)

shared_module(
  'unistd',
  'luarocks/ext/posix/unistd.c',
  c_args: luaposix_defines + posix_unistd_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps + posix_unistd_dep,
  name_prefix: '',
  name_suffix: module_suffix,
  install: true,
  install_dir: luaposix_shared_dir
)

static_library(
  'posix.unistd',
  'luarocks/ext/posix/unistd.c',
  c_args: luaposix_defines + posix_unistd_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps + posix_unistd_dep,
  pic: true,
  install: true,
  install_dir: luaposix_static_dir
)

shared_module(
  'utime',
  'luarocks/ext/posix/utime.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  name_prefix: '',
  name_suffix: module_suffix,
  install: true,
  install_dir: luaposix_shared_dir
)

static_library(
  'posix.utime',
  'luarocks/ext/posix/utime.c',
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
  'luaposix/lib/posix',
  install_dir: get_option('datadir') / 'lua' / lua_ver
)

# -------------------------------------------------
# EXTRA DATA
# -------------------------------------------------

data_dir = get_option('libdir') / 'luarocks/rocks-' + lua_ver / 'luaposix/35.1-1'
install_data('luarocks/rock_manifest', install_dir: data_dir)

install_data(
  'luaposix/luaposix-35.1-1.rockspec',
  install_dir: data_dir
)

install_subdir(
  'luaposix/doc',
  install_dir: data_dir
)
