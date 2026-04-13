#!/bin/bash
set -euo pipefail

echo "Starting workspace setup..."
echo ""

# Install Bun if not already installed
if ! command -v bun &> /dev/null; then
    echo "Installing Bun..."
    curl -fsSL https://bun.sh/install | bash
    echo "✓ Bun installed"
else
    echo "✓ Bun already installed"
fi

echo ""

# Install TPM if not already present
if [ ! -d "$HOME/.config/tmux/plugins/tpm" ]; then
    echo "Installing TPM (Tmux Plugin Manager)..."
    mkdir -p "$HOME/.config/tmux/plugins"
    git clone https://github.com/tmux-plugins/tpm "$HOME/.config/tmux/plugins/tpm"
    echo "✓ TPM installed"
else
    echo "✓ TPM already installed"
fi

echo ""
echo "Setup complete!"