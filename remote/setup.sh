#! /bin/sh

ln -s $(pwd)/.remote.sh ~/.remote.sh
[ -f "$(pwd)/.remote.local.sh" ] && ln -s $(pwd)/.remote.local.sh ~/.remote.local.sh

echo 'source "$HOME/.remote.sh"' >>$HOME/.zshrc
