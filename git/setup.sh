#! /bin/sh

cd "$(dirname "$0")" || exit 1

ln -sfn "$(pwd)/.gitconfig.personal" ~/.gitconfig.personal
ln -sfn "$(pwd)/.gitconfig.setup.sh" ~/.gitconfig.setup.sh
[ -f "$(pwd)/.gitconfig.personal.local" ] &&
  ln -sfn "$(pwd)/.gitconfig.personal.local" ~/.gitconfig.personal.local

line='source "$HOME/.gitconfig.setup.sh"'
grep -qxF "$line" "$HOME/.zshrc" 2>/dev/null || echo "$line" >>"$HOME/.zshrc"
