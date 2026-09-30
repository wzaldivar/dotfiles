#! /bin/sh

cd "$(dirname "$0")" || exit 1

mkdir -p ~/.config/tmux/plugins/catppuccin
[ -d ~/.config/tmux/plugins/catppuccin/tmux ] ||
  git clone -b v2.3.0 https://github.com/catppuccin/tmux.git ~/.config/tmux/plugins/catppuccin/tmux

ln -sfn "$(pwd)/.tmux.conf" ~/.tmux.conf

# Only reload when a server is already running.
if tmux has-session >/dev/null 2>&1; then
  tmux source-file ~/.tmux.conf
fi
