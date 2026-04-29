---
slug: fix-flameshot
title: Fix flameshot "Unable to capture" in Waylan GNOME 
authors: [faiz_maulana_habibi]
tags: [docusaurus, linux]
---

Recently I faced an error flameshot "Unable to capture" in Waylan GNOME.

:::note
Here, I am using Arch Linux GNOME and I utilizing flameshot as my primary capturing tool.
:::

<!-- truncate -->

## How do I solve?

just add 

```sh 
vim ~/.local/bin/flameshot-wayland
```

inside it, just paste 

```
#!/bin/bash
env QT_QPA_PLATFORM=wayland flameshot gui --delay 500
```

what does it mean? it is just trigger a command before it crush to waylan configuration or 
flameshot is waiting for waylan permission before capturing screen action.