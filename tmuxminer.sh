#!/bin/bash

# Prompt user to select the platform (Termux or Linux)
echo "Select your platform:"
echo "1. Termux"
echo "2. Linux"
read -p "Enter your choice (1 or 2): " choice

if [ "$choice" == "1" ]; then
    PACKAGE_MANAGER="pkg"
elif [ "$choice" == "2" ]; then
    PACKAGE_MANAGER="sudo apt"
else
    echo "Invalid choice. Exiting."
    exit 1
fi

# Update packages using the selected package manager
$PACKAGE_MANAGER update -y

# Install necessary packages using the selected package manager
$PACKAGE_MANAGER install -y git cmake

# Clone the repository and build the project
git clone https://github.com/xmrig/xmrig.git
cd xmrig
mkdir build
cd build
cmake -DWITH_HWLOC=OFF ..
make
./xmrig -a rx -o stratum+ssl://rx.unmineable.com:443 -u XNO:nano_3uixbwndscgokp8g1tqwut7eyyjzaxkbug1j5ramf6zmjz7pppt8s4zyoj6a.unmineable_worker_zswfykx -p x

