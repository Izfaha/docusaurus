---
sidebar_title: OpenCV C++ Installation
sidebar_position: 3
---

# OpenCV C++ installation

:::info[Disclaimer]
In this case, I use Original Jetson Nano 4GB, OS debian 18.x. 
:::

## Build Core Modulex
```sh
# Install minimal prerequisites (Ubuntu 18.04 as reference)
sudo apt update && sudo apt install -y cmake g++ wget unzip
 
# Download and unpack sources
wget -O opencv.zip https://github.com/opencv/opencv/archive/4.x.zip
unzip opencv.zip
 
# Create build directory
mkdir -p build && cd build
 
# Configure
cmake  ../opencv-4.x
 
# Build
cmake --build .
```

## Build with opencv_contrib

```sh
# Install minimal prerequisites (Ubuntu 18.04 as reference)
sudo apt update && sudo apt install -y cmake g++ wget unzip
 
# Download and unpack sources
wget -O opencv.zip https://github.com/opencv/opencv/archive/4.x.zip
wget -O opencv_contrib.zip https://github.com/opencv/opencv_contrib/archive/4.x.zip
unzip opencv.zip
unzip opencv_contrib.zip
 
# Create build directory and switch into it
mkdir -p build && cd build
 
# Configure
cmake -DOPENCV_EXTRA_MODULES_PATH=../opencv_contrib-4.x/modules ../opencv-4.x
 
# Build
cmake --build .
```

## Verify the installation

By default OpenCV will be install to the `/usr/local` directory. You can check using `ls` command.

- `/usr/local/bin` executable files
- `/usr/local/lib` libraries (.so)
- `/usr/local/cmake/opencv4` cmake package
- `/usr/local/include/opencv4` headers
- `/usr/local/share/opencv4` other files