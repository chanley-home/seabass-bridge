# Third-Party Software Notices

Third-party software used with seabass-bridge remains under its own license terms and is not relicensed under the seabass-bridge GPL license.

## Raspberry Pi OS

Raspberry Pi OS is the base operating system for this project. It contains software and firmware under multiple licenses.

Official licensing information:
https://www.raspberrypi.com/licensing/

Raspberry Pi OS information:
https://www.raspberrypi.com/software/operating-systems/

## Debian GNU/Linux

Raspberry Pi OS is based on Debian GNU/Linux. Debian is a distribution composed of software from many independent projects, and individual components retain their respective licenses.

Debian licensing information:
https://www.debian.org/legal/licenses/

Debian Social Contract and Debian Free Software Guidelines:
https://www.debian.org/social_contract

Installed package-specific copyright and license information is generally available under:

```text
/usr/share/doc/<package>/copyright
```

No Debian component is relicensed by seabass-bridge.

## VirtualHere

VirtualHere is optional proprietary USB-over-IP software.

This repository does not redistribute VirtualHere software. Users who choose to use VirtualHere must obtain it directly from VirtualHere and comply with its applicable license terms.

Official licensing information:
https://www.virtualhere.com/embedded_server_license

Licensing FAQ:
https://www.virtualhere.com/oem_faq

Purchase information:
https://www.virtualhere.com/purchase

## Packages installed by bootstrap.sh

The bootstrap currently installs these packages from Raspberry Pi OS / Debian repositories:

- ca-certificates
- curl
- git
- jq
- openssh-server
- rsync
- tmux
- usbutils
- v4l-utils

Each package retains its own upstream and Debian packaging license.

## systemd

systemd is supplied by Raspberry Pi OS / Debian and remains under its upstream license. Installed licensing information is normally available at:

```text
/usr/share/doc/systemd/copyright
```

## GitHub Actions

The repository currently references:

- actions/checkout@v4
- ludeeus/action-shellcheck@master

These dependencies remain governed by their respective upstream licenses.
