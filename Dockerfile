FROM ubuntu:latest
MAINTAINER Abzicht <abzicht@gmail.com>


# Install:
# dnsmasq as DNS server
# tor for anonymity
# dnscrypt-proxy for tunnelling DoH over tor
RUN apt-get update \
	&& apt-get install -y dnsmasq dnscrypt-proxy tor ca-certificates \
	&& apt-get autoremove -y \
	&& rm -rf /var/lib/apt/lists/*

RUN update-ca-certificates 2> /dev/null || true

RUN mkdir /app
WORKDIR /app

COPY ./config/dnscrypt-proxy.toml /app/dnscrypt-proxy.toml
COPY ./config/dnsmasq.conf /app/dnsmasq.conf
COPY ./config/trust-anchors.conf /app/trust-anchors.conf
COPY ./entrypoint.sh /app/entrypoint.sh

RUN dnsmasq --test

RUN tor & (sleep 10 && dnscrypt-proxy -service install)

EXPOSE 53/udp
EXPOSE 53/tcp

ENTRYPOINT /app/entrypoint.sh
