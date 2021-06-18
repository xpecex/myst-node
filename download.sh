#!/bin/bash

LATEST_VERSION=$(curl -s https://github.com/mysteriumnetwork/node/releases/latest | cut -d '/' -f 8 | cut -d '"' -f 1)

VERSION=${VERSION:-LATEST_VERSION}

SYS_ARCH=$(dpkg --print-architecture)

if [[ $SYS_ARCH == amd64* ]]; then
    echo "X64 Architecture"
    ARCH="amd64"
elif  [[ $SYS_ARCH == armhf* ]] || [[ $SYS_ARCH == armv* ]]; then
    echo "ARM Architecture"
    ARCH="armhf"
elif  [[ $SYS_ARCH == arm64* ]]; then
    echo "ARM Architecture"
    ARCH="arm64"
fi

DOWNLOAD_URL="https://github.com/mysteriumnetwork/node/releases/download/$VERSION/myst_linux_$ARCH.deb"

wget -O /tmp/myst_linux_$VERSION.deb -c $DOWNLOAD_URL