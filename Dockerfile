FROM debian:stretch-slim

RUN set -ex \
 && apt-get update \
 && apt-get install -y build-essential git \
 && git clone https://github.com/peervpn/peervpn.git /tmp/peervpn \
 && cd /tmp/peervpn \
 && make \
 && ls -lisah \
 && mv peervpn /usr/bin \
 && peervpn --help
 
