---
slug: pipewire
title: PipeWire Installation Arch
authors: faiz_maulana_habibi
tags: [linux, secure] 
---

## Installation on Arch Linux

:::note[Note]
Remove PulseAudio if you utilize before.

```sh
sudo pacman -Rns pulseaudio
```

:::

```sh
sudo pacman -S pipewire wireplumber pipewire-pulse pipewire-alsa
```

<!-- truncate -->

## Enable it

Run with no sudo because dbus run in tty.

```
systemctl --user enable --now pipewire pipewire-pulse wireplumber
```

## Verify service 

```sh
systemctl --user status pipewire
```