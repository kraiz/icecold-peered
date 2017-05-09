FROM debian:jessie-slim

ENV BUILD_PACKAGES="build-essential cmake curl gettext libbz2-dev libssl-dev libboost-system-dev pkg-config" \
    RUNTIME_PACKAGES="ca-certificates"

RUN set -ex \
 && apt-get update \
 && apt-get install -y --no-install-recommends $BUILD_PACKAGES $RUNTIME_PACKAGES \
# peervpn
 && curl -L https://github.com/peervpn/peervpn/archive/master.tar.gz | tar xz -C /tmp \
 && cd /tmp/peervpn-master \
 && make \
 && make install \
 && ldd $(which peervpn) \
# eiskaltdcpp
 && curl -L https://github.com/eiskaltdcpp/eiskaltdcpp/archive/master.tar.gz | tar xz -C /tmp \
 && cd /tmp/eiskaltdcpp-master \
 && mkdir -p builddir \
 && cd builddir \
 && cmake -DCMAKE_BUILD_TYPE=Release \
          -DNO_UI_DAEMON=ON \
          -DJSONRPC_DAEMON=ON \
          -DLOCAL_JSONCPP=ON \
          -DUSE_QT=OFF \
          -DUSE_QT5=OFF \
          -DUSE_IDNA=OFF \
          -DFREE_SPACE_BAR_C=OFF \
          -DLINK=STATIC \
          -Dlinguas="" \
          .. \
 && make \
 && make install \
 && ldd $(which eiskaltdcpp-daemon) \
# cleanup
 && apt-get remove -y --purge $BUILD_PACKAGES $(apt-mark showauto) \
 && rm -rf /tmp/* /var/lib/apt/lists/*
