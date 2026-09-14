---
sidebar_title: Jenkins
---

# Jenkins Quick Start

## Login Jenkins 

Login jenkis doscom jenkins.doscom.org dan akan tampil halaman login :
Untuk User dan Password nya bisa di tanyakan ke Tech Lead = Mas Fadhil Ryanto.

![loginpage](./img/jenkins-login-page.png)

## Cara Buat Pipeline

Setelah login akan diarahkan ke Dashboard Jenkins :

![dashboard](./img/jenkins-dashboard.png)

klik `New Item` => isi `Enter an item name` dengan nama project (nama app atau web) dan pada 
section `Select an item type` pilih `Organization Folder` => lalu klik `Ok`. 

![create-pipeline](./img/create-pipeline.png)

Sementara kita hanya mengimplementasikan Pipeline untuk project kita. 
Kenapa nggak `Multibrach Pipeline` karena resource server kita belum cukup untuk multiple build dan proses build
juga memerukan resource yg besar jika lebih dari 1 project.

## Setting Project Configuration

Setelah create project kita akan mengonfigurasi dan juga memberi tau Jenkins kita akan membuat pipeline untuk repository mana.

### Display Name dan Description

Sekarang Isi `Display Name` bisa di rubah atau di sesuaikan saja dengan nama item sebelumnya.
Lalu `Description` bersifat opsional boleh di kosongkan atau di isi. 

![display-and-description](./img/display-name-and-description.png)

### Repository Sources

Untuk `Project` => `Repository Sources` klik `+ Add` => `GitHub Organization` ini akan mengconnect kan jenkins dengan GitHub Doscom.

![sources](./img/repository-sources.png)

![github](./img/github-organization.png)

### GitHub Organization

`Credential` pilih `DOSCOM GitHub App`

![doscom-gh-page](./img/doscom-ghpage.png)

Untuk `Repository HTTPS URL` isi dengan repository yg di tuju.
Untuk `Behaviors` pada `Discover branches` => `Strategy` isi dengan `Exclude brances that are also filled as PRs`.

Untuk `Filter by name (with wildcards) ` => `Include` isi dengan brach yg mau di scan, dalam case ini kita pake branch `main`. 

Untuk `Property strategy` pilih `All branches get the same properties`.

![doscom](./img/branch-resources.png)

untuk konfigurasi lainya biarkan default saja.

Kurang lebihnya sesuai seperti ss diatas, jika ada pertanyaan bisa ditanyakan ke => PR abang Fa'iz.

## Post Createing Pipeline

Setelah buat 