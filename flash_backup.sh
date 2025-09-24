#!/bin/bash

while getopts ":u:d:m:f:s:" opt
   do
     case $opt in
        u ) HOME_NAME=$OPTARG;;
        d ) TOBACKUP=$OPTARG;;
        m ) MOUNT_DIR=$OPTARG;;
        f ) FLASH_DRIVE_NAME=$OPTARG;;
        s ) SYNC=$OPTARG;;

     esac
done

#HOME_NAME=/home/l351admin
#RSYNC=$HOME_NAME/projects/rsync/rsync
RSYNC=/usr/bin/rsync
#FLASH_DRIVE_NAME=backup_drive
#MOUNT_DIR='/media/l351admin'/$FLASH_DRIVE_NAME

BACKUP_DIR=backup

#TOBACKUP=($HOME_NAME/Downloads \
#$HOME_NAME/Documents \
#$HOME_NAME/projects)

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

if [ "$SYNC" = "n" ];
then
    if [ ! -d $MOUNT_DIR/$BACKUP_DIR ]
    then
      mkdir -p $MOUNT_DIR/$BACKUP_DIR
    fi

    for x in ${TOBACKUP[*]}
    do
      if [ ! -d $MOUNT_DIR/$BACKUP_DIR/${x} ]
      then
        mkdir -p $MOUNT_DIR/$BACKUP_DIR/${x}
      fi
      echo ${x}
      echo $MOUNT_DIR/$BACKUP_DIR/${x}
      $RSYNC --perms -vrltaog --delete --delete-excluded /${x}/ \
        $MOUNT_DIR/$BACKUP_DIR/${x}/ > $HOME_NAME/.backup.log 2>&1
      done

else
    if [ $SYNC == "y" ]
    then
      for x in ${TOBACKUP[*]}
      do
        if [ ! -d ${x} ]
        then
          mkdir -p ${x}
        fi
#        $RSYNC --perms -vrltaog --delete --delete-excluded $MOUNT_DIR/$BACKUP_DIR/${x} ${x}/ > $HOME_NAME/.backup.log 2>&1
        done
    fi
fi

exit 0
