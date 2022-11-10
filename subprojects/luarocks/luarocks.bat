@echo off
set PATH=%~dp0tools;%PATH%
set LUAROCKS_SYSCONFDIR=%~dp0../share/lua
"%~dp0lua" "%~dp0../share/lua/bin/luarocks.lua" config --scope system home_tree "%~dp0.." > nul 2>&1
"%~dp0lua" "%~dp0../share/lua/bin/luarocks.lua" %*
