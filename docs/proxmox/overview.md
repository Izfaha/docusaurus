---
title: Proxmox VE Overview
sidebar_label: Proxmox VE Overview
description: Inroduction to Proxmox VE, virtualization platform Linux based for managing virtual machine and container.
keywords:
  - proxmox
  - proxmox ve
  - virtualization
  - hypervisor
  - virtual machine
  - kvm
  - lxc
  - linux bridge
  - homelab
---

Today, I learn Proxmox VE 9.2 on Virtual Box. I just wonder how big techs manage their data centers lol :). This is specification of my VM lab. I do apologize if my documentation is not clear enough to understand.

VM Spec :

| Hostname | CPU | Memory | Interfaces |
| ----- | ----- | ----- | ----- |
| Proxmox VE 9.2 | 4 | 8GB | Nat (IP Manager) and bridge |

## Dashboard

Proxmox give us a web interface to easily managed, like this. 

![proxmox-ve-dashboard](./img/proxmox-dashboard.webp)

Look prety cool, all is set and just click it up not overwhemed like managing openstack lol, which needs at least 2 nodes. Back to the point, on this dashboard we can create VM or Container, also managing VM network through it. this is [iso file](https://www.proxmox.com/en/products/proxmox-virtual-environment/get-started) for proxmox version 9.2 when I write this article. 

## Upload ISO 

Let's try uploading iso to proxmox, click `local (izfaha)` inside parentheses will be your hostname, in this case `izfaha` is my hostname.

Then, click `ISO Images` and look for and click `Upload` button. 

:::note
You can get image via upload and download from URL.
:::

![place-iso-in-proxmox](./img/upload-proxmox-iso.webp)

After hit `Upload` button, you will be served an upload pop up, just hit `Select File` then `Upload`.

![select-iso](./img/select-iso-proxmox.webp)

There will be pup up showing the uploading process, just wait and drink your americano :p.

![upload-iso-process](./img/upload-iso-process.webp)

While uploading process you will see this task viewer output, see on status now the status process is `running` means upload process have not completed, just wait until status `stopped:OK`.

![task-viewer-output](./img/task-viewer-output.webp)

![task-viewer-status](./img/task-viewer-status.webp)

status `stopped:OK`

![status-ok](./img/task-viewer-status-ok.webp)

or until there is text on `Output`:

```
finished file import successfully
TASK OK
```

![output](./img/task-viewer-output-success.webp)

Done upload.

## Create new Virtual Machine

