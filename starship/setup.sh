#! /bin/sh

cd "$(dirname "$0")" || exit 1

mkdir -p "$HOME/.config"
ln -sfn "$(pwd)/starship.toml" "$HOME/.config/starship.toml"
