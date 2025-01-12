# /bin/sh
# links the config files to their corresponding place

# neovim
rm -rf ~/.config/nvim
ln -s $PWD/nvim ~/.config/

# i3
rm -rf ~/.config/i3
ln -s $PWD/i3 ~/.config

# alacritty
rm -rf ~/.config/alacritty
ln -s $PWD/alacritty ~/.config

# rofi
rm -rf ~/.config/rofi
ln -s $PWD/rofi ~/.config
