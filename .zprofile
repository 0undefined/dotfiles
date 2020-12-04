#!/usr/bin/env zsh

# Configuration
export PATH=$PATH:$HOME/.scripts

export EDITOR="vim"
export VISUAL="vim"
export TERMINAL="st"
export BROWSER="firefox-developer-edition"
export READER="zathura"
export PAGER="less"

# XDG~
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"
export XDEFAULTS="$HOME/.config/x/defaults"
export XRESOURCES="$HOME/.config/x/resources"
export XINITRC="${XDG_CONFIG_HOME:-$HOME/.config}/xinitrc"

export IPYTHONDIR="${XDG_CACHE_HOME:-$HOME/.cache}/ipython"
export LESSHISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}/lesshist"
export INPUTRC="${XDG_CONFIG_HOME:-$HOME/.config}/inputrc"
export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
export ZSH_COMPDUMP=$XDG_CACHE_HOME/zcompdump-$ZSH_VERSION
export ANDROID_SDK_HOME="${XDG_CONFIG_HOME:-$HOME/.config}/android"
export CARGO_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/cargo"
export GOPATH="${XDG_DATA_HOME:-$HOME/.local/share}/go"
export AWS_CONFIG_FILE="${XDG_CONFIG_HOME:-$HOME/.config}/aws/config"
export AWS_SHARED_CREDENTIALS_FILE="${XDG_CONFIG_HOME:-$HOME/.config}/aws/credentials"
export GNUPGHOME="${XDG_CONFIG_HOME:-$HOME/.config}/gnupg"

export GEM_PATH="${XDG_CACHE_HOME:-$HOME/.cache}/gem"
export RUSTUP_HOME="${XDG_CACHE_HOME:-$HOME/.cache}/rustup"
export CARGO_HOME="${XDG_CACHE_HOME:-$HOME/.cache}/cargo"
export KUBECONFIG="${XDG_CACHE_HOME:-$HOME/.cache}/kube/config"

export VIMINIT="source ${XDG_CONFIG_HOME:-$HOME/.config}/vim/vimrc"

# Preferences
export LESS=-R
export MANWIDTH=${MANWIDTH:-80}

alias irssi="irssi --home=${XDG_DATA_HOME:-$HOME/.config/irssi}"

[ "$(tty)" = "/dev/tty1" ] && ! pidof Xorg >/dev/null 2>&1 && exec startx
