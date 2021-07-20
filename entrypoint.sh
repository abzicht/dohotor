#!/bin/bash

echo "Starting Tor"
tor &

echo "Running Cloudflared over Proxychains"
proxychains cloudflared proxy-dns --port 5300 --address 127.0.0.1 --upstream $1 &

echo "Starting dnsmasq in foreground"
dnsmasq --keep-in-foreground --conf-file=/app/dnsmasq.conf \
        --addn-hosts=/app/hosts --log-facility=/dev/stdout
