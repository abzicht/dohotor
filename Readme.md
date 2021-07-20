# DoHoTor: DNS over HTTPS over TOR!

This is an easily deployable docker service for running your personal DNS
server that resolves DNS queries using HTTPS (DoH) for __security__ and TOR for
__anonymity__.

With DoHoTor, your DNS traffic is no longer associated with you and your workstation!

DoHoTor is built upon

* dnsmasq,
* cloudflared,
* tor, and
* proxychains.

In practice, DoHoTor routes DNS traffic like this:
[![](https://mermaid.ink/img/eyJjb2RlIjoiZ3JhcGggTFJcbiAgICBcbiAgICBzdWJncmFwaCBEb0hvVG9yXG4gICAgICAgIEIoRE5TTUFTUTxicj5QdWJsaWMgLyA1MyBVRFApXG4gICAgc3ViZ3JhcGggUHJveHljaGFpbnNcbiAgICAgICAgQyhDbG91ZGZsYXJlZCBQcm94eS1ETlM8YnI-MTI3LjAuMC4xOjUzMDApXG4gICAgZW5kXG4gICAgZW5kXG4gICAgQShZb3UpIC0tPnxETlMgUGFja2V0fCBCXG4gICAgQiAtLT4gQ1xuICAgIEMtLT4gRFxuICAgIHN1YmdyYXBoIFRPUlxuICAgIEQoRW50cnkgTm9kZSlcbiAgICBEMihOb2RlKVxuICAgIEQzKEV4aXQgTm9kZSlcbiAgICBEIC0tPiBEMlxuICAgIEQyIC0tPiBEM1xuICAgIGVuZFxuICAgIEQzIC0tPiBFKDEuMS4xLjE6NDQzKSIsIm1lcm1haWQiOnsidGhlbWUiOiJkZWZhdWx0In0sInVwZGF0ZUVkaXRvciI6ZmFsc2UsImF1dG9TeW5jIjp0cnVlLCJ1cGRhdGVEaWFncmFtIjpmYWxzZX0)](https://mermaid-js.github.io/mermaid-live-editor/edit/##eyJjb2RlIjoiZ3JhcGggTFJcbiAgICBcbiAgICBzdWJncmFwaCBEb0hvVG9yXG4gICAgICAgIEIoRE5TTUFTUTxicj5QdWJsaWMgLyA1MyBVRFApXG4gICAgc3ViZ3JhcGggUHJveHljaGFpbnNcbiAgICAgICAgQyhDbG91ZGZsYXJlZCBQcm94eS1ETlM8YnI-MTI3LjAuMC4xOjUzMDApXG4gICAgZW5kXG4gICAgZW5kXG4gICAgQShZb3UpIC0tPnxETlMgUGFja2V0fCBCXG4gICAgQiAtLT4gQ1xuICAgIEMtLT4gRFxuICAgIHN1YmdyYXBoICBUT1JcbiAgICBEKEVudHJ5IE5vZGUpXG4gICAgRDIoTm9kZSlcbiAgICBEMyhFeGl0IE5vZGUpXG4gICAgRCAtLT4gRDJcbiAgICBEMiAtLT4gRDNcbiAgICBlbmRcbiAgICBEMyAtLT4gRSgxLjEuMS4xOjQ0MykiLCJtZXJtYWlkIjoie1xuICBcInRoZW1lXCI6IFwiZGVmYXVsdFwiXG59IiwidXBkYXRlRWRpdG9yIjpmYWxzZSwiYXV0b1N5bmMiOnRydWUsInVwZGF0ZURpYWdyYW0iOmZhbHNlfQ)
<!--mermaid
graph LR

    subgraph DoHoTor
        B(DNSMASQ<br>Public / 53 UDP)
    subgraph Proxychains
        C(Cloudflared Proxy-DNS<br>127.0.0.1:5300)
    end
    end
    A(You) \-\->|DNS Packet| B
    B -\-> C
    C-\-> D
    subgraph TOR
    D(Entry Node)
    D2(Node)
    D3(Exit Node)
    D -\-> D2
    D2 -\-> D3
    end
    D3 -\-> E(1.1.1.1:443)
-->

__Deployment__:

```bash
# Optionally fill `hosts` with additional host addresses
touch hosts
docker build -t dohotor ./
docker stack deploy --compose-file docker-stack.yml dohotor
```

To use a DoH server other than `https://1.1.1.1`, modify `UPSTREAM_DNS` within `docker-stack.yml`.
