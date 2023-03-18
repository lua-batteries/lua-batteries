project(
	'tomlplusplus',
	'cpp',
	license: 'MIT',
	version: '3.3.0',
	meson_version: '>=0.61.0',
	default_options: [
		'b_lto=false',
		'b_ndebug=if-release',
		'cpp_std=c++17'
	]
)

tomlplusplus_dep = declare_dependency(
	include_directories: include_directories('.')
)
