---
sidebar_title: Docker Command
sidebar_position: 1
---

# Docker Common Commands

These are all of common used command in Docker CLI.

|Command             | Explanation                              |
|--------------------|------------------------------------------|
|`docker info`       | contains containers information          |
|`docker version`    | contains containers version information  |
|`docker login`      | login to docker registry                 |

## Docker CLI - Running containers

|Command                                   | Explanation                              |
|------------------------------------------|------------------------------------------|
|`docker pull [image-name]`                | download image form docker registry      |
|`docker run [image-name]`                 | runs containers memory into/as container |
|`docker run -d [image-name]`              | detached mode (run in background)        |
|`docker start [container-name]`           | start stopped container                  |
|`docker ps`                               | list running containers                  |
|`docker ps -a`                            | list all running & stopped containers    |
|`docker stop [container-name]`            | stop containers running (but containers remain in memory in a few minutes)|
|`docker kill [container-name]`            | kill containers that might be stuck in memory|
|`docker image inspect [image-name]`       | get image info                           |

:::note[Note]
    - image-name = name of the image as found in container registry.
    - container-name = name of a running container.
:::

## Docker CLI - Limits

|Command                                  | Explanation                              |
|-----------------------------------------|------------------------------------------|
|`docker run --memory="256m" nginx`       | max memory                               |
|`docker run --cpus=".5" nginx`           | max CPU                                  |

## Docker CLI - Attach Shell

|Command                                         | Explanation                              |
|------------------------------------------------|------------------------------------------|
|`docker run -it nginx -- /bin/bash`             | attach shell                             |
|`docker run -it -- microsoft/powershell:nanoserver pwsh.exe`    | attach PowerShell        |
|`docker container exec -it [container-name]`    | attach to a running container            |

## Docker CLI - Cleaning Up

|Command                           | Explanation                                   |
|----------------------------------|-----------------------------------------------|
|`docker rm [container-name]`      | remove stopped containers                     |
|`docker rm $(docker ps -a -q)`    | remove all stopped containers                 |
|`docker images`                   | list images                                   |
|`docker rmi [image-name]`         | delete the images                             |
|`docker system prune -a`          | remove all images not in use by any containers|

## Docker CLI - Building

|Command                                            | Explanation                             |
|---------------------------------------------------|-----------------------------------------|
|`docker build -t [name:tag] .`                     | build image using Dockerfile located in the same folder|
|`docker build -t [name:tag] -f [filename-dst]`     | if Dockerfile in the different folder   |
|`docker tag [image-name] [name:tag]`               | assign a name to an image               |

## Docker Compose Commands

|Command                                     | Explanation                             |
|--------------------------------------------|-----------------------------------------|
|`docker compose build`                      | build the images                        |
|`docker compose start/stop`                 | start/stop the container                |
|`docker compose up -d`                      | build and start                         |
|`docker compose ps`                         | list what's running                     |
|`docker compose rm`                         | remove from memory                      |
|`docker compose down`                       | stop and remove                         |
|`docker compose logs`                       | get the logs                            |
|`docker compose exec [container] bash`      | run a command in a container            |

## Docker Compose V2 

|Command                                     | Explanation                             |
|--------------------------------------------|-----------------------------------------|
|`docker compose --project-name test1 up -d` | run an instance as a project            |
|`docker compose -p test2 up -d`             | shortcut                                |
|`docker compose ls`                         | build and start                         |
|`docker compose cp [containerID]:[src_path] [dst_path]`   | copy file from container                     |
|`docker compose cp [src_path] [containerID]:[dst_path]`   | copy file to container                |
