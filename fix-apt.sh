#!/usr/bin/env bash
# Fixes "Package asterisk has no installation candidate" on Debian 12 (bookworm):
# makes sure the Debian main repo is in apt sources, then refreshes the package lists.
# Usage: sudo ./fix-apt.sh
set -uo pipefail
[[ $EUID -eq 0 ]] || { echo "Run as root: sudo $0" >&2; exit 1; }

echo "== Clock (a wrong date breaks apt) =="
date

echo; echo "== Current sources =="
grep -rh ^deb /etc/apt/sources.list /etc/apt/sources.list.d/ 2>/dev/null
grep -h -A6 '^Types:' /etc/apt/sources.list.d/*.sources 2>/dev/null

if ! grep -rqE 'deb\.debian\.org|ftp\.[a-z.]*debian\.org|^URIs:.*debian' /etc/apt/sources.list /etc/apt/sources.list.d/ 2>/dev/null; then
  echo; echo "No Debian repo found, writing /etc/apt/sources.list"
  [[ -f /etc/apt/sources.list ]] && cp -a /etc/apt/sources.list "/etc/apt/sources.list.bak.$(date +%s)"
  cat > /etc/apt/sources.list <<'LIST'
deb http://deb.debian.org/debian bookworm main contrib non-free-firmware
deb http://deb.debian.org/debian bookworm-updates main contrib non-free-firmware
deb http://security.debian.org/debian-security bookworm-security main contrib non-free-firmware
LIST
else
  echo; echo "A Debian repo is already configured, leaving sources unchanged"
fi

echo; echo "== apt-get update =="
apt-get update 2>&1 | tail -15

echo; echo "== asterisk candidate =="
apt-cache policy asterisk
