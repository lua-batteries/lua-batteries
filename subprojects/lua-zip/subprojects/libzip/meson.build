project(
  'libzip',
  'c',
  version: '1.9.2',
  # license: '',
  meson_version: '>=0.64.0'
)

cc = meson.get_compiler('c')
cc_id = cc.get_id()
system = host_machine.system()
deps = []

zipconfig_data = configuration_data({
  'LIBZIP_VERSION': meson.project_version(),
  'LIBZIP_VERSION_MAJOR': meson.project_version().split('.')[0],
  'LIBZIP_VERSION_MINOR': meson.project_version().split('.')[1],
  'LIBZIP_VERSION_PATCH': meson.project_version().split('.')[2]
})

if get_option('default_library') == 'static'
  zipconfig_data.set('ZIP_STATIC', true)
endif

have_nullable = cc.compiles('int foo(char * _Nullable bar);int main(int argc, char *argv[]) { }')

if have_nullable
  zipconfig_data.set('ZIP_NULLABLE_DEFINES', '')
else
  zipconfig_data.set('ZIP_NULLABLE_DEFINES', '#define _Nullable\n#define _Nonnull')
endif

if cc.has_header('inttypes.h')
  zipconfig_data.set('LIBZIP_TYPES_INCLUDE', '#if !defined(__STDC_FORMAT_MACROS)\n#define __STDC_FORMAT_MACROS 1\n#endif\n#include <inttypes.h>')
elif cc.has_header('stdint.h')
  zipconfig_data.set('LIBZIP_TYPES_INCLUDE', '#include <stdint.h>')
elif cc.has_header('sys/types.h')
  zipconfig_data.set('LIBZIP_TYPES_INCLUDE', '#include <sys/types.h>')
endif

if cc.has_type('int8_t')
  zipconfig_data.set('ZIP_INT8_T', 'int8_t')
elif cc.has_type('__int8')
  zipconfig_data.set('ZIP_INT8_T', '__int8')
else
  zipconfig_data.set('ZIP_INT8_T', 'signed char')
endif

if cc.has_type('uint8_t')
  zipconfig_data.set('ZIP_UINT8_T', 'uint8_t')
elif cc.has_type('__int8')
  zipconfig_data.set('ZIP_UINT8_T', 'unsigned __int8')
else
  zipconfig_data.set('ZIP_UINT8_T', 'unsigned char')
endif

if cc.has_type('int16_t')
  zipconfig_data.set('ZIP_INT16_T', 'int16_t')
elif cc.has_type('__int16')
  zipconfig_data.set('ZIP_INT16_T', '__int16')
elif cc.has_type('short') # 2
  zipconfig_data.set('ZIP_INT16_T', 'short')
endif

if cc.has_type('uint16_t')
  zipconfig_data.set('ZIP_UINT16_T', 'uint16_t')
elif cc.has_type('__int16')
  zipconfig_data.set('ZIP_UINT16_T', 'unsigned __int16')
elif cc.has_type('short') # 2
  zipconfig_data.set('ZIP_UINT16_T', 'unsigned short')
endif

if cc.has_type('int32_t')
  zipconfig_data.set('ZIP_INT32_T', 'int32_t')
elif cc.has_type('__int32')
  zipconfig_data.set('ZIP_INT32_T', '__int32')
elif cc.has_type('int') # 4
  zipconfig_data.set('ZIP_INT32_T', 'int')
elif cc.has_type('long') # 4
  zipconfig_data.set('ZIP_INT32_T', 'long')
endif

if cc.has_type('uint32_t')
  zipconfig_data.set('ZIP_UINT32_T', 'uint32_t')
elif cc.has_type('__uint32')
  zipconfig_data.set('ZIP_UINT32_T', 'unsigned __int32')
elif cc.has_type('int') # 4
  zipconfig_data.set('ZIP_UINT32_T', 'unsigned int')
elif cc.has_type('long') # 4
  zipconfig_data.set('ZIP_UINT32_T', 'unsigned long')
endif

if cc.has_type('int64_t')
  zipconfig_data.set('ZIP_INT64_T', 'int64_t')
elif cc.has_type('__int64')
  zipconfig_data.set('ZIP_INT64_T', '__int64')
elif cc.has_type('long') # 8
  zipconfig_data.set('ZIP_INT64_T', 'long')
