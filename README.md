# Dotfiles

Personal macOS configuration managed with Ansible.

## What's Included

| Role | Description |
|------|-------------|
| **homebrew** | Formulae, casks |
| **zsh** | Shell config with Starship prompt, autosuggestions, syntax highlighting, history search |
| **git** | Global gitconfig and ignore patterns |
| **ghostty** | Terminal config - Catppuccin Mocha theme, tabs titlebar, block cursor |
| **starship** | Powerline-style prompt with git, language, and Docker segments |
| **gh** | GitHub CLI configuration and aliases |

## Installation

```bash
git clone https://github.com/rcastley/dotfiles.git ~/Documents/GitHub/dotfiles
~/Documents/GitHub/dotfiles/bootstrap.sh
```

The bootstrap script will:
1. Install Xcode Command Line Tools (if needed)
2. Install Homebrew (if needed)
3. Create a Python venv and install Ansible
4. Run the playbook (backs up any existing config files)

## Running Individual Roles

```bash
~/Documents/GitHub/dotfiles/bootstrap.sh --tags zsh,starship
```

## Dry Run

```bash
~/Documents/GitHub/dotfiles/bootstrap.sh --check
```
