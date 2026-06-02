# Clone examples

Clone one drive to another bit-by-bit with MultiDrive's `mdcli clone` command — drive upgrades, duplicate disks, and bootable replicas. Supports partial clones, integrity hashing, and auto-mounting the target after completion.

## Command syntax

```
mdcli clone [source] [target] <OPTIONS>
```

- `[source]` — drive to copy from (Short ID like `d1`, or System ID from `mdcli list`)
- `[target]` — drive to overwrite (same ID conventions)

| Option | Description |
|--------|-------------|
| `-y, --yes` | Skip all confirmation prompts (unattended mode) |
| `-b, --byte_offset <N>` | Start offset on both source and target (e.g. `500M`) |
| `-c, --byte_count <N>` | Number of bytes to clone (e.g. `1T`) |
| `-q, --hash <TYPE>` | Integrity hash: `MD5`, `SHA1`, `SHA256`, `SHA512` |
| `-m, --mount` | Mount target partitions in Windows after cloning |
| `-s, --source` / `-t, --target` | Alternative way to pass source/target |

## Scripts

Example automation scripts for this folder are planned. For now, use the CLI directly or adapt scripts from [`backup/`](../backup).

## Quick examples

```powershell
# Clone Drive #1 to Drive #3
mdcli clone d1 d3

# Clone 1 TB from Drive #3 starting at 500 MB, mount target when done
mdcli clone d3 d4 -b 500M -c 1T -m

# Partial clone with SHA256 verification, unattended
mdcli clone -s d1 -t d4 -b 500M -c 1T -q SHA256 -y
```

> See also: [How to clone a disk from cmd](https://multidrive.io/backup-drive-command-prompt) · [Win PE image](https://multidrive.io/winpe) (clone the active boot drive)

## ⚠️ Warning

`clone` **overwrites the target drive**. Use `-y` only when target IDs are verified with `mdcli list`.
