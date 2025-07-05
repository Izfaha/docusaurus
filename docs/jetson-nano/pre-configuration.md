---
sidebar_title: Preconfigure Jetson Nano
sidebar_position: 1
---

# Pre-request

:::note[Important]
In this documentation, I am utilazing jetson nano RAM 4GB. __This is crusial__, in this documentation, it is according to my personal experience. It migh be different at your case.
:::

In this case I requres to make image segmentation and object detection. It will be using jetson-inference, jetson-utils, CUDA, cuDNN,OpenCV.

First thing first, Install jetpack SDK in your jetson nano. Then, untuk folder structure aku taruh di ```Documents/image-segmentation```.

Masuk ke folder tersebut dengan

```sh
cd ~/Documents/image-segmentation
```

lalu, clone jetson-inferece dari github

```sh
git clone --recursive https://github.com/dusty-nv/jetson-inference
```

:::note[Crusial]
wajib memakai ```--recursive```, jika tidak maka akan ada banyak file yang hilang.

Kalo terlanjur melupakan ```--recursive```, maka jalankan comman ini

```sh
cd jetson-inference
git submodule update --init
```

:::

setelah itu, struktur file nya akan seperti ini

```sh showLineNumbers
~/Documents/image-segmentation/
├── jetson-inference/               ← Repo utama dari NVIDIA
│   ├── CMakeLists.txt              ← File konfigurasi CMake
│   ├── CMakePreBuild.sh
│   ├── tools/                      ← Tools Python & C++
│   ├── examples/                   ← Semua contoh program (C++)
│   │   ├── segnet/                 ← Segmentation (pakai C++)
│   │   │   ├── segnet-camera.cpp  ← Program real-time pakai USB cam
│   │   │   ├── segnet-console.cpp ← Segmentation dari file image
│   │   │   └── ...
│   │   ├── imagenet/
│   │   ├── detectnet/
│   │   └── ...
│   ├── data/                       ← Folder model dan data sample
│   ├── docs/                       ← Dokumentasi
│   ├── jetson-inference/          ← Header + core C++ library
│   │   └── segNet.h, etc.
│   ├── jetson-utils/              ← Library utilitas (camera, video, image, dll)
│   ├── build/                     ← Dibuat setelah cmake/make
│   │   └── aarch64/
│   │       └── bin/
│   │           └── segnet-camera ← Binary siap dijalankan
│   └── CMakeLists.txt
└── (kamu bisa tambahkan folder sendiri nanti)
```
