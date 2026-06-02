# Erase examples

Erases drives with MultiDrive's `mdcli erase` command — overwrite a disk with zeros or a custom HEX pattern. 
Works on HDDs, SSDs, USB flash drives, and SD cards. Partial erasing is supported.

## Command syntax

```
mdcli erase [target] <OPTIONS>
```

- `[target]` — drive to erase (Short ID like `d3`, or System ID from `mdcli list`)

| Option | Description |
|--------|-------------|
| `-y, --yes` | Skip all confirmation prompts (unattended mode) |
| `-p, --pattern <HEX>` | HEX byte pattern to fill with. Default `00` (zeros). E.g. `FF`, `9A7B` |
| `-b, --byte_offset <N>` | Start offset on the target (e.g. `1G`) |
| `-c, --byte_count <N>` | Number of bytes to erase (e.g. `30G`) |
| `-m, --mount` | Auto-mount the target's partitions in Windows after erasing |
| `-t, --target` | Alternative way to pass the target |
| `-f, --format` | Format the drive after erasing with the specified file system: exFAT or NTFS. Only works when erasing the entire disk (without --byte_offset or --byte_count options). |

## Scripts

| Script | Scenario |
|--------|----------|
| [`MultiErase.ps1`](./MultiErase.ps1) | Auto-detect every drive, **skip the boot disk (d1)**, and wipe the rest **in parallel**, monitoring all tasks. |

## Quick examples

```powershell
# Erase Drive #3 with zeros (default pattern)
mdcli erase d3

# Erase Drive #3 by filling it with the 'FF' byte pattern
mdcli erase -t d3 --pattern FF

# Erase 30 GB from Drive #3 starting at 1 GB with a custom pattern
mdcli erase d3 -p 9A7B -b 1G -c 30G
```

## MultiErase.ps1 — fleet wipe

Wipes all disks **except the boot drive (d1)**, each in its own window, in parallel:

```powershell
# Auto-detect and wipe every non-boot drive
.\MultiErase.ps1

# Or wipe a specific set of drives
.\MultiErase.ps1 d3,d4
```

> See the full walkthrough: <https://multidrive.io/how-to-automatically-wipe-drives>

## ⚠️ Warning

Once you've deleted something, you can't get it back. The '-y' flag lets you skip all the safety checks. 
Use it only in scripts where the target IDs are known. MultiDrive protects the boot drive, and MultiErase.ps1 also skips d1 by default. 
But always check mdcli list before running an unattended wipe.
