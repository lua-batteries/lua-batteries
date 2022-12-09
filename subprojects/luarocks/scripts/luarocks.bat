@echo off
set PATH=%~dp0tools;%PATH%
set LUAROCKS_SYSCONFDIR=%~dp0../lib/luarocks/rocks-@LUA_VER@
"%~dp0@BIN@" "%~dp0../lib/luarocks/rocks-@LUA_VER@/luarocks/@LUAROCKS_VER@-1/bin/luarocks.lua" config --scope system home_tree "%~dp0.." > nul 2>&1
"%~dp0@BIN@" "%~dp0../lib/luarocks/rocks-@LUA_VER@/luarocks/@LUAROCKS_VER@-1/bin/luarocks.lua" %*
