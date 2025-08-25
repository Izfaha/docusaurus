---
sidebar_title: Fundamental
sidebar_position: 1
---

# Achitectural Fundamental

PostgreSQL uses a client/server model, which has these processes:
    - Server : manages the database files. Accepting connection from a client side. The database program is called **posgres**.
    - Client (front-end) : or client side who will perform database operation. It could be a text-oriented tool, a graphical application. In simple term, client side is vary depending on developer.

Server and Host/client communicates over TCP/IP network connection.