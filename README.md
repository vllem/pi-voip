# pi-voip

One-command Asterisk (PJSIP) PBX for a Raspberry Pi 3B running Debian 12.
Gives you internal extensions, voicemail and an echo test on your LAN.

## Install

```bash
sudo apt-get install -y git
git clone https://github.com/<your-user>/pi-voip.git
cd pi-voip
cp voip.conf.example voip.conf   # optional: change extensions/ports
sudo ./install.sh
```

Passwords are generated and saved to `/root/voip-credentials.txt`
(`sudo cat /root/voip-credentials.txt`). Re-running keeps existing passwords.

## Phones

Use any SIP softphone (Linphone, Zoiper, MicroSIP) or desk phone:

| Setting  | Value                          |
|----------|--------------------------------|
| Server   | Pi's IP address, UDP port 5060 |
| Username | extension, e.g. `1001`         |
| Password | from credentials file          |

## Dial plan

- `1001`-`1003` (or your extensions): ring 25s, then voicemail
- `600`: echo test
- `*97`: your voicemail (PIN is in `/etc/asterisk/voicemail.conf`)

## Notes

- LAN-only by design; do **not** port-forward 5060 to the internet.
- No external trunk is configured; add a provider in `/etc/asterisk/pjsip.conf` if needed.
- Debug: `sudo asterisk -rvvv`, then `pjsip show endpoints`.
- Remove: `sudo ./uninstall.sh`.
