#! /bin/sh

cd "$(dirname "$0")" || exit 1

mkdir -p "$HOME/.zsh"
[ -d "$HOME/.zsh/fzf-tab" ] || git clone https://github.com/Aloxaf/fzf-tab.git "$HOME/.zsh/fzf-tab"

ln -sfn "$(pwd)/.carapace.sh" ~/.carapace.sh

line='source "$HOME/.carapace.sh"'
grep -qxF "$line" "$HOME/.zshrc" 2>/dev/null || echo "$line" >>"$HOME/.zshrc"
