#! /bin/sh

mkdir -p ~/.config/tmux/plugins/catppuccin
git clone -b v2.3.0 https://github.com/catppuccin/tmux.git ~/.config/tmux/plugins/catppuccin/tmux

ln -s $(pwd)/.tmux.conf ~/.tmux.conf

tmux source ~/.tmux.conf
