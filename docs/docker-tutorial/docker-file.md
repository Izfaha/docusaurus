---
sidebar_title: Create Dockerfile
sidebar_position: 2
---

# Create Dockerfile

## Dockerfile - Static HTML site

```Dockerfile title="Dockerfile"
FROM nginx:alpine
COPY . /usr/share/nginx/html
```

## Dockerfile - Node Site

```Dockerfile title="Dockerfile"
FROM alpine                             #base img
RUN apk add -update nodejs nodejs-npm   #install node & NPM using the package manager
COPY . /src                             #copy file from the build context
WORKDIR /src
RUN npm install                         #run a command
EXPOSE 8080                             #add metadata to tells containers listen to port 8080
ENTRYPOINT ["node", "./app.js"]         #tells containers what to run
```
