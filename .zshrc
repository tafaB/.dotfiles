export PATH=/opt/homebrew/bin:$PATH
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
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
PS1='%F{#000000}[%n@ %1~]%F{red}$(git_branch_name)%f%F{#000000}$%f '
