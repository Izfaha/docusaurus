---
sidebar_title: Quick Start
sidebar_position: 2
---

# Debian - VM

- When first installing no GUI

```sh
qemu-system-x86_64 \
-enable-kvm \
-m 1G \
-smp 2 \
-hda debian.qcow2 \
-cdrom ~/Documents/OS/debian-13.2.0-amd64-netinst.iso \
-boot d \
-netdev user,id=net0 \
-device virtio-net-pci,netdev=net0 \
-nographic
```

[qemu-no-graphic]
ketika sudah di 'Promt Bootloader' qemu type Esc or space or enter or Ctrl + C

langsung tulis

boot: install console=ttyS0

- kalo installasi nya udah selesai Ctrl + C aja atau langsung terminate (aman)

- after install (pake conf ini)

```sh
qemu-system-x86_64 \
-enable-kvm \
-m 1G \
-smp 2 \
-hda debian.qcow2 \
-netdev user,id=net0,hostfwd=tcp::2222-:22 \
-device virtio-net-pci,netdev=net0 \
-nographic
```

Note : kalo ndak bisa sudo

- su -
- update & upgrade
- apt install sudo
- usermod -aG sudo izfaha/namauser
- exit (sampe logout lalu login lagi)
