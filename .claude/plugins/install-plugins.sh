#!/bin/bash
#
# Install Claude Code plugins from plugins.txt
#
# Usage: ./install-plugins.sh [--dry-run]
#

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLUGIN_LIST="${SCRIPT_DIR}/plugins.txt"

DRY_RUN=false
if [[ "${1:-}" == "--dry-run" ]]; then
    DRY_RUN=true
    echo "=== DRY RUN MODE ==="
fi

if [[ ! -f "$PLUGIN_LIST" ]]; then
    echo "Error: Plugin list not found: $PLUGIN_LIST"
    exit 1
fi

echo "Installing plugins from: $PLUGIN_LIST"
echo ""

installed=0
skipped=0
failed=0

while IFS= read -r line || [[ -n "$line" ]]; do
    # Skip empty lines and comments
    [[ -z "$line" ]] && continue
    [[ "$line" =~ ^[[:space:]]*# ]] && continue

    # Trim whitespace
    plugin=$(echo "$line" | xargs)
    [[ -z "$plugin" ]] && continue

    echo "Installing: $plugin"

    if $DRY_RUN; then
        echo "  [dry-run] Would run: claude /install $plugin"
        ((installed++))
    else
        if claude /install "$plugin" 2>&1; then
            echo "  Done"
            ((installed++))
        else
            echo "  Failed to install: $plugin"
            ((failed++))
        fi
    fi
done < "$PLUGIN_LIST"

echo ""
echo "=== Summary ==="
echo "Installed: $installed"
echo "Failed: $failed"

if [[ $failed -gt 0 ]]; then
    exit 1
fi
