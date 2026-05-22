---
title: SSD access denied in Windows
date: 2026-05-20
description: The way how to fix access denied for SSD in Windows
slug: ssd-access-denied-in-windows
authors: faiz_maulana_habibi
tags: [linux]
keywords: [data, ssd, forensic, recover, windows, storage]
image: ./img/access-denied-windows.jpeg
hide_table_of_contents: false

custom_fields:
  og_title: SSD access denied in Windows
  og_description: The way how to fix access denied for SSD in Windows
---

## Case

I have SSD 250Gig and when I plug into my windows PC it says "D:/ Access Denied"

![access-denied](./img/access-denied-windows.jpeg)

## Steps That I have tried

### Step 1 checking SSD in Arch Linux

Using `lsblk -f` command to verify the format type of SSD storage and it was showing me just sda => (sda1 and sda2) no mounting destination appeared.

{/* truncate */}

![try-mounting](./img/try-mounting.webp)

### Step 2 try mounting ntfs in Arch Linux using ntfs-3g

After checking, I tried to mounting manually using ntfs-3g.

```bash
sudo mount -t ntfs-3g /dev/sda2 /mnt/ssd_coe
```

![mounting-ntfs-3g](./img/try-mounting-ntfs-in-archlinux.webp)

When seeing the output, there are some failed messages apparently.


