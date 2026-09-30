#! /bin/sh

cd "$(dirname "$0")" || exit 1

mkdir -p ~/.config/lsd
ln -sfn "$(pwd)/config.yaml" ~/.config/lsd/config.yaml
ln -sfn "$(pwd)/colors.yaml" ~/.config/lsd/colors.yaml
