#!/usr/bin/env bash
# Removes Asterisk and the generated config. Backups in /etc/asterisk.bak.* are kept.
set -euo pipefail
[[ $EUID -eq 0 ]] || { echo "Run as root" >&2; exit 1; }
systemctl disable --now asterisk 2>/dev/null || true
apt-get purge -y asterisk asterisk-core-sounds-en-gsm asterisk-moh-opsound-gsm
rm -f /root/voip-credentials.txt
echo "Removed. (ufw rules left in place; remove with 'ufw status numbered' / 'ufw delete N'.)"
