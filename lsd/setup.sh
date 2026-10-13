#! /bin/sh

cd "$(dirname "$0")" || exit 1

mkdir -p "$HOME/.config/lsd"
ln -sfn "$(pwd)/config.yaml" "$HOME/.config/lsd/config.yaml"
ln -sfn "$(pwd)/colors.yaml" "$HOME/.config/lsd/colors.yaml"
