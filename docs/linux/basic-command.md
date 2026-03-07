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

### Groups
- frontend => only accessing frontend dir.
- backend => only accessing backend dir.
- pm => pm (josh) accessing all dirs exclusively.
- shared => accessing docs and database dirs for user frontend and backend, will be linked using `ln`. 
- developer => for accessing main dir in `/home/linux/*`.

Create group user for all team.

```sh
sudo groupadd frontend
sudo groupadd backend
sudo groupadd pm
sudo groupadd shared
sudo groupadd developer
```

Create user handling group.

```sh
# frontend
$ sudo useradd -s /bin/bash -G frontend,shared,developer rama
$ sudo passwd rama

$ sudo useradd -s /bin/bash -G frontend,shared,developer hanif
$ sudo passwd hanif

# backend
$ sudo useradd -s /bin/bash -G backend,shared,developer harry
$ sudo passwd harry

$ sudo useradd -s /bin/bash -G backend,shared,developer kacung
$ sudo passwd kacung

# pm
$ sudo useradd -s /bin/bash -G pm,shared,developer josh
$ sudo passwd josh
```

:::note[Information]
You can use these command to listing detailed information about your users.

```sh
# list users
cat /etc/passwd | grep username
# or `cut -d: -f1 /etc/passwd`

# list groups
cat /etc/group | grep groupname
# or `cut -d: -f1 /etc/group`

# see user's group
groups username

# detailed user info
id username

# show group info
getent group
```

:::

## 6. Secure Ownership Directory 

```sh
sudo chown root:frontend frontend
sudo chown root:backend backend
```

set ownership for docs and database dir for being accessed by user groped in `shared`.

```sh
sudo chown root:shared docs
sudo chown root:shared database
```

Set user linux home directory accessible for other user.

```sh
sudo chown root:developer /home/linux
```

Set group permission

```sh
sudo chmod 770 learn-cli/backend 
sudo chmod 770 learn-cli/frontend
sudo chmod 770 learn-cli/docs
sudo chmod 770 learn-cli/database
sudo chmod 770 /home/linux
```

## 7. Verify the configuration

### Frontend

In this point measure that your main user has grant to group you have created. We will check using first user `rama` and `hanif` as frontend. Just hit these command.

Try to switch ro `rama` user.
```sh
su rama
```

Accessing frontend dir and it must have an access to the dir. 
```sh
cd /home/linux/Documents/learn-cli/frontend 
```

If `rama` user try to access backend dir, it must be `permission denied`.
```sh
cd /home/linux/Documents/learn-cli/backend
```

Please repeating those but **don't forget to switch each user**.

### Backend

As mentioned that the backend role is filled by `harry` and `kacung` so test them using these commands.

```sh
su harry
```

Accessing backend dir and it must have an access to the dir. 

```sh
cd /home/linux/Documents/learn-cli/backend
```

If `rama` user try to access backend dir, it must be `permission denied`.

```sh
cd /home/linux/Documents/learn-cli/frontend 
```

Please repeating those but **don't forget to switch each user**.

### PM

Project manager or (PM) should have an access to all dirs so make sure that you have given an group access to `josh`.

```sh
su josh
```

```sh
cd /home/linux/Documents/learn-cli/frontend
cd /home/linux/Documents/learn-cli/backend
cd /home/linux/Documents/learn-cli/docs
cd /home/linux/Documents/learn-cli/database
```