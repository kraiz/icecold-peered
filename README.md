# icecold-peered
docker image combining peervpn with eiskaltdcpp client and icecult webinterface with optional uhub

# command

```
docker run --privileged -v peervpn.conf:/etc/peervpn.conf kraiz/icecold
```
* we need the `privileged` flag for accessing TAP device for `peervpn`
* mount `peervpn.conf` config file