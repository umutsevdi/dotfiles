# Set up the prompt

GOPATH=$HOME/go/bin
GOROOT=/lib/go/bin
JAVA_HOME=/lib/jvm/java-11-openjdk-11.0.14.0.9-2.fc35.x86_64
DOTFILES_PATH="$HOME/.dotfiles/bin"
PATH="$JAVA_HOME$GOPATH:$GOROOT:$DOTFILES_PATH:$PATH"

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias la='ls -A'
alias ..='cd ..'
alias gs='git status'
alias mv='mv -i'
alias rm='rm -i'
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

autoload -Uz promptinit
promptinit
prompt adam1

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


t_value="\[\e[1;34m\t\e[01;37m\]"
u_type=$(if [[ "$(whoami)" == "root" ]]; then echo /; else echo $; fi; )
u_value="\e[1;33m$u_type\e[01;37m"
l_value="\[\e[03;31m\]\W\[\e[03;37m\]"
PS1="\[\e[01m$t_value $u_value $l_value → \[\e[0m\]"
# launch
echo -e "\e[01m$(whoami)@$(hostname)\e[0;33m 🔸 \e[01;36m$(date +%a' '%d' '%b' '%Y)"
$HOME/.dotfiles/bin/pots
