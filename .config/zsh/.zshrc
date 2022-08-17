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
export ZSH="${XDG_CONFIG_HOME:-$HOME/.config}/ohmyzsh"

ZSH_THEME="0undefined"
ZSH_CUSTOM="${XDG_CONFIG_HOME:-$HOME/.config}/zsh/custom"

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line if pasting URLs and other text is messed up.
DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

HIST_STAMPS="yyyy-mm-dd"

plugins=()

source $ZSH/oh-my-zsh.sh

# Behaviour
setopt nonomatch
setopt interactivecomments

# History
HISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}/histfile"
HISTSIZE=32768
SAVEHIST=32768
setopt hist_ignore_all_dups
setopt hist_reduce_blanks
setopt no_share_history
setopt no_histverify

# Cache location
autoload -Uz compinit
compinit -d ~/.cache/zcompdump-$ZSH_VERSION

# Bindings
export KEYTIMEOUT=1
set -o vi
bindkey -v

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

bindkey -a "^e" vi-end-of-line
bindkey "^a" beginning-of-line
bindkey "^r" history-incremental-search-backward

bindkey "${terminfo[khome]}" beginning-of-line
bindkey "${terminfo[kend]}"  end-of-line
bindkey "^[[3~"              delete-char
bindkey "^[3;5~"             delete-char
bindkey "^[[1;5C"            forward-word
bindkey "^[[1;5D"            backward-word

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N      up-line-or-beginning-search
zle -N      down-line-or-beginning-search
bindkey "^[A"  up-line-or-beginning-search
bindkey "^[OA" up-line-or-beginning-search
bindkey "^[B"  down-line-or-beginning-search
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

function screengrab() {
  local OUT=screengrab.gif
  local SIZE=$1
  local POS=$2
  ffmpeg -f x11grab -r 20 -s ${SIZE} -i :0.0+${POS} -r 20 out.gif
}

function timeuntil() {
  if ! [[ "${1}" =~ "[0-9]{4}-[0-9]{1,2}-[0-9]{1,2} [0-9]{2}:[0-9]{2}" ]]; then
    echo "argument must be of the form \"YYYY-DD-MM hh:mm\""
  else
    date -u -d @$(($(date -d "${1}" +%s) - $(date +%s) - 24 * 60 * 60)) '+[%d %H:%M:%S]'
  fi
}

fr () {
  which futhark > /dev/null
  if [ ! -z $? ]; then
    activate futhark
  fi
  futhark repl
}

function get_dhcp_replies () {
  if [ $# -eq 0 ]; then
    doas tcpdump -i enp0s31f6 -n -e port 68 |& sed -Ee "/Reply/!d"
  else
    doas tcpdump -i enp0s31f6 -n -e port 68 |& sed -Ee "/Reply/!d;/${1}/d"
  fi
}

## Aliases
alias c=$'cd $(tree -dnfqi --noreport | sed -Ee "s/^\\.\\///g" | fzf)'
alias diff='diff --color=auto'
alias dmesg='dmesg --color=auto'
alias fsharpc='fsharpc --nologo --standalone'
alias fsharpi='fsharpi --nologo'
alias gdb='gdb -q -x ${XDG_CONFIG_HOME:-$HOME/.config}/gdbinit'
alias glog2="git log --graph --abbrev-commit --decorate --format=format:'%Cgreen%h%C(reset) [%G?] %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%Cred%d%C(reset)' --all"
alias glog='git log --pretty="%Cgreen%H%Creset [%G?] %cn: %s %Cred%d%Creset"'
alias irssi="irssi --home=${XDG_DATA_HOME:-$HOME/.config/irssi}"
alias ip='ip -c'
alias ls='lsd'
alias l='[ $(( $(tput cols) )) -lt 80 ] && ls -Ah || ls -lAh'
alias mutt='neomutt'
alias mv='mv -i'
alias pbcopy='xclip -selection clipboard -i'
alias pbpaste='xclip -selection clipboard -o'
alias s='vim $(fzf)'
alias scan='nmcli d wifi rescan'
alias screen='TERM=st-256color screen -T screen-256color -s zsh'
alias sudo='doas'
alias v='vim --servername vim'
alias ptop="ps -o pid,user,size,pcpu,command --sort size cx"
alias vbox='virtualbox'

# Make sure that nobody makes some silly mistake
alias nano='vim'
alias emacs='vim'

## Do before dropping into shell
BANNERFILE=~/.config/texts/todo.md

printwithcolors() {
  # Formatting
  local title='s/^(#+.*)/\\e[1;92m\1\\e[0m/g'
  local bold='s/\*(.*)\*/\\e[1m\1\\e[0m/g'
  local italics='s/_(.*)_/\\e[3m\1\\e[0m/g'
  local strikeout='s/~~(.*)~~/\\e[9m\1\\e[0m/g'

  # Colors
  local onion='s/(﨩)/\\e[35m\1\\e[0m/g'
  local progress='s/\[([0-9]+)\/([0-9]+)\]/\\e[33m[\1\/\2]\\e[0m/g'
  local comment='s/ *\((.*)\)/  \\e[90m\1\\e[0m/g'
  local git='s/([Gg]it[a-zA-Z]*)/\\e[38;5;222m\1\\e[0m/g'
  local points='s/^( *)(\*|\+|\-)/\1\\e[34m\2\\e[0m/g'

  local rarrow='s/->/→/g;s/=>/⇒/g'
  local larrow='s/<-/←/g;s/<=/⇐/g'
  local arrows="$rarrow;$larrow"

  echo -e "$(sed -Ee "$title;$bold;$italics;$strikeout;$onion;$progress;$comment;$git;$points;$arrows" $1)"
}

if [[ $(tput cols) -gt 140 ]]; then
  [ "$TERM" =~ .*256.* ] && [ -e "${BANNERFILE}" ] && printwithcolors $BANNERFILE
fi

# Use screen if in a ssh session
[ -n "$SSH_CLIENT" ] && ! [[ "$TERM" =~ ^screen.*$ ]] && screen -R && exit 0

true
