# Changelog

## Version 1.5
**Released: August 31, 2026**

### New 
- Automatic shutdown of the computer after all task is completed
- Help link next to a failed task: opens an extended guide on solving read and write errors caused by cables, adapters, etc
- New "Archive Logs" in the "Leave feedback" dialog
- WinPE: new Reboot and Shutdown commands in the top right menu
- Backup / Restore: Much faster ZSTD backups to network shares, the speed no longer drops after the first seconds
- Clone / Restore: The message about a target smaller than the source now shows the exact Source and Target sizes
- Options in the "After successful task completion" section now run only when the task actually succeeds
- CLI: Correct handling of different file path styles, including network paths typed without leading backslashes

### Bug Fixes
- Write speed dropped several times during Erase, Clone, and Restore when the start offset was not zero
- Backup: Choosing a folder from the Recent folders list opened the previously used directory instead
- CLI: Some drives could be missing from the list on old PCs with a small number of CPU cores
- WinPE: The internal NVMe drive was not detected on some computers
- WinPE: Only the console opened instead of MultiDrive on some devices
- WinPE: The app window went beyond the screen boundaries
- WinPE: An outdated copy of MultiDrive was present in the image next to the current one

---

## Version 1.4
**Released: April 29, 2026**

### New
- Backup / Restore: New ZST (ZStandard) compression format, which is 4-5x faster than ZIP format
- New option "Show serial numbers of drives" in Preferences: Allows you to distinguish drives of the same model.
- Backup / Restore: Support for password-protected network folders
- Clone / Restore: Clearer UX when the source drive is larger than the target
- CLI: Improved UX when writing to the target during Clone, Erase, and Restore
- More explicit indication of task completion

### Bug Fixes
- Disk range selector in Options: Incorrect minimum value of the End handle when adjusting via the slider

---

## Version 1.3
**Released March 11, 2026**  

### New
- New WinPE image with MultiDrive pre-installed
- Erase: New option - Format drive after erasing
- Better recovery from write errors on target drives during Clone and Erase tasks
- Lightweight date representation: Oct 31 instead of 25-10-31
- Improved recognition and display of EFI and Recovery volumes
- Added a warning when backing up a BitLocker volume to ZIP format

### Bug Fixes
- CLI: Crash when redirecting mdcli output to a log file
- Backup: The last chunk of a split zip/raw file was created with an incorrect size

---

## Version 1.2
**Released October 9, 2025**  

### New
- Enhanced write error handling. Improved resilience during write errors on target drives during Clone and Erase tasks.  
- Optimized drive scanning. Reduced system resource usage during automatic drive detection, resulting in faster UI responsiveness.

### Bug Fixes
- Fixed the drive listing issue where it might stuck on “Getting Drive Info...” in certain hardware configurations.  
- Resolved the installation error “uninstall registry key not found”.  
- Fixed validation logic that incorrectly reported “free space cannot be greater than total space”.  
- Fixed around 10 other minor bugs.

---

## Version 1.1
**Released July 9, 2025**

### New
- Backup and clone drives with bad sectors.  
- Automatic retry for loose cable connections during operations.  
- Silent installation for unattended deployments.
- Detailed error reporting for drive-related failures.

---

## Version 1.0.2025
**Released April 14, 2025**

### New
- Initial release with Backup/Restore, Clone, and Erase tasks.  
- CLI support for automation.  
- Parallel task execution for multiple drives.  
- Pause/resume tasks.  
- Support for HDD, SSD, USB drives, and memory cards.  
- RAW and ZIP backup formats.  
- Data integrity checks with hash algorithms.  
- Options to process parts of drives.  
- Boot drive protection and manual protection of any drive from writing.  
- Beautiful responsive UI with Dark and Light themes.

---

[1.2]: https://github.com/atola-technology/multidrive/releases/v1.2.0
