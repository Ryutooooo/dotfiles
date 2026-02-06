```
 ▄▄▄▄▄                            ▄▄▄▄      ██     ▄▄▄▄
 ██▀▀▀██               ██        ██▀▀▀      ▀▀     ▀▀██
 ██    ██   ▄████▄   ███████   ███████    ████       ██       ▄████▄   ▄▄█████▄
 ██    ██  ██▀  ▀██    ██        ██         ██       ██      ██▄▄▄▄██  ██▄▄▄▄ ▀
 ██    ██  ██    ██    ██        ██         ██       ██      ██▀▀▀▀▀▀   ▀▀▀▀██▄
 ██▄▄▄██   ▀██▄▄██▀    ██▄▄▄     ██      ▄▄▄██▄▄▄    ██▄▄▄   ▀██▄▄▄▄█  █▄▄▄▄▄██
 ▀▀▀▀▀       ▀▀▀▀       ▀▀▀▀     ▀▀      ▀▀▀▀▀▀▀▀     ▀▀▀▀     ▀▀▀▀▀    ▀▀▀▀▀▀
```

## Setup

```sh
sh setup.sh
```

This script will:
- Install Homebrew (if not installed)
- Install all packages from Brewfile
- Configure git with gh credential helper
- Install Cica font
- Create symbolic links
- Configure fzf
- Install Claude Code CLI

## Structure

```
dotfiles/
├── .bash_profile       # Bash profile
├── .bashrc             # Bash configuration
├── .tmux.conf          # Tmux configuration
├── .tmux/              # Tmux scripts and plugins
├── .alacritty.toml     # Alacritty terminal config
├── .gitconfig          # Git configuration (generated from gitconfig.txt)
├── .gitignore_global   # Global gitignore
├── .devcontainer/      # Devcontainer template
├── init.vim            # Neovim configuration
├── vim/                # Neovim plugins and settings
│   ├── lsp.lua         # LSP configuration
│   ├── ddu.vim         # ddu.vim (fuzzy finder)
│   ├── ddc.vim         # ddc.vim (completion)
│   ├── keymap.vim      # Key mappings
│   └── ...
├── starship.toml       # Starship prompt config
├── bin/                # Utility scripts
│   ├── dev-forward     # Port forwarding for devcontainers
│   └── dev-forward-supabase
├── Brewfile            # Homebrew dependencies
├── setup.sh            # Main setup script
└── link-dotfiles.sh    # Symlink creation script
```

## Packages

### CLI Tools (brew)
bash, bat, devcontainer, fzf, gh, ghq, gnu-sed, go, htop, jq, neofetch, neovim, php, ranger, ripgrep, starship, tig, tmux

### GUI Apps (cask)
Alacritty, Arc, ChatGPT, Claude, KeyboardCleanTool, LINE, Linear, Notion, Notion Calendar, OrbStack, Raycast, Rectangle, Slack, Dia

## Brewfile Management

After installing a new formula or cask:
```sh
brew bundle dump --force
```
