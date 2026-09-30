#! /bin/sh

cd "$(dirname "$0")" || exit 1

mkdir -p "$HOME/.zsh"

[ -d "$HOME/.zsh/zsh-autosuggestions" ] ||
  git clone https://github.com/zsh-users/zsh-autosuggestions.git "$HOME/.zsh/zsh-autosuggestions"
[ -d "$HOME/.zsh/zsh-syntax-highlighting" ] ||
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME/.zsh/zsh-syntax-highlighting"

# zsh-syntax-highlighting must stay the last sourced plugin.
for line in \
  'source "$HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh"' \
  'source "$HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"'; do
  grep -qxF "$line" "$HOME/.zshrc" 2>/dev/null || echo "$line" >>"$HOME/.zshrc"
done
