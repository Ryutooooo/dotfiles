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

### Prerequisites

Add to `~/.bash_profile` (automatically done by setup):
```sh
# Claude Code credentials for devcontainer
if command -v security >/dev/null 2>&1; then
  export CLAUDE_CREDENTIALS=$(security find-generic-password -s 'Claude Code-credentials' -w 2>/dev/null)
fi
```

### Usage

```sh
# Start a devcontainer (any repository)
devc ~/path/to/repo

# Start from current directory
devc

# Re-attach to existing container
devc ~/path/to/repo

# Remove a container
devc --rm ~/path/to/repo
```

### Port Forwarding

When you need to access services running inside the devcontainer from your host (e.g., Supabase, dev server):

```sh
# Forward ports from current directory's container
devc-forward 54321 3000

# Forward ports from a specific container
devc-forward ~/path/to/repo 54321 3000 8000

# Stop forwarding
# Ctrl+C
```

### Features Included

- **Docker-in-Docker**: Run containers inside the devcontainer
- **Neovim**: Pre-configured with vim-plug (plugins cached in Docker volume)
- **Claude Code**: Subscription auth forwarded from host via macOS Keychain
- **SSH keys**: Mounted read-only for git operations
- **socat**: On-demand port forwarding without SSH auth

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
