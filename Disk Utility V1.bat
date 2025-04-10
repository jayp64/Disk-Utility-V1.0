@echo off
title Disk Utility Tool
color 0A
mode con: cols=80 lines=30

:MAIN_MENU
cls
echo.
echo  ==============================
echo      DISK UTILITY TOOL v1.0
echo  ==============================
echo.
echo  1. List All Disks and Volumes
echo  2. Format a Disk/Partition
echo  3. Check and Repair Disk (CHKDSK)
echo  4. Clear File Attributes (ATTRIB)
echo  5. Recover Lost Files/Folders
echo  6. Create New Partition
echo  7. Clean a Disk (Erase All)
echo  8. Exit
echo.
set /p choice=Select an option [1-8]: 

if "%choice%"=="1" goto LIST_DISKS
if "%choice%"=="2" goto FORMAT
if "%choice%"=="3" goto CHKDSK
if "%choice%"=="4" goto ATTRIB
if "%choice%"=="5" goto RECOVER
if "%choice%"=="6" goto CREATE_PARTITION
if "%choice%"=="7" goto CLEAN_DISK
if "%choice%"=="8" exit

echo Invalid choice, please try again.
pause
goto MAIN_MENU

:LIST_DISKS
cls
echo.
echo Listing all disks and volumes...
echo.
echo === Disk Information ===
echo.
diskpart /s list_disks.txt >nul
if not exist list_disks.txt (
    echo list disk > list_disks.txt
    echo list volume >> list_disks.txt
    echo exit >> list_disks.txt
)
diskpart /s list_disks.txt
del list_disks.txt
echo.
pause
goto MAIN_MENU

:FORMAT
cls
echo.
echo === Format a Disk/Partition ===
echo.
set /p drive=Enter the drive letter to format (e.g., D:): 
set /p label=Enter the volume label (leave blank for none): 
set /p fs=Select file system [NTFS/FAT32/exFAT]: 
set /p quick=Quick format? [Y/N]: 

echo. > format_script.txt
echo select volume %drive:~0,1% >> format_script.txt
echo format fs=%fs% quick=%quick% label="%label%" >> format_script.txt
echo exit >> format_script.txt

echo.
echo WARNING: This will erase all data on %drive%
set /p confirm=Are you sure you want to continue? [Y/N]: 
if /i "%confirm%"=="Y" (
    echo Formatting %drive%...
    diskpart /s format_script.txt
    del format_script.txt
    echo Format complete!
) else (
    echo Operation cancelled.
    del format_script.txt
)
pause
goto MAIN_MENU

:CHKDSK
cls
echo.
echo === Check and Repair Disk ===
echo.
set /p drive=Enter the drive letter to check (e.g., C:): 
set /p fix=Attempt to fix errors? [Y/N]: 
set /p bad=Scan for bad sectors? [Y/N]: 

if /i "%fix%"=="Y" set fix=/f
if /i "%bad%"=="Y" set bad=/r

echo.
echo Running CHKDSK on %drive%...
chkdsk %drive% %fix% %bad%
echo.
echo CHKDSK operation completed.
pause
goto MAIN_MENU

:ATTRIB
cls
echo.
echo === Clear File Attributes ===
echo.
set /p drive=Enter the drive letter or folder path (e.g., C: or C:\Folder): 
set /p attrib=Enter attributes to remove [RASH]: 
set /p recursive=Apply to subfolders/files? [Y/N]: 

if /i "%recursive%"=="Y" set recursive=/S /D

echo.
echo Clearing attributes...
attrib -%attrib% %recursive% %drive%
echo.
echo Attributes cleared successfully.
pause
goto MAIN_MENU

:RECOVER
cls
echo.
echo === Recover Lost Files/Folders ===
echo.
echo WARNING: This attempts to recover files by clearing system attributes
echo and running CHKDSK. For serious recovery, use specialized software.
echo.
set /p drive=Enter the drive letter to scan (e.g., D:): 

echo.
echo Step 1: Clearing system attributes...
attrib -s -h %drive%\*.* /S /D
echo.
echo Step 2: Running CHKDSK to fix errors...
chkdsk %drive% /f
echo.
echo Recovery process completed. Check your drive for recovered files.
pause
goto MAIN_MENU

:CREATE_PARTITION
cls
echo.
echo === Create New Partition ===
echo.
set /p disk=Enter disk number to partition (see list disks): 
set /p size=Enter partition size in MB (leave blank for max available): 
set /p label=Enter partition label: 
set /p fs=Select file system [NTFS/FAT32/exFAT]: 

echo. > partition_script.txt
echo select disk %disk% >> partition_script.txt
echo clean >> partition_script.txt
echo create partition primary size=%size% >> partition_script.txt
echo format fs=%fs% label="%label%" quick >> partition_script.txt
echo assign >> partition_script.txt
echo exit >> partition_script.txt

echo.
echo WARNING: This will erase all data on disk %disk%
set /p confirm=Are you sure you want to continue? [Y/N]: 
if /i "%confirm%"=="Y" (
    echo Creating partition...
    diskpart /s partition_script.txt
    del partition_script.txt
    echo Partition created successfully!
) else (
    echo Operation cancelled.
    del partition_script.txt
)
pause
goto MAIN_MENU

:CLEAN_DISK
cls
echo.
echo === Clean a Disk (Erase All) ===
echo.
set /p disk=Enter disk number to clean (see list disks): 

echo. > clean_script.txt
echo select disk %disk% >> clean_script.txt
echo clean >> clean_script.txt
echo exit >> clean_script.txt

echo.
echo WARNING: This will COMPLETELY ERASE disk %disk%
set /p confirm=Are you absolutely sure? [Y/N]: 
if /i "%confirm%"=="Y" (
    echo Cleaning disk %disk%...
    diskpart /s clean_script.txt
    del clean_script.txt
    echo Disk cleaned successfully!
) else (
    echo Operation cancelled.
    del clean_script.txt
)
pause
goto MAIN_MENU