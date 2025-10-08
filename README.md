# dotfiles

Personal development scripts and configuration files for multiple platforms.

## Repository Structure

```
dotfiles/
├── windows/          # Windows-specific scripts
├── mac/              # macOS-specific scripts
├── linux/            # Linux-specific scripts
└── shared/           # Cross-platform configuration files
```

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

## macOS Scripts

### [setup.sh](mac/setup.sh)
macOS development environment setup (TODO: customize for your needs)

## Linux Scripts

### [setup.sh](linux/setup.sh)
Linux development environment setup (TODO: customize for your needs)

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
