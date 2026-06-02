<#
.SYNOPSIS
    Back up a drive to a timestamped, compressed ZIP file with a SHA256 hash using the MultiDrive CLI.

.DESCRIPTION
    Wraps `mdcli backup`. The target is a .zip file, so MultiDrive compresses it on the
    fly. AA SHA256 hash is calculated to make sure the file hasn't been changed. 
    The file name includes the date and time so that no matter how many times you run the program, 
    it will never overwrite the previous run.

.PARAMETER Source
    Drive to back up — Short ID (d1, d2, …) or System ID. Run `mdcli list` to see IDs.

.PARAMETER Destination
    Folder where the backup ZIP is written. It will be created if it does not exist.

.PARAMETER Hash
    Hash calculation algorithm: MD5, SHA1, SHA256 (default), or SHA512. Pass 'None' to skip.

.PARAMETER MdCli
    Optional explicit path to mdcli.exe. Auto-detected if omitted.

.EXAMPLE
    .\backup-drive-to-zip.ps1 -Source d2 -Destination D:\Backups

.EXAMPLE
    .\backup-drive-to-zip.ps1 -Source d2 -Destination D:\Backups -Hash SHA512 
#>
[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)][string]$Source,
    [Parameter(Mandatory = $true)][string]$Destination,
    [ValidateSet('MD5', 'SHA1', 'SHA256', 'SHA512', 'None')][string]$Hash = 'SHA256',
    [string]$MdCli
)

function Resolve-MdCli {
    param([string]$Explicit)
    if ($Explicit) {
        if (-not (Test-Path $Explicit)) { throw "mdcli.exe not found at: $Explicit" }
        return $Explicit
    }
    if (Get-Command mdcli -ErrorAction SilentlyContinue) { return 'mdcli' }
    $candidates = @(
        "$env:LOCALAPPDATA\MultiDrive\mdcli.exe",
        "$env:ProgramFiles\MultiDrive\mdcli.exe",
        "${env:ProgramFiles(x86)}\MultiDrive\mdcli.exe"
    )
    foreach ($c in $candidates) { if (Test-Path $c) { return $c } }
    throw "mdcli.exe not found. Install MultiDrive (winget install multidrive) or pass -MdCli '<path>'."
}

$cli = Resolve-MdCli -Explicit $MdCli

if (-not (Test-Path $Destination)) {
    New-Item -ItemType Directory -Path $Destination -Force | Out-Null
}

$timestamp = Get-Date -Format 'yyyy-MM-dd_HH-mm-ss'
$target = Join-Path $Destination "$Source`_$timestamp.zip"

# Build the mdcli argument list
$mdArgs = @('backup', $Source, $target)
if ($Hash -ne 'None') { $mdArgs += "--hash=$Hash" }
$mdArgs += '-y' 

Write-Host "Backing up $Source -> $target" -ForegroundColor Cyan
Write-Host "Command: $cli $($mdArgs -join ' ')" -ForegroundColor DarkGray

& $cli @mdArgs
$exitCode = $LASTEXITCODE

if ($exitCode -eq 0) {
    Write-Host "Backup completed: $target" -ForegroundColor Green
} else {
    Write-Host "Backup failed with exit code 0x$($exitCode.ToString('X'))" -ForegroundColor Red
}
exit $exitCode
