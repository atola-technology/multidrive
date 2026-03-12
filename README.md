# MultiDrive
MultiDrive is a **free Windows tool** for **disk cloning**, **wiping**, and **backups** from Atola Technology. 

It is made with the same high engineering quality as Atola's forensic imagers, so it can safely process multiple drives in parallel. 

## Download

Get the latest version from [Releases](https://github.com/atola-technology/multidrive/releases) or visit [multidrive.io](https://multidrive.io/download)

## Installation Options

- Direct download: `.exe` installer
- Winget: `winget install MultiDrive`

MultiDrive supports silent deployment across multiple machines using command-line parameters
`MultiDriveSetup.exe /s /d=c:\MyFolder`

## Windows PE bootable image

Use MultiDrive within a bootable WinPE image to clone your active Windows boot drive. 

Download the boot image and follow the guide: [Win PE image](https://multidrive.io/winpe)

## Features

- Simple and attractive UI
- CLI app for workflow automation
- Full-disk or partial cloning, erasing, backup, and restore
- Handles bad sectors (drive read errors) and loose cable connections
- Ability to process multiple drives simultaneously
- Pause/resume a task at any time
- Standard backup formats supported: RAW or ZIP (optimized Deflate algorithm)
- Hash calculation
- 100% free. No ads or upgrade popups

## CLI support

Examples:
```
mdcli list                       # Shows connected drives
mdcli backup d2 d:\image.zip     # Backs up the 2nd shown drive
mdcli restore d:\image.zip d2    # Restores the compressed drive image to the 2nd drive
mdcli erase d3 --pattern FF      # Erases the 3rd drive with 0xFF pattern
mdcli clone d1 d3                # Clones the 1st (boot) drive to the 3rd drive
```
Instead of Short IDs (d1, d2, d3),  one can use classic Windows System IDs `(SCSI\DISK&VEN_NVME&PROD_SAMSUNG_SSD_970\4&5BC748F&0&020000)`


## Product Comparison
| Feature | MultiDrive | Commercial Tools | Free Alternatives |
|--------|------------|--------------------|------------------|
| Free to use | ✅ Yes | ❌ No | ✅ Yes |
| Parallel tasks | ✅ | ⚠️ Limited | ❌   |
| CLI support | ✅ | ✅ | ⚠️ Extra cost | ❌   |
| Drive cloning | ✅ | ✅ | ⚠️ Often basic |
| Secure wiping | ✅ | ⚠️ Extra cost | ⚠️ Varies |
| Fast backup to standard ZIP format | ✅ | ❌  | ❌  |
| Modern Windows UI | ✅ | ⚠️ Varies | ❌ Outdated |

## Support the Project

If MultiDrive helps you, please star the repo and share it with your teammates or friends.

<p align="center"> ⭐⭐⭐ <b>Your star helps more people discover a free alternative to heavy commercial tools.</b> ⭐⭐⭐ </p>
