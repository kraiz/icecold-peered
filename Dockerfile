FROM debian:stretch-slim

RUN set -ex \
# && apt-get update \
 && apt-get install -y build-essential git \
 && git clone https://github.com/peervpn/peervpn.git /tmp/peervpn \
 && cd /tmp/peervpn \
 && ls -lisah
 
