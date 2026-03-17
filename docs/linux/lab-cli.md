# Lab Linux CLI — GDGoC UDINUS
## Manajemen User, Grup, dan Permission di Server Company A

---

## Latar Belakang

Company A adalah sebuah perusahaan teknologi yang memiliki server Linux untuk mengelola project mereka.
Server ini digunakan bersama oleh tiga tim: **Frontend**, **Backend**, dan **PM (Project Manager)**.

Sebagai sysadmin baru, tugasmu adalah menyiapkan struktur direktori, user, grup, dan permission
yang sesuai dengan kebijakan perusahaan — semuanya lewat terminal!

---

## Struktur Tim

| Nama  | Role     | Tim      |
|-------|----------|----------|
| Rama  | Developer| Frontend |
| Hanif | Developer| Frontend |
| Harry | Developer| Backend  |
| Kacung| Developer| Backend  |
| Josh  | PM       | PM       |

---

## Kebijakan Akses

| Direktori   | Frontend (Rama, Hanif) | Backend (Harry, Kacung) | PM (Josh) |
|-------------|------------------------|-------------------------|-----------|
| /frontend   | Baca + Tulis           | DILARANG                | Baca saja |
| /backend    | DILARANG               | Baca + Tulis            | Baca saja |
| /database   | Baca saja              | Baca saja               | Baca saja |
| /docs       | Baca saja              | Baca saja               | Baca saja |

---

## Command yang Akan Dipraktikkan

`ls` `pwd` `cd` `rm` `mv` `chown` `chmod` `useradd` `cp` `mkdir` `ln` `su` `sudo` `id` `passwd`

---

## Persiapan Awal

Semua langkah di bawah ini dijalankan sebagai **root** atau menggunakan **sudo**.
Jika kamu sedang login sebagai user biasa, jalankan dulu:

```bash
sudo su -
```

---

## Bagian 1 — Menjelajahi Sistem (ls, pwd, cd)

Sebelum mulai membuat apapun, kenali dulu lingkungan server.

### Langkah 1.1 — Cek posisi kamu saat ini

```bash
pwd
```

Output yang diharapkan:
```
/root
```

`pwd` (Print Working Directory) menampilkan lokasi direktori kamu saat ini.

### Langkah 1.2 — Lihat isi direktori root

```bash
ls
```

Untuk melihat detail lengkap termasuk permission dan kepemilikan file:

```bash
ls -la
```

Keterangan flag:
- `-l` = tampilkan dalam format panjang (long format)
- `-a` = tampilkan file tersembunyi (yang diawali titik)

### Langkah 1.3 — Berpindah ke direktori /home

```bash
cd /home
ls -la
```

Untuk kembali ke direktori sebelumnya:

```bash
cd -
```

Untuk kembali ke home directory kamu:

```bash
cd ~
```

---

## Bagian 2 — Membuat Struktur Direktori Project (mkdir, ls)

### Langkah 2.1 — Buat direktori utama project

```bash
mkdir -p /project/{frontend,backend,database,docs}
```

Flag `-p` berarti "buat direktori parent jika belum ada, dan jangan error jika sudah ada".
Tanda kurung kurawal `{}` adalah fitur shell untuk membuat banyak direktori sekaligus.

### Langkah 2.2 — Verifikasi hasil pembuatan direktori

```bash
ls -la /project/
```

Output yang diharapkan:
```
total 24
drwxr-xr-x 6 root root 4096 ... .
drwxr-xr-x 3 root root 4096 ... ..
drwxr-xr-x 2 root root 4096 ... backend
drwxr-xr-x 2 root root 4096 ... database
drwxr-xr-x 2 root root 4096 ... docs
drwxr-xr-x 2 root root 4096 ... frontend
```

### Langkah 2.3 — Masuk ke direktori project dan eksplorasi

```bash
cd /project
pwd
ls
```

---

## Bagian 3 — Membuat Grup Tim (useradd bagian grup)

Di Linux, grup digunakan untuk mengelompokkan user agar bisa diberikan permission secara kolektif.

### Langkah 3.1 — Buat grup untuk setiap tim

```bash
groupadd frontend-team
groupadd backend-team
groupadd pm-team
```

### Langkah 3.2 — Verifikasi grup berhasil dibuat

```bash
cat /etc/group | grep -E "frontend|backend|pm"
```

---

## Bagian 4 — Membuat User (useradd, passwd)

### Langkah 4.1 — Buat user Rama (tim Frontend)

