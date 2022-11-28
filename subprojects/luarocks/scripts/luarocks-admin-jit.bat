@echo off
set LUA_VER=5.1
set LUAROCKS_BIN_DIR=%~dp0../lib/luarocks/rocks-%LUA_VER%/luarocks/3.9.1-1/bin
set PATH=%~dp0tools;%PATH%
set LUAROCKS_SYSCONFDIR=%~dp0../lib/luarocks/rocks-%LUA_VER%
"%~dp0luajit" "%LUAROCKS_BIN_DIR%/luarocks.lua" config --scope system home_tree "%~dp0.." > nul 2>&1
"%~dp0luajit" "%LUAROCKS_BIN_DIR%/luarocks-admin.lua" %*
