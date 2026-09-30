#! /bin/sh

cd "$(dirname "$0")" || exit 1

ln -sfn "$(pwd)/.ollama.sh" "$HOME/.ollama.sh"
[ -f "$(pwd)/.ollama.local.sh" ] && ln -sfn "$(pwd)/.ollama.local.sh" "$HOME/.ollama.local.sh"

line='source "$HOME/.ollama.sh"'
grep -qxF "$line" "$HOME/.zshrc" 2>/dev/null || echo "$line" >>"$HOME/.zshrc"
