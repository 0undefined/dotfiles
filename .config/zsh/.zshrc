# zshrc

export GPG_TTY=$(tty)

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Add [username@hostname] prefix to prompt when its ssh
if [ "$TERM" = "linux" ]; then
  PROMPT='%(?..(%?%) )'
  [ -n "$SSH_CLIENT" ] && PROMPT+="[%n@%M] "
  PROMPT+='%c %(!.#.$) '
  return
fi

# Path to your oh-my-zsh installation.
export ZSH="${XDG_CONFIG_HOME:-$HOME/.config}/oh-my-zsh"

ZSH_THEME="0undefined"
ZSH_CUSTOM="${XDG_CONFIG_HOME:-$HOME/.config}/zsh/custom"

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
DISABLE_UPDATE_PROMPT="false"

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=31

# Uncomment the following line if pasting URLs and other text is messed up.
DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

#plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

export MANWIDTH=${MANWIDTH:-80}
man() {
    LESS_TERMCAP_md=$'\e[01;38;5;147m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[48;5;235;01;38;5;250m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[38;5;104m' \
    command man "$@"
}

setopt nonomatch
setopt interactivecomments

HISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}/histfile"
HISTSIZE=32768
SAVEHIST=32768
setopt hist_ignore_all_dups
setopt hist_reduce_blanks
setopt no_share_history
setopt no_histverify


autoload -Uz compinit
compinit -d ~/.cache/zcompdump-$ZSH_VERSION
autoload -Uz promptinit
promptinit

zstyle ':completion:*' menu select
zmodload zsh/complist

bindkey -v
export KEYTIMEOUT=1
set -o vi

function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] || [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] || [[ ${KEYMAP} == viins ]] || [[ ${KEYMAP} = '' ]] || [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select

# zle-line-init() {
#   # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
#   zle -K viins
#   echo -ne "\e[5 q"
# }
#zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
# preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd ' ' edit-command-line

bindkey -v '^?' backward-delete-char

bindkey "^e" end-of-line
bindkey "^a" beginning-of-line
bindkey -M vicmd "^e" end-of-line
bindkey -M vicmd "^a" beginning-of-line
bindkey "" beginning-of-line
bindkey "" end-of-line

bindkey "${terminfo[khome]}" beginning-of-line
bindkey "${terminfo[kend]}"  end-of-line
bindkey "^[[3~"              delete-char
bindkey "^[3;5~"             delete-char
bindkey "^[[P"               delete-char
bindkey "^[[1;5C"            forward-word
bindkey "^[[1;5D"            backward-word

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N      up-line-or-beginning-search
zle -N      down-line-or-beginning-search
bindkey "^[A" up-line-or-beginning-search
bindkey "^[B" down-line-or-beginning-search
bindkey "^[OA" up-line-or-beginning-search
bindkey "^[OB" down-line-or-beginning-search

## Handy functions
upload () {
  curl -F file=@${1} http://0x0.st
}

activate () {
  if [[ $1 == "" ]]; then
    ls --color=no -A ~/.env
  else
    source ~/.env/$1/bin/activate
  fi
}

goto() {
    cd ~/gits/personal/Documents/$1
}

stopwatch() {
    clear
    date1=`date +%s`;
    while true; do
        echo -ne "\r$(date -u --date @$((`date +%s` - $date1)) +%H:%M:%S)";
        sleep 0.1
    done
}

fs () {
  if [[ $1 == "" ]]; then
      printf ']710;%s' "xft:DejaVuSansMono Nerd Font Mono:pixelsize=14"
  else
      printf ']710;%s' "xft:DejaVuSansMono Nerd Font Mono:pixelsize=${1}"
  fi
}

calcgrade () {
    if [ -z $1 ]; then
        echo "Please submit an argument"
    fi
    D=$(find .  -maxdepth 3 -name $1\* -type d)
    if [ -z $D ]; then
        echo $1 "not found"
    else
        ls $D/guidelines.mrk
        echo $( \
            grep -oE "([0-9]+(\.[0-9]+)?)/[0-9]+" $D/guidelines.mrk \
                | sed -Ee 's/^([0-9]+(\.[0-9]+)?)\/.*/\1/g'         \
                | tr '\n' '+'                                       \
                | sed -Ee 's/^(.*)\+$/\1/g' -e 's/\+/ + /g')        \
            | bc
    fi
}

function screengrab() {
  local OUT=screengrab.gif
  local SIZE=$1
  local POS=$2
  ffmpeg -f x11grab -r 20 -s ${SIZE} -i :0.0+${POS} -r 20 out.gif
}

fr () {
  which futhark > /dev/null
  if [ ! -z $? ]; then
    activate futhark
  fi
  futhark repl
}

## Aliases
alias :q='exit'
alias gdb='gdb -q'
alias glog2="git log --graph --abbrev-commit --decorate --format=format:'%Cgreen%h%C(reset) [%G?] %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%Cred%d%C(reset)' --all"
alias glog='git log --pretty="%Cgreen%H%Creset [%G?] %cn: %s %Cred%d%Creset"'
alias ls='ls --color=auto'
alias mutt='neomutt'
alias pbcopy='xclip -selection clipboard -i'
alias pbpaste='xclip -selection clipboard -o'
alias push='git push && mpgv ~/downloads/mario_power_up.mp3'
alias s='vim $(fzf)'
alias scan='sudo iwlist wlp3s0 scan > /dev/null'
alias v='echo -ne "\e[1 q" && vim --servername vim'
alias ptop="ps -o pid,user,size,pcpu,command --sort size cx"

## Do before dropping into shell
BANNERFILE=~/.config/texts/todo.md

if [[ $(tput cols) -gt 140 ]]; then
  pr -mtW 140 $BANNERFILE ~/.config/texts/setsail
else
  cat $BANNERFILE
fi
