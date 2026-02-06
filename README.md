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
├── .claude/            # Claude Code configuration
│   ├── CLAUDE.md       # Personal work rules
│   ├── settings.json   # Core settings
│   ├── commands/       # Custom commands
│   ├── agents/         # Custom agent definitions
│   ├── hooks/          # Event hooks
│   └── plugins/        # Plugin management
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

## Devcontainer

Generic devcontainer template with Docker-in-Docker support. Useful for isolating project environments and avoiding port conflicts (e.g., running multiple Supabase instances).

### Initial Setup

Add dotfiles settings to VS Code `settings.json`:
```json
{
  "dotfiles.repository": "https://github.com/ryutooooo/dotfiles",
  "dotfiles.installCommand": "link-dotfiles.sh",
  "dotfiles.targetPath": "~/dotfiles"
}
```

### Usage

```sh
# 1. Copy devcontainer template to your project
cp -r ~/dotfiles/.devcontainer /path/to/project/

# 2. Customize if needed (e.g., add language features)
#    Edit .devcontainer/devcontainer.json:
#    "features": {
#      "ghcr.io/devcontainers/features/node:1": { "version": "22" }
#    }

# 3. Start devcontainer
cd /path/to/project
devcontainer up --workspace-folder . \
  --dotfiles-repository https://github.com/ryutooooo/dotfiles \
  --dotfiles-install-command link-dotfiles.sh

# 4. Enter the container
docker exec -it $(docker ps -q -l) bash
```

### Port Forwarding

When you need to access services running inside the devcontainer from your host (e.g., Supabase Studio in browser):

```sh
# Forward specific ports
dev-forward <project-name> <port1> [port2] ...
dev-forward my-project 3000 5432

# Supabase preset (forwards 54321-54324)
dev-forward-supabase my-project

# List running devcontainers
dev-forward
```

The `<project-name>` can be any part of the project path (case-insensitive partial match).

### Features Included

- **Docker-in-Docker**: Run containers inside the devcontainer
- **Neovim**: Pre-configured with vim-plug (plugins cached in Docker volume)
- **SSHD**: Enables on-demand port forwarding from host
- **SSH keys**: Mounted read-only for git operations

## Claude Code

Configuration for Claude Code CLI is managed in `.claude/` and symlinked to `~/.claude`.

### What's Managed

| Directory/File | Purpose |
|----------------|---------|
| `CLAUDE.md` | Personal work rules and methodology |
| `settings.json` | Permissions, hooks, plugin settings |
| `commands/` | Custom commands (e.g., `/review-and-fix`) |
| `agents/` | Custom agent definitions |
| `hooks/` | Event hook scripts |
| `plugins/plugins.txt` | Plugin list for sync across machines |

### Plugin Sync

Plugins are not automatically synced. Use these scripts to manage them:

```sh
# Install plugins from list (on new machine)
~/.claude/plugins/install-plugins.sh

# Preview without installing
~/.claude/plugins/install-plugins.sh --dry-run

# Export current plugins to list (after installing new plugins)
~/.claude/plugins/export-plugins.sh

# Preview export
~/.claude/plugins/export-plugins.sh --stdout
```

### Workflow

1. Install a new plugin: `/install marketplace/plugin-name`
2. Export to list: `~/.claude/plugins/export-plugins.sh`
3. Commit `plugins.txt`
4. On another machine: `~/.claude/plugins/install-plugins.sh`
