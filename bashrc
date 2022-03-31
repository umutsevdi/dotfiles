# .bashrc
#******************************************************************************
#
# * File: .dotfiles/.bashrc
#
# * Author:  Umut Sevdi
# * Created: 03/31/22
# * Description: .bashrc configuration
#*****************************************************************************

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export GOPATH=$HOME/.config/go
export JAVA_HOME="$(ls /lib/jvm | grep java-11-openjdk.)"
export DOT_PATH=$HOME/.dotfiles/bin
export LSP_PATH=$HOME/.local/share/nvim/mason/bin/
export PATH="/sbin:$JAVA_HOME:$GOPATH/bin:$GOROOT/bin:$DOT_PATH::$LSP_PATH:$PATH"

# ssh configuration
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
find ~/.ssh/ | grep \.pub | sed "s/.pub//" | xargs ssh-add > /dev/null 2>&1

# Generate the neovim directory for the color changes
mkdir /tmp/nvim  2>/dev/null
# aliases
alias nvim="nvim -u ~/.dotfiles/nvim/init.lua --listen /tmp/nvim/\$((\`ls /tmp/nvim | tail -n 1\`+1))"
export EDITOR=nvim
export TODO_DB_PATH=$HOME/.config/shared/todo.json
alias wget=wget --hsts-file="$HOME/.config/.wget-hsts"
export CHROME_EXECUTABLE=firefox
export QT_QPA_PLATFORMTHEME=gnome
export LESSHISTFILE=$HOME/.config/.lesshst
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
export XDG_DATA_HOME=$HOME/.local/share
export XDG_CONFIG_HOME=$HOME/.config
export XDG_STATE_HOME=$HOME/.local/state
export XDG_CACHE_HOME=$HOME/.cache
export XAUTHORITY="$XDG_CONFIG_HOME"/.Xauthority
export GRADLE_USER_HOME="$XDG_CONFIG_HOME/gradle"
export XCURSOR_PATH=/usr/share/icons:${XDG_DATA_HOME}/icons
export HISTFILE=$HOME/.config/history
export TERMINAL=/bin/alacritty
export QT_QPA_PLATFORMTHEME=gnome
export WINEPREFIX="$XDG_DATA_HOME"/wine

# ┌──────────────────────┐
# │       Aliases        │
# └──────────────────────┘

FZF_DEFAULT_COMMAND="find -L"
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias la='ls -A'
alias ..='cd ..'
alias gs='git status'
alias mv='mv -i'
alias rm='rm -i'
alias ff='x=$(fzf);cd $(dirname $x); nvim $(basename $x)'

alias tmux="tmux -f $HOME/.dotfiles/tmux.conf"
alias vim='vim -u $HOME/.dotfiles/vimrc'

# turns each folder under the src directory into a command that performs 
# fuzzy-find inside the directories
__fzf_alias() {
    cd $(find $1 -maxdepth 2  -type d -not -path '*/[@.]*' | fzf -i -x)
}

# Index directories under ~/src
for i in `ls $HOME/src/`; do
    alias $i="__fzf_alias $HOME/src/$i; tmux"
done

# Typo aliases
alias sl=ls
alias v=vim
alias n=nvim
alias nivm=nvim
alias cs=colorscheme
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

if [ "$XDG_SESSION_TYPE" == "wayland" ]; then
    # Wayland is enabled, export environment variables
    export GDK_BACKEND="wayland,x11"
    export WAYLAND_DISPLAY="wayland-0"
    export DISPLAY="wayland-0"
fi
# ┌──────────────────────┐
# │       Setup PS1      │
# └──────────────────────┘
ps_t="\[\e[34;1m\]\t"
ps_dir="\[\e[33;3m\]\W $"
ps_git="\[\e[;0m\]\[\e[33;3m\]\$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/')\[\e[39;0m\]"
export PS1="$ps_t $ps_dir$ps_git "
$HOME/.dotfiles/bin/pots

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
