---
sidebar_title: Docker Command "docker ps"
sidebar_position: 3
---

# Command - docker ps 

You know that if you can not actually do some common usage of a command, you can read man db or user additional parameter like `--help`. 
On this blog I need to share the usage of `docker ps` command and its feature.

```sh
$ docker ps --help                                                         
Usage:  docker ps [OPTIONS]

List containers

Aliases:
  docker container ls, docker container list, docker container ps, docker ps

Options:
  -a, --all             Show all containers (default shows just running)
  -f, --filter filter   Filter output based on conditions provided
      --format string   Format output using a custom template:
                        'table':            Print output in table format with column headers
                        (default)
                        'table TEMPLATE':   Print output in table format using the given Go
                        template
                        'json':             Print in JSON format
                        'TEMPLATE':         Print output using the given Go template.
                        Refer to https://docs.docker.com/go/formatting/ for more information
                        about formatting output with templates
  -n, --last int        Show n last created containers (includes all states) (default -1)
  -l, --latest          Show the latest created container (includes all states)
      --no-trunc        Don't truncate output
  -q, --quiet           Only display container IDs
  -s, --size            Display total file sizes

```

## 1. Option -a

This option command is used to show all created container (means running, stopped or exited). You can type :

```sh
docker ps -a
```

This outputs like this :

```sh
CONTAINER ID   IMAGE                          COMMAND                  CREATED        STATUS       PORTS                                         NAMES
13ded9590491   phpmyadmin/phpmyadmin:latest   "/docker-entrypoint.…"   2 months ago   Up 4 hours   0.0.0.0:8433->80/tcp, [::]:8433->80/tcp       phpmyadmin
eb3506620de1   mariadb:10.11                  "docker-entrypoint.s…"   2 months ago   Up 4 hours   0.0.0.0:3306->3306/tcp, [::]:3306->3306/tcp   mariadb
```

## 2. Option -f (--filter of --format)

### -f or --filter

This command will fillter your output base on consition.

```sh
docker ps -f "status=exited"
```

This outputs an created exited container.

```sh
CONTAINER ID   IMAGE        COMMAND                  CREATED       STATUS                      PORTS     NAMES
4743431ec595   my-app:0.1   "docker-entrypoint.s…"   2 weeks ago   Exited (137) 2 weeks ago              my-app-01
75169167080c   mysql:8.0    "docker-entrypoint.s…"   6 weeks ago   Exited (0) 40 minutes ago             utsci-db
```

### --format json

This will output json format with an messy format but you can tidy it up using `jq` or Command-line JSON processor. This collaboration will give you an beauty of output.

This command **without** `jq`.

