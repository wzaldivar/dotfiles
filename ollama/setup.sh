#! /bin/sh

cd "$(dirname "$0")" || exit 1

ln -sfn "$(pwd)/.ollama.sh" ~/.ollama.sh
[ -f "$(pwd)/.ollama.local.sh" ] && ln -sfn "$(pwd)/.ollama.local.sh" ~/.ollama.local.sh

line='source "$HOME/.ollama.sh"'
grep -qxF "$line" "$HOME/.zshrc" 2>/dev/null || echo "$line" >>"$HOME/.zshrc"
