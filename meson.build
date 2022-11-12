project(
  'lua-meson',
  version: '0.1.0',
  license: 'MIT',
  default_options: [
    'buildtype=release'
  ],
  meson_version: '>=0.63.0'
)

config = {'lua': '5.4.4', 'apps': get_option('apps')}

subproject('lua')

if get_option('luajit')
  subproject('luajit')
  config += {'luajit': '2.0.5'}
endif

if get_option('luarocks')
  subproject('luarocks')
  config += {'luarocks': '3.9.1'}
endif

summary(
  config,
  bool_yn: true,
  section: 'Configuration'
)
