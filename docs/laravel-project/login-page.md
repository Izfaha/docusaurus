---
sidebar_label: Laravel Breeze 
sidebar_position: 2
---

# Login & Register menggunakan Laravel Breeze

## Installasi Laravel Breeze

Installasi menggunakan composer

```sh
composer require laravel/breeze --dev
php artisan breeze:install

# kalo mau dirun pake 2 command dibawah ini kalo ndak ya... ndak papa 
npm install && npm run dev
php artisan migrate
```

Setelah installasi maka akan ada 2 id yaitu ```/login``` & ```/register```.

:::note
Kalo ingin melihat bisa di run menggunakan ```php artisan serve``` lalu akses buka localhost dan arahkan ke id tersebut.
:::

```sh
http://localhost:8000/register
http://localhost:8000/login
```
