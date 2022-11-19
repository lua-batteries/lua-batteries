# 17 march 2019

# TODO I'm not sure how to allow building 32-bit instead of 64-bit with meson

# TODO remove cpp from this list once https://github.com/mesonbuild/meson/issues/5181 is settled; move it to the OS checks and under cpp-multithread
project('libui', ['c', 'cpp'],
	meson_version: '>=0.48.0',
	default_options: [
		# 'buildtype=debug',				# build debug by default
		'default_library=shared',			# build shared libraries by default
		# 'layout=flat',					# keep all outputs together by default

		# these are forced options, but meson doesn't let me set these up separately before I call project() (TODO https://github.com/mesonbuild/meson/issues/5179)
		# 'warning_level=3',				# always max warnings
		'b_pch=false',					# we don't want precompiled headers
		'b_staticpic=true',				# use PIC even for static libraries
		'c_std=c99',					# strict C99
		'c_winlibs=',					# we define our own Windows libraries
		'cpp_std=c++11',				# strict C++11
		'cpp_eh=sc',					# shut the compiler up in some cases
		'cpp_winlibs=',					# likewise as with c_winlibs
	],
	license: 'MIT')

# TODO after https://github.com/mesonbuild/meson/issues/5179 is settled, remove these
libui_OS = host_machine.system()
libui_MSVC = meson.get_compiler('c').get_id() == 'msvc'

# TODO switch to tabs; the spaces are just so I can share this file while I'm writing it
libui_forced_options = {
	'warning_level': '3',     # always max warnings
	'b_pch':         'false', # we don't want precompiled headers
	'b_staticpic':   'true',  # use PIC even for static libraries
	'c_std':         'c99',   # strict C99
	'c_winlibs':     '[]',    # we define our own Windows libraries
	'cpp_std':       'c++11', # strict C++11
	'cpp_eh':        'sc',    # shut the compiler up in some cases
	'cpp_winlibs':   '[]',    # likewise as with c_winlibs
}
# foreach name, value : libui_forced_options
# 	# TODO rewrite this when https://github.com/mesonbuild/meson/issues/5181 is settled
# 	if not ((name == 'c_winlibs' or name == 'cpp_eh' or name == 'cpp_winlibs') and not libui_MSVC) and not (name == 'c_std' and libui_MSVC)
# 		actual = '@0@'.format(get_option(name))
# 		if actual != value
# 			error('sorry, but libui requires that option ' + name + ' has the default value ' + value)
# 		endif
# 	endif
# endforeach

libui_OS = host_machine.system()
libui_MSVC = meson.get_compiler('c').get_id() == 'msvc'

if libui_OS == 'darwin'
	add_languages('objc',
		required: true)
endif

libui_mode = get_option('default_library')
if libui_mode == 'both'
	error('sorry, but libui does not support building both shared and static libraries at the same time, because Windows resource file rules differ between the two')
endif

libui_is_debug = get_option('buildtype').startswith('debug')

libui_project_compile_args = []
libui_project_link_args = []

if libui_OS == 'darwin'
	libui_macosx_version_min = '-mmacosx-version-min=10.8'
	libui_project_compile_args += [libui_macosx_version_min]
	libui_project_link_args += [libui_macosx_version_min]
endif

if libui_MSVC
	# TODO subsystem version

	libui_project_compile_args += [
		'/wd4100',
		'/bigobj',
	]
	if libui_is_debug
		libui_project_compile_args += ['/RTC1', '/RTCs', '/RTCu']
	endif

	libui_project_link_args += [
		'/LARGEADDRESSAWARE',
		'/INCREMENTAL:NO',
		'/MANIFEST:NO',
	]

	# TODO autogenerate a .def file?
else
	libui_project_compile_args += [
		'-Wno-unused-parameter',
		'-Wno-switch',
	]

	if libui_OS == 'windows'
		# don't require shipping the MinGW-w64 DLLs
		libui_project_link_args += [
			'-static',
			'-static-libgcc',
			'-static-libstdc++',
		]
	endif
