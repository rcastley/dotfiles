#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%Y%m%d_%H%M%S)"

info() { printf "\033[1;34m==> %s\033[0m\n" "$1"; }
success() { printf "\033[1;32m==> %s\033[0m\n" "$1"; }
warn() { printf "\033[1;33m==> %s\033[0m\n" "$1"; }

link_file() {
    local src="$1" dst="$2"
    if [ -L "$dst" ]; then
        rm "$dst"
    elif [ -e "$dst" ]; then
        mkdir -p "$BACKUP_DIR"
        local backup_path="$BACKUP_DIR/$(basename "$dst")"
        warn "Backing up $dst -> $backup_path"
        cp -a "$dst" "$backup_path"
        rm "$dst"
    fi
    mkdir -p "$(dirname "$dst")"
    ln -s "$src" "$dst"
    success "Linked $dst -> $src"
}

info "Installing dotfiles from $DOTFILES_DIR"

# --- Homebrew ---
# Install if missing, then install packages
if ! command -v brew &>/dev/null; then
    info "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

info "Installing Homebrew packages from Brewfile..."
brew bundle --file="$DOTFILES_DIR/Brewfile" --no-lock || warn "Some Brewfile entries failed - continuing anyway"

# --- Symlinks ---
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
chmod 600 "$HOME/.ssh/config"

# GitHub CLI
link_file "$DOTFILES_DIR/gh/config.yml" "$HOME/.config/gh/config.yml"

# --- Summary ---
if [ -d "$BACKUP_DIR" ]; then
    info "Existing files backed up to: $BACKUP_DIR"
fi
success "Dotfiles installed!"
