#!/bin/bash

# Update packages
pkg update -y

# Install necessary packages
pkg install -y cmake

# Clone the repository and build the project
git clone https://github.com/xmrig/xmrig.git
cd xmrig
mkdir build
cd build
cmake -DWITH_HWLOC=OFF ..
make




