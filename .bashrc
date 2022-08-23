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
GRADLE_PATH=/usr/local/gradle/bin
DOTFILES_PATH=$HOME/.dotfiles/bin
export PATH="$GRADLE_PATH:$JAVA_HOME:$GOPATH/bin:$GOROOT/bin:$DOTFILES_PATH:$PATH"
export EDITOR=/usr/bin/nvim

# ┌──────────────────────┐
# │ Directory Management │
# └──────────────────────┘

export GRADLE_USER_HOME=~/.config/gradle
export GTK2_RC_FILES=~/.dotfiles/gtk/.gtkrc-2.0
export XCURSOR_PATH=/usr/share/icons:~/.local/share/icons
export LESSHISTFILE=~/.config/.lesshst
export NODE_REPL_HISTORY=~/.config/.node_repl_history
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot=~/.config/java
alias wget=wget --hsts-file="~/.config/.wget-hsts"


# sudo alternatives --config java

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
	for rc in ~/.bashrc.d/*; do
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
alias nivm=nvim
alias n=nvim
alias v=vim
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
