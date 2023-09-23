export PATH=/opt/homebrew/bin:$PATH
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
alias ff='find . -type f -name'
alias fg='rg -i'
alias vim='nvim'
alias :wq='exit;'
alias :q='exit;'
alias ls='ls --color'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias start_database='psql postgres://beringtafa@localhost:5432/beringtafa'
export PATH="$PATH:$CARGO_HOME/bin"
alias cl='clear'
function git_branch_name()
{
  branch=$(git symbolic-ref HEAD 2> /dev/null | awk 'BEGIN{FS="/"} {print $NF}')
  if [[ $branch == "" ]];
  then
    :
  else
    echo '-('$branch')'
  fi
}
autoload -U colors && colors
setopt prompt_subst
PS1='%F{white}[%n@ %1~]%F{red}$(git_branch_name)%f%F{white}$%f '


autoload -U compinit; compinit
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"
zstyle ':completion:*' menu select
zstyle ':completion:*:*:*:*:descriptions' format '%F{green}-- %d --%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
