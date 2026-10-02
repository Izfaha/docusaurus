---
title: Docker Resource Limits dan Monitoring dengan Docker Stats
sidebar_label: Pekan 3 - DevOps (Container Limitation)
sidebar_position: 6
description: Praktik Docker untuk menjalankan beberapa container dengan batas CPU dan memory, memantau penggunaan resource menggunakan docker stats, serta memahami perintah penting untuk resource management.
keywords:
  - docker
  - docker resource limits
  - docker stats
  - docker cpu limit
  - docker memory limit
  - container monitoring
  - devops
  - docker tutorial
  - linux containers
slug: /devops/docker-resource-limits-monitoring
---

Dalam latihan ini saya membuat 5 container :

| Container | Resources |
| ----- | ----- |
| nginx | 0.5 / 128m |
| mysql | 0.5 / 256m |
| mariadb | 0.5 / 256m |
| adminer | 0.5 / 256m |
| postgres | 0.5 / 256m |

**Nginx Container**

```
docker run --name nginx -p 8080:80 --memory 128m --cpus 0.5 -d nginx:stable-bookworm
```

![nginx](./img/pekan-3/container-nginx.png)

**MySQL Container**

```
docker run --name mysql-db -p 3333:3306 -e MYSQL_ROOT_PASSWORD=faiz --memory 256m --cpus 0.5 -d mysql:lts
```

![mysql](./img/pekan-3/container-mysql.png)

**MariaDB Container**

```
docker run --name mariadb -p 3334:3306 -e MYSQL_ROOT_PASSWORD=faiz --memory 256m --cpus 0.5 -d mariadb:13
```

![mariadb](./img/pekan-3/container-mariadb.png)

**Adminer Container**

```
docker run -p 8081:8080 -e ADMINER_DEFAULT_SERVER=mysql --memory 256m --cpus 0.5 -d adminer
```

![adminer](./img/pekan-3/container-adminer.png)

**PostgreSQL Container**

```
docker run --name postgres -e POSGRES_ROOT_PASSWORD=faiz --memory 256m --cpus 0.5 -d postgres
```

![postgres](./img/pekan-3/container-postgrs.png)

![docker-ps](./img/pekan-3/docker-ps.png)

Ini adalah stats dari semua container diatas.

![stats](./img/pekan-3/docker-stats-5-container.png)