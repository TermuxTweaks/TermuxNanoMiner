#!/bin/bash

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

sudo apt update && sudo apt install git -y && git clone https://github.com/ShadyTrapShit/lazyminer && cd lazyminer && bash lazyminer.sh && cd xmrig-6.20.0 && $final_command



