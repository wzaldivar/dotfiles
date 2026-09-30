#! /bin/sh

cd "$(dirname "$0")" || exit 1

mkdir -p ~/.config/nvim/lua/plugins
ln -sfn "$(pwd)/plugins/colorscheme.lua" ~/.config/nvim/lua/plugins/colorscheme.lua
