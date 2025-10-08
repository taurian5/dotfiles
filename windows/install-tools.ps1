# Install Git, GitHub CLI, and Claude Code on Windows
# 
# HOW TO RUN THIS SCRIPT:
# 
# Step 1: Open PowerShell as your REGULAR user (NOT as Administrator)
# 
# Step 2: Set execution policy (one-time setup):
#   Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned -Force
# 
# Step 3: Navigate to the script location and run it:
#   cd C:\Users\YourUsername\Downloads
#   .\install-tools.ps1
# 
# Step 4: Check your Desktop for install-tools-log.txt to see the full log
# 
# NOTE: Do NOT run as Administrator - the script will save logs to the admin user's
#       desktop instead of yours, and you won't be able to find them easily.

# Setup logging
$desktopPath = [Environment]::GetFolderPath("Desktop")
$logFile = Join-Path $desktopPath "install-tools-log.txt"
function Write-Log {
    param($Message, $Color = "White")
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    Add-Content -Path $logFile -Value "[$timestamp] $Message"
    Write-Host $Message -ForegroundColor $Color
}

# Clear previous log
if (Test-Path $logFile) { Remove-Item $logFile }

Write-Log "========================================" "Cyan"
Write-Log "  Dev Tools Installer for Windows" "Cyan"
Write-Log "  Git + GitHub CLI + Claude Code" "Cyan"
Write-Log "========================================" "Cyan"
Write-Log ""
Write-Log "Log file: $logFile" "Gray"
Write-Log ""

# Function to check if a command exists
function Test-Command {
    param($Command)
    try {
        if (Get-Command $Command -ErrorAction Stop) { return $true }
    } catch {
        return $false
    }
}

# Check internet connectivity
Write-Log "Checking internet connection..." "Yellow"
try {
    $null = Test-Connection -ComputerName "github.com" -Count 1 -ErrorAction Stop
    Write-Log "Internet connection verified" "Green"
} catch {
    Write-Log "No internet connection detected" "Red"
    Write-Log "Please check your network and try again" "Red"
    Read-Host "`nPress Enter to exit"
    exit 1
}
Write-Log ""

# Install Git
Write-Log "Installing Git..." "Yellow"
if (Test-Command "git") {
    $version = git --version
    Write-Log "Git already installed: $version" "Blue"
} else {
    try {
        $gitUrl = "https://github.com/git-for-windows/git/releases/download/v2.47.1.windows.1/Git-2.47.1-64-bit.exe"
        $gitInstaller = "$env:TEMP\git-installer.exe"
        
        Write-Log "Downloading Git..." "Gray"
        Invoke-WebRequest -Uri $gitUrl -OutFile $gitInstaller -ErrorAction Stop
        
        Write-Log "Installing Git (this takes a minute)..." "Gray"
        Start-Process -FilePath $gitInstaller -ArgumentList "/VERYSILENT" -Wait -ErrorAction Stop
        Remove-Item $gitInstaller -ErrorAction SilentlyContinue
        
        Write-Log "Git installed successfully" "Green"
    } catch {
        Write-Log "Git installation failed: $($_.Exception.Message)" "Red"
        Write-Log "Manual download: https://git-scm.com/download/win" "Yellow"
    }
}
Write-Log ""

# Install GitHub CLI
Write-Log "Installing GitHub CLI..." "Yellow"
if (Test-Command "gh") {
    $version = (gh --version 2>$null | Select-Object -First 1)
    Write-Log "GitHub CLI already installed: $version" "Blue"
} else {
    try {
        $ghUrl = "https://github.com/cli/cli/releases/download/v2.62.0/gh_2.62.0_windows_amd64.msi"
        $ghInstaller = "$env:TEMP\gh-installer.msi"
        
        Write-Log "Downloading GitHub CLI..." "Gray"
        Invoke-WebRequest -Uri $ghUrl -OutFile $ghInstaller -ErrorAction Stop
        
        Write-Log "Installing GitHub CLI (this takes a minute)..." "Gray"
        Start-Process msiexec.exe -ArgumentList "/i `"$ghInstaller`" /quiet /norestart" -Wait -ErrorAction Stop
        Remove-Item $ghInstaller -ErrorAction SilentlyContinue
        
        Write-Log "GitHub CLI installed successfully" "Green"
    } catch {
        Write-Log "GitHub CLI installation failed: $($_.Exception.Message)" "Red"
        Write-Log "Manual download: https://cli.github.com/" "Yellow"
    }
}
Write-Log ""

# Install Claude Code
Write-Log "Installing Claude Code..." "Yellow"
if (Test-Command "claude") {
    $version = claude --version 2>$null
    Write-Log "Claude Code already installed: $version" "Blue"
} else {
    try {
        Write-Log "Downloading and installing Claude Code..." "Gray"
        Invoke-RestMethod https://claude.ai/install.ps1 | Invoke-Expression
        Write-Log "Claude Code installed successfully" "Green"
    } catch {
        Write-Log "Claude Code installation failed: $($_.Exception.Message)" "Red"
        Write-Log "Manual install: irm https://claude.ai/install.ps1 | iex" "Yellow"
    }
}
Write-Log ""

# Configure PATH
Write-Log "Configuring PATH..." "Yellow"
$claudePath = "$env:USERPROFILE\.local\bin"
if (Test-Path $claudePath) {
    $currentPath = [Environment]::GetEnvironmentVariable("Path", "User")
    if ($currentPath -notlike "*$claudePath*") {
        try {
            [Environment]::SetEnvironmentVariable("Path", "$currentPath;$claudePath", "User")
            Write-Log "Claude Code added to PATH" "Green"
        } catch {
            Write-Log "Could not add to PATH automatically" "Yellow"
            Write-Log "Manually add: $claudePath" "Yellow"
        }
    } else {
        Write-Log "Claude Code already in PATH" "Green"
    }
}
Write-Log ""

# Summary
Write-Log "========================================" "Cyan"
Write-Log "Installation Summary" "Cyan"
Write-Log "========================================" "Cyan"

$gitOk = Test-Command "git"
$ghOk = Test-Command "gh"
$claudeOk = Test-Command "claude"

Write-Log "Git:        $(if ($gitOk) {'INSTALLED'} else {'FAILED'})" $(if ($gitOk) {"Green"} else {"Red"})
Write-Log "GitHub CLI: $(if ($ghOk) {'INSTALLED'} else {'FAILED'})" $(if ($ghOk) {"Green"} else {"Red"})
Write-Log "Claude:     $(if ($claudeOk) {'INSTALLED'} else {'FAILED'})" $(if ($claudeOk) {"Green"} else {"Red"})
Write-Log ""

if ($gitOk -and $ghOk -and $claudeOk) {
    Write-Log "SUCCESS! All tools installed." "Green"
    Write-Log ""
    Write-Log "Next steps:" "Cyan"
    Write-Log "1. Close this window" "White"
    Write-Log "2. Open a NEW PowerShell" "White"
    Write-Log "3. Verify with:" "White"
    Write-Log "   git --version" "Gray"
    Write-Log "   gh --version" "Gray"
    Write-Log "   claude --version" "Gray"
} else {
    Write-Log "Some installations failed - check log above" "Yellow"
}

Write-Log ""
Write-Log "Full log saved to: $logFile" "Cyan"
Write-Log ""
Read-Host "Press Enter to close"