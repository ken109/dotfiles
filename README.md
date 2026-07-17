# Dotfiles

A comprehensive configuration management for my development environment, primarily targeted at **macOS** (with Linux support).
Managed with automated scripts and modern CLI tools to provide a reproducible and efficient workflow.

![License](https://img.shields.io/github/license/ken109/dotfiles?style=flat-square)
![Top Language](https://img.shields.io/github/languages/top/ken109/dotfiles?style=flat-square)

## 🛠 Features

This repository manages configurations for:

- **Shell & Prompt**:
  - [Zsh](https://www.zsh.org/) - With [Sheldon](https://github.com/rossmacarthur/sheldon) plugin manager.
  - [Starship](https://starship.rs/) - Cross-shell prompt.
  - [Nushell](https://www.nushell.sh/) - Modern shell alternative.
- **Editors**:
  - [Neovim](https://neovim.io/) - Based on [LazyVim](https://www.lazyvim.org/).
  - [Zed](https://zed.dev/) - High-performance multiplayer code editor.
- **Terminal & Multiplexers**:
  - [Alacritty](https://alacritty.org/) - GPU-accelerated terminal emulator.
  - [Tmux](https://github.com/tmux/tmux) & [Herdr](https://herdr.dev/) - Agent multiplexer.
- **System & Tools**:
  - [Mise](https://mise.jdx.dev/) - Runtime executor & version manager (Node, Python, etc.).
  - [Hammerspoon](https://www.hammerspoon.org/) - macOS automation.
  - [LazyGit](https://github.com/jesseduffield/lazygit) - Simple terminal UI for git commands.

## 🚀 Installation

### Prerequisites

- **macOS** or **Linux** (Ubuntu/Debian)
- `curl`, `git`

### Quick Start

To install and set up everything, simply run the following command:

```bash
bash -c "$(curl -L https://raw.githubusercontent.com/ken109/dotfiles/main/script/install.sh)"
```

This script will:
1. Download this repository to `~/.dotfiles`.
2. Install system dependencies and tools (via Homebrew or apt).
3. Set up Zsh as the default shell.
4. Symlink configuration files to your home directory.

## 📦 Usage

After installation, the following commands and aliases are available:

### Management

- **`dotfiles list`**: List all managed files and their symlink destinations.
- **`dotfiles update`**: Pull the latest changes from GitHub and re-deploy symlinks.

### Utilities

- **`cdg`**: Quickly navigate to `ghq` managed repositories using `fzf`.
- **`git-branch-prune`**: Delete local branches that have been removed from the remote.

## 📂 Directory Structure

```
.dotfiles
├── .config/       # XDG-compatible configurations (nvim, zsh, tmux, etc.)
├── .hammerspoon/  # Hammerspoon configuration (macOS only)
├── script/        # Installation, setup, and deployment scripts
└── ...
```

## 📜 License

MIT © [Kensuke Kubo](https://github.com/ken109)
