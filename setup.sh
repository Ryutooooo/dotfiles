#!/bin/bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$DOTFILES_DIR"

section() {
    echo ""
    echo "=== ${1} ==="
    echo ""
}

# --- 依存ツールのチェック ---
section "check dependencies"
for cmd in curl unzip; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
        echo "Error: $cmd is required but not found." >&2
        exit 1
    fi
done

# --- Homebrew ---
section "install Homebrew"
if command -v brew >/dev/null 2>&1; then
    echo "Homebrew is already installed."
else
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Homebrew の PATH を確保（インストール直後でも動作するように）
if [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
fi

section "brew bundle install"
brew bundle install --file="$DOTFILES_DIR/Brewfile"

# --- gitconfig ---
section "configure gitconfig"
cp "$DOTFILES_DIR/gitconfig.txt" "$DOTFILES_DIR/.gitconfig"

section "configure gh auth"
if gh auth status >/dev/null 2>&1; then
    gh auth setup-git
    echo "gh credential helper configured."
else
    echo "Warning: gh is not authenticated. Run 'gh auth login' to set up." >&2
fi

# --- Cica フォント ---
section "install Cica font"
FONT_DIR="$HOME/Library/Fonts"
if ls "$FONT_DIR"/Cica*.ttf >/dev/null 2>&1; then
    echo "Cica font is already installed."
else
    CICA_VERSION="5.0.3"
    CICA_ZIP="Cica_v${CICA_VERSION}.zip"
    CICA_URL="https://github.com/miiton/Cica/releases/download/v${CICA_VERSION}/${CICA_ZIP}"

    curl -fSL -o "/tmp/${CICA_ZIP}" "$CICA_URL"
    unzip -o "/tmp/${CICA_ZIP}" -d /tmp/cica_fonts
    mkdir -p "$FONT_DIR"
    find /tmp/cica_fonts \( -name '*.ttf' -o -name '*.otf' \) -exec cp {} "$FONT_DIR/" \;
    rm -rf "/tmp/${CICA_ZIP}" /tmp/cica_fonts
    echo "Cica font installed."
fi

# --- Alacritty theme ---
section "install Alacritty theme"
ALACRITTY_THEME_DIR="$HOME/.config/alacritty/themes"
if [[ -d "$ALACRITTY_THEME_DIR" ]]; then
    echo "Alacritty theme is already installed."
else
    mkdir -p "$HOME/.config/alacritty"
    git clone https://github.com/alacritty/alacritty-theme "$ALACRITTY_THEME_DIR"
    echo "Alacritty theme installed."
fi

# --- git-completion.bash ---
section "install git-completion.bash"
if [[ -f "$DOTFILES_DIR/git-completion.bash" ]]; then
    echo "git-completion.bash already exists."
else
    curl -fSL -o "$DOTFILES_DIR/git-completion.bash" \
        https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
    echo "Downloaded git-completion.bash."
fi

# --- シンボリックリンク ---
section "create symbolic links"
bash "$DOTFILES_DIR/link-dotfiles.sh"

# --- fzf ---
section "configure fzf"
if [[ -f "$HOME/.fzf.bash" ]]; then
    echo "fzf is already configured."
else
    yes | "$(brew --prefix)/opt/fzf/install"
fi

# --- TPM (Tmux Plugin Manager) ---
section "install TPM"
TPM_DIR="$HOME/.tmux/plugins/tpm"
if [[ -f "$TPM_DIR/tpm" ]]; then
    echo "TPM is already installed."
else
    rm -rf "$TPM_DIR"
    mkdir -p "$HOME/.tmux/plugins"
    git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
    echo "TPM installed. Run 'prefix + I' in tmux to install plugins."
fi

# --- Claude Code ---
section "install Claude Code"
if command -v claude >/dev/null 2>&1; then
    echo "Claude Code is already installed: $(claude --version)"
else
    curl -fsSL https://claude.ai/install.sh | bash
fi

echo ""
echo "=== Setup complete ==="
