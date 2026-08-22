#!/usr/bin/env bash

set -euo pipefail

echo "--- Running post-create script ---"
rustup update stable

sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -y --no-install-recommends ripgrep vim
sudo rm -rf /var/lib/apt/lists/*

# Activating the virtual environment
# echo "Creating virtual environment..."
if [ ! -d ".venv" ]; then
    python3 -m venv .venv
fi
.venv/bin/pip install --upgrade pip

# Install Python dependencies from requirements.txt
# echo "Installing requirements..."
find . -name "requirements.txt" -exec ./.venv/bin/pip install -r {} \;

# Install anti-gravity
curl --proto '=https' --tlsv1.2 -fsSL https://antigravity.google/cli/install.sh | bash

# echo "Installing project in editable mode..."
# ./.venv/bin/pip install -e .