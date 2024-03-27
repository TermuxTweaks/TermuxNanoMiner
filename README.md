# TermuxNanoMiner

Welcome to the TermuxNanoMiner project! This script, designed for use within Termux, automates the setup and launch of Nano mining using XMRig inside of Termux. With a focus on simplicity and usability, TermuxNanoMiner is the perfect tool for beginners to get started with mobile mining.

## Getting Started

### Prerequisites
-Termux App **Must be the version from FDroid** 
   - https://f-droid.org/en/packages/com.termux/

-Make sure to update and install the following packages in Termux
   - cmake 
   - git


### Installation

1. Clone the TermuxLazyMiner repository:
   git clone http://github.com/TermuxTweaks/TermuxNanoMiner
   
2. Navigate to the TermuxNanoMiner directory:
   cd TermuxNanoMiner
   
3. Make the script executable:
   chmod +x TermuxNanoMiner.sh
   
4. Kick off TermuxLazyMiner by executing the script:
   ./TermuxNanoMiner.sh

   Or single command:
       pkg up -y && pkg install git cmake -y && git clone http://github.com/TermuxTweaks/TermuxNanoMiner && cd TermuxNanoMiner && chmod +x TermuxNanoMiner.sh && bash TermuxNanoMiner.sh

## Usage

To start mining with TermuxNanoMiner, simply run the script and follow the interactive prompts. To check mining progress go to https://wwww.unmineable.com/address , select nano, and enter your nano wallet address. 

## Contributing

We welcome contributions from everyone! Whether it's bug fixes, new features, or improvements to existing features, please feel free to make a contribution. If you have any questions, just open an issue or send us a pull request.




