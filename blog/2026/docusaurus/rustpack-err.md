---
title: Internal Rustpack Error on Docusaurus
date: 2026-09-19
description: Rustpack internal error search prisma.js for pyhon syntax highlighting
slug: ssd-access-denied-in-windows
authors: faiz_maulana_habibi
tags: [linux]
keywords: [data, ssd, forensic, recover, windows, storage]
hide_table_of_contents: false

custom_fields:
  og_title: Rustpack Error When Loading prisma.js 
  og_description: Pyhon Syntax Highlighting
---

It suddenly apprears when I run `npm run start`.

![err](./img/error-prsma.png)

## How to fix?

Just clear the cache by hitting this command :

```
npx docusaurus clear
```

![docusaurus-clear](./img/docusaurus-clear.png)

then run :

```
npm run start
```

Done!