elif cc.has_type('long long') # 8
  zipconfig_data.set('ZIP_INT64_T', 'long long')
endif

if cc.has_type('uint64_t')
  zipconfig_data.set('ZIP_UINT64_T', 'uint64_t')
elif cc.has_type('__uint64')
  zipconfig_data.set('ZIP_UINT64_T', 'unsigned __int64')
elif cc.has_type('long') # 8
  zipconfig_data.set('ZIP_UINT64_T', 'unsigned long')
elif cc.has_type('long long') # 8
  zipconfig_data.set('ZIP_UINT64_T', 'unsigned long long')
endif

zipconfig = configure_file(
  input: 'meson-zipconf.h.in',
  output: 'zipconf.h',
  configuration: zipconfig_data
)

config_data = configuration_data({
  'CMAKE_PROJECT_NAME': meson.project_name(),
  'CMAKE_PROJECT_VERSION': meson.project_version()
})

# HAVE__UMASK
# HAVE_GNUTLS
# HAVE_LIBBZ2
# HAVE_LIBLZMA
# HAVE_LIBZSTD
# HAVE_MBEDTLS
# HAVE_MKSTEMP
# HAVE_OPENSSL
# HAVE_STRUCT_TM_TM_ZONE
# HAVE_DIRENT_H
# HAVE_NDIR_H
# HAVE_SYS_DIR_H
# HAVE_SYS_NDIR_H

check_functions = [
  ['HAVE__CLOSE', '_close'],
  ['HAVE__DUP', '_dup'],
  ['HAVE__FDOPEN', '_fdopen'],
  ['HAVE__FILENO', '_fileno'],
  ['HAVE__SETMODE', '_setmode'],
  ['HAVE__STRDUP', '_strdup'],
  ['HAVE__STRICMP', '_stricmp'],
  ['HAVE__STRTOI64', '_strtoi64'],
  ['HAVE__STRTOUI64', '_strtoui64'],
  ['HAVE__UNLINK', '_unlink'],
  ['HAVE_ARC4RANDOM', 'arc4random'],
  ['HAVE_CLONEFILE', 'clonefile'],
  ['HAVE_FILENO', 'fileno'],
  ['HAVE_FCHMOD', 'fchmod'],
  ['HAVE_FSEEKO', 'fseeko'],
  ['HAVE_FTELLO', 'ftello'],
  ['HAVE_GETPROGNAME', 'getprogname'],
  ['HAVE_LOCALTIME_R', 'localtime_r'],
  ['HAVE_SETMODE', 'setmode'],
  ['HAVE_STRDUP', 'strdup'],
  ['HAVE_STRICMP', 'stricmp'],
  ['HAVE_STRTOLL', 'strtoll'],
  ['HAVE_STRTOULL', 'strtoull']
]

foreach check_fn: check_functions
  if cc.has_function(check_fn[1])
    config_data.set(check_fn[0], true)
  endif
endforeach

check_headers = [
  ['HAVE_STDBOOL_H', 'stdbool.h'],
  ['HAVE_STRINGS_H', 'strings.h'],
  ['HAVE_UNISTD_H', 'unistd.h']
]

foreach check_header: check_headers
  if cc.has_header(check_header[1])
    config_data.set(check_header[0], true)
  endif
endforeach

if cc.has_header('sys/types.h') and cc.has_header('sys/stat.h') and cc.has_header('fts.h')
  config_data.set('HAVE_FTS_H', true)
endif

check_symbols = [
  # ['HAVE__SNPRINTF', 'stdio.h', '_snprintf'],
  ['HAVE_SNPRINTF', 'stdio.h', 'snprintf'],
  ['HAVE_STRCASECMP', 'strings.h', 'strcasecmp']
]

foreach check_sym: check_symbols
  if cc.has_header_symbol(check_sym[1], check_sym[2])
    config_data.set(check_sym[0], true)
  endif
endforeach

if host_machine.endian() == 'big'
  config_data.set('WORDS_BIGENDIAN', true)
endif

if get_option('default_library') != 'static'
  config_data.set('HAVE_SHARED', true)
endif

if cc.compiles('#include <sys/ioctl.h>\n#include <linux/fs.h>\nint main(int argc, char *argv[]) { unsigned long x = FICLONERANGE; }')
  config_data.set('HAVE_FICLONERANGE', true)
endif

if have_nullable
  config_data.set('HAVE_NULLABLE', true)