```bash
useradd -m -s /bin/bash -G frontend-team rama
```

Keterangan flag:
- `-m` = buat home directory otomatis di /home/rama
- `-s /bin/bash` = set shell default ke bash
- `-G frontend-team` = masukkan ke grup frontend-team

### Langkah 4.2 — Set password untuk Rama

```bash
passwd rama
```

Masukkan password saat diminta (contoh: `Frontend@123`). Ulangi untuk konfirmasi.

### Langkah 4.3 — Buat user Hanif (tim Frontend)

```bash
useradd -m -s /bin/bash -G frontend-team hanif
passwd hanif
```

### Langkah 4.4 — Buat user Harry (tim Backend)

```bash
useradd -m -s /bin/bash -G backend-team harry
passwd harry
```

### Langkah 4.5 — Buat user Kacung (tim Backend)

```bash
useradd -m -s /bin/bash -G backend-team kacung
passwd kacung
```

### Langkah 4.6 — Buat user Josh (PM)

Josh adalah PM yang perlu melihat semua direktori. Kita masukkan Josh ke semua grup.

```bash
useradd -m -s /bin/bash -G frontend-team,backend-team,pm-team josh
passwd josh
```

### Langkah 4.7 — Verifikasi semua user berhasil dibuat

```bash
cat /etc/passwd | grep -E "rama|hanif|harry|kacung|josh"
```

---

## Bagian 5 — Mengecek Identitas User (id)

### Langkah 5.1 — Cek informasi user Rama

```bash
id rama
```

Output yang diharapkan:
```
uid=1001(rama) gid=1001(rama) groups=1001(rama),1003(frontend-team)
```

Penjelasan output:
- `uid` = User ID (nomor unik user)
- `gid` = Group ID utama user
- `groups` = Semua grup yang diikuti user

### Langkah 5.2 — Cek informasi user Josh

```bash
id josh
```

Josh seharusnya muncul di banyak grup karena dia PM.

### Langkah 5.3 — Cek identitas dirimu sendiri

```bash
id
```

---

## Bagian 6 — Mengatur Kepemilikan Direktori (chown)

Sekarang kita atur siapa yang "memiliki" setiap direktori.

### Langkah 6.1 — Set kepemilikan direktori frontend ke grup frontend-team

```bash
chown root:frontend-team /project/frontend
```

Format `chown`: `chown [user]:[group] [target]`

### Langkah 6.2 — Set kepemilikan direktori backend ke grup backend-team

```bash
chown root:backend-team /project/backend
```

### Langkah 6.3 — Set kepemilikan direktori database dan docs ke root

```bash
chown root:root /project/database
chown root:root /project/docs
```

### Langkah 6.4 — Verifikasi kepemilikan

```bash
ls -la /project/
```

Perhatikan kolom ketiga dan keempat — itulah user dan group pemilik direktori.

---

## Bagian 7 — Mengatur Hak Akses (chmod)

Ini adalah bagian paling penting! Kita akan set permission sesuai kebijakan perusahaan.

### Memahami Permission Linux

Sebelum lanjut, pahami dulu notasi permission:

```
drwxrwxr-x
│└──┬──┘└──┬──┘└──┬──┘
│   │      │      └── Other (semua user lain): r-x = baca+eksekusi
│   │      └───────── Group: rwx = baca+tulis+eksekusi  
│   └──────────────── Owner/User: rwx = baca+tulis+eksekusi
└──────────────────── d = directory
```

Dalam notasi angka:
- `4` = read (r)
- `2` = write (w)
- `1` = execute (x)
- `7` = rwx (4+2+1)
- `5` = r-x (4+0+1)
- `0` = --- (tidak ada akses)

### Langkah 7.1 — Set permission direktori /frontend

Frontend-team boleh baca+tulis, group lain tidak boleh masuk:

```bash
chmod 770 /project/frontend
```

Artinya:
- Owner (root): rwx = bisa baca, tulis, masuk
- Group (frontend-team): rwx = bisa baca, tulis, masuk
- Others: --- = tidak bisa sama sekali

### Langkah 7.2 — Set permission direktori /backend

```bash
chmod 770 /project/backend
```

### Langkah 7.3 — Set permission direktori /database (semua tim bisa baca)

```bash
chmod 755 /project/database
```

Artinya:
- Owner (root): rwx
- Group: r-x = hanya baca dan masuk, tidak bisa tulis
- Others: r-x = sama seperti group

