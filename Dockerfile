FROM debian:latest
MAINTAINER Abzicht <abzicht@gmail.com>

# Cloudflared: tunnels DNS over HTTPS (DoH)
ENV CFD_URL https://bin.equinox.io/c/VdrWdbjqyF/cloudflared-stable-linux-amd64.deb
ENV CFD_FILE cloudflared-stable-linux-amd64.deb

# Install:
# dnsmasq as DNS server
# tor for anonymity
# proxychains for tunnelling cloudflared over tor
RUN apt-get update \
	&& apt-get install -y wget dnsmasq proxychains tor \
	&& apt-get autoremove -y \
	&& rm -rf /var/lib/apt/lists/*

# Install Cloudflared
RUN wget -q ${CFD_URL} \
    && dpkg -i ${CFD_FILE}

RUN mkdir /app
WORKDIR /app

COPY ./config/proxychains.conf /etc/proxychains.conf
COPY ./config/dnsmasq.conf /app/dnsmasq.conf
COPY ./config/trust-anchors.conf /app/trust-anchors.conf
COPY ./entrypoint.sh /app/entrypoint.sh

RUN dnsmasq --test

EXPOSE 53/udp
EXPOSE 53/tcp

ENTRYPOINT /app/entrypoint.sh ${UPSTREAM_DNS}
