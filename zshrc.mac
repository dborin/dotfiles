# Path to your oh-my-zsh installation.
export ZSH=/Users/davidborin/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="dborin-bira"

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# User configuration

export PATH="$HOME/bin:/Users/davidborin/.rbenv/shims:/Users/davidborin/.rbenv/bin:/Users/davidborin/.python_virtualenvs/primary/bin:/usr/local/bin:/usr/local/git/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:/usr/X11/bin:./:../:../../:../../../"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

if [[ "$TERM" != "screen" ]] &&
        [[ "$SSH_CONNECTION" == "" ]]; then
    # Attempt to discover a detached session and attach
    # it, else create a new session

    WHOAMI=$(whoami)
    if tmux has-session -t $WHOAMI 2>/dev/null; then
        tmux attach-session -t $WHOAMI
    else
        tmux new-session -s $WHOAMI
    fi
fi

CURRENT_VIRTUALENV="primary"
export EDITOR=vim
stty erase '^?'

unalias ll 2>/dev/null

export HISTSIZE=50000
export HISTCONTROL=erasedups
export GREP_COLOR='1;37;46'

alias 1='fg %1'
alias 2='fg %2'
alias 3='fg %3'
alias 4='fg %4'
alias quit='exit'
alias bye='exit'
alias adios='exit'
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ls='ls -A'
alias ll='ls -lhA'
alias lf='ls -AF'
alias lt='ls -lArth'
alias ld='ls -dA'
alias h='history'
alias Cat='echo;cat'
alias env='env|sort'
alias gga='git log --graph --pretty=format:"%C(bold yellow)%h %Creset%C(cyan)(%cr)%Creset %C(bold red)%d%Creset%C(white) %s %Creset%C(green)[%cn]"'
alias gg='gga -n `expr $LINES / 2`'
alias ggs='gga --stat'
alias takeover="tmux detach -a"

export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python
export WORKON_HOME=$HOME/.python_virtualenvs
source /usr/local/bin/virtualenvwrapper.sh
export PIP_VIRTUALENV_BASE=$WORKON_HOME
export PIP_RESPECT_VIRTUALENV=true

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

export INTERACTIVE_SHELL=1
export LS_OPTIONS='--color=auto'
#export TERM="xterm-color"
export TERM=xterm-256color
export CLICOLOR=1
export LSCOLORS="Gxagexbxcxegedabacafad"

# No ttyctl, so we need to save and then restore terminal settings
vim()
{
#    local STTYOPTS="$(stty --save)"
    stty stop '' -ixoff
    command vim "$@"
#    stty "$STTYOPTS"
}
vi()
{
#    local STTYOPTS="$(stty --save)"
    stty stop '' -ixoff
    command vim "$@"
#    stty "$STTYOPTS"
}

has_virtualenv() {
    if [ -e .venv ]; then
        workon `cat .venv`
    fi
}
venv_cd () {
    cd "$@" && has_virtualenv
}

alias cd="venv_cd"

function goback {
    cd $OLDPWD
}
function hf {
    grep -n "$@" ~/.zsh_history | more
}
function vt {
    mvim --remote-tab $@ > /dev/null 2>&1
}
function mou {
    open -a Mou $@
}
function slow {
    top -o cpu
}
function chars {
    count=`echo $@ | wc -c`
    echo $(( $count-1 ))
}
function klone {
    git clone git@github.com:$@
}
function lsklone {
    git clone git@code.livingsocial.net:$@
}
function bootnova {
    nova boot --key-name dborin-nova_id_rsa --availability-zone=qateam $@
}
function r {
   fc -e - $@
}
function pu {
    pushd $@
}
function po {
    popd $@
}
function psg {
    /bin/ps -ea | egrep -i $1 | grep -v grep
}
function Find {
    /usr/bin/find . -name "*$1***" -a -print 2>/dev/null
}
function mancat {
    tbl $1:1 | neqn | nroff -man | col -b
}
function dfk {
    df -k $1
}

# Automatically load the current Python virtualenv

python_autoenv () {
  workon $CURRENT_VIRTUALENV
}

python_autoenv
