#! /bin/sh

cd "$(dirname "$0")" || exit 1

ln -sfn "$(pwd)/.bitwarden.sh" "$HOME/.bitwarden.sh"

line='source "$HOME/.bitwarden.sh"'
grep -qxF "$line" "$HOME/.zshrc" 2>/dev/null || echo "$line" >>"$HOME/.zshrc"
