# Disk-Utility-V1.0
Here's a comprehensive batch script that provides a user-friendly interface for disk management tasks using diskpart, chkdsk, and attrib commands:

## Features:

1. **User-Friendly Menu Interface** - Easy navigation with numbered options
2. **Disk Management Functions**:
   - List all disks and volumes
   - Format partitions with various file systems
   - Run CHKDSK with repair options
   - Clear file attributes (RASH - Read-only, Archive, System, Hidden)
   - Basic file recovery operations
   - Create new partitions
   - Completely clean disks

3. **Safety Features**:
   - Confirmation prompts for destructive operations
   - Clear warnings about data loss
   - Step-by-step execution

4. **Flexible Options**:
   - Select drive letters or disk numbers
   - Choose file systems (NTFS, FAT32, exFAT)
   - Quick or full format options
   - Recursive attribute changes

## Usage Instructions:

1. Save the script as `DiskUtility.bat`
2. Run as Administrator (required for diskpart and chkdsk operations)
3. Follow the on-screen prompts
4. For serious data recovery, consider using specialized software as this script only performs basic recovery operations

Note: Always back up important data before performing disk operations.
