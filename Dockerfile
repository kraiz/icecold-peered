FROM debian:stretch-slim

RUN set -ex \
 && apt-get update \
 && apt-get install build-essential \
 && git clone https://github.com/peervpn/peervpn.git /tmp/peervpn \
 && cd /tmp/peervpn \
 && ls -lisah
 
