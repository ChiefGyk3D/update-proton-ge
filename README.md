# Update Proton-GE

A simple script to automatically download and install the latest [Proton-GE](https://github.com/GloriousEggroll/proton-ge-custom) release for Steam on Linux.

## Features

- Downloads the latest Proton-GE release from GitHub
- Verifies SHA512 checksum before installation
- Auto-detects Steam installation (Flatpak or native)
- Skips download if already up-to-date
- Automatic cleanup of temporary files

## Requirements

- `curl` - for downloading files
- `sha512sum` - for checksum verification (usually pre-installed)
- `jq` (optional) - for more reliable JSON parsing

### Install dependencies

**Debian/Ubuntu:**
```bash
sudo apt install curl jq
```

**Fedora:**
```bash
sudo dnf install curl jq
```

**Arch Linux:**
```bash
sudo pacman -S curl jq
```

## Installation

### Option 1: Clone the repository

```bash
git clone https://github.com/yourusername/update-proton-ge.git
cd update-proton-ge
chmod +x update-proton.sh
```

### Option 2: Download directly

```bash
curl -O https://raw.githubusercontent.com/yourusername/update-proton-ge/main/update-proton.sh
chmod +x update-proton.sh
```

## Usage

Run the script manually:

```bash
./update-proton.sh
```

## Setting Up an Alias

For quick access, add an alias to your shell configuration file.

### Bash (`~/.bashrc`)

```bash
echo 'alias update-proton="/home/chiefgyk3d/src/update-proton-ge/update-proton.sh"' >> ~/.bashrc
source ~/.bashrc
```

### Zsh (`~/.zshrc`)

```bash
echo 'alias update-proton="/home/chiefgyk3d/src/update-proton-ge/update-proton.sh"' >> ~/.zshrc
source ~/.zshrc
```

### Fish (`~/.config/fish/config.fish`)

```bash
echo 'alias update-proton="/home/chiefgyk3d/src/update-proton-ge/update-proton.sh"' >> ~/.config/fish/config.fish
source ~/.config/fish/config.fish
```

Now you can simply run:

```bash
update-proton
```

## Supported Steam Installations

The script automatically detects and supports:

| Installation Type | Compatibility Path |
|-------------------|-------------------|
| Flatpak | `~/.var/app/com.valvesoftware.Steam/data/Steam/compatibilitytools.d` |
| Native (root) | `~/.steam/root/compatibilitytools.d` |
| Native (steam) | `~/.steam/steam/compatibilitytools.d` |

## After Installation

1. Restart Steam completely (quit and relaunch)
2. Right-click a game → **Properties** → **Compatibility**
3. Check "Force the use of a specific Steam Play compatibility tool"
4. Select the new GE-Proton version from the dropdown

## License

MIT License - feel free to modify and distribute.

## Credits

- [GloriousEggroll](https://github.com/GloriousEggroll) for creating Proton-GE