```sh
$ docker ps --format json  

{"Command":"\"/docker-entrypoint.…\"","CreatedAt":"2026-04-13 21:21:51 +0700 WIB","HealthStatus":"none","ID":"13ded9590491","Image":"phpmyadmin/phpmyadmin:latest","Labels":"com.docker.compose.config-hash=9500892513640f558f6b45f37a98a09f3c75402fa73b56322b681d247aee1138,com.docker.compose.container-number=1,com.docker.compose.depends_on=db:service_started:false,com.docker.compose.image=sha256:e66b1f5a8c5852cc6f7143589f34de435a0f5057fa3b012d6fb4705b9127b46b,com.docker.compose.oneoff=False,com.docker.compose.project.config_files=/home/ray/Docker/phpmyadmin/docker-compose.yml,com.docker.compose.project.working_dir=/home/ray/Docker/phpmyadmin,com.docker.compose.project=phpmyadmin,com.docker.compose.service=phpmyadmin,com.docker.compose.version=5.1.1,org.opencontainers.image.authors=The phpMyAdmin Team \u003cdevelopers@phpmyadmin.net\u003e,org.opencontainers.image.description=Run phpMyAdmin with Alpine, Apache and PHP FPM.,org.opencontainers.image.documentation=https://github.com/phpmyadmin/docker#readme,org.opencontainers.image.licenses=GPL-2.0-only,org.opencontainers.image.source=https://github.com/phpmyadmin/docker.git,org.opencontainers.image.title=Official phpMyAdmin Docker image,org.opencontainers.image.url=https://github.com/phpmyadmin/docker#readme,org.opencontainers.image.vendor=phpMyAdmin,org.opencontainers.image.version=5.2.3","LocalVolumes":"0","Mounts":"","Names":"phpmyadmin","Networks":"phpmyadmin_db_net","Platform":null,"Ports":"0.0.0.0:8433-\u003e80/tcp, [::]:8433-\u003e80/tcp","RunningFor":"2 months ago","Size":"0B","State":"running","Status":"Up 4 hours"}
{"Command":"\"docker-entrypoint.s…\"","CreatedAt":"2026-04-13 21:21:15 +0700 WIB","HealthStatus":"none","ID":"eb3506620de1","Image":"mariadb:10.11","Labels":"com.docker.compose.config-hash=d97514efb9b2b7feaac6ff94fc2d46a683d5e356aa10e3d2180e600ef34819d1,com.docker.compose.container-number=1,com.docker.compose.depends_on=,com.docker.compose.image=sha256:508e12f5ac2ab86c52d38cf40d8204c6276f87628af51367739480f4326b1fa0,com.docker.compose.oneoff=False,com.docker.compose.project.config_files=/home/ray/Docker/phpmyadmin/docker-compose.yml,com.docker.compose.project.working_dir=/home/ray/Docker/phpmyadmin,com.docker.compose.project=phpmyadmin,com.docker.compose.service=db,com.docker.compose.version=5.1.1,org.opencontainers.image.authors=MariaDB Community,org.opencontainers.image.base.name=docker.io/library/ubuntu:jammy,org.opencontainers.image.description=MariaDB Database for relational SQL,org.opencontainers.image.documentation=https://hub.docker.com/_/mariadb/,org.opencontainers.image.licenses=GPL-2.0,org.opencontainers.image.source=https://github.com/MariaDB/mariadb-docker,org.opencontainers.image.title=MariaDB Database,org.opencontainers.image.url=https://github.com/MariaDB/mariadb-docker,org.opencontainers.image.vendor=MariaDB Community,org.opencontainers.image.version=10.11.16","LocalVolumes":"0","Mounts":"/home/ray/Dock…","Names":"mariadb","Networks":"phpmyadmin_db_net","Platform":null,"Ports":"0.0.0.0:3306-\u003e3306/tcp, [::]:3306-\u003e3306/tcp","RunningFor":"2 months ago","Size":"0B","State":"running","Status":"Up 4 hours"}
```

This command **with** `jq`.

```sh
$ docker ps --format json | jq    

{
  "Command": "\"/docker-entrypoint.…\"",
  "CreatedAt": "2026-04-13 21:21:51 +0700 WIB",
  "HealthStatus": "none",
  "ID": "13ded9590491",
  "Image": "phpmyadmin/phpmyadmin:latest",
  "Labels": "com.docker.compose.config-hash=9500892513640f558f6b45f37a98a09f3c75402fa73b56322b681d247aee1138,com.docker.compose.container-number=1,com.docker.compose.depends_on=db:service_started:false,com.docker.compose.image=sha256:e66b1f5a8c5852cc6f7143589f34de435a0f5057fa3b012d6fb4705b9127b46b,com.docker.compose.oneoff=False,com.docker.compose.project.config_files=/home/ray/Docker/phpmyadmin/docker-compose.yml,com.docker.compose.project.working_dir=/home/ray/Docker/phpmyadmin,com.docker.compose.project=phpmyadmin,com.docker.compose.service=phpmyadmin,com.docker.compose.version=5.1.1,org.opencontainers.image.authors=The phpMyAdmin Team <developers@phpmyadmin.net>,org.opencontainers.image.description=Run phpMyAdmin with Alpine, Apache and PHP FPM.,org.opencontainers.image.documentation=https://github.com/phpmyadmin/docker#readme,org.opencontainers.image.licenses=GPL-2.0-only,org.opencontainers.image.source=https://github.com/phpmyadmin/docker.git,org.opencontainers.image.title=Official phpMyAdmin Docker image,org.opencontainers.image.url=https://github.com/phpmyadmin/docker#readme,org.opencontainers.image.vendor=phpMyAdmin,org.opencontainers.image.version=5.2.3",
  "LocalVolumes": "0",
  "Mounts": "",
  "Names": "phpmyadmin",
  "Networks": "phpmyadmin_db_net",
  "Platform": null,
  "Ports": "0.0.0.0:8433->80/tcp, [::]:8433->80/tcp",
  "RunningFor": "2 months ago",
  "Size": "0B",
  "State": "running",
  "Status": "Up 4 hours"
}
{
  "Command": "\"docker-entrypoint.s…\"",
  "CreatedAt": "2026-04-13 21:21:15 +0700 WIB",
  "HealthStatus": "none",
  "ID": "eb3506620de1",
  "Image": "mariadb:10.11",
  "Labels": "com.docker.compose.config-hash=d97514efb9b2b7feaac6ff94fc2d46a683d5e356aa10e3d2180e600ef34819d1,com.docker.compose.container-number=1,com.docker.compose.depends_on=,com.docker.compose.image=sha256:508e12f5ac2ab86c52d38cf40d8204c6276f87628af51367739480f4326b1fa0,com.docker.compose.oneoff=False,com.docker.compose.project.config_files=/home/ray/Docker/phpmyadmin/docker-compose.yml,com.docker.compose.project.working_dir=/home/ray/Docker/phpmyadmin,com.docker.compose.project=phpmyadmin,com.docker.compose.service=db,com.docker.compose.version=5.1.1,org.opencontainers.image.authors=MariaDB Community,org.opencontainers.image.base.name=docker.io/library/ubuntu:jammy,org.opencontainers.image.description=MariaDB Database for relational SQL,org.opencontainers.image.documentation=https://hub.docker.com/_/mariadb/,org.opencontainers.image.licenses=GPL-2.0,org.opencontainers.image.source=https://github.com/MariaDB/mariadb-docker,org.opencontainers.image.title=MariaDB Database,org.opencontainers.image.url=https://github.com/MariaDB/mariadb-docker,org.opencontainers.image.vendor=MariaDB Community,org.opencontainers.image.version=10.11.16",
  "LocalVolumes": "0",
  "Mounts": "/home/ray/Dock…",
  "Names": "mariadb",
  "Networks": "phpmyadmin_db_net",
  "Platform": null,
  "Ports": "0.0.0.0:3306->3306/tcp, [::]:3306->3306/tcp",
  "RunningFor": "2 months ago",
  "Size": "0B",
  "State": "running",
  "Status": "Up 4 hours"
}
```

