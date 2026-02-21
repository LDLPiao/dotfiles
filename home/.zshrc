eval "$(starship init zsh)"
# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd extendedglob nomatch
unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/luiz/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

path+=("$HOME/.local/bin")
path+=("$HOME/.local/share/nvim/mason/bin")

export PATH

alias ls='eza --color=auto --icons=auto'
alias grep='grep --color=auto'
