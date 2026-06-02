#!/usr/bin/env bash
set -euo pipefail

if [ "$(id -u)" -eq 0 ]; then
    echo "Error: Do not run this script as root/sudo."
    exit 1
fi

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VENV_DIR="$DOTFILES_DIR/.venv"
OS="$(uname -s)"

info() { printf "\033[1;34m==> %s\033[0m\n" "$1"; }
success() { printf "\033[1;32m==> %s\033[0m\n" "$1"; }

# Xcode CLI tools (macOS only)
if [ "$OS" = "Darwin" ] && ! xcode-select -p &>/dev/null; then
    info "Installing Xcode Command Line Tools..."
    xcode-select --install
    echo "Press any key once the installation is complete..."
    read -n 1 -s
fi

# Homebrew
if ! command -v brew &>/dev/null; then
    info "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
if [ "$OS" = "Darwin" ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# Pull latest dotfiles
if [ -d "$DOTFILES_DIR/.git" ]; then
    info "Pulling latest dotfiles..."
    git -C "$DOTFILES_DIR" pull --ff-only
fi

# Modern Python for the Ansible venv (system python3 may be too old for current ansible-core).
info "Installing Python..."
brew install --quiet python@3.14
BREW_PYTHON="$(brew --prefix python@3.14)/bin/python3.14"

# Recreate venv if it was built on an older interpreter.
if [ -d "$VENV_DIR" ] && ! "$VENV_DIR/bin/python" -c 'import sys; sys.exit(0 if sys.version_info >= (3, 11) else 1)' 2>/dev/null; then
    info "Removing outdated venv..."
    rm -rf "$VENV_DIR"
fi

if [ ! -d "$VENV_DIR" ]; then
    info "Creating Python virtual environment..."
    "$BREW_PYTHON" -m venv "$VENV_DIR"
fi

info "Installing Ansible..."
source "$VENV_DIR/bin/activate"
pip install --quiet --upgrade pip ansible

info "Installing Ansible collections..."
ansible-galaxy collection install --upgrade -r "$DOTFILES_DIR/collections/requirements.yml"

# Run playbook
info "Running Ansible playbook..."
ansible-playbook "$DOTFILES_DIR/playbook.yml" --diff "$@"

success "Done! Restart your shell to pick up changes."
