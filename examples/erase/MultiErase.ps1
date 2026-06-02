param(
    [string[]]$DriveIds = @()
)

function Get-DriveInfo {
    $tempFile = [System.IO.Path]::GetTempFileName()
    Start-Process -FilePath "mdcli" -ArgumentList "list" -NoNewWindow -Wait -RedirectStandardOutput $tempFile
    $output = Get-Content $tempFile -Encoding UTF8
    Remove-Item $tempFile -ErrorAction SilentlyContinue

    $drives = @{}

    foreach ($line in $output) {
        if ($line -match '^\s+(d\d+)\s') {
            $id = $Matches[1]
            # Get full drive name
            $parts = $line.Trim() -split '\s{2,}'
            $name = if ($parts.Count -ge 2) { $parts[1] } else { "Unknown" }
            $drives[$id] = @{
                Name = $name
                Line = $line
            }
        }
    }

    return $drives
}

Write-Host "Retrieving drive list..."
$driveInfo = Get-DriveInfo

if ($driveInfo.Count -eq 0) {
    Write-Host "No drives found from 'mdcli list'."
    exit 1
}
if ($DriveIds.Count -eq 0) {
    $DriveIds = $driveInfo.Keys | Where-Object { $_ -ne "d1" } | Sort-Object
}

$DriveIds = $DriveIds | Where-Object { $_ -ne "d1" }
if ($DriveIds.Count -eq 0) {
    Write-Host "No drives to erase." -ForegroundColor Yellow
    exit 0
}

Write-Host "`nDrives to erase:" -ForegroundColor Cyan
foreach ($driveId in $DriveIds) {
    if ($driveInfo[$driveId]) {
        Write-Host $driveInfo[$driveId].Line
        if ($systemId) {
            Write-Host "       $systemId" -ForegroundColor Gray
        }
    } else {
        Write-Host "  $driveId : Unknown"
    }
}
Write-Host ""

Write-Host "WARNING: All data on the drives will be permanently erased" -ForegroundColor Yellow
$confirmation = Read-Host "Continue? (y/n)"
if ($confirmation -ne 'y' -and $confirmation -ne 'Y') {
    Write-Host "Operation cancelled."
    exit 0
}
Write-Host ""

$processes = @{}
foreach ($driveId in $DriveIds) {
    $name = if ($driveInfo[$driveId]) { $driveInfo[$driveId].Name } else { "Unknown" }
    $proc = Start-Process -FilePath "cmd" `
    -ArgumentList "/c", "title Erase $driveId - $name && mdcli erase $driveId -y && pause" `
        -PassThru
    $processes[$driveId] = $proc
}

Write-Host "Started $($DriveIds.Count) erase tasks." -ForegroundColor Cyan
Write-Host "Each drive is processed in a separate window.`n" -ForegroundColor Gray

while ($processes.Values | Where-Object { -not $_.HasExited }) {
    $runningIds = @($processes.GetEnumerator() | Where-Object { -not $_.Value.HasExited } | ForEach-Object { $_.Key })
    $completedIds = @($processes.GetEnumerator() | Where-Object { $_.Value.HasExited } | ForEach-Object { $_.Key })
    $runningStr = ($runningIds | ForEach-Object {
        $name = if ($driveInfo[$_]) { $driveInfo[$_].Name } else { "Unknown" }
        "$_ ($name)"
    }) -join ', '

    $completedStr = ($completedIds | ForEach-Object {
        $name = if ($driveInfo[$_]) { $driveInfo[$_].Name } else { "Unknown" }
        "$_ ($name)"
    }) -join ', '

    Write-Host "`r[$(Get-Date -Format 'HH:mm:ss')] " -NoNewline
    Write-Host "Running: " -NoNewline -ForegroundColor Yellow
    Write-Host "$runningStr " -NoNewline
    Write-Host "| Done: " -NoNewline -ForegroundColor Green
    Write-Host "$completedStr   " -NoNewline

    Start-Sleep -Seconds 1
}

Write-Host "`n`n=== Results ===" -ForegroundColor Cyan
foreach ($driveId in $DriveIds) {
    $name = if ($driveInfo[$driveId]) { $driveInfo[$driveId].Name } else { "Unknown" }
    $exitCode = $processes[$driveId].ExitCode
    if ($exitCode -eq 0) {
        Write-Host "  $driveId ($name) : Completed" -ForegroundColor Green
    } else {
        if ($exitCode -eq 1) {
            Write-Host "  $driveId ($name) : Paused" -ForegroundColor Yellow
        }
        else {
            Write-Host "  $driveId ($name) : Failed with code 0x$($exitCode.ToString('X'))" -ForegroundColor Red
        }
    }
}
