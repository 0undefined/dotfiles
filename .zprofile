#!/usr/bin/env zsh

# Configuration
export PATH=$PATH:$HOME/.local/bin

export BROWSER="firefox-developer-edition"
export EDITOR="vim"
export PAGER="less"
export READER="zathura"
export TERMINAL="st"
export VISUAL="vim"

# XDG~
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"

# X11-stuff
export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"
export XDEFAULTS="$HOME/.config/x/defaults"
export XINITRC="${XDG_CONFIG_HOME:-$HOME/.config}/xinitrc"
export XRESOURCES="$HOME/.config/x/resources"

# More utils / Preferences
export GNUPGHOME="${XDG_CONFIG_HOME:-$HOME/.config}/gnupg"
export INPUTRC="${XDG_CONFIG_HOME:-$HOME/.config}/inputrc"
export LESS=-F -R
export LESSHISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}/lesshist"
export MANWIDTH=${MANWIDTH:-80}
export PASSWORD_STORE_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/passwordstore"
# Vim stuffs
export MYVIMRC="${XDG_CONFIG_HOME:-$HOME/.config}/vim/vimrc"
export VIMINIT="source $MYVIMRC"

# Zsh stuffs
export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
export ZSH_COMPDUMP=$XDG_CACHE_HOME/zcompdump-$ZSH_VERSION

#
# Developer thingies
#

# Self explanatory
export GOPATH="${XDG_DATA_HOME:-$HOME/.local/share}/go"
export IPYTHONDIR="${XDG_CACHE_HOME:-$HOME/.cache}/ipython"

# Ruby
export GEM_PATH="${XDG_CACHE_HOME:-$HOME/.cache}/gem"

# Rust
export CARGO_HOME="${XDG_CACHE_HOME:-$HOME/.cache}/cargo"
export RUSTUP_HOME="${XDG_CACHE_HOME:-$HOME/.cache}/rustup"

[ "$(tty)" = "/dev/tty1" ] && ! pidof Xorg >/dev/null 2>&1 && exec startx
