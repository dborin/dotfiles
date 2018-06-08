export VIRTUAL_ENV_DISABLE_PROMPT=yes

function my_git_prompt() {
  tester=$(git rev-parse --git-dir 2> /dev/null) || return

  INDEX=$(git status --porcelain 2> /dev/null)
  STATUS=""

  # is branch ahead?
  if $(echo "$(git log origin/$(git_current_branch)..HEAD 2> /dev/null)" | grep '^commit' &> /dev/null); then
    STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_AHEAD"
  fi

  # is anything staged?
  if $(echo "$INDEX" | command grep -E -e '^(D[ M]|[MARC][ MD]) ' &> /dev/null); then
    STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_STAGED"
  fi

  # is anything unstaged?
  if $(echo "$INDEX" | command grep -E -e '^[ MARC][MD] ' &> /dev/null); then
    STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_UNSTAGED"
  fi

  # is anything untracked?
  if $(echo "$INDEX" | grep '^?? ' &> /dev/null); then
    STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_UNTRACKED"
  fi

  # is anything unmerged?
  if $(echo "$INDEX" | command grep -E -e '^(A[AU]|D[DU]|U[ADU]) ' &> /dev/null); then
    STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_UNMERGED"
  fi

  if [[ -n $STATUS ]]; then
    STATUS=" $STATUS"
  fi

  echo "$ZSH_THEME_GIT_PROMPT_PREFIX$(my_current_branch)$STATUS$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

function my_current_branch() {
  echo $(git_current_branch || echo "(no branch)")
}

local return_code="%(?..%{$fg[red]%}%? ↵ %{$reset_color%})"

local myhost="%{$terminfo[bold]$FG[034]%}@%m%{$reset_color%}"
local myuser="%{$terminfo[bold]$FG[220]%}%n%{$reset_color%}"
local current_dir="%{$terminfo[bold]$FG[014]%} %~%{$reset_color%}"
local current_time="%{$FG[009]%}%*%{$reset_color%}"
#local rvm_ruby=""
#if which rvm-prompt &> /dev/null; then
#  rvm_ruby="%{$terminfo[bold]$fg[red]%}‹$(rvm-prompt i v g)›%{$reset_color%}"
#else
#  if which rbenv &> /dev/null; then
#    rvm_ruby="%{$terminfo[bold]$fg[red]%}‹$(rbenv version | sed -e 's/ (set.*$//')›%{$reset_color%}"
#  fi
#fi
local git_branch="$(git_prompt_info)%{$reset_color%}"

#if [[ -z $VIRTUAL_ENV ]]; then
#    local venv=""
#else
#    local venv="%{$terminfo[bold]$fg[green]%}‹${VIRTUAL_ENV##*/}›%{$reset_color%}"
#fi
local venv="%{$terminfo[bold]$fg[green]%}‹${VIRTUAL_ENV##*/}›%{$reset_color%}"
#ZSH_THEME_GIT_PROMPT_CLEAN=" %{$terminfo[bold]$FG[040]%}✓"
#ZSH_THEME_GIT_PROMPT_DIRTY=" %{$terminfo[bold]$fg[red]%}✗"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$terminfo[bold]$FG[251]%}‹%{$fg_bold[yellow]%}"
ZSH_THEME_GIT_PROMPT_AHEAD="%{$fg_bold[magenta]%}↑"
ZSH_THEME_GIT_PROMPT_STAGED="%{$fg_bold[yellow]%}●"
ZSH_THEME_GIT_PROMPT_UNSTAGED="%{$fg_bold[green]%}●"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg_bold[cyan]%}●"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg_bold[red]%}✕"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$terminfo[bold]$FG[251]%}›%{$reset_color%}"

PROMPT=$'╭─${venv}${myuser}${myhost} ${current_dir}\n╰─${current_time} ${return_code} $(my_git_prompt) %B$%b '
