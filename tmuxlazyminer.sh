#!/bin/bash
# Enhanced Crypto Mining Setup Script
# This script helps set up and start mining cryptocurrencies using XMRig.
# It supports multiple cryptocurrencies and uses both a config file and command-line arguments.
#
# Usage:
# Run without arguments for an interactive setup: ./this_script.sh
# Or, specify a crypto choice directly: ./this_script.sh -c BTC
#
# Supported cryptocurrencies: Bitcoin (BTC), Dogecoin (DOGE), Nano (NANO)
# Prerequisites: cmake, git

# Define file to store previous wallet addresses
wallet_file="wallet_addresses.txt"

# Function to display usage
usage() {
    echo "Usage: $0 [-c <BTC|DOGE|NANO>]"
    exit 1
}

# Parse command-line arguments
while getopts ":c:" opt; do
  case ${opt} in
    c ) crypto_choice=${OPTARG^^};;
    * ) usage;;
  esac
done

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

# Function to prompt for wallet address
prompt_for_address() {
    echo "Please enter your wallet address for $1 (e.g., $2):"
    read -r wallet_address
    echo "$1_address=$wallet_address" >> ../$wallet_file
}

# Function to choose cryptocurrency
choose_crypto() {
    echo "Please choose a cryptocurrency: Bitcoin (B), Dogecoin (D), or Nano (N)."
    read -r choice
    case $choice in
      B|b) crypto="BTC"; example_address="bc1q..." ;;
      D|d) crypto="DOGE"; example_address="D6Q..." ;;
      N|n) crypto="NANO"; example_address="nano_3uix..." ;;
      *) echo "Invalid choice, exiting."; exit 1 ;;
    esac
}

# If no command-line argument, interactively choose cryptocurrency
if [ -z "$crypto_choice" ]; then
    choose_crypto
else
    crypto=$crypto_choice
    case $crypto in
      BTC) example_address="bc1q..." ;;
      DOGE) example_address="D6Q..." ;;
      NANO) example_address="nano_3uix..." ;;
      *) echo "Invalid cryptocurrency choice provided."; exit 1 ;;
    esac
fi

# Check for saved wallet addresses
if [ -f "../$wallet_file" ]; then
    echo "Do you want to use the saved wallet addresses? (y/n)"
    read -r use_saved
    if [ "$use_saved" = "y" ]; then
        source ../$wallet_file
    else
        rm ../$wallet_file
    fi
fi

# Prompt for wallet address if not saved
if [ -z "${crypto}_address" ]; then
    prompt_for_address $crypto $example_address
fi

# Construct and run the final command
final_command="./xmrig -o pool.example.com:3333 -u ${crypto}:${crypto}_address.worker -p x"
echo "Starting mining with the following command:"
echo $final_command
eval $final_command
