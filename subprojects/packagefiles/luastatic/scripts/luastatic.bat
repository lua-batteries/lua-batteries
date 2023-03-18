@echo off
"%~dp0@BIN@" "%~dp0../lib/luarocks/rocks-@LUA_VER@/luastatic/@ROCKSPEC_VER@/bin/luastatic.lua" %*
