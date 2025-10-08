# dotfiles

Personal development scripts and configuration files for multiple platforms.

## Repository Structure

```
dotfiles/
├── .claude/          # Claude Code configuration
│   └── settings.local.json  # Auto-allow permissions for Claude
├── windows/          # Windows-specific scripts (.ps1)
├── mac/              # macOS-specific scripts (.sh)
├── linux/            # Linux-specific scripts (.sh)
└── shared/           # Cross-platform configuration files
```

### Script Organization Guidelines
- **Windows scripts**: Place PowerShell scripts (`.ps1`) in `windows/`
- **Linux scripts**: Place bash scripts (`.sh`) in `linux/`
- **macOS scripts**: Place bash scripts (`.sh`) in `mac/`
- **Cross-platform configs**: Place dotfiles (`.gitconfig`, `.vimrc`, etc.) in `shared/`
- **Claude config**: Place Claude Code settings in `.claude/`

## Windows Scripts

### [install-tools.ps1](windows/install-tools.ps1)
Installs Git, GitHub CLI, and Claude Code on Windows.

**Usage:**
1. Open PowerShell as regular user (NOT Administrator)
2. Set execution policy (one-time):
   ```powershell
   Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned -Force
   ```
3. Run the script:
   ```powershell
   cd windows
   .\install-tools.ps1
   ```
4. Check Desktop for `install-tools-log.txt`

**What it installs:**
- Git for Windows
- GitHub CLI
- Claude Code (Anthropic's AI coding assistant)

### [setup-dev-env.ps1](windows/setup-dev-env.ps1)
Configure Windows development environment (TODO: customize for your needs)

### [configure-git.ps1](windows/configure-git.ps1)
Configure Git with user settings and recommended defaults.

**Usage:**
```powershell
.\configure-git.ps1 -Name "Your Name" -Email "your.email@example.com"
```

### [check-claude-settings.ps1](windows/check-claude-settings.ps1)
Checks if global Claude settings (`~/.claude/settings.json`) match the repo's local settings.

**Usage:**
```powershell
.\check-claude-settings.ps1
```

## macOS Scripts

### [setup.sh](mac/setup.sh)
macOS development environment setup (TODO: customize for your needs)

### [check-claude-settings.sh](mac/check-claude-settings.sh)
Checks if global Claude settings (`~/.claude/settings.json`) match the repo's local settings.

**Usage:**
```bash
./check-claude-settings.sh
```

## Linux Scripts

### [setup.sh](linux/setup.sh)
Linux development environment setup (TODO: customize for your needs)

### [check-claude-settings.sh](linux/check-claude-settings.sh)
Checks if global Claude settings (`~/.claude/settings.json`) match the repo's local settings.

**Usage:**
```bash
./check-claude-settings.sh
```

## Claude Code Configuration

### [.claude/settings.local.json](.claude/settings.local.json)
Project-specific Claude Code permissions and settings. Defines auto-allow rules for commands like git, npm, and file operations.

**To sync to global settings:**
```bash
# Windows
Copy-Item .claude\settings.local.json $env:USERPROFILE\.claude\settings.json

# Linux/Mac
cp .claude/settings.local.json ~/.claude/settings.json
```

Use the platform-specific `check-claude-settings` script to verify sync status.

## Shared Configuration

### [.gitconfig](shared/.gitconfig)
Global Git configuration with useful aliases and settings.

**To use:**
```bash
# Backup your existing config (optional)
cp ~/.gitconfig ~/.gitconfig.backup

# Copy the shared config
cp shared/.gitconfig ~/.gitconfig

# Set your user info
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

### [.vimrc](shared/.vimrc)
Vim configuration with sensible defaults.

**To use:**
```bash
# Backup existing config (optional)
cp ~/.vimrc ~/.vimrc.backup

# Copy the shared config
cp shared/.vimrc ~/.vimrc
```

## Getting Started

1. Clone this repository
2. Navigate to the folder for your platform
3. Run the appropriate setup script
4. Optionally copy shared configuration files

## Contributing

This is a personal dotfiles repository. Feel free to fork and adapt for your own use!
