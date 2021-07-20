# DoHoTor: DNS over HTTPS over TOR!

This is an easily deployable docker service for running your personal DNS
server that resolves DNS queries using HTTPS (DoH) for __security__ and TOR for
__anonymity__.

With DoHoTor, your DNS traffic is no longer connected to you and your workstation!

DoHoTor is built upon

* dnsmasq,
* cloudflared,
* tor, and
* proxychains.

In practice, DoHoTor routes DNS traffic like this:

```mermaid
graph LR

    subgraph DoHoTor
        B(DNSMASQ<br>Public / 53 UDP)
    subgraph Proxychains
        C(Cloudflared Proxy-DNS<br>127.0.0.1:5300)
    end
    end
    A(You) -->|DNS Packet| B
    B --> C
    C--> D
    subgraph TOR
    D(Entry Node)
    D2(Node)
    D3(Exit Node)
    D --> D2
    D2 --> D3
    end
    D3 --> E(1.1.1.1:443)
```

__Deployment__:

```bash
# Optionally fill `hosts` with additional host addresses
touch hosts
docker build -t dohotor ./
docker stack deploy --compose-file docker-stack.yml dohotor
```
