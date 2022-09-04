# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi
# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# ┌──────────────────────┐
# │   Path  Management   │
# └──────────────────────┘

GOPATH=$HOME/go
GOROOT=/lib/go
JAVA_HOME="$(ls /lib/jvm | grep java-11-openjdk.)"
GRDL_PATH=/usr/local/gradle/bin
DOT_PATH=$HOME/.dotfiles/bin
JBT_PATH=$HOME/.local/share/JetBrains/Toolbox/scripts
APLT_PATH=/home/umutsevdi/src/linux/rofi-applets
export PATH="$GRDL_PATH:$JAVA_HOME:$GOPATH/bin:$GOROOT/bin:$DOT_PATH:$JBT_PATH:$APLT_PATH:$PATH"
export EDITOR=/usr/bin/nvim
export ROFI_APPLETS_PATH=$APLT_PATH
# ┌──────────────────────┐
# │ Directory Management │
# └──────────────────────┘

export GRADLE_USER_HOME=$HOME/.config/gradle
export GTK2_RC_FILES=$HOME/.dotfiles/gtk/.gtkrc-2.0
export XCURSOR_PATH=/usr/share/icons:$HOME/.local/share/icons
export LESSHISTFILE=$HOME/.config/.lesshst
export NODE_REPL_HISTORY=$HOME/.config/.node_repl_history
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot=$HOME/.config/java
alias wget=wget --hsts-file="$HOME/.config/.wget-hsts"
export XDG_DATA_HOME=$HOME/.local/share/
export XDG_CONFIG_HOME=$HOME/.config/
export XDG_STATE_HOME=$HOME/.local/state
export XDG_CACHE_HOME=$HOME/.cache
export ANDROID_HOME=$HOME/.config/android
export HISTFILE=$HOME/.config/history

# sudo alternatives --config java

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d $HOME/.bashrc.d ]; then
	for rc in $HOME/.bashrc.d/*; do
		if [ -f "$rc" ]; then
			. "$rc"
		fi
	done
fi

unset rc
[[ $- != *i* ]] && return

[[ $- == *i* ]] && source "/home/umutsevdi/.fzf/shell/completion.bash" 2> /dev/null

# alias
FZF_DEFAULT_COMMAND="find -L"
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias la='ls -A'
alias ..='cd ..'
alias gs='git status'
alias mv='mv -i'
alias rm='rm -i'
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias ff='cd $(dirname $(fzf))'

# typo aliases
alias sl=ls
alias v=vi
alias n=nvim
alias nivm=nvim
alias nuvm=nvim
alias novm=nvim
alias nvm=nvim
alias vim=nvim
alias cs=colorscheme

# ps
#PS1='[\u@\h \W]\$ '
PS1="\e[34;1m\t \e[33;3m\W →\e[39;0m "
# launch
echo -e "\e[01m$(whoami)@$(hostname) - \e[36m$(date +%a' '%d' '%b' '%Y)\e[39;0m"
$HOME/.dotfiles/bin/pots
