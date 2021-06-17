#!/bin/bash
# Print free system memory
free -h > ~/backups/freemem/free_mem.txt
# Print disk usage  
du -h > ~/backups/diskuse/disk_usage.txt
# List open files 
lsof > ~/backups/openlist/open_list.txt
# Print file system disk space statistics 
df -h > ~/backups/freedisk/free_disk.txt
