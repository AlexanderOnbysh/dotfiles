export LANGUAGE="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="af-magic"

plugins=(git zsh-syntax-highlighting colored-man-pages copydir zsh-autosuggestions)
source $ZSH/oh-my-zsh.sh

export LANG=en_US.UTF-8

export EDITOR='vim'

# source $HOME/.oh-my-zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

source ~/.aliases
source ~/.functions
export PATH="/usr/local/sbin:$PATH"
