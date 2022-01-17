#!/usr/bin/env zsh

# Configuration
export PATH=$PATH:$HOME/.local/bin

export BROWSER="firefox-developer-edition"
export EDITOR="vim"
export PAGER="less"
export READER="zathura"
export TERMINAL="st"
export TERM="$TERMINAL"
export VISUAL="vim"
export SHELL="zsh"

# XDG~
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_DESKTOP_DIR="$HOME"

# X11-stuff
export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"
export XDEFAULTS="$HOME/.config/x/defaults"
export XINITRC="${XDG_CONFIG_HOME:-$HOME/.config}/x/xinitrc"
export XRESOURCES="$HOME/.config/x/resources"

# More utils / Preferences
export GNUPGHOME="${XDG_CONFIG_HOME:-$HOME/.config}/gnupg"
export INPUTRC="${XDG_CONFIG_HOME:-$HOME/.config}/inputrc"
export LESS="-F -R"
export LESSHISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}/lesshist"
export MANWIDTH=${MANWIDTH:-80}
export PASSWORD_STORE_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/passwordstore"
export SCREENRC="${XDG_CONFIG_HOME:-$HOME/.config}/screenrc"
export BAT_THEME="fly16"
export FZF_DEFAULT_OPTS='
 --color=fg:#b2b2b2,bg:-1,hl:#8cc85f
 --color=fg+:#e4e4e4,bg+:-1,hl+:#85dc85
 --color=info:#323437,prompt:#36c692,pointer:#ae81ff
 --color=marker:#d183e8,spinner:#e3c78a,header:#ff5189'


# Vim stuffs
export MYVIMRC="${XDG_CONFIG_HOME:-$HOME/.config}/vim/vimrc"
export VIMINIT="source $MYVIMRC"

# Zsh stuffs
export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
export ZSH_COMPDUMP=$XDG_CACHE_HOME/zcompdump-$ZSH_VERSION

#
# Developer thingies
#
export ANDROID_SDK_HOME="${XDG_CONFIG_HOME:-$HOME/.config}/android"
export AWS_CONFIG_FILE="${XDG_CONFIG_HOME:-$HOME/.config}/aws/config"
export AWS_SHARED_CREDENTIALS_FILE="${XDG_CONFIG_HOME:-$HOME/.config}/aws/credentials"
export KUBECONFIG="${XDG_CACHE_HOME:-$HOME/.cache}/kube/config"

# Self explanatory
export GOPATH="${XDG_DATA_HOME:-$HOME/.local/share}/go"
export IPYTHONDIR="${XDG_CACHE_HOME:-$HOME/.cache}/ipython"

# Ruby
export GEM_PATH="${XDG_CACHE_HOME:-$HOME/.cache}/gem"

# Rust
export CARGO_HOME="${XDG_CACHE_HOME:-$HOME/.cache}/cargo"
export CARGO_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/cargo"
export RUSTUP_HOME="${XDG_CACHE_HOME:-$HOME/.cache}/rustup"

[ "$(tty)" = "/dev/tty1" ] && ! pidof Xorg >/dev/null 2>&1 && exec startx "$XINITRC"
