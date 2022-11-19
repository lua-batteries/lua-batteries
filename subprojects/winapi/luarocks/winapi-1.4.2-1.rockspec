package = "winapi"
version = "1.4.2-1"

source = {
  dir="winapi",
  url = "https://stevedonovan.github.com/files/winapi-1.4.2-src.zip"
}

description = {
  summary = "Minimal but useful bindings to Windows API",
  detailed = [[
winapi can enumerate and access windows and process, read and write to the
registry, monitor filesystem changes and provides flexible ways to launch processes.
  ]],
  homepage='https://stevedonovan.github.io/winapi/api.html',
  maintainer='steve.j.donovan@gmail.com',
  license = "MIT/X11",
}

supported_platforms = {"win32","mingw32"}

build = {
  type = "builtin",
  modules = {
    winapi = {
        sources = {'winapi.c', 'wutils.c'},
        libraries = {'user32','Advapi32','shell32','psapi','Mpr'},
        defines = {'PSAPI_VERSION=1'}
    }
  },
  copy_directories = {'docs'}
}


