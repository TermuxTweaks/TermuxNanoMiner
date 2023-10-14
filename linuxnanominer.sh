#!/bin/bash

# Download Xmrig for Linux
wget https://github.com/xmrig/xmrig/releases/download/v6.20.0/xmrig-6.20.0-linux-x64.tar.gz

# Unzip and untar the downloaded file
tar -xzf xmrig-6.20.0-linux-x64.tar.gz

# Enter the Xmrig directory
cd xmrig-6.20.0

# Run Xmrig
./xmrig -a rx -o stratum+ssl://rx.unmineable.com:443 -u XNO:nano_3uixbwndscgokp8g1tqwut7eyyjzaxkbug1j5ramf6zmjz7pppt8s4zyoj6a.unmineable_worker_zswfykx -p x

