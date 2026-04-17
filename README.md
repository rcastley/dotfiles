# Dotfiles

Personal configuration files for macOS.

## What's Included

| Config | Description |
|--------|-------------|
| **ZSH** | Shell config with Starship prompt, autosuggestions, syntax highlighting, history search |
| **Ghostty** | Terminal config - Catppuccin Mocha theme, tabs titlebar, block cursor |
| **Starship** | Powerline-style prompt with git, language, and Docker segments |
| **Git** | Global gitconfig and ignore patterns |
| **SSH** | SSH client config with host aliases and proxy jumps |
| **GitHub CLI** | `gh` configuration and aliases |
| **Brewfile** | All Homebrew formulae, casks, and VS Code extensions |

## Installation

```bash
git clone https://github.com/rcastley/dotfiles.git ~/Documents/GitHub/dotfiles
cd ~/Documents/GitHub/dotfiles
chmod +x install.sh
./install.sh
```

The install script creates symlinks from your home directory to this repo. Existing files are backed up with a `.backup` extension.

## Dependencies

- [Homebrew](https://brew.sh) - package manager
- [Starship](https://starship.rs) - cross-shell prompt
- [Ghostty](https://ghostty.org) - terminal emulator
- [Fira Code Nerd Font](https://www.nerdfonts.com) - patched font with icons

## Updating

Edit files in this repo directly - changes take effect immediately since everything is symlinked.

To regenerate the Brewfile from your current install:

```bash
brew bundle dump --file=~/Documents/GitHub/dotfiles/Brewfile --force
```
