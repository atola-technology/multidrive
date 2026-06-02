# Backup examples

Automate drive backups with MultiDrive's `mdcli backup` command. Back up an entire drive or a byte range 
to RAW, ZIP, or ZST files, with on-the-fly compression and hashing (MD5/SHA1/SHA256/SHA512).

## Command syntax

```
mdcli backup [source] [target] <OPTIONS>
```

- `[source]` — drive to back up (Short ID like `d1`, or System ID from `mdcli list`)
- `[target]` — output file or folder. A `.zip` target is compressed automatically.

| Option | Description |
|--------|-------------|
| `-y, --yes` | Skip all confirmation prompts (unattended mode) |
| `-z, --zip` | Compress the target to ZIP on the fly |
| `-a, --zstd` | Compress the target to ZST (ZStandard) on the fly |
| `-q, --hash <TYPE>` | Integrity hash: `MD5`, `SHA1`, `SHA256`, `SHA512` |
| `-p, --split <SIZE>` | Split the target into segments of `<SIZE>` (e.g. `2G`) |
| `-b, --byte_offset <N>` | Start offset on the source (e.g. `1M`) |
| `-c, --byte_count <N>` | Number of bytes to back up (e.g. `10G`) |
| `-s, --source` / `-t, --target` | Alternative way to pass source/target |
| `-u,  --share-user <SHARE_USER>` | Username for network share authentication |
| `-t,  --share-pass <SHARE_PASS>` | Password for network share authentication |

## Scripts

| Script | Scenario |
|--------|----------|
| [`DailyBackup.bat`](./DailyBackup.bat) | Logging batch script designed to run from **Windows Task Scheduler** for daily automated backups. |
| [`backup-drive-to-zip.ps1`](./backup-drive-to-zip.ps1) | Back up a drive to a timestamped, compressed ZIP with a SHA256 integrity hash. |

## Quick examples

```powershell
# Back up Drive #1 to a compressed ZIP
mdcli backup d1 E:\myfolder\backup.zip

# Back up Drive #2 with SHA256 integrity verification, unattended
mdcli backup d2 "E:\Backups\system.zip" --hash=SHA256 -y

# Back up 10 GB from Drive #1 starting at 1 MB, split into 2 GB ZIP segments
mdcli backup d1 E:\folder\backup.zip -b 1M -c 10G --zip --split 2G

# Back up a source Drive #2 to a network share folder with ZST (ZStandard) compression and network share authentication specified
mdcli backup -s d2 -t "\\nas\my dir\backup.zst" --share-user corp\operator --share-pass P@ssw0rd!
```

> See also: [Automated backups with Task Scheduler](https://multidrive.io/automated-backup)
