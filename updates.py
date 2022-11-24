import os
import re
from slpp import slpp
import sys

if not os.path.exists("manifest-5.4"):
    print("Download https://luarocks.org/manifest-5.4")
    sys.exit(1)

with open("manifest-5.4") as f:
    data = f.read()
    index = data.find("repository = {") + len("repository = {") - 1
    manifest = slpp.decode(data[index:])

    with open("meson.build") as f:
        matches = re.finditer(r"modules/([a-zA-Z0-9_-]*)':\s'([0-9.]*|scm)'", f.read(), re.MULTILINE)

        for match in matches:
            try:
                version = match.group(2)
                versions = list(map(lambda x: x.split("-")[0], manifest[match.group(1)].keys()))
                if version not in versions:
                    print(f"{match.group(1)} ({match.group(2)}): NOT FOUND")
                    continue

                versions = versions[versions.index(version):]
                print(f"{match.group(1)} ({match.group(2)}): {', '.join(versions)}")
            except KeyError:
                continue
