#!/usr/bin/env bash

set -e

# check if we are root
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root"
  exit 1
fi

if [[ "$OSTYPE" == "linux-gnu" ]] || [[ "$OSTYPE" == "linux-gnueabihf" ]]; then
	# apt-get update
	apt-get -y upgrade
    apt-get -y install libc6-dev
	apt-get -y install build-essential cmake git pkg-config
	apt-get -y install tk-dev libncurses5-dev libncursesw5-dev libreadline-dev libdb5.3-dev
	apt-get -y install libgdbm-dev libsqlite3-dev libbz2-dev libexpat1-dev
	apt-get -y install liblzma-dev zlib1g-dev mime-support
    apt-get -y install libssl-dev openssl
	apt-get -y install libffi-dev

  echo ""
  echo "Done!"
  echo ""

else
  echo ""
  echo "Sorry, don't support our OS"
  echo ""
fi
