# Architecture

```text
                Home LAN / Wi-Fi
                      |
            +---------+---------+
            |                   |
      Main workstation      Synology NAS
                                |
                         images / backups
                                |
                         future recovery
                                |
                         +------+------+
                         | Raspberry Pi |
                         | Model 4B     |
                         | seabass-bridge
                         +------+------+
                                |
                         USB / camera devices
```

## Raspberry Pi

- Raspberry Pi OS Lite 64-bit
- SSH administration
- USB enumeration and diagnostics
- Camera-device detection
- Startup health logging
- Future optional service modules

## GitHub

- Bootstrap script
- Version-controlled configuration
- systemd units
- Documentation
- Recovery procedure

## Synology

The NAS can later hold known-good Pi images and recovery artifacts. Because the endpoint will use Wi-Fi, direct Pi firmware network boot is not part of this first build.
