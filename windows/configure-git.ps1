# Git Configuration for Windows
# Sets up Git with recommended settings

param(
    [Parameter(Mandatory=$false)]
    [string]$Name,

    [Parameter(Mandatory=$false)]
    [string]$Email
)

Write-Host "Configuring Git..." -ForegroundColor Cyan

if ($Name -and $Email) {
    git config --global user.name "$Name"
    git config --global user.email "$Email"
    Write-Host "Git user configured: $Name <$Email>" -ForegroundColor Green
} else {
    Write-Host "Usage: .\configure-git.ps1 -Name 'Your Name' -Email 'your.email@example.com'" -ForegroundColor Yellow
}

# Set common Git configurations
git config --global core.autocrlf true
git config --global init.defaultBranch main
git config --global pull.rebase false

Write-Host "Git configuration complete!" -ForegroundColor Green
