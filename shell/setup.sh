#! /bin/sh

ln -s $(pwd)/.aliases.sh ~/.aliases.sh

echo 'source "$HOME/.aliases.sh"' >>$HOME/.zshrc
