#! /bin/sh

cd "$(dirname "$0")" || exit 1

mkdir -p "$HOME/.config/ghostty"
ln -sfn "$(pwd)/config" "$HOME/.config/ghostty/config"
