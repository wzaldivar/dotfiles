#! /bin/sh

cd "$(dirname "$0")" || exit 1

mkdir -p ~/.config
ln -sfn "$(pwd)/starship.toml" ~/.config/starship.toml
