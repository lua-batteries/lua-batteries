# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.5.15] - 2023-05-15

### Added

- [lua](https://www.lua.org/ftp/lua-5.4.6.tar.gz) v5.4.5 -> v5.4.6
- [lua-protobuf](https://github.com/starwing/lua-protobuf) v0.4.2 -> v0.5.0

## [0.5.13] - 2023-05-02

### Added

- [lua](https://www.lua.org/ftp/lua-5.4.5.tar.gz) v5.4.4 -> v5.4.5
- [luasec](https://github.com/brunoos/luasec) v1.3.0 -> v1.3.1

## [0.5.11] - 2023-03-19

### Added

- [luaossl](https://github.com/wahern/luaossl) v20220711
- [lpeg](http://www.inf.puc-rio.br/~roberto/lpeg.html) v1.0.2
- [bit32](https://github.com/lunarmodules/lua-compat-5.3) v5.3.5
- [compat53](https://github.com/lunarmodules/lua-compat-5.3) v0.8
- [xml2lua](https://github.com/manoelcampos/xml2lua) v1.5-2 -> v1.6-1
- [lua-cjson](https://github.com/openresty/lua-cjson) v2.1.0.10 -> v2.1.0.12
- [luasec](https://github.com/brunoos/luasec) v1.2.0 -> v1.3.0
- [openssl](https://github.com/zhaozg/lua-openssl) v0.8.2 -> v0.8.3
- [lua-protobuf](https://github.com/starwing/lua-protobuf) v0.5.1 -> v0.5.2

## [0.5.4] - 2023-02-21

### Added

- [toml](https://github.com/LebJe/toml.lua) v0.2.0 -> v0.3.0

## [0.5.3] - 2023-02-15

### Added

- [luaposix](https://github.com/luaposix/luaposix) v35.1 -> v36.1
- [toml](https://github.com/LebJe/toml.lua) v0.1.1 -> v0.2.0

## [0.5.1] - 2023-01-10

### Added

- [cffi-lua](https://github.com/q66/cffi-lua) v0.2.2 -> v0.2.3

## [0.5.0] - 2023-01-04

### Added

- [luajit](https://luajit.org) v2.0.5 -> v2.1.0-beta3
- [lua-protobuf](https://github.com/starwing/lua-protobuf) v0.4.0 -> v0.4.1

## [0.4.0] - 2022-12-30

### Added

- pkgconfig files for static lua modules.
- New [lua-batteries/luastatic](https://github.com/lua-batteries/luastatic) script.
- New [lua-zip](https://github.com/brimworks/lua-zip) module.
- [luarocks](https://github.com/luarocks/luarocks) v3.9.1 -> v3.9.2
- [luautf8](https://github.com/starwing/luautf8) v0.1.4 -> v0.1.5
- [ltui](https://github.com/tboox/ltui) v2.6 -> v2.7

### Changed

- Luarocks config file moved from `share/lua` to `lib/luarocks/rocks-$LUA_VER`

### Fixed

- [lua-cjson](https://github.com/openresty/lua-cjson) bin scripts.
- [luaposix](https://github.com/luaposix/luaposix) build script.

## [0.3.0] - 2022-11-26

### Added

- [lua-protobuf](https://github.com/starwing/lua-protobuf) library.
- Exported [lua-cjson](https://github.com/openresty/lua-cjson).safe module.

### Changed

- Removed [binser](https://github.com/bakpakin/binser) module.

### Fixed

- [luasocket](https://github.com/lunarmodules/luasocket) `socket` module install path.
- [luasec](https://github.com/brunoos/luasec) `ssl.https` module install path.
- [luv](https://github.com/luvit/luv) MinGW-W64 builds.

## [0.2.0] - 2022-11-21

### Added

- Added libraries and modules.

## [0.1.0] - 2022-11-12

[Unreleased]: https://github.com/lua-batteries/lua-batteries/compare/v0.5.15...HEAD
[0.5.15]: https://github.com/lua-batteries/lua-batteries/compare/v0.5.13...v0.5.15
[0.5.13]: https://github.com/lua-batteries/lua-batteries/compare/v0.5.11...v0.5.13
[0.5.11]: https://github.com/lua-batteries/lua-batteries/compare/v0.5.4...v0.5.11
[0.5.4]: https://github.com/lua-batteries/lua-batteries/compare/v0.5.3...v0.5.4
[0.5.3]: https://github.com/lua-batteries/lua-batteries/compare/v0.5.1...v0.5.3
[0.5.1]: https://github.com/lua-batteries/lua-batteries/compare/v0.5.0...v0.5.1
[0.5.0]: https://github.com/lua-batteries/lua-batteries/compare/v0.4.0...v0.5.0
[0.4.0]: https://github.com/lua-batteries/lua-batteries/compare/v0.3.0...v0.4.0
[0.3.0]: https://github.com/lua-batteries/lua-batteries/compare/v0.2.0...v0.3.0
[0.2.0]: https://github.com/lua-batteries/lua-batteries/compare/v0.1.0...v0.2.0
[0.1.0]: https://github.com/lua-batteries/lua-batteries/compare/302985a...v0.1.0
