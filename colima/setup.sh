#! /bin/sh

cd "$(dirname "$0")" || exit 1

ln -sfn "$(pwd)/.colima.sh" ~/.colima.sh

line='source "$HOME/.colima.sh"'
grep -qxF "$line" "$HOME/.zshrc" 2>/dev/null || echo "$line" >>"$HOME/.zshrc"
