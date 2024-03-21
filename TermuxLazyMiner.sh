#!/bin/bash

# Define file to store previous wallet addresses
wallet_file="wallet_addresses.txt"

# Update packages
echo "Updating packages..."
if ! pkg update -y; then
    echo "Failed to update packages. Please check your package manager."
    exit 1
fi

# Install necessary packages
echo "Installing necessary packages..."
if ! pkg install -y cmake git; then
    echo "Failed to install necessary packages."
    exit 1
fi

# Clone the repository and build the project if not already done
if [ ! -d "xmrig" ]; then
    echo "Cloning and building XMRig..."
    if ! git clone https://github.com/xmrig/xmrig.git; then
        echo "Failed to clone XMRig. Check your internet connection."
        exit 1
    fi
    cd xmrig || exit
    mkdir build && cd build || exit
    if ! cmake -DWITH_HWLOC=OFF .. && make; then
        echo "Failed to build XMRig. Check cmake and make installation."
        exit 1
    fi
else
    echo "XMRig already cloned and built."
    cd xmrig/build || exit
fi

# Ensuring we're in the right directory to execute xmrig
xmrig_path=$(pwd)

# Function to prompt for cryptocurrency and wallet address
prompt_for_details() {
    echo "Please choose a cryptocurrency: Bitcoin (B), Dogecoin (D), or Nano (N)."
    read -r choice
    case $choice in
        B|b) 
            crypto="BTC"
            tag=".unmineable_worker_orbbwutd"
            example_address="bc1q..."
            ;;
        D|d) 
            crypto="DOGE"
            tag=".unmineable_worker_khirdmkp"
            example_address="D6Q..."
            ;;
        N|n) 
            crypto="XNO"
            tag=".unmineable_worker_nkdrzce"
            example_address="nano_3uix..."
            ;;
        *) echo "Invalid choice, exiting."; exit 1;;
    esac
    echo "Please enter your wallet address for $crypto (e.g., $example_address):"
    read -r wallet_address
    echo "${crypto}_address=$wallet_address" >> "$wallet_file"
    # Set final command based on cryptocurrency
    final_command="./xmrig -a rx -o stratum+ssl://rx.unmineable.com:443 -u $crypto:$wallet_address$tag -p x"
}

prompt_for_details

# Check if final_command is set, meaning we have prompted for details
if [ -z "$final_command" ]; then
    echo "No mining details provided. Exiting."
    exit 1
fi

# Execute the mining command
echo "Starting mining with the following command:"
echo $final_command
(cd $xmrig_path && eval $final_command)
