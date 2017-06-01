
#! /home/pi/oprint/bin/python

"""
installs a package only if package exists
:params: pkg_name(str), pkg_url(str)
:returns: exit code
"""

import pip
import sys

def pkg_in_venv(pkg):
    packages = pip.utils.get_installed_distributions()
    return pkg in [p.project_name for p in packages]

def install_pkg(pkg):
    return pip.main(['install', pkg])

if __name__ == '__main__':
    pkg = sys.argv[1]
    url = sys.argv[2]
    if pkg_in_venv(pkg):
        install_pkg(url)
    sys.exit(0)