endif

# TODO come up with a better way to do this, both for libui (the compiler define, used by winapi.hpp, and the manifest args) and for the binaries (the manifest args)
# TODO (after the above TODO is resolved) move that below the part below that actually adds these arguments
libui_manifest_args = []
# if libui_mode == 'static'
# 	libui_project_compile_args += ['-D_UI_STATIC']
# 	libui_manifest_args = ['-D_UI_STATIC']
# endif

add_project_arguments(libui_project_compile_args,
	language: ['c', 'cpp', 'objc'])
add_project_link_arguments(libui_project_link_args,
	language: ['c', 'cpp', 'objc'])

# TODO:
# meson determins whether -Wl,--no-undefined is provided via
# built-in option b_lundef, and it's true by default, which is what
# we want (so I don't make mistakes like asking for unknown
# functions in my dependencies). However, meson also is smart
# about specifying this properly on systems that don't support it, like
# FreeBSD (where I had the comment "figure out why FreeBSD
# follows linked libraries here" when I was on cmake) and OpenBSD
# (according to someone on freenode #mesonbuild), but it isn't clear
# whether it's just ignored or if the value is forced to false.
# Therefore, once this is determined, we can uncomment the
# following.
libui_libui_link_args = []
#if not libui_MSVC and get_option("b_lundef")
	# TODO what should this be on MSVC?
#	libui_libui_link_args += ['-Wl,--no-allow-shlib-undefined']
#endif

libui_sources = []
libui_deps = []
libui_soversion = ''
libui_rpath = ''

# subdir('common')

libui_sources += [
	'libui/common/attribute.c',
	'libui/common/attrlist.c',
	'libui/common/attrstr.c',
	'libui/common/areaevents.c',
	'libui/common/control.c',
	'libui/common/debug.c',
	'libui/common/matrix.c',
	'libui/common/opentype.c',
	'libui/common/shouldquit.c',
	'libui/common/tablemodel.c',
	'libui/common/tablevalue.c',
	'libui/common/userbugs.c',
	'libui/common/utf.c',
]

