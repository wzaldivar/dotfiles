#! /bin/sh

ln -s $(pwd)/.gitconfig.personal ~/.gitconfig.personal
ln -s $(pwd)/.gitconfig.setup.sh ~/.gitconfig.setup.sh
[ -f "$(pwd)/.gitconfig.personal.local" ] && ln -s $(pwd)/.gitconfig.personal.local ~/.gitconfig.personal.local

echo 'source "$HOME/.gitconfig.setup.sh"' >>$HOME/.zshrc