## 3. Option -n 

this command will show you the last created container (default n is -1) but if you need to know the last inactve container you can use absolute number like 1 2 or 3 etc.

```sh 
$ docker ps -n 2

CONTAINER ID   IMAGE        COMMAND                  CREATED       STATUS                         PORTS     NAMES
4743431ec595   my-app:0.1   "docker-entrypoint.s…"   2 weeks ago   Exited (137) 2 weeks ago                 my-app-01
75169167080c   mysql:8.0    "docker-entrypoint.s…"   6 weeks ago   Exited (0) About an hour ago             utsci-db
```

If you look up to `STATUS` there will be msg `Exited` means that those are the last created container you have created.

## 4. Option -l

This will show the lastest a created container.

```sh
docker ps -l                
CONTAINER ID   IMAGE        COMMAND                  CREATED       STATUS                     PORTS     NAMES
4743431ec595   my-app:0.1   "docker-entrypoint.s…"   2 weeks ago   Exited (137) 2 weeks ago             my-app-01
```

## 5. Option -q

This command will only show container ID.

```sh
$ docker ps -q

13ded9590491
eb3506620de1
```
## 6. Option -s

This will display total of your file size. This tells how much your container are consuming

```sh
$ docker ps -s

CONTAINER ID   IMAGE                          COMMAND                  CREATED        STATUS       PORTS                                         NAMES        SIZE
13ded9590491   phpmyadmin/phpmyadmin:latest   "/docker-entrypoint.…"   2 months ago   Up 5 hours   0.0.0.0:8433->80/tcp, [::]:8433->80/tcp       phpmyadmin   657kB (virtual 743MB)
eb3506620de1   mariadb:10.11                  "docker-entrypoint.s…"   2 months ago   Up 5 hours   0.0.0.0:3306->3306/tcp, [::]:3306->3306/tcp   mariadb      2B (virtual 331MB)

```

This is the brakdown on this `SIZE` 

1. The First Number or Writable Layer Size (675kb)

This is the amount of disk space used for data that has been written or changed inside this specific container since it started running. If you stop and delete the container, this will be instantly freed up (deleted) on your host machine.

2. The Second Number or Virtual Size (743MB)

This is the total size of the underlying read-onliy image plus the container's writable layer size. If you have five distinct containers running off the exact same nginx:latest image, they all share that exact same 118MB base image on disk. They do not take up 5 × 118MB. They only consume 118MB once, plus whatever unique data each container writes to its own writable layer.