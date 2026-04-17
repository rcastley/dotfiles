autoload -Uz compinit
compinit
eval "$(starship init zsh)"

# Set history
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-history-substring-search/zsh-history-substring-search.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

alias ls="ls --color=auto"
alias python3="python3.14"
alias twl="terraform workspace list"
alias twn="terraform workspace new"
alias tws="terraform workspace select"
alias twd="terraform workspace delete"
export PATH="/opt/homebrew/opt/python@3.14/libexec/bin:$PATH"

# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/rcastley/.docker/completions $fpath)
# End of Docker CLI completions
alias ollama-cli="ollama run deepseek-coder:33b"

# bun
export BUN_INSTALL="$HOME/Library/Application Support/reflex/bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export CLAUDE_CODE_MAX_OUTPUT_TOKENS=128000

# Created by `pipx` on 2026-03-02 07:40:42
export PATH="$PATH:/Users/rcastley/.local/bin"
