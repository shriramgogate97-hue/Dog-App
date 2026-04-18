$ErrorActionPreference = 'Stop'

Write-Host '🐶 Dog Rescue App Bootstrap (Windows + PowerShell)' -ForegroundColor Cyan

$dogAppPath = 'E:\Dog app'
if (-not (Test-Path $dogAppPath)) {
    New-Item -ItemType Directory -Path $dogAppPath | Out-Null
    Write-Host "✅ Created folder: $dogAppPath" -ForegroundColor Green
} else {
    Write-Host "ℹ️ Folder already exists: $dogAppPath" -ForegroundColor Yellow
}

$packages = @(
    @{ Id = 'Git.Git'; Name = 'Git' },
    @{ Id = 'OpenJS.NodeJS.LTS'; Name = 'Node.js LTS' },
    @{ Id = 'Flutter.Flutter'; Name = 'Flutter SDK' },
    @{ Id = 'Notepad++.Notepad++'; Name = 'Notepad++' }
)

foreach ($pkg in $packages) {
    Write-Host "📦 Installing $($pkg.Name)..." -ForegroundColor Magenta
    winget install --id $pkg.Id --exact --accept-package-agreements --accept-source-agreements --silent
}

$targets = @('main-website', 'admin-webapp', 'customer-app', 'ngo-app', 'admin-app')
foreach ($target in $targets) {
    $path = Join-Path $dogAppPath $target
    if (-not (Test-Path $path)) {
        New-Item -ItemType Directory -Path $path | Out-Null
    }
}

Write-Host '🚀 Setup complete! Next: copy this repo into E:\Dog app or clone there and run apps.' -ForegroundColor Green
