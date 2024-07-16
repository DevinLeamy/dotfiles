#!/bin/bash

# Fail on any error.
#set -e

REPO="/Users/Devin/Desktop/Github/DevinLeamy/dotfiles"
HOME="/Users/Devin"

HAMMERSPOON="$HOME/.hammerspoon"
SKETCHYBAR="$HOME/.config/sketchybar"
FISH="$HOME/.config/fish"
NVIM="$HOME/.config/nvim"
TMUX="$HOME/.tmux.conf"
ALACRITTY="$HOME/.config/alacritty"
KITTY="$HOME/.config/kitty"

HAMMERSPOON_SYM="$REPO/.hammerspoon"
SKETCHYBAR_SYM="$REPO/sketchybar"
NVIM_SYM="$REPO/nvim"
FISH_SYM="$REPO/fish"
TMUX_SYM="$REPO/.tmux.conf"
ALACRITTY_SYM="$REPO/alacritty"
KITTY_SYM="$REPO/kitty"

# Remove the symlinks.
unlink $HAMMERSPOON_SYM
unlink $SKETCHYBAR_SYM
unlink $NVIM_SYM
unlink $FISH_SYM
unlink $TMUX_SYM
unlink $ALACRITTY_SYM
unlink $KITTY_SYM

# Copy the real directory contents.
cp -r $HAMMERSPOON $HAMMERSPOON_SYM
cp -r $SKETCHYBAR $SKETCHYBAR_SYM
cp -r $NVIM $NVIM_SYM
cp -r $FISH $FISH_SYM
cp -r $TMUX $TMUX_SYM
cp -r $ALACRITTY $ALACRITTY_SYM
cp -r $KITTY $KITTY_SYM

# Commit.
git add .
git commit -m "Update dotfiles"
git push origin main

# Remove the directory contents.
rm -rf $HAMMERSPOON_SYM
rm -rf $SKETCHYBAR_SYM
rm -rf $NVIM_SYM
rm -rf $FISH_SYM
rm -rf $TMUX_SYM
rm -rf $ALACRITTY_SYM
rm -rf $KITTY_SYM

# Restore the symlinks.
ln -s $HAMMERSPOON $HAMMERSPOON_SYM
ln -s $SKETCHYBAR $SKETCHYBAR_SYM
ln -s $NVIM $NVIM_SYM
ln -s $FISH $FISH_SYM
ln -s $TMUX $TMUX_SYM
ln -s $ALACRITTY $ALACRITTY_SYM
ln -s $KITTY $KITTY_SYM
