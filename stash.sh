#!/bin/bash

# Fail on any error.
set -e

REPO="/Users/Devin/Desktop/Github/DevinLeamy/dotfiles"
HOME="/Users/Devin"

HAMMERSPOON="$HOME/.hammerspoon"
SKETCHYBAR="$HOME/.config/sketchybar"
FISH="$HOME/.config/fish"
NVIM="$HOME/.config/nvim"
ZSH="$HOME/.zshrc"
TMUX="$HOME/.tmux.conf"
ALACRITTY="$HOME/.config/alacritty"

HAMMERSPOON_SYM="$REPO/.hammerspoon"
SKETCHYBAR_SYM="$REPO/sketchybar"
NVIM_SYM="$REPO/nvim"
FISH_SYM="$REPO/fish"
ZSH_SYM="$REPO/.zshrc"
TMUX_SYM="$REPO/.tmux.conf"
ALACRITTY_SYM="$REPO/alacritty"

# Remove the symlinks.
unlink $HAMMERSPOON_SYM
unlink $SKETCHYBAR_SYM
unlink $NVIM_SYM
unlink $FISH_SYM
unlink $ZSH_SYM
unlink $TMUX_SYM
unlink $ALACRITTY_SYM

# Copy the real directory contents.
cp -r $HAMMERSPOON $HAMMERSPOON_SYM
cp -r $SKETCHYBAR $SKETCHYBAR_SYM
cp -r $NVIM $NVIM_SYM
cp -r $FISH $FISH_SYM
cp -r $ZSH $ZSH_SYM
cp -r $TMUX $TMUX_SYM
cp -r $ALACRITTY $ALACRITTY_SYM

# Commit.
git add .
git commit -m "Update dotfiles"
git push origin main

# Remove the directory contents.
rm -rf $HAMMERSPOON_SYM
rm -rf $SKETCHYBAR_SYM
rm -rf $NVIM_SYM
rm -rf $FISH_SYM
rm -rf $ZSH_SYM
rm -rf $TMUX_SYM
rm -rf $ALACRITTY_SYM

# Restore the symlinks.
ln -s $HAMMERSPOON $HAMMERSPOON_SYM
ln -s $SKETCHYBAR $SKETCHYBAR_SYM
ln -s $NVIM $NVIM_SYM
ln -s $FISH $FISH_SYM
ln -s $ZSH $ZSH_SYM
ln -s $TMUX $TMUX_SYM
ln -s $ALACRITTY $ALACRITTY_SYM
