# icecold-peered
docker image combining peervpn with eiskaltdcpp client and icecult webinterface (TODO: with optional uhub and nusbot)

# command

```
docker run --rm --privileged \
 -v /path/to/peervpn.conf:/etc/peervpn.conf \
 -v /path/to/eiskalt:/opt/eiskalt \
 -p 7000:7000/udp
 -p 8008:80
   kraiz/icecold
```
* for `peervpn` we need access to TAP device, so we have 2 options:
  * add `--device="/dev/net/run" --add_cap="NET_ADMIN"` (recommended but not possible everywhere (synology nas))
  * add `--privileged` which is kind of root access in includes the cap above

# ports
* `7000` is the vpn port, forward traffic from your route here
* `80` is the webinterface for you to open in browser

# volumes
* `/etc/peervpn.conf`, a configuration file due to (peervpn.net)[https://peervpn.net/]:
  ```
  port <PORT>
  ifconfig4 <IP>/24
  interface ice0
  networkname Icecold

  psk <PSK>

  enabletunneling yes
  enablerelay no
  enableprivdrop yes
  user nobody
  group nogroup

  initpeers <host port> <host port>...
  ```
* `/opt/eiskalt/`, config and temp data folder. Add 2 files manually before starting:
  * `DCPlusPlus.xml`:
  ```
  <?xml version="1.0" encoding="utf-8" standalone="yes"?>
  <DCPlusPlus>
    <Settings>
     <Nick type="string">MYNICK</Nick>
     <DownloadDirectory type="string">/opt/downloads/</DownloadDirectory>
     <MaxDownloadSpeedMain type="int">0</MaxDownloadSpeedMain>
     <MaxUploadSpeedMain type="int">0</MaxUploadSpeedMain>
    </Settings>
    <Share>
      <Directory Virtual="share1">/opt/share/share1/</Directory>
      <Directory Virtual="stuff">/opt/share/stuff/</Directory>
    </Share>
  </DCPlusPlus>

  ```
  * `Favorites.xml`:
  ```
  <?xml version="1.0" encoding="utf-8" standalone="yes"?>
  <Favorites>
    <Hubs>
      <Hub Name="muhub" Connect="1" Nick="<NICK>" Password="" Server="adc://<HUBIP>:<HUBPORT>" />
    </Hubs>
    <Users/>
    <UserCommands/>
    <FavoriteDirs/>
  </Favorites>
  ```
* `/opt/share/`, mount anything you want to share below this folder. Should match direcotries of `DCPlusPlus.xml`.