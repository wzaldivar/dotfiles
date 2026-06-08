#! /bin/sh

ln -s $(pwd)/.bitwarden.sh ~/.bitwarden.sh

echo 'source "$HOME/.bitwarden.sh"' >>$HOME/.zshrc