endif

size_off_t = cc.sizeof('off_t')
sizeof_size_t = cc.sizeof('size_t')

if size_off_t != -1
  config_data.set('SIZEOF_OFF_T', size_off_t)
elif sizeof_size_t != -1 # work around
  config_data.set('SIZEOF_OFF_T', sizeof_size_t / 2)
endif

if sizeof_size_t != -1
  config_data.set('SIZEOF_SIZE_T', sizeof_size_t)
endif

# if system == 'windows'
#   config_data.set('HAVE_CRYPTO', true)
#   config_data.set('HAVE_WINDOWS_CRYPTO', true)
# else
#   # get_option('comman-crypto') != 'false' and 
#   if cc.has_header('CommonCrypto/CommonCrypto.h')
#     config_data.set('HAVE_CRYPTO', true)
#     config_data.set('HAVE_COMMONCRYPTO', true)
#   endif
# endif


config = configure_file(
  input: 'meson-config.h.in',
  output: 'config.h',
  configuration: config_data
)

libzip_sources = [
  'libzip/lib/zip_add_dir.c',
  'libzip/lib/zip_add.c',
  'libzip/lib/zip_add_entry.c',
  'libzip/lib/zip_algorithm_deflate.c',
  'libzip/lib/zip_buffer.c',
  'libzip/lib/zip_close.c',
  'libzip/lib/zip_delete.c',
  'libzip/lib/zip_dir_add.c',
  'libzip/lib/zip_dirent.c',
  'libzip/lib/zip_discard.c',
  'libzip/lib/zip_entry.c',
  'libzip/lib/zip_error.c',
  'libzip/lib/zip_error_clear.c',
  'libzip/lib/zip_error_get.c',
  'libzip/lib/zip_error_get_sys_type.c',
  'libzip/lib/zip_error_strerror.c',
  'libzip/lib/zip_error_to_str.c',
  'libzip/lib/zip_extra_field.c',
  'libzip/lib/zip_extra_field_api.c',
  'libzip/lib/zip_fclose.c',
  'libzip/lib/zip_fdopen.c',
  'libzip/lib/zip_file_add.c',
  'libzip/lib/zip_file_error_clear.c',
  'libzip/lib/zip_file_error_get.c',
  'libzip/lib/zip_file_get_comment.c',
  'libzip/lib/zip_file_get_external_attributes.c',
  'libzip/lib/zip_file_get_offset.c',
  'libzip/lib/zip_file_rename.c',
  'libzip/lib/zip_file_replace.c',
  'libzip/lib/zip_file_set_comment.c',
  'libzip/lib/zip_file_set_encryption.c',
  'libzip/lib/zip_file_set_external_attributes.c',
  'libzip/lib/zip_file_set_mtime.c',
  'libzip/lib/zip_file_strerror.c',
  'libzip/lib/zip_fopen.c',
  'libzip/lib/zip_fopen_encrypted.c',
  'libzip/lib/zip_fopen_index.c',
  'libzip/lib/zip_fopen_index_encrypted.c',
  'libzip/lib/zip_fread.c',
  'libzip/lib/zip_fseek.c',
  'libzip/lib/zip_ftell.c',
  'libzip/lib/zip_get_archive_comment.c',
  'libzip/lib/zip_get_archive_flag.c',
  'libzip/lib/zip_get_encryption_implementation.c',
  'libzip/lib/zip_get_file_comment.c',
  'libzip/lib/zip_get_name.c',
  'libzip/lib/zip_get_num_entries.c',
  'libzip/lib/zip_get_num_files.c',
  'libzip/lib/zip_hash.c',
  'libzip/lib/zip_io_util.c',
  'libzip/lib/zip_libzip_version.c',
  'libzip/lib/zip_memdup.c',
  'libzip/lib/zip_name_locate.c',
  'libzip/lib/zip_new.c',
  'libzip/lib/zip_open.c',
  'libzip/lib/zip_pkware.c',
  'libzip/lib/zip_progress.c',
  'libzip/lib/zip_rename.c',
  'libzip/lib/zip_replace.c',
  'libzip/lib/zip_set_archive_comment.c',
  'libzip/lib/zip_set_archive_flag.c',
  'libzip/lib/zip_set_default_password.c',
  'libzip/lib/zip_set_file_comment.c',
  'libzip/lib/zip_set_file_compression.c',
  'libzip/lib/zip_set_name.c',
  'libzip/lib/zip_source_accept_empty.c',
  'libzip/lib/zip_source_begin_write.c',
  'libzip/lib/zip_source_begin_write_cloning.c',
  'libzip/lib/zip_source_buffer.c',
  'libzip/lib/zip_source_call.c',
  'libzip/lib/zip_source_close.c',
  'libzip/lib/zip_source_commit_write.c',
  'libzip/lib/zip_source_compress.c',
  'libzip/lib/zip_source_crc.c',
  'libzip/lib/zip_source_error.c',
  'libzip/lib/zip_source_file_common.c',
  'libzip/lib/zip_source_file_stdio.c',
  'libzip/lib/zip_source_free.c',
  'libzip/lib/zip_source_function.c',
  'libzip/lib/zip_source_get_file_attributes.c',
  'libzip/lib/zip_source_is_deleted.c',
  'libzip/lib/zip_source_layered.c',
  'libzip/lib/zip_source_open.c',
  'libzip/lib/zip_source_pkware_decode.c',
  'libzip/lib/zip_source_pkware_encode.c',
  'libzip/lib/zip_source_read.c',
  'libzip/lib/zip_source_remove.c',
  'libzip/lib/zip_source_rollback_write.c',
  'libzip/lib/zip_source_seek.c',
  'libzip/lib/zip_source_seek_write.c',
  'libzip/lib/zip_source_stat.c',
  'libzip/lib/zip_source_supports.c',
  'libzip/lib/zip_source_tell.c',
  'libzip/lib/zip_source_tell_write.c',
  'libzip/lib/zip_source_window.c',
  'libzip/lib/zip_source_write.c',
  'libzip/lib/zip_source_zip.c',
  'libzip/lib/zip_source_zip_new.c',
  'libzip/lib/zip_stat.c',
  'libzip/lib/zip_stat_index.c',
  'libzip/lib/zip_stat_init.c',
  'libzip/lib/zip_strerror.c',
  'libzip/lib/zip_string.c',
  'libzip/lib/zip_unchange.c',
  'libzip/lib/zip_unchange_all.c',
  'libzip/lib/zip_unchange_archive.c',
  'libzip/lib/zip_unchange_data.c',
  'libzip/lib/zip_utf-8.c',
  'zip_err_str.c'
]

