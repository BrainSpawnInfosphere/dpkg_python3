#!/usr/bin/env bash

# check if we are root
if [ "$EUID" -ne 0 ] ; then
  echo "Please run as root"
  exit 1
fi

if [[ $# -ne 1 ]]; then
  echo "Please supply an Python version number"
  echo "ex: ./build-python.sh 3.7.0"
  exit 1
fi

echo "> start"

PYTHON_VERSION=$1
CURRDIR=$(pwd)
# PYTHON_INSTALL_DIR="$CURRDIR/python3/usr/local"
PYTHON_INSTALL_DIR="$CURRDIR/python3/home/pi/.local"
# PYTHON_INSTALL_DIR=/home/pi/.local

echo ""
echo "-------------------------------------------------"
echo "Installing to: $PYTHON_INSTALL_DIR"
echo "-------------------------------------------------"
echo ""

if [[ "$OSTYPE" == "linux-gnu" ]] || [[ "$OSTYPE" == "linux-gnueabihf" ]]; then
    ./update-python3.sh
    apt-get autoremove -y
fi

if [ ! -f Python-$PYTHON_VERSION.tar.xz ]; then
    echo "> Downloading python $PYTHON_VERSION"
    wget https://www.python.org/ftp/python/$PYTHON_VERSION/Python-$PYTHON_VERSION.tar.xz
else
    echo "> Using previously downloaded file"
    rm -fr Python-$PYTHON_VERSION
fi

# setup things
tar xf Python-$PYTHON_VERSION.tar.xz
cd Python-$PYTHON_VERSION
./configure --prefix=$PYTHON_INSTALL_DIR

# make and install
# set the threads and load avg to 4 so we don't have issues
make -j 4 -l 4
make altinstall

# clean up
#rm -fr Python-$PYTHON_VERSION
if [[ "$OSTYPE" == "linux-gnu" ]] || [[ "$OSTYPE" == "linux-gnueabihf" ]]; then
    echo "> Do one more clean up"
    apt-get autoremove -y
    apt-get clean
fi
