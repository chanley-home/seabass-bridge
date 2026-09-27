# Installation

## Flash the Pi

Use Raspberry Pi Imager and select Raspberry Pi OS Lite 64-bit for Raspberry Pi 4.

In Imager customization:

- Set hostname to `seabass-bridge`
- Configure Wi-Fi
- Set the wireless country
- Enable SSH
- Create the administrator account

The Pi 4 does not firmware-netboot over its onboard Wi-Fi, so the first build uses a small replaceable SD card while GitHub remains the configuration source of truth.

## First boot

```bash
sudo apt update
sudo apt full-upgrade -y
sudo reboot
```

## Bootstrap

```bash
sudo apt update
sudo apt install -y git
git clone https://github.com/chanley-home/seabass-bridge.git
cd seabass-bridge
sudo ./bootstrap.sh
sudo reboot
```

## Verify

```bash
hostname
systemctl status ssh --no-pager
systemctl status seabass-health --no-pager
/opt/seabass-bridge/scripts/diagnostics.sh
```

Expected hostname:

```text
seabass-bridge
```

## Rebuild

If the SD card is replaced, flash Raspberry Pi OS Lite 64-bit again, restore Wi-Fi/SSH settings in Imager, clone this repo, and rerun `sudo ./bootstrap.sh`.
