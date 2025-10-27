# Changelog

## Version 1.2
**Released October 9, 2025**  

### Improvements
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

### New Features
- Backup and clone drives with bad sectors.  
- Automatic retry for loose cable connections during operations.  
- Silent installation for unattended deployments.

### Improvements
- Detailed error reporting for drive-related failures.

---

## Version 1.0.2025
**Released April 14, 2025**

### New Features
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
