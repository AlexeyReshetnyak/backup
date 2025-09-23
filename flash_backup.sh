#!/bin/bash

HOME_NAME=/home/al
RSYNC=$HOME_NAME/projects/rsync/rsync
#RSYNC=/usr/bin/rsync
FLASH_DRIVE_NAME=card32g
MOUNT_DIR='/media/al'/$FLASH_DRIVE_NAME
BACKUP_DIR=/backup

TOBACKUP=(/usr/lib/systemd/system \
$HOME_NAME/Downloads \
$HOME_NAME/Documents \
$HOME_NAME/projects \
$HOME_NAME/.vim \
$HOME_NAME/.gnupg \
$HOME_NAME/.config \
$HOME_NAME/.mozilla/firefox \
$HOME_NAME/.thunderbird)
#$HOME_NAME/.local/share/themes)

#result=$(udisksctl mount -b /dev/disk/by-label/$FLASH_DRIVE_NAME 2>&1);
#if echo "$result" | grep -q "Error looking up"; then
#  echo $result > ~/.dirs_backup.log
#  echo $result > ~/.files_backup.log
#  exit
#fi
#

mountpoint=$(lsblk -o MOUNTPOINT | grep $FLASH_DRIVE_NAME)
if [[ -n $mountpoint ]]
then
  :
else
  echo "Error. Drive not mounted" > $HOME_NAME/.backup.log
  exit 0
fi

if [[ ! -n $1 ]];
then
    echo "No parameter passed."
    if [ ! -d $MOUNT_DIR$BACKUP_DIR ]
    then
      mkdir -p $MOUNT_DIR$BACKUP_DIR
    fi

    for x in ${TOBACKUP[*]}
    do
      if [ ! -d $MOUNT_DIR$BACKUP_DIR/${x} ]
      then
        mkdir -p $MOUNT_DIR$BACKUP_DIR/${x}
      fi
      echo ${x}
      echo $MOUNT_DIR$BACKUP_DIR/${x}
      $RSYNC --perms -vrltaog --delete --delete-excluded /${x}/ \
        $MOUNT_DIR$BACKUP_DIR/${x} > $HOME_NAME/.backup.log 2>&1
      done

else
    echo "Parameter passed = $1"
    if [ $1 == "sync" ]
    then
      echo 'Sync is perforning.'
      for x in ${TOBACKUP[*]}
      do
        if [ ! -d ${x} ]
        then
          mkdir -p ${x}
        fi
#        $RSYNC --perms -vrltaog --delete --delete-excluded $MOUNT_DIR$BACKUP_DIR/${x} ${x}/ > $HOME_NAME/.backup.log 2>&1
        done
    fi
fi

exit 0
