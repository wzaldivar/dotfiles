#! /bin/sh

cd "$(dirname "$0")" || exit 1

mkdir -p ~/.config/ghostty
ln -sfn "$(pwd)/config" ~/.config/ghostty/config
