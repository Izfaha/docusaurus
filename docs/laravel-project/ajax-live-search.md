---
sidebar_title: Ajax Live Search 
sidebar_position: 3
---

# Ajax Live Search untuk kos

Setelah install Breeze Laraver configurasi file-file dibawah ini!

## Menambahkan route API JSON

Tambahkan route API JSON di ```routes/web.php```

```php title='routes/web.php'
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\PropertyController;

Route::get('/api/properties/search', [PropertyController::class, 'jsonSearch'])->middleware('auth');
```

```Route::get``` mendefinisikan route HTTP GET.

```/api/properties/search``` : URL endpoint yang akan diakses untuk melakukan pencarian.

## Menambakan Method JSON search

Menambahkan method JSON Search di ```app/Http/Controllers/PropertyController.php```

```php title='app/Http/Controllers/PropertyController.php'
public function jsonSearch(Request $request) {
    $query = $request->get('q');
    $results = Property::where('name', 'like', "%{$query}%")
        ->orWhere('location', 'like', "%{$query}%")
        ->limit(10)
        ->get(['id', 'name', 'location', 'price']);
    return response()->json($results);
}
```

```php title='resources/views/property/index.blade.php'
<form class="mb-3">
    <input type="text" id="searchInput" placeholder="Cari kos..." class="form-control">
</form>
<div id="resultArea">
    <table class="table">
        <thead>
            <tr>
                <th>Nama</th>
                <th>Lokasi</th>
                <th>Harga</th>
            </tr>
        </thead>
        <tbody id="resultTable">
            @foreach ($properties as $property)
                <tr>
                    <td>{{ $property->name }}</td>
                    <td>{{ $property->location }}</td>
                    <td>Rp {{ number_format($property->price) }}</td>
                </tr>
            @endforeach
        </tbody>
    </table>
</div>

<script>
    const input = document.getElementById('searchInput');
    const resultTable = document.getElementById('resultTable');

    input.addEventListener('keyup', function() {
        const keyword = this.value;
        fetch(`/api/properties/search?q=${keyword}`)
            .then(response => response.json())
            .then(data => {
                resultTable.innerHTML = '';
                data.forEach(p => {
                    const row = `<tr>
                        <td>${p.name}</td>
                        <td>${p.location}</td>
                        <td>Rp ${Number(p.price).toLocaleString()}</td>
                    </tr>`;
                    resultTable.innerHTML += row;
                });
            });
    });
</script>
```

:::info[Optional]
Jalan command ini jika belum di jalankan sebelumnya.

```sh
# Optional jika belum menginstall jika sudah menginstall breeze tidak perlu di run
# composer require laravel/breeze --dev
# php artisan breeze:install
npm install && npm run dev
php artisan migrate
```

:::

Sekarang coba register & login di: ```http://localhost:8000/login```
