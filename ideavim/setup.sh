#! /bin/sh

ln -s $(pwd)/.ideavimrc ~/.ideavimrc
mkdir -p ~/.ideavimrc_extra
ln -s $(pwd)/extra/toggle_camelcase_motion.vim ~/.ideavimrc_extra/toggle_camelcase_motion.vim
