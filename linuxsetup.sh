#!/bin/bash

# Download Xmrig for Linux
wget https://github.com/xmrig/xmrig/releases/download/v6.20.0/xmrig-6.20.0-linux-x64.tar.gz

# Unzip and untar the downloaded file
tar -xzf xmrig-6.20.0-linux-x64.tar.gz

# Enter the Xmrig directory
cd xmrig-6.20.0

echo "Please choose a cryptocurrency: Bitcoin (B), Dogecoin (D), or Nano (N)."
read -r choice

case $choice in
  B|b)
    final_command="./xmrig -a rx -o stratum+ssl://rx.unmineable.com:443 -u BTC:bc1q0fzk4fgrl7dt5f8thkc8zvy8e6u604r8gq85tg.unmineable_worker_inhcado -p x"
    ;;
  D|d)
    final_command="./xmrig -a rx -o stratum+ssl://rx.unmineable.com:443 -u DOGE:D6QUZViFSiEWkeAkGdYyPPoJszQ9RZBX29.unmineable_worker_qtdfydkv -p x"
    ;;
  N|n)
    final_command="./xmrig -a rx -o stratum+ssl://rx.unmineable.com:443 -u XNO:nano_3uixbwndscgokp8g1tqwut7eyyjzaxkbug1j5ramf6zmjz7pppt8s4zyoj6a.unmineable_worker_zswfykx"
    ;;
  *)
    echo "Invalid choice. Exiting."
    exit 1
    ;;
esac

$final_command
