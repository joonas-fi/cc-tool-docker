![Build status](https://github.com/joonas-fi/cc-tool-docker/workflows/Build/badge.svg)
[![Download](https://img.shields.io/docker/pulls/joonas/cc-tool.svg?style=for-the-badge)](https://hub.docker.com/r/joonas/cc-tool/)

Small-ish [cc-tool](https://github.com/dashesy/cc-tool) Docker image to 
[flash your CC2531 Zigbee dongle](https://www.zigbee2mqtt.io/information/flashing_the_cc2531.html).


How to use
----------

You can find [firmware files from here](https://github.com/Koenkk/Z-Stack-firmware).

```console
$ mkdir cc2531-flash && cd cc2531-flash/
$ # download firmware file here...
$ docker run --privileged --rm -it -v "$(pwd):/workspace" joonas/cc-tool -e -w CC2531ZNP-Prod.hex
```

The `--privileged` is required for USB access. I guess one could map a single `--device` but I couldn't
be bothered to find out the particular device for the debugger device.


Prior art
---------

- https://github.com/alexalex89/docker-cc-tool (2 years old)
