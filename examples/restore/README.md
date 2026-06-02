# Restore examples

Restore a drive from a backup image with MultiDrive's `mdcli restore` command. Supports RAW, ZIP, and ZST backups created by `mdcli backup` (or the MultiDrive UI), including partial restores to a byte offset on the target drive.

## Command syntax

```
mdcli restore [source] [target] <OPTIONS>
```

- `[source]` — backup file (`.raw`, `.zip`, `.zst`, or split segments)
- `[target]` — drive to restore to (Short ID like `d2`, or System ID from `mdcli list`)

| Option | Description |
|--------|-------------|
| `-y, --yes` | Skip all confirmation prompts (unattended mode) |
| `-b, --byte_offset <N>` | Start offset on the target drive (e.g. `1M`) |
| `-c, --byte_count <N>` | Number of bytes to restore (e.g. `10G`) |
| `-m, --mount` | Mount target partitions in Windows after restore |
| `-s, --source` / `-t, --target` | Alternative way to pass source/target |
| `-u, --share-user` / `-w -share-pass` | Credentials for a network share source |

## Scripts

Example automation scripts for this folder are planned. Create backups with [`backup/`](../backup), then restore from the CLI below.

## Quick examples

```powershell
# Restore a ZIP backup to Drive #2
mdcli restore D:\Backups\system.zip d2

# Restore with explicit source/target arguments
mdcli restore -s "\\nas\images\disk.zst" -t d3 --share-user corp\operator --share-pass P@ssw0rd!

# Partial restore: 10 GB to Drive #2 starting at 1 MB, unattended
mdcli restore D:\Backups\partial.zip d2 -b 1M -c 10G -y
```

> Full CLI reference: <https://multidrive.io/backup-drive-command-prompt>

## ⚠️ Warning

`restore` **overwrites the target drive**. Use `-y` only when target IDs are verified with `mdcli list`.
