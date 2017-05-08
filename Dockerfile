FROM debian:stretch-slim

RUN set -ex \
 && apt-get install build-essiential \
 && git clone https://github.com/peervpn/peervpn.git /tmp/peervpn \
 && cd /tmp/peervpn \
 && ls -lisah
 
