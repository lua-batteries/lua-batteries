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

luaposix_defines = [
  '-DVERSION="@0@"'.format(meson.project_version()),
  '-DPACKAGE="@0@"'.format(meson.project_name())
]
luaposix_includes = [
  include_directories('luaposix/ext/include')
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

posix_sys_socket_dep = cc.find_library('socket', required: false)
posix_sys_statvfs_defines = []

if cc.has_function('statvfs')
  posix_sys_statvfs_defines += '-DHAVE_STATVFS'
endif

posix_time_dep = cc.has_header_symbol('unistd.h', '_POSIX_TIMERS') ? cc.find_library('rt') : []
posix_unistd_defines = []

if cc.has_function('crypt')
  posix_unistd_defines += '-DHAVE_CRYPT'
endif

if cc.has_header('crypt.h')
  posix_unistd_defines += '-DHAVE_CRYPT_H'
endif

if cc.has_function('fdatasync')
  posix_unistd_defines += '-DHAVE_DECL_FDATASYNC'
endif

if cc.has_function('fdatasync')
  posix_unistd_defines += '-DHAVE_FDATASYNC'
endif

if cc.has_function('gethostid')
  posix_unistd_defines += '-DHAVE_GETHOSTID'
endif

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
  'luaposix/ext/posix/fnmatch.c',
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
  'luaposix/ext/posix/fnmatch.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  pic: true,
  install: true,
  install_dir: luaposix_static_dir
)

shared_module(
  'glob',
  'luaposix/ext/posix/glob.c',
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
  'luaposix/ext/posix/glob.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  pic: true,
  install: true,
  install_dir: luaposix_static_dir
)

shared_module(
  'grp',
  'luaposix/ext/posix/grp.c',
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
  'luaposix/ext/posix/grp.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  pic: true,
  install: true,
  install_dir: luaposix_static_dir
)

shared_module(
  'libgen',
  'luaposix/ext/posix/libgen.c',
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
  'luaposix/ext/posix/libgen.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  pic: true,
  install: true,
  install_dir: luaposix_static_dir
)

shared_module(
  'poll',
  'luaposix/ext/posix/poll.c',
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
  'luaposix/ext/posix/poll.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  pic: true,
  install: true,
  install_dir: luaposix_static_dir
)

shared_module(
  'pwd',
  'luaposix/ext/posix/pwd.c',
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
  'luaposix/ext/posix/pwd.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  pic: true,
  install: true,
  install_dir: luaposix_static_dir
)

shared_module(
  'sched',
  'luaposix/ext/posix/sched.c',
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
  'luaposix/ext/posix/sched.c',
  c_args: luaposix_defines + posix_sched_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  pic: true,
  install: true,
  install_dir: luaposix_static_dir
)

shared_module(
  'signal',
  'luaposix/ext/posix/signal.c',
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
  'luaposix/ext/posix/signal.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  pic: true,
  install: true,
  install_dir: luaposix_static_dir
)

shared_module(
  'stdio',
  'luaposix/ext/posix/stdio.c',
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
  'luaposix/ext/posix/stdio.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  pic: true,
  install: true,
  install_dir: luaposix_static_dir
)

shared_module(
  'stdlib',
  'luaposix/ext/posix/stdlib.c',
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
  'luaposix/ext/posix/stdlib.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  pic: true,
  install: true,
  install_dir: luaposix_static_dir
)

shared_module(
  'msg',
  'luaposix/ext/posix/sys/msg.c',
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
  'luaposix/ext/posix/sys/msg.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  pic: true,
  install: true,
  install_dir: luaposix_static_dir
)

shared_module(
  'resource',
  'luaposix/ext/posix/sys/resource.c',
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
  'luaposix/ext/posix/sys/resource.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  pic: true,
  install: true,
  install_dir: luaposix_static_dir
)

shared_module(
  'socket',
  'luaposix/ext/posix/sys/socket.c',
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
  'luaposix/ext/posix/sys/socket.c',
  c_args: luaposix_defines + posix_sys_socket_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps + posix_sys_socket_dep,
  pic: true,
  install: true,
  install_dir: luaposix_static_dir
)

shared_module(
  'stat',
  'luaposix/ext/posix/sys/stat.c',
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
  'luaposix/ext/posix/sys/stat.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  pic: true,
  install: true,
  install_dir: luaposix_static_dir
)

shared_module(
  'statvfs',
  'luaposix/ext/posix/sys/statvfs.c',
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
  'luaposix/ext/posix/sys/statvfs.c',
  c_args: luaposix_defines + posix_sys_statvfs_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  pic: true,
  install: true,
  install_dir: luaposix_static_dir
)

shared_module(
  'time',
  'luaposix/ext/posix/sys/time.c',
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
  'luaposix/ext/posix/sys/time.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  pic: true,
  install: true,
  install_dir: luaposix_static_dir
)

shared_module(
  'times',
  'luaposix/ext/posix/sys/stat.c',
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
  'luaposix/ext/posix/sys/times.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  pic: true,
  install: true,
  install_dir: luaposix_static_dir
)

shared_module(
  'utsname',
  'luaposix/ext/posix/sys/utsname.c',
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
  'luaposix/ext/posix/sys/utsname.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  pic: true,
  install: true,
  install_dir: luaposix_static_dir
)

shared_module(
  'wait',
  'luaposix/ext/posix/sys/wait.c',
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
  'luaposix/ext/posix/sys/wait.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  pic: true,
  install: true,
  install_dir: luaposix_static_dir
)

shared_module(
  'syslog',
  'luaposix/ext/posix/syslog.c',
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
  'luaposix/ext/posix/syslog.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps,
  pic: true,
  install: true,
  install_dir: luaposix_static_dir
)

shared_module(
  'termio',
  'luaposix/ext/posix/termio.c',
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
  'luaposix/ext/posix/termio.c',
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
  'luaposix/ext/posix/time.c',
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
  'luaposix/ext/posix/time.c',
  c_args: luaposix_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps + posix_time_dep,
  pic: true,
  install: true,
  install_dir: luaposix_static_dir
)

shared_module(
  'unistd',
  'luaposix/ext/posix/unistd.c',
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
  'luaposix/ext/posix/unistd.c',
  c_args: luaposix_defines + posix_unistd_defines,
  include_directories: luaposix_includes,
  dependencies: project_deps + posix_unistd_dep,
  pic: true,
  install: true,
  install_dir: luaposix_static_dir
)

shared_module(
  'utime',
  'luaposix/ext/posix/utime.c',
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
  'luaposix/ext/posix/utime.c',
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
