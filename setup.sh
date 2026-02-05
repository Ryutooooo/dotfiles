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
for cmd in curl unzip envsubst; do
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

section "brew bundle install"
brew bundle install --file="$DOTFILES_DIR/Brewfile"

# --- GITHUB_TOKEN & gitconfig ---
section "configure gitconfig"
if [[ -z "${GITHUB_TOKEN:-}" ]]; then
    echo "Warning: GITHUB_TOKEN is not set. Skipping gitconfig generation." >&2
else
    envsubst < "$DOTFILES_DIR/gitconfig.txt" > "$DOTFILES_DIR/.gitconfig"
    echo "Generated .gitconfig with GITHUB_TOKEN."
fi

# --- Cica フォント ---
section "install Cica font"
FONT_DIR="$HOME/Library/Fonts"
if ls "$FONT_DIR"/Cica*.ttf >/dev/null 2>&1; then
    echo "Cica font is already installed."
else
    CICA_VERSION="5.0.2"
    CICA_ZIP="Cica_v${CICA_VERSION}_with_emoji.zip"
    CICA_URL="https://github.com/miiton/Cica/releases/download/v${CICA_VERSION}/${CICA_ZIP}"

    curl -fSL -o "/tmp/${CICA_ZIP}" "$CICA_URL"
    unzip -o "/tmp/${CICA_ZIP}" -d /tmp/cica_fonts
    mkdir -p "$FONT_DIR"
    find /tmp/cica_fonts \( -name '*.ttf' -o -name '*.otf' \) -exec cp {} "$FONT_DIR/" \;
    rm -rf "/tmp/${CICA_ZIP}" /tmp/cica_fonts
    echo "Cica font installed."
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
bash "$DOTFILES_DIR/dotfilesLink.sh"

# --- fzf ---
section "configure fzf"
if [[ -f "$HOME/.fzf.bash" ]]; then
    echo "fzf is already configured."
else
    yes | "$(brew --prefix)/opt/fzf/install"
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
