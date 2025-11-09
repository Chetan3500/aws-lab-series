#!/usr/bin/env bash

if [[ $EUID -ne 0 ]]; then
  echo "This script must be run with sudo or as root."
  echo "Try: sudo $0"
  exit 1
fi

# Check if AWS CLI is already installed
if command -v aws >/dev/null 2>&1; then
  echo "✅ AWS CLI is already installed: $(aws --version)"
  exit 0
fi

echo "⚙️ Downloading AWS CLI v2 for Linux (x86_64)..."
TMP_DIR="/tmp/awscli-install"
mkdir -p "$TMP_DIR"
cd "$TMP_DIR"

wget "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -O "awscliv2.zip"

echo "📦 Extracting installer..."
unzip -q awscliv2.zip

echo "🚀 Installing AWS CLI..."
./aws/install

echo "🧹 Cleaning up..."
cd /
rm -rf "$TMP_DIR"

echo "✅ Installation complete!"
aws --version

