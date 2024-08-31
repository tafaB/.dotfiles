export EDITOR='vim'

# Commands
alias cl='clear'
alias ls='ls --color=auto'
alias gg='cat ~/git_pass | pbcopy'
alias vim='nvim'
alias ls='ls -G'

# Function: ff - Fuzzy find with preview
function ff {
  find . -iname "*$1*" | fzf --preview 'bat --style=full --color=always --theme=OneHalfDark {}' \
    --preview-window 'up:50%' --bind "enter:become:nvim {}; echo {}"
}

# Function: fg - Fuzzy grep with custom opener
function fg {
  RELOAD='reload:rg --column --color=always --smart-case {q} || :'
  OPENER='if [[ $FZF_SELECT_COUNT -eq 0 ]]; then
  nvim {1} +{2}; echo {1}
else
  nvim +cw -q {+f}; echo {+f}
  fi'
  fzf --disabled --ansi --multi \
    --bind "start:$RELOAD" --bind "change:$RELOAD" \
    --bind "enter:become:$OPENER" \
    --bind "ctrl-o:execute:$OPENER" \
    --bind 'alt-a:select-all,alt-d:deselect-all,ctrl-/:toggle-preview' \
    --delimiter : \
    --preview 'bat --style=full --color=always --theme=OneHalfDark --highlight-line {2} {1}' \
    --preview-window '~4,+{2}+4/3,<80(up)' \
    --query "$*"
}

# Zsh history search
autoload -U compinit; compinit
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^[[A" history-beginning-search-backward-end
bindkey "^[[B" history-beginning-search-forward-end

# Function: compile - Compile and run C++ programs
function compile {
  g++ --std=c++20 -g -o $1 $1.cpp
  if [ $? -eq 0 ]; then
    ./$1
    if [ $? -ne 0 ]; then
      echo "Runtime error occurred: $? (Check for segmentation faults or other errors)"
    fi
  else
    echo "Compilation failed."
  fi
  rm $1
  rm -rf $1.dSYM
}

# Tmux attach or create session
function att {
  if [ $# -eq 1 ]; then
    tmux attach-session -t $1
    if [ $? -eq 1 ]; then
      tmux new-session -s $1
    fi
    return
  fi
  local session_name=$(tmux list-sessions | grep -o '^[^:]*' | fzf)
  tmux attach-session -t $session_name
  if [ $? -eq 1 ]; then
    echo "Starting new session"
    tmux new-session -s 1
  fi
}

alias dtt='tmux detach-client'

# Git branch in prompt
function git_branch_name() {
  branch=$(git symbolic-ref HEAD 2> /dev/null | awk 'BEGIN{FS="/"} {print $NF}')
  if [[ $branch == "" ]]; then
    :
  else
    echo '- ('$branch')'
  fi
}

setopt prompt_subst
prompt='%2/ $(git_branch_name)$ '
