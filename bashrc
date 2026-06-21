# .bashrc
#******************************************************************************
#
# * File: .dotfiles/.bashrc
#
# * Author:  Umut Sevdi
# * Created: 03/31/22
# * Description: .bashrc configuration
#*****************************************************************************

if [ -f /etc/bashrc ]; then . /etc/bashrc; fi
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc

export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java
export JAVA_HOME="$(ls /lib/jvm | grep java-21-openjdk.)"
export DOT_PATH=$HOME/Source/dev/dotfiles/
export RUSTUP_HOME=$HOME/.config/rust/.rustup
export CARGO_HOME=$HOME/.config/rust/.cargo
export ANDROID_HOME=$HOME/.config/android
export GOROOT=$HOME/.config/go
export GOPATH=$HOME/.config/go/pkg
export PATH="/sbin:${JAVA_HOME}:${GOROOT}/bin:${DOT_PATH}/bin:${PATH}:${RUSTUP_HOME}:${CARGO_HOME}"

# ssh configuration
if ! ssh-add -l >/dev/null 2>&1; then
    eval "$(ssh-agent -s)" >/dev/null
    find ~/.ssh/ | grep \.pub | sed "s/.pub//" | xargs ssh-add > /dev/null 2>&1
fi

mkdir /tmp/nvim  2>/dev/null
alias nvim="nvim --listen /tmp/nvim/\$((\`ls /tmp/nvim | tail -n 1\`+1))"
export CUDA_CACHE_PATH="$XDG_CACHE_HOME"/nv
export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker
export EDITOR=nvim
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
export HISTFILE=$HOME/.config/history
export LESSHISTFILE=$HOME/.config/.lesshst
export TERMINAL=/bin/alacritty
export XDG_CACHE_HOME=$HOME/.cache
export XDG_CONFIG_HOME=$HOME/.config
FZF_DEFAULT_COMMAND="find -L"
alias ..='cd ..'
alias cs=colorscheme
alias dotpath="cd $DOT_PATH"
alias gh='git show --stat --summary'
alias gl='git log --all --decorate --oneline --graph'
alias grep='grep --color=auto'
alias gs='git status'
alias la='ls -A'
alias ls='ls --color=auto'
alias mv='mv -i'
alias n=nvim
alias open=xdg-open
alias rm='rm -i'
alias sl=ls
alias v=vim

ff () {
  local file
  file=$(fzf) && cd "$(dirname "$file")" && nvim "$(basename "$file")"
}
__fzf_alias() {
    cd $(find $1 -maxdepth $2  -type d -not -path '*/[@.]*' | fzf -i -x)
}
for i in `ls $HOME/Source/`; do
    alias $i="__fzf_alias $HOME/Source/$i 2; tmux"
done
unset i
alias lect="__fzf_alias $HOME/Documents/Lectures/ 4; tmux"

__gitbranch() {
    local branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null) || return
    [[ -z $branch ]] && return
    [[ $branch == HEAD ]] && branch=detached
    printf '(%s)' "$branch"
}
export PS1="\[\e[1m\]\W\[\e[;0m\]\[\e[2;36;3m\]\$(__gitbranch)\[\e[;0m\]\[\e[2;33;1m\] $\[\e[;0m\] "
. "$CARGO_HOME/env"
echo -e "\e[2;32;1m$(date "+%a %d/%m/%y %I:%M%p")\e[;0m │ \e[2;37;2m$(uname -norm)\e[;0m\n"
