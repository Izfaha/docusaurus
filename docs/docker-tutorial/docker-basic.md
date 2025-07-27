---
sidebar_title: Docker Basic
---

# Docker

## Docker Image

**Docker Image** is a read-only template that contains instructions for creating a docker container, including the application code, libraries, depedencies, and other files needed to run the application. Docker image is built from a ***Dockerfile***, which is a text file that contains a series of instructions and commands that are used to build the image.

## Docker Volume

**Docker** volume is a persistent data storage mechanism that allows data to be stored outside of the container's filesystem. Volumes are ***independent of the container's lifecycle*** and can be shared between containers. They are used to persist data even when the container is deleted, making them ideal for storing databases, configuration files, and other data that needs to be preserved