---
sidebar_label: Client Configuration
sidebar_position: 4
---

# Setting Client using Debian

In this case, I am using debian for being client. I'll set to connect freeradius using DHCP for its network.

## Create Image Client Using QEMU

Creata QEMU image using this command

```sh
qemu-img create -f qcow2 client-debian.img 35G
```

change ```client-debian.img``` to your desire name.

jalankan boot debian untuk pertama kali

```sh
qemu-system-x86_64 \
-enable-kvm \
-boot order=d \
-cdrom ~/Downloads/debian-12.11.0-amd64-netinst.iso \
-drive file=client-debian.img,format=qcow2,if=virtio \
-m 2G \
-smp 2 \
-netdev user,id=net0,hostfwd=tcp::50022-:22,hostfwd=tcp::14000-:5432 \
-device e1000,netdev=net0 \
-netdev tap,id=net1,ifname=tap2,script=no,downscript=no \
-device virtio-net-pci,netdev=net1,mac=02:11:2a:3b:bc:c6 \
-vga virtio \
-usb -device usb-tablet 
```

### What does this command means?

:::note[Important]
Perhatikan setiap indentasi pada command, karena terkadang tidak terbaca oleh system.
:::
 
## Run Debian (QEMU)

```sh
qemu-system-x86_64 \
-enable-kvm \
#-boot order=d \
# -cdrom ~/Downloads/debian-12.11.0-amd64-netinst.iso \
-drive file=client-debian.img,format=qcow2,if=virtio \
-m 2G \
-smp 2 \
-netdev user,id=net0,hostfwd=tcp::50022-:22,hostfwd=tcp::14000-:5432 \
-device e1000,netdev=net0 \
-netdev tap,id=net1,ifname=tap2,script=no,downscript=no \
-device virtio-net-pci,netdev=net1,mac=02:11:2a:3b:bc:c6 \
-vga virtio \
-usb -device usb-tablet 
```

Perlu di perhatikan, setelah proses installasi selesai, jalankan client debian dengan pertintah di atas dan hilangkan opsi ```-cdrom ~/Downloads/debian-12.11.0-amd64-netinst.iso \``` dan ```#-boot order=d \``` karena kita sudah memboot-nya jadi kita tidak perlu menggunakan iso image lagi.