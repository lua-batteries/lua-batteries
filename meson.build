project(
  'lua-meson',
  version: '5.4.4', # keep same as lua version
  license: 'MIT',
  default_options: [
    'buildtype=release'
  ],
  meson_version: '>=0.63.0'
)

subproject('lua')
subproject('luajit', required: get_option('luajit'))
subproject('luarocks', required: get_option('luarocks'))
