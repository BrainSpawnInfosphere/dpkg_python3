#!/usr/bin/env bash

# dpkg-deb --build python3
# mv python3-kevin.deb ../packages

if [[ $# -ne 1 ]]; then
  echo "Please supply an Python version number"
  echo "ex: ./build-pkg.sh 3.4.0"
  exit 1
fi

VERSION=$1

DEBPKG=kevin-python-${VERSION}.deb


if [ -f  ${DEBPKG} ]; then
  rm -f ${DEBPKG}
fi

# clean out debian info and recreate it
rm -fr ./python3/DEBIAN
mkdir -p ./python3/DEBIAN

cat <<EOF >./python3/DEBIAN/control
Package: kevin-python3
Architecture: all
Maintainer: Kevin
Depends: debconf (>= 0.5.00)
Priority: optional
Version: ${VERSION}
Description: Kevins python 3
EOF

cat <<EOF >./python3/DEBIAN/copyright
Format: http://www.debian.org/doc/packaging-manuals/copyright-format/1.0/
Upstream-Name: kevin-python3
Upstream-Contact: Name, <email@address>

Files: *
Copyright: 2011, Name, <email@address>
License: (MIT)
Full text of licence.

Unless there is a it can be found in /usr/share/common-licenses
EOF

cat <<EOF >./python3/DEBIAN/preinst
rm -fr /usr/lib/python3
rm -fr /usr/lib/python3.5
EOF


# was: usr/*
cat <<EOF >./python3/DEBIAN/install
home/pi/.local/*
EOF

cat <<EOF >./python3/DEBIAN/postinst
#!/bin/bash
set -e

echo ""
echo "============================="
echo "| Linking libraries         |"
echo "============================="
echo ""
ldconfig

echo ""
echo "============================="
echo "| Fixing pip/python links   |"
echo "============================="
echo ""
#LOCAL=/home/pi/.local/bin
#ln -s ${LOCAL}/pip3.7 ${LOCAL}/pip3
ln -s /home/pi/.local/bin/python3.7 /home/pi/.local/bin/python3
wget https://bootstrap.pypa.io/get-pip.py && /home/pi/.local/bin/python3.7 get-pip.py
/home/pi/.local/bin/pip3 install -U setuptools wheel

echo ""
echo "============================="
echo "| Clean up and fix perms    |"
echo "============================="
echo ""

chown -R pi:pi /home/pi
chown -R pi:pi /usr/local

echo ""
echo "============================="
echo "|      <<< Done >>>         |"
echo "============================="
echo ""
EOF

# clean out stupid macOS trash
find . -type f -name '._*' -exec rm {} +
find . -type f -name '.DS_Store' -exec rm {} +

# fix permissions
chmod 0755 ./python3/DEBIAN/*

echo " > building Python ${VERSION}"
echo ""
dpkg-deb -v --build python3 ${DEBPKG}

echo ""
echo " > reading debian package:"
echo ""
dpkg-deb --info ${DEBPKG}
