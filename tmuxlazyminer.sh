#!/bin/bash

# Define file to store previous wallet addresses
wallet_file="wallet_addresses.txt"

# Update packages
echo "Updating packages..."
pkg update -y

# Install necessary packages
echo "Installing necessary packages..."
pkg install -y cmake git

# Clone the repository and build the project if not already done
if [ ! -d "xmrig" ]; then
    git clone https://github.com/xmrig/xmrig.git
    cd xmrig || exit
    mkdir build
    cd build || exit
    cmake -DWITH_HWLOC=OFF ..
    make
else
    echo "XMRig already cloned and built."
    cd xmrig/build || exit
fi

# Function to prompt for wallet address
prompt_for_address() {
    echo "Please enter your wallet address for $1 (e.g., $2):"
    read -r wallet_address
    echo "$1_address=$wallet_address" >> $wallet_file
}

# Check if the user wants to use saved wallet addresses
if [ -f "$wallet_file" ]; then
    echo "Do you want to use the saved wallet addresses? (y/n)"
    read -r use_saved

    if [ "$use_saved" = "y" ]; then
        source $wallet_file
    else
        rm $wallet_file
    fi
fi

# Choose the crypto
echo "Please choose a cryptocurrency: Bitcoin (B), Dogecoin (D), or Nano (N)."
read -r choice

case $choice in
  B|b)
    crypto="Bitcoin"
    example_address="bc1q0fzk4fgrl7dt5f8thkc8zvy8e6u604r8gq85tg"
    [ -z "$BTC_address" ] && prompt_for_address $crypto $example_address
    BTC_address=${BTC_address:-$(grep "Bitcoin_address" $wallet_file | cut -d '=' -f2)}
    final_command="./xmrig -a rx -o stratum+ssl://rx.unmineable.com:443 -u BTC:$BTC_address.unmineable_worker_inhcado -p x"
    ;;
  D|d)
    crypto="Dogecoin"
    example_address="D6QUZViFSiEWkeAkGdYyPPoJszQ9RZBX29"
    [ -z "$DOGE_address" ] && prompt_for_address $crypto $example_address
    DOGE_address=${DOGE_address:-$(grep "Dogecoin_address" $wallet_file | cut -d '=' -f2)}
    final_command="./xmrig -a rx -o stratum+ssl://rx.unmineable.com:443 -u DOGE:$DOGE_address.unmineable_worker_qtdfydkv -p x"
    ;;
  N|n)
    crypto="Nano"
    example_address="nano_3uixbwndscgokp8g1tqwut7eyyjzaxkbug1j5ramf6zmjz7pppt8s4zyoj6a"
    [ -z "$NANO_address" ] && prompt_for_address $crypto $example_address
    NANO_address=${NANO_address:-$(grep "Nano_address" $wallet_file | cut -d '=' -f2)}
    final_command="./xmrig -a rx -o stratum+ssl://rx.unmineable.com:443 -u XNO:$NANO_address.unmineable_worker_zswfykx -p x"
    ;;
  *)
    echo "Invalid choice, cuz. Exiting."
    exit 1
    ;;
esac

# Run the final command
echo "Starting mining with the following command:"
echo $final_command
$final_command
