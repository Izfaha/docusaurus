---
slug: docusaurus
title: File Error 
authors: faiz_maulana_habibi
tags: [linux, docusaurus]
---

<!-- truncate -->

## Docusaurus : get error after temoving file inside '/blog'

When I remove a file inside '/blog', I get this error

```text
ERROR in ./.docusaurus/registry.js 1:11337-11448

Module not found: Error: Can't resolve '@site/blog/2021-08-26-welcome/index.md?truncated=true' in '/home/ray/Documents/documentation/.docusaurus'

ERROR in ./.docusaurus/registry.js 1:11505-11581

Module not found: Error: Can't resolve '@site/blog/2021-08-26-welcome/index.md?truncated=true' in '/home/ray/Documents/documentation/.docusaurus'

ERROR in ./.docusaurus/registry.js 1:12427-12532

Module not found: Error: Can't resolve '@site/blog/2021-08-26-welcome/index.md' in '/home/ray/Documents/documentation/.docusaurus'

ERROR in ./.docusaurus/registry.js 1:12574-12635

Module not found: Error: Can't resolve '@site/blog/2021-08-26-welcome/index.md' in '/home/ray/Documents/documentation/.docusaurus'
```

and it is caused by '.docusaurus' file cache.

:::tip[My tips]

## How to tackle this?

You just need to remove '.docusaurus' cache using

```sh
rm -rf .docusaurus build
```

Afterwards re-run command

```sh
npm run start
```

:::
