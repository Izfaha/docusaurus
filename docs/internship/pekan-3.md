---
sidebar_title: Pekan 3
---

# Pekan 3 - Docker fundamental

## Instal Docker Engine dari repository resmi Docker (bukan snap).

### Install docker cli sesuai [dokumentasi docker](https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository).

```bash
# Add Docker's official GPG key:
sudo apt update
sudo apt install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
sudo tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: stable
Architectures: $(dpkg --print-architecture)
Signed-By: /etc/apt/keyrings/docker.asc
EOF

sudo apt update
```

![docker-install-apt](./img/pekan-3/pasang-repo-list.png)

### Install the Docker packages.

```
sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

Di bawah ini adalah beberapa kegunaan pada package above.

|Package|Fungsi|Usage|
|-----|-----|-----|
|docker-ce|Docker Engine (daemon `dockerd`) yg mengelola image, container, volume dan network.|docker service|
|docker-ce-cli|Docker command binary, yg nanti dikirim ke daemon dockerd. | contoh : docker ps, docker run, etc|
|containerd.io|Runtime yg membantu docker untuk mengelola siklus service yg jalan dan membawa komponen runtime yg diperlukan.|Dipakai dibackground saat container dibuat dan dijalankan|
|docker-buildx-plugin|Menambahkan docker buildx untuk membangun image dengan BuildKit. | Contoh : `docker buildx build -t namaimage:tag .`|
|docker-compose-plugin|Menambahkan docker compose untuk multi container. | Contoh : `docker compose up`|

![install-apt](./img/pekan-3/install-apt-docker.png)

---

## Konsep image, layer & container; perintah run, exec, logs, inspect, stats.

**Docker image** adalah kumpulan instuksi untuk menjalankan container. Instruksi dapat berupa file, konfigurasi, depedensi atau library, semua itu dijadikan satu menjadi image yg bersifat read-only.

### Image dan layer

Ini adalah beberapa command dalam docker image

```bash
# melihat image yg ada di local
docker images
```

![image-list](./img/pekan-3/image-list.png)

Semua image tersebut memiliki ukuran dan size nya di pengaruhi oleh layer dan file-file didalamnya.layer adalah hasil perubahan filesystem dari instruksi tertentu.

```bash
# command untuk melihat layer image
docker image history traefik:v3.6
```

![layer](./img/pekan-3/layer-traefik.png)

:::note
dalam `docker images` diatas saya menggunakan homelab server saya sendiri. 
:::

### container; perintah run, exec, logs, inspect, stats.

**docker run**

Docker run adalah command untuk menjalankan container dari sebuah image yg telah dibuat.

In this case, saya akan memakali image nginx:latest.

```bash
# pull image dari docker hub
docker pull nginx:stable-bookworm

# untuk liat layer image
docker image history nginx:stable-bookworm

docker run --name ngin_server -p 8080:80 nginx:stable-bookworm
```

![nginx](./img/pekan-3/nginx-docker-run.png)

Sekarang cek nginx di browser `192.168.58.10:8080` kenapa tidak 80? karena saya pointing port 80 yg didalam container ke port 8080 yg berada di host. 

![nginx](./img/pekan-3/nginx-browser.png)

**docker exec**

Sekarang saya akan masuk ke shell container `nginx_server` dengan command ini :

```bash
docker exec -it nginx_server bash
```
:::note
Untuk `-it` memastikan kita bisa open pseudo-tty dan menginputkan command didalamnya.
:::

![docker-exec-nginx](./img/pekan-3/docker-exec-nginx-container.png)

Didalam container kita juga bisa menjalankan command command, seperti melihat file/directory etc.

**docker logs**

`docker logs` berfungsi untuk melihat logs dari container yg sedang running dan juga untuk debug ketika container crash secara tiba tiba. Untuk log container sebaiknya di kasih batasan size jika tidak dibatasi akan membengkat dan memakan storage.

![nginx-logs](./img/pekan-3/nginx-logs.png)

**docker inspect**

Docker inspect digunakan untuk menampilakan semua informasi tentang container kita dalam format json.

![inspect-container](./img/pekan-3/docker-inspect-nginx.png)

**docker stats**

docker stats untuk menampikan penggunaan resource pada suatu container mulai dari cpu, ram, io dan pids.

![stats](./img/pekan-3/docker-stats.png)

---

## Volume (named vs bind mount) dan network (bridge, host, none, user-defined bridge).

Selain itu Docker juga memiliki komponen penting lainya yaitu volume dan network yang akan di implementasikan pada setiap containernya. Dalam production kedua componen ini adalah backbone pada semua aplikasi yg kita pake, Docker volume untuk menyipan data aplikasi dan untuk Docker network untuk menyambungkan 1 service dengan service lainnya dalam server. 

### Volume - named volume and bind mount

#### Named Volume

Skema pertama adalah named volume yg sepenuhnya pekerjaan penyimpanan data di manage oleh docker sendiri.
Saya akan membuat **named volume** bernama `lab-vol` terlebih dahulu lalu saya attach ke nginx.

```
docker volume create lab-vol
```

![inspect-and-create-volume](./img/pekan-3/docker-vol-and-inspect.png)

Selanjut nya saya akan meng-run nginx dan meng-attach ke volume `lab-vol`.

```
docker run --mount type=volume,source=lab-vol,target=/data -d nginx:stable-bookworm
```

![attach-vol](./img/pekan-3/run-nginx-attach-vol.png)

Masuk ke container dan buat file `note.txt` didalam container `/data/note.txt`.

```bash
docker exec -it 1ab09bd09d8501820ceaa6f61663b7b253c0322894f8d23d0f52a117b44b281c bash

# didalam container 
ls

cd data

echo "ini file untuk test docker named volume" >> note.txt

cat note.txt
```

![create-note.txt](./img/pekan-3/create-txt.png)

#### Bind Mount

Yang kedua adalah **Bind Mount** skema volum yg sepenuhnya dihandle oleh kita sendiri dan kita juga perlu menyiapkan direktori untuk di bind mount ke dalam container.

### Network - bridge, host, none and user-defined bridge

---

## Restart policy dan batas resource (-memory, -cpus).