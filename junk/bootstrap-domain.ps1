param(
    [string]$DomainName = "hamsammich.local",
    [string]$SharePath = "\\fileshare\FileshareMain",
    [string]$DriveLetter = "F",
    [string]$OUPath = ""
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

function Assert-Admin {
    $currentIdentity = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object Security.Principal.WindowsPrincipal($currentIdentity)
    if (-not $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
        throw "This script must be run as Administrator."
    }
}

Assert-Admin

Write-Host "Domain join target: $DomainName"
if ($OUPath) {
    Write-Host "OU path: $OUPath"
}

# Domain join credentials: prompt at runtime so nothing is stored on disk.
$domainCred = Get-Credential -Message "Enter domain join credentials for $DomainName"

# Optional share credentials; press Cancel to use current credentials.
$shareCred = $null
try {
    $shareCred = Get-Credential -Message "Enter share credentials for $SharePath (Cancel to use current credentials)"
} catch {
    $shareCred = $null
}

Write-Host "Mapping share $SharePath to drive $DriveLetter..."
if (Get-PSDrive -Name $DriveLetter -ErrorAction SilentlyContinue) {
    Remove-PSDrive -Name $DriveLetter -Force
}
if ($shareCred) {
    New-PSDrive -Name $DriveLetter -PSProvider FileSystem -Root $SharePath -Persist -Credential $shareCred | Out-Null
} else {
    New-PSDrive -Name $DriveLetter -PSProvider FileSystem -Root $SharePath -Persist | Out-Null
}
Write-Host "Share mapped."

Write-Host "Checking Windows Update availability (PSWindowsUpdate)..."
if (-not (Get-Module -ListAvailable -Name PSWindowsUpdate)) {
    Write-Host "PSWindowsUpdate not found. Installing from PSGallery..."
    Install-PackageProvider -Name NuGet -Force | Out-Null
    Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
    Install-Module -Name PSWindowsUpdate -Force
}
Import-Module PSWindowsUpdate
$wu = Get-WindowsUpdate -MicrosoftUpdate -IgnoreUserInput -AcceptAll -WhatIf
if ($wu) {
    Write-Host "Windows Update: updates available:"
    $wu | Format-Table -AutoSize
} else {
    Write-Host "Windows Update: no updates available."
}

Write-Host "Checking app updates via winget (if available)..."
if (Get-Command winget -ErrorAction SilentlyContinue) {
    winget upgrade --accept-source-agreements --accept-package-agreements
} else {
    Write-Host "winget not installed; skipping app update check."
}

Write-Host "Joining domain $DomainName..."
if ($OUPath) {
    Add-Computer -DomainName $DomainName -Credential $domainCred -OUPath $OUPath -Force
} else {
    Add-Computer -DomainName $DomainName -Credential $domainCred -Force
}

Write-Host "Domain join complete. Rebooting..."
Restart-Computer -Force
