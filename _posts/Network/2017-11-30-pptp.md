---
layout: post
title: "PPTP"
date: 2017-11-30 19:45:03 +0800
comments: true
categories: 

---

## PPTP

```
server name or address: 45.32.251.88
user name: vpnuser
password: shadowsocks
```

[PPTP VPN](https://www.vultr.com/docs/setup-a-pptp-vpn-server-on-ubuntu)

### Installing PPTPD

```
apt-get install pptpd
```

### Adding users

``` 
vi /etc/ppp/chap-secrets 
# vpn	pptpd	shadowsocks	*
```

### Edit the PPTPD settings

Change `localip` to your server IP.

```
ifconfig -a
vi /etc/pptpd.conf 

# localip 45.32.251.88
# remoteip 192.168.0.234-238, 192.168.0.245
```

### Update sysctl.conf

```
vi /etc/sysctl.conf 
# net.ipv4.ip_forward = 1
sysctl -p
```

```
vi /etc/ppp/pptpd-options 
# ms-dns 8.8.8.8	
# ms-dns 8.8.4.4
```

### Restarting PPTPD

```
service pptpd restart
netstat -alpn | grep :1723

systemctl start pptpd.service
systemctl enable pptpd.service
```

### iptables

```
ifconfig -a
vi /etc/rc.local
```

```
# Accept all packets via ppp* interfaces (for example, ppp0)
iptables -A INPUT -i ppp+ -j ACCEPT
iptables -A OUTPUT -o ppp+ -j ACCEPT

# Accept incoming connections to port 1723 (PPTP)
iptables -A INPUT -p tcp --dport 1723 -j ACCEPT

# Accept GRE packets
iptables -A INPUT -p 47 -j ACCEPT
iptables -A OUTPUT -p 47 -j ACCEPT

# Enable IP forwarding
iptables -F FORWARD
iptables -A FORWARD -j ACCEPT

# Enable NAT for eth0 on ppp* interfaces
iptables -A POSTROUTING -t nat -o eth0 -j MASQUERADE
iptables -A POSTROUTING -t nat -o ppp+ -j MASQUERADE
```

```
tail -f /var/log/syslog
```

### hosts

```
ping www.tumblr.com

Pinging www.tumblr.com [66.6.42.30] with 32 bytes of data:
Reply from 117.103.177.121: Destination net unreachable.

nslookup

> www.tumblr.com
Server:  google-public-dns-a.google.com
Address:  8.8.8.8

Non-authoritative answer:
Name:    www.tumblr.com.dev.tsinghuax.org
Address:  101.6.244.5
```

Just clear the `/etc/hosts` file.

### MPPE required but peer negotiation failed

I had to enable Point-to-Point encryption(MPPE) in the Advanced Settings dialog.

### tcpdump

ARP: Address Resolution Protocol.

MAC address: Media Access Control address.

`lsb_release`: linux standard base.

```
tcpdump -ennqti eth0 \( arp or icmp \)
```

```
56:00:00:39:b7:93 > fe:00:00:39:b7:93, IPv4, length 102: 45.32.251.88 > 221.229.172.35: ICMP 45.32.251.88 tcp port 22 unreachable, length 68
```

ICMP: Internet Control Message Protocol.

Just correct the script for `l2tpd`.

```
NET_IFO=${VPN_IFACE:-'ens3'}
NET_IFS=$(VPN_IFACE:-'ens3')
```