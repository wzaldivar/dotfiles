#! /bin/sh

mkdir -p "$HOME/.zsh"

git clone https://github.com/Aloxaf/fzf-tab.git "$HOME/.zsh/fzf-tab"

ln -s $(pwd)/.carapace.sh ~/.carapace.sh

echo 'source "$HOME/.carapace.sh"' >>$HOME/.zshrc
