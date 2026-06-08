#! /bin/sh

ln -s $(pwd)/.colima.sh ~/.colima.sh

echo 'source "$HOME/.colima.sh"' >>$HOME/.zshrc
