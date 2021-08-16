#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "mkdockerfile.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM ubuntu:hirsute
RUN /bin/echo -e '#!/bin/bash\n\
\n\
set -ex\n\
\n\
export DEBIAN_FRONTEND=noninteractive\n\
\n\
install_ref="${PKG_INSTALL_REF}"\n\
\n\
if [ -z "${install_ref}" ]; then\n\
    echo ::error "Cannot determine package install ref."\n\
    exit 1\n\
fi\n\
\n\
dist="${PKG_PLATFORM_VERSION}"\n\
if [ -n "${PKG_SUBDIST}" ]; then\n\
    dist+=".${PKG_SUBDIST}"\n\
fi\n\
\n\
apt-get update\n\
apt-get install -y curl gnupg apt-transport-https ncurses-bin\n\
curl https://packages.edgedb.com/keys/edgedb.asc | apt-key add -\n\
echo deb [arch=amd64] https://packages.edgedb.com/apt ${dist} main \\\n\
    >> /etc/apt/sources.list.d/edgedb.list\n\
\n\
if [ "$1" == "bash" ]; then\n\
    exec /bin/bash\n\
fi\n\
\n\
try=1\n\
while [ $try -le 30 ]; do\n\
    apt-get update && apt-get install -y "${install_ref}" && break || true\n\
    try=$(( $try + 1 ))\n\
    echo "Retrying in 10 seconds (try #${try})"\n\
    sleep 10\n\
done\n\
\n\
edgedb-server-${slot} --help\n\
edgedb --help\n\' >/entrypoint.sh

RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]