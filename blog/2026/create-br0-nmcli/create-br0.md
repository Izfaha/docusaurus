---
title: Alur dan Estimasi Pengiriman Impor China ke Indonesia via Buying Agent
date: 2026-05-22
description: tulis deskripsi
slug: create-br0-using-nmcli
authors: faiz_maulana_habibi
keywords: [data, ssd, forensic, recover, windows, storage, buying agent, china, forwarder, 1688, taobao]
# image: ./img/access-denied-windows.jpeg
hide_table_of_contents: false

custom_fields:
  og_title: Alur dan Estimasi Pengiriman Impor China ke Indonesia via Buying Agent
  og_description: Panduan lengkap alur pengiriman barang impor dari China ke Indonesia melalui buying agent (Ducking ID), mulai dari proses lokal China, jalur pengiriman, hingga custom clearance (Bea Cukai).
---

## Create br0 interface

```
sudo nmcli connection add type bridge ifname br0 con-name br0
```