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
export PATH

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc

export JAVA_HOME="$(ls /lib/jvm | grep java-11-openjdk.)"
export DOT_PATH=$HOME/.dotfiles/bin
export RUSTUP_HOME=$HOME/.config/rust/.rustup
export CARGO_HOME=$HOME/.config/rust/.cargo
export GOROOT=$HOME/.config/go
export GOPATH=$HOME/.config/go/pkg
export PATH="/sbin:$JAVA_HOME:$GOROOT/bin:$DOT_PATH::$PATH;$RUSTUP_HOME;$CARGO_HOME"

# ssh configuration
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
find ~/.ssh/ | grep \.pub | sed "s/.pub//" | xargs ssh-add > /dev/null 2>&1

# Generate the neovim directory for the color changes
mkdir /tmp/nvim  2>/dev/null
alias nvim="nvim --listen /tmp/nvim/\$((\`ls /tmp/nvim | tail -n 1\`+1))"
export EDITOR=nvim
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export TODO_DB_PATH=$HOME/.config/shared/todo.json
export LESSHISTFILE=$HOME/.config/.lesshst
export HISTFILE=$HOME/.config/history
export TERMINAL=/bin/alacritty
export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
export PLATFORMIO_CORE_DIR="$XDG_CONFIG_HOME"/platformio
export CUDA_CACHE_PATH="$XDG_CACHE_HOME"/nv


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
alias sl=ls
alias v=vim
alias n=nvim
alias nivm=nvim
alias cs=colorscheme

alias ds='ollama run deepseek-r1:8b'
alias dsps='ollama ps'
dskill() {
    for i in `ollama ps | awk '{print $1}'`; do
        [ "$i" = "NAME" ] || ollama stop $i;
    done
}

__fzf_alias() {
    cd $(find $1 -maxdepth $2  -type d -not -path '*/[@.]*' | fzf -i -x)
}
for i in `ls $HOME/src/`; do
    alias $i="__fzf_alias $HOME/src/$i 2; tmux"
done
alias lect="__fzf_alias $HOME/Lectures/ 4; tmux"

# ┌──────────────────────┐
# │       Setup PS1      │
# └──────────────────────┘
__gitbranch() {
    local branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null) || return
    [[ -z $branch ]] && return
    [[ $branch == HEAD ]] && branch=detached
    printf '(%s)' "$branch"
}
export PS1="\[\e[1m\]\W\[\e[;0m\]\[\e[2;36;3m\]\$(__gitbranch)\[\e[;0m\]\[\e[2;33;1m\] $\[\e[;0m\] "
td --nerd
. "$CARGO_HOME/env"
