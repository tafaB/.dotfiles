export PATH=/opt/homebrew/bin:$PATH
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
# alias f='grep -r --binary-files=without-match'
# function f() {
#     grep -rn --binary-files=without-match "$1" | cat -n
# }
function f() {
    grep -rn --binary-files=without-match "$1" | awk '{print "\033[33m" NR "\033[0m", $0}'
}

alias vim='nvim'
alias :wq='exit;'
alias :q='exit;'
alias ls='ls --color=tty'
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
PS1='%F{#ffffff}[%n@ %1~]%F{red}$(git_branch_name)%f%F{#ffffff}$%f '


autoload -U compinit; compinit
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"
zstyle ':completion:*' menu select
zstyle ':completion:*:*:*:*:descriptions' format '%F{green}-- %d --%f'
zstyle ':completion:*' group-name ''
