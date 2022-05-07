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

GOPATH=$HOME/go/bin
GOROOT=/lib/go/bin
JAVA_HOME=/lib/jvm/java-11-openjdk-11.0.14.0.9-2.fc35.x86_64
DOTFILES_PATH="$HOME/.dotfiles/bin"
PATH="$JAVA_HOME$GOPATH:$GOROOT:$DOTFILES_PATH:$PATH"
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
alias kitcat='kitty +kitten icat'
# ps
#PS1='[\u@\h \W]\$ '
t_value="\[\e[1;34m\t\e[01;37m\]"
u_type=$(if [[ "$(whoami)" == "root" ]]; then echo /; else echo $; fi; )
u_value="\e[1;31m$u_type\e[01;37m"
l_value="\[\e[03;33m\]\W\[\e[03;37m\]"
PS1="\[\e[01m$t_value $u_value $l_value → \[\e[0m\]"
# launch
echo -e "\e[01m$(whoami)@$(hostname)\e[0;34m 🔸 \e[01;36m$(date +%a' '%d' '%b' '%Y)"
$HOME/.dotfiles/bin/pots
