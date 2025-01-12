# /bin/sh
# installs neovim from github releases

wget https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
mv nvim.appimage nvim
chmod +x nvim
sudo mv nvim /usr/local/bin
