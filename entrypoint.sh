#!/bin/bash

echo "Starting Tor"
tor &

echo "Starting DNSCrypt"
sleep 50 && dnscrypt-proxy -config /app/dnscrypt-proxy.toml -service start

echo "Running dnsmasq in foreground"
dnsmasq --keep-in-foreground --conf-file=/app/dnsmasq.conf \
        --addn-hosts=/app/hosts --log-facility=/dev/stdout
