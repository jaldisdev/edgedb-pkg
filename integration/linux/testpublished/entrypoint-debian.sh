#!/bin/bash

set -ex

export DEBIAN_FRONTEND=noninteractive

slot="${PKG_VERSION_SLOT}"

if [ -z "${slot}" ]; then
    echo ::error "Cannot determine package version slot."
    exit 1
fi

dist="${PKG_PLATFORM_VERSION}"
if [ -n "${PKG_SUBDIST}" ]; then
    dist+=".${PKG_SUBDIST}"
fi

echo "Pausing for 30 seconds to let the package repo settle..."
sleep 30

apt-get update
apt-get install -y curl gnupg apt-transport-https
curl https://packages.edgedb.com/keys/edgedb.asc | apt-key add -
echo deb [arch=amd64] https://packages.edgedb.com/apt ${dist} main \
    >> /etc/apt/sources.list.d/edgedb.list

try=1
while [ $try -le 30 ]; do
    apt-get update && break || true
    try=$(( $try + 1 ))
    echo "Retrying in 10 seconds (try #${try})"
    sleep 10
done

try=1
while [ $try -le 30 ]; do
    apt-get install -y edgedb-${slot} && break || true
    try=$(( $try + 1 ))
    echo "Retrying in 10 seconds (try #${try})"
    sleep 10
done

edgedb --help