if libui_OS == 'windows'
	# subdir('windows')

  # 23 march 2019

  windows = import('windows')

  libui_sources += [
    'libui/windows/alloc.cpp',
    'libui/windows/area.cpp',
    'libui/windows/areadraw.cpp',
    'libui/windows/areaevents.cpp',
    'libui/windows/areascroll.cpp',
    'libui/windows/areautil.cpp',
    'libui/windows/attrstr.cpp',
    'libui/windows/box.cpp',
    'libui/windows/button.cpp',
    'libui/windows/checkbox.cpp',
    'libui/windows/colorbutton.cpp',
    'libui/windows/colordialog.cpp',
    'libui/windows/combobox.cpp',
    'libui/windows/container.cpp',
    'libui/windows/control.cpp',
    'libui/windows/d2dscratch.cpp',
    'libui/windows/datetimepicker.cpp',
    'libui/windows/debug.cpp',
    'libui/windows/draw.cpp',
    'libui/windows/drawmatrix.cpp',
    'libui/windows/drawpath.cpp',
    'libui/windows/drawtext.cpp',
    'libui/windows/dwrite.cpp',
    'libui/windows/editablecombo.cpp',
    'libui/windows/entry.cpp',
    'libui/windows/events.cpp',
    'libui/windows/fontbutton.cpp',
    'libui/windows/fontdialog.cpp',
    'libui/windows/fontmatch.cpp',
    'libui/windows/form.cpp',
    'libui/windows/graphemes.cpp',
    'libui/windows/grid.cpp',
    'libui/windows/group.cpp',
    'libui/windows/image.cpp',
    'libui/windows/init.cpp',
    'libui/windows/label.cpp',
    'libui/windows/main.cpp',
    'libui/windows/menu.cpp',
    'libui/windows/multilineentry.cpp',
    'libui/windows/opentype.cpp',
    'libui/windows/parent.cpp',
    'libui/windows/progressbar.cpp',
    'libui/windows/radiobuttons.cpp',
    'libui/windows/separator.cpp',
    'libui/windows/sizing.cpp',
    'libui/windows/slider.cpp',
    'libui/windows/spinbox.cpp',
    'libui/windows/stddialogs.cpp',
    'libui/windows/tab.cpp',
    'libui/windows/table.cpp',
    'libui/windows/tabledispinfo.cpp',
    'libui/windows/tabledraw.cpp',
    'libui/windows/tableediting.cpp',
    'libui/windows/tablemetrics.cpp',
    'libui/windows/tabpage.cpp',
    'libui/windows/text.cpp',
    'libui/windows/utf16.cpp',
    'libui/windows/utilwin.cpp',
    'libui/windows/window.cpp',
    'libui/windows/winpublic.cpp',
    'libui/windows/winutil.cpp',
  ]

  # resources.rc only contains the libui manifest.
  # For a DLL, we have to include this directly, so we do so.
  # Windows won't link resources in static libraries, so including this would have no effect.
  # In those cases, we just need them to include the manifest with the executable (or link it directly into the output executable themselves); they can also customize the manifest as they see fit (assuming nothing breaks in the process).
  # if libui_mode == 'shared'
    libui_sources += [
      windows.compile_resources('libui/windows/resources.rc',
        # args: libui_manifest_args,
        depend_files: ['libui/windows/libui.manifest']),
    ]
  # endif

  # TODO prune this list
  foreach lib : ['user32', 'kernel32', 'gdi32', 'comctl32', 'uxtheme', 'msimg32', 'comdlg32', 'd2d1', 'dwrite', 'ole32', 'oleaut32', 'oleacc', 'uuid', 'windowscodecs']
    libui_deps += [
      meson.get_compiler('cpp').find_library(lib,
        required: true),
    ]
  endforeach

  if libui_OS == 'windows' and libui_mode == 'shared' and not libui_MSVC
    error('Sorry, but libui for Windows can currently only be built as a static library with MinGW. You will need to either build as a static library or switch to MSVC.')
  endif

	install_headers('libui/ui_windows.h')
elif libui_OS == 'darwin'
	# subdir('darwin')

  # 23 march 2019

  libui_sources += [
    'libui/darwin/aat.m',
    'libui/darwin/alloc.m',
    'libui/darwin/area.m',
    'libui/darwin/areaevents.m',
    'libui/darwin/attrstr.m',
    'libui/darwin/autolayout.m',
    'libui/darwin/box.m',
    'libui/darwin/button.m',
    'libui/darwin/checkbox.m',
    'libui/darwin/colorbutton.m',
    'libui/darwin/combobox.m',
    'libui/darwin/control.m',
    'libui/darwin/datetimepicker.m',
    'libui/darwin/debug.m',
    'libui/darwin/draw.m',
    'libui/darwin/drawtext.m',
    'libui/darwin/editablecombo.m',
    'libui/darwin/entry.m',
    'libui/darwin/fontbutton.m',
    'libui/darwin/fontmatch.m',
    'libui/darwin/fonttraits.m',
    'libui/darwin/fontvariation.m',
    'libui/darwin/form.m',
    'libui/darwin/future.m',
    'libui/darwin/graphemes.m',
    'libui/darwin/grid.m',
    'libui/darwin/group.m',
    'libui/darwin/image.m',
    'libui/darwin/label.m',
    'libui/darwin/main.m',
    'libui/darwin/map.m',
    'libui/darwin/menu.m',
    'libui/darwin/multilineentry.m',
    'libui/darwin/opentype.m',
    'libui/darwin/progressbar.m',
    'libui/darwin/radiobuttons.m',
    'libui/darwin/scrollview.m',
    'libui/darwin/separator.m',
    'libui/darwin/slider.m',
    'libui/darwin/spinbox.m',
    'libui/darwin/stddialogs.m',
    'libui/darwin/tab.m',
    'libui/darwin/table.m',
    'libui/darwin/tablecolumn.m',
    'libui/darwin/text.m',
    'libui/darwin/undocumented.m',
    'libui/darwin/util.m',
    'libui/darwin/window.m',
    'libui/darwin/winmoveresize.m',
  ]

  libui_deps += [
    meson.get_compiler('objc').find_library('objc',
      required: true),
    dependency('appleframeworks',
      modules: ['Foundation', 'AppKit'],
      required: true),
  ]
  libui_soversion = 'A'
  # the / is required by some older versions of OS X
  libui_rpath = '@executable_path/'

	install_headers('libui/ui_darwin.h')
