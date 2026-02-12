---
slug: untrusted-gpg-while-update
title: Untrusted GPG Signature When Arch Linux 
authors: faiz_maulana_habibi
tags: [linux, secure, network] 
---

## How to Tackle this?

First thing first, I encounter this issue when updating my arch linux pc and I did in my terminal to updating arch keyring and solve.

![error](./img/untrusted-gpg-signature.png)

Solve 

```
sudo pacman -Sy archlinux-keyring
```