---
sidebar_title: Qemu Installation on Arch Linux
sidebar_position: 1
---

# Installation

## Qemu Depedencies

Installing qemu base and networking manager. This command will install all of those.

```sh
sudo pacman -S qemu libvirt virt-manager dnsmasq bridge-utils nftables virt-viewer
```

| Packages     | Descriptions                                         |
| :----------- | :--------------------------------------------------- |
| qemu         | it'll install qemu base (for minimal installation).  |
| libvirt      | Manages virtual machines via QEMU/KVM.               |
| virt-manager | GUI tool to manage VMs easily.                       |
| dnsmasq      | Provides DHCP and DNS services for virtual networks. |
| bridge-utils | For bridging host network interfaces.                |
| nftables     | For firewall and NAT setup between VMs and host.     |
| virt-viewer  | For showing the installation process.                |

## Enable Service

Enable service using this command :

```sh
sudo systemctl enable --now libvirtd
```

## Quickstart

using this common command :

```sh
qemu-system-x86_64 \
-m 512M \
-boot d \
-cdrom ~/Documents/OS/alpine-standard-3.22.2-x86_64.iso \
-hda alpine.qcow2 \
-net nic \
-net user
```

## Remote using VNC

```sh
remote-viewer vnc://localhost:5900
```

:::note

The password is root

:::