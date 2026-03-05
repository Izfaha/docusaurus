---
sidebar_title: Linux Command Line
sidebar_position: 1
---

# Linux Command Line (Practice)

[Case] 

Ada company A, memiliki team frontend (Rama, Hanif), backend (Harry, Kacung), dan PM (Josh => memiliki autorisasi ke directory frontend dan backend dan database dan docs) dan masing-masing team di berikan group tersendiri di server.

[Key point]
- Team Frontend yg terdiri dari Rama dan Hanif hanya bisa akses dir frontend dan database aja dan ketika akses dir backend akan `permission denied`.
- Team Frontend yg terdiri dari Rama dan Hanif hanya bisa akses dir backend dan database aja dan ketika akses dir frontend akan `permission denied`.
- PM bisa lihat semuanya.
- Semua team bisa akses dir database dan docs.

## 1. Find and Chose working directory

Find working directory using this command.

```sh
$ pwd
```

Place your working directory in `Documents/learn-cli`.

```sh
# Create dir called learn-cli inside dir Documents 
$ mkdir -p Documents/learn-cli

#  move to learn-cli dir
$ cd Documents/learn-cli
```

## 2. Assemble Project Structure

This will be our project dir tree.

```
learn-cli/
 ├── backend/
 ├── frontend/
 ├── database/
 └── docs/
```

Utilize this command below to create dirs above.

```sh
# Create dirs
$ mkdir backend frontend database docs

# list dir content
$ ls -lah
```

## 3. Create Crucial docs

Inside learn-cli/docs create 2 files :
- readme.txt
- features.txt

```sh
# Create files
$ touch readme.txt features.txt

# we are inside Documents/learn-cli/docs
$ cp readme.txt ./backend
```

## 4. Create Shorcut

Create shortcut from frontend dir to docs

```sh
# execute inside learn-cli dir
# we'll create symbolic link
$ ln -s docs docs-shortcut

# verify using list command
$ ls -l

# create hardlink
$ ln docs/readme.txt readme-hardlink.txt

$ ls -li
```

## 5. Add new user and group 

Create group user for all team.

```sh
$ sudo groupadd frontend
$ sudo groupadd backend
$ sudo groupadd pm
```

Create user handling group.

```sh
# frontend
$ sudo useradd -m -G frontend rama
$ sudo useradd -m -G frontend hanif

# backend
$ sudo useradd -m -G backend harry
$ sudo useradd -m -G backend kacung

# pm
$ sudo useradd -m -G pm josh

# give password for each user
$ sudo passwd rama
$ sudo passwd hanif
$ sudo passwd harry
$ sudo passwd kacung
$ sudo passwd josh

# switch new user
$ su [user]
# ex : $ su rama

# check udentity 
$ id
```

## 6. Secure Ownership Directory 


```sh
$ sudo chown root:frontend learn-cli/frontend

$ sudo chown root:backend learn-cli/backend
```

Create group `shared` for database and docs dir.

```sh
$ sudo groupadd shared
```

Add all users to shared group.

```sh
$ sudo usermod -aG shared rama
$ sudo usermod -aG shared hanif
$ sudo usermod -aG shared harry
$ sudo usermod -aG shared kacung
$ sudo usermod -aG shared josh
```

set ownership for docs and database dir for being accessed by user groped in `shared`.

```sh
$ sudo chown root:shared learn-cli/docs
$ sudo chown root:shared learn-cli/database
```

Set group permission

```sh
$ sudo chmod 770 learn-cli/backend 
$ sudo chmod 770 learn-cli/frontend
$ sudo chmod 770 learn-cli/docs
$ sudo chmod 770 learn-cli/database
```

Add Josh as PM to `frontend` and `backend` group in order to grant permisson in those group.

```sh
$ sudo usermod -aG frontend josh
$ sudo usermod -aG backend josh 
```