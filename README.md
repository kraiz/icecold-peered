# icecold-peered
docker image combining peervpn with eiskaltdcpp client and icecult webinterface with optional uhub

# command

```
docker run --rm --privileged -v configs/peervpn.conf:/etc/peervpn.conf -v configs/eiskalt_data:/opt/eiskalt_data kraiz/icecold
```
* we need the `privileged` flag for accessing TAP device for `peervpn`
* mount `peervpn.conf` config file
* mount `eiskalt_data` folder which holds temp data and generated configs

# volumes

* `/etc/peervpn.conf`, a configuration file due to (peervpn.net)[https://peervpn.net/]:
  ```
  port <PORT>
  ifconfig4 <IP>/24
  interface eiskalt0
  networkname Eiskalt

  psk <PSK>

  enabletunneling yes
  enablerelay no
  enableprivdrop yes
  user nobody
  group nogroup

  initpeers <host port> <host port>...
  ```
* `/opt/eiskalt_data/`, config and temp data folder. 