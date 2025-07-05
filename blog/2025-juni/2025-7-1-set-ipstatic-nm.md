---
slug: ip-static-networkmanager
title: Setting Ip Static using NetworkManager
authors: faiz_maulana_habibi
tags: [arch, linux]
---

## Set using NetworkManager

First up, we have to look up into our interface we are using.
To verify write down this command.

```sh
ip link
```
<!-- truncate -->
it will be different in other distro. In my case, it shown up using wlp2s0.
Setting up the IP to static is piece of cake, Just bash it out.

```sh
nmcli connection modify "COE-WIFI" ipv4.addresses 192.168.77.235/24
nmcli connection modify "COE-WIFI" ipv4.gateway 192.168.77.254
nmcli connection modify "COE-WIFI" ipv4.dns "1.1.1.1 8.8.8.8 8.8.4.4"
nmcli connection modify "COE-WIFI" ipv4.method manual
```

:::caution[Important]
Place ```COE_WIFI``` with your actual wifi name.\
```ipv4.addresses your-ip/network-lenght```\
```ipv4.gateway your-gateway```\
```ipv4.dns "8.8.8.8 8.8.4.4"```\
```ipv4.method manual```
:::

:::note[Note]
If you use LAN or Ethernet cable just change its name according to your LAN, like 'wired connection 1'. Just it dude!
:::

Then check your ip using ```ip a```.
And boom! you pull it off dawg!