if system == 'windows'
  libzip_sources += [
    'libzip/lib/zip_source_file_win32.c',
    'libzip/lib/zip_source_file_win32_named.c',
    'libzip/lib/zip_source_file_win32_utf16.c',
    'libzip/lib/zip_source_file_win32_utf8.c'
  ]
  libzip_sources += [
    'libzip/lib/zip_source_file_win32_ansi.c',
    'libzip/lib/zip_random_win32.c'
  ]

  deps += cc.find_library('advapi32')
  
  # libzip_sources += [
  #   'libzip/lib/zip_crypto_win.c'
  # ]

  # deps += cc.find_library('bcrypt')

  # libzip_sources += [
  #   'libzip/lib/zip_winzip_aes.c',
  #   'libzip/lib/zip_source_winzip_aes_decode.c',
  #   'libzip/lib/zip_source_winzip_aes_encode.c'
  # ]
else
  project_deps += [
    'libzip/lib/zip_source_file_stdio_named.c',
    'libzip/lib/zip_random_unix.c'
  ]
endif

zlib_dep = dependency('z', required: false)

if get_option('standalone') or not zlib_dep.found()
  zlib = subproject('zlib', default_options: ['default_library=static'])
  deps += zlib.get_variable('zlib_dep')
else
  deps += zlib_dep
endif

libzip = library(
  'zip',
  libzip_sources,
  dependencies: deps,
  include_directories: [
    include_directories('.'),
    include_directories('libzip/lib')
  ],
  install: true
)

libzip_dep = declare_dependency(
  link_with: libzip,
  include_directories: [
    include_directories('.'),
    include_directories('libzip/lib')
  ],
)

install_headers([
  'libzip/lib/zip.h',
  zipconfig
])

import('pkgconfig').generate(
  libzip,
  description: 'library for handling zip archives',
  filebase: meson.project_name(),
  name: meson.project_name(),
  url: 'https://github.com/nih-at/libzip',
  variables: ['zipcmp=${bindir}/zipcmp']
)
