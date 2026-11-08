#!/bin/bash
set -euo pipefail

# Cleanup on exit
cleanup() {
    rm -rf /tmp/proton-ge-custom
}
trap cleanup EXIT

# Determine Steam compatibility directory
if [[ -d ~/.var/app/com.valvesoftware.Steam/data/Steam ]]; then
    COMPAT_DIR=~/.var/app/com.valvesoftware.Steam/data/Steam/compatibilitytools.d
elif [[ -d ~/.steam/root ]]; then
    COMPAT_DIR=~/.steam/root/compatibilitytools.d
elif [[ -d ~/.steam/steam ]]; then
    COMPAT_DIR=~/.steam/steam/compatibilitytools.d
else
    echo "Error: Could not find Steam installation"
    exit 1
fi

echo "Creating temporary working directory..."
rm -rf /tmp/proton-ge-custom
mkdir -p /tmp/proton-ge-custom
cd /tmp/proton-ge-custom

# Fetch release info once
echo "Fetching latest release info..."
release_info=$(curl -s https://api.github.com/repos/GloriousEggroll/proton-ge-custom/releases/latest)

# Parse URLs (using jq if available, fallback to grep)
if command -v jq &>/dev/null; then
    tarball_url=$(echo "$release_info" | jq -r '.assets[] | select(.name | endswith(".tar.gz")) | .browser_download_url')
    checksum_url=$(echo "$release_info" | jq -r '.assets[] | select(.name | endswith(".sha512sum")) | .browser_download_url')
    version=$(echo "$release_info" | jq -r '.tag_name')
else
    tarball_url=$(echo "$release_info" | grep browser_download_url | cut -d\" -f4 | grep '.tar.gz$')
    checksum_url=$(echo "$release_info" | grep browser_download_url | cut -d\" -f4 | grep '.sha512sum$')
    version=$(echo "$release_info" | grep '"tag_name"' | cut -d\" -f4)
fi

tarball_name=$(basename "$tarball_url")

# Check if already installed
if [[ -d "$COMPAT_DIR/${tarball_name%.tar.gz}" ]]; then
    echo "Already up to date: $version"
    exit 0
fi

echo "Downloading $version..."
curl -# -L "$tarball_url" -o "$tarball_name"
curl -# -L "$checksum_url" -o "$(basename "$checksum_url")"

echo "Verifying checksum..."
sha512sum -c "$(basename "$checksum_url")"

mkdir -p "$COMPAT_DIR"
echo "Extracting to $COMPAT_DIR..."
tar -xf "$tarball_name" -C "$COMPAT_DIR/"

echo "✅ Successfully installed $version"
echo "Restart Steam to use the new Proton version."
