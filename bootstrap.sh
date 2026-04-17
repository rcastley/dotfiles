#!/usr/bin/env bash
set -euo pipefail

if [ "$(id -u)" -eq 0 ]; then
    echo "Error: Do not run this script as root/sudo."
    exit 1
fi

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VENV_DIR="$DOTFILES_DIR/.venv"

info() { printf "\033[1;34m==> %s\033[0m\n" "$1"; }
success() { printf "\033[1;32m==> %s\033[0m\n" "$1"; }

# Xcode CLI tools (needed for git, compilers, etc.)
if ! xcode-select -p &>/dev/null; then
    info "Installing Xcode Command Line Tools..."
    xcode-select --install
    echo "Press any key once the installation is complete..."
    read -n 1 -s
fi

# Homebrew
if ! command -v brew &>/dev/null; then
    info "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Python venv + Ansible
if [ ! -d "$VENV_DIR" ]; then
    info "Creating Python virtual environment..."
    python3 -m venv "$VENV_DIR"
fi

info "Installing Ansible..."
source "$VENV_DIR/bin/activate"
pip install --quiet --upgrade pip ansible

# Run playbook
info "Running Ansible playbook..."
ansible-playbook "$DOTFILES_DIR/playbook.yml" --diff "$@"

success "Done! Restart your shell to pick up changes."
