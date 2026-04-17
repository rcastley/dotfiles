autoload -Uz compinit
compinit
eval "$(starship init zsh)"

# Set history
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

# ZSH plugins (via Homebrew)
if command -v brew &>/dev/null; then
    source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
    source "$(brew --prefix)/share/zsh-history-substring-search/zsh-history-substring-search.zsh"
    source "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

alias ls="ls --color=auto"
alias python3="python3.14"
alias twl="terraform workspace list"
alias twn="terraform workspace new"
alias tws="terraform workspace select"
alias twd="terraform workspace delete"
export PATH="/opt/homebrew/opt/python@3.14/libexec/bin:$PATH"

# Docker CLI completions
[ -d "$HOME/.docker/completions" ] && fpath=("$HOME/.docker/completions" $fpath)

alias ollama-cli="ollama run deepseek-coder:33b"

# bun
export BUN_INSTALL="$HOME/Library/Application Support/reflex/bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export CLAUDE_CODE_MAX_OUTPUT_TOKENS=128000

export PATH="$PATH:$HOME/.local/bin"
