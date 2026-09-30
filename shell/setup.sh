#! /bin/sh

cd "$(dirname "$0")" || exit 1

ln -sfn "$(pwd)/.aliases.sh" ~/.aliases.sh

line='source "$HOME/.aliases.sh"'
grep -qxF "$line" "$HOME/.zshrc" 2>/dev/null || echo "$line" >>"$HOME/.zshrc"
