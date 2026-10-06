#!/usr/bin/env bash
# Prints info needed to debug "Package asterisk has no installation candidate".
# Usage: sudo ./diagnose.sh
echo "== OS / arch =="
head -3 /etc/os-release
dpkg --print-architecture
echo
echo "== apt sources =="
grep -rh ^deb /etc/apt/sources.list /etc/apt/sources.list.d/ 2>/dev/null
grep -rh -A8 '^Types:' /etc/apt/sources.list.d/*.sources 2>/dev/null
echo
echo "== apt-get update =="
apt-get update 2>&1 | tail -15
echo
echo "== apt-cache policy asterisk =="
apt-cache policy asterisk
