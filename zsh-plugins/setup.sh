#! /bin/sh

mkdir -p "$HOME/.zsh"

git clone https://github.com/zsh-users/zsh-autosuggestions.git "$HOME/.zsh/zsh-autosuggestions"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME/.zsh/zsh-syntax-highlighting"

echo 'source "$HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh"' >>$HOME/.zshrc
echo 'source "$HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"' >>$HOME/.zshrc