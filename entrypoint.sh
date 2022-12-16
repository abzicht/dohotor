#!/bin/bash

echo "Starting DNSCrypt"
dnscrypt-proxy -config /app/dnscrypt-proxy.toml -service start

echo "Running dnsmasq in foreground"
dnsmasq --keep-in-foreground --conf-file=/app/dnsmasq.conf --log-facility=/dev/stdout
