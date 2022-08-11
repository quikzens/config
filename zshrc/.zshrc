# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="quikzens"

# Plugins
plugins=(git)
plugins=(z zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
	source /etc/profile.d/vte.sh
fi

# Aliases
alias zshconfig="vim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"
alias vim="nvim"
alias cat='batcat --paging=never'
alias nvimconfig='vim ~/.config/nvim/init.lua'
