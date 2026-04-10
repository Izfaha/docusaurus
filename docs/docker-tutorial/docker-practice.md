---
sidebar_title: Docker practice lab tutorial
sidebar_position: 4
---

# Docker labs

## Create an express js 

In this lab, we will deploy a simple application using express js, return a simple word and json data.

So the first step is creating a working directory utilizing command bellow.

```sh
# Create a command and change dir to my-app
mkdir my-app && cd my-app
```

Creating an express as base applicatin, disclaimer that this command step I refer to express [docs installation](https://expressjs.com/en/starter/installing.html).

```sh
npm init

npm install express
```

This is code to print some text in browser but I will add a endpoint to print some json data file.

Copy this code, name as server.js 

```js title="server.js"
const express = require('express')
const app = express()
const port = 6767

const personDataFetching = require('./data/persons.json')

// Routes 

app.get('/', (req, res) => {
    res.send('Hello from container one...')
})

app.get('/data', (req, res) => {
    res.json(personDataFetching)
})

app.listen(port, () => {
    console.log(`App is listening on http://localhost:${port}`)
})
```

create data dir to store json data.

```sh
# create data dir for storing json data file
mkdir data

# create json file inside data directory 
touch data/persons.json
```

This persons.json will be given a route in express and printing some data.
Copy this code  :

```json title="persons.json"
{
    "students":[
        {"name":"Harry LBI", "age":25, "address":"Indonesia"},
        {"name":"Amar", "age":20, "address":"Indonesia"}
    ]
}
```

Back to working directory.

```sh
# make sure inside my-app directory
cd my-app
```

## Dockerfile preparation

```Dockerfile title="Dockerfile"
# this will be pulling an image from docker hub and pick a base image 
FROM node:alpine

# set working directory inside a container
WORKDIR /app

# copy json package
COPY package*.json .

# copy entire projects files into container 
COPY . .

# declare the port 
EXPOSE 6767

# command to run express app
CMD ["node", "server.js"]
```

## Build an express app into image:version

```sh 
docker build -t my-app:0.1
```

## Run app utilizing image created

After building your image, using it is possible and recommended. This command will cover a way how to deploy your first application.

```sh
docker run --rm --name my-app-01 --network net-app -p 8888:6767 my-app:0.1
```

open in your browser `http://localhost:8888`.

## Create the second app

In this way, we will try connecting to the first container deployed recently.

Modify the code bellow.

```js title="server.js"
const express = require('express')
const app = express()
const port = 6767

const personDataFetching = require('./data/persons.json')

// Routes 

app.get('/', (req, res) => {
    res.send('Hello from container two...')
})

app.get('/data', (req, res) => {
    res.json(personDataFetching)
})

app.listen(port, () => {
    console.log(`App is listening on http://localhost:${port}`)
})
```
Build again.

```sh 
docker build -t my-app:0.2
```

Run the app using the second builded image.

```sh
docker run --rm --name my-app-02 --network net-app -p 8881:6767 my-app:0.2
```

open in your browser `http://localhost:8881`.

## Let's try to ping from container to other container

```sh
docker exec -it my-app-01 ping my-app-02
``` 

vice versa

```sh
docker exec -it my-app-02 ping my-app-01
```


