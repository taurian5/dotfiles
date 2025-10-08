# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a multi-platform dotfiles repository containing setup scripts and configuration files for Windows, macOS, and Linux environments. The repository follows a strict platform-specific organization pattern.

## Directory Structure & Organization Rules

**Critical**: All new scripts MUST be placed in the appropriate platform directory:
- `windows/` - PowerShell scripts (`.ps1`) for Windows
- `linux/` - Bash scripts (`.sh`) for Linux
- `mac/` - Bash scripts (`.sh`) for macOS
- `shared/` - Cross-platform dotfiles (`.gitconfig`, `.vimrc`, etc.)
- `.claude/` - Claude Code configuration and settings

**Never** place platform-specific scripts in the root directory or shared folder.

## Key Scripts & Their Purpose

### Windows Scripts (PowerShell)
- **install-tools.ps1** - Installs Git, GitHub CLI, and Claude Code via winget
  - Must run as regular user (NOT Administrator)
  - Creates log file on user's Desktop
  - Usage: `.\install-tools.ps1`

- **configure-git.ps1** - Sets up Git user config and Windows-specific settings
  - Usage: `.\configure-git.ps1 -Name "Your Name" -Email "email@example.com"`
  - Sets `core.autocrlf true` for Windows line endings

- **check-claude-settings.ps1** - Compares global Claude settings with repo settings
  - Checks if `~/.claude/settings.json` matches `.claude/settings.local.json`
  - Usage: `.\check-claude-settings.ps1`

### Linux/Mac Scripts (Bash)
- **setup.sh** - Platform-specific environment setup (TODO stubs currently)
- **check-claude-settings.sh** - Same as Windows version but for Unix platforms
  - Uses `jq` for JSON comparison if available, falls back to `diff`

## Claude Code Configuration

The `.claude/settings.local.json` file defines auto-allow permissions for Claude Code operations in this repository. It includes safe git commands, package managers, and file operations.

**Syncing settings**: The check-claude-settings scripts verify if the global `~/.claude/settings.json` matches the repo's `.claude/settings.local.json`. When they differ, the user should sync them:
```bash
# Windows
Copy-Item .claude\settings.local.json $env:USERPROFILE\.claude\settings.json

# Linux/Mac
cp .claude/settings.local.json ~/.claude/settings.json
```

## Development Conventions

### When Creating New Scripts
1. Determine the target platform
2. Place in the correct platform directory (`windows/`, `linux/`, or `mac/`)
3. Use the correct file extension (`.ps1` for Windows, `.sh` for Unix)
4. Make bash scripts executable: `chmod +x script.sh`
5. Document the script in README.md under the appropriate platform section

### Cross-Platform Configuration Files
Shared dotfiles go in `shared/` and are meant to be copied to the user's home directory:
- `.gitconfig` - Git aliases and configuration
- `.vimrc` - Vim editor settings

Users manually copy these files (e.g., `cp shared/.gitconfig ~/.gitconfig`).

## Git Configuration Notes

Windows and Unix platforms have different line ending requirements:
- Windows: Sets `core.autocrlf true` (via configure-git.ps1)
- The shared `.gitconfig` has general settings but NOT user.name/user.email (those are set per-machine)

## Testing Changes

When modifying platform-specific scripts:
- Windows: Test in PowerShell (not PowerShell ISE)
- Linux/Mac: Test in bash shell
- Ensure script works when run from its directory and from repo root
- Verify that check-claude-settings scripts correctly identify sync status
