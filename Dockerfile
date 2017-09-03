FROM debian:jessie-slim AS builder

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    ca-certificates \
    cmake \
    curl \
    gettext \
    libboost-system-dev \
    libbz2-dev \
    libssl-dev \
    pkg-config

# peervpn
RUN curl -L https://github.com/peervpn/peervpn/archive/master.tar.gz | tar xz -C /tmp
RUN cd /tmp/peervpn-master \
 && make

# eiskaltdcpp
RUN curl -L https://github.com/eiskaltdcpp/eiskaltdcpp/archive/master.tar.gz | tar xz -C /tmp
RUN mkdir -p /tmp/eiskaltdcpp-master/builddir
RUN cd /tmp/eiskaltdcpp-master/builddir \
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
          ..
RUN cd /tmp/eiskaltdcpp-master/builddir \
 && make

# icecult
RUN curl -L https://github.com/kraiz/icecult/archive/master.tar.gz | tar xz -C /tmp
 
# production image:
FROM debian:jessie-slim
COPY --from=builder /tmp/peervpn-master/peervpn /tmp/eiskaltdcpp-master/builddir/eiskaltdcpp-daemon/eiskaltdcpp-daemon /bin/
COPY --from=builder /tmp/icecult-master /opt/icecult

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    libboost-system1.55.0 \
    python-twisted \
    uhub \
    supervisor
RUN ldd $(which peervpn)
RUN ldd $(which eiskaltdcpp-daemon)
RUN ls /opt/icecult

EXPOSE 80 4000/udp

ADD ./supervisor.conf /etc/supervisor/conf.d/supervisor.conf
CMD ["/usr/bin/supervisord", "-nc", "/etc/supervisor/supervisord.conf"]
