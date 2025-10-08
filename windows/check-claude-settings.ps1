# Check Claude settings sync status
# Compares global settings with repo's local settings

$globalSettings = "$env:USERPROFILE\.claude\settings.json"
$repoSettings = "$PSScriptRoot\settings.local.json"

Write-Host "Claude Settings Checker" -ForegroundColor Cyan
Write-Host "======================" -ForegroundColor Cyan
Write-Host ""

# Check if files exist
if (-not (Test-Path $globalSettings)) {
    Write-Host "❌ Global settings not found at: $globalSettings" -ForegroundColor Red
    exit 1
}

if (-not (Test-Path $repoSettings)) {
    Write-Host "❌ Repo settings not found at: $repoSettings" -ForegroundColor Red
    exit 1
}

Write-Host "📂 Global: $globalSettings" -ForegroundColor Gray
Write-Host "📂 Repo:   $repoSettings" -ForegroundColor Gray
Write-Host ""

# Read and parse JSON files
try {
    $global = Get-Content $globalSettings -Raw | ConvertFrom-Json
    $repo = Get-Content $repoSettings -Raw | ConvertFrom-Json
} catch {
    Write-Host "❌ Error parsing JSON: $_" -ForegroundColor Red
    exit 1
}

# Compare
$globalJson = $global | ConvertTo-Json -Depth 10
$repoJson = $repo | ConvertTo-Json -Depth 10

if ($globalJson -eq $repoJson) {
    Write-Host "✅ Settings are in sync!" -ForegroundColor Green
    exit 0
} else {
    Write-Host "⚠️  Settings are OUT OF SYNC" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Run this command to sync:" -ForegroundColor Cyan
    Write-Host "  Copy-Item '$repoSettings' '$globalSettings'" -ForegroundColor White
    exit 1
}
