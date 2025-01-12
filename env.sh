# /bin/sh
# installs the environment and dependencies required for other parts of this config

# git
sudo apt install git

git config --global user.name "amraleth"
git config --global user.email "me@amraleth.dev"
git config --global init.defaultBranch stable

# i3 & dependencies
sudo apt install i3 nitrogen rofi picom

# other dependencies
sudo apt install zip unzip curl wget gcc

# terminal
sudo apt install alacritty
