project(
  'lua-meson',
  version: '5.4.4+2.0.5+3.9.1', # lua+luajit+luarocks
  license: 'MIT',
  default_options: [
    'buildtype=release'
  ],
  meson_version: '>=0.63.0'
)

subproject('lua')

if get_option('luajit')
  subproject('luajit')
endif

if get_option('luarocks')
  subproject('luarocks')
endif
