#! /bin/sh

cd "$(dirname "$0")" || exit 1

ln -sfn "$(pwd)/.ideavimrc" ~/.ideavimrc

mkdir -p ~/.ideavimrc_extra
ln -sfn "$(pwd)/extra/toggle_camelcase_motion.vim" ~/.ideavimrc_extra/toggle_camelcase_motion.vim
