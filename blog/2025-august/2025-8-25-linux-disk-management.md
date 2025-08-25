---
slug: disk-management
title: Linux Disk Management 
authors: faiz_maulana_habibi
tags: [linux, secure] 
---

# Linux Disk Management (lsblk, mount, umount, format, wipe)

## Cek Disk & Partisi

Gunakan `lsblk` untuk melihat daftar device dan filesystem:

```bash
lsblk -f
```

<!-- truncate -->

```sh
NAME        FSTYPE FSVER LABEL    UUID                                 FSAVAIL FSUSE% MOUNTPOINTS
sda
├─sda1
├─sda2      ntfs         DATA     A61087D71087ACBD
└─sda3      btrfs                 25902326-073a-4842-9c65-ad8d62222771  254.1G    15% /
sdb
nvme0n1
├─nvme0n1p1 ntfs         Recovery 1ED80811D807E63D
├─nvme0n1p2 vfat   FAT32          5A08-EE40                              58.7M    39% /boot/efi
├─nvme0n1p3
└─nvme0n1p4 ntfs         OS       5A360D4B360D2A19
```
## Format Disk
In linux, ensure the package is available.

```sh
sudo pacman -S dosfstools
```

Example format to EXT32:

```sh
sudo mkfs.vfat -F 32 /dev/sdb1
```

:::caution[Attention]
Hati-hati: /dev/sdb1 adalah partisi, bukan seluruh disk (/dev/sdb).
:::

## Mount (pasang filesystem)

Buat folder mountpoint:

```sh
sudo mkdir -p /mnt/usb
```

Mount:

```sh
sudo mount /dev/sdb1 /mnt/usb
```

Cek hasil:

```sh
ls /mnt/usb
df -h | grep sdb
```

## Umount (lepas filesystem)

```sh
sudo umount /dev/sdb1

# or

sudo umount -l /mnt/usb   # lazy umount
sudo umount -f /mnt/usb   # force umount (hati-hati)
```

:::warning[Attention]
Jika device busy, bisa lakukan cara ini.

```sh
sudo umount -l /mnt/usb   # lazy umount
sudo umount -f /mnt/usb   # force umount (hati-hati)
```

Tapi saya lebih merekomendasikan untuk keluar dari direktory yang mau di `umount` terlebih dahulu. (**lebih aman**)
:::

## Advanced Mount Options

Mount dengan opsi:

```sh
sudo mount -t vfat -o uid=1000,gid=1000,umask=022 /dev/sdb1 /mnt/usb
```

Opsi penting:
    - ro → read-only
    - rw → read-write
    - noexec → cegah eksekusi file biner
    - nosuid → abaikan SUID/SGID
    - nodev → abaikan device file

Mount berdasarkan UUID / LABEL:

```sh
sudo mount UUID=5A08-EE40 /mnt/usb
sudo mount LABEL=DATA /mnt/usb
```

Bind mount (pasang folder ke folder lain):

```sh
sudo mount --bind /home/user/Downloads /mnt/usb
```

Mount ISO/IMG:

```sh
sudo mount -o loop archlinux.iso /mnt/iso
```

## Hapus Filesystem (Wipe)

Hilangkan signature filesystem:

```sh
sudo wipefs -a /dev/sdb
```

Overwrite awal disk (100MB pertama):
 
```sh
sudo dd if=/dev/zero of=/dev/sdb bs=1M count=100
```

Hapus partisi:

```sh
sudo fdisk /dev/sdb
# Tekan d untuk delete, w untuk simpan
```