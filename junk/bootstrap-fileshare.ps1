param(
    [string]$ShareName = "FileshareMain",
    [string]$SharePath = "F:\Shares\Main",
    [string]$DomainNetBIOS = "hamsammich",
    [string]$UsersGroup = "Users",
    [string]$AdminsGroup = "Admins"
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

if (-not (Test-Path -LiteralPath $SharePath)) {
    throw "Share path does not exist: $SharePath"
}

$usersSid = "$DomainNetBIOS\$UsersGroup"
$adminsSid = "$DomainNetBIOS\$AdminsGroup"

Write-Host "Configuring NTFS permissions on $SharePath..."
$acl = Get-Acl -LiteralPath $SharePath
$inheritFlags = [System.Security.AccessControl.InheritanceFlags]::ContainerInherit, [System.Security.AccessControl.InheritanceFlags]::ObjectInherit
$propFlags = [System.Security.AccessControl.PropagationFlags]::None

$ruleUsers = New-Object System.Security.AccessControl.FileSystemAccessRule(
    $usersSid,
    "Modify",
    $inheritFlags,
    $propFlags,
    "Allow"
)

$ruleAdmins = New-Object System.Security.AccessControl.FileSystemAccessRule(
    $adminsSid,
    "FullControl",
    $inheritFlags,
    $propFlags,
    "Allow"
)

$acl.SetAccessRule($ruleUsers)
$acl.SetAccessRule($ruleAdmins)
Set-Acl -LiteralPath $SharePath -AclObject $acl

Write-Host "Creating SMB share $ShareName..."
if (Get-SmbShare -Name $ShareName -ErrorAction SilentlyContinue) {
    Write-Host "Share already exists: $ShareName"
} else {
    New-SmbShare -Name $ShareName -Path $SharePath -FullAccess $adminsSid -ChangeAccess $usersSid | Out-Null
}

Write-Host "Share created: \\$env:COMPUTERNAME\$ShareName"
