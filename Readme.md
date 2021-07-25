# DoHoTor: DNS over HTTPS over TOR!

This is an easily deployable docker service for running your personal DNS
server that resolves DNS queries using HTTPS (DoH) for __security__ and TOR for
__anonymity__. The original idea and parts of the underlying structure are taken from [@alexmuffet](https://github.com/alecmuffett/dohot).

With DoHoTor, your DNS traffic is no longer associated with you and your workstation!

DoHoTor is built upon

* dnsmasq,
* dnscrypt-proxy, and
* tor.

In practice, DoHoTor routes DNS traffic like this:
[![](https://mermaid.ink/img/eyJjb2RlIjoiZ3JhcGggTFJcbiAgICBcbiAgICBzdWJncmFwaCBEb0hvVG9yXG4gICAgICAgIEIoRE5TTUFTUTxicj5QdWJsaWMgLyA1MylcbiAgICAgICAgQiAtLT4gQjEoSG9zdHMgZmlsZSlcbiAgICBzdWJncmFwaCBUb3IgUHJveHlcbiAgICAgICAgQyhETlNDcnlwdDxicj4xMjcuMC4wLjE6NTMwMClcbiAgICBlbmRcbiAgICBlbmRcbiAgICBBKFlvdSkgLS0-fEROUyBQYWNrZXR8IEJcbiAgICBCIC0tPiBDXG4gICAgQy0tPiBEXG4gICAgc3ViZ3JhcGggIFRPUlxuICAgIEQoRW50cnkgTm9kZSlcbiAgICBEMihOb2RlKVxuICAgIEQzKEV4aXQgTm9kZSlcbiAgICBEIC0tPiBEMlxuICAgIEQyIC0tPiBEM1xuICAgIGVuZFxuICAgIEQzIC0tPiBFKEROUyBTZXJ2ZXIpIiwibWVybWFpZCI6eyJ0aGVtZSI6ImRlZmF1bHQifSwidXBkYXRlRWRpdG9yIjpmYWxzZSwiYXV0b1N5bmMiOnRydWUsInVwZGF0ZURpYWdyYW0iOmZhbHNlfQ)](https://mermaid-js.github.io/mermaid-live-editor/edit/##eyJjb2RlIjoiZ3JhcGggTFJcbiAgICBcbiAgICBzdWJncmFwaCBEb0hvVG9yXG4gICAgICAgIEIoRE5TTUFTUTxicj5QdWJsaWMgLyA1MylcbiAgICAgICAgQiAtLT4gQjEoSG9zdHMgZmlsZSlcbiAgICBzdWJncmFwaCBUb3IgUHJveHlcbiAgICAgICAgQyhETlNDcnlwdDxicj4xMjcuMC4wLjE6NTMwMClcbiAgICBlbmRcbiAgICBlbmRcbiAgICBBKFlvdSkgLS0-fEROUyBQYWNrZXR8IEJcbiAgICBCIC0tPiBDXG4gICAgQy0tPiBEXG4gICAgc3ViZ3JhcGggIFRPUlxuICAgIEQoRW50cnkgTm9kZSlcbiAgICBEMihOb2RlKVxuICAgIEQzKEV4aXQgTm9kZSlcbiAgICBEIC0tPiBEMlxuICAgIEQyIC0tPiBEM1xuICAgIGVuZFxuICAgIEQzIC0tPiBFKEROUyBTZXJ2ZSkiLCJtZXJtYWlkIjoie1xuICBcInRoZW1lXCI6IFwiZGVmYXVsdFwiXG59IiwidXBkYXRlRWRpdG9yIjpmYWxzZSwiYXV0b1N5bmMiOnRydWUsInVwZGF0ZURpYWdyYW0iOmZhbHNlfQ)
<!--mermaid
graph LR
    
    subgraph DoHoTor
        B(DNSMASQ<br>Public / 53)
        B -/-> B1(Hosts file)
    subgraph Tor Proxy
        C(DNSCrypt<br>127.0.0.1:5300)
    end
    end
    A(You) -/->|DNS Packet| B
    B -/-> C
    C-/-> D
    subgraph  TOR
    D(Entry Node)
    D2(Node)
    D3(Exit Node)
    D -/-> D2
    D2 -/-> D3
    end
    D3 -/-> E(DNS Server)
-->

__Deployment:__

```bash
# Optionally fill `hosts` with additional host addresses
touch hosts
# Option A: Run as service
docker stack deploy --compose-file docker-stack.yml dohotor
# Option B: Run as container
docker run -p "53:53/udp" -p "53:53/tcp" --name "DoHoTor" \
	--mount type=bind,src=/absolute/path/to/hosts,dst=/app/hosts \
	abzicht/dohotor:latest
```
