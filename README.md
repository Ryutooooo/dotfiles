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
| `settings.json` | Core settings (permissions, MCP servers) |
| `commands/` | Custom commands (e.g., `/review-and-fix`) |
| `agents/` | Custom agent definitions |
| `hooks/` | Event hook scripts |
| `plugins/plugins.txt` | Plugin wishlist (manual install reference) |

### Settings Management

- **`settings.json`**: Declaratively managed in dotfiles. MCP servers and permissions are configured here.
- **Plugins**: Cannot be managed via `settings.json`. Install manually in an interactive session. See `plugins/plugins.txt` for the wishlist.

### Plugin Install

```sh
# 1. Add third-party marketplaces (official ones are pre-registered)
/plugin marketplace add thedotmack/claude-mem
/plugin marketplace add OthmanAdi/planning-with-files
/plugin marketplace add VoltAgent/awesome-claude-code-subagents
/plugin marketplace add wshobson/agents

# 2. Install plugins (plugin-name@marketplace-name)
/plugin install frontend-design@claude-plugins-official
/plugin install swift-lsp@claude-plugins-official
/plugin install claude-mem@thedotmack
/plugin install planning-with-files@planning-with-files
/plugin install voltagent-biz@voltagent-subagents
```
