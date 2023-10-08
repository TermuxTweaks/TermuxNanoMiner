#!/bin/bash

# Update and upgrade packages
pkg update -y
pkg upgrade -y

# Install necessary packages
pkg install -y git cmake

# Clone the repository and build the project
git clone https://github.com/xmrig/xmrig.git
cd xmrig
mkdir build
cd build
cmake -DWITH_HWLOC=OFF ..
make
