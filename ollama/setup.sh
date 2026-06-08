#! /bin/sh

ln -s $(pwd)/.ollama.sh ~/.ollama.sh
[ -f "$(pwd)/.ollama.local.sh" ] && ln -s $(pwd)/.ollama.local.sh ~/.ollama.local.sh

echo 'source "$HOME/.ollama.sh"' >>$HOME/.zshrc
