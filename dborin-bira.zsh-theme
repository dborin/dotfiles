# ZSH Theme - Preview: http://gyazo.com/8becc8a7ed5ab54a0262a470555c3eed.png
local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

#local user_host='%{$terminfo$fg[202]%}%n@%m%{$reset_color%}'
local user_host='%{$terminfo[bold]$FG[220]%}%n@%m%{$reset_color%}'
local current_dir='%{$terminfo[bold]$FG[014]%} %~%{$reset_color%}'
local rvm_ruby=''
if which rvm-prompt &> /dev/null; then
  rvm_ruby='%{$terminfo[bold]$fg[red]%}‹$(rvm-prompt i v g)›%{$reset_color%}'
else
  if which rbenv &> /dev/null; then
    rvm_ruby='%{$terminfo[bold]$fg[red]%}‹$(rbenv version | sed -e "s/ (set.*$//")›%{$reset_color%}'
  fi
fi
local git_branch='$(git_prompt_info)%{$reset_color%}'

PROMPT="╭─${user_host} ${current_dir} ${rvm_ruby} ${git_branch}
╰─%B$%b "
RPS1="${return_code}"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$terminfo[bold]$FG[251]%}‹"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$terminfo[bold]$FG[251]%}›%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$terminfo[bold]$FG[040]%}✓"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$terminfo[bold]$fg[red]%}✗"
