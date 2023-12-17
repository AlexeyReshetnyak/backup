#!/bin/bash

FLASH_DRIVE_NAME=flash32g
result=$(udisksctl mount -b /dev/disk/by-label/$FLASH_DRIVE_NAME 2>&1);

if echo "$result" | grep -qi error; then
  echo $result > ~/.dirs_backup.log
  echo $result > ~/.files_backup.log
  notify-send -u critical "Unable to mount backup disk."
  exit
fi
