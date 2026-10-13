#! /bin/sh

cd "$(dirname "$0")" || exit 1

ln -sfn "$(pwd)/.remote.sh" "$HOME/.remote.sh"
[ -f "$(pwd)/.remote.local.sh" ] && ln -sfn "$(pwd)/.remote.local.sh" "$HOME/.remote.local.sh"

line='source "$HOME/.remote.sh"'
grep -qxF "$line" "$HOME/.zshrc" 2>/dev/null || echo "$line" >>"$HOME/.zshrc"