else
	# subdir('unix')

  # 23 march 2019

  libui_sources += [
    'libui/unix/alloc.c',
    'libui/unix/area.c',
    'libui/unix/attrstr.c',
    'libui/unix/box.c',
    'libui/unix/button.c',
    'libui/unix/cellrendererbutton.c',
    'libui/unix/checkbox.c',
    'libui/unix/child.c',
    'libui/unix/colorbutton.c',
    'libui/unix/combobox.c',
    'libui/unix/control.c',
    'libui/unix/datetimepicker.c',
    'libui/unix/debug.c',
    'libui/unix/draw.c',
    'libui/unix/drawmatrix.c',
    'libui/unix/drawpath.c',
    'libui/unix/drawtext.c',
    'libui/unix/editablecombo.c',
    'libui/unix/entry.c',
    'libui/unix/fontbutton.c',
    'libui/unix/fontmatch.c',
    'libui/unix/form.c',
    'libui/unix/future.c',
    'libui/unix/graphemes.c',
    'libui/unix/grid.c',
    'libui/unix/group.c',
    'libui/unix/image.c',
    'libui/unix/label.c',
    'libui/unix/main.c',
    'libui/unix/menu.c',
    'libui/unix/multilineentry.c',
    'libui/unix/opentype.c',
    'libui/unix/progressbar.c',
    'libui/unix/radiobuttons.c',
    'libui/unix/separator.c',
    'libui/unix/slider.c',
    'libui/unix/spinbox.c',
    'libui/unix/stddialogs.c',
    'libui/unix/tab.c',
    'libui/unix/table.c',
    'libui/unix/tablemodel.c',
    'libui/unix/text.c',
    'libui/unix/util.c',
    'libui/unix/window.c',
  ]

  libui_deps += [
    dependency('gtk+-3.0',
      version: '>=3.10.0',
      # method: 'pkg-config',
      required: true),
    # We specify these as not required because some Unix systems include them with libc instead of providing them as separate files (thanks textshell and jpakkane in freenode #mesonbuild)
    meson.get_compiler('c').find_library('m',
      required: false),
    meson.get_compiler('c').find_library('dl',
      required: false),
  ]
  libui_soversion = '0'
  libui_rpath = '$ORIGIN'

	install_headers('libui/ui_unix.h')
endif

libui_libui = library('ui', libui_sources,
	dependencies: libui_deps,
	build_rpath: libui_rpath,
	install_rpath: libui_rpath,
	name_prefix: 'lib',		# always call it libui, even in Windows DLLs
	install: true,
	gnu_symbol_visibility: 'hidden',
	c_args: ['-Dlibui_EXPORTS'],
	cpp_args: ['-Dlibui_EXPORTS'],
	objc_args: ['-Dlibui_EXPORTS'],
	link_args: libui_libui_link_args,
	soversion: libui_soversion,
	darwin_versions: [])		# TODO
install_headers('libui/ui.h')

# TODO when the API is stable enough to be versioned, create a pkg-config file (https://mesonbuild.com/Pkgconfig-module.html) and a declare_dependency() section too

libui_binary_deps = []
if libui_mode == 'static'
	libui_binary_deps = libui_deps
endif
# subdir('test')
# subdir('examples')

libui_dep = declare_dependency(
  include_directories: include_directories('libui'),
  link_with: libui_libui
)
