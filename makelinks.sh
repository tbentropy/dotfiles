#!/bin/sh

# Run this file from the "dotfiles" directory

cwd=$(pwd)

ln -sf ${cwd}/.vimrc ~/.vimrc
ln -sf ${cwd}/.tmux.conf ~/.tmux.conf
ln -sf ${cwd}/.bashrc ~/.bashrc
ln -sf ${cwd}/.profile ~/.profile
