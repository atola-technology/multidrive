# MultiDrive CLI examples

Ready-to-run automation scripts for **MultiDrive** — a free disk management tool for
Windows 10 and 11 that can **back up, clone, restore, and erase** drives from
the command line via `mdcli.exe`.

These examples are for system administrators and power users. They want to automate drive operations with PowerShell 
and batch scripts. This can be for scheduled backups, fleet-wide secure erase, drive upgrades and unattended workflows.

> Full CLI reference and screenshots: <https://multidrive.io/backup-drive-command-prompt>

## Contents

| Folder | What it does |
|--------|--------------|
| [`backup/`](./backup) | Back up a whole drive or a partition to RAW/ZIP/ZST, with hashing enabled. |
| [`clone/`](./clone) | Clone one drive to another bit-by-bit — drive upgrades and bootable backups. |
| [`restore/`](./restore) | Restore a drive (or part of it) from a RAW/ZIP/ZST backup. |
| [`erase/`](./erase) | Erase a drive or an entire fleet in parallel. |

## Install MultiDrive

```powershell
# Windows Package Manager
winget install multidrive

# …or silent install to a custom folder
MultiDriveSetup.exe /s /d=C:\MyFolder
```

Download: <https://multidrive.io>

## Finding drive IDs

Every command targets a drive by its **Short ID** (`d1`, `d2`, `d3`, …) or **System ID**.
List all connected drives first:

```powershell
mdcli list
```

The Short ID in the first column is what `backup`, `clone`, `restore`, and `erase` use.

> **Run as Administrator.** Drive-level operations require an elevated PowerShell or
> Command Prompt (Win + X → *Terminal (Admin)*).

## Running these scripts

The PowerShell scripts auto-detect `mdcli.exe` (PATH, then the default
`%LOCALAPPDATA%\MultiDrive` and `Program Files` locations). Override with `-MdCli`:

```powershell
.\backup\backup-drive-to-zip.ps1 -Source d2 -Destination D:\Backups
.\backup\backup-drive-to-zip.ps1 -Source d2 -Destination D:\Backups -MdCli "C:\MyFolder\mdcli.exe"
```

If your execution policy blocks scripts, run them for the current session with:

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
```

## ⚠️ Safety

`clone`, `restore`, and `erase` **overwrite the target drive**. The `-y` / `--yes`
flag bypasses all confirmation prompts — use it only when you are certain of the
target IDs. MultiDrive protects the boot drive, but always double-check `mdcli list`
output before running unattended operations.
