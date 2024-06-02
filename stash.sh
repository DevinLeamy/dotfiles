#!/bin/bash

# Fail on any error.
# set -e

HOME="/Users/Devin"

HAMMERSPOON="$HOME/.hammerspoon"
SKETCHYBAR="$HOME/.config/sketchybar"
NVIM="$HOME/.config/nvim"
ZSH="$HOME/.zshrc"
TMUX="$HOME/.tmux.conf"

HAMMERSPOON_SYM="$(pwd)/.hammerspoon"
SKETCHYBAR_SYM="$(pwd)/sketchybar"
NVIM_SYM="$(pwd)/nvim"
ZSH_SYM="$(pwd)/.zshrc"
TMUX_SYM="$(pwd)/.tmux.conf"

# Remove the symlinks.
unlink $HAMMERSPOON_SYM
unlink $SKETCHYBAR_SYM
unlink $NVIM_SYM
unlink $ZSH_SYM
unlink $TMUX_SYM

# Copy the real directory contents.
cp -r $HAMMERSPOON $HAMMERSPOON_SYM
cp -r $SKETCHYBAR $SKETCHYBAR_SYM
cp -r $NVIM $NVIM_SYM
cp -r $ZSH $ZSH_SYM
cp -r $TMUX $TMUX_SYM

# Commit.
git add .
git commit -m "Update dotfiles"
git push origin main

# Remove the directory contents.
rm -rf $HAMMERSPOON_SYM
rm -rf $SKETCHYBAR_SYM
rm -rf $NVIM_SYM
rm -rf $ZSH_SYM
rm -rf $TMUX_SYM

# Restore the symlinks.
ln -s $HAMMERSPOON $HAMMERSPOON_SYM
ln -s $SKETCHYBAR $SKETCHYBAR_SYM
ln -s $NVIM $NVIM_SYM
ln -s $ZSH $ZSH_SYM
ln -s $TMUX $TMUX_SYM

