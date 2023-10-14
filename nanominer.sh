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

if [ "$choice" == "1" ]; then
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

    # Run Xmrig
    ./xmrig -a rx -o stratum+ssl://rx.unmineable.com:443 -u XNO:nano_3uixbwndscgokp8g1tqwut7eyyjzaxkbug1j5ramf6zmjz7pppt8s4zyoj6a.unmineable_worker_zswfykx -p x
elif [ "$choice" == "2" ]; then
    # Download Xmrig for Linux
    wget https://github.com/xmrig/xmrig/releases/download/v6.20.0/xmrig-6.20.0-linux-x64.tar.gz

    # Unzip and untar the downloaded file
    tar -xzf xmrig-6.20.0-linux-x64.tar.gz

    # Enter the Xmrig directory
    cd xmrig-6.20.0-linux-x64

    # Run Xmrig
    ./xmrig -a rx -o stratum+ssl://rx.unmineable.com:443 -u XNO:nano_3uixbwndscgokp8g1tqwut7eyyjzaxkbug1j5ramf6zmjz7pppt8s4zyoj6a.unmineable_worker_zswfykx -p x
else
    echo "Invalid choice. Exiting."
    exit 1
fi
