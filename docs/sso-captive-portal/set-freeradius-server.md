---
sidebar_label: Freeradius Server Configuration
sidebar_position: 3
---

# Setting Freeradius Server

## Netplan Configuration

We have to configure netplan first.

```sh
sudo vim /etc/netplan/50-cloud-init.yaml
```

```sh title='/etc/netplan/50-cloud-init.yaml'
network:
  ethernets:
    ens3:
      dhcp4: true
    ens4: 
      addresses:
      - 192.168.1.2/24
      routes:
        - to: default
          via: 192.168.1.1
  version: 2
```

:::note[Important]
If after rebooting your system the netplan's configuration change or reset by default configure in ```/etc/cloud/cloud.cfg.d/99-disable-network-config.cfg```.\
Add this following code.

```sh
network: {config: disabled}
```

If there is no ```99-disable-network-config.cfg``` file, just create it by yourself.

:::

### What are those configuration?

:::note[Info]
```192.168.1.2``` IP for freeradius.
```192.168.1.1``` IP's CHR (MikroTik).
:::

## Setting PostgreSQL

### Login to PostgreSQL

```sh
sudo -i -u postgres
psql
```

### Create User and Database

1. Create user and database for FreeRADIUS

```sql
CREATE USER radius WITH PASSWORD 'freeradius';
CREATE DATABASE radiusdb WITH OWNER radius;
```

2. Membuat user untuk client vm.

```sql
INSERT INTO radcheck (username, attribute, op, value)
VALUES ('debian-client', 'Cleartext-Password', ':=', 'debian');
```

Verify whether user for client vm exist.

```sql
SELECT * FROM radcheck WHERE username = 'debian-client';
```

### Create Table Using Radius Template

Log out from postgresql.

```sh
cd /etc/freeradius/3.0/mods-config/sql/main/postgresql/
```

### Activate SQL (PostgreSQL) Modul

```sh
cd /etc/freeradius/3.0/mods-enabled
ln -s ../mods-available/sql sql
```

Edit file module.

```sh
sudo vim /etc/freeradius/3.0/mods-available/sql
```

Find and uncomment this code:

```sh
# === ubah bagian connection
dialect = "postgresql"
driver = "rlm_sql_postgresql"
server = "localhost"
port = 5432
login = "radius"
password = "freeradius"
radius_db = "radiusdb"
read_clients = yes
```

Then, check the connection:

```sh
sudo freeradius -X
```

Output will be:

```sh
rlm_sql (sql): Attempting to connect to database "radiusdb"
Connected to database successfully
```

### Add user to database

```sql
INSERT INTO radcheck (username, attribute, op, value) VALUES ('debian-client', 'Cleartext-Password', ':=', 'debian');
```

## Setting Freeradius

- Add Ip client to server (Freeradius).

```sh
sudo nano /etc/freeradius/3.0/clients.conf
```

Add this user:

```sh

```
