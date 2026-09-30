#! /bin/sh

cd "$(dirname "$0")" || exit 1

ln -sfn "$(pwd)/.ideavimrc" "$HOME/.ideavimrc"

mkdir -p "$HOME/.ideavimrc_extra"
ln -sfn "$(pwd)/extra/toggle_camelcase_motion.vim" "$HOME/.ideavimrc_extra/toggle_camelcase_motion.vim"
