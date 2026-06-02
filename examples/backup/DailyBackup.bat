@echo off
REM ============================================================================
REM MultiDrive Automated Backup Script
REM
REM Designed to be run from Windows Task Scheduler for daily backups. 
REM It backs up a drive to a timestamped, SHA256-verified ZIP and writes a log.
REM
REM Setup:
REM   1. Edit the variables below (MDCLI path, SOURCE drive, BACKUP_DIR).
REM   2. Save as DailyBackup.bat (ensure the extension is .bat, not .bat.txt).
REM   3. Test: right-click -> "Run as administrator".
REM   4. Schedule it: Task Scheduler -> Create Task (run with highest privileges).
REM      Guide: https://multidrive.io/automated-backup
REM ============================================================================

REM --- Settings ---------------------------------------------------------------
set MDCLI="%LOCALAPPDATA%\MultiDrive\mdcli.exe"
set SOURCE=d2
set BACKUP_DIR=C:\Backups
REM ----------------------------------------------------------------------------

set BACKUP_NAME=Backup_%date:~-4,4%-%date:~-7,2%-%date:~-10,2%_%time:~0,2%-%time:~3,2%.zip
set BACKUP_NAME=%BACKUP_NAME: =0%
set LOG_FILE=%BACKUP_DIR%\backup_log.txt

REM Create backup directory if it doesn't exist
if not exist "%BACKUP_DIR%" mkdir "%BACKUP_DIR%"

echo ================================================ >> "%LOG_FILE%"
echo Backup started: %date% %time% >> "%LOG_FILE%"
echo Source: %SOURCE% >> "%LOG_FILE%"
echo Destination: %BACKUP_DIR%\%BACKUP_NAME% >> "%LOG_FILE%"

REM Execute backup with SHA256 hash calculation
%MDCLI% backup "%SOURCE%" "%BACKUP_DIR%\%BACKUP_NAME%" -y --hash=SHA256 >> "%LOG_FILE%" 2>&1

if %ERRORLEVEL% EQU 0 (
    echo Status: SUCCESS >> "%LOG_FILE%"
) else (
    echo Status: FAILED with error code %ERRORLEVEL% >> "%LOG_FILE%"
)

echo Backup finished: %date% %time% >> "%LOG_FILE%"
echo ================================================ >> "%LOG_FILE%"
exit /b %ERRORLEVEL%