### Langkah 7.4 — Set permission direktori /docs

```bash
chmod 755 /project/docs
```

### Langkah 7.5 — Verifikasi semua permission

```bash
ls -la /project/
```

Output yang diharapkan:
```
drwxrwx--- 2 root backend-team  ... backend
drwxr-xr-x 2 root root          ... database
drwxr-xr-x 2 root root          ... docs
drwxrwx--- 2 root frontend-team ... frontend
```

---

## Bagian 8 — Menyiapkan Konten File (cp, mv, rm)

Sekarang kita isi direktori dengan file-file simulasi project.

### Langkah 8.1 — Buat file contoh di direktori docs (sebagai root)

```bash
echo "Ini adalah dokumentasi umum Company A" > /project/docs/README.md
echo "API v1.0 documentation" > /project/docs/api-docs.md
echo "Database schema v2" > /project/docs/db-schema.md
```

### Langkah 8.2 — Salin file dokumentasi ke frontend dan backend (cp)

Tim frontend butuh salinan README untuk referensi:

```bash
cp /project/docs/README.md /project/frontend/README.md
cp /project/docs/api-docs.md /project/backend/api-docs.md
```

`cp` menyalin file tanpa menghapus file aslinya.

### Langkah 8.3 — Pindahkan file yang salah tempat (mv)

Misalnya ada file schema yang terlanjur dibuat di root:

```bash
echo "schema data dummy" > /tmp/schema-dummy.sql
mv /tmp/schema-dummy.sql /project/database/schema.sql
```

`mv` bisa digunakan untuk memindahkan file **dan** mengubah nama file.

Contoh rename file:

```bash
mv /project/database/schema.sql /project/database/schema-v1.sql
```

### Langkah 8.4 — Hapus file yang tidak diperlukan (rm)

```bash
echo "file sampah" > /project/docs/tmp.txt
ls /project/docs/
rm /project/docs/tmp.txt
ls /project/docs/
```

Untuk menghapus direktori beserta isinya:

```bash
rm -rf /path/ke/direktori/
```

Hati-hati dengan `rm -rf` — tidak ada recycle bin di Linux!

---

## Bagian 9 — Membuat Symbolic Link (ln)

Symbolic link (symlink) adalah shortcut — seperti Windows shortcut, tapi lebih powerful.

### Skenario: Josh butuh akses cepat ke semua direktori dari home-nya

### Langkah 9.1 — Login sebagai root dan buat symlink untuk Josh

```bash
ln -s /project/frontend /home/josh/frontend
ln -s /project/backend /home/josh/backend
ln -s /project/database /home/josh/database
ln -s /project/docs /home/josh/docs
```

Flag `-s` artinya symbolic link (bukan hard link).

### Langkah 9.2 — Verifikasi symlink berhasil dibuat

```bash
ls -la /home/josh/
```

Symlink ditandai dengan tanda panah `->`:

```
lrwxrwxrwx 1 root root ... backend -> /project/backend
lrwxrwxrwx 1 root root ... database -> /project/database
lrwxrwxrwx 1 root root ... docs -> /project/docs
lrwxrwxrwx 1 root root ... frontend -> /project/frontend
```

### Langkah 9.3 — Perbaiki kepemilikan symlink agar Josh bisa gunakan

```bash
chown -h josh:josh /home/josh/frontend
chown -h josh:josh /home/josh/backend
chown -h josh:josh /home/josh/database
chown -h josh:josh /home/josh/docs
```

---

## Bagian 10 — Berpindah User dan Menguji Akses (su, sudo)

Sekarang saatnya pengujian! Kita akan masuk sebagai masing-masing user dan cek apakah policy berjalan benar.

### Langkah 10.1 — Switch ke user Rama (su)

```bash
su - rama
```

Flag `-` berarti load environment variables milik user tersebut (bukan sekedar ganti user).

### Langkah 10.2 — Cek identitas Rama

```bash
id
pwd
```

### Langkah 10.3 — Uji akses Rama ke direktori frontend (HARUS BISA)

```bash
cd /project/frontend
ls
echo "Ini file dari Rama" > test-rama.txt
ls
```

Seharusnya berhasil karena Rama ada di grup frontend-team.

### Langkah 10.4 — Uji akses Rama ke direktori backend (HARUS GAGAL)

```bash
cd /project/backend
```

Output yang diharapkan:
```
-bash: cd: /project/backend: Permission denied
```

Ini benar! Rama tidak boleh masuk ke direktori backend.

