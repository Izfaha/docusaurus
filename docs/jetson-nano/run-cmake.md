---
sidebar_title: Run CMake
sidebar_position: 2
---

# Run CMake

Jalankan CMake, tool untuk generate Makefile. Cmake akan :
    - Mendeteksi semua depedensi (CUDA, TensorRT, OpenCV, dsb)
    - Menyiapkan configurasi build
    - Menyiapkan model downloader otomatis

Jalankan dengan command berikut

```sh
cmake ../
```

Setelah itu compile code C++ dari ```jetson-inference```.\
dengan comman ini

```sh
make -j$(proc)
```

```-j$(proc)``` akan menjalankan compile paralel sebanya jumlah core CPU (misal -j4).\
Ini akan membangun library ```jetson-inferece``` dan semua contoh program seperti ```segnet-camera```, ```imagenet-console```, dll.\
Dan file compilasinya akan ada di ```build/aarch64/bin/```.

Lalu, jalankan

```sh
sudo make install
```

untuk install binary, library, dan model ke sistem.
    - menyalin file penting seperti ```.so```, ```.h```, dan model kesistem.
    - meletakan model ke ```/usr/local/share/jetson-inference/models```.

Setelah itu, run command

```sh
sudo ldconfig
```

Untuk memberitahu sistem kalo ada library baru yang ditambahkan (```.so``` files). Supaya jetson bisa mengenali library C++ dan jetson-inference.
