---
sidebar_label: Configurasi Awal Laravel
sidebar_position: 1
---
# Laravel Configuration

:::caution
Documentasi ini berisi pengalaman pribadi saya, dan mungkin tidak relate dengan issue/error yang kalian alami. Jika dokumentasi ini membuat lebih parah maka temukan dokumentasi yang terkait.
:::

```text
Buatlah program CRUD yang ada proses transaksinya, dikemas/di kontrol dalam sebuah dashboard, untuk masuk ke dashboard harus login terlebih dahulu. 
Program aplikasi yang di develop minimal menerapkan :
1. MVC
2. Teknik Ajax 
3. JSON
4. Search live
5. Unggah gambar/foto menggunakan standar MIME
6. Validasi form dan keamanan dasar
7. Diperbolehkan menggunakan jasa layanan API Key, provider bebas sesuai pilihan masing-masing (kalau diperlukan) 

Topik web
1. e-commerce
2. Platform Sewa Properti / Kos-kosan
3. Sistem Manajemen Koperasi Mahasiswa
4. Aplikasi Pemesanan Layanan (Booking Service)
5. Sistem Pembayaran SPP Sekolah / Kampus
6. Platform Donasi Online 
7. Penggajian
8. Sisfo Nilai Akademik
9. dll
```

## Setting .env

```sh
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=sewa_kosan
DB_USERNAME=kosuser
DB_PASSWORD=password123
```

Pastikan credentials yang di file ```.env``` (```DB_DATABASE, DB_USERNAME, DB_PASSWORD```) sama.

## Buat Model di Laravel

```sh
php artisan make:model Transaction
php artisan make:model Property
```

Pada command diatas, kita akan membuat file ```Transaction.php``` & ```Property.php``` di dalam directory ```Models```.

Untuk Models/Transaction.php isinya seperti ini

```php title='Models/Transaction.php'
<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Transaction extends Model
{
    use HasFactory;

    protected $fillable = [
        'user_id', 'property_id', 'amount', 'start_date', 'end_date'
    ];

    public function property() {
        return $this->belongsTo(Property::class);
    }

    public function user() {
        return $this->belongsTo(User::class);
    }
}
```

Untuk Models/Property.php isinya seperti ini

```php title='Models/Property.php'
<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Property extends Model
{
    Use HasFactory;

    protected $fillable = [
        'name', 'location', 'price', 'image', 'available'
    ];
}
```