### Langkah 10.5 — Uji akses Rama ke database dan docs (HARUS BISA baca)

```bash
cd /project/database
ls
cd /project/docs
ls
```

### Langkah 10.6 — Kembali ke root

```bash
exit
```

### Langkah 10.7 — Uji akses Backend (Harry)

```bash
su - harry
id
cd /project/backend
ls
echo "File dari Harry" > test-harry.txt
cd /project/frontend
```

Akses ke /project/frontend harus menghasilkan `Permission denied`.

```bash
exit
```

### Langkah 10.8 — Uji akses PM (Josh)

```bash
su - josh
id
ls ~/
cd /project/frontend
ls
cd /project/backend
ls
cd /project/database
ls
exit
```

Josh harus bisa masuk ke semua direktori.

### Langkah 10.9 — Jalankan command sebagai root tanpa ganti user (sudo)

Misalnya Harry perlu melihat log system tanpa jadi root:

Tambahkan harry ke sudoers dulu (dari root):

```bash
usermod -aG sudo harry
```

Kemudian test dari Harry:

```bash
su - harry
sudo ls /root
```

`sudo` memungkinkan user biasa menjalankan perintah dengan hak root,
tanpa harus tahu password root — hanya perlu password mereka sendiri.

```bash
exit
```

---

## Bagian 11 — Mengubah Password (passwd)

### Langkah 11.1 — User mengubah password sendiri

```bash
su - rama
passwd
```

Masukkan password lama, lalu password baru dua kali.

### Langkah 11.2 — Root mengubah password user lain (tanpa tahu password lama)

```bash
exit
passwd hanif
```

Root bisa mengubah password siapapun tanpa perlu tahu password lama.

---

## Ringkasan Command

| Command | Contoh Penggunaan | Fungsi |
|---------|-------------------|--------|
| `ls` | `ls -la /project` | Lihat isi direktori |
| `pwd` | `pwd` | Tampilkan lokasi saat ini |
| `cd` | `cd /project/frontend` | Berpindah direktori |
| `mkdir` | `mkdir -p /project/frontend` | Membuat direktori |
| `cp` | `cp file.md /project/docs/` | Menyalin file |
| `mv` | `mv file.sql /project/database/` | Memindahkan/rename file |
| `rm` | `rm -rf /tmp/sampah` | Menghapus file/direktori |
| `ln` | `ln -s /project/docs ~/docs` | Membuat symbolic link |
| `useradd` | `useradd -m -s /bin/bash -G frontend-team rama` | Membuat user baru |
| `passwd` | `passwd rama` | Mengatur/mengubah password |
| `id` | `id rama` | Melihat UID, GID, dan grup user |
| `su` | `su - rama` | Berpindah ke user lain |
| `sudo` | `sudo ls /root` | Jalankan command sebagai root |
| `chown` | `chown root:frontend-team /project/frontend` | Ubah kepemilikan file/dir |
| `chmod` | `chmod 770 /project/frontend` | Ubah permission file/dir |

---

## Tantangan Tambahan

Setelah selesai semua langkah di atas, coba kerjakan tantangan berikut:

1. **Tantangan 1**: Buat user baru bernama `intern` yang hanya bisa membaca direktori `/docs`, tanpa akses ke direktori lainnya.

2. **Tantangan 2**: Josh meminta file `api-docs.md` dipindahkan dari `/project/backend` ke `/project/docs`. Lakukan pemindahan tersebut sebagai user yang tepat.

3. **Tantangan 3**: Tim Frontend membuat file `style.css` di direktori frontend. Bagaimana caranya agar Harry (Backend) juga bisa membaca file itu tanpa mengubah permission direktori frontend?
   (Hint: gunakan `cp` untuk menyalin ke direktori yang bisa diakses Harry)

4. **Tantangan 4**: Ganti nama direktori `/project` menjadi `/srv/company-a` dan pastikan semua symlink Josh masih berfungsi. Apa yang terjadi pada symlink-nya?

---

## Catatan Penting

- Selalu hati-hati saat menggunakan `rm -rf` — perintah ini tidak bisa dibatalkan.
- `sudo` memberikan kekuatan besar, gunakan dengan bijak.
- Di dunia nyata, permission management biasanya menggunakan ACL (Access Control List) untuk kasus yang lebih kompleks.
- Jika ada command yang tidak berjalan, cek dulu apakah kamu menjalankannya sebagai user yang tepat dengan `id` atau `whoami`.