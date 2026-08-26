# Dotfiles

Configuration for my development environment, on **macOS** and **Ubuntu**.

[![CI](https://github.com/ken109/dotfiles/actions/workflows/ci.yml/badge.svg)](https://github.com/ken109/dotfiles/actions/workflows/ci.yml)
![License](https://img.shields.io/github/license/ken109/dotfiles?style=flat-square)
![Top Language](https://img.shields.io/github/languages/top/ken109/dotfiles?style=flat-square)

![demo](.github/demo/sennit.gif)

Managed with [sennit](https://github.com/ken109/sennit), written for this repository.
Three files describe the whole thing:

| | |
|---|---|
| `packages.toml` | every package, and what it provides |
| `theme.toml` | the colour scheme, once |
| `sennit.toml` | what gets linked, generated, and run afterwards |

CI installs the whole thing into a fresh Ubuntu container on every push, then checks that
nothing any config references is missing from `packages.toml`. A pull request that changes
a declaration is tested by removing it and seeing whether the install still succeeds.

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

It clones the repository to `~/.dotfiles`, installs Homebrew and enough to run `sennit`,
and hands the rest over: `sennit sync` installs what `packages.toml` declares, and
`sennit apply` renders the templates and places the symlinks.

## 📦 Usage

After installation, the following commands and aliases are available:

### Management

- **`dotfiles update`**: Pull, then re-apply.
- **`dotfiles list`**: Show every managed path and where it points.

Or use `sennit` directly, from anywhere inside the repository:

```sh
sennit diff      # what an apply would change
sennit apply     # place it
sennit sync      # install anything declared but missing
sennit check     # is everything the configs need declared?
sennit verify    # is everything declared actually here?
```

### Utilities

- **`cdg`**: Quickly navigate to `ghq` managed repositories using `fzf`.
- **`git-branch-prune`**: Delete local branches that have been removed from the remote.

## 📂 Directory Structure

```
.dotfiles
├── packages.toml    # every package, per OS and package manager
├── theme.toml       # the colour scheme
├── sennit.toml      # what to link, what to generate, what to run after
├── .config/         # XDG configuration (nvim, zsh, tmux, alacritty, ...)
├── .hammerspoon/    # macOS automation
├── .local/          # GNOME Shell extensions (Linux)
└── script/          # bootstrap and setup; everything else is sennit's job
```

Files ending in `.tmpl` are generated from `theme.toml`; their output is not committed.

## 📜 License

MIT © [Kensuke Kubo](https://github.com/ken109)
