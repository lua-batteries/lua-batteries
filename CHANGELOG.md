# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- pkgconfig files for static lua modules.
- [luarocks](https://github.com/luarocks/luarocks) v3.9.1 -> v3.9.2
- [luautf8](https://github.com/starwing/luautf8) v0.1.4 -> v0.1.5
- [ltui](https://github.com/tboox/ltui) v2.6 -> v2.7

### Changed

- Luarocks config file moved from `share/lua` to `lib/luarocks/rocks-$LUA_VER`

## Fixed

- [lua-cjson](https://github.com/openresty/lua-cjson) bin scripts.
- [luaposix](https://github.com/luaposix/luaposix) build script.

## [0.3.0] - 2022-11-26

### Added

- [lua-protobuf](https://github.com/starwing/lua-protobuf) library.
- Exported [lua-cjson](https://github.com/openresty/lua-cjson).safe module.

### Changed

- Removed [binser](https://github.com/bakpakin/binser) module.

## Fixed

- [luasocket](https://github.com/lunarmodules/luasocket) `socket` module install path.
- [luasec](https://github.com/brunoos/luasec) `ssl.https` module install path.
- [luv](https://github.com/luvit/luv) MinGW-W64 builds.

## [0.2.0] - 2022-11-21

### Added

- Added libraries and modules.

## [0.1.0] - 2022-11-12

[Unreleased]: https://github.com/clitic/lua-batteries/compare/v0.3.0...HEAD
[0.3.0]: https://github.com/clitic/lua-batteries/compare/v0.2.0...v0.3.0
[0.2.0]: https://github.com/clitic/lua-batteries/compare/v0.1.0...v0.2.0
[0.1.0]: https://github.com/clitic/lua-batteries/compare/302985a...v0.1.0
