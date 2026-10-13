#! /bin/sh

cd "$(dirname "$0")" || exit 1

mkdir -p "$HOME/.config/nvim/lua/plugins"
ln -sfn "$(pwd)/plugins/colorscheme.lua" "$HOME/.config/nvim/lua/plugins/colorscheme.lua"
