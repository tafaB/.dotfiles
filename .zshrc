export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="eastwood"
plugins=(git)
source $ZSH/oh-my-zsh.sh
export PATH=/opt/homebrew/bin:$PATH
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
alias vim='nvim'
alias :wq='exit;'
alias :q='exit;'
alias skim='sh ~/skim.sh'
fortune
