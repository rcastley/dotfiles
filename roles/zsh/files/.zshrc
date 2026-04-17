# Docker CLI completions (must be before compinit)
[ -d "$HOME/.docker/completions" ] && fpath=("$HOME/.docker/completions" $fpath)

# Set history
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt HIST_IGNORE_ALL_DUPS
setopt SHARE_HISTORY
setopt APPEND_HISTORY

# ZSH plugins (via Homebrew)
if command -v brew &>/dev/null; then
    BREW_PREFIX="$(brew --prefix)"
    source "$BREW_PREFIX/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh"
    source "$BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
    source "$BREW_PREFIX/share/zsh-history-substring-search/zsh-history-substring-search.zsh"
    source "$BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

    bindkey '^[[A' history-substring-search-up
    bindkey '^[[B' history-substring-search-down
fi

alias python3="python3.14"
alias twl="terraform workspace list"
alias twn="terraform workspace new"
alias tws="terraform workspace select"
alias twd="terraform workspace delete"
export PATH="/opt/homebrew/opt/python@3.14/libexec/bin:$PATH"

alias ollama-cli="ollama run deepseek-coder:33b"

export CLAUDE_CODE_MAX_OUTPUT_TOKENS=128000

eval "$(starship init zsh)"
