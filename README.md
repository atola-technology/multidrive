# MultiDrive
MultiDrive is an app to clone, back up and restore, or completely or partially erase drives.

Key features:
- Simple and attractive UI app
- CLI app for workflow automation
- Handles bad sectors (drive read errors) and loose cable connections
- Ability to process multiple drives in parallel
- Pause/resume a task at any time
- Standard backup formats supported: RAW or ZIP (optimized Deflate algorithm)
- 100% free. No ads, upgrade popups

# CLI support

MultiDrive supports silent deployment across multiple machines using command-line parameters or installation through Windows Package Manager (winget).
MultiDriveSetup.exe /s /d=c:\MyFolder

Examples:
```
mdcli list                       # Shows connected drives

mdcli backup d2 d:\image.zip     # Backs up the 2nd shown drive

mdcli restore d:\image.zip d2    # Restores the compressed drive image to the 2nd drive

mdcli erase d3 --pattern FF      # Erases the 3rd drive with 0xFF pattern

mdcli clone d1 d3                # Clones the 1st (boot) drive to the 3rd drive
```
Instead of Short IDs (d1, d2, d3),  one can use classic Windows System IDs (SCSI\DISK&VEN_NVME&PROD_SAMSUNG_SSD_970\4&5BC748F&0&020000)
