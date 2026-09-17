autoload -U compinit && compinit
source "$HOME/.zsh/fzf-tab/fzf-tab.zsh"

export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense'

zstyle ':completion:*' format '[ %d ]'
zstyle ':fzf-tab:*' switch-group '<' '>'

source <(carapace _carapace)
