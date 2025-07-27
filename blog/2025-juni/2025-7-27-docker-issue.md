---
slug: docker-daemon-issue
title: Cannot connect to the Docker daemon
authors: faiz_maulana_habibi
tags: [linux, secure] 
---

## Issue 

Recently, I was trying build docker image but it become an issue. Pop in my terminal up a messege. 

![issue](./img/docker-issue.jpeg)

<!-- truncate -->

The main issue is I used wrong docker path in `docker context`. In my case, I remain using docker desktop path.

After I change it using `docker context default`, suddenly it works.

![solve](./img/docker.jpg)

And I verify `docker context ls`

![context_ls](./img/docker-context-ls.jpeg)