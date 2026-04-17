#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

info() { printf "\033[1;34m==> %s\033[0m\n" "$1"; }
success() { printf "\033[1;32m==> %s\033[0m\n" "$1"; }
warn() { printf "\033[1;33m==> %s\033[0m\n" "$1"; }

link_file() {
    local src="$1" dst="$2"
    if [ -L "$dst" ]; then
        rm "$dst"
    elif [ -e "$dst" ]; then
        warn "Backing up existing $dst to ${dst}.backup"
        mv "$dst" "${dst}.backup"
    fi
    mkdir -p "$(dirname "$dst")"
    ln -s "$src" "$dst"
    success "Linked $dst -> $src"
}

info "Installing dotfiles from $DOTFILES_DIR"

# Homebrew - install first so plugins are available for zsh
if ! command -v brew &>/dev/null; then
    info "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

info "Installing Homebrew packages from Brewfile..."
brew bundle --file="$DOTFILES_DIR/Brewfile" --no-lock

# ZSH
link_file "$DOTFILES_DIR/zsh/.zshrc" "$HOME/.zshrc"
link_file "$DOTFILES_DIR/zsh/.zprofile" "$HOME/.zprofile"

# Git
link_file "$DOTFILES_DIR/git/.gitconfig" "$HOME/.gitconfig"
link_file "$DOTFILES_DIR/git/ignore" "$HOME/.config/git/ignore"

# Ghostty
link_file "$DOTFILES_DIR/ghostty/config" "$HOME/Library/Application Support/com.mitchellh.ghostty/config"

# Starship
link_file "$DOTFILES_DIR/starship/starship.toml" "$HOME/.config/starship.toml"

# SSH
link_file "$DOTFILES_DIR/ssh/config" "$HOME/.ssh/config"

# GitHub CLI
link_file "$DOTFILES_DIR/gh/config.yml" "$HOME/.config/gh/config.yml"

success "Dotfiles installed!"
