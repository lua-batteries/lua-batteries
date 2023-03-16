@echo off
"%~dp0@BIN@" "%~dp0../lib/luarocks/rocks-@LUA_VER@/lua-cjson/@ROCKSPEC_VER@/bin/json2lua.lua" %*
